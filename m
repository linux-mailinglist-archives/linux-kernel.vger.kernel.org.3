Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0A59970A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347333AbiHSIGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347315AbiHSIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:06:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F562DEB56
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:06:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BC0CB5C01B9;
        Fri, 19 Aug 2022 04:06:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Aug 2022 04:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660896410; x=1660982810; bh=MW7fwh1jlh
        Lt99QT7W6TrPFD6EINpAhygwxAPWIlKrQ=; b=PAva6MkIv9E0eIVLrDVV2Hy62F
        q8euoOBt8a2+rpW/CEKnLRR+pgaxHgvKdf/yAtFrLrae+tFlbqZZ22bNXmKbUVwg
        SqQxz00t3+0DMorsLtHEWZIIJzmJ7MDMyOj1SWINfsxK1q/CtDB3lt62qHWDGRx4
        aesBMJe0UMJfzvd73cTHDP4/sFZMMqz8Sn2pkEqOCKsgxxVTsLKcleAEGzux3b3J
        7HYanrtOM/paYCXozWmYJv4q/nv0Yorts1CXXCRrDgkcWADUkMkfWzycXycjG6F6
        YuyqW6iNkBJHV/3aj/lFh25LD5Jk79uORi7Q4PVWkv+etQLXXbT2ay/+qO5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660896410; x=1660982810; bh=MW7fwh1jlhLt99QT7W6TrPFD6EIN
        pAhygwxAPWIlKrQ=; b=D880SEiSSVheTMznuq9TVLMgKze5mb+KNJY8/P7AxGNz
        hGtkS3BGgRAO089YK25fCs6pE/UHrfAWLpI6MTeNvY+H4wpoBZcg9QeI2UKy8lJn
        6oMjQmzX8PC0OTtFl8GjSY3AGG1ZKj5fIhcTBas5N09iRijQs8PkYhMkgPkRYepN
        YeV7NzP8CjJpwRbAD2zUjbxSkU5QAsQ6qbBwoe8osXIH1G4ChWj8S7qg7WmS+/DK
        MYYXG1azgGp+YpG8g3ebzq/NLv32SxGiHF49NPgNVLIwjDI6v/Z64kKsMZFIeWWy
        YKzPWPgcpG/Zzv4DE9enV37eHXBFCS+F26O/T40XVg==
X-ME-Sender: <xms:mkT_YjW8_mw6SNS3kCMSBE7k5ZKZDub-vGbLztjxkAe_p4qCF1oHJg>
    <xme:mkT_YrncXwQB6Nd8uPNWzd7KcOA7XlWvZdhxVvIga-2LN6yJiRf49_motEHL0rZbM
    s8d5z6zk9SzPPP3NRk>
X-ME-Received: <xmr:mkT_YvaIC905vM7v6eL89t9mDoBWE1mB1DSSVMJhcc7Vi0AFY1u6Wkuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffej
    ieegteejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:mkT_YuXAoVZzgsf-w0E5Z3KdppsgwQEIMKzOhpaMQ3r3p2zaZoxT0g>
    <xmx:mkT_YtmjjNsA7LT5Z4Mb7hUcJRRNi4Z4hCdRGKNNzzSGjjG9ft2Uxg>
    <xmx:mkT_YrdVCZEbJ5TpaLcvHK5EpCszDKZbfFX-ZiuoCSFP8kTRfzlY_A>
    <xmx:mkT_YjUHTjKPUnGndr2NqtoqXu7sz7Sb6VHWlcgqS_pUhgSGmVX2tg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Aug 2022 04:06:49 -0400 (EDT)
Date:   Fri, 19 Aug 2022 10:06:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: drm warning with mainline due to 467e30171b5b ("drm/vc4: hdmi:
 Move HDMI reset to pm_resume")
Message-ID: <20220819080647.v25c6tqvqajwarlw@houat>
References: <YvvHK2zb1lbm2baU@debian>
 <20220817071048.4v66zky5qysn45wq@houat>
 <CADVatmOKemXQbRpJeeqR2NbWMkUc9U09xrch=OpDkxFXqbH8XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpuha7jlmdph3xbp"
Content-Disposition: inline
In-Reply-To: <CADVatmOKemXQbRpJeeqR2NbWMkUc9U09xrch=OpDkxFXqbH8XA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wpuha7jlmdph3xbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 18, 2022 at 09:36:35PM +0100, Sudip Mukherjee wrote:
> On Wed, Aug 17, 2022 at 8:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 16, 2022 at 05:34:51PM +0100, Sudip Mukherjee (Codethink) w=
rote:
> > > Not sure if it has been reported but the mainline kernel shows a drm =
warning
> > > on RPI4B.
> > >
> > > [   14.821276] WARNING: CPU: 3 PID: 187 at drivers/gpu/drm/vc4/vc4_hd=
mi_regs.h:487 vc5_hdmi_reset+0x1f8/0x240 [vc4]
>=20
> <snip>
>=20
> > >
> > > git bisect pointed to 467e30171b5b ("drm/vc4: hdmi: Move HDMI reset t=
o pm_resume")
> > > and reverting this commit has fixed the warning.
> > >
> > > I will be happy to test any patch or provide any extra log if needed.
> >
> > We have fixes for this in drm-misc-next that have missed the cut for the
> > merge window:
> >
> > https://lore.kernel.org/all/20220629123510.1915022-38-maxime@cerno.tech/
> > https://lore.kernel.org/all/20220629123510.1915022-39-maxime@cerno.tech/
> >
> > If it fixes it for you, I'll apply it to drm-misc-fixes
>=20
> Thanks. With these two patches applied on top of the latest mainline,
> I don't see the warning anymore.
>=20
> Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

I ended up applying the patches yesterday anyway, thanks for confirming :)

Maxime

--wpuha7jlmdph3xbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYv9ElwAKCRDj7w1vZxhR
xQ84AP9z5gFy8AM6jUI44bSFj7rpF+ibsK3OOps8Wyd7+UaKgwD9HPKODIoJlm1K
4ykhodSVPYuDbBevfgRT/tAvJgroOw4=
=xd5B
-----END PGP SIGNATURE-----

--wpuha7jlmdph3xbp--
