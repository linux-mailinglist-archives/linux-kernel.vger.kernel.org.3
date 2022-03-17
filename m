Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F44DC482
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiCQLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiCQLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:11:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24BE1DB8B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:10:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-MiCiRbVUN16QRgYdqh5Xig-1; Thu, 17 Mar 2022 11:10:22 +0000
X-MC-Unique: MiCiRbVUN16QRgYdqh5Xig-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 11:10:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 11:10:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vignesh Raghavendra' <vigneshr@ti.com>,
        'Michael Walle' <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
Subject: RE: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Topic: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Index: AQHYOQSPIX1seC7nAUuKrYcK6uPoWazCAVMggAFSn4CAAATp8IAABzYAgAAFzgA=
Date:   Thu, 17 Mar 2022 11:10:21 +0000
Message-ID: <fcae2d955b3f43af8d64f1aa50fbc685@AcuMS.aculab.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
 <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
 <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
 <8b765d24cb9a422bb383aad07251b65f@AcuMS.aculab.com>
 <c17fe9c6-0757-dbb6-6efb-69d05d7ff589@ti.com>
In-Reply-To: <c17fe9c6-0757-dbb6-6efb-69d05d7ff589@ti.com>
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

RnJvbTogVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiBTZW50OiAxNyBNYXJjaCAyMDIyIDEwOjI0DQou
Li4NCj4gTW9kZXJuIE9TUEkvUVNQSSBmbGFzaCBjb250cm9sbGVycyBwcm92aWRlIE1NSU8gaW50
ZXJmYWNlIHRvIHJlYWQgZnJvbQ0KPiBmbGFzaCB3aGVyZSBETUEgY2FuIHB1bGwgZGF0YSBhcyBp
ZiB0aG91Z2ggeW91IGFyZSByZWFkaW5nIGZyb20gT24gY2hpcCBSQU0NCg0KU28gdGhlIGNwdSBk
b2VzIGFuIE1NSU8gcmVhZCBjeWNsZSB0byB0aGUgY29udHJvbGxlciB3aGljaCBkb2Vzbid0DQpj
b21wbGV0ZSB1bnRpbCAoZm9yIHRoZSBuaWJibGUtbW9kZSBzcGkgZGV2aWNlIEkgaGF2ZSk6DQox
KSBDaGlwc2VsZWN0IGlzIGFzc2VydGVkLg0KMikgVGhlIDgtYml0IGNvbW1hbmQgaGFzIGJlZW4g
Y2xvY2tlZCBvdXQuDQozKSBUaGUgMzJiaXQgYWRkcmVzcyBoYXZlIGJlZW4gY2xvY2tlZCBvdXQg
KDggY2xvY2tzIGluIG5pYmJsZXMpLg0KNCkgQSBmZXcgKHByb2JhYmx5IDQpIGV4dHJhIGRlbGF5
IGNsb2NrcyBhcmUgYWRkZWQuDQo1KSBUaGUgZGF0YSBpcyByZWFkIC0gOCBjbG9ja3MgZm9yIDMy
Yml0cyBpbiBuaWJibGUgbW9kZS4NCjYpIENoaXBzZWxlY3QgaXMgcmVtb3ZlZC4NCg0KTm93IHlv
dSBjYW4gZG8gbG9uZyBzZXF1ZW50aWFsIHJlYWRzIHdpdGhvdXQgYWxsIHRoZSByZWQgdGFwZS4N
CkJ1dCBhIHJhbmRvbSByZWFkIGluIG5pYmJsZSBtb2RlIGlzIGFib3V0IDMwIGNsb2Nrcy4NCjE2
IGJpdCBtb2RlIHNhdmVzIDYgY2xvY2tzIGZvciB0aGUgZGF0YSBhbmQgbWF5YmUgNiBmb3IgdGhl
IGFkZHJlc3M/DQoNClRoZSBjb250cm9sbGVyIGNvdWxkIGRvICdjbGV2ZXIgc3R1ZmYnIGZvciBz
ZXF1ZW50aWFsIHJlYWRzLg0KQXQgYSBjb3N0IG9mIHNsb3dpbmcgZG93biByYW5kb20gcmVhZHMu
DQoNClNvIGV2ZW4gYXQgNDAwTUh6IGl0IGlzbid0IHRoYXQgZmFzdC4NCg0KSWYgdGhlIE1NSU8g
aW50ZXJmYWNlIHRvIHRoZSBmbGFzaCBjb250cm9sbGVyIGlzIFBDSWUgeW91IGNhbg0KYWRkIGlu
IGEgbG9hZCBvZiBleHRyYSBsYXRlbmN5IGZvciB0aGUgY3B1IHJlYWQgaXRzZWxmLg0KDQpXaGls
ZSBQQ0llIGFsbG93cyBtdWx0aXBsZSByZWFkIHJlcXVlc3RzIHRvIGJlIG91dHN0YW5kaW5nLA0K
dGhlIEludGVsIGNwdSBJJ3ZlIGxvb2tlZCBhdCBzZXJpYWxpc2UgdGhlIHJlYWRzIGZyb20gZWFj
aA0KY3B1IGNvcmUgKGVhY2ggY3B1IGFsd2F5cyB1c2VzIHRoZSBzYW1lIFRMUCB0YWcpLg0KDQpO
b3cgbG9uZ2VyIHJlYWQgVExQIGhlbHAgYSBsb3QgKElJUkMgbWF4IGlzIDI1NiBieXRlcykuDQpC
dXQgdGhlIHg4NiBjcHUgd2lsbCBvbmx5IGdlbmVyYXRlIHJlYWQgVExQIGZvciByZWdpc3RlciBy
ZWFkcy4NCllvdSBuZWVkIHRvIHVzZSBBVlg1MTIgcmVnaXN0ZXJzIChvciBjYWNoZSBsaW5lIGZl
dGNoZXMpIHRvDQpnZXQgYmV0dGVyIHRocm91Z2hwdXQhDQoNClRoZSBhbHRlcm5hdGl2ZSBpcyBn
ZXR0aW5nIHRoZSBmbGFzaCBjb250cm9sbGVyIHRvIGlzc3VlDQp0aGUgcmVhZC93cml0ZSBUTFAg
Zm9yIG1lbW9yeSB0cmFuc2ZlcnMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

