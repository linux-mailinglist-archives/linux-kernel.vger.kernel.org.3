Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9E4B962D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiBQC6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:58:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBQC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:58:36 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B37E5D76E3;
        Wed, 16 Feb 2022 18:58:19 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 17 Feb 2022 10:57:55
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Thu, 17 Feb 2022 10:57:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, jleng@ambarella.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix superspeedplus transfer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YgzUdO92gzgkqB/9@kroah.com>
References: <Ygow+EB1P84VflBb@kroah.com>
 <20220215021647.4316-1-3090101217@zju.edu.cn> <Yguzht2JJtF+8N76@kroah.com>
 <6ca9a5a8.ae1fb.17f0061243d.Coremail.3090101217@zju.edu.cn>
 <YgzUdO92gzgkqB/9@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <e3311c8.a65f5.17f059d63df.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cC_KCgBXV2yzuQ1iNWBjDQ--.14180W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQAAsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgoKSSB0ZXN0ZWQgdGhlIGZlYXR1
cmUgb24gbGludXgtNS4xMCwgaXQgd2lsbCBjYXVzZSBPb3BzLgpUaGUgT29wcyBpcyBhcyBmb2xs
b3dzOgogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0
IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAwCiBNZW0gYWJvcnQgaW5mbzoKICAgRVNS
ID0gMHg5NjAwMDAwNQogICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJp
dHMKICAgU0VUID0gMCwgRm5WID0gMAogICBFQSA9IDAsIFMxUFRXID0gMAogRGF0YSBhYm9ydCBp
bmZvOgogICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA1CiAgIENNID0gMCwgV25SID0gMAogdXNl
ciBwZ3RhYmxlOiA0ayBwYWdlcywgMzktYml0IFZBcywgcGdkcD0wMDAwMDAwMWIxMmNmMDAwCiBb
MDAwMDAwMDAwMDAwMDAwMF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAw
MDAwLCBwdWQ9MDAwMDAwMDAwMDAwMDAwMAogSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDk2MDAwMDA1
IFsjMV0gUFJFRU1QVCBTTVAKIE1vZHVsZXMgbGlua2VkIGluOiAuLi4KIENQVTogMCBQSUQ6IDYx
OSBDb21tOiBpcnEvOTUtMjAyMDAwODAgVGFpbnRlZDogRyAgICAgICAgICAgTyAgICAgIDUuMTAu
NjEgIzIKIEhhcmR3YXJlIG5hbWU6IEFtYmFyZWxsYSBDVjUgVElNTiBCb2FyZCAoRFQpCiBwc3Rh
dGU6IDIwYzAwMDg1IChuekN2IGRhSWYgK1BBTiArVUFPIC1UQ08gQlRZUEU9LS0pCiBwYyA6IGNv
bmZpZ19lcF9ieV9zcGVlZF9hbmRfYWx0KzB4M2MvMHgyYTAgW2xpYmNvbXBvc2l0ZV0KIGxyIDog
Y29uZmlnX2VwX2J5X3NwZWVkKzB4MTQvMHgyMCBbbGliY29tcG9zaXRlXQogc3AgOiBmZmZmZmZj
MDExZGJiYWMwCiB4Mjk6IGZmZmZmZmMwMTFkYmJhYzAgeDI4OiAwMDAwMDAwMDAwMDAwMDAxCiB4
Mjc6IGZmZmZmZjgxYjNlYjE5MjAgeDI2OiAwMDAwMDAwMDAwMDAwMDAwCiB4MjU6IGZmZmZmZjgx
YjY4MDg1ZTggeDI0OiBmZmZmZmY4MWIzZWU0YzAwCiB4MjM6IGZmZmZmZjgxYjNkNzFjNDAgeDIy
OiAwMDAwMDAwMDAwMDAwMDAwCiB4MjE6IDAwMDAwMDAwMDAwMDAwMDAgeDIwOiBmZmZmZmY4MWI2
ODA4NWU4CiB4MTk6IGZmZmZmZjgxYjY4MDgwMDAgeDE4OiBmZmZmZmZjMDkxZGJiNzM3CiB4MTc6
IDAwMDAwMDAwMDAwMDAwMTcgeDE2OiAwMDAwMDAwMDAwMDAwMDBhCiB4MTU6IDAwMDAwMDAwMDAw
MDAwMDYgeDE0OiBmZmZmZmZjMDExZGJiNzNmCiB4MTM6IDAwMDAwMDAwMDAwMDAwMDEgeDEyOiBm
ZmZmZmZjMDEwOWM5N2U4CiB4MTE6IDAwMDAwMDAwMDAwMDA2NTIgeDEwOiAwMDAwMDAwMDAwMGU1
YTY1CiB4OSA6IGZmZmZmZmMwMTA5Yzk3ZTggeDggOiAwMDAwMDAwMGZmZmZmN2ZmCiB4NyA6IDAw
MDAwMDAwMDAwMDE3ZmQgeDYgOiAwMDAwMDAwMDAwMDAwMDAxCiB4NSA6IGZmZmZmZjgxZmI1OTc2
YTggeDQgOiAwMDAwMDAwMDAwMDAwMDA2CiB4MyA6IDAwMDAwMDAwMDAwMDAwMDAgeDIgOiBmZmZm
ZmY4MWI2ODM4NzE4CiB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiBmZmZmZmY4MWI2ODM4MDA4
CiBDYWxsIHRyYWNlOgogIGNvbmZpZ19lcF9ieV9zcGVlZF9hbmRfYWx0KzB4M2MvMHgyYTAgW2xp
YmNvbXBvc2l0ZV0KICB1dmNfZnVuY3Rpb25fc2V0X2FsdCsweGQ0LzB4MmU4IFt1c2JfZl91dmNd
CiAgc2V0X2NvbmZpZy5jb25zdHByb3AuMCsweDE1NC8weDNhMCBbbGliY29tcG9zaXRlXQogIGNv
bXBvc2l0ZV9zZXR1cCsweDMxNC8weGI0NCBbbGliY29tcG9zaXRlXQogIGNvbmZpZ2ZzX2NvbXBv
c2l0ZV9zZXR1cCsweDg0LzB4YjAgW2xpYmNvbXBvc2l0ZV0KICBjZG5zcF9lcDBfc3RkX3JlcXVl
c3QrMHgyNWMvMHg0NzAgW2NkbnMzXQogIGNkbnNwX3NldHVwX2FuYWx5emUrMHg5NC8weDI1YyBb
Y2RuczNdCiAgY2Ruc3BfaGFuZGxlX2V2ZW50KzB4ZTgvMHgyM2MgW2NkbnMzXQogIGNkbnNwX3Ro
cmVhZF9pcnFfaGFuZGxlcisweDU4LzB4ZTggW2NkbnMzXQogIGlycV90aHJlYWRfZm4rMHgyYy8w
eGEwCiAgaXJxX3RocmVhZCsweDE2NC8weDI4MAogIGt0aHJlYWQrMHgxMjgvMHgxMzQKICByZXRf
ZnJvbV9mb3JrKzB4MTAvMHg0MAogQ29kZTogNzEwMDBjOWYgNTQwMDBiNjAgZjk0MDA4MjEgNTI4
MDAwMDYgKGY5NDAwMDI0KQogLS0tWyBlbmQgdHJhY2UgN2QzMDY1YjgxODFkZTdhNiBdLS0tCiBu
b3RlOiBpcnEvOTUtMjAyMDAwODBbNjE5XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDIKIGdl
bmlycTogZXhpdGluZyB0YXNrICJpcnEvOTUtMjAyMDAwODAiICg2MTkpIGlzIGFuIGFjdGl2ZSBJ
UlEgdGhyZWFkIChpcnEgOTUpCgpCdXQgdGhlIE9vcHMgaXMgZml4ZWQgaW4gdGhlIGxhdGVzdCBr
ZXJuZWwgYnkgdGhlIGZvbGxvd2luZyBjb21taXQ6CiBjb21taXQgMTZkNDI3NTkyMDdmYzNkMWJm
ZjdjZmQzMzBhMDhhMjI1ZTQ3MGJhMAogQXV0aG9yOiBRaWhhbmcgSHUgPGh1cWloYW5nQG9wcG8u
Y29tPgogRGF0ZTogICBXZWQgTm92IDEwIDE4OjExOjI5IDIwMjEgKzA4MDAKCiAgICAgdXNiOiBn
YWRnZXQ6IGNvbXBvc2l0ZTogU2hvdyB3YXJuaW5nIGlmIGZ1bmN0aW9uIGRyaXZlcidzIGRlc2Ny
aXB0b3JzIGFyZSBpbmNvbXBsZXRlLgoKVGhlcmUgYXJlIHNvbWUgcHJvYmxlbXMgd2l0aCBteSBw
cmV2aW91cyB1bmRlcnN0YW5kaW5nLApzbyB0aGUgcGF0Y2ggaXMgYSBmZWF0dXJlIGJ1dCBub3Qg
YSBidWcsIEkgd2lsbCBtb2RpZnkgdGhlCnRpdGxlIGFuZCBkZXNjcmlwdGlvbiBvZiB0aGUgcGF0
Y2ggYW5kIHJlc2VuZCBpdC4gCgpUaGFua3MKSmluZyBMZW5nCg==
