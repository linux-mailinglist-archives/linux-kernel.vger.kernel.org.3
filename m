Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB953CB45
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbiFCODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiFCODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:03:06 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DB27CD7;
        Fri,  3 Jun 2022 07:03:01 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w130so10577747oig.0;
        Fri, 03 Jun 2022 07:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4KrDpSYq99VolrzPQGxB5l5hpx3haeHuOlN9SEwbx0=;
        b=dWRlUqdZW3EC6g9gtD8qyuwfwNaGfrMfUUrKv3vI57AolDjIgR6TtgzH3Pk4T6ehtM
         8tWZYCwwOJFgmPRm4XQ8IzcMBpNlApbuAHXPhJujBbjle1yVtB/Kn8th+uWIko3rXnwI
         Kq8YDgZCEkSBxYkCjFUiyvE3d/zluRtR8wr5ZG2TL8yyWIrhnCWfNA6dNRqoF1ZCUn3i
         2P/nO93EWmOa440wBCwm9Kxap57dSs5PVf9CvDrgQGvThzYI8Q/JKveJAAEwL/NSls/R
         e6GJldJAqUuPVdt7WXpXmCoyOVj3eGlYIXmJgUvKiejhxSY9+gPrium74sPCn9Af93uz
         mbWQ==
X-Gm-Message-State: AOAM531gKUeQjxZiBVNakdmZa39spYjYCsfAm+YbgFgszr/KueidkoVU
        kub057oSDeK//95d4CvWhg==
X-Google-Smtp-Source: ABdhPJzNWAcrfALGI9WFStd6O7bU+uyoCscDf+bymPZkJRN1miqnpseIhlLZQcf+wmB4Pok3H4FeGA==
X-Received: by 2002:a05:6808:144d:b0:32b:7fbc:9440 with SMTP id x13-20020a056808144d00b0032b7fbc9440mr5607304oiv.226.1654264980296;
        Fri, 03 Jun 2022 07:03:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p3-20020acad803000000b0032e5209af19sm891448oig.31.2022.06.03.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:02:59 -0700 (PDT)
Received: (nullmailer pid 275907 invoked by uid 1000);
        Fri, 03 Jun 2022 14:02:58 -0000
Date:   Fri, 3 Jun 2022 09:02:58 -0500
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
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND v12 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <20220603140258.GB243231-robh@kernel.org>
References: <20220525015140.384-1-axe.yang@mediatek.com>
 <20220525015140.384-2-axe.yang@mediatek.com>
 <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 09:28:37AM +0200, Ulf Hansson wrote:
> On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
> >
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 2a2e9fa8c188..e83bf10281d6 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -72,12 +72,27 @@ properties:
> >        - const: ahb_cg
> >
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source irq.
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msdc
> > +      - const: sdio_wakeup
> >
> >    pinctrl-names:
> > +    description:
> > +      Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
> > +      will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are
> > +      mandatory in this scenarios.
> > +    minItems: 2
> >      items:
> >        - const: default
> >        - const: state_uhs
> > +      - const: state_eint
> 
> Don't you need something along the lines of the below instead? I mean
> the "state_eint" isn't always needed, right?
> 
> oneOf:
>   - items:
>       - const: default
>       - const: state_uhs
>     - items:
>         - const: default
>         - const: state_uhs
>         - const: state_eint

This is equivalent to what was done. The 'minItems: 2' makes the 3rd 
item optional.

Rob
