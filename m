Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB74F9715
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiDHNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiDHNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:43:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403749F3E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:41:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w21so12938703wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ttnjxeFPtnBDvb8Dmwr7pVkOvTYYrY+X3dFBMwXdT3Y=;
        b=uCwSmY+ePMLZWlx2IqWzxlM4xato0/+QGD8xW8s506c56i6Phvjwf2CmIivbe3yS6w
         fcPXSkc5zW5rgCjHzdYh1A7hSxsPFAKabvn+vAROfC/ZTb8yXBku323RGXkMfJ5Wbzsu
         D3Yll8aXkE2q5GMplOjbZAMXoQOHTpRRI6oeAtElp8B1Hcn9PEtM0sbvoCZlsqp7eGXH
         zG9boZBRQBoFEKfgSAOH+FI2rFAKijM+GQmlgVgVkyYkynvaeT5aiSPZ/BiP58yq5VAc
         TS+g+H3xOAEwIxCV2p5n7etg9jJ+/VRU6rZvSmoDb7tyskiS9SLnxcaslbiWnHq1D8Pn
         dDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ttnjxeFPtnBDvb8Dmwr7pVkOvTYYrY+X3dFBMwXdT3Y=;
        b=T9FU5Wq5y35G6vy9Pm1dJBHD1v9Vj9Ebz8tyEx6ps484x6oktDdGCPiYvvugUI/KUL
         VfFR9+r5ZlEG/HMJ4x5M/SCsujSQisA/7L5uY9+QQ0WtksQFaEgCbBhD49iPfH064ypt
         cbgxVAM3HFFJON7opc2kO3FC0CCNsTLB6fgglQC/ghxTa2pXI0gB8GLAw65wLyrVaAOV
         3ydHetYBWQ5Jy6UyRxolYZCq1mOWNMfMSxm++08j2th0uuOybkgwSe+W6TWqMhXh73R2
         6FiWjs94cj6+1PIZqT2PsL50esk7iJwc3C5aL/fzQAeMFrmiItKleBBuZbPcAeOSmBme
         MN9w==
X-Gm-Message-State: AOAM530ggP1NYN/JSGGE0LUd+kdVU4/DxH5iBwmrBJYxhCsifcvhQOmZ
        D7pwbQWLVfPtZbPSdSKTHfaSqw==
X-Google-Smtp-Source: ABdhPJzZMmsiiLeNmisRgf/QerRPfZJDrPAsPV0vAyABh/txaHHIq4rGE5g6fUSveEUfpckt8rBRGA==
X-Received: by 2002:a5d:414b:0:b0:205:89b7:91bf with SMTP id c11-20020a5d414b000000b0020589b791bfmr14754373wrq.217.1649425298367;
        Fri, 08 Apr 2022 06:41:38 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm23576229wrb.8.2022.04.08.06.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:41:37 -0700 (PDT)
Message-ID: <4a6a4b70-3e24-3043-4e9d-f62e4798f28b@baylibre.com>
Date:   Fri, 8 Apr 2022 15:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/5] drm: bridge: dw_hdmi: cec: Add cec suspend/resume
 function
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
References: <cover.1649412256.git.Sandor.yu@nxp.com>
 <45739041a743cd435415ca53264678e57a653147.1649412256.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <45739041a743cd435415ca53264678e57a653147.1649412256.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:32, Sandor Yu wrote:
> CEC interrupt status/mask and logical address registers
> will be reset when device enter suspend.
> It will cause cec fail to work after device resume.
> Add CEC suspend/resume functions, reinitialize logical address registers
> and restore interrupt status/mask registers after resume.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 37 +++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> index c8f44bcb298a..ab176401b727 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -62,6 +62,10 @@ struct dw_hdmi_cec {
>   	bool rx_done;
>   	struct cec_notifier *notify;
>   	int irq;
> +
> +	u8 regs_polarity;
> +	u8 regs_mask;
> +	u8 regs_mute_stat0;
>   };
>   
>   static void dw_hdmi_write(struct dw_hdmi_cec *cec, u8 val, int offset)
> @@ -306,11 +310,44 @@ static int dw_hdmi_cec_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int __maybe_unused dw_hdmi_cec_resume(struct device *dev)
> +{
> +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> +
> +	/* Restore logical address */
> +	dw_hdmi_write(cec, cec->addresses & 255, HDMI_CEC_ADDR_L);
> +	dw_hdmi_write(cec, cec->addresses >> 8, HDMI_CEC_ADDR_H);
> +
> +	/* Restore interrupt status/mask register */
> +	dw_hdmi_write(cec, cec->regs_polarity, HDMI_CEC_POLARITY);
> +	dw_hdmi_write(cec, cec->regs_mask, HDMI_CEC_MASK);
> +	dw_hdmi_write(cec, cec->regs_mute_stat0, HDMI_IH_MUTE_CEC_STAT0);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
> +{
> +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> +
> +	/* store interrupt status/mask register */
> +	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> +	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
> +	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dw_hdmi_cec_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_cec_suspend, dw_hdmi_cec_resume)
> +};
> +
>   static struct platform_driver dw_hdmi_cec_driver = {
>   	.probe	= dw_hdmi_cec_probe,
>   	.remove	= dw_hdmi_cec_remove,
>   	.driver = {
>   		.name = "dw-hdmi-cec",
> +		.pm = &dw_hdmi_cec_pm,
>   	},
>   };
>   module_platform_driver(dw_hdmi_cec_driver);

As Hans said on v1, why don't you call dw_hdmi_cec_enable(cec->adap, false) in suspend and dw_hdmi_cec_enable(cec->adap, true) in resume ?

With this, CEC engine is not disabled on suspend.

Do you plan to use the engine from the suspend code ?

Neil
