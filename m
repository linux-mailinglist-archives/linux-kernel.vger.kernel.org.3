Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B624FAD6E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiDJKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21A53710;
        Sun, 10 Apr 2022 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587640;
        bh=sgguoRaS2TlrebaefUioIyv1Sby/7wOqOhBsg4HrAe4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aCiKvZRPvrXFmsM57tB/p97dj7WQQK2pKThT5rwUTjjCh0b6nQQQfAtcJEC3XtyDv
         0TcCvS5WPFDbtzZFl7U9OHo2GGpJR6p8gMahC7/9ZD7RzMYHEibFAu5xRpQRUWSDHx
         A7J8qVqc3DBJu8KjRzgl8ZAzFT6ikKmdQKxDBQqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1nzNWa1YlE-014GAc; Sun, 10
 Apr 2022 12:47:20 +0200
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
Subject: [PATCH v4 RESEND 9/9] serial: atmel: remove redundant assignment in rs485_config
Date:   Sun, 10 Apr 2022 12:46:42 +0200
Message-Id: <20220410104642.32195-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:8ffrXrQsbMz/N6WspPKgXguRr1bS3q5soA6JNcGZo8ZmdFieX+Z
 rUInPwmSnSNMlv73PqUgg1KDGn7ZC6/HPnKic8Nmsb4CPH36Gsu27w3A3RdLQ+Kowzyjrsx
 76kM0WgH+bgIFRpHMJ81xmdnWoo3tQ2fctNdhXmvNWivxgeANUkn7LNS4h3G0ffypshD9mm
 BfI48+b6l6/ASA4x0nHKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4yr4llBWTr4=:n4BWjLga1isj9AecV7NBeI
 xKwlICbnPCXbrQoCerzcmbC4fVzy2YLv/hzlZKxRwnWfOHb/d3ALgEq/jwGtlVvJupZVBXxIU
 +C2jE9y4VUaNkpoKnBQ2P7weK1Kh97sCrkJjuwJMzoztlUVBk9FoACVRVbCO4/tLip2Yu3g+s
 gR6yNXBod1Yv5pGQxT091/uvbsNc+j9rhakYUfELNi1pUvc3K5Gfw7XjtNxexXbGZOUuBLL/6
 q3jO3lEEdoqScf18SNQUGTWzPHM/50wY+P0xVVfJllUOmKuKugs7e3h3OO7VLCkpWPBRKNRs7
 5aQvfoN5PYNKww3r6uy+jMJsIZhYKx9m+2redZAcB0Up8/v3+EgAVQIwlFUxIbzPGdgZJiGUS
 Be806cz9LYpPDs1hDTNYLPEeU3ifbmFqAdJNv8YCZ6Qx2U42kQnkbYBxUmZvUPDJf7TQ55FOf
 FnUylAbT7bOAAMvRrkvkpQk/+Lo4fjShHSVRHw3pSbBt+EHe8JErC9qVeXsT9hEJohxUWaB3p
 WjTEAsgo4s88A3DtGPGU9dikTu7vfu5K6prfkFzzmMiRUPK8kq4cffUnwwFGNGy1fvy0+eiLt
 d/53+JwjId89FqB9Fg3xLsVIR0lKOMPuw3XRy1YvuQAYv5rNDVNNgRwx3ZqJbzUDmz9sMRS9k
 JlCmiFhx9kqvO2xB8Qh32g8h8sntNFGybSBZH99W4uXD4GWoE6CX1tbaX0lOicq1g7QKuPB4Q
 nXg90uhnd3N09t0MJA/e9bX/XkFa3UTaB05vmeVOUStyVFp+vc4AtDDh1Zgej0APkIJD8tXHg
 rUE7GTLeIprOPSVeaJ8ytMj7ax+olKNLxKxlLs3ruKLYazTWxXr1BpZNC2qloD+F7sJW8jvqG
 TrobolQhmzkyzyu8JN5W7+MP6AU+BnUUO2/FACGXkI2SLnlLlXxNtxxn0Nmvm9SnAwBvvfRKu
 XZo4e0q3w+LWfRVcQOOwwunZ3Rj1SeHNi8PBYsaYAWdYxeelL0/sHHxU3lIxJEfEtmZ5Tfpdo
 V2ayVlii9BsLmAyVRTBMunsjEaTmShGIyys8ueUoyisI1kk+8786Jmlhf6qEij+y+XZwEZJGE
 ymE9qc9IuPA5cA=
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
cy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jCmluZGV4IDNhNDVlNGZjNzk5My4uZGQxYzdlNGJk
MWM5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMKKysrIGIv
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
