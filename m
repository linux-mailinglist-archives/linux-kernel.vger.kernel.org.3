Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D024B3E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiBMWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:33:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbiBMWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:56 -0500
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 14:33:49 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72435546B7;
        Sun, 13 Feb 2022 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791627;
        bh=WBgs4UsljChJvlnfHo4GVoBnICbWqNN2tqDkgEeXK8E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WMuLJzGGO3yM8k0byJUE/Y4U9umpFMUhF2vCCmGtZly1/kZ1UrysFXw7Jwu6+aZ6F
         4ijarPi/P5ceUTTC6qhztVzbQprKaUq9dogIB4+khpe7NivjmedMnFQPoqeQSpvQg5
         xFN3bwPtruvQzaDsGb+9FDk87xf5Snr8GlUwI/q4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1nVFpu35HZ-00GonE; Sun, 13
 Feb 2022 23:28:11 +0100
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
Subject: [PATCH 9/9] serial: atmel: remove redundant assignment in rs485_config
Date:   Sun, 13 Feb 2022 23:27:37 +0100
Message-Id: <20220213222737.15709-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Q3ZlTb7isrIm8pDj4u1NbzVTiR5ZqKFpbyFVf3Sdoi4eXu3Ta8z
 oYr8DGswb8CiESXcXRkinbjAqcyDZxNc8JafBdlTupttlUD+Z9NxWNASfbGJhOPYqeE5I6g
 ZvCF/t1Zd866PwCgY+foXoupJw53+0IHnS3uR1IJZwozNfOaUy2VzvCWMZzPGb7rd1/maoM
 10tuzyU9LtKQuXKqUFAjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PQKhTy0t+Yw=:jIQ7ZPJuT3e6i5/yCgdlfv
 kak3Wk/fSqMToJpkujRgrRNNHtpqrZOGR2S/YOVgOMvJpiYPpWLV1TKezM8n+G+jp4un21xVn
 x/B2ClqizVQ84jXAiFDr8FgUtTXLenUodV2LoVgVM/N8bsA1HwSjJ0P8+tydo1QHQ02dKKEa1
 FTJ78U0Txk0XO45vJdOELNQG41SNUOZzrHutBNQ6SNJ1xpI+ldsUeNP3VChfCFblQ1PNf8Tj7
 Jbn0c7MvQ8+GOIyg8+RKnU/ZtozL0GH7gF8DCOUl64xUA1LTMqpKuwPasOnOORDOYWIqwlJcc
 K9rTQrXX0liC8CQ0+oElDYbxgONLW51ZaJ79wvAa6RwxUAlkzzfW6BS9obmranRp32PGN2uFh
 nlTI/JgeVbKrtN/Yd9F51gml6IjsHtfARF1Ina/8EUqr2ahjWfFb3cAcLQsuTGa1le7CEcq7E
 S5DOHQE9wkf946JuPy1fQH3X6DaVnVLanNKPBy4dKe0OEfK5g9ERm8pvDVrYIuSmzMPvlYH79
 cJVwR+0yfkVsF0pZkRtrJqxwEbt1oDkpB9ALB35IKAqqxR3RFK49W8DYGfeeVtbBUpT5sIOQy
 mjbb7Mr7PIJfu6H5jpQ/XOF1cIAnrnBVoZR49vls33Yhe0rrS4EpbpZsF28uizkMIstkG2q+S
 z0M/lnGYdpvlnBsaZ2TLXngHQZlR7kSKUZROePTRaHh5BsYxax23menZQKC9oZOXt9TfpxU8V
 09Q9IRVRdGKz2uk8OTsfLqlDnh5iuCNoC8S/IuJDFaNxAnWdgpRt/VH+Nk+gFKhE0uO+YDCxw
 PdbIzvM6yqIKDvgThAw4yVqrd2n5HdsbyqMIel0eCQxdtQO68zXDxe9pQzEZkyvGa9bQ/L1vA
 JDbjOQgaNJjYn+lzDDX8Nh3nQRTB9L4fQ0oHfsLzEfc8s7XbhDmbvwqqK+iNCKxEgjT+3uFL1
 e+9ikDgYuii1VctIbizbk1QItjpeU5D2cNvi2r1IhEUX68QH3ReWUTYURLTfdh01xHCwB8Kb2
 LSA/hAc9Q2vHQwzP19mpx/SdU2SjlLq1cAcyuhFLQ/+BDZpMIH/cnbGaimyTwSEfakCPL4GxN
 OWNYKOraCl6+os=
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
ZWFkeSBhc3NpZ25zIHRoZQpwYXNzZWQgY29uZmlndXJhdGlvbiB0byB0aGUgdWFydCBwb3J0LiBT
byByZW1vdmUgdGhlIGFzc2lnbm1lbnQgZnJvbSB0aGUKZHJpdmVycyByczQ4NV9jb25maWcgZnVu
Y3Rpb24gdG8gYXZvaWQgcmVkdW5kYW5jeS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBw
byA8TGlub1NhbmZpbGlwcG9AZ214LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9z
ZXJpYWwuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYwppbmRleCAyZDA5YTg5OTc0YTIuLjJh
YjU4OWEzZDg2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5j
CisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYwpAQCAtMjk5LDExICsyOTks
OSBAQCBzdGF0aWMgaW50IGF0bWVsX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LAogCS8qIFJlc2V0dGluZyBzZXJpYWwgbW9kZSB0byBSUzIzMiAoMHgwKSAqLwogCW1vZGUgJj0g
fkFUTUVMX1VTX1VTTU9ERTsKIAotCXBvcnQtPnJzNDg1ID0gKnJzNDg1Y29uZjsKLQogCWlmIChy
czQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKIAkJZGV2X2RiZyhwb3J0LT5k
ZXYsICJTZXR0aW5nIFVBUlQgdG8gUlM0ODVcbiIpOwotCQlpZiAocG9ydC0+cnM0ODUuZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQorCQlpZiAocnM0ODVjb25mLT5mbGFncyAmIFNFUl9S
UzQ4NV9SWF9EVVJJTkdfVFgpCiAJCQlhdG1lbF9wb3J0LT50eF9kb25lX21hc2sgPSBBVE1FTF9V
U19UWFJEWTsKIAkJZWxzZQogCQkJYXRtZWxfcG9ydC0+dHhfZG9uZV9tYXNrID0gQVRNRUxfVVNf
VFhFTVBUWTsKLS0gCjIuMzQuMQoK
