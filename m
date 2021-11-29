Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE5460F62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhK2HgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:36:13 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37257 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbhK2HeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:34:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J2cTR27GZz4xQv;
        Mon, 29 Nov 2021 18:30:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638171052;
        bh=XLUAw31g2hL7dLzC6ws61gJhzOb5F1xpkHy2CUXmIVw=;
        h=Date:From:To:Cc:Subject:From;
        b=CQKLrbhIK6IjwcTi9lNnzkX8vEInH3saRQ/HgsLLWX47B7WJ4Rruf+21TH2zLreYN
         IdTQUNmdF1fv+pM95ewnP66qSGGKDUANFioLqhW7k/rW254A6/4gm7sODpT5bg+dY9
         vfr8XMs++D1yy7WJjlBoAkVSHsKWrTrUiRKQrMoCOfzAE5GIgmnlmlzlv93B6T+CBK
         BAIkjfksxSc/k/mUYGVcBotXn3rrN40uDw3z49iK0QVhaibbT4uFRu/F05g9Yum2U1
         l8Ss/jCNRfs/+bCiu9HVrdAXMN2wrbyb1YzWy2rIhnTGbI8axJMN29QC5FoKUdqdXz
         hRTSzgGtt3DUQ==
Date:   Mon, 29 Nov 2021 18:30:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mac80211 tree
Message-ID: <20211129183047.133cf01c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W9xO.9p.CLxgNZHWv+ae1fi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W9xO.9p.CLxgNZHWv+ae1fi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211 tree, today's linux-next build (htmldocs)
produced this warning:

net/mac80211/sta_info.h:208: warning: Function parameter or member 'ssn' no=
t described in 'tid_ampdu_tx'

Introduced by commit

  73111efacd3c ("mac80211: fix regression in SSN handling of addba tx")

--=20
Cheers,
Stephen Rothwell

--Sig_/W9xO.9p.CLxgNZHWv+ae1fi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGkgacACgkQAVBC80lX
0Gy3AQf/W0p3Aq7h0GEuxspyg9pS4JmRFV2kN0L8M4dQqLsNbeapy0PH9udBTdsB
Hyv74oHyZ26UwqzQWUJMDPeu7kckXLQWECc+AopvhwO/2OUOEeFoTIpb8Zs35tfd
wnIe39Lu+EZd7Gjqx0EwgtpzAOfEFgrmIBk0DZJuTROdwr0hTavbsbOyzGKFO6Ke
dUz2Z2sbZNXOHVVZFFjVrvFqHfRWobfSovGQAMI+5tBuAZwHrCKa4/yoa0STyilQ
mjcRkXvsrwcfbIOacmfSFNJQhTfvXJuqGQagHH7QBjtnB9qDiDx1ez1lpzeQdRmB
Z5Y+hXUqMgMePqr86Ju/9az+HCFsHg==
=at/Q
-----END PGP SIGNATURE-----

--Sig_/W9xO.9p.CLxgNZHWv+ae1fi--
