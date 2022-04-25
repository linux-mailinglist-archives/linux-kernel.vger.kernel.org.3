Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72D50E45F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbiDYPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiDYPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:30:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFA103DF4;
        Mon, 25 Apr 2022 08:27:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 79so16221784iou.7;
        Mon, 25 Apr 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nYsiunOUmFwZ8o8GT74juEfa6oLm3zN9Ibj3gVa3bhU=;
        b=i77OZZbZby0nwayMxGseETzr9Nj7J6fX5a++xq03SVhVqRw1UzRVEFc2taTVeAwKIx
         bpvm7uM3vRs39zX0rrxk5JDfUWPopToIhRBrDI+o4mAuHvh3vFBZupK5zorHVe/CmH+u
         vyFzmNAsKrnn+xdUsiFFpZlPY+NZEygZg5XCeHV51KiCqTj00m5DiEP+e+DnYHXQHART
         h1Zphjo3zCVJueWZVhkfeYvQk2BGyHdlT/ujK+BZc6F7STAC3GVIK4fd389QU+E3CWYZ
         WgAQhDs9ANzbCD4mOfXtByWpJFFyk+yN6QxirF8aFCaVelBhgkxpLlYf5lARzkvP5tZT
         cS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nYsiunOUmFwZ8o8GT74juEfa6oLm3zN9Ibj3gVa3bhU=;
        b=2ZnaUvU1ZRWMMMvvJPFIs3IrabZJzetqfGThA+EiV+RFShuQ+WU4fbXduJrYIkYLR7
         2hv3CAs3w74UXsSj0Kl6BqeaMdU3HOdOcOeyqaifsHiukG6l+41ry2Gd2cbRCY0fUb4v
         ue+AdILsEerbcjkEWrpbcXjbGajzJFkL8eNNhnpIzxXa59prhYB62ABRaiQmtiG1xTxd
         ZF9P0oTV896Ok4dyooxX1eSPWTxwP7JtkrqleLa4/5V/VJW/VjiSO7q8MCOv3xVxiApD
         lUhg4WsiTMXaeL1/rvrHJd+SOs5ozaTCz5MwuQALdjy8uGq1YP2SvpO4wjfOkmu+U/AZ
         VToA==
X-Gm-Message-State: AOAM530YSiw/uhKh2J/+YylDcrh7hPMTChrjyuiykDCNG7ZfYq9qpnDH
        EeyZIWSA0UdGJRyNFFW9axs=
X-Google-Smtp-Source: ABdhPJzaOOhKV4BPWVeNOg0tWQ6bvh+gsUzBd/G0AXF40GnUFg0YdN6YZlGg+EFWAsS/57V61YrvNQ==
X-Received: by 2002:a05:6638:1352:b0:321:547b:daa2 with SMTP id u18-20020a056638135200b00321547bdaa2mr7317700jad.128.1650900453788;
        Mon, 25 Apr 2022 08:27:33 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id b11-20020a6be70b000000b00654b3a46b5esm7499151ioh.53.2022.04.25.08.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 08:27:33 -0700 (PDT)
Message-ID: <7faa6c9a-9ace-d1eb-0bca-8e8d7c3ae7ec@gmail.com>
Date:   Mon, 25 Apr 2022 17:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 11/21] drm/mediatek: add display merge start/stop API
 for cmdq support
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        llvm@lists.linux.dev, singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220416020749.29010-1-nancy.lin@mediatek.com>
 <20220416020749.29010-12-nancy.lin@mediatek.com>
 <2cd07faf-e903-e55b-85c1-ce7a823ddb8b@gmail.com>
 <CAAOTY_8Ei1e+Y==y+e7LoHBH3-SZEiz4M0SSqecRfWVMsLKH3Q@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAAOTY_8Ei1e+Y==y+e7LoHBH3-SZEiz4M0SSqecRfWVMsLKH3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 15:32, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2022年4月22日 週五 下午7:48寫道：
>>
>>
>>
>> On 16/04/2022 04:07, Nancy.Lin wrote:
>>> Add merge start/stop API for cmdq support. The ovl_adaptor merges
>>> are configured with each drm plane update. Need to enable/disable
>>> merge with cmdq making sure all the settings taken effect in the
>>> same vblank.
>>>
>>> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
>>> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>    drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  2 ++
>>>    drivers/gpu/drm/mediatek/mtk_disp_merge.c | 20 +++++++++++++++++---
>>>    2 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
>>> index 53aa988dde3b..43a412525b75 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
>>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
>>> @@ -66,6 +66,8 @@ void mtk_merge_stop(struct device *dev);
>>>    void mtk_merge_advance_config(struct device *dev, unsigned int l_w, unsigned int r_w,
>>>                              unsigned int h, unsigned int vrefresh, unsigned int bpc,
>>>                              struct cmdq_pkt *cmdq_pkt);
>>> +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt);
>>> +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt);
>>>
>>>    void mtk_ovl_bgclr_in_on(struct device *dev);
>>>    void mtk_ovl_bgclr_in_off(struct device *dev);
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
>>> index 40da0555416d..c0d9b43b2a66 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
>>> @@ -67,17 +67,31 @@ struct mtk_disp_merge {
>>>    };
>>>
>>>    void mtk_merge_start(struct device *dev)
>>
>> Probably not my call, but wouldn't it make sense to enhance mtk_merge_start to
>> pass 'struct cmdq_pkt *cmdq_pkt' directly instead of adding this 'adapter'?
> 
> In [1], mtk_merge_start() should match the function prototype of
> mtk_ddp_comp_funcs.start, so keep the non-cmdq interface.

Well other callbacks, namely config hass cmdq_pkt. So we could change the 
callback in a similar way is was done in
d0afe37f5209 ("drm/mediatek: support CMDQ interface in ddp component")


But as i said it's up to you. You are the maintainer.

Regards,
Matthias

> 
> static const struct mtk_ddp_comp_funcs ddp_merge = {
>   .clk_enable = mtk_merge_clk_enable,
>   .clk_disable = mtk_merge_clk_disable,
>   .start = mtk_merge_start,
>   .stop = mtk_merge_stop,
>   .config = mtk_merge_config,
> };
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220419094143.9561-5-jason-jh.lin@mediatek.com/
> 
> Regards,
> Chun-Kuang.
> 
>>
>> In the end this is up to Chun-Kuang.
>>
>> Regards,
>> Matthias
>>
>>> +{
>>> +     mtk_merge_start_cmdq(dev, NULL);
>>> +}
>>> +
>>> +void mtk_merge_stop(struct device *dev)
>>>    {
>>>        struct mtk_disp_merge *priv = dev_get_drvdata(dev);
>>>
>>> -     writel(MERGE_EN, priv->regs + DISP_REG_MERGE_CTRL);
>>> +     mtk_merge_stop_cmdq(dev, NULL);
>>>    }
>>>
>>> -void mtk_merge_stop(struct device *dev)
>>> +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
>>> +{
>>> +     struct mtk_disp_merge *priv = dev_get_drvdata(dev);
>>> +
>>> +     mtk_ddp_write(cmdq_pkt, 1, &priv->cmdq_reg, priv->regs,
>>> +                   DISP_REG_MERGE_CTRL);
>>> +}
>>> +
>>> +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
>>>    {
>>>        struct mtk_disp_merge *priv = dev_get_drvdata(dev);
>>>
>>> -     writel(0x0, priv->regs + DISP_REG_MERGE_CTRL);
>>> +     mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
>>> +                   DISP_REG_MERGE_CTRL);
>>>    }
>>>
>>>    static void mtk_merge_fifo_setting(struct mtk_disp_merge *priv,
