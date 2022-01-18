Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086D5492940
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiARPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29326 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345108AbiARPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:09 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150107epoutp013ae3e8c7f43b927dc779f1477d7ae576~LZXr5pZv40046900469epoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150107epoutp013ae3e8c7f43b927dc779f1477d7ae576~LZXr5pZv40046900469epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518067;
        bh=Cu8662uuY8Wn+WQzVyGiTN6tWfoygcTDTXTd88WrFCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OakbkFuND8a9iygTSNprpEBYy/v0CA8I1u3Ti8MvGYTUh2VCiHXjjzJZHGorQTvTL
         aEIpmCw4WFoaSg0L1+UltWNn1TpOU7gYOFwSnrdriFafE3DIzrknlrSCWfRtgRjq0P
         +5RZBIAEMrNhpvTYs8ouZ1lfWPnHdsS+9TqExwF4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150106epcas5p3e85f9c6fd21d8fe8c2072befe99880ad~LZXqu9MM42328723287epcas5p3A;
        Tue, 18 Jan 2022 15:01:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JdX5n0D5dz4x9Pv; Tue, 18 Jan
        2022 15:01:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.29.06423.C26D6E16; Wed, 19 Jan 2022 00:01:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220118150100epcas5p3b7cf28e13fd177336dc9b06875d94f43~LZXkjvO3t2328723287epcas5p33;
        Tue, 18 Jan 2022 15:01:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150100epsmtrp274184892bd8222232246140cd324a131~LZXki1DVe2220222202epsmtrp2I;
        Tue, 18 Jan 2022 15:01:00 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-57-61e6d62cc8b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.F0.08738.B26D6E16; Wed, 19 Jan 2022 00:00:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150057epsmtip1e7f8926b55bb8c4b32e6cfc3ad2cec86~LZXiPTlCK1211512115epsmtip1u;
        Tue, 18 Jan 2022 15:00:57 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v2 12/16] pinctrl: samsung: add FSD SoC specific data
Date:   Tue, 18 Jan 2022 20:18:47 +0530
Message-Id: <20220118144851.69537-13-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlq7OtWeJBusmW1oceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMFy272Qu+alQ8v3aFuYFxr3IXIyeHhICJxPvL
        v5i6GLk4hAR2M0pM+LWOGcL5xCjR+Ho9VOYzo0TvxZlADgdYy/IziSDdQgK7GCWabwpD1LQw
        SXx6uI8VJMEmoC1xd/oWJhBbRMBN4kZjB9ggZoFpzBJv3hxiBEkIC7hKPLy+A6yIRUBVoufb
        IhYQm1fAVuL3mTXsEPfJS6zecIAZxOYEik9tmMoGMkhCYAeHxNrGCawQRS4Sz598YoSwhSVe
        Hd8C1Swl8fndXjaIq7MlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv7ydQ
        //JKdLQJQVSrSjS/uwrVKS0xsbsb6gAPiXP337NBwmECo8SVqbNYJzDKzkKYuoCRcRWjZGpB
        cW56arFpgWFeajk8npLzczcxglOplucOxrsPPugdYmTiYDzEKMHBrCTCK1X/LFGINyWxsiq1
        KD++qDQntfgQoykwyCYyS4km5wOTeV5JvKGJpYGJmZmZiaWxmaGSOO/p9A2JQgLpiSWp2amp
        BalFMH1MHJxSDUyzlgrlGT7k/hdfsGLNL9O9aWc2ZNR8928QttuZYc+XtdQwNPX0l5iot9d5
        D5T5W/77xXCkI3U3fx/j24tLpFb8UotgXl7/s66t+ObkSQ3bLtb0bfE9MNdL6mTmn3lhr9Ln
        v1t42bK7LvVbyINwTnXzNcrhvh3LFus1vfx1g/Whuiav394zdzr+lyzv05f7V/WLLylIn0ew
        vPBJ3LTpvRNu/RXkm7Y4+dfkiyEbrj289FA+OThiO8exFYdPcV0Jq1q+39wl/aiXdOTPzRdi
        n/KpRU15/jrH9l618NfCRutQf9UNt94VfL6u0f309kmNp6erGxLibJdas3rsyDLmPHSjxuHs
        H7mljrm7l9twHK1UYinOSDTUYi4qTgQA4dzipy4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK72tWeJBssPWFsceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8aLlt3sBV81Kp5fu8Lc
        wLhXuYuRg0NCwERi+ZnELkYuDiGBHYwSvfOOMHYxcgLFpSWub5zADmELS6z895wdoqiJSeLY
        1jusIAk2AW2Ju9O3MIHYIgIeEm3/7jGDFDELLGOWOLXoMxtIQljAVeLh9R1gRSwCqhI93xax
        gNi8ArYSv8+sgdogL7F6wwFmEJsTKD61YSpYr5CAjcTFldOYJzDyLWBkWMUomVpQnJueW2xY
        YJSXWq5XnJhbXJqXrpecn7uJERwJWlo7GPes+qB3iJGJg/EQowQHs5IIr1T9s0Qh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamKZeY5iftndtyfxTxetV
        L2+R730nKVr2aEpyZZ6eoKLa5Cir/NOfanw6dgdPSb1yTWgVY63c5L0HPRp19B7NfLLvxt7k
        jxw18rNjVtbXuGkGH2UuddFamG7q/PTVed7lbPX3+T/qPD7TKKofrHLk5GFdt4P3GzY4xFdN
        LV9p331YMG3NMaFolZSM6CMmF5RK0nhLdy18k/3JdH7P7QdXOk8K/md/URHe/k567i2ecLlH
        B57nXf6/0/MxJ4vHAfur3G/fCUpc+H6E+2O6COuF6IP/67JrOrNexO0p9tkmblIsMnMa97bz
        uyqLotibdNW4F6XLb5huUMXxa6NVpkJ1/uknPaay2TvVYgumbok7oMRSnJFoqMVcVJwIANLK
        e8/zAgAA
