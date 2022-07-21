Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDD57C50A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiGUHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiGUHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:09:05 -0400
Received: from m1353.mail.163.com (m1353.mail.163.com [220.181.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 885527B355
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=H21Z3
        zENWhrexHUy/InJxjqdjQsZr7/yZzHfgQUmPTs=; b=B5UoD81DnjHi01oNw0p4P
        TvRvA0hmpkPaWcVjMScpdCS19Uvo/oimZbUdKQ2+1IDYwDQuYevqqi2WO1Owl1mb
        jT9uI7qYZOOvZb09xdDFyV4mOahRqsFV4/zZ9q1iPxdvSUT43ahI5cUbDijth20x
        b+YyV0I0w3Xlp4ZDzvjLvE=
Received: from slark_xiao$163.com ( [112.97.57.47] ) by ajax-webmail-wmsvr53
 (Coremail) ; Thu, 21 Jul 2022 15:08:35 +0800 (CST)
X-Originating-IP: [112.97.57.47]
Date:   Thu, 21 Jul 2022 15:08:35 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Conor Dooley" <mail@conchuod.ie>
Cc:     monstr@monstr.eu, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] microblaze: Fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <fe53105e-3891-b11f-b01b-70b123831b88@conchuod.ie>
References: <20220721025158.21856-1-slark_xiao@163.com>
 <f55b4d0b-c9b8-e4b8-9a1d-468f6a22128d@conchuod.ie>
 <7591e9f.1f6c.1821f7f7405.Coremail.slark_xiao@163.com>
 <fe53105e-3891-b11f-b01b-70b123831b88@conchuod.ie>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ece9d3d.21f8.1821f963a2d.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAAnNphz+9hiAgclAA--.30264W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQtFZFaEKA1EAgACsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgpBdCAyMDIyLTA3LTIxIDE0OjUzOjMwLCAiQ29ub3IgRG9vbGV5IiA8bWFpbEBjb25j
aHVvZC5pZT4gd3JvdGU6Cj4KPkhleSBTbGFyaywKPk9uIHRoZSBsaXN0IHdlIHJlcGx5ICJpbmxp
bmUiIHJhdGhlciB0aGFuIGF0IHRoZSB0b3Agb2YgdGhlCj5xdW90ZWQgZW1haWwuIFRoaXMgbWFr
ZXMgdGhpbmdzIGVhc2llciB0byBmb2xsb3cuCj5JIGZpeGVkIHVwIHlvdXIgcmVwbHksIHNlZSBi
ZWxvdyA7KQo+Cj5PbiAyMS8wNy8yMDIyIDA3OjQzLCBTbGFyayBYaWFvIHdyb3RlOgo+PiAKPj4g
QXQgMjAyMi0wNy0yMSAxNDozMzozMiwgIkNvbm9yIERvb2xleSIgPG1haWxAY29uY2h1b2QuaWU+
IHdyb3RlOgo+Pj4KPj4+IE9uIDIxLzA3LzIwMjIgMDM6NTEsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+
Pj4gRml4IHR5cG8gaW4gdGhlIGNvbW1lbnQKPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJr
IFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4+PiAtLS0KPj4+PiAgICBhcmNoL21pY3JvYmxh
emUva2VybmVsL2VudHJ5LlMgfCAyICstCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9taWNyb2Js
YXplL2tlcm5lbC9lbnRyeS5TIGIvYXJjaC9taWNyb2JsYXplL2tlcm5lbC9lbnRyeS5TCj4+Pj4g
aW5kZXggYjE3OWY4ZjZkMjg3Li44NjUxZmUzNTEyNzYgMTAwNjQ0Cj4+Pj4gLS0tIGEvYXJjaC9t
aWNyb2JsYXplL2tlcm5lbC9lbnRyeS5TCj4+Pj4gKysrIGIvYXJjaC9taWNyb2JsYXplL2tlcm5l
bC9lbnRyeS5TCj4+Pj4gQEAgLTQ1Niw3ICs0NTYsNyBAQCBUUkFQX3JldHVybjoJCS8qIE1ha2Ug
Z2xvYmFsIHN5bWJvbCBmb3IgZGVidWdnaW5nICovCj4+Pj4gICAgCj4+Pj4gICAgCj4+Pj4gICAg
LyogVGhpcyB0aGUgaW5pdGlhbCBlbnRyeSBwb2ludCBmb3IgYSBuZXcgY2hpbGQgdGhyZWFkLCB3
aXRoIGFuIGFwcHJvcHJpYXRlCj4+Pj4gLSAgIHN0YWNrIGluIHBsYWNlIHRoYXQgbWFrZXMgaXQg
bG9vayB0aGUgdGhlIGNoaWxkIGlzIGluIHRoZSBtaWRkbGUgb2YgYW4KPj4+PiArICAgc3RhY2sg
aW4gcGxhY2UgdGhhdCBtYWtlcyBpdCBsb29rIHRoZSBjaGlsZCBpcyBpbiB0aGUgbWlkZGxlIG9m
IGFuCj4+Pgo+Pj4gVGhpcyBpcyAvYS8gZml4LCBidXQgSSBkb24ndCB0aGluayBpdCBpcyB0aGUg
cmlnaHQgb25lIGZvciB0aGlzIGNvbW1lbnQuCj4+PiBTdXJlbHkgdGhpcyBzaG91bGQgYmUgInMv
dGhlIHRoZS9saWtlIHRoZS8sIG5vPwo+Pgo+PiAgICBUaGFua3MgZm9yIHlvdXIgcmVwbHkuCj4+
ICAgIEFjdHVhbGx5ICBJIGRpZG4ndCBnZXQgeW91ciBwb2ludCBvZiAnU3VyZWx5IHRoaXMgc2hv
dWxkIGJlICJzL3RoZSB0aGUvbGlrZSB0aGUvLCBubz8nLgo+PiAgICBEbyB5b3UgbWVhbiB0aGlz
IGlzIE5PVCBhIFRZUE8sIGJ1dCBsaWtlIGEgY2hhbmdlIHdoaWNoIHdlIHVzZSAndGhlLycgaW5z
dGVhZCBvZiAndGhlIHRoZS8nPwo+Cj5XaGF0IEkgbWVhbnQgd2FzIHRoYXQgdGhlIHNlbnRlbmNl
IGRvZXMgbm90IG1ha2UgdmVyeSBtdWNoIHNlbnNlLCBlaXRoZXIgbm93Cj5vciB3aXRoIHlvdXIg
cGF0Y2ggYXBwbGllZC4gSSBkbyB0aGluayB0aGF0ICJ0aGUgdGhlIiBpcyBhIG1pc3Rha2UsIGJ1
dCB0byBtZQo+dGhlIGNvcnJlY3QgZml4IGlzIHJlcGxhY2luZyBpdCB3aXRoICJsaWtlIHRoZSIg
cmF0aGVyIHRoYW4gInRoZSIuCj5UaGUgbmV3IHNlbnRlbmNlIHdvdWxkIHJlYWQ6Cj4ic3RhY2sg
aW4gcGxhY2UgdGhhdCBtYWtlcyBpdCBsb29rIGxpa2UgdGhlIGNoaWxkIGlzIGluIHRoZSBtaWRk
bGUgb2YgYW4iCj4KPk9oLCBhbHNvIC0gdGhlcmUncyBhbm90aGVyIHR5cG8gaW4gdGhpcyBsaW5l
LiAiYW4gc3lzY2FsbCIgc2hvdWxkIGJlICJhIHN5c2NhbGwiLgo+VGhhbmtzLAoKPkNvbm9yLgpU
aGlzIHRpbWUgSSBnZXQgd2hhdCB5b3Ugc2FpZC4gQWN0dWFsbHkgSSBoYXZlIGNvbW1pdHRlZCBh
Ym91dCAyMCBjb21taXRzIGFib3V0IHRoaXMgdHlwby4KSSBzZWFyY2hlZCBpdCBpbiB3aG9sZSBw
cm9qZWN0IHRvIHNlZSB3aGljaCBmaWxlIHVzZSAndGhlIHRoZScuIFNvIEkgbWlzcyBjaGVja2lu
ZyBhYm91dCAKCnRoZSBzZW50ZW5jZSByZWFsIG1lYW5pbmcsIGp1c3QgbGlrZSBpbiB0aGlzIGNo
YW5nZS4gCgrCoCBBbHNvLCBzb21lIG1haW50YWluZXJzIHdvdWxkIGxpa2UgdG8gcmVwbHkgbWUg
aW4gdGhlIHRvcCBvZiBxdW90ZWQgZW1haWwuIFNvIGl0J3MgaGFyZCAKCmZvciBtZSB0byBwaWNr
IHRoZSAnY29ycmVjdCcgYmVoYXZpb3IuCsKgIEFueXdheSwgSSB3aWxsIGluc2lzdCBvbiByZXBs
eWluZyBpdCBpbiAnaW5saW5lJyBhbmQgYSB2ZXJzaW9uIHYyIHdvdWxkIGJlIGNvbW1pdC4KCgpU
aGFua3MhCgoKPgo+PiAgICAKPj4gVGhhbmtzIQo+Pj4KPj4+PiAgICAgICBzeXNjYWxsLiAgVGhp
cyBmdW5jdGlvbiBpcyBhY3R1YWxseSBgcmV0dXJuZWQgdG8nIGZyb20gc3dpdGNoX3RocmVhZAo+
Pj4+ICAgICAgIChjb3B5X3RocmVhZCBtYWtlcyByZXRfZnJvbV9mb3JrIHRoZSByZXR1cm4gYWRk
cmVzcyBpbiBlYWNoIG5ldyB0aHJlYWQncwo+Pj4+ICAgICAgIHNhdmVkIGNvbnRleHQpLiAgKi8K

