Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF09D4DDF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiCRQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbiCRQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:49:24 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A013D4B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:48:04 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id a5so9970628pfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UiwMNQAcJybAKewEM0dZcEYqnf9WKLLDT9V2nDkKi3Y=;
        b=ixWKXv4GjykF1D963z3mX5UKBv9NMlr0zg8lx/3zhPlHZxIGl4ibP4sJn+5dOfp4zu
         rxNA1x8FUdtFTr8yqK7j3iV1MOHnRj44uJDIX9IAaAGpG11dm8YHaS3ZIeZUG6N+n9hV
         UG7lMKSPvCdze8/twMI/8K3X4h1fjvkdpXjezBmNOxpCN/XpoR7UDYvAepQFsrVV5RAp
         waLyImKDe4t88eg5yVbY2mOTn4+diOithT4gyd/z/px8W/h7rhAOKYLcEiO190IGzEbF
         AktjCdUjvqZw0xHUtn5uUlK0mogCCLZNffSvfU4G/TbcL+fL+9LKKo66TcJoay6S0y0X
         amZg==
X-Gm-Message-State: AOAM533od1xu6W2BeQNV2IT24tMf4KTAniXY+5VX8NArOoCdWYnPglG3
        sqWHPiytJNQw+ygRGYTWEM09lA==
X-Google-Smtp-Source: ABdhPJwwVK19S8VwNYG9iLz/w3CUg34rZ/2OYsNz+NiHLrH99YHMdqQhKsiphPx4pIEeAHDV0b6ogQ==
X-Received: by 2002:a63:7b57:0:b0:382:2edd:fcc4 with SMTP id k23-20020a637b57000000b003822eddfcc4mr2914667pgn.559.1647622084331;
        Fri, 18 Mar 2022 09:48:04 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id oa12-20020a17090b1bcc00b001bf430c3909sm13497665pjb.32.2022.03.18.09.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:48:03 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: Re: [PATCH v23 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <60613d10-f7fc-03ea-900f-4255ebe0d5aa@collabora.com>
References: <20220221063939.14969-1-roger.lu@mediatek.com>
 <60613d10-f7fc-03ea-900f-4255ebe0d5aa@collabora.com>
Date:   Fri, 18 Mar 2022 09:48:02 -0700
Message-ID: <7hlex7p5q5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
writes:

> Il 21/02/22 07:39, Roger Lu ha scritto:
>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>> which calculates suitable SVS bank voltages to OPP voltage table.
>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>> 
>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
>> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
>> 
>> change since v22:
>> - Make "svsb_volt = max(svsb->volt[i] + temp_voffset, svsb->vmin);" become one line.
>> - Remove voffset read/write commands for better system safety.
>> - Add more comments on @turn_freq_base.
>> 
>> Roger Lu (7):
>>    [v23,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
>>    [v23,2/7] arm64: dts: mt8183: add svs device information
>>    [v23,3/7] soc: mediatek: SVS: introduce MTK SVS engine
>>    [v23,4/7] soc: mediatek: SVS: add monitor mode
>>    [v23,5/7] soc: mediatek: SVS: add debug commands
>>    [v23,6/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
>>    [v23,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
>> 
>>   .../bindings/soc/mediatek/mtk-svs.yaml        |   91 +
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   16 +
>>   drivers/soc/mediatek/Kconfig                  |   10 +
>>   drivers/soc/mediatek/Makefile                 |    1 +
>>   drivers/soc/mediatek/mtk-svs.c                | 2398 +++++++++++++++++
>>   5 files changed, 2516 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
>> 
>
> Hello,
> the entire series has got reviews, and this has already reached 23 iterations.
> I personally have no more complaints about this one.
>
> Does anyone have any KO comments about this series?

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

I haven't reviewed closely since much earlier versions, but reviewing it
again now, I think this series is in good shape now.  Thank you Angelo
for all of your detailed reviews.

Also thank you Roger for your persistence and dedication on getting this
feature upstream.  It has been a long road, but you've stuck with it.

Kevin
