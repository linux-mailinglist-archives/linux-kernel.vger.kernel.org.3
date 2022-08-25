Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928A5A121A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiHYN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbiHYN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:29:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91156B4EB2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:29:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u14so24619120wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=r+7KhO107XtuGQRya2SMyrN5Gkqvxhp+QnSydUEqt4o=;
        b=MfbpSWBjslBLidMOtHp64srSaAoaakp960Ce6NEWjKyzPy8MNQ3qdV2N/awZMaPLmM
         PE8jcYwf2amrUihE5rdSfRP/6FZ1PaGlw2omrC5nI7X05OfCQsniax4EpN+MjmNUD59B
         uY+Bv2HrH1CRvqw9n12E5SoG27rntqHeqTlE3cNuvv9Rv9EfOJViio295e7d7zNK5tzz
         ecXsPBbE74VQdy/XB9c525oQJLWyFhdWgrufqJfNz1tlkPv7qgkLxnFng0JfSzQFJ/ER
         OZKu2bxYtlhIw/arAdlmRMiL2c4e4jnsKNv1fEbKa+3b8PNKG0FPoA32rBe+fzF2Rgdo
         9Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=r+7KhO107XtuGQRya2SMyrN5Gkqvxhp+QnSydUEqt4o=;
        b=4uybEi/8ufBantgRUBSzU8ZNNufddZgKQXzPL1qtidzUFo8K/wasmcE4vAfoOdbNdU
         I78H8tgRRjBBkpcaSKg6l1BgGJAVLC7KSyHQI0JUBVxa+bFvxhds0h4xDJdjhSEq5bLg
         XL5nxmGuR/htZp9yj3JNa9zvpD/JrTWwfBp/teFo7XMDOl6+9jPhec+Eb+DV5MpS2EMq
         6t8xYhmwNq7TdeDX8KE62tHBppYf304POpHJxKalYn1EtLagr8FomNg48NIXe/eENIyI
         jAJ9cN714iWw8BbBoGbaN07FjV4sGrrNUoWTSQ8lYbeYJ7XQUxY/bX9z87x48nNt8JoA
         8m6A==
X-Gm-Message-State: ACgBeo0lP4tWcZrvtVR4Nx1kUJzJ0Y9ewWF3gsb6XEYigA2+JqEcDFKE
        SvWcxb2eDHVr/KrBkMId60s=
X-Google-Smtp-Source: AA6agR497WIz5r1eVzo7O7AQ0hCep0Ul49wd8ZivXsaJIBA29VICrc02nB5BCbm3dE6vKSqPje5O8A==
X-Received: by 2002:adf:d0c4:0:b0:225:3a53:f573 with SMTP id z4-20020adfd0c4000000b002253a53f573mr2284853wrh.503.1661434175008;
        Thu, 25 Aug 2022 06:29:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b002207a0b93b4sm19781560wrr.49.2022.08.25.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:29:33 -0700 (PDT)
Message-ID: <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
Date:   Thu, 25 Aug 2022 15:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 6/6] soc: mediatek: mtk-svs: Use bitfield access macros
 where possible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> In order to enhance readability and safety during registers setup
