Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B281B523332
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiEKMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiEKMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:37:18 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C67356D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:37:15 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so1093638vkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=v9Th8rxPiWf3ZnzxeLk5F4SGsw0EdAo79OtQwsPtPNc=;
        b=qZGqNwBdtTPSsXJ4TudOdVSft1cn0crk+rUA+BXcaAtlIIcDlbrBzGZl1G6ZvqtL0/
         52aPzGjkDjxenmbtmqIx6HbPYriuF0amTOjLWM4rtPHVTv/9qzizlClERaRHxX71D0ie
         /JuDIGifRPC2mJZsXUpCyTfdP6nLePIyl87T0VN3BU/AWzRxgidSFlfa9LPoAfc+5GxY
         LpL/W8t6FtVAAJclUgCOS+NJAgUpE/918VqAruLfHfgduNmM7bpqSwYcGW0lFDx6KmLh
         z/P+C9mYP3Rw8n+JWR2eJ+XXz039AdpnO9kvyDW1SbdY7w98B+1jppF+iMFrluk/aUcT
         y8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=v9Th8rxPiWf3ZnzxeLk5F4SGsw0EdAo79OtQwsPtPNc=;
        b=6udmdTT/u0PdUEHjy/8fahxcYbPtdxwQh0hZc4FSKUsZsB1xp+uPleDgsU9zRVgJ5k
         0oAvNAurLUxcF9IymHOTXwduR+z0VpnNYk87pJZQ+g6apgK10d3R47ZZg8PcQpZMt8UK
         c3kRyBachzt8ZpCcyZ8OK+oxlB4wBd44X5+nDEGKnNzRhvGp8erPtynzqePf+fqaY7Ua
         M64mSjOHaf0zE9L8BzjUpFXCRotRmtYI/Bj91uSkaeOnquxt2LMId7rM4OQzxD0MzYRH
         7LPIS6VH2q5A4VoOq0SoKaZxIr4hbmRsBb7GZy/N+HVWm1M0w0E3xrxK7GzS99EBCWm3
         zDRw==
X-Gm-Message-State: AOAM532gOolS6s1ajv6xe5SJ4nikTAiyfeIKjcgWC+xJq+m7Iwo8wlVt
        s2xyT5UZTbNdg8aR0rQsz4sY7SVemCWxPRSar17VAA==
X-Google-Smtp-Source: ABdhPJxBn9ixvONga67IFvsidm0urKpQCjlwF7V0itqftu5rkpNVWoXNuJCCn1qTxzlSqdUM84jEJ4VrTbu4KEramCk=
X-Received: by 2002:a05:6122:511:b0:34e:e406:a66d with SMTP id
 x17-20020a056122051100b0034ee406a66dmr14033939vko.6.1652272634992; Wed, 11
 May 2022 05:37:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 May 2022 05:37:13 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-2-granquet@baylibre.com>
 <20220422105712.bdpbwliificvon4j@houat>
In-Reply-To: <20220422105712.bdpbwliificvon4j@houat>
MIME-Version: 1.0
Date:   Wed, 11 May 2022 05:37:13 -0700
Message-ID: <CABnWg9uwMN6yK-xfCPtRsLif5yC7AU5b+OKc0xaHjLKzQ__gJA@mail.gmail.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, tzimmermann@suse.de,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 12:57, Maxime Ripard <maxime@cerno.tech> wrote:
>Hi,
>
>On Mon, Mar 28, 2022 at 12:39:06AM +0200, Guillaume Ranquet wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> DP_INTF is similar to DPI but does not have the exact same feature set
>> or register layouts.
>>
>> DP_INTF is the sink of the display pipeline that is connected to the
>> DisplayPort controller and encoder unit. It takes the same clocks as
>> DPI.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index dd2896a40ff0..2dba80ad3b18 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -4,16 +4,16 @@
>>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> -title: mediatek DPI Controller Device Tree Bindings
>> +title: mediatek DPI/DP_INTF Controller
>>
>>  maintainers:
>>    - CK Hu <ck.hu@mediatek.com>
>>    - Jitao shi <jitao.shi@mediatek.com>
>>
>>  description: |
>> -  The Mediatek DPI function block is a sink of the display subsystem and
>> -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
>> -  output bus.
>> +  The Mediatek DPI and DP_INTF function blocks are a sink of the display
>> +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
>> +  parallel output bus.
>>
>>  properties:
>>    compatible:
>> @@ -23,6 +23,7 @@ properties:
>>        - mediatek,mt8173-dpi
>>        - mediatek,mt8183-dpi
>>        - mediatek,mt8192-dpi
>> +      - mediatek,mt8195-dpintf
>
>It seems a bit weird to have all instances of DP_INTF with a separator
>but the compatible doesn't have one?
>
>Is there a reason to not use dp-intf?

None that I know of, It was taken as is from the vendor tree.
I'll use dp-intf in v10 for the sake of consistency.

Thx,
Guillaume.

>
>Maxime
