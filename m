Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B32476A84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhLPGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:41:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55954 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbhLPGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:41:18 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211216064116epoutp013361c0928f435d8978c2e278e0028de6~BKQ1LF41w2859028590epoutp01b
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:41:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211216064116epoutp013361c0928f435d8978c2e278e0028de6~BKQ1LF41w2859028590epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639636876;
        bh=a4XZeIL7XpDOjQub5fg786w4iBykZg4P3o0YiBx9KT8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CY27L7R1kYoHIYXo+vVMvfzHavwwmzNGvoMJkWwPBUNbVe//Y0mLIB74j+ApPeohc
         MKXaQv03He4wzffAN3TkLi4jAxWp8JM7SClBhzWaowz/CsMWS+Dd0HEhvRkSe11sE6
         7H0B9DVMOPx2V28Ba8wkqhv73OUtnP/QVgC7ughQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211216064115epcas1p4c36144a0233617c848adf997cd3f99ff~BKQ0kK5Zu1715117151epcas1p4E;
        Thu, 16 Dec 2021 06:41:15 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JF2ZG46fkz4x9QF; Thu, 16 Dec
        2021 06:41:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.B4.21932.33FDAB16; Thu, 16 Dec 2021 15:39:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216064103epcas1p3bf39ff9adc5810403eab886ef579b3c7~BKQpmCJMf2655626556epcas1p3-;
        Thu, 16 Dec 2021 06:41:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216064103epsmtrp14ac266aaa141ba4d80aefd6db104820d~BKQpkmVhf2023420234epsmtrp1k;
        Thu, 16 Dec 2021 06:41:03 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-1e-61badf3367c4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.BE.08738.F7FDAB16; Thu, 16 Dec 2021 15:41:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216064103epsmtip2f349661508f0fc437e2c8953bb06c995~BKQpT5mHW3173231732epsmtip2J;
        Thu, 16 Dec 2021 06:41:03 +0000 (GMT)
