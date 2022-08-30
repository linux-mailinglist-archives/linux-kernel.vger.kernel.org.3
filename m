Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250BE5A6873
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH3Qb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3Qb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:31:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60B8B980;
        Tue, 30 Aug 2022 09:31:54 -0700 (PDT)
Received: from [192.168.0.74] ([91.64.235.177]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mj8Vx-1p5xjd0PHJ-00fCHk; Tue, 30 Aug 2022 18:31:48 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     mathias.nyman@intel.com
Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96
 controller
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Aug 2022 16:31:47 +0000
Message-Id: <emc5c926da-851b-4152-8d2f-9d43bab7bcdc@607fe812.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------=_MB3241BCED-BD68-41C7-BA37-E3D7783F0573"
X-Antivirus: Avast (VPS 220830-6, 30.8.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:06BnlqnG/Q1vMM+tYaQjtE+/EPWOxCcUeMYUonqvD1llIz9ZNbH
 OR1yJNab236L7Jzf8y8knJbfR8e16B1nv0/JXRL8QED6YjNvgIWaQ99fL7Kvqv8ttO4eejE
 DohW2pBGGg5beePDEBNp+JTyKt0/5ovl1WEHPLD6ge3xkNdLovio+h3zvsOa3ZiPHoCVnbO
 4HxMO8J+N/rWQ9LMn88jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2KGciDdT2wc=:ct5ZKgbBHpmYjwhpkOVLK7
 iEcr+HA9Z2b8SFqfgkP4gIXozO9+Cogf9b2K/XDau+PONNdF7pud51q4pCo6F1np8yQZx5P3g
 YH6OPN+RlCcAegv72oubPRVCdYXH51zOH/MgAqIpPIaCt0iKVrChM/2GC7kOE6hXgzaZxjkTS
 ke3QRMtxWWuOCUTeaIn97p4+diVFFmy5Lz+RBAS0Oj2GcQObHesoSLBRgYzG4EFExs4zEAUfl
 5VZh3QyzZ7eBWAzgyubnMph3/ESQzxlUyNluX/B+qSW5vb3+D2M0/pMe6Mhaj6cbCAnZHJ2Bl
 dGuuHAKteSd744nsfgT4LbPj2aMi0mguXHLFIEi9BBHYKqkPw7xOu2lomvNZ0RSPXGNq+k3tC
 jYHbAFuV0pG+p2r2WAjzQBxftytACgMgjEpWKVFxK9jRiilsciEeEP33icOVNxM3ffJvMVMgP
 cZX/yBn3onDQM1OfeII+MYEVeHBHV6XPP3qgKCIqS+10QPRt3Bw6QQgCnYyLVIrB18mq+TO0D
 PDYB0mbvQAOd+zwGpEzaIm6pjR2yv54Ia5y2adXXw1dVdtEsBMwwxPO+CQgAL09xDTA6Px79w
 eEXmVuZZdPWgEYFAM8IJzNZl57mR5cywmHDks+l9L3t0X/2rGH1VjcEhB2p/t5GBUwms96Y7q
 T4TBe78JqyULGXdJRNkyru6GHcDN1ajXNwUtV/oUX1Vd6DEsF1+vo59lg3nYHOhuLJNE/ACqX
 jEyPM6I8r1oIzYIf9YeL1dk0q5CNDP2xefhPYnwQRFSnSsOuviHnZbmROmQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------=_MB3241BCED-BD68-41C7-BA37-E3D7783F0573
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi there,

first try at a patch which was an actual pain with my Lenovo T500=20
notebook, augmented with an USB3 PCMCIA card that has an ASM1042 chip.=20
Inspired by this email thread:=20
https://markmail.org/thread/7vzqbe7t6du6qsw3

ASM1042 identifies as a 0x96 XHCI host, brings spurious transfer event=20
errors with a r8152 (Realtek 8153a) USB3 enthernet adapter. Additionally=20
setting quirk XHCI_SPURIOUS_SUCCESS seems to resolve this issue in this=20
case.

wiith best regards

Jens Glathe
--------=_MB3241BCED-BD68-41C7-BA37-E3D7783F0573
Content-Type: text/plain;
 name=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch;
 charset=iso-8859-1
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch

RnJvbSBlYWMzNDEwZWVhZjAzYzExMWFkZDRkY2UyNDdjNDAwMmZjNThiYTVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEdsYXRoZSA8amVucy5nbGF0aGVAb2xkc2Nob29sc29s
dXRpb25zLmJpej4KRGF0ZTogU3VuLCAyOCBBdWcgMjAyMiAxNjoyMzo0MSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGZpeDogYWRkIFhIQ0lfU1BVUklPVVNfU1VDQ0VTUyB0byBBU00xMDQyIGRlc3Bp
dGUgYmVpbmcgYQogVjAuOTYgY29udHJvbGxlcgoKb25seSBpZiBpdCByZXBvcnRzIGFzIGEgVjAu
OTYgWEhDSSBjb250cm9sbGVyLiBBcHBlYXJzIHRvIGZpeCB0aGUgZXJyb3JzCiJ4aGNpX2hjZCA8
YWRkcmVzcz47IEVSUk9SIFRyYW5zZmVyIGV2ZW50IFRSQiBETUEgcHRyIG5vdCBwYXJ0IG9mIGN1
cnJlbnQgVEQgZXBfaW5kZXggMiBjb21wX2NvZGUgMTMiCnRoYXQgYXBwZWFyIHNwdXJpb3VzbHkg
KG9yIHByZXR0eSBvZnRlbikgd2hlbiB1c2luZyBhIHI4MTUyIFVTQjMgZXRoZXJuZXQgYWRhcHRl
ciB3aXRoIGludGVncmF0ZWQgaHViLgotLS0KIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYyB8
IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMgYi9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktcGNpLmMKaW5kZXggZGNlNmMwZWM4ZDM0Li4wMzUyMjliYzZkMjkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYworKysgYi9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktcGNpLmMKQEAgLTMwNiw4ICszMDYsMTQgQEAgc3RhdGljIHZvaWQgeGhjaV9wY2lfcXVp
cmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHhoY2lfaGNkICp4aGNpKQogCX0KIAogCWlm
IChwZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9BU01FRElBICYmCi0JCXBkZXYtPmRldmlj
ZSA9PSBQQ0lfREVWSUNFX0lEX0FTTUVESUFfMTA0Ml9YSENJKQorCQlwZGV2LT5kZXZpY2UgPT0g
UENJX0RFVklDRV9JRF9BU01FRElBXzEwNDJfWEhDSSkgeworICAgIC8qIHRyeSB0byB0YW1lIHRo
ZSBBU01lZGlhIDEwNDIgY29udHJvbGxlciB3aGljaCBpcyAwLjk2IAorICAgICovCisJICBpZiAo
eGhjaS0+aGNpX3ZlcnNpb24gPT0gMHg5NikgeworICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lf
U1BVUklPVVNfU1VDQ0VTUzsKKyAgICB9CiAJCXhoY2ktPnF1aXJrcyB8PSBYSENJX0JST0tFTl9T
VFJFQU1TOworCX0KIAlpZiAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQVNNRURJQSAm
JgogCQlwZGV2LT5kZXZpY2UgPT0gUENJX0RFVklDRV9JRF9BU01FRElBXzEwNDJBX1hIQ0kpIHsK
IAkJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfVFJVU1RfVFhfTEVOR1RIOwotLSAKMi4yNS4xCgo=
--------=_MB3241BCED-BD68-41C7-BA37-E3D7783F0573--

