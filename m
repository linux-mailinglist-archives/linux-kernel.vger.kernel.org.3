Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE3554FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359509AbiFVPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359161AbiFVPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176633C4AE;
        Wed, 22 Jun 2022 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912842;
        bh=5KTQXMZiT6D7UTxVVBqbL5j7igCB2KvHxvl0c3jIThM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b23P5kRcBPxk+Mh5R0DyccQRxSN7ul5bW/3joQlL/4IfG4g8lESitm603XuYPUY/f
         Dd2ogve+eR32enNs0eKYopEsm+U5PPTw7YMi0xSzSganBpDv7zYOeV45mXoLLqALam
         n4JeecrWhfRdQsxMaM8pRNkPK9vx+4uWTai5ekuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1o73mJ0v0f-003guP; Wed, 22
 Jun 2022 17:47:22 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 7/8] serial: ar933x: Remove redundant assignment in rs485_config
Date:   Wed, 22 Jun 2022 17:46:58 +0200
Message-Id: <20220622154659.8710-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+/P+cW6WC/sfzPNKX52MvBHuDtz6aEhlqHZ5nTG7UhbBBXSh6BA
 mjRMJwcHAM7Yeu1flSL1UmEVHF4kzmijtSwjB5fLJMlCYt0HznQ93Wq3KEFFrwXNQ+ZedWS
 tnXPaXlpEt3p2UgqKqA6GxaPzGPLsEt0jbJCaL68R7iwhwRcHJa/1qXPSOEyoxeYzUbYP41
 df3UthSFC98NFFLbvT9Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZkIw/wbidMs=:QchOS8ZSYUDzL5VwVNxQPh
 M1Vin1g8XTNCVIlZjM+S9zCpAi2ThwSjOnJGpUAGH7hf0FR74m7Wo2df6dnPHWOMQ3pTMP+Xa
 TDkdTWaD6g5n2mgZER5aNCnYAS82jdVT98RA9+Z/wX3fApONnLiIb7oZ3iQjsmC/+cKOak0Cd
 l899MXix3GNBUF8ceZQI4f+IeWzMjM/u0FGI2LOR1xY3Egh5CXqPZqn84Mq8WP/P31KqdrxHq
 OlKh6vkk+1bK7VifnQFWARCH37n3+29e6U8wdpgNBzDPuiEGvlihkUjxQYc0RfGIZxK0zZ8jU
 kxEPOl+y4ZPbpIwFwsGaMMd4eaI848CFCATkO0NarmAaqPfy7RmCJ4SOoDVY+TTtY4S++l2LZ
 gvcYQy14oJRa0X0VAgH/n1xz/CPuMP+v4BRdQAg3s9rTDtXNh3WGxkRKsLeiVWo1ImfdhVB1o
 D1tXwS/ye87TrwcgC8ir4bIsET1NzBgYgB1UZaos4l2W0YjvyqO61+HFdZY+cCSzgigzSMi18
 qMpjQy9857p+7qyH3qax39Dx3n/vN3WFRHYelP3DMoSfc9UDP2dZQBwDV7Y+VEaK1xj/vxs62
 rLGs7YUSqFEAncPXZLfFHfgT0TGOQCBhO8V1C4e0eVeNNZR0uJyO7zDD6MpiqV1hAFk54hEs+
 imCrv7ce9l1zzvULo7AwIhHB0YhQ6Z1vGFZ0cPtfeqIh9oquiQaPo82sSLTzN/pBimKz3nQSy
 uvEOZPfv9QofW4qgzfNf+7Ow5IIohW9T8hQjjcJ+c1YehpibMYh8LIbsNjoa4K7/7er+hTS7S
 44w069ud3GUhSzqAJ8Y3jv16/l2Q8V2gZBwHGgUoM9P1uxKube94aNwZ/8qcg5bxfJoMKsjYX
 GcF3ZcCSY0m5Wl/T/TVFpDjVHtIzp0p3PLFenz6faEh/L/zFqcCW9NZU24dRENv5qQVMTV7j4
 b7gNO9KpVIs1B4kE9KFI+o4XChCyyIwufrlFmsGwLpTleKf8Tw5Hmiyxralvy7OI0sS2TGnL3
 eNYWHv4EOA9ExM7oNqqdAg7oMKnbbQoT7hhs9ezO1NwFZFlei01nyhL968OoSrPz1Us36N9bS
 GHnB++5ZabW3zKc8DfQwk+lyLZpckBrq7vlLlUC7pMrelUlIgqMCwCFcQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHVhcnRf
c2V0X3JzNDg1X2NvbmZpZygpIHRoZSBzZXJpYWwgY29yZSBhbHJlYWR5IGFzc2lnbnMgdGhlIHBh
c3NlZApzZXJpYWxfcnM0ODUgc3RydWN0IHRvIHRoZSB1YXJ0IHBvcnQuCgpTbyByZW1vdmUgdGhl
IGFzc2lnbm1lbnQgaW4gdGhlIGRyaXZlcnMgcnM0ODVfY29uZmlnKCkgZnVuY3Rpb24gdG8gYXZv
aWQKcmVkdW5kYW5jeS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxp
cHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMgfCAx
IC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXI5MzN4X3VhcnQu
YwppbmRleCBhYjJjNWIyYTFjZTguLjg1N2UwMTBkMDFkYyAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91
YXJ0LmMKQEAgLTU5MSw3ICs1OTEsNiBAQCBzdGF0aWMgaW50IGFyOTMzeF9jb25maWdfcnM0ODUo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAkJZGV2X2Vycihwb3J0LT5kZXYsICJSUzQ4NSBuZWVk
cyBydHMtZ3Bpb1xuIik7CiAJCXJldHVybiAxOwogCX0KLQlwb3J0LT5yczQ4NSA9ICpyczQ4NWNv
bmY7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMzYuMQoK
