Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725364D70E3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiCLUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCLUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:35:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC161DDFF7;
        Sat, 12 Mar 2022 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647117223;
        bh=p4wbiBI36jMJowzHLs3ZgbjNxhQ76VxJT5fuQCav8FI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KaCWSgbEZIaXfPQrNXb0RpGmovRXoFVa+9w0MPbLk4WTNe0pqpybqoXNEdzcG5geF
         1s9SxKvh3qYAhg61snp7EDScDGUNVMemxLvlJNXWZqG5FSzliHch5ExB4ODWL7norW
         a/VylwE26aiFlZII0H/aHGSNkQ8o+jxM41JVvNJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([85.197.41.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1oE96q3Q2k-01709c; Sat, 12
 Mar 2022 21:33:42 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-media@vger.kernel.org
Cc:     linux-uvc-devel@lists.sourceforge.net,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: media: uvcvideo: Update mailing list address
Date:   Sat, 12 Mar 2022 21:33:22 +0100
Message-Id: <20220312203323.626657-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vvcaI9pzXryVVgQLazU0llTITl6EseKIdEQP3Pa/CXHpdvNo6vq
 8CTrZ86AD+SHPtRLpbxktG7o3nzkLDouxJvYsscFI4JaCEcjyF28J5m5enAg5Y1VKcR0Unf
 V+i0jLrUiIRltWZCTXnXIZ46qq12Iwgh1Xbm6aLeRs0lqKOyVMhoVeKX7TtbJwTcEl9CLQO
 SR1pad0L0YZIj4B0cM6rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/DhTd9E8QoY=:OvZg1ILnF9i7GvsvdqLYC5
 zn+gvDAvB/5Vm29z4Py5m+AFdkH+Ih7+fKMVpGp58lpi9/Iz+Vm9OAjO05LWrSf0nqXHVvqhJ
 +ciPgm08t3X6Ym0PdpjHiJpM1vdvDiJpwQ6/EbW7x3ByKVoXZe0WraJzthG80SqXZgvWXxBwj
 vKE+zUev9W+jKB4+kIHe8A5t4Cwbbqz2hgPkuGHJ8mqT2w900GAi1Ldu2N22MUNsO1Cp+wQ4N
 yxdNbVUKevw2A7wGyHJ03yEsoBK6c+T1lrEdiAunskgHLt+MKBZi4jzKBjsCIeZwR59XzmxPx
 SYBSuEHhl7g3x9Mn6OIlvzstrWdIi3MOROqnkIPj/2gTwOqhzOp0Cbc204a/8+4o0u1EMNm+4
 8sEpfseWAXYOnYWbm4e+3WXKlFdzBasDf5lH/IBuGbD2X9cuNQLK/tprn0c4Wi3BYXmNNqjKw
 W9u9zgvQjSTp3PdyVa+69e0vcFcwAaZIerstzAenlIER2D4ZZX/r1mb4MLo5Zu4PDrxaIb6gY
 4htQ/T4H19igbfjIEeTR1JTHIz/m4u+pBfd4UJbUOim4yTRMavSKL8lqEc2h4pd6gcnL//Xn2
 UR8SmZaNb2DxFjdSu9GmlqmXZYTCyzLN95Rc35lM1JzJtdoPg4hdrJM8svBlpSRbDroQd+FzN
 Z8NdhGiJ68AyiXVlTy7j8PWAwjkuxhNDvr5esuY2AlPpM0jMxLCdW2hfLSRSeE4mbU4gUmWNH
 iTL70CxpkQ/jb88fZfchnMWlryhcUT9MyOdkbxZXfon+0z+509mnkgOzQwfN3yYm3cN9PY9jQ
 /p332MVHISP6GuPOwQWHbvpOmjZVPLXjoNMBi0RKkXQ0zA77fXYmh7eyFzYx+1E5cSTZroHfV
 wOs2TD1PAbm9EO2zsadyzWQuHyYEijO1dq5K0dLMVqZVA78EfM88KRsP/bX/CpdEx7HpXY/61
 1vKfX/ulOinaKJgkemq2hwtU41sVxuVdGu9EhjYo9IhXC1FL7Jlue6DWFEla9eBbMQT/Ogo6u
 Q5m3uRsr+lDOF9Tb98viVqcDB5nRk4g17FE4zQeIEiKRFfCpGYowdEde5kxk0ICEssfReUW71
 XjnDowH4Z2ztF4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailing list address for UVC development has changed a while ago,
but it was only updated in MAINTAINERS, not in the documentation.
Update it there, too.

Fixes: 616bd4e2573cb ("[media] MAINTAINERS: Update UVC driver's mailing li=
st address")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

The ML is marked "subscribers-only" in MAINTAINERS. Perhaps it would
be useful to bring that up in the docs too.
=2D--
 Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Docu=
mentation/userspace-api/media/drivers/uvcvideo.rst
index e5fd8fad333c9..dcf992f85d471 100644
=2D-- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
+++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
@@ -7,7 +7,7 @@ This file documents some driver-specific aspects of the UV=
C driver, such as
 driver-specific ioctls and implementation notes.

 Questions and remarks can be sent to the Linux UVC development mailing li=
st at
-linux-uvc-devel@lists.berlios.de.
+linux-uvc-devel@lists.sourceforce.net.


 Extension Unit (XU) support
=2D-
2.34.1

