Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EE585176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbiG2OVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiG2OVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:21:02 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36218B27;
        Fri, 29 Jul 2022 07:21:01 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A6A55463484;
        Fri, 29 Jul 2022 16:20:59 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 925D0463209;
        Fri, 29 Jul 2022 16:20:59 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri, 29 Jul 2022 16:20:59 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 29 Jul
 2022 16:20:59 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Fri, 29 Jul 2022 16:20:59 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Topic: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Index: Adibg9VERWQQSIdlTuivPV3k9XDqxwC0zsEAABMWzRABIBEjAAAMSLYA
Date:   Fri, 29 Jul 2022 14:20:58 +0000
Message-ID: <5ef57568791d4a80987b3cb715bbe9d1@hyperstone.com>
References: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
 <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
 <a66fe29560f545e18b91af57f4d0dddb@hyperstone.com>
 <95116fcd-a374-d0c7-47f3-10921325e331@intel.com>
In-Reply-To: <95116fcd-a374-d0c7-47f3-10921325e331@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27046.000
X-TMASE-Result: 10-3.386300-10.000000
X-TMASE-MatchedRID: oTBA/+sdKaY4HKI/yaqRm+Y6WKvKEZZTF4r8H5YrEqxYfsHHDgAMI5w6
        tnDgS/8FCs2j90F4YYktjNtuqn4bqw719kpOO37PjhXy0Khej9JNLPQl0QAltM3/nbjAiSxMfSa
        aVTZG9St1trix3E1eFOj46rO9rCp+MWaDVk6hcbnN+qWlu2ZxaEWGJun24Wb1NC+n2AT31kFko1
        Q4MlbjvYaxlfSrcWmIYkcwbeol/UbHVxBzI/6B454CIKY/Hg3AwWulRtvvYxRlgn288nW9IGnuo
        SGaY+DLjoczmuoPCq2Zc+0v3cEkyq0QPhlR0v0zqbv506vLfGvJWHhlweX64qbq0k6raE0L
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 578c277a-e912-41c6-91cd-dc53e120ee0c-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBJZiBub3QgSSB3b3VsZCBhdCBsZWFzdCBhZGQgdGhlICFtbWNfaXNfaG9zdF9zcGkgY29u
ZGl0aW9uIGZvciBjYWxsaW5nIG1tY19ibGtfc3RhdHVzX2Vycm9yIHRvIG1ha2UgaXQgYSBiaXQg
bW9yZSBjbGVhciB0aGF0IHRoaXMgZnVuY3Rpb24gZG9lcyBkbyB3aGF0IGlzIGludGVuZGVkIGZv
ciBTUEkgY2FyZHMuDQo+DQo+SSBhbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuLiAgSXNuJ3QgaXQg
T0sgdG8gY2hlY2sgQ01EMTMgcmVzcG9uc2UgZm9yIFNQST8NCg0KWW91IGNhbiBkbyB0aGF0IGZv
ciBzdXJlLCBidXQgZS5nLiB3aXRob3V0IHNvbWUga25vd2xlZGdlIGFib3V0IHdoYXQgc3RhdGUg
eW91J3JlIGluIGl0IGRvZXNuJ3QgdGVsbCB5b3UgYSBsb3QuDQpJZiB5b3UgZ2V0IGFsbCB6ZXJv
ZXMgYWZ0ZXIgYSB3cml0ZSBlLmcuLCB5b3UgY2Fubm90IGFsd2F5cyB0ZWxsIGlmIHRoZSBTUEkg
Y2FyZCBpcyBob2xkaW5nIHRoZSBsaW5lIExPVyBiZWNhdXNlIG9mIGJ1c3lbKl0sIG9yIHlvdSBh
Y3R1YWxseSBnb3QgYW4gU1BJIFIyIHdpdGggbm8gZXJyb3IgYml0cyBzZXQuIChUaGUgQ01EMTIg
PSBJTExFR0FMIGFzc2VydCB3b3VsZCBmaXggaXQsIGJ1dCBub3cgYWxsIGNhcmRzIGJlaGF2ZSB0
aGlzIHdheSBhbmQgdGhlIHNwZWMgZG9lc24ndCBtYW5kYXRlIGl0LikNCkl0IGNhbm5vdCByZWFs
bHkgYmUgZGVhbHQgd2l0aCBpbiBhIG5pY2UgbWFubmVyLg0KRnVydGhlcm1vcmUgY2FyZHMgYXJl
LCBhY2NvcmRpbmcgdG8gc3BlYywgZnJlZSB0byB0cmVhdCBjbWQxMyBhcyBJTExFR0FMIGR1cmlu
ZyBkYXRhIHN0YXRlLg0KSWYgc28sIHRoYXQncyBuaWNlIGZvciB1cywgd2UgZ2V0IGEgMHg0IGJh
Y2sgYW5kIGtub3cgd2UgaGF2ZSB0byBmaXggc3RhdGUsIHNvbWUgY2FyZHMgYWxzbw0KYWNjZXB0
IENNRDEzIChubyBlcnJvciBiaXRzIHNldCksIHBlcmZlY3RseSBsZWdhbCwgYnV0IHdlIGRvbid0
IGtub3cgaWYgd2Ugc2hvdWxkIGZpeCBzdGF0ZSBvciBub3QuDQooRnVydGhlcm1vcmUsIGhvdyB0
byBmaXggc3RhdGUgaXMgdGhlbiBkZXBlbmRlbnQgb24gdGhlIGlzc3VlZCAoZS5nLiB0aW1lZG91
dCBjb21tYW5kKQ0KDQoqVGhlIFNEIFNQSSBzcGVjIGUuZy4gc2F5cyBpbiA3LjIuOCB0aGF0IGEg
Q01EMTMgbXVzdCBBTFdBWVMgYmUgcmVzcG9uZGVkIHRvLCBidXQgdGhhdCBpcyBjbGVhcmx5IG5v
dCB0aGUgaW50ZW50aW9uIG9mIHRoZSBzcGVjLCBhIGNhcmQgYWx3YXlzIGxpc3RlbmluZyBmb3Ig
Q01EMTMgaW4gUkNWIHN0YXRlIHNpbXBseSBkb2Vzbid0IG1ha2Ugc2Vuc2UuDQoNCkh5cGVyc3Rv
bmUgR21iSCB8IFJlaWNoZW5hdXN0ci4gMzlhICB8IDc4NDY3IEtvbnN0YW56Ck1hbmFnaW5nIERp
cmVjdG9yOiBEci4gSmFuIFBldGVyIEJlcm5zLgpDb21tZXJjaWFsIHJlZ2lzdGVyIG9mIGxvY2Fs
IGNvdXJ0czogRnJlaWJ1cmcgSFJCMzgxNzgy

