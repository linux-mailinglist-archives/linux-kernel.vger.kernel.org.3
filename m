Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1950B22A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445230AbiDVH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445142AbiDVH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:56:19 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA351E53;
        Fri, 22 Apr 2022 00:53:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3131DE0167;
        Fri, 22 Apr 2022 00:52:42 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AoAItcZSh5Jc; Fri, 22 Apr 2022 00:52:41 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1650613961; bh=nA+vS/aVzkwJ49gPvwKQ6UgaV68rU6pGl2lO0ta88Eg=;
        h=Date:From:To:Subject:From;
        b=QtBob9lhd0G+InpAoTMAeVeCaUd5hyFdXvRu1rsB76PW95nrZU0aQNNnkkzHlWmv9
         ZJOVxgO4RL+CvuBv3suh3xIr/WD8h5eqXOYyoGgeXuH1eSJfa8f1LI+nULLCh44jXP
         0ZT+2+CycbgGFoj6e4oaA6hwOse5KhKjHYwTxMhIMCqgzVoODbdVTRTyIuiSsueIhj
         ZYYVXjQT2hLCp7v82XJk5djl3o+M7dQBa9K2o2B4sz2cQ64BKHKjeuOsDXwhtLrOJ0
         bMufKrJgTiTpPqo7DpYEtm68pWeeSbyY5FCtnyeHOWGMtGnl9C/yend+CT7IQRLi+t
         IESyypXwnB6Eg==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCH] Documentation/media: Remove incorrect statement
Message-ID: <20220422074024.1329082-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QXXw6oSReTxGpImYAt=+y0I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QXXw6oSReTxGpImYAt=+y0I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
Hi,

I tried to debug streaming in libcamera, where I stumbled upon this. I aske=
d around on IRC where I was told that this statement in the documentation i=
s wrong, so I'm submitting a removal.

Cheers,
Dorota Czaplejewicz

 Documentation/userspace-api/media/v4l/vidioc-streamon.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst b/Do=
cumentation/userspace-api/media/v4l/vidioc-streamon.rst
index 0bc86f06947b..1a79313a29fa 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
@@ -43,8 +43,7 @@ the capture or output process during streaming
 Capture hardware is disabled and no input buffers are filled (if there
 are any empty buffers in the incoming queue) until ``VIDIOC_STREAMON``
 has been called. Output hardware is disabled and no video signal is
-produced until ``VIDIOC_STREAMON`` has been called. The ioctl will
-succeed when at least one output buffer is in the incoming queue.
+produced until ``VIDIOC_STREAMON`` has been called.
=20
 Memory-to-memory devices will not start until ``VIDIOC_STREAMON`` has
 been called for both the capture and output stream types.
--=20
2.34.1


--Sig_/QXXw6oSReTxGpImYAt=+y0I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJiXlEACgkQADBpX4S8
ZncephAAlO6B9r1+L0bTgLSblqcFF8Yi9L6Dc/WgxdLfjz1VoZr43AYz1t44Mm/T
oUh6Ky45TTWoB/zX+jLUTyZZ8NfJvorViq+KKwGLutcZz44k80qRxsw0sMyQzanH
GpcprRz66WuiPw20G5XamS5Fa8KpHj70NDcU/9AlNTZh5EIKCb00gv1IeDh61+mv
Qn5e884S/0KqgLZp3qgodCoCNLKD2iJcIqJe5lUJVOXrfYjpR2NcGMC76lMTy49t
a3WpUpHr65EwCjyu8/9aj8MvVKacQBOxEer1Ki9aZYtWEi3d+221H8zqWuu1xSk9
RjOBtYYT2Ol/+KTlyvSt7lkzrm1MSRcsXH4he6riYDCPVTNVecpC6q5zyvk8QMmc
LxyniNpFhZPDOuba93BN2E/aVhXNKu6XKhyntSGhNcMJTUn7uYzNE67qD8bfBWYm
2bDLjlATrELAWVEnn6PqRvtD2wHECoDJGEJewAZBSqYPmaqpkymI2nR+YgG/w15B
qWm0E4ehp2UvQRQUyy8rh1uDqSyPswjmuE10rukAWDHpJF2Bsl26GPu8BQZ9mfbB
f6oUEP3587Ft9VYQ1ww/tFlDVhCScyY3VtQrkSBWxx/GkKEVqdFg005mWbF05O0e
qR8y/U2SvNwIa9O4Kg/YqaW+/+5KO2JlvcWNU+5F7jPXHZ/G89E=
=slsB
-----END PGP SIGNATURE-----

--Sig_/QXXw6oSReTxGpImYAt=+y0I--
