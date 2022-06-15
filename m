Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44C54D3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiFOVek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346887AbiFOVei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:34:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4F562F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:34:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so25723867ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a6DtLTLobod88Vbu2Jz+rOYgvjfuQls0C5Gm8b+A/Tg=;
        b=rHCi8L1ybU8ft6fEpCxWYYb49UY3WV+YotC5AOOsPPjhfYdepujeSUDUs2hE2c8+eO
         3rgQ5vXsQVMw3stQDK4cPswZIKYh5HpDvV8QJyMxNTh6EEfts24NCrcpuZCj4wT1TTbd
         Aqwcv1WZHRhB8TzFGa8eq4On9gYoVUiki+cpQyWelUp5Mp6KOtYWECCVOYiM8e9cOrM+
         VykVKLMw6lz2/24nCE6dNZj2bZk3r7IsVHkmCb6P0oW1KQSGj24GwWptpafXr/oOgZT7
         M0tJaT8d5ZGQMv8esLVpXc22gVoGGTU8RolAeSx5WTnpN6oRizpFyThBqu4g1kP8WxvP
         GeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a6DtLTLobod88Vbu2Jz+rOYgvjfuQls0C5Gm8b+A/Tg=;
        b=H5PEqAO+xXPL9i0zXHLxSED9Kt2z0nFvfG1Dt7KJZO3kOWEpm43jmox71xDKLXBHg2
         1WS4qKHctuH+/7nHSFcIucoaMFePznXkqEOcfOvwBhIpPsBtoB4YEn331yXoQKb/KlPo
         O7Bi4KB/4PzaIrzTq2kYuBHZ8on1qOCztpoXoDuRsOruPomCtyWYiqP3s+GN6FguwOHq
         7T/v2p+U6Hsv5YRmi0YEKzzfWkuXwdcioiIilfKLa8MhPXVVv2SAPCjXoNqMohq4Xjjf
         Bsh8pRzb8STApykAq9pcOn/a+iMcCBx6nrk/CjOJ8axNdMtZckOpM2S+jbwiUNzaLVyr
         QQcg==
X-Gm-Message-State: AJIora+ly6BUC3RWJtRdScw63XtAtTfQ/YWIS6+00NA89yJrRUrk4/nY
        YYXEBhpDg5fHveNHzUSG6HVmxA==
X-Google-Smtp-Source: AGRyM1sEaypWaSZznLFeKudXK3MocASE9sGxcs+HiLloGXAClszGFSbbgDZrUFR9E2nyOzY719LLug==
X-Received: by 2002:a17:906:3e96:b0:711:5a8:5081 with SMTP id a22-20020a1709063e9600b0071105a85081mr1709484ejj.703.1655328874660;
        Wed, 15 Jun 2022 14:34:34 -0700 (PDT)
Received: from [192.168.1.12] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id u9-20020aa7d0c9000000b00433b5f22864sm248667edo.20.2022.06.15.14.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 14:34:33 -0700 (PDT)
Message-ID: <8a9a253a-de0a-eaa5-3b36-22fa817502a3@linaro.org>
Date:   Thu, 16 Jun 2022 00:34:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: venus: set ubwc configuration on specific video
 hardware
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        frkoenig@chromium.org, quic_dikshita@quicinc.com
References: <1651225672-32243-1-git-send-email-quic_vgarodia@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <1651225672-32243-1-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

Thanks for the patch! Few minor comments below.

