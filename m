Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FB50E51B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbiDYQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiDYQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221010FF6;
        Mon, 25 Apr 2022 09:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA7E2612E6;
        Mon, 25 Apr 2022 16:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546ECC385B0;
        Mon, 25 Apr 2022 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650902557;
        bh=ibAp6Qdurhq2UaINptVowpGDRoELicExS9BcLP47wrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bPprMwkwmyDxvOqb490NX6HiwrlcOOMNTSO7fdIBQ97pBBEw2PoHYFF1CbPEg6yko
         6To47/fpvROzmLuJFip3Ofa8QjXz+esrwMWOIO1e9PonXm8OPPkYw0wO/iwqy0Ld3T
         l3bYbwrFtDWJqts4QENV31+xfaA/kdTxrNBHp3GxHocbcFN/0ue77gZs/XHZe54FIb
         6sddFMEi7Fa/uO2YQVi4bTlN36o9kfXqBz5tNA2HGuSrdYeA8vUnZOWbC141HH4Ych
         loBINSTeTh34pG3/nffGd/gJRMOF+XkOMhi9NhJ5/vzxJrQ0vhcOlmca6Oghs6wupo
         di39+Eg3a4YQw==
Received: by mail-pl1-f180.google.com with SMTP id n8so27683156plh.1;
        Mon, 25 Apr 2022 09:02:37 -0700 (PDT)
X-Gm-Message-State: AOAM533UVqQU1lA/3bvhgFm5xov5k9Ni4JtBkrj8ZBXFFsxGzPYqV6+N
        Wou68RSFfpW9Jm4h0sckVXrpCyQnCWTW+ig9sg==
X-Google-Smtp-Source: ABdhPJwiET3dMMmtNpcl3m0Jao6U9LdDUHuMBgi/c2Wo3MntkfVL4gztMAOSkvWGxBOAgFL47WvVLxfV4VMa5JbKeaU=
X-Received: by 2002:a17:90b:1e08:b0:1d2:8bb4:f565 with SMTP id
 pg8-20020a17090b1e0800b001d28bb4f565mr32241726pjb.4.1650902556770; Mon, 25
 Apr 2022 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220422121017.23920-1-allen-kh.cheng@mediatek.com>
 <20220422121017.23920-3-allen-kh.cheng@mediatek.com> <e2e4ead0-d8eb-1302-93e9-f330807d811e@linaro.org>
In-Reply-To: <e2e4ead0-d8eb-1302-93e9-f330807d811e@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 11:02:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKU98F0wD=cmayq_k-uwP=M5nQrjmG1kd5SJtdv41nsCg@mail.gmail.com>
Message-ID: <CAL_JsqKU98F0wD=cmayq_k-uwP=M5nQrjmG1kd5SJtdv41nsCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: mediatek: Convert binding to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:44 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2022 14:10, Allen-KH Cheng wrote:
> > Convert Mediatek watchdog devicetree binding to YAML.
> >
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > ---
> >  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
> >  .../devicetree/bindings/watchdog/mtk-wdt.yaml | 76 +++++++++++++++++++
> >  2 files changed, 76 insertions(+), 42 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > deleted file mode 100644
> > index 762c62e428ef..000000000000
> > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > +++ /dev/null
> > @@ -1,42 +0,0 @@
> > -Mediatek SoCs Watchdog timer
> > -
> > -The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
> > -before the expiry.
> > -
> > -Required properties:
> > -
> > -- compatible should contain:
> > -     "mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
> > -     "mediatek,mt2712-wdt": for MT2712
> > -     "mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
> > -     "mediatek,mt6589-wdt": for MT6589
> > -     "mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
> > -     "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> > -     "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> > -     "mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> > -     "mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
> > -     "mediatek,mt8183-wdt": for MT8183
> > -     "mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
> > -     "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
> > -     "mediatek,mt8192-wdt": for MT8192
> > -     "mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
> > -
> > -- reg : Specifies base physical address and size of the registers.
> > -
> > -Optional properties:
> > -- mediatek,disable-extrst: disable send output reset signal
> > -- interrupts: Watchdog pre-timeout (bark) interrupt.
> > -- timeout-sec: contains the watchdog timeout in seconds.
> > -- #reset-cells: Should be 1.
> > -
> > -Example:
> > -
> > -watchdog: watchdog@10007000 {
> > -     compatible = "mediatek,mt8183-wdt",
> > -                  "mediatek,mt6589-wdt";
> > -     mediatek,disable-extrst;
> > -     reg = <0 0x10007000 0 0x100>;
> > -     interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
> > -     timeout-sec = <10>;
> > -     #reset-cells = <1>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> > new file mode 100644
> > index 000000000000..5788617027c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/mtk-wdt.yaml#
>
> File name: mtk,wdt.yaml

mediatek,wdt.yaml
