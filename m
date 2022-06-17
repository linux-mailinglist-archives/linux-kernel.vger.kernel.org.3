Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1F54F474
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380786AbiFQJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiFQJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:36:48 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B5567D15;
        Fri, 17 Jun 2022 02:36:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DW;RN=12;SR=0;TI=W4_0.1.30_DEFAULT_211267C8_1655458496779_o7001c314n;
Received: from WS-web (tianjia.zhang@linux.alibaba.com[W4_0.1.30_DEFAULT_211267C8_1655458496779_o7001c314n]) at Fri, 17 Jun 2022 17:36:43 +0800
Date:   Fri, 17 Jun 2022 17:36:43 +0800
From:   "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Eric Biggers" <ebiggers@kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Vitaly Chikunov" <vt@altlinux.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-crypto" <linux-crypto@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>
Message-ID: <d76d7de3-59c2-4d83-9f53-b44ada7621d4.tianjia.zhang@linux.alibaba.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSBYLjUwOTogU3VwcG9ydCBwYXJzaW5nIGNlcnRpZmljYXRlIHVz?=
  =?UTF-8?B?aW5nIFNNMiBhbGdvcml0aG0=?=
X-Mailer: [Alimail-Mailagent][W4_0.1.30][DEFAULT][Safari]
MIME-Version: 1.0
References: <20210712081352.23692-1-tianjia.zhang@linux.alibaba.com>     <99a79ccb-8dd9-ac37-2a1d-ec390bcb0c8a@linux.alibaba.com>,<1ea7a9bd9f6d74e1b9a002a19c0923f184c17c88.camel@kernel.org>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE1LjUgU2FmYXJpLzYwNS4xLjE1La
In-Reply-To: <1ea7a9bd9f6d74e1b9a002a19c0923f184c17c88.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFya2tvLAoKPiBPbiA3LzEyLzIxIDQ6MTMgUE0sIFRpYW5qaWEgWmhhbmcgd3JvdGU6Cj4g
PiBUaGUgU00yLXdpdGgtU00zIGNlcnRpZmljYXRlIGdlbmVyYXRlZCBieSBsYXRlc3Qgb3BlbnNz
bCBubyBsb25nZXIKPiA+IHJldXNlcyB0aGUgT0lEX2lkX2VjUHVibGljS2V5LCBidXQgZGlyZWN0
bHkgdXNlcyBPSURfc20yLiBUaGlzIHBhdGNoCj4gPiBzdXBwb3J0cyB0aGlzIHR5cGUgb2YgeDUw
OSBjZXJ0aWZpY2F0ZSBwYXJzaW5nLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaWFuamlhIFpo
YW5nIDx0aWFuamlhLnpoYW5nQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGNyeXB0
by9hc3ltbWV0cmljX2tleXMveDUwOV9jZXJ0X3BhcnNlci5jIHwgMyArKysKPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2Fz
eW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlz
L3g1MDlfY2VydF9wYXJzZXIuYwo+ID4gaW5kZXggNmQwMDMwOTZiNWJjLi42YTk0NWE2Y2U3ODcg
MTAwNjQ0Cj4gPiAtLS0gYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIu
Ywo+ID4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMKPiA+
IEBAIC00OTYsNiArNDk2LDkgQEAgaW50IHg1MDlfZXh0cmFjdF9rZXlfZGF0YSh2b2lkICpjb250
ZXh0LCBzaXplX3QgaGRybGVuLAo+ID4gICAgY2FzZSBPSURfZ29zdDIwMTJQS2V5NTEyOgo+ID4g
ICAgIGN0eC0+Y2VydC0+cHViLT5wa2V5X2FsZ28gPSAiZWNyZHNhIjsKPiA+ICAgICBicmVhazsK
PiA+ICsgY2FzZSBPSURfc20yOgo+ID4gKyAgY3R4LT5jZXJ0LT5wdWItPnBrZXlfYWxnbyA9ICJz
bTIiOwo+ID4gKyAgYnJlYWs7Cj4gPiAgICBjYXNlIE9JRF9pZF9lY1B1YmxpY0tleToKPiA+ICAg
ICBpZiAocGFyc2VfT0lEKGN0eC0+cGFyYW1zLCBjdHgtPnBhcmFtc19zaXplLCAmb2lkKSAhPSAw
KQo+ID4gICAgICByZXR1cm4gLUVCQURNU0c7Cj4gPiAKPgo+IEFja2VkLWJ5OiBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgo+Cj4gL0phcmtrbwoKTGlrZXdpc2UsIE5vIHJlc3Bv
bnNlIGZyb20gRGF2aWQsIGNhbiB5b3UgcGljayB0aGlzPyB0aGFua3MuCgpCZXN0IHJlZ2FyZHMs
ClRpYW5qaWE=
