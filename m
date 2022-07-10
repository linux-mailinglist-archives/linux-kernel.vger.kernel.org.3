Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3DA56D021
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGJQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGJQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2013E14;
        Sun, 10 Jul 2022 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471498;
        bh=MsWxBaLlxA4ELwYXkzuPt+y1986U/Jbrt8tDYt6WPtU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ePqk3UCYbWhcEREOfn2BmyXgqSXhiA4giff//b8To8GFdDdl7w/8Li5xm6UorodsM
         WlGlY+UqoPiVpp9pASd3SI4y9ppyA/WhYgXpc+9y/iytVZMA+EzP3dYDENd9IGK0Eq
         NSP43hhHPlV+8Pi2JsQDoauZC/n6QVP8S5Tz2RHM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvbBu-1nKXjL3YcY-00sehu; Sun, 10 Jul 2022 18:44:57 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 6/8] dt_bindings: rs485: Correct delay values
Date:   Sun, 10 Jul 2022 18:44:40 +0200
Message-Id: <20220710164442.2958979-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:pS2amxHgDU+Wqa33aIo1OuacztgWxkio2F8l4JrUK1VzOdgcVA5
 BHIxYGcVgBkD1j9QSuzO8Bi31IPuzNtlAVefpXKX1EgGeJXT/bcOEGRlCj3cXDs49oRryx2
 +5EzF50w7rfGvw1ROEgQuRQZw9Ib9VsG/pOeOP063V4EEZtBlCqh5znEI1XfyhzByllDv0r
 oA0HfvHlEePKUN8Q8YXlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3JcwZC3pljw=:ia63mV8swlzNczAFBk8Rbt
 Wj3umSjlDASFbqh4PJMZtDocYNtEvRpvQgA5O4TL4jaS2UiWmhqEdukEOINLs255h0BGa9jvu
 3hVBTijPiiQgbXlb5/CDm+FTfl82O3tI8B0F6jYfx73xxG3V+gMxkjaMY2aTIz1FNevAC4+0a
 CY3bnEyck1fAPTwXSXrg6XCwOPY+InmSj2zmXmGN3ZcHSdJtUEVuU2K4f+/+6Hk6zDAvhcjIS
 MxqUL4AyeJgoANSkp5R/llwGeqh+RjO/PWjCNWB8YGROwDbXR+8XdszBWGEH2N1isBzK0O6WG
 CC6xUSBr1PZdhFHI6sGAAQ+z1AV3tcVD207JvHemBvWfbo+LXGp5lbFHRIgsue7oYVQXvYp9W
 D4cC46KQdKHLhKJKZFx6crAWY8rHnpfqsSY5C4Jq7pVngBOn79qAhGfEkpUZUx1B2T5QQgXor
 QFk8WyhmOvfoG9hOLDOY14Z10b7GFQy8oWVV0U6q3TSnev2ErobCzW8nroGaD+BKrIGVWWFCp
 5yJUrQCwCVmFHFHVtKpk5X+0/3pXDyGNEhj6f0fdFhx45WvA1TzGani0OT7eN1X0zgBc5Ip9R
 IS5d9IECJWaLcXSKF3PKQK31AYAxh/Q75cgDYCvbiAk+vu03bUUih0Vq+6JC2gcynJoY8WZ+H
 m90KB8TJ2HuM6Fobk1w9uClnnB65mT0i3GcZKpua1iIQVn6wzB1bgL+m83t0eqb/DSlIvavq+
 NLvR9ZA8qzMuzONlYjfigjeXL2GX8BwhcwD595bR3NfPZ1aBpTJ26rv4BHvEAC80YEOQHoCeJ
 N3zROmEhqwwHiSRSikJyMe5L+/fCeyRrZuAzU3hNCZtAHMzQ9gz2Z2CkRo7OjRyPL3LIBPFVg
 wYOMY8K5DgIsUFGgdxoiS4d6Q6fbavyXLMDTcSA8gOI4cXsBWrQTe8g9yasmDH9KY/KuoGkGi
 UjRWZ1lPhrvBNpaDbeD+qfpMRPw23KnHHOIhLwbzXCvFUoctH0TiDRjwD3ZcnHlf9evGuK7cN
 UZr01oen8zpTL7RgFaP1oCt6l84DjBp/xUZWSCmLraGrWI7o/aZfY2fRhsHffqKaQlZHHh01Z
 D/TlArsNIXMrLY8BKMumZfi84Aj+7zzY1Ql4rtOoMfVENeOwg2WK7shFQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkN1cnJlbnRs
