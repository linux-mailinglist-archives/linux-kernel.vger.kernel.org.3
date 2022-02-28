Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7984C6153
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiB1Cl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiB1ClH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:41:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075916E2B4;
        Sun, 27 Feb 2022 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015995;
        bh=TjAcqoaAnmI0l2suIZ3fiCn2gdLnVgDyq5jYOOZmOWA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=egzCk6PLEW6jzuBH5Ay/BHf/YLpzdeNDLh12tM+XxnGLr1KoO/+ASW/ya15xBlwIk
         uK7QE0hBo6Ki0wopsnq2XbMBScFXdndYbFqvzeqUesmYtECIwaLH7blK4Fphd9Y5gD
         w+F0631x29u0i2hpiGW96sFF+/8GbhKlASgEj1/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1navzq30QX-00NTW9; Mon, 28
 Feb 2022 03:39:55 +0100
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
Subject: [PATCH v4 7/9] serial: imx: remove redundant assignment in rs485_config
Date:   Mon, 28 Feb 2022 03:39:26 +0100
Message-Id: <20220228023928.1067-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:OqeMSE2CDGXt5KJ7rWsD/nIkLMTCtETnI8mPAheao9RteHUJGjH
 uhUD9hHjzAgC5OkrDc4EyFM0mtAdCljBI8ScajPJ1tUtZ4fEtQR6l1gWFFN6dnRMb0kccMF
 GR8f+uhf6e+oXTukcckXjpiZRFG8gmLRl++cphp+zMyBSerp9tm06LJxhM3kM45hKwJDgw+
 xW99kyvyOseDuWzuSDljg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nyG/fLspJU8=:AYZg7QdM2fx5TjQNE4uplA
 ON0A/MUk4WKpoRdZVavvoFhzMeq4r9Fgp83P5TbqMSRS40Ul1qxFh8lHEZta/ylXkHQSQEI0n
 4ohkZ7iB6uxSWHgWgpbNVkKUKuhYMykU57+DkyZOf75Fo6XUB1zmOfCB4J8NwQMQrNtlH0GcB
 KkeWcyQd04hmw81OYe1zjTQ48W1IR1x+/TwI8JveQFZBVZNBH8BQDUqEbV2/PIsYzR9c4MtgC
 J/DdVfd5nBvFehz4/2aiRmSU7L6U+ey8V+yZGzx1M/ca/Ns1TfSWQHwkrF+RLdb/WhUbhF57o
 ZNzS7SW9LZLrhegJO7xvLtyXok0XgwAty+ZzHySFeIeyNL0oBygKHzfwwni4Qhk5QO1lqEk9S
 xFYrAzIcmZJ6xMkupV43OECEuKDJDl/gcLkAVL/V0IQPrd/HRqeZGfVGcgG5nK1U3p7KEFvjn
 mfaYUeeXLs/8kvLiuAigW2Z0SGmvipR2g/xPC++De10+OoKyOMAYeOBNmce5e8j3Ep/6njUwr
 TMVntYKvHbXmBKZO7uJjS1gVE0DUYdsswNYSI9YXroQ8tkDXitRXw8Zu9BebganzvmGDfFvbI
 M9cSbKjBgnsE+Em5fw58IjJxqCyrmy/A4khElxmIHcbwLQHTLTsyZkDALPk9ya6j2TTzU5dZl
 5rXKuQ0N7OYteVeVQ3usQtMSqL+DgkAwIr4n3SWzu4dkGzTPCNJGtTVroet5Awa+X0yKKqJCx
 GDQ3ks9NTEwmtsUAw5Eju6/bqQ53SDipx+KfjxCqCa6IP29tRImwHWTkiA9owpp2LwDJZuHgq
 UcjRPh0DZOhC832wOC/qzxBn2ejgbmmCfgvqf5UXENzfPw/b4e0DY6aNNLpCK0h41WXav/jSH
 opAUEv/HRD3f986FO4Gz1PDp5NVknqKIgUpwW1jJ9QwYpeJ3S0j4QHwmuruLnmSqkdbGI+TBs
 esIIwOp3QB2Dx6oxS+4IYgaRwDXbQE26AdE0EDLSHW1Z8/KXTkCwBneBvAvL1WMy58EQ5DXJt
 axykPGwCSZ+zTuhwQPfxkCYd2iGDtzJ2yFcdf1entYTBaSm1rImnribgQ2r14VbxTAkr07Bmi
 cZbfoChIBaGaUU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
cnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwppbmRleCAwYjQ2
N2NlOGQ3MzcuLmFiNTZmZjIzZThhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMTkzNyw4ICsxOTM3LDYgQEAg
c3RhdGljIGludCBpbXhfdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwK
IAkgICAgcnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpCiAJCWlteF91
YXJ0X3N0YXJ0X3J4KHBvcnQpOwogCi0JcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwotCiAJcmV0
dXJuIDA7CiB9CiAKLS0gCjIuMzUuMQoK
