Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710259FF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiHXQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiHXQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:26:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FA8C015;
        Wed, 24 Aug 2022 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661358415;
        bh=VhhqfxDhlo8MSrH5FBk/zyn3/We7sr7S1F+UoYwEGWs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HU9hLBn3Vi3A77jjDtGhfk2yUGgGkkdS0ONVaBgpCWkkHOM1YYzUaVC49h27U4hxf
         1EKpkeBUN7WehD4SLBO/A7uuaVzL4XHdgZfak/0tjPrKkE0Z1Tg1MSRtmE7TuAJFke
         EoP1I+39WKe4Qcn3gTQ58n1yYb5iO8/WYzOzQSPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from silverpad ([82.113.106.57]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4JmT-1oRACM2kgj-000IRy; Wed, 24
 Aug 2022 18:26:55 +0200
From:   Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     JFLF <jflf_kernel@gmx.com>
Subject: [PATCH v2] usb: add quirks for Lenovo OneLink+ Dock
Date:   Wed, 24 Aug 2022 18:26:41 +0200
Message-Id: <20220824162641.11805-1-jflf_kernel@gmx.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSPMEo50wRO62CAmqE7u576h2yfH11dV2rqcW2IgT6+OPVlFR0I
 QHQpR5xGYhBsieYgCAOxDRcF4LaBrcH7AkwLpgQ++iXrdXdRjEpEvtxrVxgrNwEqwkqobj1
 IwxhQnP+88cf0nZmY6bLDnjplJJg6SY71ojSkF6Lm6DS5nY16GlSfK228OIu46W9Gtm1FjU
 4yVH6RSqHHR9UtspOO0rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:11DWyJJdY+Q=:U/PYIa+NVqm4pneOZL6ttA
 /PqOojtWKw3X8/H8YJnhgn+ccadWAfFb+B4JYVG5TMI4nFyEvAbjl7Bo1eChqmi5C6wkxK/iL
 p7uTXY1w9t6gRLtvlYvYIi2P5hhKKTshxbfs99FTrlMUqW0/c7ZHlowXf11jIXxnFTnQmhPkc
 +j1P7R3mKlqpM4s5xbYYm9bUt0gjqyg5wK5nBJHR6JHtExO6kk++fbGgyM7kZpquBhEZFJfjG
 t/hhYaU0jOBvrTu6sPN4/0aQ6hYegmknky/BZoLztxkIEbQ9Hxu3wph/eJs76VNpwEeBw0sEG
 j06AYEbcK4i72jdBagABXmk5BvyaCtxML5odWPjheS0Khq/gbkQXI6LjrKDq4jP1tGR+ZI8H2
 ghyLaUf0PefT68AKhkXxr1zjbX+YTrnFv3wCNuQnRuXudN1nx74naDizYLdlRT8797VyvdioQ
 k1VCRxMcHagJgu0CzD0n3MdCq0dSD1MSqBXqzNldBDWCAoic8V+k0+BkT37DGTFo7xz58DLzF
 1SeslRajbJOloGYIvC2ZTuElQLtlNOqtLAns+u/KCQ4moUJOHVeLuimB1+dpuP+IGEXH/veGe
 yp1fpYU0kR1a6dkVczKR0UnbwfBPCDIGkOSJwrTxsTtCON0Dx9jVXD/JJbNyKBKp1h2fEOMma
 52bPaC8D3gHjdGYGCXw4+a9OQ2HlWSx6hMtXGJMC3O+06IvDIEwlGckrtQv8JSHbKr6+VNPoe
 w8wlIEGfrNNRY8oulaJDUW8f01GRpUyWR3Fpvn4r80awJB6W/p9Lv2OeEJDbuw5tRP3LS3/DB
 p2Y4uuqC5o9OLJc32wd5FMp61Y9LjQzcqYi0YXCamkJUWkv0UIk2jWcDJ5LEEVlhBA7732lvD
 /timy9nHUoS2HJXLR55dnUcjHZSY6ccCLYNeuteopqryT+ihlcgMi7b5AG2fYjiI50McmniCs
 OsYkrbvEHWoCk8mxI98DTLyAhkbgkVhmcuaJc7VNs+llGliGSkFlZ8rAiwO3RHzWC+5P304zV
 NC8f7qisdfBWG31FtnlQsVwDFxUxeJJ/9nDC1pJHDYQH/kosN0sDjSkMTTC58zItznQxBP6UB
 PU3O64rmjuj/OBt4EzkS2EavSG9mFOV6CkJCl6PDA64kHZZACawY3e29Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JFLF <jflf_kernel@gmx.com>

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

Signed-off-by: Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
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

