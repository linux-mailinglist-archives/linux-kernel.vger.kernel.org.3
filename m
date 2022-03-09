Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2093C4D300F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiCINi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiCINiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:38:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 266C94C419
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:37:55 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-144-UXgOpunAMRSZMlNG3aOzdg-1; Wed, 09 Mar 2022 13:37:52 +0000
X-MC-Unique: UXgOpunAMRSZMlNG3aOzdg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 9 Mar 2022 13:37:50 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 9 Mar 2022 13:37:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v4 00/45] x86: Kernel IBT
Thread-Topic: [PATCH v4 00/45] x86: Kernel IBT
Thread-Index: AQHYM4LxCfkzaUw3o020v7uo0T//Qqy3DG6A
Date:   Wed, 9 Mar 2022 13:37:50 +0000
Message-ID: <bdb04de758ea4f89a8731ee6b98794fa@AcuMS.aculab.com>
References: <20220308153011.021123062@infradead.org>
 <20220308200614.gyhp657bdq3rxapl@treble>
 <20220309065718.e4k2el2mlqn23yh2@treble>
In-Reply-To: <20220309065718.e4k2el2mlqn23yh2@treble>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDkgTWFyY2ggMjAyMiAwNjo1Nw0KPiANCj4g
T24gVHVlLCBNYXIgMDgsIDIwMjIgYXQgMTI6MDY6MThQTSAtMDgwMCwgSm9zaCBQb2ltYm9ldWYg
d3JvdGU6DQo+ID4gQXMgdGFsa2VkIGFib3V0IG9uIElSQyB0aGVyZSBhcmUgc3RpbGwgYSBmZXcg
b3V0c3RhbmRpbmcgaXNzdWVzLCB0aGF0DQo+ID4gSSdtIGZpbmUgd2l0aCBmaXhpbmcgYWZ0ZXIg
dGhlIG1lcmdlIHdpbmRvdyBkdXJpbmcgdGhlIHVwY29taW5nIC1uZXh0DQo+ID4gY3ljbGU6DQo+
ID4NCj4gPiAtIHhlbiBoeXBlcmNhbGwgcGFnZSBmdW5jdGlvbnMgbmVlZCAncmV0JyAtIChJIHRo
aW5rIHlvdSBhbHJlYWR5IGZpeGVkKQ0KPiA+DQo+ID4gLSB3aHkgZG9uJ3QgdW5yZWFjaGFibGVz
IG5lZWQgdG8gZmlsbCB1cCB0aGUgZW50aXJlIHN5bSBob2xlPw0KPiA+DQo+ID4gLSBnZXQgcmlk
IG9mIHRoZSAnY19maWxlJyBoYWNrDQo+ID4NCj4gPiAtIGltcHJvdmUgY21kbGluZSBvcHRpb24g
aW50dWl0aXZlLW5lc3MNCj4gPg0KPiA+IC0gcHJvcGVybHkgaW50ZWdyYXRlIHRoZSByZXRwb2xp
bmUgImRlbW90aW9uIiB3aXRoIHRoZSBuZXcgU3BlY3RyZSBCSEkNCj4gPiAgIHJlbGF0ZWQgcGF0
Y2hlcyAtIHByb2JhYmx5IHN0aWxsIG5lZWRzIG1vcmUgZGlzY3Vzc2lvbiAtIGZvciBleGFtcGxl
DQo+ID4gICB3ZSBtaWdodCBpbnN0ZWFkIHdhbnQgdG8gZGlzYWJsZSBJQlQgYW5kIHdhcm4NCj4g
DQo+IE9uZSBtb3JlOg0KPiANCj4gLSBDaGFuZ2luZyBvYmp0b29sIHNob3VsZCBmb3JjZSBhIHZt
bGludXggcmUtbGluay4NCg0KSSdtIHdvbmRlcmluZyB3aGF0IGFjdHVhbGx5IGhhcHBlbnMgdG8g
bG9hZGFibGUgbW9kdWxlcz8NCg0KRXNwZWNpYWxseSB0aG9zZSBidWlsdCAnb3V0IG9mIHRyZWUn
LA0KcG90ZW50aWFsbHkgd2l0aCBhIGRpZmZlcmVudCBjb21waWxlciwNCmFuZCBtYXliZSBjb250
YWluaW5nIGJpbmFyeSAnYmxvYnMnLg0KDQpUaGUgcmVxdWlyZW1lbnQgdG8gcnVuIHByb2dyYW1z
IG9uIG9sZCBkaXN0cmlidXRpb25zIG1lYW5zDQp0aGF0IHRoaW5ncyBnZXQgY29tcGlsZWQgd2l0
aCBxdWl0ZSBvbGQgdmVyc2lvbnMgb2YgZ2NjLg0KRm9yIGluc3RhbmNlIFJIRUw3IGlzIGdjYyA0
LjguNS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

