Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1813F466D79
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbhLBXND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:13:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:11126 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349369AbhLBXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638486577; x=1670022577;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nbmqy62m/cmILo8Y6Y47E1TyHv5ik6uqbv+qJuJ6uTs=;
  b=ebQBZbKWzeslhEheAKFK/SIMeTOTjzwBY1TkfBE1gUV5hFRXTDa1B0mR
   bcEuCE9FaCg7OlM2R4DJ1L7Ma2PGg8l8q/40iPd8PbSq3tLaOCeX6oENQ
   P9Me7tXlBqMn7SUsQXYzSOHrddz2qLLTYbwn1w+xHaK6EQrDPQWq9rDGC
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Dec 2021 15:09:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 15:09:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 15:09:36 -0800
Received: from [10.47.233.232] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 15:09:36 -0800
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
To:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211201072718.3969011-1-vkoul@kernel.org>
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Message-ID: <8f6645ff-0753-bcd3-f692-6be205cf71b8@quicinc.com>
Date:   Thu, 2 Dec 2021 15:09:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211201072718.3969011-1-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 11:27 PM, Vinod Koul wrote:
> From: David Dai <daidavid1@codeaurora.org>

This change was made internally by David Collins.Can you please fix it?

commit ee7581a559720dd5a45f2f4c3eb7f8b4bde36118
Author: David Collins <collinsd@codeaurora.org>
Date:   Thu Oct 8 15:36:46 2020 -0700

    spmi: pmic-arb: add support for HW version 7
   
    Add support for version 7 of the SPMI PMIC arbiter.  It provides
    two independent SPMI bus interfaces which share some common PMIC
    arbiter registers.
   
    Change-Id: I7a2f816c9cd6898ada28967b47c8192f4529bc04
    Signed-off-by: David Collins <collinsd@codeaurora.org>

We wanted to send this patch once the current spmi-pmic-arb patch series [1] got reviewed and accepted.

