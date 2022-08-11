Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAE59089C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiHKWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHKWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:08:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CEA0262;
        Thu, 11 Aug 2022 15:08:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C8C215C006A;
        Thu, 11 Aug 2022 18:08:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 18:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660255714; x=
        1660342114; bh=8ZCDjbDiatX8L4toFofmUz+eVA1AbAXz/oRWIKvDcSo=; b=G
        isUhB/wN1ioUV+Ag+wZaIMzQUEoJh5uuW07ezA4iHDfaVs3xkzdGlK/ZwjjtEdHP
        k2286GAOwybQaVszqFrXG5vvSY2awa/zhIYMCfxRt75f5ZhSUv+lQLkzOxPXtkmA
        Ld/q5f3ZEmtujnGCfGCbbmim9zTHWwoz3d4KlDzqWYpZ7zHNDyfYwhFgippLhtto
        KvDXSqz/Wh1z/zLktc2Ypm9LjX4IWv9GsgtKXueFssf2NPo1yNxqX++WAurm2ffT
        Q9SOHe5x/VfHg5m6pVXmkUW3qkWCRQ4eTqT65X/OFbEJDNZn0GU8a4rnKnJDjTOP
        bc/xTV0gXM0/4G2G/AM8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660255714; x=
        1660342114; bh=8ZCDjbDiatX8L4toFofmUz+eVA1AbAXz/oRWIKvDcSo=; b=r
        1yp9+b11KeIx+50+UEMu2jx/k+Q8BluB2l55aVCVoeSvxhsPN7NZqpIkhAAHdzVP
        5Vsyw5VJVnlS1KbXsZA/KEbDLXCWpf9zlRT0ciWCcCK/HgRWbnTzmg2AgGx646q3
        UEreodsPxldzb8inVCel6kuTkovlrT/eiC0Akvo6aV+b0yTdvJkLxeWYJHQTJgBD
        MKfslJNMtYxSf6FnjpXsTo0GWBdzTzy+wxQs/mroeF9p0nOHrQjbRynAytsf21RE
        7d6dPylElT56nBL4Y1rfn3d5ei6YbdvWfWb20/n3NhALT3aKP1ZSXuoiQAYLdalh
        9BxXZH5G5Oqmd5Tcu2aiQ==
X-ME-Sender: <xms:4n31Yrd0RXt_mlYkV4TnW33E6SqzwG-urNcTn5kQR0tkbwygx11DAQ>
    <xme:4n31YhM4GXYpOKaE2XzG5ukYcmPumoWvzQ5V9i-Q5XU8xqIrAzEBroPqGJAYV1EpQ
    uVlzyMVRzbZi5zM9QM>
X-ME-Received: <xmr:4n31YkhKAhRB2R9UJI_oBMnw-o2eyKg6-YhxWiuBGPcjRNmL4SF3Gb2r1wmzJRMbDbseBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:4n31Ys-8-cL9z1vg1dXBV9zMPJkcmzLaT1FKvn1C1lpP92eVzHUcqQ>
    <xmx:4n31YnsiDzGe0IDFgAeDkea2BEn_knIdEaQ9pX_uJld_wmMtcwmikg>
    <xmx:4n31YrHMtnDN-bpeTswx2mUnSUXyP30gohwpSR00SZaLhM9id7SgJg>
    <xmx:4n31YnK373oLA-XbtGUsNWRHOafkC5YsKXY9jD2SFbMguqWHeeXLgg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 18:08:32 -0400 (EDT)
Message-ID: <ef32187cf1090de6e8cda2bf0218985cd3f4c21e.camel@ljones.dev>
Subject: Re: [PATCH v3 4/6] asus-wmi: Document previously added attributes
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Aug 2022 10:08:25 +1200
In-Reply-To: <a0688d90-8b20-fc50-56ec-d50a5601f468@redhat.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-5-luke@ljones.dev>
         <CAHp75VeLWGURdL9SK4+fLPRsM_Dc3bNvGSoWXKOWMSz=3CQUQg@mail.gmail.com>
         <a0688d90-8b20-fc50-56ec-d50a5601f468@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2022-08-11 at 17:08 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 8/9/22 11:25, Andy Shevchenko wrote:
> > On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev>
> > wrote:
> > >=20
> > > Documents some previously added attributes:
> > > - dgpu_disable
> > > - egpu_enable
> > > - panel_od
> >=20
> > Try to find a commit that introduced thouse and add the respective
> > Fixes tag.
> >=20
> > ...
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * keyboa=
rd - 0 or 1, unknown what effect
> > > this really has
> > > \ No newline at end of file
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * keyboa=
rd - 0 or 1, unknown what effect
> > > this really has
> >=20
> > Should be part of another patch.
>=20
> Ack to both remarks.
>=20
> Luke please make this patch one of the first patches in your next
> version / patch-series and then add the doucmentation of the new
> kbd RGB backlight attributes in the patches where you are also
> adding those actual attributes.

Yep, done. Everything is looking much cleaner too.
