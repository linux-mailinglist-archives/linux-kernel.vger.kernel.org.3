Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95162479B95
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhLRP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 10:26:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:35729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232660AbhLRP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 10:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639841165;
        bh=F0q+sD4JU+RQTxFCuOmDhjEnN8MILJC/UdK29G9BcoM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RrwDHHy94iQLXMstvCklFcYHGGVfKEB5ZORyPwGrcxfgceDtxJXSH7+wrqCjEajQo
         /xdJy2V87kO+yNIuLarEgaIRjrR0P9Ltq0O/7mxKFrL9V0K9YLVk+XciaBBRjuBCJ/
         T8vJdV2eP3+AJtbTTzvLzqVyHFkXQRa9NVjsGoCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1n9mpK0KbL-00P97Z; Sat, 18
 Dec 2021 16:26:05 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: ntxec: Change return type of ntxec_reg8 from __be16 to u16
Date:   Sat, 18 Dec 2021 16:25:53 +0100
Message-Id: <20211218152553.744615-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ub6q/INK4e3odxUbe9IapS9Fiaq81l7ZAW9CF6emhwjnB/e6pQK
 TFiaGkj/Ekad+Vf5eRVXVc8iuh1KZt7Mr59n2nAC/3OhrCxB0ZPEWytWbCcfCiv6Lxocy6j
 R7ZBERJOA49Ttl+zfPTYkk8/Ze4pWX8d356tF4J+MQL6R1RftePKjXHgeYEct8zdqLNFp6m
 CqPS0E3I5Kl0/23RzPvog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gMHUHlUAMtA=:QjTjKkVef8lCNMLUzOYgNb
 MFYgibKu8U2QYLwPVAd7G3OMspyXWOCxGtcHtXa7NYViCIG0Z1+A83bi/yMWokIjVTfy5D+WT
 tYiBlzRhEoQL1CcwEHXgAAwPATy+89PXeiM2oUm7gIeFVxOUf8GQxggitfzJnMV3G5Q5+zaiM
 tLFhQsubPSx8XPJ4hWXnq7HsfGi6Em9rbnwPtncRNGy6HvRqN2aWcyldYYfCAmzC/fYmt0263
 A5H0NfEgNsm5DWXOFP2Tk+LQdQqg3QEAAc0KOvsDHITREKFeaXyyGx4YJ1VXqKeq2SFQRiHYD
 YXVfMr4LyenT9+3qkbQ0Q4KhKXdIU5JRyiPQiYJ4rew7NhK8ggcUUlmq8Xv+Vsu0QXnq1azl/
 vdVF8v/8YP+aj7GyIzDxP+US1/WCylrFPQe9UYm7sW26NivadzBpo452tQSds1xYB8e8UU15t
 a9nKPlT/VYJgAUGGK5G5UtmJiOVRvS+x1PbiZL6rSUpleBtjxSPF5NFwxLWMZV1THv5RFXjyp
 tiiZjyKSfGQaJOnPRg2iDQLPoOaWie0deMPqgqfBzA19zTa3d2FtAQQDN6dfBAyuxX1kOEToE
 lkDzVTT9IgDcnQRFXcfnzrb+xQEFciv52UzseOReB77XXkY+kWmv/Sm1H9WyBnXg/o67IJOLv
 ZBwbDcjyR5MKQSU7e/7CM4liOO0ntDor45tlRSzlLktOd34QSpRa+iZ8djgGw6migbRWn31Db
 PXHfq5qO+DT4cvz7GId3MJO+OX23NfJjtOcgOjXevsLI4ThuniB3yc+p0imtn4n93Pn4Lj+4u
 Tp2wkkkDgijbAXQO6UjccW7BI01CaLyMbMm448XtWoBjAcM+S2PWolgILjackgITNivjPv14h
 GylwTZP3YtqnnIgDKvqW3fXUCCPK80mY6pds3LBAehhJYRnD0h6wR8QlZ0a+CalDKD/6RuI8N
 piL/TVdgrJBEWVQxBGoKehMd1hfyiWtPT4tX20AEdUPjXfHpGvVfISSUWIR2ZZmmD+OzYaibs
 KSZT5ba14jBMy+E35pF6Ab5CkBAzdxFdrw676iRmuPcEE6dD2W9QQW+EEeB5AkOTTZcxta/SF
 a/Vr/Hsixg3MA4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register values in NTXEC are big-endian on the I2C bus, but the regmap
subsystem handles the conversion between CPU-endian and big-endian data
internally. ntxec_reg8 should thus return u16, not __be16.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/mfd/ntxec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
index 26ab3b8eb612f..cc6f07bfa2b34 100644
=2D-- a/include/linux/mfd/ntxec.h
+++ b/include/linux/mfd/ntxec.h
@@ -26,7 +26,7 @@ struct ntxec {
  * This convenience function converts an 8-bit value to 16-bit for use in=
 the
  * second kind of register.
  */
-static inline __be16 ntxec_reg8(u8 value)
+static inline u16 ntxec_reg8(u8 value)
 {
 	return value << 8;
 }
=2D-
2.30.2