X-CMS-MailID: 20220118150100epcas5p3b7cf28e13fd177336dc9b06875d94f43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150100epcas5p3b7cf28e13fd177336dc9b06875d94f43
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150100epcas5p3b7cf28e13fd177336dc9b06875d94f43@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Tesla FSD SoC specific data to enable pinctrl.
FSD SoC has similar pinctrl controller as found in the most
samsung/exynos SoCs.

Cc: linux-fsd@tesla.com
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 71 +++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 2e490e7696f4..6fd06a6ee131 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -727,3 +727,74 @@ const struct samsung_pinctrl_of_match_data exynosautov9_of_data __initconst = {
 	.ctrl		= exynosautov9_pin_ctrl,
 	.num_ctrl	= ARRAY_SIZE(exynosautov9_pin_ctrl),
 };
+
+/*
+ * Pinctrl driver data for Tesla FSD SoC. FSD SoC includes three
+ * gpio/pin-mux/pinconfig controllers.
+ */
+
+/* pin banks of FSD pin-controller 0 (FSYS) */
+static const struct samsung_pin_bank_data fsd_pin_banks0[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(7, 0x00, "gpf0", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x20, "gpf1", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(3, 0x40, "gpf6", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(2, 0x60, "gpf4", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(6, 0x80, "gpf5", 0x10),
+};
+
+/* pin banks of FSD pin-controller 1 (PERIC) */
+static const struct samsung_pin_bank_data fsd_pin_banks1[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(4, 0x000, "gpc8", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x020, "gpf2", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x040, "gpf3", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x060, "gpd0", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x080, "gpb0", 0x10),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0a0, "gpb1", 0x14),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0c0, "gpb4", 0x18),
+	EXYNOS850_PIN_BANK_EINTG(4, 0x0e0, "gpb5", 0x1c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x100, "gpb6", 0x20),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x120, "gpb7", 0x24),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x140, "gpd1", 0x28),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x180, "gpd3", 0x30),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1a0, "gpg0", 0x34),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1c0, "gpg1", 0x38),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1e0, "gpg2", 0x3c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x220, "gpg4", 0x44),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x240, "gpg5", 0x48),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x260, "gpg6", 0x4c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x280, "gpg7", 0x50),
+};
+
+/* pin banks of FSD pin-controller 2 (PMU) */
+static const struct samsung_pin_bank_data fsd_pin_banks2[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTN(3, 0x00, "gpq0"),
+};
+
+const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 FSYS0 data */
+		.pin_banks	= fsd_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 PERIC data */
+		.pin_banks	= fsd_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 PMU data */
+		.pin_banks	= fsd_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks2),
+	},
+};
+
+const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
+	.ctrl		= fsd_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 0f6e9305fec5..c542c8ed8fe7 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1271,6 +1271,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynos850_of_data },
 	{ .compatible = "samsung,exynosautov9-pinctrl",
 		.data = &exynosautov9_of_data },
+	{ .compatible = "tesla,fsd-pinctrl",
+		.data = &fsd_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 1f8d30ba05af..5b32d3f30fcd 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -342,6 +342,7 @@ extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos7885_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos850_of_data;
 extern const struct samsung_pinctrl_of_match_data exynosautov9_of_data;
+extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
-- 
2.25.1

