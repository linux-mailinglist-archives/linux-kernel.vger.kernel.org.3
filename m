Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A524BEF20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiBVBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793C24F2E;
        Mon, 21 Feb 2022 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492512;
        bh=lEGAOtzgMEFzQKENfjNLVN0s0ToEzWqdhUuUbTO2bGM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ge/7Uk7V/IzQamDgNXDVZvVyKqd5insicDzvapDhXavvi3qo4FYW7M0nyZDFh+YSj
         4Qwj/k0FxGe1jZ6UvIQcW0bLgf+sp3SpexFk6m8CAWRzKw2p3RA3b9gMPBhyHMx+WI
         kEqu29XU9YXG34Hytbz2bNt/WzYUAx2Mtxjr+PEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1nqh301gSk-00fT5W; Tue, 22
 Feb 2022 02:15:12 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v3 9/9] serial: atmel: remove redundant assignment in rs485_config
Date:   Tue, 22 Feb 2022 02:14:33 +0100
Message-Id: <20220222011433.8761-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:bv2z3mAXWdpqELROOyojpjGAFmvhd9PZYl442nj8R122IfdOqxk
 1tQpzRuLC7Fsyr4HxbpC8xSGSSJHPnaHWcP4ketFZsBdZ5ZpmJoJmpMFHvfiTa1YR5BLMzh
 cfNM0W9I/MenOtYzJSnXNdBIbrdvZCHwMLNyc46qbPHuLRSY9O0m1lANaZ2AMk/4P8bzpvz
 hDZOOPRadR7oxCIq2jwcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b9iQb2TqwS0=:FMH99wrfQQGCjY2UNaGD8t
 3voyfBU2YiqBxOp/7Yjfl2vovYpoCeU4ao/AaLL/+2nLHggL8MvxrfsV1TXfUVdbJrKoUKacv
 kPN6DWZCwxRxRLzRS+lp9ZWRMWTZm2GO3aqdIpg+PbLOQbgFwQw6+ExGr3p156V06egM+zO43
 dkgkvJ/zOgjrU5MYbj5XpZgqz1evF9WVcmwSPDLWrIRxYluq9LRbKdOVOOUMMCElkRophkndl
 24N0xjtpeHQcRTU5pAKT0Mnava7kvxfR2dkHC3vM7aZlvtfqzs9bcHerOEqKGtRZJTkTbW6PY
 usu2rMEp3XCwaz3c8O9lod7B8MLkUv7vn5r7QqlmXtaNQ1cVqZyQlVmbOoFG62U5i+e9nmaPs
 GK7NneVEHN2X29x6l8NybWkH8eABylVpfOH2F3NzWpTq7KSf8u0Xu0d63ysu55x1u2cxLZ3tH
 3Di1L3VI8ATgULFDI6rEoLFgP6sO0EcRq8SvWrLe89cL5BjKeSOx7xZ1GKirIu1oQURjGL5Bd
 jMV6pr+MwTkvbIR5aiXYDeGLiQ6ZUajH9qsbEva0eyVE8vMR+rhrJjauTJM3K5DtnlG44pNQV
 RjMUySGhd2HPDgrihsWL7zSjRV8C/GZYEoTXs3AajN8SW7rFy67+U8w7SLN/0TrXjh6eEGdVj
 IhtC4TPPCI7QjVmSsoBZVBDh+O/XFeyYValvhxPawUnapL+KhS4OvfKx242TGSaRtXbfljkSq
 u+NGDicXrwBmfLR/N17ikCmzk1W1H4Fmd1mF/94OtJYkKN/byg1i46wu5vHFS8Dsnwj4SW8Gm
 GMYnCqFu51V/PoVc1j6H91y51YPBwvU+OZMn/vksJaqmM4jx72xw6jccBaz4htVPEP1N81U46
 DNTgV08Sm97yuXLHNrjbahlziAbVliddDHmrn/XOMmaGlhgYj5LvWUwFJB3qstdYeN4a6V1ll
 VghyGPa2GQJN8YCKf9ttyj3NLv7IgNiUZZPaEcDurG+VkljkOBc8JGChXI7sncidPvV3kqhMr
 j03vWp3jusvtN4jtqLqWxdnPXXlEz/dA/a/g4lQMK3X9pO2/VKUPh/NktmVkyMtBReul/hzoE
 DIlSFzITkj95kI=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgYXNzaWdu
cyB0aGUgcGFzc2VkCnNlcmlhbF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHVhcnQgcG9ydC4KClNvIHJl
bW92ZSB0aGUgYXNzaWdubWVudCBmcm9tIHRoZSBkcml2ZXJzIHJzNDg1X2NvbmZpZygpIGZ1bmN0
aW9uIHRvIGF2b2lkCnJlZHVuZGFuY3kuCgpBY2tlZC1ieTogUmljaGFyZCBHZW5vdWQgPHJpY2hh
cmQuZ2Vub3VkQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5v
U2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5j
IHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVy
cy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jCmluZGV4IDczZDQzOTE5ODk4ZC4uMThkM2JiZGNi
N2EyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jCkBAIC0yOTksMTEgKzI5OSw5IEBAIHN0
YXRpYyBpbnQgYXRtZWxfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJLyog
UmVzZXR0aW5nIHNlcmlhbCBtb2RlIHRvIFJTMjMyICgweDApICovCiAJbW9kZSAmPSB+QVRNRUxf
VVNfVVNNT0RFOwogCi0JcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwotCiAJaWYgKHJzNDg1Y29u
Zi0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgewogCQlkZXZfZGJnKHBvcnQtPmRldiwgIlNl
dHRpbmcgVUFSVCB0byBSUzQ4NVxuIik7Ci0JCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9S
UzQ4NV9SWF9EVVJJTkdfVFgpCisJCWlmIChyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JY
X0RVUklOR19UWCkKIAkJCWF0bWVsX3BvcnQtPnR4X2RvbmVfbWFzayA9IEFUTUVMX1VTX1RYUkRZ
OwogCQllbHNlCiAJCQlhdG1lbF9wb3J0LT50eF9kb25lX21hc2sgPSBBVE1FTF9VU19UWEVNUFRZ
OwotLSAKMi4zNS4xCgo=