Subject: Re: [PATCH 2/7] clk: samsung: exynos850: Add missing sysreg clocks
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <31bbb0a6-0b46-b195-2376-a92a04666f0a@samsung.com>
Date:   Thu, 16 Dec 2021 16:04:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211215160906.17451-3-semen.protsenko@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGPb3t7S2KuyswjojC7rLBQD5aCpxNwBnZuDLIIC5KmAlc6Q0g
        0NZ+mGlcaLZBx0IHCJvSMFkEIeuMlcIQOhAHGGRhWxYUJwgqdBTY+NpswtyXbS9T/nve9/ze
        8+Q5HwQm/gsPIAoVWlatYIop3IvfObAzKkL2h42JvnIEjfaFo+5vTwtR4+A1AerSDwpQ2+Ia
        D9U9bOUh68yYAK1WTgnQqK0BR59f/56HblzZi8p6B4Vo4I5BgB6PtfGR45Srb7Y9BGhoeQag
        ph/uCveI6bV2K0Yv3ywT0ia9Eae7TZNC2mquwOnfx3pwur25lD7VYQb0PevLGaLsooQClpGz
        6mBWkaeUFyryE6n9b+W8kRMbFy2JkOxC8VSwgilhE6nktIyIfYXFrjRU8IdMsc7VymA0Gioq
        KUGt1GnZ4AKlRptIsSp5sSpWFalhSjQ6RX6kgtXulkRHS2NdYG5RQeWdZaCalR4uu1bF14Nv
        wk8CEQFJGVxpNQpOAi9CTHYB+GD4a+BeEJN3Aez88n1O3wNwdRw9HajWn+BxAzYAVy6PrxfL
        APZ2nhG6KR9yP6xqrPZs6+umevs/xdwFRhr5sPbiksBN4WQY7Ju7ibv1JnIr/GVtxuPtTSZB
        y60hvlvzye3w8vKsh/cj34bDncfXmc1wuN7uYUTkHljW3OJxxkh/OG5v5HE6CH632OAxhqRB
        BB1TTUIuRDK8f/oCzmkfuDDUsd4PgPNV5UJuoAXAf2oreFxhAXDeVIFxVAzs+6rWtUC4LHZC
        iy2Ka2+F3Q/OAs75ebjkrBS4EUh6wxPlYg7ZBkf/nORx+gXYZKjAqwFl2pDHtCGDaUMG0/9m
        5wDfDLawKk1JPquRqGT/3XeessQKPG89DHWBs4srkf2AR4B+AAmM8vW2Z9kYsbec+ehjVq3M
        UeuKWU0/iHWdcA0W4JendH0WhTZHItsVLYuTxsiQJE5C+Xs7DnzGiMl8RssWsayKVT+d4xGi
        AD0vveO9hXdrn0k5FlqTPv1zyxaxXJp2IOsQIZjbl29uNl6yHlU1Hy0Jv5Bp9ncurI5MxBiW
        dJc67/fEX523pB8OvD1yQxpzvdT8KqSu2mfaBw09vw6ceymzZ/r47R1H8Gx7r1dQlWg3NG2r
        ORQ4PRVHbbL7ka1BxKPzq9kHgx/VFtG5U5l/T24OyUkJ+Q1Lm1CMpbbOEdasujr16wnnLzo/
        qY8w0oFv0v6vJEuZhoMt1raQ8ndSV571+8my3WnpSfXdsegTlBiS6rD0AfGLmY9BbnWK1UDH
        1zd80CzoALSTyHjy45mJkaS9r5nXvlDOqrXP6Y6ZfZUyLLS0/cmtUMcqxdcUMJIwTK1h/gWQ
        DayxdAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvG79/V2JBrPazSwu79e22LlhKrvF
        /CPnWC12NBxhtdj49geTxZQ/y5ksNj2+xmrxseceq8XlXXPYLGac38dkcfGUq0Xr3iPsFoff
        tLNa/Lu2kcXieR9QfNWuP4wWx98/ZrRYfOATu4OQx4/Nm5g93t9oZfeY1dDL5rFz1l12j02r
        Otk87lzbw+axeUm9R9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGX0vHnPWPDMqKL1XD9LA+M6
        7S5GTg4JAROJCQ0dTF2MXBxCAjsYJb4dW8oMkZCUmHbxKJDNAWQLSxw+XAxR85ZR4vz/VrAa
        YQFvif75E1hBEiICuxglTr/7zw7iMAv0s0gcXf+PFaLlJKPEpF8X2EBa2AS0JPa/uAFm8wso
        Slz98ZgRxOYVsJNY//Q4C4jNIqAqcfD9M1YQW1QgTGLnksdMEDWCEidnPgGr4RRwkGhdsowd
        xGYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3P
        LTYsMMpLLdcrTswtLs1L10vOz93ECI5xLa0djHtWfdA7xMjEwXiIUYKDWUmE90nErkQh3pTE
        yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamNbc3bRisqro0f+l
        62euOyG0W5pXLl5HZc0n05/Kp6/l1bI/XxTs883//5bA2lWx910+T95T+6b5ng/7FOeUXYdM
        mUI/J1xuLZiwZ9LF8wWiChGMESvn+Fl+dfngydi7SK/r0EGlZzttTf+/vT35erbROWfvnUeT
        V/KoGf1u2dzTtu7Fc8cGf7aOyY2HeO2fffstZ5N7d3OakpnRQSuNpzoR5l29Ak8fbjF4HvR4
        XpJZWqNI677+pYeZpqcZ8LDPl91y4+r85Jc3fQOXOBlyaGXdEGDdZRAyNf994llzWcZXPGF3
        dhwPYRQ0q5DpfnFRsnTypSBt32bm2eFlEu5HM5e+D2rn+i5z91HwCoXaU0osxRmJhlrMRcWJ
        ALpaYJFgAwAA
