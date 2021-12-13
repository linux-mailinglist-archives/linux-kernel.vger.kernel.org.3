Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF447316B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbhLMQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbhLMQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:17:31 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB2D6C061574;
        Mon, 13 Dec 2021 08:17:30 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 7A6665DD12;
        Mon, 13 Dec 2021 17:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1639412201;
        bh=pYRj6hpP2d+oqrEeJWKY13nEblacXwgxeVq/IqKaUBM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GVQz64l844YN8B3u0IC9sP5++352QmWNj8Y+jRgl/NaJl6+kFSOM5rjP21UXUxbzz
         9zIzmbibYRgtzT/TuEJStXVGhw06od/S5xml+mMiqjVEBlaTJkqO9Gx3cZ/gwbxTDT
         D/LDSKzLN2eH4zuVjgRqDM5LsDpx+e4B2vKjVnwDqx2BOJ96bqCyn39s5QGqpUocBZ
         6aaeyglrPAuW0qvg4v7KnSwnrpHVEt6be2a21VsWjxd+IVOXb39e5svQr8VYWFQPP4
         nxeEq5CCW4jL71mivm+sQnKaCnigzr5inKnci0FIQx1vdtUZnd/w414lZGRMEUbqx7
         ZdU+C2ktmxIGw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Dec 2021 17:16:26 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.014; Mon, 13 Dec 2021 17:16:26 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAIEJYAAALaKlA=
Date:   Mon, 13 Dec 2021 16:16:26 +0000
Message-ID: <a1a45da963f343ec94ae8b1025dcb0d9@dh-electronics.com>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
 <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net>
