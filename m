Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF64C54A707
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiFNCrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352572AbiFNCqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:46:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97040E59;
        Mon, 13 Jun 2022 19:24:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMXMP5k7pz4yTf;
        Tue, 14 Jun 2022 12:24:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655173490;
        bh=7r/wSZntjyx/vAomnCuxBPjB/OyUEqKUwv9dafChlXo=;
        h=Date:From:To:Cc:Subject:From;
        b=DX1W8DswoFWnxurxN5OOgLILu45/GqIZBPxo2tFwJT4uYk4ydo32GjwPuoldQWycz
         XwDh2/bNXs15YHrRwnEOk+wqo+JbUW6/GpykGrzlVdUXeEaAXHtg92cegOm0TGq7F/
         SZy1aCbTsUVwA3yqNLDRZ3tTcmoNwMCfRjpPRIYhSGaZLgcrEnJiNUZshDPfsh3Mvp
         lOB+mrHWie7XSa/gP0FE/1EQr+2ZAN/G1bIbNmKKyMrXv3xjXrdOPahzD4gyDV9WB4
         HHhP84sxMDIQx+VTtEGH6g/bChbITO2bQImlgz/XSFzrd/GbmWlPXnakWGyD9BwNuN
         uhWKPqSBewt+w==
Date:   Tue, 14 Jun 2022 12:24:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nam Cao <namcaov@gmail.com>
Subject: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20220614122448.1360395f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sx/3I2jev=dZ0zCrj1O3tyP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sx/3I2jev=dZ0zCrj1O3tyP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/r8188eu/os_dep/ioctl_linux.c

between commit:

  96f0a54e8e65 ("staging: r8188eu: Fix warning of array overflow in ioctl_l=
inux.c")

from the staging.current tree and commit:

  ac663ae22f02 ("staging: r8188eu: replace FIELD_OFFSET with offsetof")

from the staging tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sx/3I2jev=dZ0zCrj1O3tyP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKn8XAACgkQAVBC80lX
0GxUeAf6Aok1SQgrFlfCbdPq4p9T7sTFS8OjHzJecbSmOiWrHuPwTopzwB0KDYky
XvGHfSmF86HDaMs00rW6hwv7XEZQELz2R/hX1gUHQG7LB07zIh+RtZi+LY+A1GKn
gYi31LbD2DlZ14WRFlkVlJDi92nGnX3k17HILbeYQhM0rNwWFmQFWVN7pUBwOdzI
RhG8WwIuWeANahHLDx9Gw4GZTP1PgRvIg8EuvVhQ/4RZ4lZGBDD6RlJay2boWwqn
YRhU3E1/HIiXSGpTMFFPFwRxxbwpDsFYY26Ddzbuxm1zVxDcsH/WJV2PX/5hAR05
T7nIKluKTr8nNUqyu2XrRo3nptmnIQ==
=6X2/
-----END PGP SIGNATURE-----

--Sig_/Sx/3I2jev=dZ0zCrj1O3tyP--
