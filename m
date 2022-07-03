Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C65648CD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiGCRCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGCRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:02:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6C6255;
        Sun,  3 Jul 2022 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867693;
        bh=AAX50up9vrAlY/p/+wJUzVHbLcYBIrsT5uEQh7IkmNY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y9+z4Autfh1ycKRvZkjfgTSyYoVnBehSUKpQ8YHzXjTP+yqmOGPmt0GFbxVbvKpqe
         XkIAowi8qE3JZEwhCE7X/bLrO10Vo3b9SXAGA7rtFyXahwCs0a77mdixtxQqgvxj+a
         KJsYPge8l7shau/QnBdFs/wZSWc1PSvKp29A9npo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYvY2-1o3d6b0r2W-00Uutl; Sun, 03 Jul 2022 19:01:33 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 8/9] serial: ar933x: Remove redundant assignment in rs485_config
Date:   Sun,  3 Jul 2022 19:00:38 +0200
Message-Id: <20220703170039.2058202-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Qo0skloQF62CG0UUEStUQZSV1iogB+E/uMIFp0z7Lb6ONP5anEp
 cAtLLk6++A4T+0LnXbRMWpuYucEbODsNpcHSrTnjD0skN8KIuvvH64XyrcBetnCRBJ0nLBb
 oL9LGqWityudKugIPobY+XheImMQ8NuYWtBZ7ckB+YKAASuJ6n/zihekYWaoSnsFjL2ApkI
 y9hoTppvn+yMGVd4LSv/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GswIleH2Oq4=:qGXjT1EUAtBYScBPZcRc2g
 Kk7goyv98JI4EvKXTmuWK8gYvFCtvqB7gfVAQjg/GCoJHxxko7U1JnIIJ1K//Q9mbZEGRwtyy
 jkKJJBBA1PTi9wz0bCs6yzkL8bXyj13zorrSxDHAOfmzqhXBe5bi1cqr9tCvJUfBk/SUjYVEv
 1GuVrsaaYZdXbVIM1o06XCrEzpbqYyQmVa9ba6PejIcOmzNa1oizwfubER32cjHVD5QdIWEIv
 YyleB7iSuq1hv7QRaKW0pAJH58RBlOSDr4FFNk/4sLhFrUYGt5YetjtsLJIoIhbmmRq0ECzWm
 aCBrzrE+JrbXZW+Ax0ULX4gUn/fs4TFuwbrjnDxE4PDzVYImiFBsMLUvKGzt5DPaeKXkgOaQR
 VRnx43HvqLp24aAuGz6dR54Om4bbQHZDmV4mgn3ku2XNatLu9HCl0Fo74lnF4cd/TpsqIXiEB
 78/lKoljcMrCoSNLwqZOweUKlncmH1UADlwVY2AfDnkvbAT4LBIqqYklHSZ//XkqWWhJ8EJVY
 4k/0bh+iergvKbyJfirXsmGo8RfJS0/AzPcJZXR/y+vBFY3JpIvW+1Bfy5Jd82qzFjioELvwB
 ydpEf3eKFX+aH05sUuK3SVZO8hZZSP9XF34MrOOJo9jDj1n6wYLoGMwqDIqAmlpqPmRsLC4TA
 Cmst+WRLIrBbOqR+60+ZlFOJD9mhIDO+1tkE/WMbMkTI6VMKHNbALvvok0Bv17J1imIRrTBaH
 sulpRyjQAOHQeEahqm6KBkctTw/7v03Lw9StHRpzmu7GEcdv2sU2ahwcWPzk/jEJpXlgeqyQr
 uPtbExaRnaK3ntacrQh1sPbyEfx8m7LeuPzMvPeqGed0mLAC/OPVeKzZRvwygG2x1frs47xnh
 /EMaStot/N9YFjRL++X/Jumd1w3mmSNI/3j4F2aNfi6f4C0YBATRjVWvFfwu8CwWcbkQPJWUG
 ngESaWIbYqHHDghMk/XwDr+3GQLA+hqivJdPp/ZaGsDn+xjyE3mkhX1UrFTwTEe17HWwW2nqm
 Lypwhq1CvInOJvto8vegRnQV3bpIf5qUgkLwZpkNrRT1NZlsO4aaNexrzYNxIr2nSe9IiQh4m
 9pJLBpjNojGVWYPApshIRSBbG0M1+12EilhxIqGEUYzyYR9O5n1w7O6Xw==
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
YwppbmRleCBkYWM0OGEzMzBkYjYuLmUwN2Q4YTU1MGE0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91
YXJ0LmMKQEAgLTU4Myw3ICs1ODMsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVhcnRfb3BzIGFy
OTMzeF91YXJ0X29wcyA9IHsKIHN0YXRpYyBpbnQgYXI5MzN4X2NvbmZpZ19yczQ4NShzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsCiAJCQkJc3RydWN0IHNl
cmlhbF9yczQ4NSAqcnM0ODVjb25mKQogewotCXBvcnQtPnJzNDg1ID0gKnJzNDg1Y29uZjsKIAly
ZXR1cm4gMDsKIH0KIAotLSAKMi4yNS4xCgo=
