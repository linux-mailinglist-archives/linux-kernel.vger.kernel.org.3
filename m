Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9950B4B3DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiBMW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:28:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBMW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:28:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7985468F;
        Sun, 13 Feb 2022 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791290;
        bh=5wRzDJnH/MZt0kXSTv+r+X6s4j4DfxLFn8KhRpAsf+k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=drwtnPZpDdswVRyGbojgh3QOoOb+gOjLQCjfgwFWtLfhCavf8/Z01ndmtAxI5ujNI
         xwYzXWomVIXPipmJk8bW4cMmzMdFbOreX4iFQ85cmDego2brQgSGfsVi1UoLiJonkg
         It7BOS0PPSZYtsMRgpEyTUB67w3ymF8rQ0UAzX1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1oGT8l1INN-012LMu; Sun, 13
 Feb 2022 23:28:10 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 7/9] serial: imx: remove redundant assignment in rs485_config
Date:   Sun, 13 Feb 2022 23:27:35 +0100
Message-Id: <20220213222737.15709-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VQAd/OJ1jhpk4ldceF25FblvAEPLGdXjHdVFpiuPSuwADkBeT7V
 yCfW/CI9M5DgE8+jVQFlBr63McC7604NjY1wWsZ2tTsR7Sozw6+IX5Obol0dSbpjd1lf8Yz
 d7NCqZrRweC/jyYIQGhtkgyi+wplMUxGkGwA6sEPNfHm8KWDl2h3g53uxVYJILCCzU+VFLU
 oj5ppYlcbHf2/n11GstWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5jXlo6iGtGE=:2aF7oQ2b8dRXTmb9YMU/9E
 N59bqsjvTyI8lRoO97eqDWLgQzLdE4gPbzjdn1pfmvnEHT4fDWcQCiF/FOMJk9p86a7xzAGaQ
 HIVuaN3kR2sOeUDTcXsM99sQ16YeXQz+x+OrHuKOT/F7lYndAyXeTXJlYate248QxBV/msw5l
 x+iH9vPNrWEPLsqTlxt3PwVLdPLyiVaJbbP4uiZdrY2SjvpDDKcPE6+8TRWaf15hGuAnBB5ht
 v/leGM8Zb0gmIBCF+IdUP+ZdWZChtUCA9kDRV5b9aKXpL6kYlQePvBBR4ECgfia57JzBKko0X
 ISGzA5liPhq8ZDkEVZpfjalx2nj+BaeXOSNFgLFtDDkjR/dRLpHGNmknYnK4/jAod3ja+yBTj
 f1ilnGiXN0Bx+RraTypO7LQwQmOd21Zu1R6cGHoZofHLgJ48V9VYcrz6B58vCV4o1FkcaSEIi
 kVBRu93pxzqNrko5tAQt9/V6UH7sY0A+f0DfVF/DbYIWypQfTVhti3lFE6IayJY1CQmHYp081
 stHZIa/KyskpiTUjN2WDwUJDGD1HGb63lS08fOr1Luv90vn4ipI01ZsvlNn08FsZhz5pjDC9n
 z+SRL3zDV1KGjriEZz9aEYB0aehKozbjyp9NpPlbO6KaBLudgvr+RlsLuNNP541zq+Mvek2zp
 3X+OJtU9sjnkvjTszBxU8jipdg1QzFPQeWtihfOv2K/nGScHRT6kKcrPGdl8ENs62f7giofdX
 10w/i5LAc94AZdWtZ99/UPtgCozBWlnT9jAlHWgLo+i5TIq503XDc/MVt/2kmLT5yHQFVqhJS
 oRWK/HlT0REhLyiUlsnWe8dkY/Rlzfs9rGu7U8/nGqRM8FJeyxzVOn1tuQxEjXcz6iMRmaYeu
 PKaWtr4Y1BU/pg0ZlWMM/ovwjeX0IvpNQ0D3wSS2rybaBeU5OXy1hmen6l+5fRSWMYf9vKg1L
 6CWY7tBK6cg7FtincYaNvjyC0WgYGqjLRINTzDecW5uK6/XMcpWtjPDsOPeyFCThvY80iQXDG
 NE7LA3Glz53CKTaZSKpqfYvRj8NfAgNghT/lmi8nxHDkb72oY4uNs5bcrzrQkhaKjZUcLlYez
 y0XBaXQACqP8QY=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBSUzQ4NSBpcyBjb25maWd1cmVkIGJ5IHVzZXJzcGFjZSB0aGUgc2VyaWFsIGNvcmUgYWxy
ZWFkeSBhc3NpZ25zIHRoZQpwYXNzZWQgY29uZmlndXJhdGlvbiB0byB0aGUgdWFydCBwb3J0LiBE
b2luZyB0aGUgc2FtZSBpbiB0aGUgZHJpdmVycwpyczQ4NV9jb25maWcgZnVuY3Rpb24gaXMgcmVk
dW5kYW50LiBTbyByZW1vdmUgdGhlIGNvbmNlcm5pbmcgY29kZSBpbiB0aGUKZnVuY3Rpb24uCgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0t
CiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMKaW5kZXggMGI0NjdjZThkNzM3Li5hYjU2ZmYyM2U4YTkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMKQEAgLTE5MzcsOCArMTkzNyw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcnM0ODVfY29u
ZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJICAgIHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJf
UlM0ODVfUlhfRFVSSU5HX1RYKQogCQlpbXhfdWFydF9zdGFydF9yeChwb3J0KTsKIAotCXBvcnQt
PnJzNDg1ID0gKnJzNDg1Y29uZjsKLQogCXJldHVybiAwOwogfQogCi0tIAoyLjM0LjEKCg==
