Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E2583514
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiG0WHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiG0WHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:07:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77B5142C;
        Wed, 27 Jul 2022 15:07:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtSYl2Lv4z4x1c;
        Thu, 28 Jul 2022 08:07:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658959628;
        bh=09VF2SGH6MbHLa8PegHml9IXa/L6kZGN2zaiViFnXqg=;
        h=Date:From:To:Cc:Subject:From;
        b=gyNOmpqGnWyZOiVhfFE2LiByNDTYU0zAyUQD3mmOJDt3HWp0UfMlQxRtMPv5DXHnS
         VuF0nuRcfce4oFyjkJBrn10oUHTvvbQsY69r5WXD4KYe5O7AMWRM2gg30NmnjC27ub
         7GhJ1MDzd2HhRYjPfH0sR6DElKlJ6Z02iqqXM3PnGVVWK36sJMSTqHbfb5jX+vdyzO
         jm6hbPo7aYZui7/07rUhVqy+xoXlixVU8I5SuKwrqyyWULmPbObOpo9W4FDYG0WTLc
         teaPgOrp/arr5q5hjcyFsG9zBlg3f/qOHGerFDV36xWFY12vrAdiyiPbB4oHkrVOAY
         +o34mAjLgm9wg==
Date:   Thu, 28 Jul 2022 08:06:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bean Huo <beanhuo@micron.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220728080648.767b4c94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4d0fwticbl6wKSP=.oLUbpW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4d0fwticbl6wKSP=.oLUbpW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5509e85fd887 ("nvme: use command_id instead of req->tag in trace_nvme_com=
plete_rq()")

Fixes tag

  Fixes: e7006de6c238 ("nvme: code command_id with a genctr for use authent=
ication after release")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

So

Fixes: e7006de6c238 ("nvme: code command_id with a genctr for use-after-fre=
e validation")

--=20
Cheers,
Stephen Rothwell

--Sig_/4d0fwticbl6wKSP=.oLUbpW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLhtvgACgkQAVBC80lX
0GxFZgf/VN5b7W0XHErICzQktefpRUn4usABjo50rvUYMvmUBxlI62qSGBA6sZmz
rPwrWdZNxhtqxaVrDq1zHfzwGiktY1jZC0RmWYuGumrfbSuQ9Ovurk8I2r/ivKg7
D0Jjd5vzmjX2yFO4d3WaVjpPcRbqSbyrTpkWLc6oHR45b7BbmRvVIF44qNEWbPDZ
HPb+066ucOF2r8Rbrs5F8qTpSHzO3hZT9EAu7FPwuLZNQRdNqU37UFcpI4czGHQE
F3l6uB/0M9VY59Zk0rhCDDYv1UJZ8pdJ5DeydN+ljNwicx5U3aKYw/7WB7Mmo8II
+taDV1IyXHaGmI183Vzp/RDZuX2gTA==
=II5Z
-----END PGP SIGNATURE-----

--Sig_/4d0fwticbl6wKSP=.oLUbpW--
