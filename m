Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB985091E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382436AbiDTVQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382414AbiDTVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:15:57 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id A674E3C499
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:13:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650489189; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=zRjGTGnzaVlx+b81ByZmjRuO5gTu2rGruPsHyj6hw9o=; b=CmBbwSpCOLmzoUW0uF+M/ieUfO4lTvy+Sh44pR9RjpfLn6pWJAWcDPPDBWAgGoZkKF7J2eLo
 jM12jTX+yiYuv7k9gwPf5zyU8aKYBK0m64ZIJbWDRPOYIwMeXZA7EtCJVaNLezRo1fwF2Ky+
 5RZnzIIXnAsS+Up73OZBjgoGpX3bWtgCzBfA6KVb66RRQKy1QgT6FVpWzOb1FXUCI91/t3ys
 i7XdEQYlpfWAyzXw5A28UfnQbKfm4127U4iR5aUpJzh6sT6Uyi5qtCF8HzokMrW9cCimRwyy
 ABO/biLPWgMpF01ZVMUmgnc8LW/KEyobRQOl95pwOOD68gIaw6DmWw==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 62607764b77b16c56e5b6d3e (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 20 Apr 2022 21:13:08 GMT
Sender: codeagain@codeagain.dev
Date:   Wed, 20 Apr 2022 18:12:58 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 2/3] staging: vme: Add VME_BUS dependency to Kconfig
Message-ID: <20220420211258.j23biocryjkuz3qo@AN5Bruno>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <00de5644d7c2f8c8878eccf86b761e0602732080.1650321310.git.codeagain@codeagain.dev>
 <20220418233929.zz32dil4u6hbwtqv@AN5Bruno>
 <YmA4ILK5Gv/Gdaso@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="entcbfx2eyqninee"
Content-Disposition: inline
In-Reply-To: <YmA4ILK5Gv/Gdaso@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--entcbfx2eyqninee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 06:43:12PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 18, 2022 at 08:39:29PM -0300, Bruno Moreira-Guedes wrote:
> > Please, disregard the following message as there's a typo in the prefix.
> >=20
> > On Mon, Apr 18, 2022 at 08:31:09PM -0300, Bruno Moreira-Guedes wrote:
> > > The KConfig file for VME_USER ('drivers/staging/vme/devices/Kconfig')
> > > sourced at "drivers/vme/boards/KConfig" misses a `depends on` line for
> > > VME_BUS, which is unnoticeable for menuconfig users who aren't be able
> > > to select it through this interface without setting the CONFIG_VME_BUS
> > > option because it's nested on VME_BUS menu entry.
> > ...
> > >  	  VME windows in a manner at least semi-compatible with the interfa=
ce
> > > --=20
> > > 2.35.3
> > >=20
> >=20
> > It's already sent a new copy with the proper version number. Nothing's
> > changed except for the message ID and the v2 typo.
>=20
> I can't handle 2 v2 of this same commit, our tools get very confused (as
> do people.)  Would you be able to unwind this if you were in my
> position?
I really apologize for this confusion, I really did some mistakes on my
local branch and had to edit the patches manually to reapply them. While
working on that I accidentally missed to change the 'v2' to 'v3'. My
mistake.

Though, there's no 2 v2s, the new one I sent is a v3 as is the rest of
this thread. So, would it be necessary to unwind anything anyway?=20

If this question happens to beb a bad one, my apologies again, I'll soon
do some effort to learn more about how things work from a maintainer's
perspective so next time I make a mistake I'll be able to take the best
curse of action straight away.

>=20
> Please resubmit a v3 of this series with everything fixed up.
Did you mean a v4 in this case? Or just post the same patch again?

>=20
> thanks,
>=20
> greg k-h

--entcbfx2eyqninee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmB3WgAKCRAZtd3tyEY2
ksbKAPwPgITi8i0KAigk8iXE96aF+Bz80tV57D5e9sQtk1HRJgEA3pxLFm5GRTwv
aHAulqmNfDatFnWis1wjkqpiUhuJPwk=
=yp+5
-----END PGP SIGNATURE-----

--entcbfx2eyqninee--
