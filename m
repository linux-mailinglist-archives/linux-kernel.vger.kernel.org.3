Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA934723A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhLMJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:20:11 -0500
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Dec 2021 01:20:10 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBC32C06173F;
        Mon, 13 Dec 2021 01:20:10 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 7A2985EA99;
        Mon, 13 Dec 2021 10:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1639386697;
        bh=ciWdTfVPU8qkvCxE3UE4jtPkgBe04AAxjcvNeUgFT2E=;
        h=From:To:CC:Subject:Date:From;
        b=GLXqO5oBx8VlihD7RVc4YuJU4N1Xbh8YJmNaG/eix6XBLqo24b4L4nPSJdj34oMd/
         5LNyh273Hz21CbAh/bAokRG934y4BwDaTBGhnrlmWLU4M4ETY5SsQW8d9yDQuicTiK
         tUAMHT734ZD/zwqJdWXU0ss3NK/ZI4009krPsdGDv+Y0Kx8KwJQ9hgQ0ro21BQ7CD4
         OcpfTji4XG5Ie9dzbD6QNaWrZyMVGYFsyzUnwdiRX69jOn7XXI3xxhMJDN9z91ZXdl
         f6UB7NatFIFBN5YoeWrqHPJ4SFZrUgOMfIpZuPeOR3RH+xD8q4w0pKt+bXspUD8s2D
         SUy3cTDJPEJfQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Dec 2021 10:11:25 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.014; Mon, 13 Dec 2021 10:11:25 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmA==
Date:   Mon, 13 Dec 2021 09:11:25 +0000
Message-ID: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
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

