Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40D4AB233
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiBFVHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiBFVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:06:56 -0500
X-Greylist: delayed 618 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 13:06:51 PST
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E90C061353;
        Sun,  6 Feb 2022 13:06:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsMK62s5Hz4xcZ;
        Mon,  7 Feb 2022 08:06:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644181610;
        bh=tHt4mi6UoTqf1dlWCq4Y9eBrz0OZwC9iYgM9KOsRrsA=;
        h=Date:From:To:Cc:Subject:From;
        b=DPyFz6GO6w6nhI1/BoWOI9mXv8+LI+RUV7OjlGTcvfi5k2uVsxADkhEyi8jkRgLJO
         WITEw4bSAMfeNZ3VSIqM978DzQxU+3MKZLK4vAdJE7TTg/tGuBWsa1NlQf4KkXVN9p
         dIPmmmRVTVaLTDPnRZoKGtIswjdjDGb+Fg/QbQELetDn3HE8G5UDC8C3VDZk1oVbgU
         brnLkUn0BPh76zX+C1W4x3371btE63kZC2jGCrMKkDXw93yW2jOntnAtEpDdg/k5Hw
         9nebLzxfEtk+dabkf+WsovTknNQ8YWi6XPhD9Bmxy2nyd+EpQl8DMt89hZEPBGEk3A
         +VOc4qKo2dWfw==
Date:   Mon, 7 Feb 2022 08:06:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the folio tree
Message-ID: <20220207080649.2c13bf83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I18JUNM3fUSqvF7pAeSZZ=l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I18JUNM3fUSqvF7pAeSZZ=l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  975e1b1f874a ("mm/rmap: Convert try_to_unmap() to take a folio")

is missing a Signed-off-by from its author and committer.

BTW, it would be good to see Review-by/Tested-by/Acked-by tags on more
of these commits ...

--=20
Cheers,
Stephen Rothwell

--Sig_/I18JUNM3fUSqvF7pAeSZZ=l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIAOGkACgkQAVBC80lX
0GychAf8DwgO3yTiBaM6O2o0P+5JStl2deNSf9nF5MWslSNFl41reizzXdq134N0
m1ABJQ+CMum6TtMUzReDdCU/dcEk9DNkR/nEsT+EZwLzFlXe9OBPaOHY9K8Mhhs1
UUrWLU2ug19SR/CbbpO5DRkFfVCVrF83/tP8xfTN+fGOsuMGwoFlFnxD3kfSDPBH
QnAlSnHLHVcp0YbxnECPZ1DmH2CzNVEYF1ofTkoqzmbEXkGq4ECgj0BSzMLwRY/a
uD/yAPQKgWmg4IumZ3eJTrH1ZO1ggKapT6AXOxcUN0FBcYG93Qj+l1ZVLvxMZthP
QOxzMYEjmtMrrDGpedWO5bX5GudKmw==
=Oz75
-----END PGP SIGNATURE-----

--Sig_/I18JUNM3fUSqvF7pAeSZZ=l--
