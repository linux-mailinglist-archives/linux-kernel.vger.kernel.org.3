Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3B5A01DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiHXTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiHXTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:14:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9AF65240;
        Wed, 24 Aug 2022 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661368454;
        bh=Wf+PgvEMxVLzIEkHcy0ZAH85uq9spAuazl+zPdNjBpc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MSVaIYBJDTVZPe+Y5zdglJAkgXaWuHmY47lpMPqe87nQfw6n7ALxH/0gsqo3jO+F8
         BAFPIX1ShzI6zswgafYwZ5agCQ6jleMmQeqXN/pA5hVE9AIs+6NeqHMlWwhFd8kyGA
         l3ymQ5xG5dKDSk+FMVPO3T0AWZ1Xhthxu9IdsoWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from silverpad ([89.204.135.131]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1pDgrE3Z0z-00mqrV; Wed, 24
 Aug 2022 21:14:14 +0200
From:   Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
Subject: [PATCH v3] usb: add quirks for Lenovo OneLink+ Dock
Date:   Wed, 24 Aug 2022 21:13:21 +0200
Message-Id: <20220824191320.17883-1-jflf_kernel@gmx.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oC3+so+41R2EyHHJ2AN93nJq1sJqJgGMVDu43fxDbWm7rWjz+K4
 vfdv5/FlFIDOAvUItqOQz14zYlfwbT8m63QonQgXO34eqcuYEKt3W4ma8CPsJlrz6ZJHdPW
 8enCachOymIRNjvrix9VnhbKKIhVNEBsVF/RA98bdU4t5cEzL7llpurQQBDciLTTi2AFSD6
 v1qgQNGIdIZyV535QhH5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2foCDcNJHi8=:WX+rB6uxNjd6ec8zY4NMcD
 PCfWYJcp6TmnzRZkcAc7WOclVd/vCjvKmZSQxTynFXsr5Suu+ndZn5okE1oA2hKatTgVmG0lj
 RHCQ46/lQZER+TWzPiyLlN6zCKYl5FWeUSwJE1PVw9wFn7g5OkYHHdvO+qn3yJpaAfc1Y8qQp
 jUTz4LkuVOdb4Y+9FVy7CiIAGXmgJhUxyGkTPwneUeaTDjBqQdD4x/RlRTkzNRJjoo5JwKW/b
 dDYxaILlz9T0U2AY75BkE8dfef9ZBOtrlEN0KVgiKPWY4O1blf7jcxVcommNrdxQBdE+z58gg
 P5jK1amojHxRAYzsOPkPBBxlHgNYR3Qt9mPbnXD2ILdBVGfyVT31QveFgpZtU0L9GuggZaH8n
 wpSAn+Mg8IsM30dVW/YFy9vVt4D2BJp01td+b+sYa/hMomNdt/1BOV0F+SqrC2qkyn+O4Vvdf
 SYgO9ZmK5DWFX7Ci9bvltGAGq2h0fbphIgyZ/cr6vDC5xggCd1o8kuYP5imYI3YqNqC5SGVkQ
 BXJyjH6v2TSV5mZAZDYAxzO8SaJjNLnYW4h5xFbe+evhlTskn5aIf9zoFtKd5hWLu/qsQKyqQ
 PFjnKlHYEVvjDHVSIk3yK8MW3jfFOMKZbqJX1OKFmOhnkAeqV0R+4d+mApv4p1ISoSRj+1rJE
 pK2rZuTZqGbU1nCCj5Y+uQsF5jmWqK6RZKWOzEf7DcSE3zPRw0yvLJ2Oqg8SNXBoPWEy/gVdr
 5M6Z25HbzsMoLt/00z/ZiSo9mvoS5xKHSm9NZIRTcJbXMAznPSDrABwAuYtZltaIGBbrTyQFu
 2JUJ1mhlZjy4fYLb0WPswD/1OA2oXoy+7CSNySYk3dqKevL2e8JzO8NnKniIcoM3omQuRTP9v
 AYT+ChPilrllyGc7iN6eBuEL2m0AwKSwZSZbr4WlFHrNLQxsYpcqh6ZNiS1ZTJOT4OMuYfRC7
 +fzRYNzYySL+S9oGkpZWonMDs4fcPTjCWC9KBLTJjsOnb/VusyrpUIrYzUb5X6VS1HOyF+KCB
 czotvjtN0HgxoRWvteyB+vGmVCvNpXPxV4EcYm//Wn2wCgis9W0TiMRHmS4jPMVGMZ5zQrMJH
 noLHzTd4NLyhp9Jyor7zhcnrCtDlfpoJ9al+54NjzkRCU32gRQNTkx2Cw==
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

Signed-off-by: Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
=2D--
v2 -> v3: fix commit email address, add revision details
v1 -> v2: use full author name


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

