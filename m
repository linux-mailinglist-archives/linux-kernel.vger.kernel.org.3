Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95559799B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiHQWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbiHQWVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:21:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0381A1A49;
        Wed, 17 Aug 2022 15:21:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M7Mtz2Tr1z4x1N;
        Thu, 18 Aug 2022 08:21:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660774907;
        bh=SaOtZrx7vNOSIz7uZQSReKhzMZZq9Pq0ayCJwhsE4mE=;
        h=Date:From:To:Cc:Subject:From;
        b=WEVZbCSBjcsDYMMm3uIxqQIs078k/YUFVGUtb7A0PGgqoXUiBby3TkBTEsefbBoiF
         GkJsSVM/yLJ9/H/T7EECNL1LhHXMj4L0aeDki1zSMaEIFK+7L52uk24JIzwisy5R4d
         xA5eTDmGVE+pGa09EPqs142P/1f3K9a96kYPCn/y3f7WqQpEjHoJRPtZU5g270e9Nt
         4uBnoe04vmeBR5GJMTuFLjVnf0sX56mIlbsAR+GSTn7/0hW1EGS566Tg43JWKP/i5R
         NAqe6jwJJyNY2okvePqM/HqlRw70s1oi0azsDuky2235EKfKuB23eMOhbGj+/LFPzZ
         e3ONMLkZhCNfQ==
Date:   Thu, 18 Aug 2022 08:21:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20220818082146.4ec2738c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YUoBf8X2jlh8RTrCVNFgMl3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YUoBf8X2jlh8RTrCVNFgMl3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f08791fd0061 ("cifs: remove unused server parameter from calc_smb_size()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/YUoBf8X2jlh8RTrCVNFgMl3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL9afoACgkQAVBC80lX
0Gyw6Af+Puths8II3qDzkKWnryVeeSCiaqRMaHwEkfCMy5it7hmCYCL7my3CsZRz
3f31WvV9LowlKwE3tICU/EdjlfxikQmyCA6ToC1kNqsagrNHbWnpJlk3WGc2zeGg
cu7jNpc3UXayRKNlvHOJ0bH6jAIR8RlZc0BnjD0DIjf/srvmNkTlcs8+XXTqJeCe
ptehNg6jDe8miabXj8ws0yzu9/F5Dr6BlVRNMovwEDGPfK/lKCCivz4wx75pwasd
QOGaORj5c68y38aCMyrYA+EhjxgfE5MNkhceHWMy8lqP6/qCjLoWpTeXmXoIRL7K
ZXBcrgCw9asC2rOM4UW9WGLAKpScww==
=LlbM
-----END PGP SIGNATURE-----

--Sig_/YUoBf8X2jlh8RTrCVNFgMl3--
