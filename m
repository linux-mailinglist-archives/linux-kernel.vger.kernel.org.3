Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFE4FAD65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiDJKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiDJKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DD532DF;
        Sun, 10 Apr 2022 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587639;
        bh=EkwcGx3CPUbYWWZP3ZPvy4myrnOU5OVGhK+9ZHM1nsM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i9H8mXeQzNLtGN4t+qK/zKFUPB5RjLJzTtekXccYtZkUmUq9qty+/VXu5XRBXwOyD
         aWnOQv/ogIIrnpkzFuULXR73vjr4/4adZ09OEKFAPSdxYH6if82jAQ9fBCOTSexEpd
         8IZCq+jCGIhTN5L9xBDLdYPX0rlPRoEXsNH1Fflo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1nk3bD0aZk-00FSry; Sun, 10
 Apr 2022 12:47:19 +0200
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
Subject: [PATCH v4 RESEND 7/9] serial: imx: remove redundant assignment in rs485_config
Date:   Sun, 10 Apr 2022 12:46:40 +0200
Message-Id: <20220410104642.32195-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:0GWZ5HC7QoU4tJWQnFxv8oh9nnTv9+iXk+yuFZIc/VOCXO4LNh5
 l2KXnW6gfliInNs/VUZ5FxI+LuOZKeR4f19hE1y4D1D/L2VzOg7+8z4G/siXjuRAtWU7ArN
 pTtBA7hCCY2UCiVI/BSYYKEmGo1AbNeB6FIW/p4nN57A6Mfq2QNExW5B2zI7mkToIsw7jlY
 OYn4w7rktot3VqOzT/7WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b8P0rGbCftw=:zlL8tc2o2S/XVbvti1K3ip
 u3TyQtS6GqC37FYdZscnZ4ysTo1hkAofjyB7nJ/th0atjbjIPfwPCRtL/4FC4FlXgoHltNtuJ
 WGnixugJHZIxZoYeZxojEwfD9LgLYaxPDR2Fg+/am/WZ74ieT2pB4BzHzNDg+RmLfS5I8BUFL
 XKdAleFS+hbok7CwUjzsrjAfSOQYelVjvQXjjDLrNiPmYxEAYbl/68hZOVsTr3EhqP/XvHhnG
 HWKvLh5vrVQY2id6FQGyzbgMHlW+JmG4EOQbVj3u1gZiHgsysVsi5/L8m2jUuU2qAYbBsjOl5
 RH5t9rvTwUXajghOm1GpIuqUwm+JNIny+zEl8ScyNGwF9yDmb+aBeKDEQ9PQitaV0HsBNCFxS
 fQp1UzJCLxLpByB/5oN1UHmxam/6XVDKifs+u4pU3kXAbqnvk1gFMkx8crDHyGhfS5Fdr2SIS
 q+OTUUoWO6OVAERt63SJD7hdFej+hNdJHedMpESb1Z4P7G2wIo9Zx3KBp1L4Y4hb/eQPFHyEv
 MgwWXWc+QVKYTqfmxkCA+HEDxBDk1s+dHz79BA/Lh0E4Orm9y28nutTCv6B9M77yWwMUCRfy4
 FysLT2QxiZ2hLI4ed3UNR7JK5mIiBKUK7+SsrrVq1LcyPklYpmJyVGFMkdAQkA0pL1nyHSA+I
 /G2aKBdKO8yBIoor2oSEl7EBhSCLyfa3KRg4bayZzUVevcAGFBgM+3YElvPntIeD9mYBaUnRs
 b8D9jJ/fT0UPMzq74n/xXU+JBsY8imYlRaahCqy2r6r2H6/1F832bcON0lb+kdb5lNL7PmHpq
 qRkhM5zm7SiIRIkZtM5rtwSXMIlnYViUc1miMbFwLM8aZYVtUQFFn/iK/YeDK/Omowjyhegff
 3eqDE9UtceZBgsnUlB2Kh+gxYhUWP/LoqPqeK+tZN3cxroeejP16gAKnYSZrGvo3eln+7sGYt
 r1zTLh9nCRmcMTEUjDJrMZ0qmbBbXslv0iNCgsTKyyEl4TgGyvF25LI5R02ZuyN//sCvzTQzA
 K3f5WaM1PK7niqaurLktwFrhlJRi/lcmTCWoF8hlYoy4JcGlN/JDEtdBKpZdnEeW6x/pt7XG1
 aql4P3luul7Cp0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgYXNzaWdu
cyB0aGUgcGFzc2VkCnNlcmlhbF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHVhcnQgcG9ydC4KClNvIHJl
bW92ZSB0aGUgYXNzaWdubWVudCBpbiB0aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlv
biB0byBhdm9pZApyZWR1bmNhbmN5LgoKQWNrZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBw
byA8TGlub1NhbmZpbGlwcG9AZ214LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8
IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwppbmRleCBmZDM4
ZTZlZDRmZGEuLmU5MzQ4ODBmZWJlOCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMTkzNyw4ICsxOTM3LDYgQEAg
c3RhdGljIGludCBpbXhfdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwK
IAkgICAgcnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpCiAJCWlteF91
YXJ0X3N0YXJ0X3J4KHBvcnQpOwogCi0JcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwotCiAJcmV0
dXJuIDA7CiB9CiAKLS0gCjIuMzUuMQoK
