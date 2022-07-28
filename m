Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEC7584615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiG1S0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiG1S0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:26:49 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1516D55C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:26:46 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 81618302740;
        Thu, 28 Jul 2022 20:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659032804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBLNbZ0iXZQd0mXrqJ8005T/3DAkEB7BeWOFtSOzZ2w=;
        b=s8G8S6ahouXHgFOIfnZZKHdlodgIb5e9A9L5Nv+BV/L3wXRMB6A0W3gi3mn/aA6xNtMgwj
        GP07kv8z1tbHnZzSifnfoRYZC4XlhRWQ2/RbfOLaGPxyBZQjW1xbF3YkqGfiJPZay0cCfl
        8O1B/bvnicEcY+6zgKnGTYjwCVsWcaX4FOyJO3e0M7snDvI/udxRNs06NemXnS43DUUHRS
        ixHtJMatETqYonA6EOHMWlbHaeSsxNNrI3aHaNnT20qpO8YZtjcu3kR2P0bBGRIQLuexMe
        PDeia9lSYqpj4DYOzMNIZbunXX/LLEnJ4px63PnBy/he4uVYBih2Y6nJlwkoeQ==
Message-ID: <f5b80dfafccd629e98df6c516b512b9492cae14d.camel@svanheule.net>
Subject: Re: [PATCH v2 1/2] spi: realtek-rtl: Add compile testing support
From:   Sander Vanheule <sander@svanheule.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, mail@birger-koblitz.de
Date:   Thu, 28 Jul 2022 20:26:41 +0200
In-Reply-To: <20220728152118.1429161-2-martin.blumenstingl@googlemail.com>
References: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
         <20220728152118.1429161-2-martin.blumenstingl@googlemail.com>
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

SGkgTWFydGluLAoKT24gVGh1LCAyMDIyLTA3LTI4IGF0IDE3OjIxICswMjAwLCBNYXJ0aW4gQmx1
bWVuc3RpbmdsIHdyb3RlOgo+IEFkZCBzdXBwb3J0IGZvciBjb21waWxlIHRlc3RpbmcgdGhlIHNw
aS1yZWFsdGVrLXJ0bCBkcml2ZXIgdG8gaW5jcmVhc2UKPiBidWlsZCB0ZXN0aW5nIGNvdmVyYWdl
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5z
dGluZ2xAZ29vZ2xlbWFpbC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL3NwaS9LY29uZmlnwqAgfCA5
ICsrKysrKysrKwo+IMKgZHJpdmVycy9zcGkvTWFrZWZpbGUgfCAyICstCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zcGkvS2NvbmZpZyBiL2RyaXZlcnMvc3BpL0tjb25maWcKPiBpbmRleCA4ZTU1MDI2
OWQ0ODguLmQ4YjU1ZWZiMDVkNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3NwaS9LY29uZmlnCj4g
KysrIGIvZHJpdmVycy9zcGkvS2NvbmZpZwo+IEBAIC05NjksNiArOTY5LDE1IEBAIGNvbmZpZyBT
UElfTVhTCj4gwqDCoMKgwqDCoMKgwqDCoGhlbHAKPiDCoMKgwqDCoMKgwqDCoMKgwqAgU1BJIGRy
aXZlciBmb3IgRnJlZXNjYWxlIE1YUyBkZXZpY2VzLgo+IMKgCj4gK2NvbmZpZyBTUElfUkVBTFRF
S19SVEwKPiArwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiUmVhbHRlayBSVEwgU1BJIGNvbnRyb2xs
ZXIiCj4gK8KgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBIQVNfSU9NRU0KCkkgdGhpbmsgdGhpcyBp
cyBhbHJlYWR5IGFuIGltcGxpZWQgZGVwZW5kZW5jeSwgYnkgdmlydHVlIG9mIHRoaXMgc3ltYm9s
IGJlaW5nCmF2YWlsYWJsZSBvbmx5IHdoZW4gQ09ORklHX1NQST15LgoKPiArwqDCoMKgwqDCoMKg
wqBkZXBlbmRzIG9uIE1BQ0hfUkVBTFRFS19SVEwgfHwgQ09NUElMRV9URVNUCj4gK8KgwqDCoMKg
wqDCoMKgZGVmYXVsdCBNQUNIX1JFQUxURUtfUlRMCj4gK8KgwqDCoMKgwqDCoMKgaGVscAo+ICvC
oMKgwqDCoMKgwqDCoMKgIFNQSSBkcml2ZXIgZm9yIHRoZSBoYXJkd2FyZSBmb3VuZCBvbiBSZWFs
dGVrIFJMVEw4MzgwLCBSVEw4MzgyLAo+ICvCoMKgwqDCoMKgwqDCoMKgIFJUTDgzOTEsIFJUTDgz
OTIgYW5kIFJUTDgzOTMgU29Dcy4KPiArCgpDb3VsZCB5b3UgYWRkIGhvdyB0aGUgbW9kdWxlIHdp
bGwgYmUgbmFtZWQgYmUgdG8gdGhlIGhlbHAgdGV4dD8gU2VlIGZvciBleGFtcGxlCkNPTkZJR19T
UElfRExOMi4KCkJlc3QsClNhbmRlcgoKPiDCoGNvbmZpZyBTUElfVEVHUkEyMTBfUVVBRAo+IMKg
wqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiTlZJRElBIFRlZ3JhIFFTUEkgQ29udHJvbGxlciIKPiDC
oMKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBBUkNIX1RFR1JBIHx8IENPTVBJTEVfVEVTVAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9NYWtlZmlsZSBiL2RyaXZlcnMvc3BpL01ha2VmaWxlCj4g
aW5kZXggMThiZjNkOGM2ZGY3Li45ZmU0YTJhYTBmZDcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9z
cGkvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL3NwaS9NYWtlZmlsZQo+IEBAIC0xMDUsNyArMTA1
LDcgQEAgb2JqLSQoQ09ORklHX1NQSV9RVVApwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1xdXAubwo+IMKgb2JqLSQoQ09ORklHX1NQSV9ST0NLQ0hJ
UCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1yb2NrY2hpcC5vCj4gwqBvYmotJChD
T05GSUdfU1BJX1JPQ0tDSElQX1NGQynCoMKgwqDCoMKgwqDCoMKgwqArPSBzcGktcm9ja2NoaXAt
c2ZjLm8KPiDCoG9iai0kKENPTkZJR19TUElfUkI0WFgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gc3BpLXJiNHh4Lm8KPiAtb2JqLSQoQ09ORklHX01B
Q0hfUkVBTFRFS19SVEwpwqDCoMKgwqDCoMKgwqDCoMKgKz0gc3BpLXJlYWx0ZWstcnRsLm8KPiAr
b2JqLSQoQ09ORklHX1NQSV9SRUFMVEVLX1JUTCnCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1y
ZWFsdGVrLXJ0bC5vCj4gwqBvYmotJChDT05GSUdfU1BJX1JQQ0lGKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1ycGMtaWYubwo+IMKgb2JqLSQo
Q09ORklHX1NQSV9SU1BJKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqArPSBzcGkt
cnNwaS5vCj4gwqBvYmotJChDT05GSUdfU1BJX1MzQzI0WFgpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCs9IHNwaS1zM2MyNHh4LWh3Lm8KCg==

