Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC37E484CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiAEDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:30:37 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45002 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiAEDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:30:36 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1286B80002;
        Wed,  5 Jan 2022 16:30:34 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1641353434;
        bh=cOHEwjnuqvmFpc9fiNiu2Zdc+YgEB7tbP9OrwfENuC0=;
        h=From:To:CC:Subject:Date;
        b=2iCQ0QIZEoo6Eoz8CYZJLxg+W1eZfEZbkH5fsUtNQDv0ukmTdk8ztqMUiAkVRWSpc
         K3CpE8GRlVwSigAfUm2rC/DmZinIsEZCpa9wldoI5JiUr4wy9p4s4CSxkqS17mt9Et
         vzj0Xi0FhlUVpaFAgkZnvSSg49/0vJ8C1/tEtUWAwpJ4kiyxb4kQtVuchGaNsTq7F6
         HMAo57LKGPiVeXfwA57l8eO3ZMAMq2TfD9OFqt2scKJM08xa59byI0ZCFlyluya3qR
         T8QZ7XJMEX0u76mlbODnMJ1lcjrv63H/UkCOBkRlQcv9tDtEgnbcQXqwpSvHrzQlSc
         MJigDYFRcD9jw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61d510d00000>; Wed, 05 Jan 2022 16:30:24 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 5 Jan 2022 16:30:24 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.026; Wed, 5 Jan 2022 16:30:24 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Building out of tree dtbs
Thread-Topic: Building out of tree dtbs
Thread-Index: AQHYAeSSw5Qj6fF+60Oge/GF/WUCiA==
Date:   Wed, 5 Jan 2022 03:30:23 +0000
Message-ID: <134fa5e2-691f-2dee-1cd6-09522907bd44@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F11898167B0EE47B6B9082E71715FBA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=HvoI5HbS c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=DghFqjY3_ZEA:10 a=BoJB4dgYAAAA:8 a=fck5lr1RrayVXB5qS0IA:9 a=QEXdDO2ut3YA:10 a=zGR_d48pMUbmtCY1HACo:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpJIGhhZCBhIHF1aWNrIHNlYXJjaCBvZiB0aGUgZGV2aWNldHJlZSBtYWlsaW5n
IGxpc3QgYW5kIGRpZG4ndCBmaW5kIA0KYW55dGhpbmcgcmVsZXZhbnQgc28gaGVyZSBnb2VzLi4u
DQoNCkknbSBsb29raW5nIGF0IGhvdyBiZXN0IHRvIGdvIGFib3V0IG1hbmFnaW5nIG91dCBvZiB0
cmVlIGRldmljZXRyZWVzIGZvciANCm91ciBpbnRlcm5hbCBidWlsZCBzeXN0ZW0uIElmIHRoZSBk
ZXZpY2V0cmVlcyBmb3Igb3VyIGJvYXJkcyB3ZXJlIA0KY29tcGxldGVseSBzdGFuZGFsb25lIHRo
ZXJlIHdvdWxkIGJlIG5vIHByb2JsZW0gd2UgY291bGQganVzdCBpbnZva2UgZHRjIA0KZGlyZWN0
bHkgYW5kIHByb2R1Y2UgdGhlIGR0YnMgd2UncmUgYWZ0ZXIuIEJ1dCB3ZSdkIGxpa2UgdG8gaGF2
ZSB0aGUgQyANCnByZXByb2Nlc3NvciBhbmQgZHRjIHBpY2sgdXAgdGhlIGluLXRyZWUgZHRzaSBm
aWxlcyBmb3IgdGhlIHZhcmlvdXMgDQpTb0NzL0lQIGJsb2NrcyB0aGF0IHdlIHVzZS4NCg0KSSBj
YW4gZG8gKGFuZCBoYXZlIGRvbmUpIHNvbWV0aGluZyB3aGVyZSB3ZSBtYW51YWxseSBpbnZva2Ug
Z2NjIC1FIGFuZCANCmR0YyB3aXRoIHRoZSByZWxldmFudCAtSS8taSBkaXJlY3RpdmVzIChhcyB3
ZWxsIGFzIHRoZSB2YXJpb3VzIG90aGVyIA0KYXJndW1lbnRzIHRoYXQgdGhlIGtlcm5lbCBidWls
ZCBwYXNzZXMpLiBCdXQgdGhpcyBzZWVtcyB2ZXJ5IGZyYWdpbGUgYW5kIA0KSSBleHBlY3Qgd2ls
bCBicmVhayBpbiB0aGUgbmVhciBmdXR1cmUuDQoNCkJ1aWxkcm9vdCBzZWVtcyB0byBzb2x2ZSB0
aGUgcHJvYmxlbSBieSBjb3B5aW5nIHRoZSBvdXQgb2YgdHJlZSBmaWxlcyANCmludG8gdGhlIGtl
cm5lbCBzb3VyY2UgdHJlZVsxXS4gVGhpcyB3b3JrcyBidXQgaXQgZW5kcyB1cCBwdXR0aW5nIA0K
dW50cmFja2VkIGZpbGVzIGludG8gdGhlIHNvdXJjZSB0cmVlLg0KDQpXaGF0IHdvdWxkIGJlIHJl
YWxseSBuZWF0IGlzIGlmIHNvbWV0aGluZyBsaWtlIHRoZSBtZWNoYW5pc20gZm9yIA0KYnVpbGRp
bmcgYW4gb3V0IG9mIHRyZWUgbW9kdWxlIHdlcmUgcG9zc2libGUgKGkuZS4gbWFrZSAtQyANCmBw
YXRoL3RvL2tlcm5lbC9zb3VyY2UgTT0kUFdEKS4gT3RoZXIgdGhhbiBub3QgYmVpbmcgYW55b25l
J3MgaXRjaCB0byANCnNjcmF0Y2ggaXMgdGhlcmUgYW55IHJlYXNvbiB0aGlzIGhhc24ndCBiZWVu
IGRvbmU/DQoNCkFueSBndWlkYW5jZSBvbiB0aGlzIHdvdWxkIGJlIG11Y2ggYXBwcmVjaWF0ZWQu
DQoNClRoYW5rcywNCkNocmlzDQoNCi0tDQpbMV0gLSBodHRwczovL2dpdC5idWlsZHJvb3QubmV0
L2J1aWxkcm9vdC90cmVlL2xpbnV4L2xpbnV4Lm1rI240MzQNCg==
