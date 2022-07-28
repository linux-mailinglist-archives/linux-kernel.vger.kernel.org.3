Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002BC5845F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiG1Skl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiG1Skg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:40:36 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD31209A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:40:36 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 58DC8302750;
        Thu, 28 Jul 2022 20:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659033634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D37G27M71NdyUqIBu80G6hfFB1vGquOW3veRxv/waVQ=;
        b=LeTfDD7TdNz0n2ucmB6EGevqdDVtqoVctKb53JI1zszTybaQ+pEPCjqHC7taH67ynY/zXl
        d2x3ZKChkcQl0BvYpvhdaTdEF95taddNj4JjNuwP7miXkzvHY0SIKl2oYojsGb9tZD2kXq
        J13z1scIWKbGkwYo5dOM5S6ULJV+SP4joQsNPRzWu67jLXs/Z+vZEgD0vTDRXZAkJWexkE
        ItVjysOcMoiLIVh56xxiVMv0rRAGIEX8mYunEhmOT5Wtp5BUL+uvwhkQE1Z+txRJkgPdW3
        DoCWwMV5ISVK/9C4My7ICBBNk9x133EnQq/XPCllipGTqDuxNQHee6PuHzF3hg==
Message-ID: <fe43a69a23308580eac251fdfdde66d848b64381.camel@svanheule.net>
Subject: Re: [PATCH v2 2/2] spi: realtek-rtl: Improve readability when
 clearing the size mask
From:   Sander Vanheule <sander@svanheule.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, mail@birger-koblitz.de
Date:   Thu, 28 Jul 2022 20:40:33 +0200
In-Reply-To: <20220728152118.1429161-3-martin.blumenstingl@googlemail.com>
References: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
         <20220728152118.1429161-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDE3OjIxICswMjAwLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdy
b3RlOgo+IERlZmluZSB0aGUgYml0bWFzayBSVExfU1BJX1NGQ1NSX0xFTl9NQVNLIHNvIGl0IG9u
bHkgc2V0cyB0aGUgYml0cyBvZgo+IHRoaXMgc3BlY2lmaWMgcGFydCBvZiB0aGUgcmVnaXN0ZXIg
aW5zdGVhZCBvZiBzZXR0aW5nIGFsbCBiaXRzIGV4Y2VwdAo+IHRoZSByZWxldmFudCBvbmVzLiBU
aGlzIG1ha2VzIGl0IGNvbnNpc3RlbnQgd2l0aCBzaW5nbGUgYml0IG1hY3JvcyBpbgo+IHRoZSBz
cGktcmVhbHRlay1ydGwgZHJpdmVyIGFzIHdlbGwgYXMgd2l0aCB0aGUgYXBwcm9hY2ggdGhhdCBt
YW55IG90aGVyCj4gZHJpdmVycyB1c2UuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBTYW5kZXIgVmFuaGV1
bGUgPHNhbmRlckBzdmFuaGV1bGUubmV0Pgo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBCbHVtZW5z
dGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+CgpGV0lXClRlc3RlZC1i
eTogU2FuZGVyIFZhbmhldWxlIDxzYW5kZXJAc3ZhbmhldWxlLm5ldD4KCm9uIG15IE5ldGdlYXIg
R1MxMTBUUFAgdjEuCgo+IC0tLQo+IMKgZHJpdmVycy9zcGkvc3BpLXJlYWx0ZWstcnRsLmMgfCA0
ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1yZWFsdGVrLXJ0bC5jIGIvZHJpdmVy
cy9zcGkvc3BpLXJlYWx0ZWstcnRsLmMKPiBpbmRleCA4NjZiMDQ3N2RiZDcuLjAzNzFkNDRjYmZi
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktcmVhbHRlay1ydGwuYwo+ICsrKyBiL2Ry
aXZlcnMvc3BpL3NwaS1yZWFsdGVrLXJ0bC5jCj4gQEAgLTIwLDcgKzIwLDcgQEAgc3RydWN0IHJ0
c3BpIHsKPiDCoCNkZWZpbmUgUlRMX1NQSV9TRkNTUl9DU0IxwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBCSVQoMzApCj4gwqAjZGVmaW5lIFJUTF9TUElfU0ZDU1JfUkRZwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoEJJVCgyNykKPiDCoCNkZWZpbmUgUlRMX1NQSV9TRkNTUl9DU8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJVCgyNCkKPiAtI2RlZmluZSBSVExfU1BJX1NGQ1NSX0xF
Tl9NQVNLwqDCoMKgwqDCoMKgwqDCoMKgfigweDAzIDw8IDI4KQo+ICsjZGVmaW5lIFJUTF9TUElf
U0ZDU1JfTEVOX01BU0vCoMKgwqDCoMKgwqDCoMKgwqAoMHgwMyA8PCAyOCkKPiDCoCNkZWZpbmUg
UlRMX1NQSV9TRkNTUl9MRU4xwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoMHgwMCA8PCAyOCkK
PiDCoCNkZWZpbmUgUlRMX1NQSV9TRkNTUl9MRU40wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAo
MHgwMyA8PCAyOCkKPiDCoAo+IEBAIC00OSw3ICs0OSw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaXpl
KHN0cnVjdCBydHNwaSAqcnRzcGksIGludCBzaXplKQo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgdmFs
dWU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgdmFsdWUgPSByZWFkbChSRUcoUlRMX1NQSV9TRkNT
UikpOwo+IC3CoMKgwqDCoMKgwqDCoHZhbHVlICY9IFJUTF9TUElfU0ZDU1JfTEVOX01BU0s7Cj4g
K8KgwqDCoMKgwqDCoMKgdmFsdWUgJj0gflJUTF9TUElfU0ZDU1JfTEVOX01BU0s7Cj4gwqDCoMKg
wqDCoMKgwqDCoGlmIChzaXplID09IDQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB2YWx1ZSB8PSBSVExfU1BJX1NGQ1NSX0xFTjQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGVsc2UgaWYg
KHNpemUgPT0gMSkKCg==

