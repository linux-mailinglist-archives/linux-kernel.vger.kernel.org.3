Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9556CF9D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGJPEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGJPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694206552;
        Sun, 10 Jul 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465412;
        bh=AdWDe6Q5QpRDiXyrdxp/60gdvK8IQ697veYdYB+5CPw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RpDQmP9YpKA3kZJbp2nBYOA8WtEtCb+ZCafnb3qhJttYtVM1UlLmyID40TdkH8BhM
         FOS78SiPO674Vz7f9FQvUBtc+hGE56XwCU++wYVYY3kjdnWW2vHCnWhvPmWv7YnIq4
         5hYhtjHJTHlYF4z+5XQPFj/cGCEFnggMxAnBO9iM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSt8W-1nzzoL3KHO-00UKK3; Sun, 10 Jul 2022 17:03:31 +0200
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
Subject: [PATCH v3 6/8] dt_bindings: rs485: Correct delay values
Date:   Sun, 10 Jul 2022 17:03:20 +0200
Message-Id: <20220710150322.2846170-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:yJi8p2NgxKQ8FKq06j2HKJzfUCvFcCx+6G4JpaRdHQrk8vklqVq
 lFC1SiKRhr7xeyGLdAfLc95ybCifFXnM+72ScdGZueBY1rmd4DIkdfMnqTq3Ep+uFMD586X
 YFLV2NbYXbQBRPPbLheiHCyZ/PVjeAJ9eCY7DkrYv6rreMlnlqII/fEBlwM04Jkh+GtFbJk
 wtI3rzaRYGOMrHTr8l8yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SmAIpv7yMk=:tEAeLMKY7NmT+XfzJj9Hu5
 hwBVsIRn2eI7//D+ZOZ6ZmDO0dssPPpv3Phy8hEPIBdFquyv/ecR/zCZXRXFb7SyfkEyKoGV2
 bLKE6X1YZxPCLi88ON/dituSvUjsN8yq48FJr5Q6ZXMYcpE41FYD0IWdhuLzDLQkTu0GrUYvF
 +qRV3nf0pYInsGbRVrbiuixWtck76W0VZmfeuF7nFARhr9r7k69pHQRT23CqYSzemJXEJdN+3
 AOy3NCie05wzoLQlEPsBq17pIHRh1GeHwoB8wTsymb6EUGkYmFv9R8a6wO2RJemScdSmtOPfr
 S5BTzpeMCG5NCovFq9Ginr55mgvcn9qzZjV2XoI+zMBkB2/Y2PQYiqKkLX4cxEVyFyucXt2+z
 VVZI42+kzORSW01iCrW9mLgqKoO37lMjkbi6Fssq46Y9zStDFNHxowPHuy3dsctxBWw28YEHU
 tsAlO1UDSpwiTVyyq8oCb0xBa4ODtqfIB3XePu76Mgu8eq59ytDJiIK+O0K16xyi4bXH/nED9
 10/3/eHmmCdUAUL5XGq9jbbpt8SsOTi1mYZsqVh7TISmOPNGqoFycm7CXO3RX5VBx2uwCUP1Y
 GMKbxzpwD/TySOUMe57zNsTZh/BwyhNGKcdYi19n203ZOo0TusIm70l3aANB1Vi6qguPwPQe9
 JVg5dQ7JMjNp7U1Z/SLZmhsW1wiClEfRRwrrZNT1unfoOA1urKu6s6bdfKOkM+6LGqN7a5+ox
 P0eDRfDJwwk2wgdXxI5O7zP+dYAYJndD8Ym/eD/D/L8D6J/tsY9BKyF+Y5fAuBDQ3Ml6I33rX
 DMwUN9dhv24UvTH9oOLDtFCYPXdoYoFQZuSJr5soSdWSmkmd1VrVgw+HnHRa7DXjlRzcDmHU7
 m2cBYrigKZy+cVEtDxjNCrW3GLlGhHCH8FxZHBwpZDm/9PEGOT99//9iRKt+Ik+hNxJBMfFHj
 KQ0lthjHs1O24SGddWAzqJhMtlBAVdXcbxOCpHs8FkZri2//ln5X0Pff2Fnvk8fpV32zibe9O
 WK1gKYj0CEz/GoN9pMWSSwiH0M4ig9QyNBIRl/Hi/UX0ygM/5cDOWpSHC9G+sPzVatYixPFa7
 UGReiGg37X3D8DUx1HLKUKXT7Y3tbZS3Tagzxr1ivCHc1yC3z/2roAG+g==
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
dWFydCBUSU9DU1JTNDg1IGlvY3RsLiBUbyBiZSBjb25zaXN0ZW50IHdpdGggdGhhdCB1c2UgdGhl
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