UmVzZW5kIHdpdGggW0tsYXJ0ZXh0XSB0byB0dXJuIG9mZiBUTFMgZW5jcnlwdGlvbi4NCg0KRnJv
bTogQWRhbSBUaG9tc29uDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDYsIDIwMjEgNTozOCBQTQ0K
Pj4gVGhhbmtzIGFueXdheSwgc28gbm93IEkga25vdyBpdCBtdXN0IGJlDQo+PiBwcm9ibGVtIHdp
dGggbXkgREE5MDYxIGNoaXAuDQo+Pg0KPj4gQEFkYW0NCj4+IFdoZXJlIGNhbiBpdCBjb21lIGZy
b20/DQo+PiBDYW4geW91IGdpdmUgd2UgYSBoaW50IHdoYXQgdG8gY2hlY2s/DQo+IA0KPiBJJ3Zl
IHNwb2tlbiBpbnRlcm5hbGx5IGFuZCBoYXZlIGJlZW4gaW5mb3JtZWQgdGhhdCB0aGlzIGlzIGRv
d24gdG8gdGhlIGZhY3QgdGhhdA0KPiBEQTkwNjEgcnVucyBvbmx5IGZyb20gYW4gaW50ZXJuYWwg
b3NjaWxsYXRvciB3aGljaCBtYXkgYmUgc2xvd2VyLiBUaGUgaW5kaWNhdGlvbg0KPiBpcyB0aGF0
IHRoZSB2YWx1ZXMgZm9yIFRXRFNDQUxFIGRlc2NyaWJlIHRoZSB3aW5kb3cgd2hlcmUgaWYgYSBr
aWNrL3Bpbmcgb2NjdXJzDQo+IHdpdGhpbiB0aGF0IHBlcmlvZCB0aGVuIHRoZSB3YXRjaGRvZyBp
cyBndWFyYW50ZWVkICpub3QqIHRvIHRpbWVvdXQuIFRoZSBhY3R1YWwNCj4gdGltZW91dCB3b3Vs
ZCBiZSBhdCBzb21lIHBvaW50IGFmdGVyIHRoZSBzZWxlY3RlZCB0aW1lb3V0IHBlcmlvZCwgYXNz
dW1pbmcgbm8NCj4gcGluZy9raWNrIG9jY3VycmVkLg0KPiANCj4gVGFibGUgOCBpbiB0aGUgZGF0
YXNoZWV0IHNwZWNpZmllcyBhIG1pbmltdW0gd2F0Y2hkb2cgdGltZW91dCBvZiAyLjVzICh0V0RN
QVgpDQo+IHVuZGVyIHNwZWNpZmljIG9wZXJhdGluZyBjb25kaXRpb25zLCBzbyBpZiB0aGUgbWlu
aW11bSAycyB3aW5kb3cgd2FzIGNob3Nlbg0KPiAoVFdEU0NBTEUgPSAxKSB0aGVuIGVhcmxpZXN0
IHRoZSB3YXRjaGRvZyB3b3VsZCBhY3R1YWxseSB0aW1lb3V0LCBmb2xsb3dpbmcgYQ0KPiBwaW5n
LCBpcyAyLjVzLCBhc3N1bWluZyB0aGUgY29uZGl0aW9ucyBtYXRjaGVkIHRob3NlIGRlc2NyaWJl
ZC4NCj4gDQo+IElmIHlvdSBoYXZlIGZ1cnRoZXIgcXVlc3Rpb25zIGl0IHByb2JhYmx5IG1ha2Vz
IHNlbnNlIHRvIGNvbnRhY3QgRGlhbG9nL1JlbmVzYXMNCj4gc3VwcG9ydCBhcyB0aGV5IHdpbGwg
YmUgYWJsZSB0byBwcm92aWRlIG1vcmUgZGV0YWlsZWQgaW5mbyBvbiB0aGlzLg0KDQpTbyBhIERB
OTA2MSBydW5zIG9ubHkgZnJvbSBhbiBpbnRlcm5hbCBvc2NpbGxhdG9yLCB3aGVyZWFzIGEgREE5
MDYyDQpjYW4gcnVuIG9uIGVpdGhlciBhbiBpbnRlcm5hbCBvciBhbiBleHRlcm5hbCBvc2NpbGxh
dG9yLiBTbyB0aGlzDQptZWFucyB0aGF0IHRoZSBEQTkwNjEgdGltZW91dCB2YWx1ZXMgYXJlIGRp
ZmZlciBmcm9tIHRoZSBEQTkwNjIgDQp3aXRoIGFuIGV4dGVybmFsIG9zY2lsbGF0b3Igbm90IG9u
bHkgb24gbXkgZGV2aWNlIGJ1dCBvbiBhbGwgREE5MDYxDQpkZXZpY2VzLg0KDQpUaGlzIGFyZSB0
aGUgdmFsdWVzIChpbiBzZWNvbmRzKSBpbiBjb21wYXJpc29uOg0KREE5MDYyIChmcm9tIGRyaXZl
cik6IDAgIDIgIDQgICA4ICAxNiAgMzIgIDY1IDEzMQ0KREE5MDYxIChtZWFzdXJlZCk6ICAgIDAg
IDMgIDYgIDEyICAyNSAgNTEgMTAyIDIwNA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KRGlmZmVyZW5jZTogICAgICAgICAgIDAgKzEgKzIgICs0ICAr
OSArMTkgKzM3ICs3Mw0KDQpJbiBteSBvcGluaW9uLCB0aGUgZGlmZmVyZW5jZXMgaW4gdGhlIGhp
Z2hlciB2YWx1ZXMgYXJlIHZlcnkgaHVnZS4NCklmIEkgZXhwZWN0IHRoYXQgdGhlIHdhdGNoZG9n
IHRyaWdnZXJzIGFuZCBJIGhhdmUgdG8gd2FpdCBtb3JlIHRoYW4NCmEgbWludXRlIGZvciB0aGF0
IHRvIGhhcHBlbiBJIGFzayBteXNlbGYgaXMgdGhlcmUgc29tZXRoaW5nIHdyb25nLg0KDQpAQW5k
cmVqDQpJIGd1ZXNzLCB5b3UgYXJlIHVzaW5nIGFuIGV4dGVybmFsIG9zY2lsbGF0b3IsIGFyZW4n
dCB5b3U/DQoNCkBBZGFtDQpJcyB0aGVyZSBhIHdheSB0byBjaGVjayBpbiB0aGUgZHJpdmVyIHdo
aWNoIG9zY2lsbGF0b3IgaXMgaW4gdXNlPw0KDQpATWFpbnRhaW5lcnMNCklzIGluIHRoZSBkcml2
ZXIgYSBuZWVkIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gYW4gZXh0ZXJuYWwgYW5kIGFuDQppbnRl
cm5hbCBvc2NpbGxhdG9yIHRvIGdldCB0aGUgdGltZW91dCB2YWx1ZXMgbW9yZSBhY2N1cmF0ZT8N
Cg0KDQpCZXN0IHJlZ2FyZHMNCkNocmlzdG9waA0K
