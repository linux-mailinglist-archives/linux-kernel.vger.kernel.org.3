Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAE59635E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiHPTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiHPTzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:55:16 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C82379604
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:55:14 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id CE25130CA4A;
        Tue, 16 Aug 2022 21:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660679712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E399oj/FMl021QbNUJyi4jZOEXebW+M4RWUvtnt08fA=;
        b=AtLcy0X/Bl5vOo1QH8enQlD64WzFLH2ZqdoEnHt36Il1r/8eARwjioNZ5y7GvxqQDcROcK
        jTLf20K6DDac2G1bBJ+8BHTcVgCIb54shlveDbp700Yaw+/tdqgkvzjuySi2zL/kHLXior
        y0b0QQXn9fW9EtcMxdCaGL7Fl0TFcDAU5CW+kCa8U54PoApfVH76YiMlsI7koKhvSA1w33
        4MsZMBAOqDFUc5m46MN3tHXDjqGTFAzN5LBlseqUh4iPRv0cwYlUQCIOKCioc/HmwMT/0N
        sa3ltcVRbADNT50YiQUlnaz5jF7y4pXBud+uQhJEOB1cWSUhxA73fB88zFMuTA==
Message-ID: <d837b3ecdc8eaddee62737df9abb086c490692d8.camel@svanheule.net>
Subject: Re: [PATCH v3 1/2] spi: realtek-rtl: Add compile testing support
From:   Sander Vanheule <sander@svanheule.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, mail@birger-koblitz.de
Date:   Tue, 16 Aug 2022 21:55:08 +0200
In-Reply-To: <20220731202152.1358252-2-martin.blumenstingl@googlemail.com>
References: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
         <20220731202152.1358252-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTA3LTMxIGF0IDIyOjIxICswMjAwLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdy
b3RlOgo+IEFkZCBzdXBwb3J0IGZvciBjb21waWxlIHRlc3RpbmcgdGhlIHNwaS1yZWFsdGVrLXJ0
bCBkcml2ZXIgdG8gaW5jcmVhc2UKPiBidWlsZCB0ZXN0aW5nIGNvdmVyYWdlLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xl
bWFpbC5jb20+CgpTb3JyeSB0aGlzIHRvb2sgc29tZSB0aW1lLCBidXQKClJldmlld2VkLWJ5OiBT
YW5kZXIgVmFuaGV1bGUgPHNhbmRlckBzdmFuaGV1bGUubmV0PgoKVGhhbmtzIQpTYW5kZXIKCj4g
LS0tCj4gwqBkcml2ZXJzL3NwaS9LY29uZmlnwqAgfCAxMSArKysrKysrKysrKwo+IMKgZHJpdmVy
cy9zcGkvTWFrZWZpbGUgfMKgIDIgKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9LY29uZmln
IGIvZHJpdmVycy9zcGkvS2NvbmZpZwo+IGluZGV4IDhlNTUwMjY5ZDQ4OC4uNGI4NGYyN2ZhZTJi
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc3BpL0tjb25maWcKPiArKysgYi9kcml2ZXJzL3NwaS9L
Y29uZmlnCj4gQEAgLTk2OSw2ICs5NjksMTcgQEAgY29uZmlnIFNQSV9NWFMKPiDCoMKgwqDCoMKg
wqDCoMKgaGVscAo+IMKgwqDCoMKgwqDCoMKgwqDCoCBTUEkgZHJpdmVyIGZvciBGcmVlc2NhbGUg
TVhTIGRldmljZXMuCj4gwqAKPiArY29uZmlnIFNQSV9SRUFMVEVLX1JUTAo+ICvCoMKgwqDCoMKg
wqDCoHRyaXN0YXRlICJSZWFsdGVrIFJUTCBTUEkgY29udHJvbGxlciIKPiArwqDCoMKgwqDCoMKg
wqBkZXBlbmRzIG9uIE1BQ0hfUkVBTFRFS19SVEwgfHwgQ09NUElMRV9URVNUCj4gK8KgwqDCoMKg
wqDCoMKgZGVmYXVsdCBNQUNIX1JFQUxURUtfUlRMCj4gK8KgwqDCoMKgwqDCoMKgaGVscAo+ICvC
oMKgwqDCoMKgwqDCoMKgIFNQSSBkcml2ZXIgZm9yIHRoZSBoYXJkd2FyZSBmb3VuZCBvbiBSZWFs
dGVrIFJMVEw4MzgwLCBSVEw4MzgyLAo+ICvCoMKgwqDCoMKgwqDCoMKgIFJUTDgzOTEsIFJUTDgz
OTIgYW5kIFJUTDgzOTMgU29Dcy4KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqAgVGhpcyBkcml2ZXIg
Y2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlCj4gK8KgwqDC
oMKgwqDCoMKgwqAgd2lsbCBiZSBjYWxsZWQgc3BpLXJlYWx0ZWstcnRsLgo+ICsKPiDCoGNvbmZp
ZyBTUElfVEVHUkEyMTBfUVVBRAo+IMKgwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiTlZJRElBIFRl
Z3JhIFFTUEkgQ29udHJvbGxlciIKPiDCoMKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBBUkNIX1RF
R1JBIHx8IENPTVBJTEVfVEVTVAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9NYWtlZmlsZSBi
L2RyaXZlcnMvc3BpL01ha2VmaWxlCj4gaW5kZXggMThiZjNkOGM2ZGY3Li45ZmU0YTJhYTBmZDcg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zcGkvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL3NwaS9N
YWtlZmlsZQo+IEBAIC0xMDUsNyArMTA1LDcgQEAgb2JqLSQoQ09ORklHX1NQSV9RVVApwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1xdXAubwo+IMKg
b2JqLSQoQ09ORklHX1NQSV9ST0NLQ0hJUCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNw
aS1yb2NrY2hpcC5vCj4gwqBvYmotJChDT05GSUdfU1BJX1JPQ0tDSElQX1NGQynCoMKgwqDCoMKg
wqDCoMKgwqArPSBzcGktcm9ja2NoaXAtc2ZjLm8KPiDCoG9iai0kKENPTkZJR19TUElfUkI0WFgp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gc3BpLXJi
NHh4Lm8KPiAtb2JqLSQoQ09ORklHX01BQ0hfUkVBTFRFS19SVEwpwqDCoMKgwqDCoMKgwqDCoMKg
Kz0gc3BpLXJlYWx0ZWstcnRsLm8KPiArb2JqLSQoQ09ORklHX1NQSV9SRUFMVEVLX1JUTCnCoMKg
wqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1yZWFsdGVrLXJ0bC5vCj4gwqBvYmotJChDT05GSUdfU1BJ
X1JQQ0lGKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9
IHNwaS1ycGMtaWYubwo+IMKgb2JqLSQoQ09ORklHX1NQSV9SU1BJKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqArPSBzcGktcnNwaS5vCj4gwqBvYmotJChDT05GSUdfU1BJX1MzQzI0
WFgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHNwaS1zM2MyNHh4LWh3Lm8KCg==

