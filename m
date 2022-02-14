Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D14B3EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiBNAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:54:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiBNAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:54:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FC522DE;
        Sun, 13 Feb 2022 16:54:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jxm2Z6F4Nz4xcZ;
        Mon, 14 Feb 2022 11:54:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644800072;
        bh=ocDwSD7bCblHT7UKg4UyZyYXJz6H2kFovkRwt8OFd6s=;
        h=Date:From:To:Cc:Subject:From;
        b=Q7AkeKwVpZQQLpsEbGTIVpiDpbCCUwinB6K84h7PA9E30i5ZdghjXzGEPhOv6LOr8
         Ksk7VcEabKszu7um9/05w4C3sZ+ELh/Bs/Lk5LsY8hzt3OZuusFmrofH6+5sdi8xPa
         44PklDXSdL4yxjAsB34rZhIzS5rALd/XIOzOH6y/1IKFfKCZvj+DJozcyIW1rTVEPO
         xGaBOEtFumjN6+4S67iTryE+lLkANbIpGEc5fOO3TwSQIs2ybgsSr8TlqHQIdM17hp
         fytwLo6ZDioSx4Pz3C9DI6oKgNNC8zrjMpxFugSoPpncGAhPhYshcKEkSiVEQN6xeV
         vGWo0vHBkzpXQ==
Date:   Mon, 14 Feb 2022 11:54:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-intel-gt tree with the
 drm-intel tree
Message-ID: <20220214115429.16613f3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eURzRz08=q3T+0BGJrhPfB8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eURzRz08=q3T+0BGJrhPfB8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The ongoing merge conflicts between the drm-intel tree and the
drm-intel-gt tree are just a mess, so I am removing the drm-intel-gt
tree from linux-next until you all can come up with a better way of
doing conflicting development.

--=20
Cheers,
Stephen Rothwell

--Sig_/eURzRz08=q3T+0BGJrhPfB8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJqEUACgkQAVBC80lX
0GwfJQgAiBwRMOvQL4nvcgvQ1I8bX8G+hJle/DiDdRxFid0bhV6v18na6V6oou7K
s7jgoofbAedlX3bum2KhJdSKotXcirH8BGne2981f6f8r+xQIcmacI8lPlM54JXj
Kv7Vm3cWf+/xDz6aOXEWmyV5YNBF6PjZO3x9z71MGcGMyHTFY+MtfPx2X5eQuquG
2osq7t/bAPhqKo4FNhQNUoFHGpV6e32FvHT+GJRYtY5aGfp8For9/IfWpndDrz/q
znZka0mrJD1OnLcHe4GDgbVrurmdKiJKP7IJ6F7ucIvusfMuOs3iZrVGLWOHTyWw
cqhV1xQSkDGgK6vhpuriK6Xk9Oxrig==
=5nDl
-----END PGP SIGNATURE-----

--Sig_/eURzRz08=q3T+0BGJrhPfB8--
