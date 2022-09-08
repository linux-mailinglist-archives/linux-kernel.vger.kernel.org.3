Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ACC5B205F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiIHOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIHOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:18:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD9D5736;
        Thu,  8 Sep 2022 07:18:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l14so14923360eja.7;
        Thu, 08 Sep 2022 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uqElwfgdSmRAbe1TxOgEvl0rGlU2m9x2RTPe61zpA7Y=;
        b=GQ1YLhDR+Js6JeGa+dmtWxbwMjFRcXEcSDp2cUdAhNThPTEy0/xPN4uWvWuT4U+HDL
         Tv/q/CyaTZntmCMLEjqeNnv97WYrHr6rxOR/yVg3PGUl0rmaOeAdti3Ur0fxekkTJ8/8
         yjmx/Xed42Qt7b7V+1XsVyb/fH4sw3dDcAeuQ2eR2Xo/U0pnKs7I5w+2cTEVZmnXn7sM
         joSGkZf1lGage7BsJOd33pUf7ELB9v/tN0Acic+U4CQ2c5xI19FuOc0I+CXFzY6UpQ6U
         YdFkg0igv0w5Af7PuCgf+/utcCDq22gHGdhZrfPbJ3fUjHK7s1mzPXXeytOQxH6RKi2f
         cynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uqElwfgdSmRAbe1TxOgEvl0rGlU2m9x2RTPe61zpA7Y=;
        b=CW2sPR/zp55HnB5VNseGiWS/dyxCV2B1FeLAKQil8U6OhZTmvlto8wlaqSIlLIQg5c
         9nJ0mvq5IJbQWR+mG38Tww0k7JJSMRiT6RcVGqMTgVjxuHbJEFWfSMDA4XDx361FamzI
         NTfquiocvUSuPzZakUX3fqceuQ48QIHxTEff2e/gc/nrCpwRj6P/+KLQ8D8ANKuz7ByB
         6LptWav9Gvvd3ixneM3T1OgZF+ZO/sH5xE0iG5301jbPcW8O9UXibrYY01TwvEXKd32k
         ftEZoGb1/RxwSqQaocbqzQCF2EwHCEr6ZuHBqni4tHF+6eGn5Xf2XDvGjd+az5N25Tc1
         Z+UA==
X-Gm-Message-State: ACgBeo2sYGT/Kzz/T1LVbOvORAVKEAQUtzngrJFjtV2oyd3KkCBJSBAt
        +oeH0/adpRKuIFucFEEpJC6+qlJEmPA=
X-Google-Smtp-Source: AA6agR7qDdqjQwHSmkOGWVFjGIbsnQAb7euDyigcbVZwCBgLje0vwmAqMisXPFAW+X+k+wUu7pa+1w==
X-Received: by 2002:a17:907:2c41:b0:741:4906:482b with SMTP id hf1-20020a1709072c4100b007414906482bmr6062420ejc.239.1662646721196;
        Thu, 08 Sep 2022 07:18:41 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00764a76d5888sm1290016ejh.27.2022.09.08.07.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:18:39 -0700 (PDT)
Message-ID: <10a9c90d-aacf-5283-526d-b3ae42b86ea3@gmail.com>
Date:   Thu, 8 Sep 2022 16:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/mediatek: Fix wrong dither settings
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
References: <20220908141205.18256-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220908141205.18256-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2022 16:12, Allen-KH Cheng wrote:
> The width and height arguments in the cmdq packet for mtk_dither_config()
> are inverted. We fix the incorrect width and height for dither settings
> in mtk_dither_config().
> 
> Fixes: 73d3724745db ("drm/mediatek: Adjust to the alphabetic order for mediatek-drm")
> Co-developed-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 2d72cc5ddaba..6b6d5335c834 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -157,7 +157,7 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
>   {
>   	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
>   
> -	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_REG_DITHER_SIZE);
> +	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs, DISP_REG_DITHER_SIZE);
>   	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs,
>   		      DISP_REG_DITHER_CFG);
>   	mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, DISP_REG_DITHER_CFG,