On 4/29/22 12:47, Vikash Garodia wrote:
> UBWC configuration parameters would vary across video hardware
> generations. At the same time, driver is expected to configure
> these parameters, without relying on video firmware to use the
> default configurations.
> Setting the configuration parameters for sc7280.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  5 +++
>  drivers/media/platform/qcom/venus/core.h       | 18 +++++++++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  9 +++++
>  drivers/media/platform/qcom/venus/hfi_cmds.h   |  1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h | 20 ++++++++++
>  drivers/media/platform/qcom/venus/hfi_venus.c  | 54 ++++++++++++++++++++++++++
>  6 files changed, 107 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 877eca1..75d8e14 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -832,6 +832,10 @@ static const struct reg_val sm7280_reg_preset[] = {
>  	{ 0xb0088, 0 },
>  };
>  
> +static const struct ubwc_config sc7280_ubwc_config[] = {

ubwc_config shouldn't be an array, right?

> +	{{1, 1, 1, 0, 0, 0}, 8, 32, 14, 0, 0},
> +};
> +
>  static const struct venus_resources sc7280_res = {
>  	.freq_tbl = sc7280_freq_table,
>  	.freq_tbl_size = ARRAY_SIZE(sc7280_freq_table),
> @@ -841,6 +845,7 @@ static const struct venus_resources sc7280_res = {
>  	.bw_tbl_enc_size = ARRAY_SIZE(sc7280_bw_table_enc),
>  	.bw_tbl_dec = sc7280_bw_table_dec,
>  	.bw_tbl_dec_size = ARRAY_SIZE(sc7280_bw_table_dec),
> +	.ubwc_conf = sc7280_ubwc_config,
>  	.clks = {"core", "bus", "iface"},
>  	.clks_num = 3,
>  	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index c3023340..ef71462 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -47,6 +47,23 @@ struct bw_tbl {
>  	u32 peak_10bit;
>  };
>  
> +struct ubwc_config {

I think it will be better to reuse stuct hfi_ubwc_config from
hfi_helper.h. This will also simplify venus_sys_set_ubwc_config() body.

> +	struct {
> +		u32 max_channel_override : 1;
> +		u32 mal_length_override : 1;
> +		u32 hb_override : 1;
> +		u32 bank_swzl_level_override : 1;
> +		u32 bank_spreading_override : 1;
> +		u32 reserved : 27;
> +	} override_bit_info;
> +
> +	u32 max_channels;
> +	u32 mal_length;
> +	u32 highest_bank_bit;
> +	u32 bank_swzl_level;
> +	u32 bank_spreading;
> +};
> +
>  struct venus_resources {
>  	u64 dma_mask;
>  	const struct freq_tbl *freq_tbl;
> @@ -57,6 +74,7 @@ struct venus_resources {
>  	unsigned int bw_tbl_dec_size;
>  	const struct reg_val *reg_tbl;
>  	unsigned int reg_tbl_size;
> +	const struct ubwc_config *ubwc_conf;
>  	const char * const clks[VIDC_CLKS_NUM_MAX];
>  	unsigned int clks_num;
>  	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 4ecd444..036eaca 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -58,6 +58,15 @@ void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode)
>  	pkt->data[1] = mode;
>  }
>  
> +void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct hfi_ubwc_config *hfi)
> +{
> +	pkt->hdr.size = struct_size(pkt, data, 1) + sizeof(*hfi);
> +	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
> +	pkt->num_properties = 1;
> +	pkt->data[0] = HFI_PROPERTY_SYS_UBWC_CONFIG;
> +	memcpy(&pkt->data[1], hfi, sizeof(*hfi));
> +}
> +
>  int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
>  			 u32 addr, void *cookie)
>  {
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index 327ed90..ce7179e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -256,6 +256,7 @@ void pkt_sys_init(struct hfi_sys_init_pkt *pkt, u32 arch_type);
>  void pkt_sys_pc_prep(struct hfi_sys_pc_prep_pkt *pkt);
>  void pkt_sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable);
>  void pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable);
> +void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct hfi_ubwc_config *hfi);
>  int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
>  			 u32 addr, void *cookie);
>  int pkt_sys_unset_resource(struct hfi_sys_release_resource_pkt *pkt, u32 id,
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 2daa88e..d2d6719 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -427,6 +427,7 @@
>  #define HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL			0x5
>  #define HFI_PROPERTY_SYS_IMAGE_VERSION				0x6
>  #define HFI_PROPERTY_SYS_CONFIG_COVERAGE			0x7
> +#define HFI_PROPERTY_SYS_UBWC_CONFIG				0x8
>  
>  /*
>   * HFI_PROPERTY_PARAM_COMMON_START
> @@ -626,6 +627,25 @@ struct hfi_debug_config {
>  	u32 mode;
>  };
>  
> +struct hfi_ubwc_config {
> +	u32 size;
> +	u32 packet_type;
> +	struct {
> +		u32 max_channel_override : 1;
> +		u32 mal_length_override : 1;
> +		u32 hb_override : 1;
> +		u32 bank_swzl_level_override : 1;
> +		u32 bank_spreading_override : 1;
> +		u32 reserved : 27;
> +		} override_bit_info;

Could you align '}'

> +	u32 max_channels;
> +	u32 mal_length;
> +	u32 highest_bank_bit;
> +	u32 bank_swzl_level;
> +	u32 bank_spreading;
> +	u32 reserved[2];
> +};
> +
>  struct hfi_enable {
>  	u32 enable;
>  };
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 3a75a27..fa0fc91 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -904,6 +904,52 @@ static int venus_sys_set_power_control(struct venus_hfi_device *hdev,
>  	return 0;
>  }
>  
> +static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
> +{
> +	struct hfi_sys_set_property_pkt *pkt;
> +	u8 packet[IFACEQ_VAR_SMALL_PKT_SIZE];
> +	struct hfi_ubwc_config *hfi;
> +	const struct venus_resources *res = hdev->core->res;
> +	const struct ubwc_config *ubwc_conf = res->ubwc_conf;
> +	int ret;
> +
> +	hfi = kzalloc(sizeof(*hfi), GFP_KERNEL);

You don't need to allocate memory, struct hfi_ubwc_config could be in stack.

> +	if (!hfi)
> +		return -ENOMEM;
> +
> +	pkt = (struct hfi_sys_set_property_pkt *)packet;
> +
> +	hfi->max_channels = ubwc_conf->max_channels;
> +	hfi->override_bit_info.max_channel_override =
> +		ubwc_conf->override_bit_info.max_channel_override;
> +
> +	hfi->mal_length = ubwc_conf->mal_length;
> +	hfi->override_bit_info.mal_length_override =
> +		ubwc_conf->override_bit_info.mal_length_override;
> +
> +	hfi->highest_bank_bit = ubwc_conf->highest_bank_bit;
> +	hfi->override_bit_info.hb_override =
> +		ubwc_conf->override_bit_info.hb_override;
> +
> +	hfi->bank_swzl_level = ubwc_conf->bank_swzl_level;
> +	hfi->override_bit_info.bank_swzl_level_override =
> +		ubwc_conf->override_bit_info.bank_swzl_level_override;
> +
> +	hfi->bank_spreading = ubwc_conf->bank_spreading;
> +	hfi->override_bit_info.bank_spreading_override =
> +		ubwc_conf->override_bit_info.bank_spreading_override;
> +
> +	pkt_sys_ubwc_config(pkt, hfi);
> +
> +	kfree(hfi);
> +
> +	ret = venus_iface_cmdq_write(hdev, pkt, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int venus_get_queue_size(struct venus_hfi_device *hdev,
>  				unsigned int index)
>  {
> @@ -922,6 +968,7 @@ static int venus_get_queue_size(struct venus_hfi_device *hdev,
>  static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
>  {
>  	struct device *dev = hdev->core->dev;
> +	const struct venus_resources *res = hdev->core->res;
>  	int ret;
>  
>  	ret = venus_sys_set_debug(hdev, venus_fw_debug);
> @@ -945,6 +992,13 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
>  		dev_warn(dev, "setting hw power collapse ON failed (%d)\n",
>  			 ret);
>  
> +	/* For specific venus core, it is mandatory to set the UBWC configuration */
> +	if (res->ubwc_conf) {
> +		ret = venus_sys_set_ubwc_config(hdev);
> +		if (ret)
> +			dev_warn(dev, "setting ubwc config failed (%d)\n", ret);
> +	}
> +
>  	return ret;
>  }
>  

-- 
regards,
Stan