In-Reply-To: <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.51.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VlbnRlciBSb2Vjaw0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAxMywgMjAyMSAyOjU4
IFBNDQo+PiBGcm9tOiBBZGFtIFRob21zb24NCj4+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNiwg
MjAyMSA1OjM4IFBNDQo+Pj4+IFRoYW5rcyBhbnl3YXksIHNvIG5vdyBJIGtub3cgaXQgbXVzdCBi
ZQ0KPj4+PiBwcm9ibGVtIHdpdGggbXkgREE5MDYxIGNoaXAuDQo+Pj4+DQo+Pj4+IEBBZGFtDQo+
Pj4+IFdoZXJlIGNhbiBpdCBjb21lIGZyb20/DQo+Pj4+IENhbiB5b3UgZ2l2ZSB3ZSBhIGhpbnQg
d2hhdCB0byBjaGVjaz8NCj4+Pg0KPj4+IEkndmUgc3Bva2VuIGludGVybmFsbHkgYW5kIGhhdmUg
YmVlbiBpbmZvcm1lZCB0aGF0IHRoaXMgaXMgZG93biB0byB0aGUgZmFjdCB0aGF0DQo+Pj4gREE5
MDYxIHJ1bnMgb25seSBmcm9tIGFuIGludGVybmFsIG9zY2lsbGF0b3Igd2hpY2ggbWF5IGJlIHNs
b3dlci4gVGhlIGluZGljYXRpb24NCj4+PiBpcyB0aGF0IHRoZSB2YWx1ZXMgZm9yIFRXRFNDQUxF
IGRlc2NyaWJlIHRoZSB3aW5kb3cgd2hlcmUgaWYgYSBraWNrL3Bpbmcgb2NjdXJzDQo+Pj4gd2l0
aGluIHRoYXQgcGVyaW9kIHRoZW4gdGhlIHdhdGNoZG9nIGlzIGd1YXJhbnRlZWQgKm5vdCogdG8g
dGltZW91dC4gVGhlIGFjdHVhbA0KPj4+IHRpbWVvdXQgd291bGQgYmUgYXQgc29tZSBwb2ludCBh
ZnRlciB0aGUgc2VsZWN0ZWQgdGltZW91dCBwZXJpb2QsIGFzc3VtaW5nIG5vDQo+Pj4gcGluZy9r
aWNrIG9jY3VycmVkLg0KPj4+DQo+Pj4gVGFibGUgOCBpbiB0aGUgZGF0YXNoZWV0IHNwZWNpZmll
cyBhIG1pbmltdW0gd2F0Y2hkb2cgdGltZW91dCBvZiAyLjVzICh0V0RNQVgpDQo+Pj4gdW5kZXIg
c3BlY2lmaWMgb3BlcmF0aW5nIGNvbmRpdGlvbnMsIHNvIGlmIHRoZSBtaW5pbXVtIDJzIHdpbmRv
dyB3YXMgY2hvc2VuDQo+Pj4gKFRXRFNDQUxFID0gMSkgdGhlbiBlYXJsaWVzdCB0aGUgd2F0Y2hk
b2cgd291bGQgYWN0dWFsbHkgdGltZW91dCwgZm9sbG93aW5nIGENCj4+PiBwaW5nLCBpcyAyLjVz
LCBhc3N1bWluZyB0aGUgY29uZGl0aW9ucyBtYXRjaGVkIHRob3NlIGRlc2NyaWJlZC4NCj4+Pg0K
Pj4+IElmIHlvdSBoYXZlIGZ1cnRoZXIgcXVlc3Rpb25zIGl0IHByb2JhYmx5IG1ha2VzIHNlbnNl
IHRvIGNvbnRhY3QgRGlhbG9nL1JlbmVzYXMNCj4+PiBzdXBwb3J0IGFzIHRoZXkgd2lsbCBiZSBh
YmxlIHRvIHByb3ZpZGUgbW9yZSBkZXRhaWxlZCBpbmZvIG9uIHRoaXMuDQo+Pg0KPj4gU28gYSBE
QTkwNjEgcnVucyBvbmx5IGZyb20gYW4gaW50ZXJuYWwgb3NjaWxsYXRvciwgd2hlcmVhcyBhIERB
OTA2Mg0KPj4gY2FuIHJ1biBvbiBlaXRoZXIgYW4gaW50ZXJuYWwgb3IgYW4gZXh0ZXJuYWwgb3Nj
aWxsYXRvci4gU28gdGhpcw0KPj4gbWVhbnMgdGhhdCB0aGUgREE5MDYxIHRpbWVvdXQgdmFsdWVz
IGFyZSBkaWZmZXIgZnJvbSB0aGUgREE5MDYyDQo+PiB3aXRoIGFuIGV4dGVybmFsIG9zY2lsbGF0
b3Igbm90IG9ubHkgb24gbXkgZGV2aWNlIGJ1dCBvbiBhbGwgREE5MDYxDQo+PiBkZXZpY2VzLg0K
Pj4NCj4+IFRoaXMgYXJlIHRoZSB2YWx1ZXMgKGluIHNlY29uZHMpIGluIGNvbXBhcmlzb246DQo+
PiBEQTkwNjIgKGZyb20gZHJpdmVyKTogMCAgMiAgNCAgIDggIDE2ICAzMiAgNjUgMTMxDQo+PiBE
QTkwNjEgKG1lYXN1cmVkKTogICAgMCAgMyAgNiAgMTIgIDI1ICA1MSAxMDIgMjA0DQo+PiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiBEaWZmZXJl
bmNlOiAgICAgICAgICAgMCArMSArMiAgKzQgICs5ICsxOSArMzcgKzczDQo+Pg0KPj4gSW4gbXkg
b3BpbmlvbiwgdGhlIGRpZmZlcmVuY2VzIGluIHRoZSBoaWdoZXIgdmFsdWVzIGFyZSB2ZXJ5IGh1
Z2UuDQo+PiBJZiBJIGV4cGVjdCB0aGF0IHRoZSB3YXRjaGRvZyB0cmlnZ2VycyBhbmQgSSBoYXZl
IHRvIHdhaXQgbW9yZSB0aGFuDQo+PiBhIG1pbnV0ZSBmb3IgdGhhdCB0byBoYXBwZW4gSSBhc2sg
bXlzZWxmIGlzIHRoZXJlIHNvbWV0aGluZyB3cm9uZy4NCj4+DQo+PiBAQW5kcmVqDQo+PiBJIGd1
ZXNzLCB5b3UgYXJlIHVzaW5nIGFuIGV4dGVybmFsIG9zY2lsbGF0b3IsIGFyZW4ndCB5b3U/DQo+
Pg0KPj4gQEFkYW0NCj4+IElzIHRoZXJlIGEgd2F5IHRvIGNoZWNrIGluIHRoZSBkcml2ZXIgd2hp
Y2ggb3NjaWxsYXRvciBpcyBpbiB1c2U/DQo+Pg0KPj4gQE1haW50YWluZXJzDQo+PiBJcyBpbiB0
aGUgZHJpdmVyIGEgbmVlZCB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIGFuIGV4dGVybmFsIGFuZCBh
bg0KPj4gaW50ZXJuYWwgb3NjaWxsYXRvciB0byBnZXQgdGhlIHRpbWVvdXQgdmFsdWVzIG1vcmUg
YWNjdXJhdGU/DQo+Pg0KPiANCj4gSXQgd291bGQgYmUgdmVyeSBkZXNpcmFibGUgdG8gZ2V0IHRp
bWVvdXQgdmFsdWVzIG1vcmUgYWNjdXJhdGUuDQo+IEkgd291bGQgbm90IHdhbnQgdG8gZGljdGF0
ZSBob3cgdG8gaW1wbGVtZW50IGl0LCB0aG91Z2guDQo+IEl0IGNvdWxkIGJlIGF1dG9tYXRpY2Fs
bHkgZGV0ZWN0ZWQgaWYgdGhhdCBpcyBwb3NzaWJsZSwgdGhlcmUNCj4gY291bGQgYmUgYSBkZXZp
Y2V0cmVlIGNsb2NrIHByb3BlcnR5IHByb3ZpZGluZyB0aGUgY2xvY2sNCj4gZnJlcXVlbmN5LCBv
ciBtYXliZSB0aGVyZSBpcyBzb21lIG90aGVyIHNvbHV0aW9uLg0KPiANCj4gR3VlbnRlcg0KDQpJ
IGFtIG9wZW4gZm9yIGEgZ29vZCBzb2x1dGlvbi4NCk1lYW53aGlsZSBJIG1lYXN1cmVkIHRoZSB0
aW1lb3V0IHZhbHVlcyBvZiBteSA4IGF2YWlsYWJsZSBEQTkwNjENCndhdGNoZG9ncy4gSSBkZXJp
dmVkIHRoZSBmb2xsb3dpbmcgZm9ybXVsYSBmcm9tIHRoZSBnaXZlbiBmb3JtdWxhDQphdCB0aGUg
ZGF0YSBzaGVldCBhbmQgdGhlIGNsb2NrIGRpdmlkZXIgb2YgMl4xNjoNCg0KZiA9IDJeKDE1K1RX
RFNDQUxFKSAvIHQNCg0KRm9ybXVsYSBjaGVjayB3aXRoIHRoZSBleHRlcm5hbCBvc2NpbGxhdG9y
ICgzMmtIeikgVFdEU0NBTEU9NyBAIDEzMXM6DQpmID0gMl4oMTUrNykgLyAxMzEgPSAzMjAxN0h6
ICg9PiBzaG91bGQgYmUgT0spDQoNClRoZSB0aW1lb3V0cyBvZiBteSA4IHdhdGNoZG9ncyAoOTA2
MS1BQSkgd2l0aCBUV0RTQ0FMRT03Og0KdDcgPSAyMTFzID0+IDE5ODc4SHoNCnQ3ID0gMTk3cyA9
PiAyMTI5MUh6DQp0NyA9IDIwM3MgPT4gMjA2NjJIeg0KdDcgPSAyMDRzID0+IDIwNTYwSHoNCnQ3
ID0gMjA2cyA9PiAyMDM2MUh6DQp0NyA9IDE5OHMgPT4gMjE2NjJIeg0KdDcgPSAyMDBzID0+IDIw
OTcySHoNCg0KQWNjb3JkaW5nIHRvIHRoZSBkYXRhIHNoZWV0IHRoZSBpbnRlcm5hbCBvc2NpbGxh
dG9yIHNob3VsZCBydW4gYXQgMjVrSHouDQpUaGUgYXZlcmFnZSBmcmVxdWVuY3kgb2YgbXkgOCBk
ZXZpY2VzIGlzIDIwLjZrSHouIE1heWJlIHRoZSBkYXRhIHNoZWV0DQpDbG9jayB2YWx1ZSBpcyBh
IG1heCB2YWx1ZS4gVGhlIHRpbWVvdXQgZGlmZmVyZW5jZSBvbiBteSA4IGRldmljZXMgYXJlDQox
NHMuIFNvIHRoZSB2YWx1ZXMgdmFyeSBmcm9tIGRldmljZSB0byBkZXZpY2UsIGFuZCBtYXliZSB0
aGVyZSBpcyBhbHNvIGENCnRlbXBlcmF0dXJlIGNvbXBvbmVudC4NCg0KQEFkYW0NCklzIHRoZXJl
IGEgd2F5IHRvIGNoZWNrIHdoaWNoIG9zY2lsbGF0b3IgaXMgaW4gdXNlPw0KSXMgdGhlcmUgYSB3
YXkgdG8gZmluZCB0aGUgY3VycmVudCBvc2NpbGxhdG9yIGZyZXF1ZW5jeT8NCkFyZSB0aGVyZSBh
bnkgb3RoZXIgaWRlYXMvc29sdXRpb25zIHRvIGdldCB0aGUgdGltZW91dCB2YWx1ZXMgbW9yZSBh
Y2N1cmF0ZT8NCg0KVGhhbmtzIGFuZCByZWdhcmRzDQpDaHJpc3RvcGgNCg==
