Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02393564C60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGDERP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGDERN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:17:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4866307
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:17:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3176b6ed923so70518597b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SnvkTob9JxAXj3cCksRHVu/Zmndab/ZO+alnhXaDHto=;
        b=UxjwJvhPQz8Hbl6Id472zcA+hG2Tb3K2c4pLpiq7vMkXbEE1Qn6jeYePc6PyZD04wV
         3F6MlJBlXjZycneXtfa/GyXxmpvHX7AlaojmPGKdQw8Ah5Z6PjVkCcdd4YUgwqkyC7XV
         g8hwBSPzgXbF3C3KS2ZA5FTyFoly5mWLB9Um0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SnvkTob9JxAXj3cCksRHVu/Zmndab/ZO+alnhXaDHto=;
        b=Hq2Q7rMDywMaFecXU3OrGEacX9VdImbVbqjKEBo+d6fk26C2KYVRJIiG3jOTT3BDZ4
         vJD5HJKiDf4Z/JDiFAICeJVKtwwqWyrcKel01T/RCYpT9IhJR6ZTcBOVg7zjhPTJNUgV
         TNIIumuPrvsdHPId/xDgjeLldZNSCQX92QzjCQgErExmPqynH4Jev8nbxIADMGmaPf1y
         xEgJ2o2h1Rf0WRCaIpEU23ux1rSWVp68CoOD2+IslRAHxU+gvljeQPfeVdJYQJYNlEzB
         VlRzo4xheadPOOHVMNK881fDfeCtExsocGYYtArK27RVBye9edVB4bsA9nbna6JU8bU+
         bCNQ==
X-Gm-Message-State: AJIora+HCnDVxhi69JswO/H6OuQkVB61uH3KivmbKzTm67K4smlgN27V
        fpPhPzLNdTCj8wOVgI4FWJh6YiSZpe/J/dJ4RDOMqQ==
X-Google-Smtp-Source: AGRyM1uEEhhuAbH2ef0MhtMLltmJW5iNsMjxZxvRRjC5JnT25dH17+A40VJtHSgng3Ur8v8DvVEBXTqGXvucducXsc0=
X-Received: by 2002:a0d:ff02:0:b0:318:41fd:6b1f with SMTP id
 p2-20020a0dff02000000b0031841fd6b1fmr29804621ywf.354.1656908232160; Sun, 03
 Jul 2022 21:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-3-angelogioacchino.delregno@collabora.com> <20220701221158.iuw5fehgkjrqw6zh@notapiano>
In-Reply-To: <20220701221158.iuw5fehgkjrqw6zh@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 4 Jul 2022 12:17:00 +0800
Message-ID: <CAGXv+5FwDuUjbP4THBsXorps12in-=JUtB-4VO5ygDBuQn1SeQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] arm64: dts: mediatek: Introduce MT8195 Cherry
 platform's Tomato
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        hsinyi@chromium.org, allen-kh.cheng@mediatek.com, gtk3@inbox.ru,
        luca@z3ntu.xyz, sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 2, 2022 at 6:12 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Thu, Jun 30, 2022 at 05:33:07PM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Introduce the MT8195 Cherry Chromebook platform, including three
> > revisions of Cherry Tomato boards.
> >
> > This basic configuration allows to boot Linux on all board revisions
> > and get a serial console from a ramdisk.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile         |  3 +++
> >  .../dts/mediatek/mt8195-cherry-tomato-r1.dts  | 11 ++++++++
> >  .../dts/mediatek/mt8195-cherry-tomato-r2.dts  | 11 ++++++++
> >  .../dts/mediatek/mt8195-cherry-tomato-r3.dts  | 12 +++++++++
> >  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 26 +++++++++++++++++++
> >  5 files changed, 63 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r=
1.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r=
2.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r=
3.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> [..]
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b=
/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > new file mode 100644
> > index 000000000000..17e9e4d6f6ab
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2021 MediaTek Inc.
> > + */
> > +/dts-v1/;
> > +#include "mt8195-cherry.dtsi"
> > +
> > +/ {
> > +     model =3D "MediaTek Tomato (rev1) board";
>
> Given that the compatible is "google," I believe we'll want to rename the=
 model
> to "Google Tomato", much like was commented on the Asurada series [1], bu=
t
> better to have confirmation from someone from Google. Chen-Yu? :)

I asked for clarification internally and it turns out we didn't get the
Asurada series quite right either.

Google only owns the reference design, that is Asurada for MT8192 and
Cherry for MT8195. The vendor own the end product design that is based
off of Google's reference design.

So for Tomato, the vendor is Acer. Note that "Tomato" and the other
codenames seen in ChromeOS are public codenames that Google uses.

The compatible string will likely stay "google,XXX", since this is set
in firmware, and updating it after the product has shipped poses both
a significant hurdle and risk.


Regards
ChenYu

> Otherwise,
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Thanks,
> N=C3=ADcolas
>
> [1] https://lore.kernel.org/all/CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFd=
uVz82rM=3D+g@mail.gmail.com/
>
> > +     compatible =3D "google,tomato-rev1", "google,tomato", "mediatek,m=
t8195";
> > +};
> [..]
> > --
> > 2.35.1
> >
