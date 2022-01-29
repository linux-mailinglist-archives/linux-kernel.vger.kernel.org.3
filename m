Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5C4A2AAF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbiA2Auy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:50:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:57869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241666AbiA2Aux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643417444;
        bh=Diw1Yu38TMajSwVTyV0Mz3ACbBBVfaeWXm13ZtCuYo0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KJ2kLNq2Z32iYHQulMMlqmm8mb2Xok1JZW1B9uiqIX3Z+V4s/EuQ0fnlsIhZp68HS
         9UEys9vIZhY77JqK6ktCXR48nzVaej5x/akPcby0yOeTfkAhFdrYpiMOqbbjRhzQKn
         NDbMwRa+sKTOorynT5Fz4IHDjQvRL57xoHPTmZXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1mtKiT1vAM-00Puwe; Sat, 29
 Jan 2022 01:50:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] scripts/get_abi.pl: Ignore hidden files
Date:   Sat, 29 Jan 2022 01:50:18 +0100
Message-Id: <20220129005019.2090996-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j9u2Zu2cquDw+N6/3IDKCuTSyb2QKViD3fdHEOS3yJit5EzSvUa
 wzSgrqw4vFkrdpjdthP+AOCfKyLFqAnksVLmmbSh+K+twXh6lxWBnWjIb47SPyvId7Opxvr
 lJ5Ug9LgrtnnQhZFVUDIfz3qoAdb/OnkIcJ4qYx3cjzESzo3+IWPznTAwgWCqGBLB0OvjKw
 k5WNJYwdyvvzZsKJzOfsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hZ+ZOEekVhg=:vFWodCGU08dm9Bpf1qXdvx
 YpoKSxqtBqtUhTP88Z64L+uf3vdXUq+hJavKFRWcRo9p7ra3xvAzgwPpPnNw7h/vOr/jokqkI
 LZd5k7eDgPFUQ/69eXlErJAahHNKXGGxpvQt0D7pJRX6cQDnX/fT5/3mRZr8GI5VkQtxbSFPb
 Pshs300jKa5kZgae4d1GfR8dmC5A5uluIT5xNIXJU4EI+Q5B6yRTNQKUMqLOYPvj3KbCl6ajw
 CCC7YizbXG2SPjGhcX8h+zpQyQ9OwKSeCkMM4cMMIg/JJTNMg/by8dTketFv+qMv2IrKQWC7a
 etoCk+xaXACw/f91hSm5g5LBJ1KnwIgXka2XMtJxgWmN9b0sluyQpwyqgwZJF7+hbiQkL0WPf
 fb68KyNS1T5F9HEV/WRulZujQGrhZiuR1CaG0RhFG6+BRNVIrnGv43HBUgJl2VVNQ5vJm7r2c
 coEzDuBHPpaLUlNCPMF/ipz5GKcobKPYsjXGqi6wq6E5Rp5aD5OW3JiKzR0y/a51rI5BdC8sl
 E0jEWC6BGbKdvJp+sg8KrLA6RK0s3lk4CwK2eseqBCMXXJg0lu3Br+qL1CvL+OJru3i3hIL8v
 FGTadgMbJM8AfEhsvozg52tSYaU3FqyY4+l/Tho3cr6webWxFd3ZdeU3xsi7qUfpB34ijZ3Q8
 MLYZUwTwTDJnP6+c/FlfqsMRLXdcUNjY6fEKpZC5w7L1EFjANphr+xIUGuL+txXsCwMDgBh3u
 VuEW0KlpunAlF3HSJY4oNfnxuMyETPEMpxb/Qp49wa5JnR00O/li7yfWqNuAjTFOV++eWHIdf
 u+0i8VdmIaaB6KqqhCIV5nF4+kbpb1HuK89pjInFGylt5J+Y+magzwxijB/6BQMK1Qlot2jwa
 f42+B8LReS3wt/YUWZbzcXIgyD16SlzQ06mSSAJy6++tqdS58+trHSdsX18b1cOTGlsQfVUyc
 54TrQqmHbUTy3Tt9/7Ch8T0lakoIxQC5Vqbj0lNXSoDv4n0kOt7hu9PyJ/aCnq2V2C0mUP39y
 XtbtjwXieejZIikxg2gzRaGNcNMvz7A2x1C38VrzGeesBZtvI2zFA2L9TpK5fnO0DrG9UuLPY
 r249Lbrqeqxars=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_abi.pl currently collects every file in Documentation/ABI. This
causes a UnicodeDecodeError in Documentation/sphinx/kernel_abi.py,
when it finds my Vim swap files (.foo.swp) in the directory.

To avoid such issues, ignore hidden files in get_abi.pl.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
=2D--

v2:
- Fix abi->api typo
- Add R-b tag
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

