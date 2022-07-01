Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607915630F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiGAKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiGAKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:05:11 -0400
Received: from m1345.mail.163.com (m1345.mail.163.com [220.181.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3CD574349
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TQ/0V
        3FsB0IRL01gxfRe7u0z1zjX3SDeyEwp6u9IufE=; b=IqSZnKWDBaUXA54ANKSng
        v35VnZenyGJTXb2kikMZnp4HOMLO40Gx3WkdcmLbStCwbjTgNSJBWhVnBxs/Yfwa
        xGw2qX6kI8hdrAr5aNa69zIx20WzaVbCfKDA28NrmPh7pOKNdThZjlomFSxrMcX/
        PsCu2hBRvLsmabBrEiJ/rw=
Received: from 15815827059$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr45 (Coremail) ; Fri, 1 Jul 2022 18:04:53 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Fri, 1 Jul 2022 18:04:53 +0800 (CST)
From:   huhai <15815827059@163.com>
To:     "Sudeep Holla" <sudeep.holla@arm.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, luriwen@kylinos.cn,
        liuyun01@kylinos.cn, huhai <huhai@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] firmware: arm_scpi: Fix error handle when scpi probe
 failed
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220701094212.snsnbdjc7hia5oti@bogus>
References: <20220701061606.151366-1-15815827059@163.com>
 <20220701094212.snsnbdjc7hia5oti@bogus>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1752bac0.5d05.181b93873da.Coremail.15815827059@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LcGowACn2jnFxr5iMhkdAA--.3301W
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/1tbiwAUxhVXlv13c4QAAse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBGcmksIEp1bCAwMSwgMjAyMiBhdCAwMjoxNjowNlBNICswODAwLCBodWhhaSB3cm90ZToK
Pj4gRnJvbTogaHVoYWkgPGh1aGFpQGt5bGlub3MuY24+Cj4+Cj4+IFdoZW4gc2NwaSBwcm9iZSBm
YWlscywgZG8gbm90IGp1c3QgcmV0dXJuIHRoZSBlcnJvciBjb2RlLCBidXQgYWxzbyByZXNldAo+
PiB0aGUgZ2xvYmFsIHNjcGlfaW5mbyB0byBOVUxMLCBvdGhlcndpc2Ugc2NwaV9od21vbl9wcm9i
ZSgpIG1heSBnZXQgYSBVQUYKPj4gYW5kIGNhdXNlIHBhbmljOgo+Pgo+Cj5JbnRlcmVzdGluZywg
d2hpY2ggcGxhdGZvcm0gYXJlIHlvdSB1c2luZyB0aGlzIG9uID8gU0NQSSBpcyBkZXByZWNhdGVk
IGZvcgo+YSB3aGlsZSwgcGxlYXNlIHN3aXRjaCB0byBTQ01JIHdoaWNoIGlzIHdlbGwgbWFpbnRh
aW5lZCBib3RoIGluIHRlcm1zIG9mCj5zcGVjaWZpY2F0aW9uIGFuZCBzdXBwb3J0IGluIHRoZSBr
ZXJuZWwuIEkgYWxzbyBhc3N1bWUgdGhpcyBpcyA2NC1iaXQKPnBsYXRmb3JtLCBzbyBJIGRvbid0
IHdhbnQgeW91IHRvIGdldCBzdHVjayBpbiBmdXR1cmUgYmVjYXVzZSBvZiBsYWNrCgo+b2Ygc29t
ZSBmZWF0dXJlIGluIFNDUEkuIFBsZWFzZSBzZWUgaWYgeW91IGNhbiBtaWdyYXRlIHRvIFNDTUku
CgoKVGhpbmtzIGZvciBzaGFyaW5nIHRoaXMgbWFzc2FnZSwgYW5kIG15IHBsYXRmb3JtIGlzIEZU
MjAwMCsoQVJNNjQpLgoKPgo+PiAgIHNjcGlfcHJvdG9jb2wgRlRTQzAwMDE6MDA6IGluY29ycmVj
dCBvciBubyBTQ1AgZmlybXdhcmUgZm91bmQKPj4gICAuLi4gLi4uCj4+ICAgVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAw
MDAwMDAwMDAwMDAwMDAwCj4+ICAgTWVtIGFib3J0IGluZm86Cj4+Cj4KPlsuLi5dCj4KCj5JIHRo
aW5rIHdlIGRvbid0IHNlZSB0byBtYWtlIGl0IGNvbXBsZXguIENhbid0IGl0IGJlIGFzIHNpbXBs
ZSBhczoKCnNjcGlfaW5mbyBpcyBhIGdsb2JhbCB2YXJpYWJsZaOsIHdlIG11c3Qgc2V0IGl0IHRv
IE5VTEwgd2hlbiBpdCBpcyBub3QgdmFsaWQKCj5SZWdhcmRzLAo+U3VkZWVwCj4KPi0tPjgKPgo+
ZGlmZiAtLWdpdCBpL2RyaXZlcnMvZmlybXdhcmUvYXJtX3NjcGkuYyB3L2RyaXZlcnMvZmlybXdh
cmUvYXJtX3NjcGkuYwo+aW5kZXggZGRmMGI5ZmY5ZTE1Li42ZmExYTViMTkzYjggMTAwNjQ0Cj4t
LS0gaS9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY3BpLmMKPisrKyB3L2RyaXZlcnMvZmlybXdhcmUv
YXJtX3NjcGkuYwo+QEAgLTc5OSw3ICs3OTksNyBAQCBzdGF0aWMgc3RydWN0IHNjcGlfb3BzIHNj
cGlfb3BzID0gewo+Cj4gc3RydWN0IHNjcGlfb3BzICpnZXRfc2NwaV9vcHModm9pZCkKPiB7Cj4t
ICAgICAgIHJldHVybiBzY3BpX2luZm8gPyBzY3BpX2luZm8tPnNjcGlfb3BzIDogTlVMTDsKCj4r
ICAgICAgIHJldHVybiBzY3BpX2luZm8gJiYgc2NwaV9pbmZvLT5zY3BpX29wcyA/IHNjcGlfaW5m
by0+c2NwaV9vcHMgOiBOVUxMOwoKCkkgZG9uJ3QgdGhpbmsgaXQgd29yayB3ZWxsLCBiZWNhdXNl
IGl0J3MgYSBVQUYgYW5kIHNjcGlfaW5mby0+c2NwaV9vcHMgY291bGQgYmUgYW55IHZhbHVlIHNl
dCBieSBvdGhlcnMuCgo+IH0KPiBFWFBPUlRfU1lNQk9MX0dQTChnZXRfc2NwaV9vcHMpOwo=