X-CMS-MailID: 20211216064103epcas1p3bf39ff9adc5810403eab886ef579b3c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211215160914epcas1p3174efaa5d640dce5fc28158587565792
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
        <CGME20211215160914epcas1p3174efaa5d640dce5fc28158587565792@epcas1p3.samsung.com>
        <20211215160906.17451-3-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 1:09 AM, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos850.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> index 568ac97c8120..4799771d09bc 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -426,11 +426,14 @@ CLK_OF_DECLARE(exynos850_cmu_top, "samsung,exynos850-cmu-top",
>  #define CLK_CON_DIV_DIV_CLK_APM_I3C			0x1808
>  #define CLK_CON_GAT_CLKCMU_CMGP_BUS			0x2000
>  #define CLK_CON_GAT_GATE_CLKCMU_CHUB_BUS		0x2014
> +#define CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK	0x2018
> +#define CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK	0x2020
>  #define CLK_CON_GAT_GOUT_APM_APBIF_RTC_PCLK		0x2024
>  #define CLK_CON_GAT_GOUT_APM_APBIF_TOP_RTC_PCLK		0x2028
>  #define CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_PCLK	0x2034
>  #define CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK	0x2038
>  #define CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK		0x20bc
> +#define CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK		0x20c0
>  
>  static const unsigned long apm_clk_regs[] __initconst = {
>  	PLL_CON0_MUX_CLKCMU_APM_BUS_USER,
> @@ -445,11 +448,14 @@ static const unsigned long apm_clk_regs[] __initconst = {
>  	CLK_CON_DIV_DIV_CLK_APM_I3C,
>  	CLK_CON_GAT_CLKCMU_CMGP_BUS,
>  	CLK_CON_GAT_GATE_CLKCMU_CHUB_BUS,
> +	CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK,
> +	CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK,
>  	CLK_CON_GAT_GOUT_APM_APBIF_RTC_PCLK,
>  	CLK_CON_GAT_GOUT_APM_APBIF_TOP_RTC_PCLK,
>  	CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_PCLK,
>  	CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK,
>  	CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK,
> +	CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK,
>  };
>  
>  /* List of parent clocks for Muxes in CMU_APM */
> @@ -512,6 +518,14 @@ static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
>  	     CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK, 21, 0, 0),
>  	GATE(CLK_GOUT_SPEEDY_PCLK, "gout_speedy_pclk", "dout_apm_bus",
>  	     CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK, 21, 0, 0),
> +	/* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICAL) */
> +	GATE(CLK_GOUT_GPIO_ALIVE_PCLK, "gout_gpio_alive_pclk", "dout_apm_bus",
> +	     CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK, 21, CLK_IGNORE_UNUSED,
> +	     0),
> +	GATE(CLK_GOUT_PMU_ALIVE_PCLK, "gout_pmu_alive_pclk", "dout_apm_bus",
> +	     CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK, 21, 0, 0),
> +	GATE(CLK_GOUT_SYSREG_APM_PCLK, "gout_sysreg_apm_pclk", "dout_apm_bus",
> +	     CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK, 21, 0, 0),
>  };
>  
>  static const struct samsung_cmu_info apm_cmu_info __initconst = {
> @@ -541,6 +555,7 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
>  #define CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S0	0x200c
>  #define CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S1	0x2010
>  #define CLK_CON_GAT_GOUT_CMGP_GPIO_PCLK		0x2018
> +#define CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK	0x2040
>  #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK	0x2044
>  #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_PCLK	0x2048
>  #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK	0x204c
> @@ -556,6 +571,7 @@ static const unsigned long cmgp_clk_regs[] __initconst = {
>  	CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S0,
>  	CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S1,
>  	CLK_CON_GAT_GOUT_CMGP_GPIO_PCLK,
> +	CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK,
>  	CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK,
>  	CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_PCLK,
>  	CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK,
> @@ -610,6 +626,9 @@ static const struct samsung_gate_clock cmgp_gate_clks[] __initconst = {
>  	GATE(CLK_GOUT_CMGP_USI1_PCLK, "gout_cmgp_usi1_pclk",
>  	     "gout_clkcmu_cmgp_bus",
>  	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_PCLK, 21, 0, 0),
> +	GATE(CLK_GOUT_SYSREG_CMGP_PCLK, "gout_sysreg_cmgp_pclk",
> +	     "gout_clkcmu_cmgp_bus",
> +	     CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK, 21, 0, 0),
>  };
>  
>  static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
> @@ -910,10 +929,12 @@ CLK_OF_DECLARE(exynos850_cmu_peri, "samsung,exynos850-cmu-peri",
>  #define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
>  #define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK	0x2038
>  #define CLK_CON_GAT_GOUT_CORE_GIC_CLK		0x2040
> +#define CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK	0x2044
>  #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK	0x20e8
>  #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN	0x20ec
>  #define CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK	0x2128
>  #define CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK	0x212c
> +#define CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK	0x2130
>  
>  static const unsigned long core_clk_regs[] __initconst = {
>  	PLL_CON0_MUX_CLKCMU_CORE_BUS_USER,
> @@ -924,10 +945,12 @@ static const unsigned long core_clk_regs[] __initconst = {
>  	CLK_CON_DIV_DIV_CLK_CORE_BUSP,
>  	CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK,
>  	CLK_CON_GAT_GOUT_CORE_GIC_CLK,
> +	CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK,
>  	CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK,
>  	CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN,
>  	CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK,
>  	CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK,
> +	CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK,
>  };
>  
>  /* List of parent clocks for Muxes in CMU_CORE */
> @@ -972,6 +995,12 @@ static const struct samsung_gate_clock core_gate_clks[] __initconst = {
>  	     CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK, 21, 0, 0),
>  	GATE(CLK_GOUT_SSS_PCLK, "gout_sss_pclk", "dout_core_busp",
>  	     CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK, 21, 0, 0),
> +	/* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICAL) */
> +	GATE(CLK_GOUT_GPIO_CORE_PCLK, "gout_gpio_core_pclk", "dout_core_busp",
> +	     CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK, 21, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_GOUT_SYSREG_CORE_PCLK, "gout_sysreg_core_pclk",
> +	     "dout_core_busp",
> +	     CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK, 21, 0, 0),
>  };
>  
>  static const struct samsung_cmu_info core_cmu_info __initconst = {
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
