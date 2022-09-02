Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602495AB167
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiIBN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiIBN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:29:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537AEEEC59
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:08:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E4371320090C;
        Fri,  2 Sep 2022 08:34:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Sep 2022 08:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1662122046; x=1662208446; bh=69wBoD2FcW
        S+VJub/o1SXKNMgpIXHt/jaTIMdQTQNes=; b=XHrR1ZCQoQmpvRT/cPY/9LcNB5
        HbYvLIIwbwJ3I8tAiCkQeqeD6ac4sQxkWFElK4/2M96NO42Hn11H07JT/QFVXr8z
        kjDkscAYB/o/TxBPAsTcp+fBpWSD/X1HfCWtH3LgmeNzI7tSVefpoYfjRXCfJCN8
        yDK2T/6mdgHaynbM6eZ0TXnzYtHqgCrJqnqkHxz6vRRzIfyplybtYLDBG8aDYvI8
        pUTzvXG+HUMzuuTVOYAws1tvn7az6LV1uZdaFlVENwuar4NRxgqpiKmI7/ofJtsr
        Hdv3DLT5DJHI3FWooBjmEE43LrvAwr5PqO+XYyjq6nrmo8PliVuHhkTGbZeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662122046; x=1662208446; bh=69wBoD2FcWS+VJub/o1SXKNMgpIX
        Ht/jaTIMdQTQNes=; b=CWTAamlIdomT+2ReqO+SVhE0ewgiqv4yZ5OnRNWDwcWE
        X+8+FemvxwpBtL7ywc/vsmj75bkH8tMuLI15yvL0uqDa8/So7C9tjphjJ/4HlESX
        RkAKKO07mO5oNGEPr+G1FKsJtliCuhZBW17aBw6gamPUMJa4F5P8KkwPf2pftijZ
        tM8Ih6E6wiVykyxgp/vBxmhEmr46bOVdJLJz9AILj7bmhvZ6mZNL/15uUiLHO1R5
        DPcjpytHi9i6NFcJNfHaInErfSGLL/eKd+sTtPv0iRCd2PPKhcBWEvzZZwiLL0tE
        hNsr1L3frvU1jNbOHl3IQ4yXzpfKT0mAiv3hF74pBA==
X-ME-Sender: <xms:PfgRYzY0V9T6oHAQHYFq_qp488C0-vJwmhaKBtvMkoo--Pptnv3k_Q>
    <xme:PfgRYybbx_9WsuS45POrQj46N9ZoIAtv9JfUFyFTQm_BgBUoYbTjEDmtfPAPI5y6s
    JmtzIX7xj6wM1L5yjY>
X-ME-Received: <xmr:PfgRY1_LZGkpshpvDD9gA_AiArZJHnu4dD16PaWXHxuc2vSX2-Ev4UR0Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeljeeugfegveetleevkeetffegudevieetieeugeeugeeivddtjeejvdef
    feetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:PfgRY5pdGZEc6150lT0Pj62iRT2PDLE_CEy5Zbw-1_46mEj43zL5Cw>
    <xmx:PfgRY-r6IKQCQHWo131B_1vTIKy_IvK3_85AfmrLwbBg9l0FlI2bqQ>
    <xmx:PfgRY_StF0AYljou5s-fvHd8GAt3KYRXn70kCZ7iTDDTXUGXH1UBaQ>
    <xmx:PvgRYzjM24CXnQqyMUH2ejZ8atEu4eK32NXN-shDmoLTZ3mzmTN61g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Sep 2022 08:34:04 -0400 (EDT)
Date:   Fri, 2 Sep 2022 14:34:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
Message-ID: <20220902123400.5ljgc7z6zw34d64m@houat>
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
 <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
 <87h71qfbi9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="je6h4ueg2vhmqv2d"
Content-Disposition: inline
In-Reply-To: <87h71qfbi9.fsf@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--je6h4ueg2vhmqv2d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2022 at 11:04:14AM +0300, Jani Nikula wrote:
> On Thu, 01 Sep 2022, Ma=EDra Canal <mairacanal@riseup.net> wrote:
> > Hi Maxime,
> >
> > On 9/1/22 09:55, Maxime Ripard wrote:
> >> Hi,
> >>=20
> >> On Thu, Sep 01, 2022 at 09:42:10AM -0300, Ma=EDra Canal wrote:
> >>> With the introduction of KUnit, IGT is no longer the only option to r=
un
> >>> the DRM unit tests, as the tests can be run through kunit-tool or on
> >>> real hardware with CONFIG_KUNIT.
> >>>
> >>> Therefore, remove the "igt_" prefix from the tests and replace it with
> >>> the "test_drm_" prefix, making the tests' names independent from the =
tool
> >>> used.
> >>>
> >>> Signed-off-by: Ma=EDra Canal <mairacanal@riseup.net>
> >>>
> >>> ---
> >>> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-m=
airacanal@riseup.net/
> >>> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confusi=
ng (Jani Nikula).
> >>=20
> >> I appreciate it's a bit of a bikeshed but I disagree with this. The
> >> majority of the kunit tests already out there start with the framework
> >> name, including *all* the examples in the kunit doc. Plus, it's fairly
> >> obvious that it's a test, kunit is only about running tests in the fir=
st
> >> place.
> >
> > Would it be better to keep it as "drm_"?
>=20
> That's not "keeping". That's renaming igt to drm.

Well, there's like half the tests that are prefixed with drm, the other
with igt, so it's both really

> > Currently, I don't think it is appropriate to hold the "igt_" prefix, as
> > the tests are not IGT exclusive, but I don't have a strong opinion on
> > using the "drm_" or the "test_drm" prefixes.
>=20
> I repeat my stance that "drm_" alone is confusing.

What are you confusing it with?

> For the reason alone that it pollutes the code tagging tools, mixing
> actual drm_ types and functions with unit test functions.

I don't get it, I'm sorry. All these functions are static and not part
of any API, so I can't see how it would pollute a code tagging tool. Or
at least, not more than any driver does.

And we're part of a larger project here, it's about consistency with the
rest of the ecosystem.

Maxime

--je6h4ueg2vhmqv2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxH4OAAKCRDj7w1vZxhR
xcnGAQDfG15wrc3ceeKSo7qsOykhYDbwylJuO4xitBZoirs0ZgD/ecLkzhEgtAOv
b++wHEVZEq7FPSdzWgIwHQIiRnLixgA=
=zFJ3
-----END PGP SIGNATURE-----

--je6h4ueg2vhmqv2d--
