Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0953F996
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiFGJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiFGJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:27:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C71A06B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:27:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so27343030lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bycnujn+C+TNXArQgDaRYNKXnzzQ5tOqUsTDh+BoVXc=;
        b=t8p26q3E/L/TgZvfOS55JAOsz9xPuki8ovvsGEs+DFidMo0+nC5q87KialHMbXXUx2
         NZBSPLKbAm5cIgCaNWSfYwSt4fnlLecR64L71ARiiI5CPS1aqqzrxJvXB6IKLY3WXNuu
         5SHFPVTF0HSOWo8rE6sQ/WkS4a9ZCwX0/c1KlNkUzxFzcQXCYtwlIQpkRlh9O9h7hD2c
         lzKWKa/el8B4Cs+eVSyH6vN291VP71o6gwb8Ctk7TpGDvbmiVIQea1yApDwP5aGLX40A
         Z49d4wqGHGA6mOLOnxNUVdf0Mj1739Iv+QtyQf++UoZ8BECNUCN8dDbnFukVMBX5uYds
         kbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bycnujn+C+TNXArQgDaRYNKXnzzQ5tOqUsTDh+BoVXc=;
        b=b23yeM+AwFLz+OfKI6ES8e5xLD2b5IJ94EdE7yI0mjCr+V0vUVHiKrtW7z262tG/zH
         PxdfThhzAw094e37UtvgOngQVkbJzGcjmfb7GV6RH3EoxwdhrrUbgNknuyEkPU1TJKbt
         EmJfyhR2A4PP//uByD19lwM2X3spPijqzv/W5ppwP+cOJKeLjx85e9lfDFcTeUtKt5lx
         qId0NweYvOm9l98UtOXstIyjGc1W/gVptC76YSPVjk/aGIy1ytdiLX2kJvtbtjUUs7O6
         vneX/CUI9DjsW4uQoSlchYuyWKUTWzjnUm8XvoY6TV3fJ/k9JsbLPgMgkjwHLSV+uuf2
         ucZw==
X-Gm-Message-State: AOAM5318wCBh4WkjmIHjGSt6aCO8jAPn60KVtCdN0uxZy1wce13831A4
        gNwkSIkBZdyrMSnC3a8w12oq3vcQIUrliSGfkrJmRg==
X-Google-Smtp-Source: ABdhPJxQISkP4fpMf2Tx4GQZOz5bRQyTzJ8vaUdWMeVJt9giKQNrG2uqpo97Sb9v8bOTq0hPO8Lyk67AS9Huf+RLHh4=
X-Received: by 2002:a05:6512:403:b0:479:1627:a9b7 with SMTP id
 u3-20020a056512040300b004791627a9b7mr15454828lfk.233.1654594027813; Tue, 07
 Jun 2022 02:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220525015140.384-1-axe.yang@mediatek.com> <20220525015140.384-2-axe.yang@mediatek.com>
 <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com> <c46ef886f908067d10b1cb9f37b3e41e6157c71d.camel@mediatek.com>
In-Reply-To: <c46ef886f908067d10b1cb9f37b3e41e6157c71d.camel@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 11:26:31 +0200
Message-ID: <CAPDyKFp1ibzg2FO9m_m9quqPRew9jOtLJRSF80VTi0cesjhBqw@mail.gmail.com>
Subject: Re: [RESEND v12 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 10:24, Axe Yang <axe.yang@mediatek.com> wrote:
>
> On Fri, 2022-06-03 at 09:28 +0200, Ulf Hansson wrote:
> > On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
> > >
> > > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > > This feature allow SDIO devices alarm asynchronous interrupt to
> > > host
> > > even when host stop providing clock to SDIO card. An extra wakeup
> > > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > > required in this scenario.
> > >
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50
> > > ++++++++++++++++++-
> > >  1 file changed, 49 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > index 2a2e9fa8c188..e83bf10281d6 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > @@ -72,12 +72,27 @@ properties:
> > >        - const: ahb_cg
> > >
> > >    interrupts:
> > > -    maxItems: 1
> > > +    description:
> > > +      Should at least contain MSDC GIC interrupt. To support SDIO
> > > in-band wakeup, an extended
> > > +      interrupt is required and be configured as wakeup source
> > > irq.
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: msdc
> > > +      - const: sdio_wakeup
> > >
> > >    pinctrl-names:
> > > +    description:
> > > +      Should at least contain default and state_uhs. To support
> > > SDIO in-band wakeup, dat1 pin
> > > +      will be switched between GPIO mode and SDIO DAT1 mode,
> > > state_eint and state_dat1 are
> > > +      mandatory in this scenarios.
> > > +    minItems: 2
> > >      items:
> > >        - const: default
> > >        - const: state_uhs
> > > +      - const: state_eint
> >
> > Don't you need something along the lines of the below instead? I mean
> > the "state_eint" isn't always needed, right?
> >
> > oneOf:
> >   - items:
> >       - const: default
> >       - const: state_uhs
> >     - items:
> >         - const: default
> >         - const: state_uhs
> >         - const: state_eint
> >
> No, it is not always needed.
> As Rob said, the 'minItems: 2' makes the 3rd item optional.
> Combine 'minItems' and 'description' fields, it is easy for others to
> understand how to set pinctrl related properities.

Yes, I agree.

>
> Anyway, If you insist 'oneOf' is the better way, I can update that in
> next version. What do you think?

I am fine with it as is, sorry for the noise.

>
> And thanks to your comment, I found a mistake in 'description', I
> should remove descriptions related to 'state_dat1', and I will update
> that in next version.

Okay.

>
> And do you have any comment on patch 2/3 and 3/3?

Sorry for the delay, I will have a look asap.

>
>
> Regards,
> Axe
>
>

Kind regards
Uffe
