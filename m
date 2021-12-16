Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDD476A67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhLPGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:34:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33550 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhLPGe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5650CB8229B;
        Thu, 16 Dec 2021 06:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6313C36AE2;
        Thu, 16 Dec 2021 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636466;
        bh=Gt+BZtczzJb/Dny3RcnKDn17J9ysbZaBLlG0bXroAfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vM6Nd/tOhVZKcPnSqFEgSG0ahjioaW0+Zili52Tw4oDE/SS9MZFgBBIMWABR92w2Y
         JK+FfRX2jPcc9l46ArdVp+/dlwZhwwE9Av1cio8z8Lsvn0mvkUkw9f3Ha0kJyjI6xE
         THJ/JatMTPLILGVvgg2Zz/4hVHxIUkh8uXMA9sZtYKnye/ZAh1q6QtMx002+WRgfrJ
         5JT6D1X+R+Uyz8Gr2AS46D6o+ZyobAIgSeAJDoEpGyW+SYhga/ykU5UUnhjr18Wo+y
         zYtemdIXd8fepgkxlwx94LizH8sLMczUY9eaIz7G4sb0/YlPbtJJv4nCz671LcTtFJ
         bxCrMAExqH9vQ==
Date:   Thu, 16 Dec 2021 12:04:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, quic_abhinavk@quicinc.com,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, p.zabel@pengutronix.de,
        Kuogee Hsieh <khsieh@codeaurora.org>
Subject: Re: [PATCH v8] phy: qcom-qmp: add display port v4 voltage and
 pre-emphasis swing tables
Message-ID: <Ybrd7WJpnmd6Wxle@matsya>
References: <1639439228-11430-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639439228-11430-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuogee,

On 13-12-21, 15:47, Kuogee Hsieh wrote:
> From: Kuogee Hsieh <khsieh@codeaurora.org>

The patch is sent by Kuogee Hsieh <quic_khsieh@quicinc.com>, the patch
author is Kuogee Hsieh <khsieh@codeaurora.org> and s-o-b Kuogee Hsieh
<quic_khsieh@quicinc.com>.

Sorry but they need to match before I can pick this.
(Hint: git commit --amend --reset-author would do so provided gitconfig
has your correct email)

> The previous patch from Fixes 'aff188feb5e1 ("phy: qcom-qmp: add support
> for sm8250-usb3-dp phy")' added functions to support V4 of the PHY, But

Pls rephrase to:
Commit aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp
phy")' added functions to support V4 of the PHY, but it did not update
voltage and pre-emphasis tables accordingly.

> it did not update voltage and pre-emphasis tables accordingly.

Empty line here

> This patch add v4 voltage and pre-emphasis swing tables to complete v4
> phy implementation. Both voltage and pre-emphasis swing level are set
> during link training negotiation between host and sink. There are totally
> four tables added.  A voltage swing table for both hbr and hbr1, a voltage
> table for both hbr2 and hbr3, a pre-emphasis table for both hbr and hbr1
> and a pre-emphasis table for both hbr2 and hbr3.

Add one more empty line here

