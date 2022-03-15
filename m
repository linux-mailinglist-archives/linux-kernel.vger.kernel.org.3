Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EB4DA54D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352234AbiCOWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352162AbiCOWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:23:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC275C65C;
        Tue, 15 Mar 2022 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647382924;
        bh=uGf5ssj2+JRlcnLBq5nUQAIohY7WuCmEsDC7du9H4PM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=V7A4yXyT5nIVUx9YMjFiKLNLL1FP7jLK2mbxxa7ll3neUqNHBrhcn0ssN9NX/q4Ax
         tmgl+le3sLxF6Ou5g1sByanO9LkvZp1r6Eb1ye1vE3ByRfsHj0axFgdxTA0Bh0+Hcx
         eS7J5N5zDKt+a18wSK9aTlDnGgCGixYUAMigf+KY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1nrENd08u5-00o0F3; Tue, 15
 Mar 2022 23:22:04 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: uvcvideo: Send users to linux-media mailing list instead of linux-uvc-devel
Date:   Tue, 15 Mar 2022 23:21:46 +0100
Message-Id: <20220315222146.1051303-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ra64OB6sv6u5s+9lL1+pRiuIRotpZOZ5e6zgwNoRWWbYPpaE9Tm
 yzyLcVX46dPNbJD5UMFphpnP1cVAdUIOW08I2rUKGEeEP+8F1aqWNKY59Xf1PFCh+UE8tOl
 Q5x8f0YjP1bkbcK5ZSOlg8aHQfavCw5zKOH6BfMCA8PgA75HwjASqY6bkQAFeHNxm7DrIC1
 S0Wt+Nzo0Nc1rUET9Iy7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3vTU1TuvKSI=:knbVclTgOwFjpdxcBJguqc
 D5C6FgmDau4ihymuax5Y5SO7MrfgrDB1bgpMlXzFZseFMS3dR830cCy0y2blvk2iMLJg5x9Wi
 ikvmfaLlDjSxvtLwoHA73wZjdc0NJlykqQrEtbHOaIL4GcSTrzbYg6XFt0P3Ti0rmFBitYy+O
 eEChwipY5hw91Ee0HqzGiucPBsi+tlqpp7vhTf6nH3PSdQAXMaUQGBV4bwJqookKOpwG4GKP7
 HdKlquURTYfP2YXSJ6fgmEmHrrVz7Ek1BTHpBXvEaAvhET/L0X1qaAsyZU6k6HQKfbbEEYAYm
 n5Q6Api/mSOeflX9+0Mww+7dJmgP3BywP+zzWLJsvxcoQrWmMxhP1+npkBfvV+e80Q5w1wSOg
 IJbg9XugQNxjH7Znx+UeTB8cuNMUVj7WpXrcrFoJjOr1h+vY+mn1hTK5y3o78o8MOEf5GOLPY
 USFHgVpPzipUN7yyP9luTS0KVJYymyr276cBNmeHnwd40I/tjtf65GUcFcMBjd9+bIYIrs3Wc
 5FDLWjfEhnZF5Li5NaKYb3Yr5pmWA7S0fe3370+KWVnWOrqb6MJX57/nkmKmx13EGCef/SYvL
 rlzmeOhYxT0KZ3OvCAP9CZ8Utu7PrEVi7VPFTpn55rgDAYEUBKLKhRB9hWoBHZu0IlbYgpWCS
 iRmMmzGseJePbb7BUDjmxd6/ooXunduHSVQFUHHDXd8ePusOYDIieK6T2ZG2sqomn36POh8RM
 YUVFp7iGH+SKGU97+Bmiu4hLE/iBNjoGdRvesvbfFqbJoF3NxpW5N94y7S1FDv0mcPi7DCngg
 YQ883axzFOikyeDO4n/Q/ynWivfdZdB6Jbpi2Y4Oe5EFZpv3u8GyR41IGGlhn0QVwqk8Z7lUV
 mYI9jLKP3+GAbMekTS4nnT+Hw7xeJ8yJVOX+7zATuR5rYdo3lHwgye0nxm4H28tbZKkvChCPu
 zJksyiazttF8iTGyMkWneapUO/YIi4tch0IA9G2ybTrcB1f95IEz+BBfvVIsry6vkIv/sWcdv
 vfVXaqBSYQ3PvQKCApwUQ/NQLY4hg4xUUuv1Ik84RkItJKpgfaN+AdOK1bt0V261YbZ1kAS0q
 B2jHOMe7xJycus=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-uvc-devel mailing list has been deprecated in documentation
and MAINTAINERS. Update this message printed by the driver, as well.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uv=
c_driver.c
index 5f394d4efc21c..6c6a82af07cee 100644
=2D-- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
 			 "Forcing device quirks to 0x%x by module parameter for testing purpos=
e.\n",
 			 dev->quirks);
 		dev_info(&dev->udev->dev,
-			 "Please report required quirks to the linux-uvc-devel mailing list.\n=
");
+			 "Please report required quirks to the linux-media mailing list.\n");
 	}

 	if (dev->info->uvc_version) {
=2D-
2.35.1

