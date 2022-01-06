Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF948670A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiAFPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:48:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:34807 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiAFPsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:48:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JV9jr2dlZz4xd4;
        Fri,  7 Jan 2022 02:48:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641484097;
        bh=xfms9TANy3Zz+RR0S26Hb+XnMo+yJLO3B83lLSXF9Po=;
        h=Date:From:To:Cc:Subject:From;
        b=Mvuz6UaUep/VQ6SGssMg2tmeCZfa27A0bYOwo2MdhnZo0Em58wG46r34KsFSiioAA
         QutN9797xhTedfg8AVht0GGNjgucoQtXVxKmrYN9hR2/FWwByenHQIpqEYVTrlcK1R
         S7GbLfKkvmQIADoZ6AgZKyGtBSuKpcBXjHS8zp9F+jrFs8YuDLtYD0fltqD839pBPo
         w6dQ5gH3/pPmbGjVEUzKqTS4+c1gfjytvTQObcqVV7HaSrI5DnJVJTg+iLoNOysdhP
         M8QJZOU7a1+00s1dS3ukomTmv4enuoQfJrs971x8ySDBvGe+KUnCdCnUA8HvCRDLig
         FcVfZEn52/ajw==
Date:   Fri, 7 Jan 2022 02:48:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Pavel Hofman <pavel.hofman@ivitera.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20220107024815.15dc7e04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X9PCbToV=6m/CZMN1np9f.5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X9PCbToV=6m/CZMN1np9f.5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/configfs-usb-gadget-uac2:2: WARNIN
G: Malformed table.
Text in column margin in table line 27.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
c_chmask                capture channel mask
c_srate                 capture sampling rate
c_ssize                 capture sample size (bytes)
c_sync                  capture synchronization type
                        (async/adaptive)
c_mute_present          capture mute control enable
c_volume_present        capture volume control enable
c_volume_min            capture volume control min value
                        (in 1/256 dB)
c_volume_max            capture volume control max value
                        (in 1/256 dB)
c_volume_res            capture volume control resolution
                        (in 1/256 dB)
fb_max                  maximum extra bandwidth in async mode
p_chmask                playback channel mask
p_srate                 playback sampling rate
p_ssize                 playback sample size (bytes)
p_mute_present          playback mute control enable
p_volume_present        playback volume control enable
_volume_present        playback volume control enable
p_volume_min            playback volume control min value
                        (in 1/256 dB)
p_volume_max            playback volume control max value
                        (in 1/256 dB)
p_volume_res            playback volume control resolution
                        (in 1/256 dB)
req_number      the number of pre-allocated requests for both capture
                        and playback
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  e3088ebc1b97 ("docs: ABI: added missing num_requests param to UAC2")

--=20
Cheers,
Stephen Rothwell

--Sig_/X9PCbToV=6m/CZMN1np9f.5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXDz8ACgkQAVBC80lX
0Gw/bgf+Kjwnv2dYJhdrviryBJJ4yXFlddJSjBRIR9BbWUUBD08PCw4qSg5OYnPv
IsnoLF+O+tAwMYq4BIrVw29FckwG+fozjGJGtEfqxAD77phv7mYSVaLofTqNwaTv
JFu7r9cetXWeZl6Fd4ZDtyi9MpKqrJz5gCWeE/VyQZJXVH+O+lzk6DP3SMx0Xuhv
w46UD8aIWYNmrXZ17TEDZanO0i7zUGq7dwM/CT1vrVs5HjCiYQLiU1Vm1/F3dnM0
2f4WjkbbmkbQ//GSMQDsUdbrRqVwN8ayq4wterl4TXI22MAI7ulrRUpDjYLljGjO
TP+u3nwc+ojF7at+1hmKX0eARAHYxg==
=TkpT
-----END PGP SIGNATURE-----

--Sig_/X9PCbToV=6m/CZMN1np9f.5--
