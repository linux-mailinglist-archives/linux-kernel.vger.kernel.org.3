Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B24B9672
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiBQDQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:16:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiBQDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:16:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16D27828C;
        Wed, 16 Feb 2022 19:16:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jzg2X2PzHz4xdL;
        Thu, 17 Feb 2022 14:16:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645067765;
        bh=Q4H5ayK/zhcWhlzOz/RZe9o6CtiF6QpdLOqPVjAx62I=;
        h=Date:From:To:Cc:Subject:From;
        b=q2szfDlnQGxWjelfHefyI0SCPx6I6RuIUlvien6XYp8ERAHdkfopY2qL1wcgm0Ik2
         GRibm/XUHnNX9R9AZqoADuA57U1shrMzOiyeOMPBCG16Yit6GqQBOJIiPWaJA6y1qe
         4SyBb7MDArDq/ys01wtB7yTVbFhO2ZYA7rN84ASjCEyJhdNWq3IGObwgpevGq74+FX
         J8IdVQYKSJ+u51HzhjZnx14yITSX345IZOcHNqEw91Y8/+oYLXStszADHetA4I+Zde
         ZUZogiFm7NlcKkOqsNXoeVihKIHH7RmoJ/JlQyKgHB/Wy5exkE18hUP9cuy0htxniO
         l09T70WlG9G7A==
Date:   Thu, 17 Feb 2022 14:16:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>
Subject: linux-next: manual merge of the staging tree with the kspp-gustavo
 tree
Message-ID: <20220217141603.7a0ef4ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cOJ5DoEW9RgPsujCwh._Ol6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cOJ5DoEW9RgPsujCwh._Ol6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/r8188eu/include/ieee80211.h

between commit:

  fbe9ccfe809d ("treewide: Replace zero-length arrays with flexible-array m=
embers")

from the kspp-gustavo tree and commit:

  6c36bcbfcef7 ("staging: r8188eu: remove unused structs from ieee80211.h")

from the staging tree.

I fixed it up (the latter removed the structs updated by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/cOJ5DoEW9RgPsujCwh._Ol6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmINvfMACgkQAVBC80lX
0GxPlwf/YT8wvZ1WHcyVSsSxoLEiYyKUTAOIKy3velPLPanzPw/uQ61VUha+5Xyv
EwjTOjhB/s9o5FeRWpza/wU04EiffCU2nFsXM4kdgodfw4tnyXMcHQ+Mf+te26v6
asda4+Kl3OF4egzG2LT2f0rKFHbxEbKhnTL5PObNAHDRBARjYziZQnkdm8ygiZZy
fg6e3Q0GF9LjI6AUBeYGDV4XmlkIHkqhJjuhTUaJI3ilFgDkJGD6Wa7Bch8qVWNd
aMdUcf37eFzgQYEBommXVZC8MQGPoRZKJhR12bX3WdVOmKWtKeRNlp9QZL6XE0ld
N79VNiGXKyRyFcjYsuHoIGkRFBQpbA==
=bzpT
-----END PGP SIGNATURE-----

--Sig_/cOJ5DoEW9RgPsujCwh._Ol6--
