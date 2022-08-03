Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946E588EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiHCOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiHCOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:46:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0128E5FAA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:46:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-B58XJMnkPz25bSYtoz8p9A-1; Wed, 03 Aug 2022 15:46:09 +0100
X-MC-Unique: B58XJMnkPz25bSYtoz8p9A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 3 Aug 2022 15:46:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 3 Aug 2022 15:46:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] printk for 5.20
Thread-Topic: [GIT PULL] printk for 5.20
Thread-Index: AQHYp0ZOrCjhEtlBF0OMnCiDcM8gDa2dPvww
Date:   Wed, 3 Aug 2022 14:46:08 +0000
Message-ID: <45448fe59f7242fd90c5271a72ca937c@AcuMS.aculab.com>
References: <YufsTLpighCI7qSf@alley>
 <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
 <YuqHvu4zAzwq+BdZ@linutronix.de>
In-Reply-To: <YuqHvu4zAzwq+BdZ@linutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDIyLTA4LTAyIDIwOjE5OjM0IFstMDcwMF0sIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0K
PiA+IFNlcmlvdXNseSwgZXZlbiBpZiB5b3UgaGF2ZSBzdHJpY3QgUlQgcmVxdWlyZW1lbnRzLCB5
b3UgbWF5IGFsc28gaGF2ZQ0KPiA+IHN0cmljdCBkZWJ1Z2dpbmcgcmVxdWlyZW1lbnRzLCBhbmQg
aWYgc29tZXRoaW5nIGdvZXMgd3JvbmcsIHlvdSB3YW50DQo+ID4gdG8gS05PVyBBQk9VVCBJVC4g
QXQgdGhhdCBwb2ludCwgeW91ciBSVCBydWxlcyBtYXkgd2VsbCBmbHkgb3V0IHRoZQ0KPiA+IHdp
bmRvdywgYmVjYXVzZSB5b3UgaGF2ZSBtb3JlIHNlcmlvdXMgcHJvYmxlbXMuDQo+ID4NCj4gPiBF
bmQgcmVzdWx0OiBubyB3YXkgd2lsbCBJIGFjY2VwdCB0aGlzIGtpbmQgb2YgY29tcGxldGVseSBh
cmJpdHJhcnkgYW5kDQo+ID4gZnJhbmtseSBub3QgdmVyeSBpbnRlbGxpZ2VudCBwYXRjaC4NCj4g
Pg0KPiA+IElmIHBlb3BsZSB3YW50IHRvIGRpc2FibGUgY29uc29sZSBwcmludGluZywgdGhhdCdz
IFRIRUlSIENIT0lDRS4gSXQNCj4gPiBjb3VsZCBiZSBhIG5ldyBjb25maWcgdmFyaWFibGUgd2hl
cmUgeW91IEFTSyBwZW9wbGUgYWJvdXQgd2hhdCB0aGV5DQo+ID4gd2FudC4gTm90IHRoaXMga2lu
ZCBvZiBpZGlvdGljIHR5aW5nIHRvZ2V0aGVyIG9mIHRoaW5ncy4NCg0KVGhlcmUgaXMgYWxyZWFk
eSB0aGUgc3lzY3RsIGtlcm5lbC5wcmludGsNClRoYXQgY2FuIGJlIHVzZWQgdG8gbGltaXQgdGhl
IGVmZmVjdHMgb2YgY29uc29sZSBsb2dnaW5nLg0KDQpJIGRvbid0IGFjdHVhbGx5IHJlbWVtYmVy
IHRoZSAndGhyZWFkZWQgY29uc29sZScgc3R1ZmYgYmVpbmcNCmVuYWJsZWQvZGlzYWJsZWQgaW4g
bXVjaCB0aGUgc2FtZSB3YXkuDQoNCkkgZW5kIHVwIHNldHRpbmcgJzYgNCAxIDcnIHRvIGF2b2lk
IHNlcmlhbCBwb3J0IGRlbGF5cy4NCkJ1dCAoaW4gc29tZSBzZW5zZSkgaXQgbWlnaHQgYmUgdXNl
ZnVsIHRvIGhhdmUgdGhlIHN1cHJlc3NlZA0KJ2luZm8nIG1lc3NhZ2VzIG91dHB1dCBieSBhIHRo
cmVhZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

