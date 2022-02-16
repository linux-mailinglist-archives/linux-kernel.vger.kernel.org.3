Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24E4B7BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiBPATu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbiBPATU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAB70332;
        Tue, 15 Feb 2022 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970727;
        bh=7qzWDUNopK0bho5I5nYj0J78qRs15cAksVO/Q8GWxsw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eFU5XYTy+SpZQMBcsDZPHFLFN/heaRrGD12W2PBjm6CRz7xdnfZoP8qKfzPPfmuOc
         3+6+eam14QnT0azUMnqf/WBAcu7kQiwsONOTFuW/SMqfsadjkX9ieNX/FDot6bU4kA
         OfiAarqevJrMmzFMdzFEyCjsspbIhflL4hq93ViQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1oMKQo09Jx-016e1C; Wed, 16
 Feb 2022 01:18:47 +0100
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
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2 9/9] serial: atmel: remove redundant assignment in rs485_config
Date:   Wed, 16 Feb 2022 01:18:03 +0100
Message-Id: <20220216001803.637-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:zA2TdkclBElvUYZlMDu80hyoLmVC33BJetCeueVe0nw+noQF1V1
 L/Ab3lZ4xwopWgLe/eddWpj7m2jLKl0mONq2uA12enhs6iQJxOtpVQrJETJo4TM51LKZ6c0
 +Y+sXtpzeFP2FmWNq4E4DBv6OtQJnx4A4iFaBoQHkepgsEcvWh4VjPlJPmvVR2PxWjPRczs
 f23tAxie8X4MJm+pJhDow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XcvYYdJUjWo=:atOtBcfRRm4xT8HMi31JHV
 MbZ0MzpH38gakA0WlwxC9/E+/3FI3Z+FityUADReFMjaq3vTJ9I2e1YOyQ8BildGgsuXd2PyZ
 +AvQxESyYnhUifIsSHX2MWHyJvtWL4WEkDD/KDeyaEIZjcP+hEk778pUGf1Nkrh1RTmzKKw1B
 Lr37gftv5eooYIwdiR1RQ9yon/wx7d7yYbgFqUTCLp3YN4VhrYgfj6lqgy7pCvhiLHdY30aRm
 Hm0bkWxevHH2BvoFXGlZ4XdpixJxqB5aWhNMnZel39s5RTkP57rO6vk2c4odwvOPFBN1LH0yQ
 vlGZGCNK0n4ZqP8T9PzGxdxGkBMHlfeMo8DuDmXCg0x76823YlQzeJ7UYl6CaLDpku7RKEgua
 zcODuEHFEw3EGfhqnazMtsONy0qbQ1S4Qchw/vV94NRDGQFYTooq8dwzCDUADHUu2K3PQzHPi
 X3jBGID2ilgamDREi+CNmK/QNlf0iRCcRf4n9eUNCsfkAFBzKjg53h3Sscd+CiyhLS9ZJUPPm
 HLg1eVHcdvC8RRzSRmF8mQC45aNo//ROuotXzo8XzYM3ebtn3wJ/qb9oLg2ZnbGM0nn5lKAwM
 JDTXzZgHHmNh1wT6mk39LGoUh5Q+WR9Oo4CWjkMt6Uh8leEOeyPVGTW8onq01k81gTx4rX0b1
 /aSibjYS+4qMoptOh/CT/5h5zNmt33okgKLIkPJSWrD477+cU5X2JmvXj8vc9DDCVegtVTPG6
 bPvAF7yy+GhSCr0HR8Jft0y2qu3tACB/Mvj6dOPzVm0dkLmu9YZJuUGsBePTOK8O/zL+xXaLV
 4nQpcbEPrPai/j7QLPrQ3/urza7oqfCO1WEJ+1l+4VODlSk0VjMkbq2YvpfwAMrzs6k2eOYxP
 m9VAhPFJQASLD9792OlrxmOuVcDt73IjYVlxlRffIck/0fKnJ5FiozF46os6DBMTDXVlDrnNi
 BpbCJugA5GMy1hUwNtAaW6axViMSoDL8/TzxtgqZvxLvif6yTKj0jhC2Q4jyTfrty/siL099k
 CjFptrr3RbHdWUyu1uOgXqDEabjS0WNKBHkjoqzVhI9EDsVw5kp9FKIVtUBhGcqSqIBStgeyg
 QCIQxHcXHriSmE=
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
aW9uIHRvIGF2b2lkCnJlZHVuZGFuY3kuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8g
PExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2Vy
aWFsLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMKaW5kZXggMmQwOWE4OTk3NGEyLi4yYWI1
ODlhM2Q4NmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYwor
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMKQEAgLTI5OSwxMSArMjk5LDkg
QEAgc3RhdGljIGludCBhdG1lbF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwK
IAkvKiBSZXNldHRpbmcgc2VyaWFsIG1vZGUgdG8gUlMyMzIgKDB4MCkgKi8KIAltb2RlICY9IH5B
VE1FTF9VU19VU01PREU7CiAKLQlwb3J0LT5yczQ4NSA9ICpyczQ4NWNvbmY7Ci0KIAlpZiAocnM0
ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7CiAJCWRldl9kYmcocG9ydC0+ZGV2
LCAiU2V0dGluZyBVQVJUIHRvIFJTNDg1XG4iKTsKLQkJaWYgKHBvcnQtPnJzNDg1LmZsYWdzICYg
U0VSX1JTNDg1X1JYX0RVUklOR19UWCkKKwkJaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0
ODVfUlhfRFVSSU5HX1RYKQogCQkJYXRtZWxfcG9ydC0+dHhfZG9uZV9tYXNrID0gQVRNRUxfVVNf
VFhSRFk7CiAJCWVsc2UKIAkJCWF0bWVsX3BvcnQtPnR4X2RvbmVfbWFzayA9IEFUTUVMX1VTX1RY
RU1QVFk7Ci0tIAoyLjM0LjEKCg==
