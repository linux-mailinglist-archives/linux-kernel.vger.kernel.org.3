Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86C523AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiEKQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiEKQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:54:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184C644F0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:54:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so4622531lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+5747A4Ma391dQmFsOLvwVUU2kapbuzWaQTGm/dKdZQ=;
        b=NrZRAu/N5s8gpBmN+NE8JE4qm599tse0FE4/hUcxD2dduSKW9wcjqAwCyx+phX7hhI
         OFZAunZ8ixiWs41Nk0IJ9xuGMr1PVNayB8zF7g3Wvo0Cj5R1D1Tq3P6fLdJ6buieL0Ex
         98NpfA2mqbzQdhJKWE64l0nc2GXlZBY4lseJ1h3KiqC7bZnuQqWzQi9on+uQadEQw69T
         t9u6X6xV3OwjOch09fv1bYhhdzmPkwetJduP2qksKYuU9hQQCfbMNI3jN5oJsGbxFWLB
         XlomA+rUzeI4poH8sHTs4MnmUwj09JpTlohRPR0JJrfKjyvMyvgA/ad8e6RyPZRHzqAy
         SGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+5747A4Ma391dQmFsOLvwVUU2kapbuzWaQTGm/dKdZQ=;
        b=0Z6E//f6uEbOuKQ/oHRP6/2srvSXkE7buuuSi9EQQNt/3ouylHkKPM0JZL0cQJp2aD
         pinlqRcnwbc/XgVlJDQpYtBBdr45H/XMWpa86PYZdXek/Xw45gE0RMaW1hJbiaDqDeFm
         xqdVBGr/P8j9nqaCFTXMh9bXu1U4xi9dyuUo5sJCPAsKIOO0Sg/+qKhMslvlGENm+MVx
         iSApYivKaX0hdg+sJ6Ibr6UoEeLKpBPa4UJU+ZDZdU2J7Vmz71EKDdafnYfXJCAmW+ZU
         iMMWKZjF+n5iab7Kz1bpnkAVOwtDyxq3wrFSIGU/4PngG4Ryhrkl+z0x7Rbqw1ZkLTcV
         9IGQ==
X-Gm-Message-State: AOAM532aIpyYGaPNi2rB2lVXQJhwHcBwHMaAG3Z0yaLHXPgvM5Dk4RaQ
        hvVhqd1J+IeZ/0MqMwxOA4+0iQ==
X-Google-Smtp-Source: ABdhPJye2LWKIIWro0fjrmR+DnWvSvOo9wamkKGElpGs2OZ2l4JsOJdVTsjMmwDwZYXwdSRzw9Q0cA==
X-Received: by 2002:a05:6512:2391:b0:473:ac1e:f2ce with SMTP id c17-20020a056512239100b00473ac1ef2cemr20756190lfv.297.1652288081314;
        Wed, 11 May 2022 09:54:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id dt5-20020a0565122a8500b0047255d2119csm354662lfb.203.2022.05.11.09.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:54:40 -0700 (PDT)
Message-ID: <1d43e1fa-30b2-dbf0-bfaf-f9cfaf987efb@linaro.org>
Date:   Wed, 11 May 2022 19:54:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/9] remoteproc: qcom: q6v5-mss: Add modem support on
 MSM8953
