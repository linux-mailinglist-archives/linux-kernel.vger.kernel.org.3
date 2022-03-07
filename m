Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158F4CF01A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiCGDUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiCGDUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:20:54 -0500
X-Greylist: delayed 1783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 19:19:58 PST
Received: from SHSQR01.unisoc.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FCCE022
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:19:58 -0800 (PST)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 2272oEQb033185
        for <linux-kernel@vger.kernel.org>; Mon, 7 Mar 2022 10:50:14 +0800 (CST)
        (envelope-from bruce.chen@unisoc.com)
Received: from SHSend.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by SHSQR01.spreadtrum.com with ESMTPS id 2272npcb031067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 7 Mar 2022 10:49:51 +0800 (CST)
        (envelope-from bruce.chen@unisoc.com)
Received: from shmbx05.spreadtrum.com (10.29.1.56) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 7 Mar
 2022 10:49:51 +0800
Received: from shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543]) by
 shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543%16]) with mapi id
 15.00.1497.023; Mon, 7 Mar 2022 10:49:51 +0800
From:   =?utf-8?B?6ZmI5bu6IChCcnVjZSBDaGVuKQ==?= <bruce.chen@unisoc.com>
To:     Roger Quadros <rogerq@kernel.org>,
        Bruce Chen <brucechen251@gmail.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?B?57+f5LqsIChPcnNvbiBaaGFpKQ==?= <Orson.Zhai@unisoc.com>
CC:     "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "gengcixi@gmail.com" <gengcixi@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjFdIGV4dGNvbi91c2I6IFJlbW92ZSBkaXNhYmxl?=
 =?utf-8?Q?_irq_operation_in_system_sleep.?=
Thread-Topic: [PATCH V1] extcon/usb: Remove disable irq operation in system
 sleep.
Thread-Index: AQHYLtGVK2uDMo5g702ybB2Qryhxfqys3ByAgAZhotA=
Date:   Mon, 7 Mar 2022 02:49:50 +0000
Message-ID: <a613cd9f7dcc4e70af0db40e7772084e@shmbx05.spreadtrum.com>
References: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
 <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
