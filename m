Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6246848B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377344AbhLDLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:49:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4195 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLDLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:49:28 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J5npn1jptz67L8m;
        Sat,  4 Dec 2021 19:41:53 +0800 (CST)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 12:46:01 +0100
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 11:45:59 +0000
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.020;
 Sat, 4 Dec 2021 19:45:58 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: RE: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Thread-Topic: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Thread-Index: AQHX5SHRAlmFSCd89Uy1sBtsuCn0LqwaA1gAgAS8PoCAAAFFAIADT7Qw//+HKACAAKVQcA==
Date:   Sat, 4 Dec 2021 11:45:58 +0000
Message-ID: <c63a4971458c49c7a0cb0a8ba48ceb2d@hisilicon.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net> <YajWjasdqnibSRJm@osiris>
 <YajXnjVGEWeUmEqA@kroah.com> <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>
 <63384337-ba36-9b2a-c9ae-75e3f5ac02d7@inria.fr>
In-Reply-To: <63384337-ba36-9b2a-c9ae-75e3f5ac02d7@inria.fr>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.91]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJpY2UgR29nbGluIFtt
YWlsdG86QnJpY2UuR29nbGluQGlucmlhLmZyXQ0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIg
NCwgMjAyMSAxMDo0OCBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPjsgSGVpa28gQ2Fyc3RlbnMgPGhjYUBsaW51eC5pYm0uY29tPg0KPiBD
YzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgUmFmYWVsIEogLiBXeXNv
Y2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBMZW4gQnJvd24gPGxlbi5i
cm93bkBpbnRlbC5jb20+OyBUaG9tYXMgUmljaHRlciA8dG1yaWNodEBsaW51eC5pYm0uY29tPjsg
SWFuDQo+IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDAvM10gdG9wb2xvZ3kvc3lzZnM6IG9ubHkgZXhwb3J0IHVzZWQgc3lzZnMgYXR0cmlidXRl
cw0KPiANCj4gTGUgMDQvMTIvMjAyMSDDoCAxMDowNywgU29uZyBCYW8gSHVhIChCYXJyeSBTb25n
KSBhIMOpY3JpdMKgOg0KPiA+DQo+ID4gQ291bGQgeW91IGdpdmUgbWUgb25lIG1pbnV0ZT8NCj4g
Pg0KPiA+ICtCcmljZQ0KPiA+DQo+ID4gSSdkIGxpa2UgdG8gaGVhciBzb21lIGZlZWRiYWNrcyBm
cm9tIGh3bG9jIGlmIHRoZXJlDQo+ID4gaXMgYSBjaGFuY2UgdG8gYnJlYWsgdXNlcnNwYWNlIGFu
ZCBpZiB1c2Vyc3BhY2UgZGVwZW5kcw0KPiA+IG9uIHRoZSBleGlzdGVuY2Ugb2Ygc3lzZnMgZXZl
biB0aG91Z2ggdGhlIHRvcG9sb2d5DQo+ID4gZG9lc24ndCBleGlzdC4NCj4gPg0KPiA+IElmIG5v
LCBJIGZlZWwgaXQgaXMgc2FmZSB0byB0YWtlLg0KPiA+DQo+IA0KPiBIZWxsbw0KPiANCj4gSWYg
dGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgaHdsb2MgKnJlcXVpcmVzKiBjbHVzdGVyL2RpZS9ib29r
L2RyYXdlcg0KPiBzeXNmcyBmaWxlcyB0byBleGlzdCwgdGhlbiB0aGUgYW5zd2VyIGlzIG5vLiBX
ZSBoYXZlIHRvIHN1cHBvcnQgb2xkDQo+IGtlcm5lbHMgd2l0aG91dCB0aG9zZSBmaWxlcyBhbnl3
YXkuDQoNClRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbiwgQnJpY2UuIEkgc2F3IGh3bG9jIGlzIHJl
YWRpbmcgc3lzZnMNCmRyYXdlciwgYm9vayBhbmQgY2x1c3Rlci4gQnV0IHNpbmNlIGl0IGRvZXNu
J3QgYXNzdW1lIHRoZWlyDQpleGlzdGVuY2UgaW4gc3lzZnMsIEkgaGF2ZSBtb3JlIGNvbmZpZGVu
Y2Ugb24gdGhpcyBwYXRjaHNldA0Kbm93Lg0KDQpHcmVnLCBwbGVhc2UgaWdub3JlIG15IGNvbW1l
bnQgdGhlbiA6LSkNCg0KPiANCj4gQnJpY2UNCj4gDQo+IA0KDQpUaGFua3MNCkJhcnJ5DQo=
