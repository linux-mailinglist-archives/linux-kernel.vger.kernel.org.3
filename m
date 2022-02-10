Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29614B0854
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiBJIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:32:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBJIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:32:24 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19C21A7;
        Thu, 10 Feb 2022 00:32:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 7B0702B000CD;
        Thu, 10 Feb 2022 03:32:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 10 Feb 2022 03:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=C/eXBq+gZ62G9kCMbvxgHoY4HT9QFjd3I7LMc4
        VqqdY=; b=ituAnSye7hGbmYW3uz3PGJC/qkvsI6a0H7OYi91PGWs9Ry6Qj2o6+7
        psPYX0O2MqlDtPKNXTiRKevzPRkk4l0CIRT3qkbgki6IkAW+hRpR2Opm+yzVXSaD
        uOJFMlzi6xI2S8OIriSyt+RK5x7bZRBbNVLpyLyr5O4Moo/JFi0KPeFd3Z2geDS8
        /u4s9cJIsI/1fLMJOlg9FesN0+5VSGp5+ARJJRKvZiZJ1+15zTay28R8aAu3eRkd
        O9UFCfxlzEDrf6PF8ynXjSxV4wSwTUEmA/h154NtuXdun+KiCAjrTWUzE5PTum5V
        NtGpKWRWr1/ozBFPIRUhHJQ29QUgy26A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C/eXBq+gZ62G9kCMb
        vxgHoY4HT9QFjd3I7LMc4VqqdY=; b=OlRhPlrktWnn293Ix4vniS4/TLrLc8A9e
        zftKBpJXIKOiwP4FIvhRs7i960W1CnbFhPTrRUpcMbi2KiMCdSKr851NzmpalL0N
        oDUu6lLMjDQ5kN6awAKk+AqjIKq6tHdVeyW9IkHiwgCoFMH5ciIwryXV1mkRpjGb
        mrtioo5DaxLttoviThNTvUY42WxOlAMnMJ+vJkdnslgU06nlW3SBbTg2P3VuoArZ
        F9wMdcXEw1M1NzgddGF1fuo5T1XEKKCCdiDoUkPJtEm/bVucC8xXQUhMiVrqvnXw
        lhdRHvRLnjv40vrcRxbufaHFlABeZyrl49qsN6x1hVDy0zmOeAUcA==
X-ME-Sender: <xms:jM0EYk1qx-1espsy7K0VZIF62yd7Em3ylB3xSK4ORcYGZfAQGsM3qw>
    <xme:jM0EYvGMW3SOp_Jd_d_Mau5ua01fK_Dnr_BON3ijKKpfDxbZY8P77M5gWIdM2xyaS
    4qxS-9SfqTNNU36VZM>
X-ME-Received: <xmr:jM0EYs7gJ6_UeLuTxMeB_ukS3Jdo2H50RxgWlwg3a5tIUuXnP9jl7i14niIVdl9ksuvtmQSPvz7xMTmGLGz6hjmpgFIHFQs1d9qpmpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jM0EYt03v46yxj4pMbCbQ2-2VwqTMarEfzts0AZ1o8mvPQ8jnEqP6A>
    <xmx:jM0EYnEbm_Ww5VF2fUbKnSDH_U-52OqCSWUqelDYYn76dAsjSH1Esg>
    <xmx:jM0EYm_RxLik0gCOuGd1caX0waikq_oeNaM_y9tgvpxlyDgd8qp5LQ>
    <xmx:js0EYoLBi4qU5l70RxzFJfsXtDvMU8D5FsJavd0OxYmqJU4lyn39smTPvtU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 03:32:11 -0500 (EST)
Date:   Thu, 10 Feb 2022 09:32:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <20220210083209.c7r32rn2s22342ov@houat>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
 <YgPF1cBMsd9973Dx@smile.fi.intel.com>
 <CAMuHMdXQdL_Do8Hjay1egfmd9H05R7BjNeKfLGq67mU4bQNVZA@mail.gmail.com>
 <f58b2608-0d51-3209-ae11-18bdac19dd66@redhat.com>
 <YgPef3s5+AMqWpSH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yujxwkbg7rlinnus"
Content-Disposition: inline
In-Reply-To: <YgPef3s5+AMqWpSH@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yujxwkbg7rlinnus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 05:32:15PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 03:42:16PM +0100, Javier Martinez Canillas wrote:
> > On 2/9/22 15:27, Geert Uytterhoeven wrote:
>=20
> ...
>=20
> > Now, this is a reason why I mentioned that the old fbdev driver shouldn=
't
> > be removed yet.
>=20
> I agree on this conclusion.
>=20
> I think based on the fbtft resurrection discussion I can send a new versi=
on
> to unorphan it, route via fbdev, and leave under staging, so it will be a
> compromise between all stakeholders.

The DT bindings still don't belong anywhere in the main tree.

Maxime

--yujxwkbg7rlinnus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgTNiQAKCRDj7w1vZxhR
xWgfAP9c/WNFJ2bN5djje6UoeI3NdmGyqQqkH/nOSnKreJjVggEAlkkecUX+M/D1
o4NAxYKHGIWb/kzHxeNo7yoVXMbVaw4=
=H8/+
-----END PGP SIGNATURE-----

--yujxwkbg7rlinnus--