In-Reply-To: <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.29.193.111]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 2272npcb031067
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K29yc29uDQoNCkhpIEFzd2F0aCAmIFZpZ25lc2g6DQpEaWQgeW91IGhlbHAgY29uZmlybSB3aGF0
IFJvZ2VyIHNhaWQ/IFRoYW5rcy4NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6
OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCuWPkemAgeaXtumXtDogMjAyMuW5
tDPmnIgz5pelIDE3OjIxDQrmlLbku7bkuro6IEJydWNlIENoZW4gPGJydWNlY2hlbjI1MUBnbWFp
bC5jb20+OyDpmYjlu7ogKEJydWNlIENoZW4pIDxicnVjZS5jaGVuQHVuaXNvYy5jb20+OyBteXVu
Z2pvby5oYW1Ac2Ftc3VuZy5jb207IGN3MDAuY2hvaUBzYW1zdW5nLmNvbTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgQXN3YXRoIEdvdmluZHJhanUgPGEtZ292aW5kcmFqdUB0aS5jb20+
OyBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQrmioTpgIE6IG9yc29uemhh
aUBnbWFpbC5jb207IGdlbmdjaXhpQGdtYWlsLmNvbTsgYmFvbGluLndhbmc3QGdtYWlsLmNvbTsg
emhhbmcubHlyYUBnbWFpbC5jb20NCuS4u+mimDogUmU6IFtQQVRDSCBWMV0gZXh0Y29uL3VzYjog
UmVtb3ZlIGRpc2FibGUgaXJxIG9wZXJhdGlvbiBpbiBzeXN0ZW0gc2xlZXAuDQoNCg0K5rOo5oSP
OiDov5nlsIHpgq7ku7bmnaXoh6rkuo7lpJbpg6jjgILpmaTpnZ7kvaDnoa7lrprpgq7ku7blhoXl
rrnlronlhajvvIzlkKbliJnkuI3opoHngrnlh7vku7vkvZXpk77mjqXlkozpmYTku7bjgIINCkNB
VVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXph
dGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0K
K1RJIGZvbGtzIEFzd2F0aCAmIFZpZ25lc2guDQoNCkhpIEJydWNlLA0KDQpPbiAwMy8wMy8yMDIy
IDA5OjM2LCBCcnVjZSBDaGVuIHdyb3RlOg0KPiBGcm9tOiBCcnVjZSBDaGVuIDxicnVjZS5jaGVu
QHVuaXNvYy5jb20+DQo+DQo+IElmIGRpc2FibGUgdmJ1cy9pZCBpcnEsIGl0IHdpbGwgbGVhZCB0
byB3YWtldXAgc3lzdGVtIGZhaWwgaW4gdW5pc29jDQo+IHBsYXRmb3JtLiBJbiB1bmlzb2MgcGxh
dGZvcm0sIElycSBlbmFibGUgYW5kIGlycSB3YWtldXAgYXJlIHRoZSBzYW1lDQo+IGludGVycnVw
dCBsaW5lLiBTbyByZW1vdmUgZGlzYWJsZSB2YnVzL2lkIGlycSBvcGVyYXRpb24gaXMgYSB3YXkg
dG8NCj4gc29sdmUgdGhlIGlzc3VlPg0KPiBTaWduZWQtb2ZmLWJ5OiBCcnVjZSBDaGVuIDxicnVj
ZS5jaGVuQHVuaXNvYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9leHRjb24vZXh0Y29uLXVzYi1n
cGlvLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi11c2ItZ3Bpby5j
DQo+IGIvZHJpdmVycy9leHRjb24vZXh0Y29uLXVzYi1ncGlvLmMNCj4gaW5kZXggZjJiNjVkOS4u
NDBkOTY3YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9leHRjb24vZXh0Y29uLXVzYi1ncGlvLmMN
Cj4gKysrIGIvZHJpdmVycy9leHRjb24vZXh0Y29uLXVzYi1ncGlvLmMNCj4gQEAgLTIyNiwxNiAr
MjI2LDYgQEAgc3RhdGljIGludCB1c2JfZXh0Y29uX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgICAgICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KPiAtICAgICAvKg0KPiAtICAgICAg
KiBXZSBkb24ndCB3YW50IHRvIHByb2Nlc3MgYW55IElSUXMgYWZ0ZXIgdGhpcyBwb2ludA0KPiAt
ICAgICAgKiBhcyBHUElPcyB1c2VkIGJlaGluZCBJMkMgc3Vic3lzdGVtIG1pZ2h0IG5vdCBiZQ0K
PiAtICAgICAgKiBhY2Nlc3NpYmxlIHVudGlsIHJlc3VtZSBjb21wbGV0ZXMuIFNvIGRpc2FibGUg
SVJRLg0KPiAtICAgICAgKi8NCg0KSSB0aGluayB0aGUgcmVhc29uIHRoaXMgd2FzIGFkZGVkIHdh
cyB0aGF0IGlmIFVTQiBjYWJsZSBpcyBwbHVnZ2VkL3VucGx1Z2dlZCB3aGlsZSBzeXN0ZW0gd2Fz
IHN1c3BlbmRpbmcgaXQgd2FzIGNhdXNpbmcgc29tZSBmYXVsdHMgb24gVEkgRFJBNyBFVk0gYXQg
dXNiX2lycV9oYW5kbGVyKCkvdXNiX2V4dGNvbl9kZXRlY3RfY2FibGUoKSB3aGVuIGl0IHRyaWVz
IHRvIHJlYWQgR1BJTyBzdGF0dXMgd2hlbiBJMkMgYmFzZWQgR1BJTyBjb250cm9sbGVyIHdhcyB1
c2VkIGJ1dCBhbHJlYWR5IHN1c3BlbmRlZC4NCkJ1dCBsb29rcyBsaWtlIGRpc2FibGluZyB0aGUg
SVJRIGlzIG5vdCB0aGUgcmlnaHQgYXBwcm9hY2ggZWl0aGVyIHNvIHlvdXIgcGF0Y2ggaXMgcmln
aHQuDQoNCkhvd2V2ZXIgSSdtIG5vdCBzdXJlIGlmIHRoZSBhYm92ZSBpc3N1ZSB3aWxsIHN0aWxs
IGV4aXN0IG9uIERSQTcgYW5kIG90aGVyIFRJIEVWTVMgdXNpbmcgSUQvVkJVUyBHUElPIG92ZXIg
STJDIGRldmljZS4NCg0KTGV0J3Mgd2FpdCBmb3IgQXN3YXRoL1ZpZ25lc2ggdG8gY29uZmlybS4g
SWYgbm8gaXNzdWVzIEknbSBPSyB3aXRoIHRoaXMgcGF0Y2guDQoNCj4gLSAgICAgaWYgKGluZm8t
PmlkX2dwaW9kKQ0KPiAtICAgICAgICAgICAgIGRpc2FibGVfaXJxKGluZm8tPmlkX2lycSk7DQo+
IC0gICAgIGlmIChpbmZvLT52YnVzX2dwaW9kKQ0KPiAtICAgICAgICAgICAgIGRpc2FibGVfaXJx
KGluZm8tPnZidXNfaXJxKTsNCj4gLQ0KPiAgICAgICBpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRl
dikpDQo+ICAgICAgICAgICAgICAgcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsN
Cj4NCj4gQEAgLTI2NywxMSArMjU3LDYgQEAgc3RhdGljIGludCB1c2JfZXh0Y29uX3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+IC0g
ICAgIGlmIChpbmZvLT5pZF9ncGlvZCkNCj4gLSAgICAgICAgICAgICBlbmFibGVfaXJxKGluZm8t
PmlkX2lycSk7DQo+IC0gICAgIGlmIChpbmZvLT52YnVzX2dwaW9kKQ0KPiAtICAgICAgICAgICAg
IGVuYWJsZV9pcnEoaW5mby0+dmJ1c19pcnEpOw0KPiAtDQo+ICAgICAgIHF1ZXVlX2RlbGF5ZWRf
d29yayhzeXN0ZW1fcG93ZXJfZWZmaWNpZW50X3dxLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmluZm8tPndxX2RldGNhYmxlLCAwKTsNCj4NCg0KY2hlZXJzLA0KLXJvZ2VyDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRoaXMgZW1haWwgKGluY2x1ZGluZyBpdHMgYXR0
YWNobWVudHMpIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRvIHdo
aWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBw
cml2aWxlZ2VkLCBjb25maWRlbnRpYWwgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBmcm9tIGRpc2Ns
b3N1cmUuIFVuYXV0aG9yaXplZCB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBj
b3B5aW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiBvciB0YWtpbmcg
YW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBvciB0
aGUgaW5mb3JtYXRpb24gaGVyZWluLCBieSBhbnlvbmUgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBvciBhbiBlbXBsb3llZSBvciBhZ2VudCByZXNwb25zaWJsZSBmb3IgZGVsaXZl
cmluZyB0aGUgbWVzc2FnZSB0byB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
ZG8gbm90IHJlYWQsIGNvcHksIHVzZSBvciBkaXNjbG9zZSBhbnkgcGFydCBvZiB0aGlzIGUtbWFp
bCB0byBvdGhlcnMuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgcGVy
bWFuZW50bHkgZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgaWYgeW91IHJl
Y2VpdmVkIGl0IGluIGVycm9yLiBJbnRlcm5ldCBjb21tdW5pY2F0aW9ucyBjYW5ub3QgYmUgZ3Vh
cmFudGVlZCB0byBiZSB0aW1lbHksIHNlY3VyZSwgZXJyb3ItZnJlZSBvciB2aXJ1cy1mcmVlLiBU
aGUgc2VuZGVyIGRvZXMgbm90IGFjY2VwdCBsaWFiaWxpdHkgZm9yIGFueSBlcnJvcnMgb3Igb21p
c3Npb25zLg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YW35pyJ5L+d5a+G5oCn6LSo77yM5Y+X5rOV
5b6L5L+d5oqk5LiN5b6X5rOE6Zyy77yM5LuF5Y+R6YCB57uZ5pys6YKu5Lu25omA5oyH54m55a6a
5pS25Lu25Lq644CC5Lil56aB6Z2e57uP5o6I5p2D5L2/55So44CB5a6j5Lyg44CB5Y+R5biD5oiW
5aSN5Yi25pys6YKu5Lu25oiW5YW25YaF5a6544CC6Iul6Z2e6K+l54m55a6a5pS25Lu25Lq677yM
6K+35Yu/6ZiF6K+744CB5aSN5Yi244CBIOS9v+eUqOaIluaKq+mcsuacrOmCruS7tueahOS7u+S9
leWGheWuueOAguiLpeivr+aUtuacrOmCruS7tu+8jOivt+S7juezu+e7n+S4reawuOS5heaAp+WI
oOmZpOacrOmCruS7tuWPiuaJgOaciemZhOS7tu+8jOW5tuS7peWbnuWkjemCruS7tueahOaWueW8
j+WNs+WIu+WRiuefpeWPkeS7tuS6uuOAguaXoOazleS/neivgeS6kuiBlOe9kemAmuS/oeWPiuaX
tuOAgeWuieWFqOOAgeaXoOivr+aIlumYsuavkuOAguWPkeS7tuS6uuWvueS7u+S9lemUmea8j+Wd
h+S4jeaJv+aLhei0o+S7u+OAgg0K
