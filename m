Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465244EF922
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbiDARp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbiDARpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:45:51 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB517067;
        Fri,  1 Apr 2022 10:43:59 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso2576230otf.12;
        Fri, 01 Apr 2022 10:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sNR2TlxgTK1TbH9xd2EATOl1wVHrrsxIUMLp6s+Vsc=;
        b=WeZSsRtXfx3qWUoOm52VYz8lvNFEYE/LVv0D34H2z6BziJY8YAFvielJ0pIfo/XzDk
         WGLyr+Ak1RkvbcyC+YbaqNl0xhLMnObsQ8cfJio9V0LqKIVY5IQdY7LWkwdgQsZwji3h
         ssMQ35+BSaQD7SEBShELAkhTy2BrScRdy1aPaZTeMN56FrOAMWJo9jPBX8SVFsF70cQg
         9TMo/iov/t7Tt0EvxCs0CJF1u5Q7GADXYzpckyL13APVNd/qpyLeMoSMJei/Mwxr4Aju
         unnXpojfl5+QlqlFLPOBVvD/L41UXBiozwGb5bjRlgyi3pjhTZNHj3PbNQMLgEC7Vz+J
         EwUQ==
X-Gm-Message-State: AOAM53166AX/huGf/xiM0F/oCkiJBpgc0tjMdDFJWEdOoRO3T0HimBr0
        bew78Ja0//esuHBWjQAzNw==
X-Google-Smtp-Source: ABdhPJyovbTksU5nQiLA0YPpdSisoZNvCngTqQ2Hzh2Z/zGQkGPiKebnd/iY0i+yZeuu1HOu3/Qk+g==
X-Received: by 2002:a05:6830:16c3:b0:5b2:3700:654a with SMTP id l3-20020a05683016c300b005b23700654amr7844054otr.353.1648835038745;
        Fri, 01 Apr 2022 10:43:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm1255081oig.52.2022.04.01.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:43:57 -0700 (PDT)
Received: (nullmailer pid 3302659 invoked by uid 1000);
        Fri, 01 Apr 2022 17:43:56 -0000
Date:   Fri, 1 Apr 2022 12:43:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <Ykc53EmCaA7TadRK@robh.at.kernel.org>
References: <20220329032913.8750-1-axe.yang@mediatek.com>
 <20220329032913.8750-2-axe.yang@mediatek.com>
 <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:22:13AM +0200, Ulf Hansson wrote:
> On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
> >
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> >
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml         | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 297ada03e3de..3872a6ce2867 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -69,12 +69,22 @@ properties:
> >        - const: ahb_cg
> >
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source irq.
> 
> If I understand correctly, the extended interrupt (a GPIO irq) may not
> necessarily share the same interrupt parent as the primary device
> interrupt.
> 
> Perhaps it's then better to extend this with "interrupts-extended"
> instead. See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.

'interrupts-extended' is interchangeable with 'interrupts'. For schemas, 
use 'interrupts' and the tools take care of supporting both forms.

Rob
