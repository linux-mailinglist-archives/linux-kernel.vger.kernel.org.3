Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372BE50B665
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447154AbiDVLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380235AbiDVLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:51:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22941FAA;
        Fri, 22 Apr 2022 04:48:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c10so10707777wrb.1;
        Fri, 22 Apr 2022 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=USB9sQq04sTiAxmM8QQ7srYcUe8WlCh4HajD9OSYJ6o=;
        b=NzIx/QXqWbn00uU3BKoOzzQ56jbjOJFxXvcFNZMrrnkUcYyLYKtefdD4B78DxLpyqy
         qUQ9OjzuQBnOr/NBhm5cq4zASqJLzRaB1X5ETy+ZBJCgwVFkK/zrUXnkdQ9B8d3l77C+
         bao0jbWUFczaF4rNJfcMB7mdp/yMwDyP4KyXyd6As4FJx7vPiMZUMGrAjKQPVv35LQJj
         GqAET5OL4PFyFr7gaAn9/AhWfCWTSGI2nmpvnnI9E/dHu5T50OtUb/zQmZdaohc7UcqI
         /eW15+8FEZei1tw7AoLxovxndZxe2RiSJ7Vha7VoigGvm5EavC4yPYXHvGFfC+G+Atct
         EL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=USB9sQq04sTiAxmM8QQ7srYcUe8WlCh4HajD9OSYJ6o=;
        b=EH6w5il3tp1KTM58yRNLyANmFzqI4pGgitZd8kaPpiY0YKtCtoTEX7gmgdnlTqvKvP
         zEATzJzbSdhC4g3+R+Wnz9mq545ZjlB7G2KtkV9C53eiMR+EUKFd6I/XleOLFKj+Ta6T
         rWytwqKBKHbKgDIrXW/4JR1IgLQUnigTMah7OSt1pCjlI/jVnehOtauvvxIoOFlHZCad
         QFznAncxQpll/T1Pr/093y5wQVBKPr634Cl+ECc+z2PAJNE+FV2XJJPXAhe1QDMwOokO
         +9ancQ4AX/40slyS33w9MFXTdfhRQ6sJst65cpahdYO5vG+/ALagXANK5Xlf/883xJOo
         /oHg==
X-Gm-Message-State: AOAM531TgsTt8/ixLj409qobkSTyro9E95EQj/VX5OTY4Rf11q2rlDPV
        ZKURLH30x5t6+0pYEVOodzY=
X-Google-Smtp-Source: ABdhPJxnLaVOa0YHXafmOZJInj59XC4WGJzkGDmdMfbuZG+DNqLpxPS7LhSSaxyFsScgD1taCf5JDw==
X-Received: by 2002:a5d:6486:0:b0:20a:93fe:dd09 with SMTP id o6-20020a5d6486000000b0020a93fedd09mr3483295wri.436.1650628103145;
        Fri, 22 Apr 2022 04:48:23 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0038ebcbadcedsm5107504wmn.2.2022.04.22.04.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:48:22 -0700 (PDT)
Message-ID: <2cd07faf-e903-e55b-85c1-ce7a823ddb8b@gmail.com>
Date:   Fri, 22 Apr 2022 13:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 11/21] drm/mediatek: add display merge start/stop API
 for cmdq support
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220416020749.29010-1-nancy.lin@mediatek.com>
 <20220416020749.29010-12-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220416020749.29010-12-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2022 04:07, Nancy.Lin wrote:
> Add merge start/stop API for cmdq support. The ovl_adaptor merges
> are configured with each drm plane update. Need to enable/disable
> merge with cmdq making sure all the settings taken effect in the
> same vblank.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  2 ++
>   drivers/gpu/drm/mediatek/mtk_disp_merge.c | 20 +++++++++++++++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index 53aa988dde3b..43a412525b75 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -66,6 +66,8 @@ void mtk_merge_stop(struct device *dev);
>   void mtk_merge_advance_config(struct device *dev, unsigned int l_w, unsigned int r_w,
>   			      unsigned int h, unsigned int vrefresh, unsigned int bpc,
>   			      struct cmdq_pkt *cmdq_pkt);
> +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt);
> +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt);
>   
>   void mtk_ovl_bgclr_in_on(struct device *dev);
>   void mtk_ovl_bgclr_in_off(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> index 40da0555416d..c0d9b43b2a66 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> @@ -67,17 +67,31 @@ struct mtk_disp_merge {
>   };
>   
>   void mtk_merge_start(struct device *dev)

Probably not my call, but wouldn't it make sense to enhance mtk_merge_start to 
pass 'struct cmdq_pkt *cmdq_pkt' directly instead of adding this 'adapter'?

In the end this is up to Chun-Kuang.

Regards,
Matthias

> +{
> +	mtk_merge_start_cmdq(dev, NULL);
> +}
> +
> +void mtk_merge_stop(struct device *dev)
>   {
>   	struct mtk_disp_merge *priv = dev_get_drvdata(dev);
>   
> -	writel(MERGE_EN, priv->regs + DISP_REG_MERGE_CTRL);
> +	mtk_merge_stop_cmdq(dev, NULL);
>   }
>   
> -void mtk_merge_stop(struct device *dev)
> +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_merge *priv = dev_get_drvdata(dev);
> +
> +	mtk_ddp_write(cmdq_pkt, 1, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_MERGE_CTRL);
> +}
> +
> +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
>   {
>   	struct mtk_disp_merge *priv = dev_get_drvdata(dev);
>   
> -	writel(0x0, priv->regs + DISP_REG_MERGE_CTRL);
> +	mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_MERGE_CTRL);
>   }
>   
>   static void mtk_merge_fifo_setting(struct mtk_disp_merge *priv,
