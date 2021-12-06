Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2A4690F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhLFHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhLFHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:52:17 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F041C0613F8;
        Sun,  5 Dec 2021 23:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1638776880;
        bh=9LjNAMfbHqPPYqfOd0H/bcQt7NiEEMGw6nLCEydrLY8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LBqpNm924/sExE8twPWKn1jD74Eg9zFlUHLKoKaMV1vIUKBy1rV5+s1kwoDWLWQQA
         IO6MGdGuApYNwsHMZDaA5FX6DLq6TDxBZaWHEwp2/3ksGXCGnZj5i5GHsT+tbfmwnj
         P8qdpnDr51SQypF7wATZGDAbOn+9xJsxrj1TI5vrMxpoCXLCTGaL+DrzptMB+6K3hz
         vCMj7s5SZmElU4KCRBZDRMN7JrGI2AtYRyzHaleZDCFHXREIYU450OhCCMFT9ZU6zJ
         Tv4r/OndW4cwR5pKApCQy48NYfSRKXAB9lPbzWt/fykludKxTGS3+f9M199Dmedfbz
         aDdK/a2UtEHiw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
Thread-Index: AQHX6GQONgXT05Iq6ke/N4Kseos6o6wg6rAAgAATvjCABAXqAIAAE0gQ
Date:   Mon, 6 Dec 2021 07:47:51 +0000
Message-ID: <46136729bb564aa6b9f332fa584b2575@dh-electronics.com>
References: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
 <dc6a432c-79a3-881c-eac4-32620040d11b@roeck-us.net>
 <4bfb6ab512cd45ee81c55361525987b7@dh-electronics.com>
 <a0b6a801-f911-3371-1067-479b66240bdc@norik.com>
In-Reply-To: <a0b6a801-f911-3371-1067-479b66240bdc@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmVqIFBpY2VqDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDYsIDIwMjEgODoyOSBB
TQ0KPj4+PiBJIG1lYXN1cmVkIHRoZSB0aW1lb3V0IHZhbHVlcyBvZiBteSBEQTkwNjEgY2hpcC4g
QWNjb3JkaW5nIHRvIHRoZQ0KPj4+PiBpbmZvcm1hdGlvbiBpbiB0aGUgZGF0YSBzaGVldCB0aGUg
Zm9ybXVsYSBzaG91bGQgYmU6DQo+Pj4+DQo+Pj4+IHRpbWVvdXQgPSAyLjA0OCAqIDJeKHJlZ3Zh
bCAtIDEpDQo+Pj4+DQo+Pj4+IEJ1dCBteSBtZWFzdXJlZCB2YWx1ZXMgZGlmZmVyIGZyb20gdGhh
dC4NCj4+Pj4gQWNjb3JpbmcgdG8gbXkgbWVhc3VyZWQgdmFsdWVzIHRoZSBmb3JtdWxhIG11c3Qg
YmU6DQo+Pj4+DQo+Pj4+IHRpbWVvdXQgPSAzLjIgKiAyXihyZWd2YWwgLSAxKQ0KPj4+Pg0KPj4+
PiBJcyB0aGVyZSBzb21ldGhpbmcgd3Jvbmcgd2l0aCBteSBjaGlwLCBvciBoYXMgYW55b25lIGVs
c2Ugbm90aWNlZCB0aGlzIGFzIHdlbGw/DQo+Pj4NCj4+PiBUaGUgZHJpdmVyIGFzc3VtZXMgYSBz
dGF0aWMgYW5kIHdlbGwgZGVmaW5lZCBjbG9jayByYXRlLiBNYXliZSB0aGF0IHJhdGUNCj4+PiBp
cyBkaWZmZXJlbnQgaW4geW91ciBzeXN0ZW0gKGlmIHRoYXQgaXMgcG9zc2libGUpID8NCj4+Pg0K
Pj4+IEd1ZW50ZXINCj4+DQo+PiBAQW5kcmVqDQo+PiBEbyB0aGUgdmFsdWVzIGluIHRoZSBkcml2
ZXIgbWF0Y2ggd2hhdCB5b3VyIGNoaXAgZG9lcz8NCj4+DQo+IA0KPiBKdXN0IGRpZCBhIHF1aWNr
IHRlc3QuIFRoZSB2YWx1ZXMgaW4gdGhlIGRyaXZlciBtYXRjaCB3aGF0IHRoZSBjaGlwDQo+IGRv
ZXMuIEkgY2hlY2tlZCBtdWx0aXBsZSB0aW1lb3V0cyAxNiwgMzIsIDY1IGFuZCAxMzEgc2Vjb25k
cy4gVGhlDQo+IHRpbWVvdXQgdHJpZ2dlcnMgcXVpdGUgYWNjdXJhdGVseS4NCj4gDQo+PiBJIGhh
dmUgbm90IGNoYW5nZWQgYW55dGhpbmcuIEFmdGVyIHBvd2VyIG9uLCB0aGUgY2hpcCBiZWhhdmVz
IGxpa2UgdGhpcy4NCj4+IFNvIEkgZ3Vlc3MgaXQgZWl0aGVyIGNvbWUgZnJvbSBhbiBPVFAgdmFs
dWUgb3IgdGhlIHdpcmluZyBvdXRzaWRlIHRoZSBjaGlwLg0KPj4gRG9lcyBhbnlvbmUga25vdyB3
aGF0IG5lZWRzIHRvIGJlIGNoZWNrZWQ/DQo+IA0KPiBDYW4ndCBoZWxwIHlvdSBoZXJlLCBzb3Jy
eS4NCj4gDQoNClRoYW5rcyBhbnl3YXksIHNvIG5vdyBJIGtub3cgaXQgbXVzdCBiZQ0KcHJvYmxl
bSB3aXRoIG15IERBOTA2MSBjaGlwLg0KDQpAQWRhbQ0KV2hlcmUgY2FuIGl0IGNvbWUgZnJvbT8N
CkNhbiB5b3UgZ2l2ZSB3ZSBhIGhpbnQgd2hhdCB0byBjaGVjaz8NCg0KDQpUaGFua3MgYW5kIGJl
c3QgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
