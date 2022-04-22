Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B250B645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447114AbiDVLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447112AbiDVLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:40:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896CD546BB;
        Fri, 22 Apr 2022 04:37:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id b188so8678721oia.13;
        Fri, 22 Apr 2022 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0nCOrfzNKhvYlmx3RgltHl48oEpCFD6SLJ8DgS3uoYM=;
        b=LbeUwZubcq+D8Y58jDtmIVxFyrSD9uX6ZR3ZX5jQ3rF7Qb59Y/mwQjJjbWNhYTQUKL
         ILGh7Z7Eo8/CyxnvOrdZYUmkmw2whRPs44EPchxuExQfFv2rHXvmzsf3/6oy6ju22uMS
         cCn6qpt6Q/HcuEhL3b+2WLLYzZJ4pqcImDXp9VmyPIJNxGzLXmcs32G98RwqwdQeunUo
         qTIOH1iYp5kXJIQaqUM5ukSj8wpkPY4SrOnq2XOLayDvFh951rYujuksapJWvW/cFcuw
         0Ohhsnt621V7bIugtIHsOKxB5MbvD6lIwY2A79gD3qoAaJlBI/Zz7Yx3N27Bpfy/AL51
         2v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0nCOrfzNKhvYlmx3RgltHl48oEpCFD6SLJ8DgS3uoYM=;
        b=JpFgYmD7EXdvZ1tjp/r25Fp0sLZ6PXbibKR9VUZq/XHhivuMxYrNmMAYOs28u/Y9Sf
         bw/PqHUlwpAZucQ1wjrTu09ZPyt42nnZh0GN0BHwSy3Dp0efl2QAPH9acts4hpVNIIK8
         AQ2GFx2BS0bMuvP50tQHUjo7uDAPwTtwn+9goKOGHICFyvlMJ7lnoYfSENPVA2TH+195
         oLZmlmCdTH3cjJerJIxTIukw2AG++pwlLegAibhk17cuF5Qhmux0aaGXzfwhySbx4XpW
         O7segrZT5rDIrkTh3WBhShJvGv7iEBk9sx14EtMeia7EoV8TtSi2IJzLoTvYds+E2OsV
         FFSA==
X-Gm-Message-State: AOAM530gptC/5NBNsT2GotrF8gzpctQ9QHzwnwadyHnU1cIH2v4nGVLI
        Mx9h4a4eapoOzKQE/a8jsFM=
X-Google-Smtp-Source: ABdhPJxHqu9ZMth9CGSeX/zg/lNzvL96kt+ob/DI19LW4Zlx67zUGyxxgX9YpQoAqgQlerN3uqVDxg==
X-Received: by 2002:a05:6808:169e:b0:2f9:6119:d67f with SMTP id bb30-20020a056808169e00b002f96119d67fmr6308084oib.218.1650627452814;
        Fri, 22 Apr 2022 04:37:32 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b4-20020aca1b04000000b00322959f5251sm626427oib.26.2022.04.22.04.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:37:32 -0700 (PDT)
