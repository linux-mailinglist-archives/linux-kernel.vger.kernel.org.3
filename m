Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498D59FF27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiHXQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiHXQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:10:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E3A4DB4F;
        Wed, 24 Aug 2022 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661357418;
        bh=7mm/yrPnEWFWZR/Jlf21nIbJSmJwkfcdwaQyebvIAQ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IeFDWWWg/Womv8SFsMA1qj48+QZuOnhDYyulqfO/K+0hg/6/GHZ7gn6XASUkH6k2R
         2NIi5hFRCUiAFv4dCGV+OAWe10w8lekkUcrPTUt4ZrZ6ivnPWtHBIM8BJ55mmmVCjv
         E6IlQAee3C4zKzw+1mM6XsSBVUlmn/YOHtv/NKAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from silverpad ([82.113.106.57]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGhyS-1odaX547Pe-00Dlch; Wed, 24
 Aug 2022 18:10:18 +0200
From:   JFLF <jflf_kernel@gmx.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     JFLF <jflf_kernel@gmx.com>
Subject: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Date:   Wed, 24 Aug 2022 18:09:46 +0200
Message-Id: <20220824160946.10128-1-jflf_kernel@gmx.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:INBwlXI5QhpWoz/qQX0OcR52mZmVSnqRiNsEVK+pL34v67cjCvK
 Cn0iA7Os9nN0nf+46p0PVYK77AuVewBJXcfP5LLz4sYymrhK0KiwvOaevOFu7jbKgS2txXd
 aHCUbI0g4q8tjrFoeQnm9FsKQeul6nfTrNROTG9ql8NDbRg6uGLW7XUHkVTNoxxIwgXCPWE
 0pBL7koYL1Go14v8B2vGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rHjN7vGzHVs=:ls50/fZyBRhhA2Wgd2uq9e
 /wr2tYM49tUiWgqNY9Xpk0e6U9yhTMSunz30tJLS8YfmaFO6+tsK0kvKoPML7jE0d1nh/aHGn
 ulW0CLhwt1lqNKmCg/NE+S4z0jk9lpj2Yp0bB3tsSqOqqe8UG0YaWpA4qUz0/JHjxpRELsE1j
 CtjPNw6PIB+zACWZykgoP1IWhf2HbQGsGJS7VL7TtQlotie4nlDO+zPqe8U6ICcybGwKWAOj3
 KwNlp5yPDYxRN972uPI/3luwP3dcBLytUBdCsKzmx5EMTXte7MCIZ/q/GxJz6ZndqIqDmPEYP
 983bXJ6z64I6nJXZhOVQCf28R7cbV26zml+/P4nBHb8giWlLlZjGnbg814irOFL3RZW3CLqJD
 cRs8vXKLvQAQsiUqFq+SnbYP4A8bPEakEl7oYIGJi1opOJ3Yn3LtxSswWnUnq3yikuv2k+M/U
 j4BJOPRpx4DzeE255gDZrYC2eZChrP+yyd3EFh14bqyepLW4g1UIV6eNnO+poa9Xu8b/aXGX7
 YXjQo0C1kY0CD/xZj+pKdwQgFaUKWrqL6+SRhZU1y4WEMIDxouG1Gww5ryCpP0iUYx3bOvBIV
 H5ii4oaOlcXsaL25gSgYA5R8uCDvnhFvqdsK7w03leqzPCjizo4MA8iztTTNgr1d0te4F4IvG
 RYMLQDuyyaW3tO/KLlgpoKeTktEgreHyoTsPcr0OMSaJsAJRw4C2KjuYwY7KW3l2Ns+K31hOW
 LwYPRgyJ6sj5CkuGBDFLCMzJDWUE6USm+exXqFeJtkVUDTIusudb4/U6SaVfkKMWVLAE5reiO
 GKMNL2wLxEATF0JZ4rIEuTx5FZhQ61oitNY4nGnf7Nc7EIVe4lXIvKiAwh8SNnLYyiLSeXOIb
 nGg3Q23iN/xOxeHpUIvRx5JGpaVh5GedvbyNgv/AB6wPdb4iZBzMGJ8TX6jsrhispD7EP2pSO
 unce6V4nQkyKyV3A5rdaAmiSt6OaV1789JXypRQTrGyB6DKSYe5/VcsDf+ycQGZvWFYNB4Zn0
 nBY37lH48p783jr/J6qiEfw23x1FQuBpUNrX2osRCLmfVhv0CaxTqVHdw8BiEhDPPFimYk0q4
 Jz4PZiaGNxUDBLHWRi1bGo7637BXOQODGYYeq+sHwDtGlo2uvfzPcl3Rg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo OneLink+ Dock contains two VL812 USB3.0 controllers:
17ef:1018 upstream
17ef:1019 downstream

Those two controllers both have problems with some USB3.0 devices,
particularly self-powered ones. Typical error messages include:

  Timeout while waiting for setup device command
  device not accepting address X, error -62
  unable to enumerate USB device

By process of elimination the controllers themselves were identified as
the cause of the problem. Through trial and error the issue was solved
by using USB_QUIRK_RESET_RESUME for both chips.

Signed-off-by: JFLF <jflf_kernel@gmx.com>
=2D--
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f99a65a64..999b7c969 100644
=2D-- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -437,6 +437,10 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =3D
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },

+	/* Lenovo ThinkPad OneLink+ Dock twin hub controllers (VIA Labs VL812) *=
/
+	{ USB_DEVICE(0x17ef, 0x1018), .driver_info =3D USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x17ef, 0x1019), .driver_info =3D USB_QUIRK_RESET_RESUME },
+
 	/* Lenovo USB-C to Ethernet Adapter RTL8153-04 */
 	{ USB_DEVICE(0x17ef, 0x720c), .driver_info =3D USB_QUIRK_NO_LPM },

=2D-
2.34.1

