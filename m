Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25983589ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiHDLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHDLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:13:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3319D61D6B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:13:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m22so18497078lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ocrse2lQ6Zu05i5TSECxP89aNNukjo6UNe8sPBi1Tac=;
        b=Y2sE4cFmB+/Hm7t80UvbhOR/3iDhNxGiy5cDtxtu9grrPVx2hr5S4QbpVJlNmxk6Nh
         mW7pS10lAUh+BRUSydRJ0e0ES3++9AvWsbBo5QD6+KpFKfQ7qHe4FvJ4X9W6mgScBwO5
         EY0FwScIlrnBeCj9kj59E2Zv68PyHW5L6+BOpfdqYKEgOc3G5oq5pFMzKZkm3ah4jpHi
         QnggCBo+4a8zuLbnCkVtz934XZeLP5t5bw+AieLC+OT0Q6dv2xCCekI58pY4x5l4sck9
         NguMsVmActDL8MZmcrH4fmHm0q5SakwlZyYMV+AO/TNd3t73mvxk5fEJa/2G05oT0a2x
         UNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ocrse2lQ6Zu05i5TSECxP89aNNukjo6UNe8sPBi1Tac=;
        b=dQ1OA2jJ4gS3BYDNRMpL4yE0yIbvyJmLE7SG5Ds8SMBDQDmPbh7HA/vJYgXridZBaM
         uZUoydZLc36AA39x4swB5HXiPtsRrA7q5Q35HmQZsJv6Up9MJhvKgs3j00gD+bPuA8P7
         qIgx+z22DTWiMZrQeXD/MyhbUNSB2LLSNpaUlTLE6nSPviMApjhW/jCAIPfSptrcjtsF
         tnmL5pKP+BrIW0NbGa9fBk2dzdnbyNLq0VGQHzdqhXreivHfhGmtfYA/2IMK8nPGxLq6
         osGLXc3VBt2mUlfpmCDjWUER9f6671fFOL8vk9c0MWJWthycFRQ46/H5IuL9kda30cRi
         JLzQ==
X-Gm-Message-State: ACgBeo2ujUnDNYEZXcbvBLnVQpRVj49+ycKwIQgaZNW7VJ1f87HPN8jp
        oNrpvx5kvUvW/jFkTjQHz+ChHw==
X-Google-Smtp-Source: AA6agR63N/Slocyhyqr3XJV8eS2xQ5DeoyAUJHauggb0t0T4y0jeXLCPYsVQtaa2lc9r7TngPF7lIg==
X-Received: by 2002:a05:6512:3f05:b0:48a:ca44:80f2 with SMTP id y5-20020a0565123f0500b0048aca4480f2mr519981lfa.224.1659611628451;
        Thu, 04 Aug 2022 04:13:48 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id r15-20020ac25f8f000000b0048b03f9adcdsm84592lfe.309.2022.08.04.04.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:13:47 -0700 (PDT)
Message-ID: <ae06f644-b988-8fc3-fde8-258299f8f2ae@linaro.org>
Date:   Thu, 4 Aug 2022 13:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8188: Add binding for MM &
 INFRA IOMMU
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804105834.626-1-chengci.xu@mediatek.com>
 <20220804105834.626-2-chengci.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804105834.626-2-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 12:58, Chengci.Xu wrote:
> This patch adds descriptions for mt8188 IOMMU which also use ARM
> Short-Descriptor translation table format.
> 


Thank you for your patch. There is something to discuss/improve.

>      then:
>        required:
> diff --git a/include/dt-bindings/memory/mt8188-memory-port.h
>  b/include/dt-bindings/memory/mt8188-memory-port.h
> new file mode 100644
> index 000000000000..612fd366c3a7
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8188-memory-port.h

Use vendor prefix in filename, so mediatek,mt8188-memory-port.h

> @@ -0,0 +1,482 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */


This should be dual-license, if possible.


> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Chengci Xu <chengci.xu@mediatek.com>
> + */
> +#ifndef _DT_BINDINGS_MEMORY_MT8188_LARB_PORT_H_
> +#define _DT_BINDINGS_MEMORY_MT8188_LARB_PORT_H_
> +
> +#include <dt-bindings/memory/mtk-memory-port.h>
> +
> +/*
> + * MM IOMMU supports 16GB dma address. We separate it to four ranges:
> + * 0 ~ 4G; 4G ~ 8G; 8G ~ 12G; 12G ~ 16G, we could adjust these masters
> + * locate in anyone region. BUT:
> + * a) Make sure all the ports inside a larb are in one range.
> + * b) The iova of any master can NOT cross the 4G/8G/12G boundary.
> + *
> + * This is the suggested mapping in this SoC:
> + *
> + * modules    dma-address-region	larbs-ports
> + * disp         0 ~ 4G                  larb0/1/2/3
> + * vcodec      4G ~ 8G                  larb19/21/23
> + * cam/mdp     8G ~ 12G                 the other larbs.
> + * N/A         12G ~ 16G
> + * CCU0   0x24000_0000 ~ 0x243ff_ffff   larb27: port 0/1
> + * CCU1   0x24400_0000 ~ 0x247ff_ffff   larb27: port 2/3
> + *
> + * This SoC have two MM IOMMU HWs, this is the connected information:
> + * iommu-vdo: larb0/2/5/9/10/11A/11C/13/16B/17B/19/21
> + * iommu-vpp: larb1/3/4/6/7/11B/12/14/15/16A/17A/23/27
> + */
> +
> +/* MM IOMMU larbs */
> +#define SMI_L0_ID		(0)

No need for ().

> +#define SMI_L1_ID		(1)
> +#define SMI_L2_ID		(2)
> +#define SMI_L3_ID		(3)\


Best regards,
Krzysztof
