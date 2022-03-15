Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD214DA50E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiCOWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCOWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:11:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702AC55489;
        Tue, 15 Mar 2022 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647382211;
        bh=xM4oQR7OIYhkFU4WGIccTCaere6PdIYnlMfBAvjxxBg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ol3kShPLRkRdDbiv96OKUfWMW9cxEKFgg8JVBNTXP3VjxwCLrcnG526uuu1NKhx9Y
         JUjzi+9qmACwthiEjMkmEP8GDVn7f2JyEBoo+Y/mzQNmd0bu0sTtUrsJNNiC7fcpIK
         F2zShaWXKuCk7MihzoBVd6bODKNEHZnMNvMbVIA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1o7pND3Vtx-014Vu0; Tue, 15
 Mar 2022 23:10:10 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Date:   Tue, 15 Mar 2022 23:10:06 +0100
Message-Id: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zoHKQfF+3R9vbpcfwUudeUTFqC5qNt5OTi6HV9gEsEIjLZxYnBw
 ArJ3NyQPJnaMvcL/KI/kwoQ2b069LedHhdhvk+yIxZ0M+zQISsFxhnS6DdKMu1Tp5cLrG27
 wSEf8fIcpTWPfwPfJZ0bTHLNt5wiAd7Cr+Ip+XFf1PWCE4vz8rKKjxva7MnFymFIVyAtVsQ
 HMb6J8nM42GkKHBLWkZxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wb6X+o6SB5s=:Oxik5vkStHR0aks5xkOYog
 xr+dUodkqkmm2lRx+xyd1suYFCbpBmP9ytwBGmSr6rQJlyPeKS0ZXO2O3WPeOFU9SxZYUnmR2
 2lsnQAOJhrSjDStTxvtIhzSxyeCMyd+YKOBlDWAdyByNTvQ5MlT/hgJzTtXpX1/hFFkrrJH/u
 /gfeUvGR2IYM6OCTls8Y1x6hKlzS1/pQpTxZD5ydg0tgD9b4jlwX1WmcYXE7Ejp22RvEkMpiL
 KQhxRRpe0wGQZnkq8BCdMJi23SQPay5ogKYgi8OQ9Nvq3PhUGZmOptxnvoX6u55oVjE7j3V5C
 GfVFr67SlaXSi9OrxoYAGvLY0dZhkm1gFXvDdzXzC4Fb/e/0qpU+4THRW6ZXRLyvPGyx/5xZF
 w1GiaGDjUcWTWjPWMgI9LIQv7IcnCbLK3xfM9KbKiqtQFQe/vUiC/jse0VrvV1HkVSwfx1687
 91etbEMBhz7uHXvwdGxo+ko0Yx2dl5ypNKZwKjO9KAVHQNjVZa7bedAW6od6rL/l6O4GL0GF0
 uPSGtCsYu79XvaoFu7Vo9fvfqK2D4CzveI31U5wEgY9+vBKqn3TxdVR3XoevfqKKxRQptYKey
 yb4iJDYQeFIkwXQxl5SR+upi81ztvGU8SpTgJ+tIBEBHA5hJm1PExRfRj8GzImiePRr4ffCak
 vXEhORs741dipPoT/VsoQiaNHnbQZB3FBb2vy+xuOfn5W1MXujJpPBI6j1nsUUEF1OJRzREJD
 Hg5JZEKD418/EZ64NpeQcCMYJilXl5jr1BGDrFSIvc6HvUfxL65/R09XhtpKqm4PV86c5MiWi
 2OvZPphRwnTK4egfoBH0kt/jHl9KkqlSemgrdB+1+YH+LtY/7+9xaNKWJ0nS/MHc/8bHVT7YG
 naij6aG+ch0OXvxoZWwY6Us5AF0m6XLKBqeSRAaLm1/asAFW/B0rr7xRqwCEg3yXyoXUHyZUx
 sm91ZLOL60Lfeuuq47oIMmtEFHWkQbAkA5MhYpNQGij5NIyNGt9lxL8JeHFbJRcgiZu3kz6YH
 zshkjKFXXKHNcfdHq77DSzrWoQAR+qYJzTcTCQEtOlPr6nuMirhAPc1FFEa5x+u6HYyN16t+V
 ne6dXevpJLgDBM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with other developers, the linux-uvc-devel mailing list is
not very useful anymore, and it's better to send people to the general
linux-media mailing list.

Replace/remove the old mailing list address in uvcvideo.rst and
MAINTAINERS.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Changed mailing list to linux-media@vger.kernel.org instead

v1:
- https://lore.kernel.org/lkml/20220312203323.626657-1-j.neuschaefer@gmx.n=
et/
=2D--
 Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
 MAINTAINERS                                            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Docu=
mentation/userspace-api/media/drivers/uvcvideo.rst
index e5fd8fad333c9..a290f9fadae9d 100644
=2D-- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
+++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
@@ -7,7 +7,7 @@ This file documents some driver-specific aspects of the UV=
C driver, such as
 driver-specific ioctls and implementation notes.

 Questions and remarks can be sent to the Linux UVC development mailing li=
st at
-linux-uvc-devel@lists.berlios.de.
+linux-media@vger.kernel.org.


 Extension Unit (XU) support
diff --git a/MAINTAINERS b/MAINTAINERS
index 05fd080b82f3a..8a0aeb1b98786 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20154,7 +20154,6 @@ F:	drivers/usb/host/uhci*

 USB VIDEO CLASS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-L:	linux-uvc-devel@lists.sourceforge.net (subscribers-only)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
=2D-
2.35.1

