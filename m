Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A258E250
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiHIWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHIWCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:02:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE763A7;
        Tue,  9 Aug 2022 15:02:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M2Rqr3Lkvz4x1K;
        Wed, 10 Aug 2022 08:02:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660082520;
        bh=lzMSjjRZ623/wfX/gXAtkJEWNROyr7zFuT4DYyTGT7U=;
        h=Date:From:To:Cc:Subject:From;
        b=Hm+rUNQOIHNrbhsF+vwPQeRqUnn0ppcvwzZVBmc32cesV+OmdUG8TlncZeCldLorz
         ztWOj5UeB9yQ2pCV05cEk/D8po0B+QfCDiwDMRN5YTez3UVi5/z4ROgPDJsuFre9ik
         jAft99eVAfim20NiZvhXsg7kmERKh/fyRDiCakqFqoAoV0LxVB/y0t/T/ypnzJaKqn
         FUaX1g1sA8rAMkqCz9IXPl4yOs7UFvJGExu6+o8NVj26098xy20ZbB8X+mDHOqLoX0
         GpU5jlA2cZV7uq1SFT9aqqu+PpswQVkm6R/9ue9VlLcsOd+A0QqP4+UfK7q9iKiirW
         y1MxGMUeIPEHg==
Date:   Wed, 10 Aug 2022 08:01:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-bys missing for commits in the vhost tree
Message-ID: <20220810080139.71f67609@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ou39+AqS1JaihHQRp/S9sa/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ou39+AqS1JaihHQRp/S9sa/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  2d84b3963557 ("ack! tools/virtio: drop phys_addr_t typedef")
  c6d14c52fba9 ("ack! tools/virtio: drop phys_addr_t typedef")

are missing Signed-off-bys from their author and committer.

Is this new set of commits really ready and destined for the current
merge window?

--=20
Cheers,
Stephen Rothwell

--Sig_/Ou39+AqS1JaihHQRp/S9sa/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLy2UMACgkQAVBC80lX
0Gxm+gf5AcOjbAvago9iCV5vOu/mRmBIhqa+4kYkk4jBLD+Gzw3PzvlejvI65Fhd
pZzRFSyzYDt8nz6TiJmiEZCX48fHZOIul+T51Us4DIQc44P4hKOEnA7MBjQiXFq5
hACGNmVYBoJtHRlNggD3zfacR91W7yd+on+GP0ObbmSzLflmTb5+vyl7TtGWdvp3
ukRYhot2jwxwWpsVGrpfGmitx4+pvliTR89xOq4Gei5DJoyZWLjd4fZs+vFjPI4N
sM2WBq4B4XJPY/c+ddx8rGfen5+psQLncXPSrzHrxBDg9gAXysQemb4MGfRL62hm
qIKJUHCypaCyEx0GOumAzum0TPtQQA==
=cKAc
-----END PGP SIGNATURE-----

--Sig_/Ou39+AqS1JaihHQRp/S9sa/--
