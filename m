Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50754D9EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbiCOPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349442AbiCOPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:41:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF30D53B54
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:39:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-X2iS_tTiOcWMWEmfNZDmhg-1; Tue, 15 Mar 2022 15:39:53 +0000
X-MC-Unique: X2iS_tTiOcWMWEmfNZDmhg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 15 Mar 2022 15:39:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 15 Mar 2022 15:39:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [tip: x86/core] objtool: Find unused ENDBR instructions
Thread-Topic: [tip: x86/core] objtool: Find unused ENDBR instructions
Thread-Index: AQHYOFmT3fMulR219kOHQpX/dLMyoazAlNEw
Date:   Tue, 15 Mar 2022 15:39:52 +0000
Message-ID: <a5fa50d9f00542de8a6ad7a3fe0c49b3@AcuMS.aculab.com>
References: <20220308154319.763643193@infradead.org>
 <164734101940.16921.11639161864874862247.tip-bot2@tip-bot2>
In-Reply-To: <164734101940.16921.11639161864874862247.tip-bot2@tip-bot2>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gDQo+IG9ianRvb2w6IEZpbmQgdW51c2VkIEVOREJSIGlu
c3RydWN0aW9ucw0KPiANCj4gRmluZCBhbGwgRU5EQlIgaW5zdHJ1Y3Rpb25zIHdoaWNoIGFyZSBu
ZXZlciByZWZlcmVuY2VkIGFuZCBzdGljayB0aGVtDQo+IGluIGEgc2VjdGlvbiBzdWNoIHRoYXQg
dGhlIGtlcm5lbCBjYW4gcG9pc29uIHRoZW0sIHNlYWxpbmcgdGhlDQo+IGZ1bmN0aW9ucyBmcm9t
IGV2ZXIgYmVpbmcgYW4gaW5kaXJlY3QgY2FsbCB0YXJnZXQuDQoNClRob3VnaHQsIHdoYXQgaGFw
cGVucyBpZiB0aGUgb25seSBpbmRpcmVjdCBjYWxsIGlzIGZyb20NCmNvZGUgaW4gYSBtb2R1bGU/
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

