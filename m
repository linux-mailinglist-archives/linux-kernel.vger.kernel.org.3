Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12BF586B27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiHAMqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiHAMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:45:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7249B54
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:34:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id n8so18709440yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LcoRKUZxcX+fwnP/w+Ek0L1ccliKcMJGGIMkqg+/gBk=;
        b=8Qq67pSUym7bRxaJ1wXQxajEMJS6HpKos8PyqVw/AIYaTRUkyuiHDv0eycBw7WteMz
         vA2ffmtRj5NpE9imFKTBnZZHdh7Veak9BjcfMJEO1TvQsTZncZ8wpJSSeWS/Fzl2r4oo
         crxtVikU87MU4cvow8KAMXuSE8Fw4ECrP5KwDbAKdS8agCFU52209EKhx1fzCsQSWcmG
         Bf2T4r9FGmsl0SSufopazQYH6qUx7esh3yBY7jYpKJtzHa+9ugcTbzjnNcl7YUrB99/v
         9oEa7EI5KFpJbbLUS6osrgC2g3+vL4a3PJZdTepn337fCpKGSdA1qUQAomSfAXFQxHJJ
         e1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LcoRKUZxcX+fwnP/w+Ek0L1ccliKcMJGGIMkqg+/gBk=;
        b=m2rkuzm9CusAsgzf1SqdIcFYNf4/ZwsFRvclTuJJs66OG+0LVEICh6foBJkGJ1HoYK
         HitBHnVXQ/Sh/MBwTkkyzQbPF17kU2VQMLlWDK3O9U9O6oIeTCDhmmC0Y2bNEilHLRu0
         ntJmTACi9F4L6NSyDSWveZghofrJHGycWPHpRqe9HFFBGz1nFswUXBsO1W3MBJo2PQd4
         J+33KqvMTU84GkA1I+6sE8rqvhgqNb9nntC3751X1axqHxcKONgp8qzwg48vBygRaiq4
         jta8wH7RWnhvxpM/KVV27Y1KUccxVkYbTQySqRtFy1cb5eUWnXBlLGbhiKoq6vHdM/Aq
         e19w==
X-Gm-Message-State: ACgBeo1b49DzkbcNaLaZYbRxLHOwxV1AQd7s4RDWW7SUgw94HtdIxIBK
        81VmO7KabcxhsF+k01Sqaqi2gQPSmG7XPkKQL4Ed3w==
X-Google-Smtp-Source: AA6agR6gUV377VODoTtcZyENpHL6zTEL/yl0+xktWswsikj2XjC6xG8FsEO1Dd8D5SwcKI+6sZgTq8Xo9pCEdETIOIU=
X-Received: by 2002:a25:4941:0:b0:670:24c7:dc96 with SMTP id
 w62-20020a254941000000b0067024c7dc96mr10354775yba.22.1659357247554; Mon, 01
 Aug 2022 05:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-6-bchihi@baylibre.com>
 <20220729201421.fxybo57g46ftghgd@notapiano>
In-Reply-To: <20220729201421.fxybo57g46ftghgd@notapiano>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 1 Aug 2022 14:33:31 +0200
Message-ID: <CAGuA+ooqk-tf5FVfEbA0WdjTOo2fPJi-+AaHDC9jXgw=3vKq0g@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] arm64: dts: mt8195: Add efuse node to mt8195
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:14 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Jul 26, 2022 at 03:55:05PM +0200, Balsam CHIHI wrote:
> > This adds the efuse node. This will be required by the thermal driver
> > to get the calibration data.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8195.dtsi
> > index 0ff34edcf8c8..4fbf24b5d202 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1236,6 +1236,22 @@ nor_flash: spi@1132c000 {
> >                       status =3D "disabled";
> >               };
> >
> > +             efuse: efuse@11c10000 {
> > +                     compatible =3D "mediatek,efuse";
> > +                     reg =3D <0 0x11c10000 0 0x1000>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     lvts_efuse_data1: lvts1-calib@1bc {
> > +                             reg =3D <0x1bc 0x14>;
> > +                     };
> > +                     lvts_efuse_data2: lvts2-calib@1d0 {
> > +                             reg =3D <0x1d0 0x38>;
> > +                     };
> > +                     svs_calibration: calib@580 {
> > +                             reg =3D <0x580 0x64>;
> > +                     };
> > +             };
> > +
>
> This commit doesn't apply, there's already an efuse node on mt8195.dtsi. =
Please
> rebase.
>
> Thanks,
> N=C3=ADcolas

Hello N=C3=ADcolas,

Thank you so much for the review.
I rebased on top of the latest kernel version "linux-5.19.0" but I
can't find efuse node on mt8195.dtsi.
But, this node is indeed present on mt8192.dtsi.

Best regards,
Balsam
