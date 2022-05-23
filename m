Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5D530AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiEWHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiEWHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:24:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFB3A1B7;
        Mon, 23 May 2022 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653290258; x=1684826258;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ev8v7cyguP4Weqk3Bhpwe6YaRfyri/aaDhL9TcGpb8I=;
  b=OE9+ap3Q9zdtnOJxSTb8kEpeo/ZmSvGahLmXghqMz+2ZBkdM1OlqWPf4
   8X+Ub4xTVj3xYi95Y6jO624KN00aRoDkz44RsrN53MLkNcDknmt4fsA+H
   8GgzhTNeCaD/LtTjf+uXOhqCYi2y+8k7qXUBcbzBgwNExBBHyTGny5qch
   rlacEMUZkw8un+JcEFMZyqmOah4Ev0xqF5EtgbbeFkzxC4fuJ+VM/rVFE
   YIrZZR13c79Pxn7k9GO879Z2cTK+HXafgihEB4iKOMSM/e+YSoF3a33Dq
   hJacjVpgumve4Bp2ky+QGJ3RBQ3yOuRobZ7YdjK22WWSwXLTch8r/uKON
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359523924"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="359523924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:07:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="600484629"
Received: from tstralma-mobl1.ger.corp.intel.com ([10.252.55.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:07:13 -0700
Date:   Mon, 23 May 2022 10:07:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, Jiri Slaby <jirislaby@kernel.org>,
        shawnguo@kernel.org, bjorn.andersson@linaro.org,
        geert+renesas@glider.be, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, robert.hancock@calian.com,
        j.neuschaefer@gmx.net, lkundrak@v3.sk, soc@kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/19] clk: npcm8xx: add clock controller
In-Reply-To: <20220522155046.260146-9-tmaimon77@gmail.com>
Message-ID: <6fa3d94c-294d-1c6c-5738-6d15b2e17e90@linux.intel.com>
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-9-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022, Tomer Maimon wrote:

> Nuvoton Arbel BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

> +static struct clk_hw *
> +npcm8xx_clk_register_pll(void __iomem *pllcon, const char *name,
> +			 const char *parent_name, unsigned long flags)
> +{
> +	struct npcm8xx_clk_pll *pll;
> +	struct clk_init_data init;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
> +
> +	init.name = name;
> +	init.ops = &npcm8xx_clk_pll_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = flags;
> +
> +	pll->pllcon = pllcon;
> +	pll->hw.init = &init;
> +
> +	hw = &pll->hw;
> +
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		kfree(pll);
> +		hw = ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +
> +#define NPCM8XX_CLKEN1          (0x00)
> +#define NPCM8XX_CLKEN2          (0x28)
> +#define NPCM8XX_CLKEN3          (0x30)
> +#define NPCM8XX_CLKEN4          (0x70)
> +#define NPCM8XX_CLKSEL          (0x04)
> +#define NPCM8XX_CLKDIV1         (0x08)
> +#define NPCM8XX_CLKDIV2         (0x2C)
> +#define NPCM8XX_CLKDIV3         (0x58)
> +#define NPCM8XX_CLKDIV4         (0x7C)
> +#define NPCM8XX_PLLCON0         (0x0C)
> +#define NPCM8XX_PLLCON1         (0x10)
> +#define NPCM8XX_PLLCON2         (0x54)
> +#define NPCM8XX_SWRSTR          (0x14)
> +#define NPCM8XX_IRQWAKECON      (0x18)
> +#define NPCM8XX_IRQWAKEFLAG     (0x1C)
> +#define NPCM8XX_IPSRST1         (0x20)
> +#define NPCM8XX_IPSRST2         (0x24)
> +#define NPCM8XX_IPSRST3         (0x34)
> +#define NPCM8XX_WD0RCR          (0x38)
> +#define NPCM8XX_WD1RCR          (0x3C)
> +#define NPCM8XX_WD2RCR          (0x40)
> +#define NPCM8XX_SWRSTC1         (0x44)
> +#define NPCM8XX_SWRSTC2         (0x48)
> +#define NPCM8XX_SWRSTC3         (0x4C)
> +#define NPCM8XX_SWRSTC4         (0x50)
> +#define NPCM8XX_CORSTC          (0x5C)
> +#define NPCM8XX_PLLCONG         (0x60)
> +#define NPCM8XX_AHBCKFI         (0x64)
> +#define NPCM8XX_SECCNT          (0x68)
> +#define NPCM8XX_CNTR25M         (0x6C)
> +#define NPCM8XX_THRTL_CNT       (0xC0)
> +
> +struct npcm8xx_clk_gate_data {
> +	u32 reg;
> +	u8 bit_idx;
> +	const char *name;
> +	const char *parent_name;
> +	unsigned long flags;
> +	/*
> +	 * If this clock is exported via DT, set onecell_idx to constant
> +	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
> +	 * this specific clock.  Otherwise, set to -1.
> +	 */
> +	int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_mux_data {
> +	u8 shift;
> +	u8 mask;
> +	u32 *table;
> +	const char *name;
> +	const char * const *parent_names;
> +	u8 num_parents;
> +	unsigned long flags;
> +	/*
> +	 * If this clock is exported via DT, set onecell_idx to constant
> +	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
> +	 * this specific clock.  Otherwise, set to -1.
> +	 */
> +	int onecell_idx;
> +
> +};
> +
> +struct npcm8xx_clk_div_fixed_data {
> +	u8 mult;
> +	u8 div;
> +	const char *name;
> +	const char *parent_name;
> +	u8 clk_divider_flags;
> +	/*
> +	 * If this clock is exported via DT, set onecell_idx to constant
> +	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
> +	 * this specific clock.  Otherwise, set to -1.
> +	 */
> +	int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_div_data {
> +	u32 reg;
> +	u8 shift;
> +	u8 width;
> +	const char *name;
> +	const char *parent_name;
> +	u8 clk_divider_flags;
> +	unsigned long flags;
> +	/*
> +	 * If this clock is exported via DT, set onecell_idx to constant
> +	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
> +	 * this specific clock.  Otherwise, set to -1.
> +	 */
> +	int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_pll_data {
> +	u32 reg;
> +	const char *name;
> +	const char *parent_name;
> +	unsigned long flags;
> +	/*
> +	 * If this clock is exported via DT, set onecell_idx to constant
> +	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
> +	 * this specific clock.  Otherwise, set to -1.
> +	 */
> +	int onecell_idx;
> +};
> +


> +/*
> + * Single copy of strings used to refer to clocks within this driver indexed by
> + * above enum.
> + */
> +#define NPCM8XX_CLK_S_REFCLK      "refclk"
> +#define NPCM8XX_CLK_S_SYSBYPCK    "sysbypck"
> +#define NPCM8XX_CLK_S_MCBYPCK     "mcbypck"
> +#define NPCM8XX_CLK_S_GFXBYPCK    "gfxbypck"
> +#define NPCM8XX_CLK_S_PLL0        "pll0"
> +#define NPCM8XX_CLK_S_PLL1        "pll1"
> +#define NPCM8XX_CLK_S_PLL1_DIV2   "pll1_div2"
> +#define NPCM8XX_CLK_S_PLL2        "pll2"
> +#define NPCM8XX_CLK_S_PLL_GFX     "pll_gfx"
> +#define NPCM8XX_CLK_S_PLL2_DIV2   "pll2_div2"
> +#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel"
> +#define NPCM8XX_CLK_S_GPRFSEL_MUX "gprfsel_mux"
> +#define NPCM8XX_CLK_S_MC_MUX      "mc_phy"
> +#define NPCM8XX_CLK_S_CPU_MUX     "cpu"  /*AKA system clock.*/

Add spaces around comment.

> +#define NPCM8XX_CLK_S_MC          "mc"
> +#define NPCM8XX_CLK_S_AXI         "axi"  /*AKA CLK2*/
> +#define NPCM8XX_CLK_S_AHB         "ahb"  /*AKA CLK4*/

Ditto.

> +static void __init npcm8xx_clk_init(struct device_node *clk_np)
> +{
> +	struct clk_hw_onecell_data *npcm8xx_clk_data;
> +	void __iomem *clk_base;
> +	struct resource res;
> +	struct clk_hw *hw;
> +	int ret;
> +	int i;
> +
> +	ret = of_address_to_resource(clk_np, 0, &res);
> +	if (ret) {
> +		pr_err("%pOFn: failed to get resource, ret %d\n", clk_np, ret);
> +		return;
> +	}
> +
> +	clk_base = ioremap(res.start, resource_size(&res));
> +	if (!clk_base)
> +		goto npcm8xx_init_error;
> +
> +	npcm8xx_clk_data = kzalloc(struct_size(npcm8xx_clk_data, hws,
> +					       NPCM8XX_NUM_CLOCKS), GFP_KERNEL);
> +	if (!npcm8xx_clk_data)
> +		goto npcm8xx_init_np_err;
> +
> +	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
> +
> +	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	/* Register plls */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
> +		const struct npcm8xx_clk_pll_data *pll_data = &npcm8xx_plls[i];
> +
> +		hw = npcm8xx_clk_register_pll(clk_base + pll_data->reg,
> +					      pll_data->name,
> +					      pll_data->parent_name,
> +					      pll_data->flags);
> +		if (IS_ERR(hw)) {

Who deregisters the already registered plls on error paths?

You might want to consider devm_ variants in npcm8xx_clk_register_pll() to 
make the cleanup simpler.

Please check the other error path rollbacks from this point onward too.

> +			pr_err("npcm8xx_clk: Can't register pll\n");
> +			goto npcm8xx_init_fail;
> +		}
> +
> +		if (pll_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[pll_data->onecell_idx] = hw;
> +	}
> +
> +	/* Register fixed dividers */
> +	hw = clk_hw_register_fixed_factor(NULL, NPCM8XX_CLK_S_PLL1_DIV2,
> +					  NPCM8XX_CLK_S_PLL1, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		pr_err("npcm8xx_clk: Can't register fixed div\n");
> +		goto npcm8xx_init_fail;
> +	}
> +
> +	hw = clk_hw_register_fixed_factor(NULL, NPCM8XX_CLK_S_PLL2_DIV2,
> +					  NPCM8XX_CLK_S_PLL2, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		pr_err("npcm8xx_clk: Can't register pll div2\n");
> +		goto npcm8xx_init_fail;
> +	}
> +
> +	hw = clk_hw_register_fixed_factor(NULL, NPCM8XX_CLK_S_PRE_CLK,
> +					  NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		pr_err("npcm8xx_clk: Can't register ckclk div2\n");
> +		goto npcm8xx_init_fail;
> +	}
> +
> +	hw = clk_hw_register_fixed_factor(NULL, NPCM8XX_CLK_S_AXI,
> +					  NPCM8XX_CLK_S_TH, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		pr_err("npcm8xx_clk: Can't register axi div2\n");
> +		goto npcm8xx_init_fail;
> +	}
> +
> +	hw = clk_hw_register_fixed_factor(NULL, NPCM8XX_CLK_S_ATB,
> +					  NPCM8XX_CLK_S_AXI, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		pr_err("npcm8xx_clk: Can't register atb div2\n");
> +		goto npcm8xx_init_fail;
> +	}
> +
> +	/* Register muxes */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> +		const struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
> +
> +		hw = clk_hw_register_mux_table(NULL, mux_data->name,
> +					       mux_data->parent_names,
> +					       mux_data->num_parents,
> +					       mux_data->flags,
> +					       clk_base + NPCM8XX_CLKSEL,
> +					       mux_data->shift,
> +					       mux_data->mask, 0,
> +					       mux_data->table,
> +					       &npcm8xx_clk_lock);
> +
> +		if (IS_ERR(hw)) {
> +			pr_err("npcm8xx_clk: Can't register mux\n");
> +			goto npcm8xx_init_fail;
> +		}
> +
> +		if (mux_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[mux_data->onecell_idx] = hw;
> +	}
> +
> +	/* Register clock dividers specified in npcm8xx_divs */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> +		const struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
> +
> +		hw = clk_hw_register_divider(NULL, div_data->name,
> +					     div_data->parent_name,
> +					     div_data->flags,
> +					     clk_base + div_data->reg,
> +					     div_data->shift, div_data->width,
> +					     div_data->clk_divider_flags,
> +					     &npcm8xx_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("npcm8xx_clk: Can't register div table\n");
> +			goto npcm8xx_init_fail;
> +		}
> +
> +		if (div_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
> +	}
> +
> +	ret = of_clk_add_hw_provider(clk_np, of_clk_hw_onecell_get,
> +				     npcm8xx_clk_data);
> +	if (ret)
> +		pr_err("failed to add DT provider: %d\n", ret);
> +
> +	of_node_put(clk_np);
> +
> +	return;
> +
> +npcm8xx_init_fail:
> +	kfree(npcm8xx_clk_data->hws);
> +npcm8xx_init_np_err:
> +	iounmap(clk_base);
> +npcm8xx_init_error:
> +	of_node_put(clk_np);
> +}
> +
> +CLK_OF_DECLARE(npcm8xx_clk_init, "nuvoton,npcm845-clk", npcm8xx_clk_init);
> 

-- 
 i.

