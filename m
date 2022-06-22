Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB5554FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359566AbiFVPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359512AbiFVPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D03DDE2;
        Wed, 22 Jun 2022 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912841;
        bh=qz3RPS0BDICfMwamW1svnc7WnNORF05BoX0V9U034PY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q9rqsXtaMHi1YlwEa4O0LljiLQt7E7eGVDzXCe1m3Yy3wLBQ7vFYdpRI7fJyZL1bQ
         5Cxs6jYX/4aBEwGVeAPTeZgRaLf0XPC6ZNTOpJelWV3dscEzdqDkJkX5or4q2LcKbw
         dhbwwV6XNVM/14EiK85yEoNrnQ3brzR8MaIAfye4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1nVGBi1rNf-00bN23; Wed, 22
 Jun 2022 17:47:21 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 5/8] dt_bindings: rs485: Correct delay values
Date:   Wed, 22 Jun 2022 17:46:56 +0200
Message-Id: <20220622154659.8710-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:prpxpsnL+vHyU31JlXHFy4JJMQnzLkmjydzLnz0hdCESo10CyX1
 BvFe2Ef67UDIzefsCrVEOhPDaCAtKR4JHdmHsOz67qK/B8uxQAFJ82e8iG8FmwlSZAUNKUe
 vuPmKM2UUf/cR8cMFcG4JVy+cwZ04tp2Pgj9ww0tWhodpEEcBDqcmbOLBm/jifd9EocrflE
 sq/FpHGFY0ugxgYIfmoxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jd8EvS36E6A=:+4D6ILjoBJaOwLyGtJ7GPE
 EIj2y5rNKJk0IVlrWHMTCPYRxfEQd/eIRDbQfitfnXM91yzFq3TFivv9LzEfzjX+692TvAKOL
 iYfbf1uLMGtEiZ04idQ+T7J44UmljX57MdOVO7jqOpdjEp009EjD/A/mk04s0BZ+Eaz/WtVO4
 B8Op82x6RrWmcAsDim1UXbmJMYiu6GkdkL9zp8ZHhZ7V4uVIzkXTJoDLC9fyP52/IbWhqf2sE
 srcFDsTgsJDnl62pwdq07j2DJDgMROQSy3h8+XWOi1btlYNRqqzYIjB10zjCpoP0lsH3YhnvA
 cARGw+jWzL/1u4W3NQGs8DMIRRLY1QqeW0NypF77SVxokB9M2W3XYJW1vR4lIe9StdeZzdpyj
 qisg0AH0ToqAtwd02qCgkQnUb21RRGcxKd1q7Uq6RwQaIwT6xMfHn8DRO/gSsimapaRaQcNM+
 MKkQk/7/OTdLQPl4qfZH6xw084uD7NBvYodqI2WjOpmsWqljgaJhz9kP5LBLWwqWgyT4e3fAx
 Wm4hJwrUw6cqoZ0iqvT+/GL0TQfWlbaWj2vx3q/IiyWfunOorZJY4a9eVVF+fTf2CiazJBfgC
 BNwj/pTN/TKNYfNF9SNqEa465zZKkH/cCbtcvAHfboAgOAfGNWnXZ/P9No4+SOISVg67grzSz
 j/YNNolTGeA26jLX2VYynCcTijz3FCGzPtwh54IaM6AzG8VTP5z3v7GyoMF6Hdl0zP559Fdyn
 Gjc7Z7s/D1gcIZOD8lD1VnHgVJuuBzWNkhOR614GTmB8yQosBZ4sP8wZ7GAX1G7uhRVQil9WI
 N4UIRDtX+Kjf2aeXmm8VGlaTdX1c/dAhhZrdTXEHN4C2GfNAnOtJNXdOhHdbw4iWcg/CiX6fv
 tskcnHOfj3o+gXBpCHSIHuNFKHJzoaT6PgdxYGfRm6vTF/xQalqqMGsvRhcmcX6wlmrpu6dy3
 x7vn9ZcyM7PgdgPbdR8pHqA9b8twRGmqveMDrg4kJReMVjI/U9TXROVnTqlQP6P+VehdacfO0
 lV3aWZFLLQGHF+ogy4RJTxHdcUmuRS/boTzuGblmPqFoGVYQh6V+IAgVmvKb/SV5Y1Vox9hmZ
 UnAsPjOizVJmcZNXtRf6IRM8FONJO9KD5uKT48zVLpuhyIM2RBWX2CbZA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBtYXhp
bXVtIGFsbG93ZWQgZGVsYXkgZm9yIFJUUyBiZWZvcmUgYW5kIFJUUyBhZnRlciBzZW5kIGlzIDEw
MCBtcy4KQWRqdXN0IHRoZSBkb2N1bWVudGF0aW9uIGFjY29yZGluZ2x5LgoKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwgfCA0ICsrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sCmluZGV4
IGYyYzljOWZlNmFhNy4uOTBhMWJhYjQwZjA1IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwKKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sCkBAIC0yMiwxMiArMjIsMTIgQEAg
cHJvcGVydGllczoKICAgICAgICAgLSBkZXNjcmlwdGlvbjogRGVsYXkgYmV0d2VlbiBydHMgc2ln
bmFsIGFuZCBiZWdpbm5pbmcgb2YgZGF0YSBzZW50IGluCiAgICAgICAgICAgICBtaWxsaXNlY29u
ZHMuIEl0IGNvcnJlc3BvbmRzIHRvIHRoZSBkZWxheSBiZWZvcmUgc2VuZGluZyBkYXRhLgogICAg
ICAgICAgIGRlZmF1bHQ6IDAKLSAgICAgICAgICBtYXhpbXVtOiAxMDAwCisgICAgICAgICAgbWF4
aW11bTogMTAwCiAgICAgICAgIC0gZGVzY3JpcHRpb246IERlbGF5IGJldHdlZW4gZW5kIG9mIGRh
dGEgc2VudCBhbmQgcnRzIHNpZ25hbCBpbiBtaWxsaXNlY29uZHMuCiAgICAgICAgICAgICBJdCBj
b3JyZXNwb25kcyB0byB0aGUgZGVsYXkgYWZ0ZXIgc2VuZGluZyBkYXRhIGFuZCBhY3R1YWwgcmVs
ZWFzZQogICAgICAgICAgICAgb2YgdGhlIGxpbmUuCiAgICAgICAgICAgZGVmYXVsdDogMAotICAg
ICAgICAgIG1heGltdW06IDEwMDAKKyAgICAgICAgICBtYXhpbXVtOiAxMDAKIAogICByczQ4NS1y
dHMtYWN0aXZlLWxvdzoKICAgICBkZXNjcmlwdGlvbjogZHJpdmUgUlRTIGxvdyB3aGVuIHNlbmRp
bmcgKGRlZmF1bHQgaXMgaGlnaCkuCi0tIAoyLjM2LjEKCg==
