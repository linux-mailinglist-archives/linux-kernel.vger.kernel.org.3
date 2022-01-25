Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8611D49BEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiAYWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:40:38 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:43259 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiAYWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:40:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jk1yq5ndKz4xjx;
        Wed, 26 Jan 2022 09:40:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643150436;
        bh=/Z7u52vIWMzyap1X/8gzPT5BJqHVjzgBldpQh7dDOEw=;
        h=Date:From:To:Cc:Subject:From;
        b=dHcDt02RRC1r19ceyALlTZPFAPUDJTw9kcEaWXFjj9tolra3Qxv8Rp3dktE+yc8ar
         lYQN+aM4Wb1K0dMSomRyIQcP8h/1/mjChkQqUJ/XichttKJNjx2J5SmrYSFo6RbIH9
         d8WU+Jvgphd8qAWn6L/75zy2qlnlZpgk1KHk5OqTjmOGFCP3T1zpyuPme50PMqJTPl
         wLShhecqjYcwAGawdPzDc6IWf/PfpoRvb1RffHLNJUBuFi4Xbs6e8f49go/GO5/Ywg
         fV77/GsnNLCol4atPcIoU/tHiIoknr8uH6lppQ4u0wdPPwDC9dQgqT0JtV3CnMRF4U
         tcYlm8i/VMbig==
Date:   Wed, 26 Jan 2022 09:40:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220126094035.631da5e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fdX+xxffMnLM9Y_QbH9+mj2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fdX+xxffMnLM9Y_QbH9+mj2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  69bba523d97a ("drm/amdgpu: Fix kernel compilation; style")

Fixes tag

  Fixes: 1b08dfb889b2c5 ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Thus:

Fixes: 1b08dfb889b2 ("drm/amdgpu: remove gart.ready flag")

or

Fixes: eadabcc2bc6c ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")

--=20
Cheers,
Stephen Rothwell

--Sig_/fdX+xxffMnLM9Y_QbH9+mj2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHwfGMACgkQAVBC80lX
0GxJjwf/Wtl67qsfw2x4SZcfAQp5Lvm/yjTtQ2ZqqrAR2Oxe9oBhJBBESw5ZeljQ
KZ6rwcmJM/CyVZuDsjT8PyqT/d/CVcSMVp04DezW8iK9ad7gTzupYC/1uSrh7Ow+
mQxKzNWgH03qbJ1RUNMgx+h58LoGQzjg4cqyXS2x5qAZpq+JyDAJ+RHkSZ0Vaa/m
Bnzl7P7SfKH9RnHKYyj0CwtwEnDLgPmFy59c2rvaPphPGZYCiP13pLoondtTSV78
HNmGL2P9FZvQxOdBgaazypoHHCyhXmXm1f7w2YhZsn8ZEKijt0FzGqMfySM2MsRD
19stpLcVEXEsQId2bXSRb8g1UyltIw==
=Mx3O
-----END PGP SIGNATURE-----

--Sig_/fdX+xxffMnLM9Y_QbH9+mj2--
