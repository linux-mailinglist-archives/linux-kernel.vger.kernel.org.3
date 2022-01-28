Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0A4A01C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiA1UQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:16:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:33587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbiA1UQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643400958;
        bh=gwQ/4xaaK8OULuaGlNyfE3KKSgGWQAQkj7Y9rmCO9Ow=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JEPpzGz1wki1AkPdCQBvOvh1ZvKtBkbjyD85F4j/NyGXh+xkYfAQSGz+C2qhBiS2s
         HKT7XdvQ5P3oqobBL63/oWUdOTlNgD7yfi8z0SU4RyDiJbChAS5jj7E/ojChbF/vkv
         OWJlzOqFQluBmGLOkCPJUYGy/5Mp3d3aZlueboTU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1m8pyN2Iqb-015dG2; Fri, 28
 Jan 2022 21:15:58 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] scripts/get_abi.pl: Ignore hidden files
Date:   Fri, 28 Jan 2022 21:13:53 +0100
Message-Id: <20220128201354.1928412-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NShGPbU75VNhuHAG5dwgV6cPD9CF84q8W/Po24dCXrGMry3OBXK
 Wn/+UpZ6Gm6yTRWGVy4sMOEAg+HIgoPn90A2UIDT0nfn+096jL/kJUaKZCBkZ9muPmiRgxt
 gvCKdC/XAiVdrHe02lMah6bF7coACAe0BGNdgimeR0M2eQuoss/9rwkoZvmEETznqlalB6m
 kwtd1HSibTBn17+sPR/Hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IWPjzIN+vqA=:icESYHU/g/1b15Ey+HSWh8
 U3PomK4EKAXfWH1M86hpCACyv+s2rOcBkZEJn+XVxLcqXkWmBg3lmbLJTKEs/GIcQIAwUZ806
 5S4Ajx1CmFllk5bB7OJCmkDBUIZV6yX6vjS7Wv72vLQ3h4wvKOFvdDcgv7lf/N/Lp6DqvIzGT
 SoeIsZYI6Mvqa/mC0Oj9wxu3YNOtXdsBUk4hVPr80qXdTXekq6NMuDsjQ2mACCtJFXCEbmlzg
 d1FAthwYGAxWawnbU7hJ8hWBN1v+mXOPneyIhJ8JUWlgbstTCLLwbug/EYR6PTvmSS/evxtHv
 vJoWvqM+2JvL67unno2ppMcnaR79xYwiw8pIRuM/E/podPRCYyGBavwL8BW+IYy2dwzYWiltT
 hy73UV1SDXEm4pe6oOrMvQwRglYslGX8Vam/Bh+WXb9W23uWU9aiiiWeH13sHY+ZLBYaU/NN3
 cnE9Ymd0e4OO5LJPKdQgVNhOTCqQtc/W2WZ1759PZwziMMDcxMRGEads/9OkxkCvSdlqpOgH1
 0Es4yxPmAo6HPMQWUYBl0lxLAmtpaAGEv3qpR/ckWbsbsA9YCqg4iH3bVjsI5qk3FdBM9NWl/
 VowTHNOe6CY8YEoEx3Uf3amlkhLysgD9kfTdef5CKSs7I+MHwTvEYykd0Ug69XxZZW4HJf85F
 LAjhX56L7PYjXgseG7hGJKbhtp7yuQzmRXd+NwH5+XkZbFbKPKVc2g7xJYHblkscxAnsL6DDS
 X8ARIfztovJ4Q3//vo5YJaQbXycAVAk1ksF2VQLKZcnFgS0WtxUkE9/tfCKSqUQpVrdCbG4LX
 t/ywyo8jCNbOezTef9i2Eah/c8HZiHgLNmq8t+PXgQxHe6dBp4tsFQezvuKM5T+mICVRsZFiV
 M3zAFZCsXReF6bcNtqVtv/hewVsBnLj7jQ7XWJ4QiRpvaCTGScoAoRY+cY3UChDkize9TBFYT
 bGUdfiRK8R2TYdZdMsbxLHEwXpl0B0Pyyb06aewW9KJIigBCJWBQ2lvl1DtyTNmBl1M9+Elvy
 QRMw2lf0PFK6Rzn1Y4+WA/TqBNPJXc3FJIKopFX+9rFi2gtjYg96KKfYfYcuV8JHbvh+Jn82U
 eOm0D7jo8w0qv8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_abi.pl currently collects every file in Documentation/ABI. This
causes a UnicodeDecodeError in Documentation/sphinx/kernel_api.py,
when it finds my Vim swap files (.foo.swp) in the directory.

To avoid such issues, ignore hidden files in get_api.pl.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/get_abi.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 6212f58b69c61..47b7eca5b0b71 100755
=2D-- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -92,6 +92,7 @@ sub parse_abi {
 	my $mode =3D (stat($file))[2];
 	return if ($mode & S_IFDIR);
 	return if ($file =3D~ m,/README,);
+	return if ($file =3D~ m,/\.,);

 	my $name =3D $file;
 	$name =3D~ s,.*/,,;
=2D-
2.34.1

