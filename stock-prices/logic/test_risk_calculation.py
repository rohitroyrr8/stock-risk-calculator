"""
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

"""

from unittest import TestCase
import logic.risk_calculation as r
import logic.csvutils as data


class TestRiskCalculation(TestCase):

    def test_get_regressions(self):
        prices = data.read_all_files("../historical-prices", 0, 4)
        risk_calculation = r.RiskCalculation(prices, 'SP500')

        self.assertEquals(22 - 1, len(risk_calculation.risk_params))

    def test_get_weights(self):
        prices = data.read_all_files("../historical-prices", 0, 4)
        risk_calculation = r.RiskCalculation(prices, 'SP500')

        self.assertAlmostEqual(1, sum([val.weight for key, val in risk_calculation.risk_params.items()]))