> In addition, write 0x0a
> to TX_TX_POL_INV is added to complete the sequence of configure dp phy
> base on the hardware documentation.
> 
> Fixes: aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp phy")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 112 +++++++++++++++++++++++++-----------
>  1 file changed, 77 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 456a59d..d41e30c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -4255,40 +4255,50 @@ static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy)
>  	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
>  }
>  
> -static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
> +#define MAX_SWING_LEVEL 4
> +#define MAX_VOLTAGE_LEVEL 4
> +#define MAX_EMPHASIS_LEVEL 4
> +
> +static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL] = {
>  	{ 0x00, 0x0c, 0x15, 0x1a },
>  	{ 0x02, 0x0e, 0x16, 0xff },
>  	{ 0x02, 0x11, 0xff, 0xff },
>  	{ 0x04, 0xff, 0xff, 0xff }
>  };
>  
> -static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] = {
> +static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL] = {
>  	{ 0x02, 0x12, 0x16, 0x1a },
>  	{ 0x09, 0x19, 0x1f, 0xff },
>  	{ 0x10, 0x1f, 0xff, 0xff },
>  	{ 0x1f, 0xff, 0xff, 0xff }
>  };
>  
> -static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[4][4] = {
> +static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL] = {
>  	{ 0x00, 0x0c, 0x14, 0x19 },
>  	{ 0x00, 0x0b, 0x12, 0xff },
>  	{ 0x00, 0x0b, 0xff, 0xff },
>  	{ 0x04, 0xff, 0xff, 0xff }
>  };
>  
> -static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[4][4] = {
> +static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL] = {
>  	{ 0x08, 0x0f, 0x16, 0x1f },
>  	{ 0x11, 0x1e, 0x1f, 0xff },
>  	{ 0x19, 0x1f, 0xff, 0xff },
>  	{ 0x1f, 0xff, 0xff, 0xff }
>  };
>  
> -static int qcom_qmp_phy_configure_dp_swing(struct qmp_phy *qphy,
> -		unsigned int drv_lvl_reg, unsigned int emp_post_reg)
> +static int __qcom_qmp_phy_configure_dp_swing
> +			(struct qmp_phy *qphy,
> +			unsigned int drv_lvl_reg,
> +			unsigned int emp_post_reg,
> +			const u8 voltage_swing_hbr_rbr[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL],
> +			const u8 pre_emphasis_hbr_rbr[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL],
> +			const u8 voltage_swing_hbr3_hbr2[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL],
> +			const u8 pre_emphasis_hbr3_hbr2[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL])
>  {
>  	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
>  	unsigned int v_level = 0, p_level = 0;
> -	u8 voltage_swing_cfg, pre_emphasis_cfg;
> +	u8 voltage, emphasis;
>  	int i;
>  
>  	for (i = 0; i < dp_opts->lanes; i++) {
> @@ -4297,26 +4307,25 @@ static int qcom_qmp_phy_configure_dp_swing(struct qmp_phy *qphy,
>  	}
>  
>  	if (dp_opts->link_rate <= 2700) {
> -		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_level];
> -		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_level];
> +		voltage = voltage_swing_hbr_rbr[v_level][p_level];
> +		emphasis = pre_emphasis_hbr_rbr[v_level][p_level];
>  	} else {
> -		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr3_hbr2[v_level][p_level];
> -		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr3_hbr2[v_level][p_level];
> +		voltage = voltage_swing_hbr3_hbr2[v_level][p_level];
> +		emphasis = pre_emphasis_hbr3_hbr2[v_level][p_level];
>  	}
>  
>  	/* TODO: Move check to config check */
> -	if (voltage_swing_cfg == 0xFF && pre_emphasis_cfg == 0xFF)
> +	if (voltage == 0xFF && emphasis == 0xFF)
>  		return -EINVAL;
>  
>  	/* Enable MUX to use Cursor values from these registers */
> -	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
> -	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
> -
> -	writel(voltage_swing_cfg, qphy->tx + drv_lvl_reg);
> -	writel(pre_emphasis_cfg, qphy->tx + emp_post_reg);
> -	writel(voltage_swing_cfg, qphy->tx2 + drv_lvl_reg);
> -	writel(pre_emphasis_cfg, qphy->tx2 + emp_post_reg);
> +	voltage |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
> +	emphasis |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
>  
> +	writel(voltage, qphy->tx + drv_lvl_reg);
> +	writel(emphasis, qphy->tx + emp_post_reg);
> +	writel(voltage, qphy->tx2 + drv_lvl_reg);
> +	writel(emphasis, qphy->tx2 + emp_post_reg);
>  	return 0;
>  }
>  
> @@ -4325,9 +4334,14 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
>  	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
>  	u32 bias_en, drvr_en;
>  
> -	if (qcom_qmp_phy_configure_dp_swing(qphy,
> -				QSERDES_V3_TX_TX_DRV_LVL,
> -				QSERDES_V3_TX_TX_EMP_POST1_LVL) < 0)
> +	if (__qcom_qmp_phy_configure_dp_swing
> +			(qphy,
> +			QSERDES_V3_TX_TX_DRV_LVL,
> +			QSERDES_V3_TX_TX_EMP_POST1_LVL,
> +			qmp_dp_v3_voltage_swing_hbr_rbr,
> +			qmp_dp_v3_pre_emphasis_hbr_rbr,
> +			qmp_dp_v3_voltage_swing_hbr3_hbr2,
> +			qmp_dp_v3_pre_emphasis_hbr3_hbr2) < 0)
>  		return;
>  
>  	if (dp_opts->lanes == 1) {
> @@ -4465,6 +4479,35 @@ static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy)
>  	return 0;
>  }
>  
> +/* The values in these tables are given without MUX_EN (0x20) bit set */
> +static const u8 qmp_dp_v4_pre_emphasis_hbr3_hbr2[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL] = {
> +	{ 0x00, 0x0c, 0x15, 0x1b },
> +	{ 0x02, 0x0e, 0x16, 0xff },
> +	{ 0x02, 0x11, 0xff, 0xff },
> +	{ 0x04, 0xff, 0xff, 0xff }
> +};
> +
> +static const u8 qmp_dp_v4_voltage_swing_hbr3_hbr2[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL] = {
> +	{ 0x02, 0x12, 0x16, 0x1a },
> +	{ 0x09, 0x19, 0x1f, 0xff },
> +	{ 0x10, 0x1f, 0xff, 0xff },
> +	{ 0x1f, 0xff, 0xff, 0xff }
> +};
> +
> +static const u8 qmp_dp_v4_pre_emphasis_hbr_rbr[MAX_SWING_LEVEL][MAX_EMPHASIS_LEVEL] = {
> +	{ 0x00, 0x0e, 0x15, 0x1b },
> +	{ 0x00, 0x0e, 0x15, 0xff },
> +	{ 0x00, 0x0e, 0xff, 0xff },
> +	{ 0x04, 0xff, 0xff, 0xff }
> +};
> +
> +static const u8 qmp_dp_v4_voltage_swing_hbr_rbr[MAX_SWING_LEVEL][MAX_VOLTAGE_LEVEL] = {
> +	{ 0x08, 0x0f, 0x16, 0x1f },
> +	{ 0x11, 0x1e, 0x1f, 0xff },
> +	{ 0x16, 0x1f, 0xff, 0xff },
> +	{ 0x1f, 0xff, 0xff, 0xff }
> +};
> +
>  static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
>  {
>  	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> @@ -4494,16 +4537,14 @@ static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
>  
>  static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
>  {
> -	/* Program default values before writing proper values */
> -	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
> -	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
> -
> -	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> -	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> -
> -	qcom_qmp_phy_configure_dp_swing(qphy,
> +	__qcom_qmp_phy_configure_dp_swing
> +			(qphy,
>  			QSERDES_V4_TX_TX_DRV_LVL,
> -			QSERDES_V4_TX_TX_EMP_POST1_LVL);
> +			QSERDES_V4_TX_TX_EMP_POST1_LVL,
> +			qmp_dp_v4_voltage_swing_hbr_rbr,
> +			qmp_dp_v4_pre_emphasis_hbr_rbr,
> +			qmp_dp_v4_voltage_swing_hbr3_hbr2,
> +			qmp_dp_v4_pre_emphasis_hbr3_hbr2);
>  }
>  
>  static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
> @@ -4622,6 +4663,9 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
>  	writel(drvr1_en, qphy->tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
>  	writel(bias1_en, qphy->tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
>  
> +	writel(0x0a, qphy->tx + QSERDES_V4_TX_TX_POL_INV);
> +	writel(0x0a, qphy->tx2 + QSERDES_V4_TX_TX_POL_INV);
> +
>  	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
>  	udelay(2000);
>  	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
> @@ -4633,11 +4677,9 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
>  			10000))
>  		return -ETIMEDOUT;
>  
> -	writel(0x0a, qphy->tx + QSERDES_V4_TX_TX_POL_INV);
> -	writel(0x0a, qphy->tx2 + QSERDES_V4_TX_TX_POL_INV);
>  
> -	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
> -	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
> +	writel(0x22, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
> +	writel(0x22, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
>  
>  	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
>  	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
~Vinod
