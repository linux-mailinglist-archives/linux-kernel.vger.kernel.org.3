Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7FE58E35E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiHIWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHIWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:42:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB465661;
        Tue,  9 Aug 2022 15:42:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M2Sjx07nSz4x1T;
        Wed, 10 Aug 2022 08:41:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660084917;
        bh=5oYxSRw4GDm8hKKfPqGHBSj35HgDEB2NvoOpA95Zfkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0CKPzfXeBSOAZ/XB2/CyWwSVJ5xdttajFH69ysTvxRK9kRRXPqdeLGdx82C/2HWB
         Zs/cA+5ouG7Ur8ongXuWlWmE5Tb7o9+3yeC+IX3435q/CQ7izc6QX9LsL+mCPZVINC
         yGeE49vFuiDA7f9NodyfEulE+jynH17Yq5nBkAb0bcU0dgH8LrxvpNcb59LY/ACkcJ
         sHXkHcfJQ2Qg7VfMAuKMB3B/Jc4lL0LpJorDYBz6CdBxTBDDVLxCHje9aIKQ2W4Ntf
         pcR2PCFHw3NgY5LqPHqrMJNBj3uP1eW3n7uvnmZUlPCVIXtCFUlEDV9N41fM6EfbMK
         XzzIhY44FXkIA==
Date:   Wed, 10 Aug 2022 08:41:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-bys missing for commits in the vhost
 tree
Message-ID: <20220810084153.4ac7a75d@canb.auug.org.au>
In-Reply-To: <20220809181520-mutt-send-email-mst@kernel.org>
References: <20220810080139.71f67609@canb.auug.org.au>
        <20220809181520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cl/r=8e_BeRMzs.sLNmMZG/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cl/r=8e_BeRMzs.sLNmMZG/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 9 Aug 2022 18:22:38 -0400 "Michael S. Tsirkin" <mst@redhat.com> wro=
te:
>
> Oh sorry.  They are empty, they just record that I need to add an ack to
> the log of the previous commit. So harmless - I just forgot to squash
> them - I would normally notice as I prepare the pull request.
> Fixed - if you can pick up the new hash I just pushed pls do but
> if not it's okay to test as is, too.

No worries, I fetched the new one, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/cl/r=8e_BeRMzs.sLNmMZG/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLy4rEACgkQAVBC80lX
0Gwy9gf+NCM3UMJaWxBDMOiMVbvJm2WW73q92VrHXqOOZK1koleNqlJT1FWqFG++
tyWQEx3JwF79yjFfO0uKdC5gHqtF1J/urhd87V7vAY28LNQaBtce9HiFCEzvvPvW
phfbNUakUpwdOXHrBU2vXlhHJfvqh3jlijKbxdJ269Y6lWs/g/iRk4o9LrSZGcv4
nhi3BthjLuGkNR8JabWWWAhE9tbOzdRq0ClViGtSoE4b3cAuNEk35/99IfeGdBTA
/8Y88a0oy4Wp6geFZaWXlLK8vMzUYluDF3FNHb17tLzwLwNDzbFmrh2eIBx2c+Lo
G87HSojGj28iGwJN8zvEby88ace9yQ==
=g85b
-----END PGP SIGNATURE-----

--Sig_/cl/r=8e_BeRMzs.sLNmMZG/--