Message-ID: <eca7f22a-9a04-dd67-aaad-3cf64a909090@gmail.com>
Date:   Fri, 22 Apr 2022 13:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 06/21] soc: mediatek: add cmdq support of mtk-mmsys
 config API for mt8195 vdosys1
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
 <20220416020749.29010-7-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220416020749.29010-7-nancy.lin@mediatek.com>
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
> Add cmdq support for mtk-mmsys config API.
> The mmsys config register settings need to take effect with the other
> HW settings(like OVL_ADAPTOR...) at the same vblanking time.
> 
> If we use CPU to write the mmsys reg, we can't guarantee all the
> settings can be written in the same vblanking time.
> Cmdq is used for this purpose. We prepare all the related HW settings
> in one cmdq packet. The first command in the packet is "wait stream done",
> and then following with all the HW settings. After the cmdq packet is
> flush to GCE HW. The GCE waits for the "stream done event" to coming
> and then starts flushing all the HW settings. This can guarantee all
> the settings flush in the same vblanking.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c       | 50 ++++++++++++++++++--------
>   include/linux/soc/mediatek/mtk-mmsys.h | 15 +++++---
>   2 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 7b262cefef85..ea04aa2c3840 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -177,6 +177,7 @@ struct mtk_mmsys {
>   	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
>   	struct reset_controller_dev rcdev;
>   	phys_addr_t io_start;
> +	struct cmdq_client_reg cmdq_base;
>   };
>   
>   static int mtk_mmsys_find_match_drvdata(struct mtk_mmsys *mmsys,
> @@ -280,46 +281,61 @@ static const struct reset_control_ops mtk_mmsys_reset_ops = {
>   	.reset = mtk_mmsys_reset,
>   };
>   
> -static void mtk_mmsys_write_reg(struct device *dev, u32 offset, u32 mask, u32 val)
> +static void mtk_mmsys_write_reg(struct device *dev, u32 offset, u32 mask, u32 val,
> +				struct cmdq_pkt *cmdq_pkt)
>   {
>   	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>   	u32 tmp;
>   
> -	tmp = readl(mmsys->regs + offset);
> -	tmp = (tmp & ~mask) | val;
> -	writel(tmp, mmsys->regs + offset);
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	if (cmdq_pkt && mmsys->cmdq_base.size) {
> +		cmdq_pkt_write_mask(cmdq_pkt, mmsys->cmdq_base.subsys,
> +				    mmsys->cmdq_base.offset + offset, val,
> +				    mask);
If we put here:

    return;
}
#endif

> +	} else {
> +#endif
> +		tmp = readl(mmsys->regs + offset);
> +		tmp = (tmp & ~mask) | val;
> +		writel(tmp, mmsys->regs + offset);
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	}
> +#endif

Then we can get rid of this IS_REACHABLE. Other then that patch looks good.

Matthias

>   }
>   
> -void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height)
> +void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width,
> +				  int height, struct cmdq_pkt *cmdq_pkt)
>   {
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_MERGE0_ASYNC_CFG_WD + 0x10 * idx,
> -			    ~0, height << 16 | width);
> +			    ~0, height << 16 | width, cmdq_pkt);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_merge_async_config);
>   
> -void mtk_mmsys_hdr_confing(struct device *dev, int be_width, int be_height)
> +void mtk_mmsys_hdr_confing(struct device *dev, int be_width, int be_height,
> +			   struct cmdq_pkt *cmdq_pkt)
>   {
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_HDRBE_ASYNC_CFG_WD, ~0,
> -			    be_height << 16 | be_width);
> +			    be_height << 16 | be_width, cmdq_pkt);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_hdr_confing);
>   
>   void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16 alpha,
> -			       u8 mode, u32 biwidth)
> +			       u8 mode, u32 biwidth, struct cmdq_pkt *cmdq_pkt)
>   {
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_MIXER_IN1_ALPHA + (idx - 1) * 4, ~0,
> -			    alpha << 16 | alpha);
> +			    alpha << 16 | alpha, cmdq_pkt);
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_HDR_TOP_CFG, BIT(19 + idx),
> -			    alpha_sel << (19 + idx));
> +			    alpha_sel << (19 + idx), cmdq_pkt);
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4,
> -			    GENMASK(31, 16) | GENMASK(1, 0), biwidth << 16 | mode);
> +			    GENMASK(31, 16) | GENMASK(1, 0),
> +			    biwidth << 16 | mode, cmdq_pkt);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_mixer_in_config);
>   
> -void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap)
> +void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap,
> +				     struct cmdq_pkt *cmdq_pkt)
>   {
>   	mtk_mmsys_write_reg(dev, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4, BIT(4),
> -			    channel_swap << 4);
> +			    channel_swap << 4, cmdq_pkt);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_mixer_in_channel_swap);
>   
> @@ -377,6 +393,12 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		mmsys->data = match_data->drv_data[0];
>   	}
>   
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	ret = cmdq_dev_get_client_reg(dev, &mmsys->cmdq_base, 0);
> +	if (ret)
> +		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
> +#endif
> +
>   	platform_set_drvdata(pdev, mmsys);
>   
>   	clks = platform_device_register_data(&pdev->dev, mmsys->data->clk_driver,
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index fe620929b0f9..7a73305390ba 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -6,6 +6,10 @@
>   #ifndef __MTK_MMSYS_H
>   #define __MTK_MMSYS_H
>   
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
>   enum mtk_ddp_comp_id;
>   struct device;
>   
> @@ -73,13 +77,16 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>   			      enum mtk_ddp_comp_id cur,
>   			      enum mtk_ddp_comp_id next);
>   
> -void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height);
> +void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width,
> +				  int height, struct cmdq_pkt *cmdq_pkt);
>   
> -void mtk_mmsys_hdr_confing(struct device *dev, int be_width, int be_height);
> +void mtk_mmsys_hdr_confing(struct device *dev, int be_width, int be_height,
> +			   struct cmdq_pkt *cmdq_pkt);
>   
>   void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16 alpha,
> -			       u8 mode, u32 biwidth);
> +			       u8 mode, u32 biwidth, struct cmdq_pkt *cmdq_pkt);
>   
> -void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap);
> +void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap,
> +				     struct cmdq_pkt *cmdq_pkt);
>   
>   #endif /* __MTK_MMSYS_H */
