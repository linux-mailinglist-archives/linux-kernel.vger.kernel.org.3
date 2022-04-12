Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8704FDE14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiDLL0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347599AbiDLLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C97A0BFA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:06:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-df22f50e0cso20272609fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=tZvbGpFjILGpekjAvGDF0y9dQ6Kd+gBt4gVMWfKJuAk=;
        b=Xo8+YSn3qT7Jhf9u4FuGYXY6Bov1PRuEhL0/Es2kDk9T156ExPENxfB+L80w1q/WN8
         AY7X2X8pBC+egX5EAP7hbmLqVYYquyMaM+9TMa0V8rrwt4eOMwpnKS1rXrmKnJYddRKl
         WXqMioKIAM/xFynvUhz/5U8QrlcdzmdQycq7DES/Sco99BT/85Gs/jV5R1n5nlmInzkN
         Xusklq+2enfKbeU1Z/uYCXgSMZElx/lRCPsCgmbehOhUkX+zIy72zJ9+1JEhZnnHiF0b
         7lrsXEthfoBv0c5BqbSXLUfcVprx8t79rP5dVaUdlBdoIR+brcAYyZc6c3+7XT7Jw7uM
         vcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=tZvbGpFjILGpekjAvGDF0y9dQ6Kd+gBt4gVMWfKJuAk=;
        b=oOReS94c5FmvKcXv+cVaxJMEfEaGVEcnVUxFv2u97mz44FG0uxESYEKke31Mb34Sy4
         +ufexYafQpDfmb/K1Q6Rf65Rs/MZeTy9bUoBuC9ty0HRpklxSA0/bamPd+V5xw3OngWA
         8qw8q2+RrRv3ceDBij4oeuSVr8fV3+c9xoT/QEEcZTRHA4B/yVGJI6Qpmt313Y5RgX1P
         ONBMNicaeHLMrw6DNLANSkx40uXOpczhnt2xx6m2w51xeyLtcvtDRK9FVIKU5jraN+1e
         +bpZ24/zSToLx3l5mlAOQA1GsvcueXcWGgYtdBc49kuGrjahWBjkKbLKZsOtMwMq+y2h
         73tQ==
X-Gm-Message-State: AOAM532MktM7Wu/VW6frQaoxqt/ibbjrtmJuczfoLBZzwolr41Muecc7
        K7nIineWX803aRm1L3ZBmO9YzDk1lzjbyWlVZU95Bw==
X-Google-Smtp-Source: ABdhPJw3WX7NFQkxU4ADRLrRdzB/pHuRSdo1xjaZj5zggo6wW/RSRVmkJtH7xxbo7eDcNYsrg++TE2K0RicigcNQMoo=
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id
 t26-20020a056870f21a00b000dd9beccaf8mr1670792oao.78.1649757969594; Tue, 12
 Apr 2022 03:06:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 03:06:08 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-4-granquet@baylibre.com>
 <YkOPB5W7uXkOc72/@robh.at.kernel.org>
In-Reply-To: <YkOPB5W7uXkOc72/@robh.at.kernel.org>
MIME-Version: 1.0
Date:   Tue, 12 Apr 2022 03:06:08 -0700
Message-ID: <CABnWg9tvh31wibtTO2nETfJ9XtST0Ejjea0_2q1Hd5GRs9DN4Q@mail.gmail.com>
Subject: Re: [PATCH v9 03/22] dt-bindings: mediatek,dp_phy: Add Display Port
 PHY binding
To:     Rob Herring <robh@kernel.org>
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, tzimmermann@suse.de,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 00:58, Rob Herring <robh@kernel.org> wrote:
>On Mon, Mar 28, 2022 at 12:39:08AM +0200, Guillaume Ranquet wrote:
>> This phy controller is embedded in the Display Port Controller on mt8195 SoCs.
>
>Sorry, but I think you need to go back to what you had in v8. While yes,
>the phy and controller IP often do change independently, this h/w looks
>pretty interwined.

Understood, I'll revert back to v8.

>
>You could make the controller a phy provider to itself if you wanted.

Not sure I follow, could you point me to an example?

Thx,
Guillaume.
>
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>  .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>> new file mode 100644
>> index 000000000000..1f5ffca4e140
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (c) 2022 MediaTek
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek Display Port PHY
>> +
>> +maintainers:
>> +  - CK Hu <ck.hu@mediatek.com>
>> +  - Jitao shi <jitao.shi@mediatek.com>
>> +
>> +description: |
>> +  Device tree bindings for the Mediatek (embedded) Display Port PHY
>> +  present on some Mediatek SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8195-dp-phy
>> +
>> +  mediatek,dp-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the Display Port node.
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - mediatek,dp-syscon
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    dp_phy: dp-phy {
>> +      compatible = "mediatek,mt8195-dp-phy";
>> +      mediatek,dp-syscon = <&dp_tx>;
>> +      #phy-cells = <0>;
>> +    };
>> --
>> 2.34.1
>>
>>