> and value retrieval, redefine a few register related macros and
> convert all open-coded instances of bitfield setting/retrieval
> to use the FIELD_PREP() and FIELD_GET() macros.
> While at it, some macros were renamed to further enhance readability.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Does not apply, would you mind to resend together with 1/6? Thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 191 ++++++++++++++++++++++-----------
>   1 file changed, 128 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 25b49d8af59a..f5e6627f7a56 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -53,22 +53,79 @@
>   #define SVSB_MON_VOLT_IGNORE		BIT(16)
>   #define SVSB_REMOVE_DVTFIXED_VOLT	BIT(24)
>   
> -/* svs bank register common configuration */
> -#define SVSB_DET_MAX			0xffff
> +/* svs bank register fields and common configuration */
> +#define SVSB_PTPCONFIG_DETMAX		GENMASK(15, 0)
> +#define SVSB_DET_MAX			FIELD_PREP(SVSB_PTPCONFIG_DETMAX, 0xffff)
>   #define SVSB_DET_WINDOW			0xa28
> -#define SVSB_DTHI			0x1
> -#define SVSB_DTLO			0xfe
> -#define SVSB_EN_INIT01			0x1
> -#define SVSB_EN_INIT02			0x5
> -#define SVSB_EN_MON			0x2
> -#define SVSB_EN_OFF			0x0
> -#define SVSB_INTEN_INIT0x		0x00005f01
> -#define SVSB_INTEN_MONVOPEN		0x00ff0000
> -#define SVSB_INTSTS_CLEAN		0x00ffffff
> -#define SVSB_INTSTS_COMPLETE		0x1
> -#define SVSB_INTSTS_MONVOP		0x00ff0000
> +
> +/* DESCHAR */
> +#define SVSB_DESCHAR_FLD_MDES		GENMASK(7, 0)
> +#define SVSB_DESCHAR_FLD_BDES		GENMASK(15, 8)
> +
> +/* TEMPCHAR */
> +#define SVSB_TEMPCHAR_FLD_DVT_FIXED	GENMASK(7, 0)
> +#define SVSB_TEMPCHAR_FLD_MTDES		GENMASK(15, 8)
> +#define SVSB_TEMPCHAR_FLD_VCO		GENMASK(23, 16)
> +
> +/* DETCHAR */
> +#define SVSB_DETCHAR_FLD_DCMDET		GENMASK(7, 0)
> +#define SVSB_DETCHAR_FLD_DCBDET		GENMASK(15, 8)
> +
> +/* SVSEN (PTPEN) */
> +#define SVSB_PTPEN_INIT01		BIT(0)
> +#define SVSB_PTPEN_MON			BIT(1)
> +#define SVSB_PTPEN_INIT02		(SVSB_PTPEN_INIT01 | BIT(2))
> +#define SVSB_PTPEN_OFF			0x0
> +
> +/* FREQPCTS */
> +#define SVSB_FREQPCTS_FLD_PCT0_4	GENMASK(7, 0)
> +#define SVSB_FREQPCTS_FLD_PCT1_5	GENMASK(15, 8)
> +#define SVSB_FREQPCTS_FLD_PCT2_6	GENMASK(23, 16)
> +#define SVSB_FREQPCTS_FLD_PCT3_7	GENMASK(31, 24)
> +
> +/* INTSTS */
> +#define SVSB_INTSTS_VAL_CLEAN		0x00ffffff
> +#define SVSB_INTSTS_F0_COMPLETE		BIT(0)
> +#define SVSB_INTSTS_FLD_MONVOP		GENMASK(23, 16)
>   #define SVSB_RUNCONFIG_DEFAULT		0x80000000
>   
> +/* LIMITVALS */
> +#define SVSB_LIMITVALS_FLD_DTLO		GENMASK(7, 0)
> +#define SVSB_LIMITVALS_FLD_DTHI		GENMASK(15, 8)
> +#define SVSB_LIMITVALS_FLD_VMIN		GENMASK(23, 16)
> +#define SVSB_LIMITVALS_FLD_VMAX		GENMASK(31, 24)
> +#define SVSB_VAL_DTHI			0x1
> +#define SVSB_VAL_DTLO			0xfe
> +
> +/* INTEN */
> +#define SVSB_INTEN_F0EN			BIT(0)
> +#define SVSB_INTEN_DACK0UPEN		BIT(8)
> +#define SVSB_INTEN_DC0EN		BIT(9)
> +#define SVSB_INTEN_DC1EN		BIT(10)
> +#define SVSB_INTEN_DACK0LOEN		BIT(11)
> +#define SVSB_INTEN_INITPROD_OVF_EN	BIT(12)
> +#define SVSB_INTEN_INITSUM_OVF_EN	BIT(14)
> +#define SVSB_INTEN_MONVOPEN		GENMASK(23, 16)
> +#define SVSB_INTEN_INIT0x		(SVSB_INTEN_F0EN | SVSB_INTEN_DACK0UPEN |	\
> +					 SVSB_INTEN_DC0EN | SVSB_INTEN_DC1EN |		\
> +					 SVSB_INTEN_DACK0LOEN |				\
> +					 SVSB_INTEN_INITPROD_OVF_EN |			\
> +					 SVSB_INTEN_INITSUM_OVF_EN)
> +
> +/* TSCALCS */
> +#define SVSB_TSCALCS_FLD_MTS		GENMASK(11, 0)
> +#define SVSB_TSCALCS_FLD_BTS		GENMASK(23, 12)
> +
> +/* INIT2VALS */
> +#define SVSB_INIT2VALS_FLD_DCVOFFSETIN	GENMASK(15, 0)
> +#define SVSB_INIT2VALS_FLD_AGEVOFFSETIN	GENMASK(31, 16)
> +
> +/* VOPS */
> +#define SVSB_VOPS_FLD_VOP0_4		GENMASK(7, 0)
> +#define SVSB_VOPS_FLD_VOP1_5		GENMASK(15, 8)
> +#define SVSB_VOPS_FLD_VOP2_6		GENMASK(23, 16)
> +#define SVSB_VOPS_FLD_VOP3_7		GENMASK(31, 24)
> +
>   /* svs bank related setting */
>   #define BITS8				8
>   #define MAX_OPP_ENTRIES			16
> @@ -667,8 +724,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
>   		svsp->pbank = svsb;
>   		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
>   		svs_switch_bank(svsp);
> -		svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
> -		svs_writel_relaxed(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
>   		spin_unlock_irqrestore(&svs_lock, flags);
>   
>   		svsb->phase = SVSB_PHASE_ERROR;
> @@ -830,7 +887,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
>   		} else if (svsb->type == SVSB_LOW) {
>   			/* volt[turn_pt] + volt[j] ~ volt[opp_count - 1] */
>   			j = svsb->opp_count - 7;
> -			svsb->volt[turn_pt] = vop30 & GENMASK(7, 0);
> +			svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
>   			shift_byte++;
>   			for (i = j; i < svsb->opp_count; i++) {
>   				b_sft = BITS8 * (shift_byte % REG_BYTES);
> @@ -852,7 +909,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
>   		if (svsb->type == SVSB_HIGH) {
>   			/* volt[0] + volt[j] ~ volt[turn_pt - 1] */
>   			j = turn_pt - 7;
> -			svsb->volt[0] = vop30 & GENMASK(7, 0);
> +			svsb->volt[0] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
>   			shift_byte++;
>   			for (i = j; i < turn_pt; i++) {
>   				b_sft = BITS8 * (shift_byte % REG_BYTES);
> @@ -989,16 +1046,16 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
>   		return;
>   
>   	temp = svs_readl_relaxed(svsp, VOP74);
> -	svsb->volt[14] = (temp >> 24) & GENMASK(7, 0);
> -	svsb->volt[12] = (temp >> 16) & GENMASK(7, 0);
> -	svsb->volt[10] = (temp >> 8)  & GENMASK(7, 0);
> -	svsb->volt[8] = (temp & GENMASK(7, 0));
> +	svsb->volt[14] = FIELD_GET(SVSB_VOPS_FLD_VOP3_7, temp);
> +	svsb->volt[12] = FIELD_GET(SVSB_VOPS_FLD_VOP2_6, temp);
> +	svsb->volt[10] = FIELD_GET(SVSB_VOPS_FLD_VOP1_5, temp);
> +	svsb->volt[8] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, temp);
>   
>   	temp = svs_readl_relaxed(svsp, VOP30);
> -	svsb->volt[6] = (temp >> 24) & GENMASK(7, 0);
> -	svsb->volt[4] = (temp >> 16) & GENMASK(7, 0);
> -	svsb->volt[2] = (temp >> 8)  & GENMASK(7, 0);
> -	svsb->volt[0] = (temp & GENMASK(7, 0));
> +	svsb->volt[6] = FIELD_GET(SVSB_VOPS_FLD_VOP3_7, temp);
> +	svsb->volt[4] = FIELD_GET(SVSB_VOPS_FLD_VOP2_6, temp);
> +	svsb->volt[2] = FIELD_GET(SVSB_VOPS_FLD_VOP1_5, temp);
> +	svsb->volt[0] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, temp);
>   
>   	for (i = 0; i <= 12; i += 2)
>   		svsb->volt[i + 1] = interpolate(svsb->freq_pct[i],
> @@ -1046,20 +1103,20 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
>   static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb = svsp->pbank;
> +	u32 freqpct74_val, freqpct30_val;
> +
> +	freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT1_5, svsb->freq_pct[10]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT2_6, svsb->freq_pct[12]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT3_7, svsb->freq_pct[14]);
> +
> +	freqpct30_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[0]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT1_5, svsb->freq_pct[2]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT2_6, svsb->freq_pct[4]) |
> +			FIELD_PREP(SVSB_FREQPCTS_FLD_PCT3_7, svsb->freq_pct[6]);
>   
> -	svs_writel_relaxed(svsp,
> -			   (svsb->freq_pct[14] << 24) |
> -			   (svsb->freq_pct[12] << 16) |
> -			   (svsb->freq_pct[10] << 8) |
> -			   svsb->freq_pct[8],
> -			   FREQPCT74);
> -
> -	svs_writel_relaxed(svsp,
> -			   (svsb->freq_pct[6] << 24) |
> -			   (svsb->freq_pct[4] << 16) |
> -			   (svsb->freq_pct[2] << 8) |
> -			   svsb->freq_pct[0],
> -			   FREQPCT30);
> +	svs_writel_relaxed(svsp, freqpct74_val, FREQPCT74);
> +	svs_writel_relaxed(svsp, freqpct30_val, FREQPCT30);
>   }
>   
>   static void svs_set_bank_phase(struct svs_platform *svsp,
> @@ -1070,13 +1127,17 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
>   
>   	svs_switch_bank(svsp);
>   
> -	des_char = (svsb->bdes << 8) | svsb->mdes;
> +	des_char = FIELD_PREP(SVSB_DESCHAR_FLD_BDES, svsb->bdes) |
> +		   FIELD_PREP(SVSB_DESCHAR_FLD_MDES, svsb->mdes);
>   	svs_writel_relaxed(svsp, des_char, DESCHAR);
>   
> -	temp_char = (svsb->vco << 16) | (svsb->mtdes << 8) | svsb->dvt_fixed;
> +	temp_char = FIELD_PREP(SVSB_TEMPCHAR_FLD_VCO, svsb->vco) |
> +		    FIELD_PREP(SVSB_TEMPCHAR_FLD_MTDES, svsb->mtdes) |
> +		    FIELD_PREP(SVSB_TEMPCHAR_FLD_DVT_FIXED, svsb->dvt_fixed);
>   	svs_writel_relaxed(svsp, temp_char, TEMPCHAR);
>   
> -	det_char = (svsb->dcbdet << 8) | svsb->dcmdet;
> +	det_char = FIELD_PREP(SVSB_DETCHAR_FLD_DCBDET, svsb->dcbdet) |
> +		   FIELD_PREP(SVSB_DETCHAR_FLD_DCMDET, svsb->dcmdet);
>   	svs_writel_relaxed(svsp, det_char, DETCHAR);
>   
>   	svs_writel_relaxed(svsp, svsb->dc_config, DCCONFIG);
> @@ -1085,33 +1146,37 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
>   
>   	svsb->set_freq_pct(svsp);
>   
> -	limit_vals = (svsb->vmax << 24) | (svsb->vmin << 16) |
> -		     (SVSB_DTHI << 8) | SVSB_DTLO;
> +	limit_vals = FIELD_PREP(SVSB_LIMITVALS_FLD_DTLO, SVSB_VAL_DTLO) |
> +		     FIELD_PREP(SVSB_LIMITVALS_FLD_DTHI, SVSB_VAL_DTHI) |
> +		     FIELD_PREP(SVSB_LIMITVALS_FLD_VMIN, svsb->vmin) |
> +		     FIELD_PREP(SVSB_LIMITVALS_FLD_VMAX, svsb->vmax);
>   	svs_writel_relaxed(svsp, limit_vals, LIMITVALS);
>   
>   	svs_writel_relaxed(svsp, SVSB_DET_WINDOW, DETWINDOW);
>   	svs_writel_relaxed(svsp, SVSB_DET_MAX, CONFIG);
>   	svs_writel_relaxed(svsp, svsb->chk_shift, CHKSHIFT);
>   	svs_writel_relaxed(svsp, svsb->ctl0, CTL0);
> -	svs_writel_relaxed(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
>   
>   	switch (target_phase) {
>   	case SVSB_PHASE_INIT01:
>   		svs_writel_relaxed(svsp, svsb->vboot, VBOOT);
>   		svs_writel_relaxed(svsp, SVSB_INTEN_INIT0x, INTEN);
> -		svs_writel_relaxed(svsp, SVSB_EN_INIT01, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_INIT01, SVSEN);
>   		break;
>   	case SVSB_PHASE_INIT02:
> +		init2vals = FIELD_PREP(SVSB_INIT2VALS_FLD_AGEVOFFSETIN, svsb->age_voffset_in) |
> +			    FIELD_PREP(SVSB_INIT2VALS_FLD_DCVOFFSETIN, svsb->dc_voffset_in);
>   		svs_writel_relaxed(svsp, SVSB_INTEN_INIT0x, INTEN);
> -		init2vals = (svsb->age_voffset_in << 16) | svsb->dc_voffset_in;
>   		svs_writel_relaxed(svsp, init2vals, INIT2VALS);
> -		svs_writel_relaxed(svsp, SVSB_EN_INIT02, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_INIT02, SVSEN);
>   		break;
>   	case SVSB_PHASE_MON:
> -		ts_calcs = (svsb->bts << 12) | svsb->mts;
> +		ts_calcs = FIELD_PREP(SVSB_TSCALCS_FLD_BTS, svsb->bts) |
> +			   FIELD_PREP(SVSB_TSCALCS_FLD_MTS, svsb->mts);
>   		svs_writel_relaxed(svsp, ts_calcs, TSCALCS);
>   		svs_writel_relaxed(svsp, SVSB_INTEN_MONVOPEN, INTEN);
> -		svs_writel_relaxed(svsp, SVSB_EN_MON, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_MON, SVSEN);
>   		break;
>   	default:
>   		dev_err(svsb->dev, "requested unknown target phase: %u\n",
> @@ -1147,8 +1212,8 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
>   	svs_save_bank_register_data(svsp, SVSB_PHASE_ERROR);
>   
>   	svsb->phase = SVSB_PHASE_ERROR;
> -	svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
> -	svs_writel_relaxed(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
>   }
>   
>   static inline void svs_init01_isr_handler(struct svs_platform *svsp)
> @@ -1173,8 +1238,8 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
>   	svsb->age_voffset_in = svs_readl_relaxed(svsp, AGEVALUES) &
>   			       GENMASK(15, 0);
>   
> -	svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
> -	svs_writel_relaxed(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_F0_COMPLETE, INTSTS);
>   	svsb->core_sel &= ~SVSB_DET_CLK_EN;
>   }
>   
> @@ -1192,8 +1257,8 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
>   	svsb->phase = SVSB_PHASE_INIT02;
>   	svsb->get_volts(svsp);
>   
> -	svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
> -	svs_writel_relaxed(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_F0_COMPLETE, INTSTS);
>   }
>   
>   static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
> @@ -1206,7 +1271,7 @@ static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
>   	svsb->get_volts(svsp);
>   
>   	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
> -	svs_writel_relaxed(svsp, SVSB_INTSTS_MONVOP, INTSTS);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_FLD_MONVOP, INTSTS);
>   }
>   
>   static irqreturn_t svs_isr(int irq, void *data)
> @@ -1233,13 +1298,13 @@ static irqreturn_t svs_isr(int irq, void *data)
>   		int_sts = svs_readl_relaxed(svsp, INTSTS);
>   		svs_en = svs_readl_relaxed(svsp, SVSEN);
>   
> -		if (int_sts == SVSB_INTSTS_COMPLETE &&
> -		    svs_en == SVSB_EN_INIT01)
> +		if (int_sts == SVSB_INTSTS_F0_COMPLETE &&
> +		    svs_en == SVSB_PTPEN_INIT01)
>   			svs_init01_isr_handler(svsp);
> -		else if (int_sts == SVSB_INTSTS_COMPLETE &&
> -			 svs_en == SVSB_EN_INIT02)
> +		else if (int_sts == SVSB_INTSTS_F0_COMPLETE &&
> +			 svs_en == SVSB_PTPEN_INIT02)
>   			svs_init02_isr_handler(svsp);
> -		else if (int_sts & SVSB_INTSTS_MONVOP)
> +		else if (int_sts & SVSB_INTSTS_FLD_MONVOP)
>   			svs_mon_mode_isr_handler(svsp);
>   		else
>   			svs_error_isr_handler(svsp);
> @@ -1525,8 +1590,8 @@ static int svs_suspend(struct device *dev)
>   		spin_lock_irqsave(&svs_lock, flags);
>   		svsp->pbank = svsb;
>   		svs_switch_bank(svsp);
> -		svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
> -		svs_writel_relaxed(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
>   		spin_unlock_irqrestore(&svs_lock, flags);
>   
>   		svsb->phase = SVSB_PHASE_ERROR;