[1] https://lore.kernel.org/linux-arm-msm/1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com/T/#t
>
> PMIC v7 has different offset values and seqeunces, so add support for
> this new version of PMIC
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/spmi/spmi-pmic-arb.c | 188 +++++++++++++++++++++++++++++++----
>  1 file changed, 169 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index bbbd311eda03..28418a10ee5c 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -22,8 +22,14 @@
>  #define PMIC_ARB_VERSION_V2_MIN		0x20010000
>  #define PMIC_ARB_VERSION_V3_MIN		0x30000000
>  #define PMIC_ARB_VERSION_V5_MIN		0x50000000
> +#define PMIC_ARB_VERSION_V7_MIN		0x70000000
>  #define PMIC_ARB_INT_EN			0x0004
>  
> +#define PMIC_ARB_FEATURES		0x0004
> +#define PMIC_ARB_FEATURES_PERIPH_MASK	GENMASK(10, 0)
> +
> +#define PMIC_ARB_FEATURES1		0x008
> +
>  /* PMIC Arbiter channel registers offsets */
>  #define PMIC_ARB_CMD			0x00
>  #define PMIC_ARB_CONFIG			0x04
> @@ -48,7 +54,6 @@
>  #define INVALID_EE				0xFF
>  
>  /* Ownership Table */
> -#define SPMI_OWNERSHIP_TABLE_REG(N)	(0x0700 + (4 * (N)))
>  #define SPMI_OWNERSHIP_PERIPH2OWNER(X)	((X) & 0x7)
>  
>  /* Channel Status fields */
> @@ -91,6 +96,7 @@ enum pmic_arb_channel {
>  
>  /* Maximum number of support PMIC peripherals */
>  #define PMIC_ARB_MAX_PERIPHS		512
> +#define PMIC_ARB_MAX_PERIPHS_V7		1024
>  #define PMIC_ARB_TIMEOUT_US		100
>  #define PMIC_ARB_MAX_TRANS_BYTES	(8)
>  
> @@ -104,12 +110,12 @@ enum pmic_arb_channel {
>  	((((slave_id) & 0xF)   << 28) | \
>  	(((periph_id) & 0xFF)  << 20) | \
>  	(((irq_id)    & 0x7)   << 16) | \
> -	(((apid)      & 0x1FF) << 0))
> +	(((apid)      & 0x3FF) << 0))
>  
>  #define hwirq_to_sid(hwirq)  (((hwirq) >> 28) & 0xF)
>  #define hwirq_to_per(hwirq)  (((hwirq) >> 20) & 0xFF)
>  #define hwirq_to_irq(hwirq)  (((hwirq) >> 16) & 0x7)
> -#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x1FF)
> +#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x3FF)
>  
>  struct pmic_arb_ver_ops;
>  
> @@ -149,8 +155,11 @@ struct spmi_pmic_arb {
>  	u8			channel;
>  	int			irq;
>  	u8			ee;
> +	u32			bus_instance;
>  	u16			min_apid;
>  	u16			max_apid;
> +	u16			base_apid;
> +	int			apid_count;
>  	u32			*mapping_table;
>  	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
>  	struct irq_domain	*domain;
> @@ -158,7 +167,8 @@ struct spmi_pmic_arb {
>  	const struct pmic_arb_ver_ops *ver_ops;
>  	u16			*ppid_to_apid;
>  	u16			last_apid;
> -	struct apid_data	apid_data[PMIC_ARB_MAX_PERIPHS];
> +	struct apid_data	*apid_data;
> +	int			max_periphs;
>  };
>  
>  /**
> @@ -196,6 +206,7 @@ struct pmic_arb_ver_ops {
>  	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
>  	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
>  	u32 (*apid_map_offset)(u16 n);
> +	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
>  };
>  
>  static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
> @@ -530,6 +541,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	int first = pmic_arb->min_apid >> 5;
>  	int last = pmic_arb->max_apid >> 5;
> +	int acc_offsets = pmic_arb->base_apid >> 5;
>  	u8 ee = pmic_arb->ee;
>  	u32 status, enable;
>  	int i, id, apid;
> @@ -538,7 +550,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>  
>  	for (i = first; i <= last; ++i) {
>  		status = readl_relaxed(
> -				ver_ops->owner_acc_status(pmic_arb, ee, i));
> +				ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offsets));
>  		while (status) {
>  			id = ffs(status) - 1;
>  			status &= ~BIT(id);
> @@ -839,8 +851,7 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>  		if (offset >= pmic_arb->core_size)
>  			break;
>  
> -		regval = readl_relaxed(pmic_arb->cnfg +
> -				      SPMI_OWNERSHIP_TABLE_REG(apid));
> +		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb, apid));
>  		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
>  		apidd->write_ee = apidd->irq_ee;
>  
> @@ -876,9 +887,9 @@ static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>  
>  static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>  {
> -	struct apid_data *apidd = pmic_arb->apid_data;
> +	struct apid_data *apidd;
>  	struct apid_data *prev_apidd;
> -	u16 i, apid, ppid;
> +	u16 i, apid, ppid, apid_max;
>  	bool valid, is_irq_ee;
>  	u32 regval, offset;
>  
> @@ -889,7 +900,9 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>  	 * allowed to write to the APID.  The owner of the last (highest) APID
>  	 * for a given PPID will receive interrupts from the PPID.
>  	 */
> -	for (i = 0; ; i++, apidd++) {
> +	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
> +	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
> +	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
>  		offset = pmic_arb->ver_ops->apid_map_offset(i);
>  		if (offset >= pmic_arb->core_size)
>  			break;
> @@ -900,8 +913,7 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>  		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
>  		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
>  
> -		regval = readl_relaxed(pmic_arb->cnfg +
> -				      SPMI_OWNERSHIP_TABLE_REG(i));
> +		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb, i));
>  		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
>  
>  		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
> @@ -995,6 +1007,36 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>  	return offset;
>  }
>  
> +static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> +			      enum pmic_arb_channel ch_type)
> +{
> +	u16 apid;
> +	int rc;
> +	u32 offset = 0;
> +	u16 ppid = (sid << 8) | (addr >> 8);
> +
> +	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
> +	if (rc < 0)
> +		return rc;
> +
> +	apid = rc;
> +	switch (ch_type) {
> +	case PMIC_ARB_CHANNEL_OBS:
> +		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
> +		break;
> +	case PMIC_ARB_CHANNEL_RW:
> +		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
> +			dev_err(&pmic_arb->spmic->dev, "disallow spmi write to sid=%u, add: %x\n",
> +				sid, addr);
> +			return -EPERM;
> +		}
> +		offset = 0x10000 * apid;
> +		break;
> +	}
> +
> +	return offset;
> +}
> +
>  static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
>  {
>  	return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
> @@ -1029,6 +1071,12 @@ pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
>  	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
>  }
>  
> +static void __iomem *
> +pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +{
> +	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
> +}
> +
>  static void __iomem *
>  pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
>  {
> @@ -1047,6 +1095,12 @@ pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
>  	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
>  }
>  
> +static void __iomem *
> +pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +{
> +	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
> +}
> +
>  static void __iomem *
>  pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
>  {
> @@ -1065,6 +1119,12 @@ pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
>  	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
>  }
>  
> +static void __iomem *
> +pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +{
> +	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
> +}
> +
>  static void __iomem *
>  pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
>  {
> @@ -1079,6 +1139,12 @@ pmic_arb_irq_clear_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
>  
>  static void __iomem *
>  pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
> +{
> +	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
> +}
> +
> +static void __iomem *
> +pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
>  {
>  	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
>  }
> @@ -1093,6 +1159,23 @@ static u32 pmic_arb_apid_map_offset_v5(u16 n)
>  	return 0x900 + 0x4 * n;
>  }
>  
> +static u32 pmic_arb_apid_map_offset_v7(u16 n)
> +{
> +	return 0x2000 + 0x4 * n;
> +}
> +
> +static void __iomem *
> +pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
> +{
> +	return pmic_arb->cnfg + 0x700 + 0x4 * n;
> +}
> +
> +static void __iomem *
> +pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +{
> +	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
> +}
> +
>  static const struct pmic_arb_ver_ops pmic_arb_v1 = {
>  	.ver_str		= "v1",
>  	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
> @@ -1104,6 +1187,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
>  	.irq_status		= pmic_arb_irq_status_v1,
>  	.irq_clear		= pmic_arb_irq_clear_v1,
>  	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
> +	.apid_owner		= pmic_arb_apid_owner_v2,
>  };
>  
>  static const struct pmic_arb_ver_ops pmic_arb_v2 = {
> @@ -1117,6 +1201,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
>  	.irq_status		= pmic_arb_irq_status_v2,
>  	.irq_clear		= pmic_arb_irq_clear_v2,
>  	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
> +	.apid_owner		= pmic_arb_apid_owner_v2,
>  };
>  
>  static const struct pmic_arb_ver_ops pmic_arb_v3 = {
> @@ -1130,6 +1215,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
>  	.irq_status		= pmic_arb_irq_status_v2,
>  	.irq_clear		= pmic_arb_irq_clear_v2,
>  	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
> +	.apid_owner		= pmic_arb_apid_owner_v2,
>  };
>  
>  static const struct pmic_arb_ver_ops pmic_arb_v5 = {
> @@ -1143,6 +1229,21 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>  	.irq_status		= pmic_arb_irq_status_v5,
>  	.irq_clear		= pmic_arb_irq_clear_v5,
>  	.apid_map_offset	= pmic_arb_apid_map_offset_v5,
> +	.apid_owner		= pmic_arb_apid_owner_v2,
> +};
> +
> +static const struct pmic_arb_ver_ops pmic_arb_v7 = {
> +	.ver_str		= "v7",
> +	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
> +	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
> +	.offset			= pmic_arb_offset_v7,
> +	.fmt_cmd		= pmic_arb_fmt_cmd_v2,
> +	.owner_acc_status	= pmic_arb_owner_acc_status_v7,
> +	.acc_enable		= pmic_arb_acc_enable_v7,
> +	.irq_status		= pmic_arb_irq_status_v7,
> +	.irq_clear		= pmic_arb_irq_clear_v7,
> +	.apid_map_offset	= pmic_arb_apid_map_offset_v7,
> +	.apid_owner		= pmic_arb_apid_owner_v7,
>  };
>  
>  static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  	pmic_arb = spmi_controller_get_drvdata(ctrl);
>  	pmic_arb->spmic = ctrl;
>  
> +	/*
> +	 * Don't use devm_ioremap_resource() as the resources are shared in
> +	 * PMIC v7 onwards, so causing failure when mapping
> +	 */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
> -	core = devm_ioremap_resource(&ctrl->dev, res);
> +	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>  	if (IS_ERR(core)) {
>  		err = PTR_ERR(core);
>  		goto err_put_ctrl;
> @@ -1199,12 +1304,14 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  			pmic_arb->ver_ops = &pmic_arb_v2;
>  		else if (hw_ver < PMIC_ARB_VERSION_V5_MIN)
>  			pmic_arb->ver_ops = &pmic_arb_v3;
> -		else
> +		else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
>  			pmic_arb->ver_ops = &pmic_arb_v5;
> +		else
> +			pmic_arb->ver_ops = &pmic_arb_v7;
>  
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  						   "obsrvr");
> -		pmic_arb->rd_base = devm_ioremap_resource(&ctrl->dev, res);
> +		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>  		if (IS_ERR(pmic_arb->rd_base)) {
>  			err = PTR_ERR(pmic_arb->rd_base);
>  			goto err_put_ctrl;
> @@ -1212,25 +1319,68 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  						   "chnls");
> -		pmic_arb->wr_base = devm_ioremap_resource(&ctrl->dev, res);
> +		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>  		if (IS_ERR(pmic_arb->wr_base)) {
>  			err = PTR_ERR(pmic_arb->wr_base);
>  			goto err_put_ctrl;
>  		}
>  	}
>  
> +	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> +
> +	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
> +		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
> +
> +		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id", &pmic_arb->bus_instance);
> +		if (pmic_arb->bus_instance > 1) {
> +			err = -EINVAL;
> +			dev_err(&ctrl->dev, "invalid bus instance: %d\n", pmic_arb->bus_instance);
> +			goto err_put_ctrl;
> +		}
> +
> +		if (pmic_arb->bus_instance == 0) {
> +			pmic_arb->base_apid = 0;
> +			pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
> +		} else {
> +			pmic_arb->base_apid = readl_relaxed(core + PMIC_ARB_FEATURES) &
> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
> +			pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES1) &
> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
> +		}
> +
> +	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
> +		pmic_arb->base_apid = 0;
> +		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
> +						     PMIC_ARB_FEATURES_PERIPH_MASK;
> +	}
> +
> +	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> +		err = -EINVAL;
> +		dev_err(&ctrl->dev, "Unsupported APID count: %d\n",
> +			pmic_arb->base_apid + pmic_arb->apid_count);
> +		goto err_put_ctrl;
> +	}
> +
> +	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
> +					   sizeof(*pmic_arb->apid_data), GFP_KERNEL);
> +	if (!pmic_arb->apid_data) {
> +		err = -ENOMEM;
> +		goto err_put_ctrl;
> +	}
> +
>  	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
>  		 pmic_arb->ver_ops->ver_str, hw_ver);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
> -	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
> +	pmic_arb->intr = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>  	if (IS_ERR(pmic_arb->intr)) {
>  		err = PTR_ERR(pmic_arb->intr);
>  		goto err_put_ctrl;
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cnfg");
> -	pmic_arb->cnfg = devm_ioremap_resource(&ctrl->dev, res);
> +	pmic_arb->cnfg = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>  	if (IS_ERR(pmic_arb->cnfg)) {
>  		err = PTR_ERR(pmic_arb->cnfg);
>  		goto err_put_ctrl;
> @@ -1281,7 +1431,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  	/* Initialize max_apid/min_apid to the opposite bounds, during
>  	 * the irq domain translation, we are sure to update these */
>  	pmic_arb->max_apid = 0;
> -	pmic_arb->min_apid = PMIC_ARB_MAX_PERIPHS - 1;
> +	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
>  
>  	platform_set_drvdata(pdev, ctrl);
>  	raw_spin_lock_init(&pmic_arb->lock);

