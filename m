Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220594737D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbhLMWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbhLMWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:45:56 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5C0C061748;
        Mon, 13 Dec 2021 14:45:55 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 122725DE01;
        Mon, 13 Dec 2021 23:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1639435511;
        bh=3GIEGVZf8PcJSm90lGLvZpIfiXIcdns1+xNUaJEcEvA=;
        h=From:To:CC:Subject:Date:References:From;
        b=QqRtoqWc7bvSDXo8OXJKJFS2sHQsRiSH8G2cG9aV8rsgb+DakuVBxpq3v4wiSKzTl
         W/7g7sJg9tzGnfbiCS/IcUDyUILGMQWGNCaytDu5uKQ5lAV07bRQS1xJa/H7y81amO
         cMF40M7OcErwwjx/kTi69otwyZ+uNZGd7gaxjf4OYflpwm+7ccfYpflgedrSfzY46g
         k0LTTVcWEOE2QztHBpdaTe/5y2Uhyl4/OA9Q9vMnJ37QYtHsZbOUGwhwMSJ6ySSZ5Z
         OH3p+ahuPtBaIohqQ2ErWQQa53v1D/H6RRemgeyM0Jj1DP4K9eLtuqWNvG9vp3TQbR
         xw3MBsPwo1eeg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Dec 2021 23:44:59 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.014; Mon, 13 Dec 2021 23:44:59 +0100
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
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAIEJYAAALaKlAAD68ZMA==
Date:   Mon, 13 Dec 2021 22:44:59 +0000
Message-ID: <a065a23625404ca9853354f9d367a09c@dh-electronics.com>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
 <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net> 
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

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDEzLCAy
MDIxIDU6MTYgUE0NCj4+Pj4+IFRoYW5rcyBhbnl3YXksIHNvIG5vdyBJIGtub3cgaXQgbXVzdCBi
ZQ0KPj4+Pj4gcHJvYmxlbSB3aXRoIG15IERBOTA2MSBjaGlwLg0KPj4+Pj4NCj4+Pj4+IEBBZGFt
DQo+Pj4+PiBXaGVyZSBjYW4gaXQgY29tZSBmcm9tPw0KPj4+Pj4gQ2FuIHlvdSBnaXZlIHdlIGEg
aGludCB3aGF0IHRvIGNoZWNrPw0KPj4+Pg0KPj4+PiBJJ3ZlIHNwb2tlbiBpbnRlcm5hbGx5IGFu
ZCBoYXZlIGJlZW4gaW5mb3JtZWQgdGhhdCB0aGlzIGlzIGRvd24gdG8gdGhlIGZhY3QgdGhhdA0K
Pj4+PiBEQTkwNjEgcnVucyBvbmx5IGZyb20gYW4gaW50ZXJuYWwgb3NjaWxsYXRvciB3aGljaCBt
YXkgYmUgc2xvd2VyLiBUaGUgaW5kaWNhdGlvbg0KPj4+PiBpcyB0aGF0IHRoZSB2YWx1ZXMgZm9y
IFRXRFNDQUxFIGRlc2NyaWJlIHRoZSB3aW5kb3cgd2hlcmUgaWYgYSBraWNrL3Bpbmcgb2NjdXJz
DQo+Pj4+IHdpdGhpbiB0aGF0IHBlcmlvZCB0aGVuIHRoZSB3YXRjaGRvZyBpcyBndWFyYW50ZWVk
ICpub3QqIHRvIHRpbWVvdXQuIFRoZSBhY3R1YWwNCj4+Pj4gdGltZW91dCB3b3VsZCBiZSBhdCBz
b21lIHBvaW50IGFmdGVyIHRoZSBzZWxlY3RlZCB0aW1lb3V0IHBlcmlvZCwgYXNzdW1pbmcgbm8N
Cj4+Pj4gcGluZy9raWNrIG9jY3VycmVkLg0KPj4+Pg0KPj4+PiBUYWJsZSA4IGluIHRoZSBkYXRh
c2hlZXQgc3BlY2lmaWVzIGEgbWluaW11bSB3YXRjaGRvZyB0aW1lb3V0IG9mIDIuNXMgKHRXRE1B
WCkNCj4+Pj4gdW5kZXIgc3BlY2lmaWMgb3BlcmF0aW5nIGNvbmRpdGlvbnMsIHNvIGlmIHRoZSBt
aW5pbXVtIDJzIHdpbmRvdyB3YXMgY2hvc2VuDQo+Pj4+IChUV0RTQ0FMRSA9IDEpIHRoZW4gZWFy
bGllc3QgdGhlIHdhdGNoZG9nIHdvdWxkIGFjdHVhbGx5IHRpbWVvdXQsIGZvbGxvd2luZyBhDQo+
Pj4+IHBpbmcsIGlzIDIuNXMsIGFzc3VtaW5nIHRoZSBjb25kaXRpb25zIG1hdGNoZWQgdGhvc2Ug
ZGVzY3JpYmVkLg0KPj4+Pg0KPj4+PiBJZiB5b3UgaGF2ZSBmdXJ0aGVyIHF1ZXN0aW9ucyBpdCBw
cm9iYWJseSBtYWtlcyBzZW5zZSB0byBjb250YWN0IERpYWxvZy9SZW5lc2FzDQo+Pj4+IHN1cHBv
cnQgYXMgdGhleSB3aWxsIGJlIGFibGUgdG8gcHJvdmlkZSBtb3JlIGRldGFpbGVkIGluZm8gb24g
dGhpcy4NCj4+Pg0KPj4+IFNvIGEgREE5MDYxIHJ1bnMgb25seSBmcm9tIGFuIGludGVybmFsIG9z
Y2lsbGF0b3IsIHdoZXJlYXMgYSBEQTkwNjINCj4+PiBjYW4gcnVuIG9uIGVpdGhlciBhbiBpbnRl
cm5hbCBvciBhbiBleHRlcm5hbCBvc2NpbGxhdG9yLiBTbyB0aGlzDQo+Pj4gbWVhbnMgdGhhdCB0
aGUgREE5MDYxIHRpbWVvdXQgdmFsdWVzIGFyZSBkaWZmZXIgZnJvbSB0aGUgREE5MDYyDQo+Pj4g
d2l0aCBhbiBleHRlcm5hbCBvc2NpbGxhdG9yIG5vdCBvbmx5IG9uIG15IGRldmljZSBidXQgb24g
YWxsIERBOTA2MQ0KPj4+IGRldmljZXMuDQo+Pj4NCj4+PiBUaGlzIGFyZSB0aGUgdmFsdWVzIChp
biBzZWNvbmRzKSBpbiBjb21wYXJpc29uOg0KPj4+IERBOTA2MiAoZnJvbSBkcml2ZXIpOiAwICAy
ICA0ICAgOCAgMTYgIDMyICA2NSAxMzENCj4+PiBEQTkwNjEgKG1lYXN1cmVkKTogICAgMCAgMyAg
NiAgMTIgIDI1ICA1MSAxMDIgMjA0DQo+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPj4+IERpZmZlcmVuY2U6ICAgICAgICAgICAwICsxICsyICAr
NCAgKzkgKzE5ICszNyArNzMNCj4+Pg0KPj4+IEluIG15IG9waW5pb24sIHRoZSBkaWZmZXJlbmNl
cyBpbiB0aGUgaGlnaGVyIHZhbHVlcyBhcmUgdmVyeSBodWdlLg0KPj4+IElmIEkgZXhwZWN0IHRo
YXQgdGhlIHdhdGNoZG9nIHRyaWdnZXJzIGFuZCBJIGhhdmUgdG8gd2FpdCBtb3JlIHRoYW4NCj4+
PiBhIG1pbnV0ZSBmb3IgdGhhdCB0byBoYXBwZW4gSSBhc2sgbXlzZWxmIGlzIHRoZXJlIHNvbWV0
aGluZyB3cm9uZy4NCj4+Pg0KPj4+IEBBbmRyZWoNCj4+PiBJIGd1ZXNzLCB5b3UgYXJlIHVzaW5n
IGFuIGV4dGVybmFsIG9zY2lsbGF0b3IsIGFyZW4ndCB5b3U/DQo+Pj4NCj4+PiBAQWRhbQ0KPj4+
IElzIHRoZXJlIGEgd2F5IHRvIGNoZWNrIGluIHRoZSBkcml2ZXIgd2hpY2ggb3NjaWxsYXRvciBp
cyBpbiB1c2U/DQo+Pj4NCj4+PiBATWFpbnRhaW5lcnMNCj4+PiBJcyBpbiB0aGUgZHJpdmVyIGEg
bmVlZCB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIGFuIGV4dGVybmFsIGFuZCBhbg0KPj4+IGludGVy
bmFsIG9zY2lsbGF0b3IgdG8gZ2V0IHRoZSB0aW1lb3V0IHZhbHVlcyBtb3JlIGFjY3VyYXRlPw0K
Pj4+DQo+Pg0KPj4gSXQgd291bGQgYmUgdmVyeSBkZXNpcmFibGUgdG8gZ2V0IHRpbWVvdXQgdmFs
dWVzIG1vcmUgYWNjdXJhdGUuDQo+PiBJIHdvdWxkIG5vdCB3YW50IHRvIGRpY3RhdGUgaG93IHRv
IGltcGxlbWVudCBpdCwgdGhvdWdoLg0KPj4gSXQgY291bGQgYmUgYXV0b21hdGljYWxseSBkZXRl
Y3RlZCBpZiB0aGF0IGlzIHBvc3NpYmxlLCB0aGVyZQ0KPj4gY291bGQgYmUgYSBkZXZpY2V0cmVl
IGNsb2NrIHByb3BlcnR5IHByb3ZpZGluZyB0aGUgY2xvY2sNCj4+IGZyZXF1ZW5jeSwgb3IgbWF5
YmUgdGhlcmUgaXMgc29tZSBvdGhlciBzb2x1dGlvbi4NCj4+DQo+PiBHdWVudGVyDQo+IA0KPiBJ
IGFtIG9wZW4gZm9yIGEgZ29vZCBzb2x1dGlvbi4NCj4gTWVhbndoaWxlIEkgbWVhc3VyZWQgdGhl
IHRpbWVvdXQgdmFsdWVzIG9mIG15IDggYXZhaWxhYmxlIERBOTA2MQ0KPiB3YXRjaGRvZ3MuIEkg
ZGVyaXZlZCB0aGUgZm9sbG93aW5nIGZvcm11bGEgZnJvbSB0aGUgZ2l2ZW4gZm9ybXVsYQ0KPiBh
dCB0aGUgZGF0YSBzaGVldCBhbmQgdGhlIGNsb2NrIGRpdmlkZXIgb2YgMl4xNjoNCj4gDQo+IGYg
PSAyXigxNStUV0RTQ0FMRSkgLyB0DQo+IA0KPiBGb3JtdWxhIGNoZWNrIHdpdGggdGhlIGV4dGVy
bmFsIG9zY2lsbGF0b3IgKDMya0h6KSBUV0RTQ0FMRT03IEAgMTMxczoNCj4gZiA9IDJeKDE1Kzcp
IC8gMTMxID0gMzIwMTdIeiAoPT4gc2hvdWxkIGJlIE9LKQ0KPiANCj4gVGhlIHRpbWVvdXRzIG9m
IG15IDggd2F0Y2hkb2dzICg5MDYxLUFBKSB3aXRoIFRXRFNDQUxFPTc6DQo+IHQ3ID0gMjExcyA9
PiAxOTg3OEh6DQo+IHQ3ID0gMTk3cyA9PiAyMTI5MUh6DQo+IHQ3ID0gMjAzcyA9PiAyMDY2Mkh6
DQo+IHQ3ID0gMjA0cyA9PiAyMDU2MEh6DQo+IHQ3ID0gMjA2cyA9PiAyMDM2MUh6DQo+IHQ3ID0g
MTk4cyA9PiAyMTY2Mkh6DQo+IHQ3ID0gMjAwcyA9PiAyMDk3Mkh6DQo+IA0KPiBBY2NvcmRpbmcg
dG8gdGhlIGRhdGEgc2hlZXQgdGhlIGludGVybmFsIG9zY2lsbGF0b3Igc2hvdWxkIHJ1biBhdCAy
NWtIei4NCj4gVGhlIGF2ZXJhZ2UgZnJlcXVlbmN5IG9mIG15IDggZGV2aWNlcyBpcyAyMC42a0h6
LiBNYXliZSB0aGUgZGF0YSBzaGVldA0KPiBDbG9jayB2YWx1ZSBpcyBhIG1heCB2YWx1ZS4gVGhl
IHRpbWVvdXQgZGlmZmVyZW5jZSBvbiBteSA4IGRldmljZXMgYXJlDQo+IDE0cy4gU28gdGhlIHZh
bHVlcyB2YXJ5IGZyb20gZGV2aWNlIHRvIGRldmljZSwgYW5kIG1heWJlIHRoZXJlIGlzIGFsc28g
YQ0KPiB0ZW1wZXJhdHVyZSBjb21wb25lbnQuDQo+IA0KPiBAQWRhbQ0KPiBJcyB0aGVyZSBhIHdh
eSB0byBjaGVjayB3aGljaCBvc2NpbGxhdG9yIGlzIGluIHVzZT8NCj4gSXMgdGhlcmUgYSB3YXkg
dG8gZmluZCB0aGUgY3VycmVudCBvc2NpbGxhdG9yIGZyZXF1ZW5jeT8NCj4gQXJlIHRoZXJlIGFu
eSBvdGhlciBpZGVhcy9zb2x1dGlvbnMgdG8gZ2V0IHRoZSB0aW1lb3V0IHZhbHVlcyBtb3JlIGFj
Y3VyYXRlPw0KDQpBcyBJIHNlbnQgbXkgRS1NYWlsIEkgZGlkbid0IHNlZSB5b3VyIGFuc3dlciwg
c28gaGVyZSBpdCBpczoNCg0KPiBBIHF1aWNrIHNjYW4gb2YgdGhlIERBOTA2MiBkYXRhc2hlZXQg
c2hvd3MgdGhhdCByZWcvZmllbGQgRU5fMzJLL0NSWVNUQUwgd2lsbA0KPiBpbmRpY2F0ZSB0aGUg
cHJlc2VuY2Ugb2YgYSAzMktIeiBjcnlzdGFsIG9zY2lsbGF0b3IuIE9idmlvdXNseSBvbiBEQTkw
NjEgdGhhdA0KPiBvcHRpb24gaXNuJ3QgYXZhaWxhYmxlLg0KPg0KPiBJIHRoaW5rIHRoZSBwcm9i
bGVtIHNlZW1zIHRvIGxpZSBhcm91bmQgZGV0ZXJtaW5pbmcgdGhlIGludGVybmFsIG9zY2lsbGF0
b3Incw0KPiBmcmVxdWVuY3kuIERhdGFzaGVldCByZWZlcmVuY2VzIDI1TWh6IGluIFRhYmxlIDkg
KFdhdGNoZG9nIEVsZWN0cmljYWwNCj4gQ2hhcmFjdGVyaXN0aWNzKSwgYnV0IHRoYXQgZG9lc24n
dCBzZWVtIHRvIHRhbGx5IHdpdGggeW91ciB0aW1pbmdzIGFuZCBJIGRvbid0DQo+IHNlZSBhbiBv
YnZpb3VzIHdheSBpbiB0aGUgcmVnbWFwIHRvIGNhbGN1bGF0ZSB0aGlzIGF0IHJ1biB0aW1lLiAq
SWYqIHRoZQ0KPiBvc2NpbGxhdG9yIGZyZXF1ZW5jeSB2YXJpZXMgZnJvbSBwYXJ0IHRvIHBhcnQs
IG9yIHVuZGVyIGRpZmZlcmVudCBlbnZpcm9ubWVudGFsDQo+IGNvbmRpdGlvbnMsIHRoZW4gaXQn
cyBnb2luZyB0byBiZSB0b3VnaCB0byB0aWUgdGhpcyBkb3duLCBhbmQgeW91IHdvdWxkbid0IHdh
bnQNCj4gdG8gc3RhdGUgYSB0aW1lb3V0IHZhbHVlIHRoYXQncyBsb25nZXIgdGhhbiByZWFsaXR5
Lg0KDQpAQWRhbQ0KV2hhdCBkbyB5b3UgdGhpbmsgaWYgSSBhZGQgYWxzbyB0aGUgdGltZW91dCB2
YWx1ZXMgZm9yIHRoZSBpbnRlcm5hbCBvc2NpbGxhdG9yPw0KVGhhbiB0aGUgdmFsdWVzIHdvdWxk
IGJlOg0KDQp0ID0gMl4oMTUrVFdEU0NBTEUpIC8gZg0KDQpJbnRlcm5hbCAyNWtIeiBvc2NpbGxh
dG9yOiAwICAyICA1ICAxMCAgMjAgIDQxICA4MyAxNjcNCg0KSW4gY29tcGFyaXNvbiB0byB0aGUN
CmV4dGVybmFsIDMya0h6IG9zY2lsbGF0b3I6IDAgIDIgIDQgICA4ICAxNiAgMzIgIDY1IDEzMQ0K
DQpTbyB0aGUgZGlmZmVyZW5jZSB0byBteSBtZWFzdXJlZCB2YWx1ZXMgd2lsbCBkZWNyZWFzZSBh
bmQgaXQgd2lsbCBpbXByb3ZlIHRoZQ0KY3VycmVudCBkcml2ZXIgdG93YXJkcyBtb3JlIGFjY3Vy
YXRlIHZhbHVlcy4NCg0KQnR3IGlmIEkgY2FsY3VsYXRlIHRoZSB2YWx1ZXMgd2l0aCAzMjc2OEh6
ICh0aGUgdHlwaWNhbCAzMmtIeiBvc2NpbGxhdG9yKSwgSSBnZXQgdGhlDQpmb2xsb3dpbmcgdmFs
dWVzOg0KMzI3NjhIeiBvc2NpbGxhdG9yOiAgICAgICAgMCAgMiAgNCAgIDggIDE2ICAzMiAgNjQg
MTI4DQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
