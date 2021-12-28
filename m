Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410DF480A97
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhL1Oyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:54:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:14286 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhL1Oyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640703277; x=1672239277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U2yVtnsfZFtTATBT+E5nodHx3muVLQZATk0t7D+purY=;
  b=DwmahJ6IhfAHTuSyaqQuXKgNHov7lGXhR4uwf1TM09XdtUDGwvBpq6+s
   Iu/DtUCA0nXjalOlAOjO7v4Nlvw6/JLHNnkCcmd3VonmWqKty1JO1HMah
   MLJ/9uhEeI50FahDG6BAiSrzHYGcYW3dhpuO0ONQKdg+eePQG7DzjCTac
   hpbOI7zqCgmYjvF5300KWh+c94UPQgTb8/LPI87bczlB/CQqCOqlnw0Bo
   yj5Do4Yeb3LJlnA5icguzI6IOdmKCpOLwfvCKx2wOszgxxid5rkvYqYEW
   BWu+rVtpOGdzN9dsQyX85Nq507pJCWu2E1lV/WSXHF7AEzCqaQjxcrQFb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241176941"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="241176941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 06:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="572340021"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2021 06:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 06:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 06:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Tue, 28 Dec 2021 06:54:36 -0800
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Thread-Topic: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Thread-Index: AQHX8Q+KXckW3dfKx0uCWfd3QXiQxaxIOTgA///aUh0=
Date:   Tue, 28 Dec 2021 14:54:36 +0000
Message-ID: <90001979-9362-47F4-A033-62A2F82ADC82@intel.com>
References: <20211214172437.1552740-1-broonie@kernel.org>,<CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
In-Reply-To: <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRGVjIDI4LCAyMDIxLCBhdCAyOjA5IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgRGVjIDE1LCAyMDIx
IGF0IDEwOjUzIEFNIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gVG9kYXkncyBsaW51
eC1uZXh0IG1lcmdlIG9mIHRoZSBkbWFlbmdpbmUgdHJlZSBnb3QgYSBjb25mbGljdCBpbjoNCj4+
IA0KPj4gIGRyaXZlcnMvZG1hL2lkeGQvc3VibWl0LmMNCj4+IA0KPj4gYmV0d2VlbiBjb21taXQ6
DQo+PiANCj4+ICA4YWZmZDhhNGI1Y2UzICgiZG1hZW5naW5lOiBpZHhkOiBmaXggbWlzc2VkIGNv
bXBsZXRpb24gb24gYWJvcnQgcGF0aCIpDQo+PiANCj4+IGZyb20gdGhlIGRtYWVuZ2luZS1maXhl
cyB0cmVlIGFuZCBjb21taXQ6DQo+PiANCj4+ICA1ZDc4YWJiNmZiYzk3ICgiZG1hZW5naW5lOiBp
ZHhkOiByZXdvcmsgZGVzY3JpcHRvciBmcmVlIHBhdGggb24gZmFpbHVyZSIpDQo+PiANCj4+IGZy
b20gdGhlIGRtYWVuZ2luZSB0cmVlLg0KPj4gDQo+PiBJIGZpeGVkIGl0IHVwIChzZWUgYmVsb3cp
IGFuZCBjYW4gY2FycnkgdGhlIGZpeCBhcyBuZWNlc3NhcnkuIFRoaXMNCj4+IGlzIG5vdyBmaXhl
ZCBhcyBmYXIgYXMgbGludXgtbmV4dCBpcyBjb25jZXJuZWQsIGJ1dCBhbnkgbm9uIHRyaXZpYWwN
Cj4+IGNvbmZsaWN0cyBzaG91bGQgYmUgbWVudGlvbmVkIHRvIHlvdXIgdXBzdHJlYW0gbWFpbnRh
aW5lciB3aGVuIHlvdXIgdHJlZQ0KPj4gaXMgc3VibWl0dGVkIGZvciBtZXJnaW5nLiAgWW91IG1h
eSBhbHNvIHdhbnQgdG8gY29uc2lkZXIgY29vcGVyYXRpbmcNCj4+IHdpdGggdGhlIG1haW50YWlu
ZXIgb2YgdGhlIGNvbmZsaWN0aW5nIHRyZWUgdG8gbWluaW1pc2UgYW55IHBhcnRpY3VsYXJseQ0K
Pj4gY29tcGxleCBjb25mbGljdHMuDQo+PiANCj4+IGRpZmYgLS1jYyBkcml2ZXJzL2RtYS9pZHhk
L3N1Ym1pdC5jDQo+PiBpbmRleCA4MzQ1MmZiYmIxNjhiLDU2OTgxNWE4NGU5NWIuLjAwMDAwMDAw
MDAwMDANCj4+IC0tLSBhL2RyaXZlcnMvZG1hL2lkeGQvc3VibWl0LmMNCj4+ICsrKyBiL2RyaXZl
cnMvZG1hL2lkeGQvc3VibWl0LmMNCj4+IEBAQCAtMTM0LDIwIC0xMjAsMzIgKzEyNSw0MyBAQEAg
c3RhdGljIHZvaWQgbGxpc3RfYWJvcnRfZGVzYyhzdHJ1Y3QgaWR4DQo+PiAgICAgICAgc3Bpbl91
bmxvY2soJmllLT5saXN0X2xvY2spOw0KPj4gDQo+PiAgICAgICAgaWYgKGZvdW5kKQ0KPj4gLSAg
ICAgICAgICAgICAgIGNvbXBsZXRlX2Rlc2MoZm91bmQsIElEWERfQ09NUExFVEVfQUJPUlQpOw0K
Pj4gKyAgICAgICAgICAgICAgIGlkeGRfZG1hX2NvbXBsZXRlX3R4ZChmb3VuZCwgSURYRF9DT01Q
TEVURV9BQk9SVCwgZmFsc2UpOw0KPj4gKw0KPj4gKyAgICAgIC8qDQo+PiAtICAgICAgICAqIGNv
bXBsZXRlX2Rlc2MoKSB3aWxsIHJldHVybiBkZXNjIHRvIGFsbG9jYXRvciBhbmQgdGhlIGRlc2Mg
Y2FuIGJlDQo+PiAtICAgICAgICAqIGFjcXVpcmVkIGJ5IGEgZGlmZmVyZW50IHByb2Nlc3MgYW5k
IHRoZSBkZXNjLT5saXN0IGNhbiBiZSBtb2RpZmllZC4NCj4+IC0gICAgICAgICogRGVsZXRlIGRl
c2MgZnJvbSBsaXN0IHNvIHRoZSBsaXN0IHRyYXN2ZXJzaW5nIGRvZXMgbm90IGdldCBjb3JydXB0
ZWQNCj4+IC0gICAgICAgICogYnkgdGhlIG90aGVyIHByb2Nlc3MuDQo+PiArKyAgICAgICAqIGNv
bXBsZXRpbmcgdGhlIGRlc2NyaXB0b3Igd2lsbCByZXR1cm4gZGVzYyB0byBhbGxvY2F0b3IgYW5k
DQo+PiArKyAgICAgICAqIHRoZSBkZXNjIGNhbiBiZSBhY3F1aXJlZCBieSBhIGRpZmZlcmVudCBw
cm9jZXNzIGFuZCB0aGUNCj4+ICsrICAgICAgICogZGVzYy0+bGlzdCBjYW4gYmUgbW9kaWZpZWQu
ICBEZWxldGUgZGVzYyBmcm9tIGxpc3Qgc28gdGhlDQo+PiArKyAgICAgICAqIGxpc3QgdHJhc3Zl
cnNpbmcgZG9lcyBub3QgZ2V0IGNvcnJ1cHRlZCBieSB0aGUgb3RoZXIgcHJvY2Vzcy4NCj4gDQo+
IHRyYXZlcnNpbmcNCj4gDQo+PiArICAgICAgICovDQo+PiArICAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKGQsIHQsICZmbGlzdCwgbGlzdCkgew0KPj4gKyAgICAgICAgICAgICAgbGlzdF9k
ZWxfaW5pdCgmZC0+bGlzdCk7DQo+PiAtICAgICAgICAgICAgICAgY29tcGxldGVfZGVzYyhkLCBJ
RFhEX0NPTVBMRVRFX05PUk1BTCk7DQo+PiArKyAgICAgICAgICAgICAgaWR4ZF9kbWFfY29tcGxl
dGVfdHhkKGQsIElEWERfQ09NUExFVEVfTk9STUFMLCBmYWxzZSk7DQo+IA0KPiBJcyAiZmFsc2Ui
IGNvcnJlY3QgaGVyZT8NCg0KWWVzIHRoYXTigJlzIGNvcnJlY3QuIFRoYW5rcy4gDQo+IA0KPj4g
KyAgICAgIH0NCj4+ICB9DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBU
aGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcN
Cj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJ
IGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFs
aXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