Content-Language: en-GB
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-3-sireeshkodali1@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220511161602.117772-3-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 19:15, Sireesh Kodali wrote:
> The modem on the MSM8953 platform is similar to the modem on the MSM8996
> platform in terms of set up. It differs primarily in the way it needs SCM
> to bless the MPSS firmware region.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>   drivers/remoteproc/qcom_q6v5_mss.c | 64 +++++++++++++++++++++++++++---
>   1 file changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index af217de75e4d..a73fdcddeda4 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -234,6 +234,7 @@ struct q6v5 {
>   
>   enum {
>   	MSS_MSM8916,
> +	MSS_MSM8953,
>   	MSS_MSM8974,
>   	MSS_MSM8996,
>   	MSS_MSM8998,
> @@ -687,12 +688,14 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>   		}
>   		goto pbl_wait;
>   	} else if (qproc->version == MSS_MSM8996 ||
> -		   qproc->version == MSS_MSM8998) {
> +		   qproc->version == MSS_MSM8998 ||
> +		   qproc->version == MSS_MSM8953) {
>   		int mem_pwr_ctl;
>   
>   		/* Override the ACC value if required */
> -		writel(QDSP6SS_ACC_OVERRIDE_VAL,
> -		       qproc->reg_base + QDSP6SS_STRAP_ACC);
> +		if (qproc->version != MSS_MSM8953)
> +			writel(QDSP6SS_ACC_OVERRIDE_VAL,
> +					qproc->reg_base + QDSP6SS_STRAP_ACC);
>   
>   		/* Assert resets, stop core */
>   		val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
> @@ -734,7 +737,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>   		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>   
>   		/* Turn on L1, L2, ETB and JU memories 1 at a time */
> -		if (qproc->version == MSS_MSM8996) {
> +		if (qproc->version == MSS_MSM8996 ||
> +			qproc->version == MSS_MSM8953) {
>   			mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
>   			i = 19;
>   		} else {
> @@ -1314,7 +1318,16 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>   			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
>   	}
>   
> -	/*
> +	if (qproc->version == MSS_MSM8953) {
> +		ret = qcom_scm_pas_mem_setup(5, qproc->mpss_phys, qproc->mpss_size);
> +		if (ret) {
> +			dev_err(qproc->dev,
> +					"setting up mpss memory failed: %d\n", ret);
> +			goto release_firmware;
> +		}
> +	}
> +
> +	/**

Single star please

>   	 * In case of a modem subsystem restart on secure devices, the modem
>   	 * memory can be reclaimed only after MBA is loaded.
>   	 */
> @@ -1413,7 +1426,6 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>   			writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
>   		}
>   		writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
> -
>   		ret = readl(qproc->rmb_base + RMB_MBA_STATUS_REG);
>   		if (ret < 0) {
>   			dev_err(qproc->dev, "MPSS authentication failed: %d\n",
> @@ -1422,6 +1434,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>   		}
>   	}
>   
> +

Unnecessary


>   	/* Transfer ownership of modem ddr region to q6 */
>   	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, true,
>   				      qproc->mpss_phys, qproc->mpss_size);
> @@ -2198,6 +2211,44 @@ static const struct rproc_hexagon_res msm8996_mss = {
>   	.version = MSS_MSM8996,
>   };
>   
> +static const struct rproc_hexagon_res msm8953_mss = {
> +	.hexagon_mba_image = "mba.mbn",
> +	.proxy_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "pll",
> +			.uA = 100000,
> +		},
> +		{}
> +	},
> +	.proxy_pd_names = (char*[]) {
> +			"cx",
> +			"mx",
> +			NULL
> +	},
> +	.active_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "mss",
> +			.uV = 1050000,
> +			.uA = 100000,
> +		},
> +		{}
> +	},
> +	.proxy_clk_names = (char*[]){
> +			"xo",
> +			NULL
> +	},
> +	.active_clk_names = (char*[]){
> +			"iface",
> +			"bus",
> +			"mem",
> +			NULL
> +	},
> +	.need_mem_protection = false,
> +	.has_alt_reset = false,
> +	.has_spare_reg = false,


Please follow the custom  and define the rest of fields here.

> +	.version = MSS_MSM8953,
> +};
> +
>   static const struct rproc_hexagon_res msm8916_mss = {
>   	.hexagon_mba_image = "mba.mbn",
>   	.proxy_supply = (struct qcom_mss_reg_res[]) {
> @@ -2301,6 +2352,7 @@ static const struct of_device_id q6v5_of_match[] = {
>   	{ .compatible = "qcom,msm8916-mss-pil", .data = &msm8916_mss},
>   	{ .compatible = "qcom,msm8974-mss-pil", .data = &msm8974_mss},
>   	{ .compatible = "qcom,msm8996-mss-pil", .data = &msm8996_mss},
> +	{ .compatible = "qcom,msm8953-mss-pil", .data = &msm8953_mss},
>   	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
>   	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
>   	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},


-- 
With best wishes
Dmitry
