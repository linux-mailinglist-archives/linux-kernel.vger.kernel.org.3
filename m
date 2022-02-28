Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6044C6154
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiB1ClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiB1Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5E6AA5C;
        Sun, 27 Feb 2022 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015997;
        bh=lEGAOtzgMEFzQKENfjNLVN0s0ToEzWqdhUuUbTO2bGM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QLvB8/eHK+/SvsTwtT0eawHbDf2gnk1IMj5JWgZ+vCETZVKmKPM2nuJfdhBfSEZRu
         bRzvBLKTPZVNZVTLqV/IGZ6bzfPyV2SgNKo2gBSrnTeOeIdMP5ivp1byPVagCOKZ8S
         A6rVBx4fhRaGZ3u7xjM2cGODqJzdjYREc14QqDuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1o0pd80Sst-00pbxb; Mon, 28
 Feb 2022 03:39:57 +0100
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
Subject: [PATCH v4 9/9] serial: atmel: remove redundant assignment in rs485_config
Date:   Mon, 28 Feb 2022 03:39:28 +0100
Message-Id: <20220228023928.1067-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YV4KYBkt5vzMrAX6xWwquDgNmwuBCgeR6qBMGU7OtpSXlhEZBgV
 hsctjceCxGWP8JlM7yusdI+xE38Ji9hhrArnUSILM6GzTNnW/S6iSXrTnTqyfdqwKRI1lv5
 G2rO+BDEbqb1V+s8OguTgqmQ40B1DtCvgIjOo17IFLvGAVwD0HUu4DPGrNPkSdrZ0azh2T7
 1GtHBqoFveUeOa9p2lVJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4UaHU7djQk=:7t0EOHwetVvLoSDwyT7kQP
 5ypQC6G1iU+SvNNR2VaSPgp9T0yrtmocNDX/1Ud/Qz9+tFSaoQkGJ1NELIRvmJoMXakodYOZ0
 eb3IdiMM+cjtSqr8d1bYBBt4tDgetKjfLhbIAIRH7qAco4QYFadummZjZtjUSCRvpuvyGN7y3
 3GIxDs7tXEBPFzrLOcjJPX0qqox1omm9eByXUKifeBb/U44RhCg/jn+sIKPzfzvt6jasXJPW7
 RWlzOErH/JJ9/nlbakntOHw/UoLse7D30NHkVsDrhL9rM1WY72B3nP2VBSr0WsckTP2+JxHUk
 kNddDvMhfU9oIKaZjQCa8eyZNyMPajPNKWHtYaaHmol7byZ8rwagKQq10Q8+ahdJPTRXAsSq+
 7ZuotDHY9eOB/hcnrwrdk5rx8HLFDPF2qQcAtj41AOdum2cWTApdITbgXY2Ivtff3cTkz0DEU
 DYuzpYWeMKarqjme48FqRuZ60Gk80qN/r9YjFOVOux/OLTIfDWxqBZcDwpX6ZPzvFILkhdE05
 oHia0+xtN9CTrj+Q7UItQHRfQsXfFG90aooHaQzVniAK9LeUTC/+DL0z5sWbFhUe8/zeeNHD6
 L8ToIX8Z7UTqiWzbWvkrVZhtl8GEuqJWb2JXzLFSbo9CqFUZuqgVEZ3Kn79pC8ETyApVuGxmA
 T4HAgYu86TGI0ufinZAjKRMRRS9kzeAJBRd8YNyrTpmLbnkh3eSNBwJ8qxtbgcQv1NNRtPAmg
 k8nSng1DKhTJFDuSW3PHhsMA0CGiIiXkqxYHKTgGHf3gLvAbV+tk5mregVGHVCDE/6TBC8vwc
 N9cVHsdOnJUR4D4xqb+rtPTRvRUQ6gq0zXsJumebwEZOpW7HbczSQRMh/p6dweI7rDWX5zHMa
 UCPNi0ap8fCExByFvY6qpUwTSAsdMkPuoOJpxo239wln9qau1TE1NOX3zwh87AvnK9GEkUuxA
 CXz+tq+pn48xPThCwFUZnTJ8sojmmJURtPDFUlNeY9sOhgzoJOs1SBRNrhf5JDJgjPTjvHMtc
 B23hTJ/kucecTA5bCBDHjidOzD+w31Yz+HU6ub8sWdwpj0DeJhLEegLi9xYbQ+GhhTINAxTfC
 zFbNjUzFRJekGI=
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