eSB0aGUgZG9jdW1lbnRhdGlvbiBjbGFpbXMgdGhhdCBhIG1heGltdW0gb2YgMTAwMCBtc2VjcyBp
cyBhbGxvd2VkCmZvciBSVFMgZGVsYXlzLiBIb3dldmVyIG5vdGhpbmcgYWN0dWFsbHkgY2hlY2tz
IHRoZSB2YWx1ZXMgcmVhZCBmcm9tIGRldmljZQp0cmVlL0FDUEkgYW5kIHNvIGl0IGlzIHBvc3Np
YmxlIHRvIHNldCBtdWNoIGhpZ2hlciB2YWx1ZXMuCgpUaGVyZSBpcyBhbHJlYWR5IGEgbWF4aW11
bSBvZiAxMDAgbXMgZW5mb3JjZWQgZm9yIFJUUyBkZWxheXMgdGhhdCBhcmUgc2V0CnZpYSB0aGUg
VUFSVCBUSU9DU1JTNDg1IGlvY3RsLiBUbyBiZSBjb25zaXN0ZW50IHdpdGggdGhhdCB1c2UgdGhl
IHNhbWUKbGltaXQgZm9yIERUL0FDUEkgdmFsdWVzLgoKQWx0aG91Z2ggdGhpcyBjaGFuZ2UgaXMg
dmlzaWJsZSB0byB1c2Vyc3BhY2UgdGhlIHJpc2sgb2YgYnJlYWtpbmcgYW55dGhpbmcKd2hlbiBy
ZWR1Y2luZyB0aGUgbWF4IGRlbGF5cyBmcm9tIDEwMDAgdG8gMTAwIG1zIHNob3VsZCBiZSB2ZXJ5
IGxvdywgc2luY2UKMTAwIG1zIGlzIGFscmVhZHkgYSB2ZXJ5IGhpZ2ggbWF4aW11bSBmb3IgZGVs
YXlzIHRoYXQgYXJlIHVzdWFsbHkgcmF0aGVyIGluCnRoZSB1c2VjcyByYW5nZS4KClNpZ25lZC1v
ZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+CkFja2VkLWJ5
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgotLS0KIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFtbCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwKaW5kZXggZjJjOWM5ZmU2YWE3
Li45MGExYmFiNDBmMDUgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zZXJpYWwvcnM0ODUueWFtbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwKQEAgLTIyLDEyICsyMiwxMiBAQCBwcm9wZXJ0aWVzOgog
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBEZWxheSBiZXR3ZWVuIHJ0cyBzaWduYWwgYW5kIGJlZ2lu
bmluZyBvZiBkYXRhIHNlbnQgaW4KICAgICAgICAgICAgIG1pbGxpc2Vjb25kcy4gSXQgY29ycmVz
cG9uZHMgdG8gdGhlIGRlbGF5IGJlZm9yZSBzZW5kaW5nIGRhdGEuCiAgICAgICAgICAgZGVmYXVs
dDogMAotICAgICAgICAgIG1heGltdW06IDEwMDAKKyAgICAgICAgICBtYXhpbXVtOiAxMDAKICAg
ICAgICAgLSBkZXNjcmlwdGlvbjogRGVsYXkgYmV0d2VlbiBlbmQgb2YgZGF0YSBzZW50IGFuZCBy
dHMgc2lnbmFsIGluIG1pbGxpc2Vjb25kcy4KICAgICAgICAgICAgIEl0IGNvcnJlc3BvbmRzIHRv
IHRoZSBkZWxheSBhZnRlciBzZW5kaW5nIGRhdGEgYW5kIGFjdHVhbCByZWxlYXNlCiAgICAgICAg
ICAgICBvZiB0aGUgbGluZS4KICAgICAgICAgICBkZWZhdWx0OiAwCi0gICAgICAgICAgbWF4aW11
bTogMTAwMAorICAgICAgICAgIG1heGltdW06IDEwMAogCiAgIHJzNDg1LXJ0cy1hY3RpdmUtbG93
OgogICAgIGRlc2NyaXB0aW9uOiBkcml2ZSBSVFMgbG93IHdoZW4gc2VuZGluZyAoZGVmYXVsdCBp
cyBoaWdoKS4KLS0gCjIuMjUuMQoK
