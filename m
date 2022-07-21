Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7057C49B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGUGo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGUGo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:44:57 -0400
Received: from m1353.mail.163.com (m1353.mail.163.com [220.181.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20FE34BD27
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=uqpt7
        5rdgq/fbr4/W5hPie6UtIR88h7BbOkhuWw7G68=; b=nq4Gjh1/7sKXi8SL7XGmk
        XES+GGzmTSKfLT9CCXuTNpWkKCEmYOhDUHg/Jp+xF/O/gZRPzesHiYi2PyhbAx8P
        gmW4YQEpta8Wb6s6q14dm546uNWVJO3sxinty0O1kLBE7gudlWSUj22oSm5rYOxk
        1AKH+sdipTZpFDIiQxHsfY=
Received: from slark_xiao$163.com ( [112.97.57.47] ) by ajax-webmail-wmsvr53
 (Coremail) ; Thu, 21 Jul 2022 14:43:42 +0800 (CST)
X-Originating-IP: [112.97.57.47]
Date:   Thu, 21 Jul 2022 14:43:42 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Conor Dooley" <mail@conchuod.ie>
Cc:     monstr@monstr.eu, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] microblaze: Fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <f55b4d0b-c9b8-e4b8-9a1d-468f6a22128d@conchuod.ie>
References: <20220721025158.21856-1-slark_xiao@163.com>
 <f55b4d0b-c9b8-e4b8-9a1d-468f6a22128d@conchuod.ie>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7591e9f.1f6c.1821f7f7405.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAAXJ5me9dhi3AIlAA--.30256W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQJFZGBbEa58pQADsI
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpIENvbm9yLAogIFRoYW5rcyBmb3IgeW91ciByZXBseS4KICBBY3R1YWxseSAgSSBkaWRuJ3Qg
Z2V0IHlvdXIgcG9pbnQgb2YgJ1N1cmVseSB0aGlzIHNob3VsZCBiZSAicy90aGUgdGhlL2xpa2Ug
dGhlLywgbm8/Jy4KICBEbyB5b3UgbWVhbiB0aGlzIGlzIE5PVCBhIFRZUE8sIGJ1dCBsaWtlIGEg
Y2hhbmdlIHdoaWNoIHdlIHVzZSAndGhlLycgaW5zdGVhZCBvZiAndGhlIHRoZS8nPwogIApUaGFu
a3MhCgpBdCAyMDIyLTA3LTIxIDE0OjMzOjMyLCAiQ29ub3IgRG9vbGV5IiA8bWFpbEBjb25jaHVv
ZC5pZT4gd3JvdGU6Cj4KPk9uIDIxLzA3LzIwMjIgMDM6NTEsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+
IEZpeCB0eXBvIGluIHRoZSBjb21tZW50Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFv
IDxzbGFya194aWFvQDE2My5jb20+Cj4+IC0tLQo+PiAgIGFyY2gvbWljcm9ibGF6ZS9rZXJuZWwv
ZW50cnkuUyB8IDIgKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9hcmNoL21pY3JvYmxhemUva2VybmVsL2VudHJ5
LlMgYi9hcmNoL21pY3JvYmxhemUva2VybmVsL2VudHJ5LlMKPj4gaW5kZXggYjE3OWY4ZjZkMjg3
Li44NjUxZmUzNTEyNzYgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvbWljcm9ibGF6ZS9rZXJuZWwvZW50
cnkuUwo+PiArKysgYi9hcmNoL21pY3JvYmxhemUva2VybmVsL2VudHJ5LlMKPj4gQEAgLTQ1Niw3
ICs0NTYsNyBAQCBUUkFQX3JldHVybjoJCS8qIE1ha2UgZ2xvYmFsIHN5bWJvbCBmb3IgZGVidWdn
aW5nICovCj4+ICAgCj4+ICAgCj4+ICAgLyogVGhpcyB0aGUgaW5pdGlhbCBlbnRyeSBwb2ludCBm
b3IgYSBuZXcgY2hpbGQgdGhyZWFkLCB3aXRoIGFuIGFwcHJvcHJpYXRlCj4+IC0gICBzdGFjayBp
biBwbGFjZSB0aGF0IG1ha2VzIGl0IGxvb2sgdGhlIHRoZSBjaGlsZCBpcyBpbiB0aGUgbWlkZGxl
IG9mIGFuCj4+ICsgICBzdGFjayBpbiBwbGFjZSB0aGF0IG1ha2VzIGl0IGxvb2sgdGhlIGNoaWxk
IGlzIGluIHRoZSBtaWRkbGUgb2YgYW4KPgo+VGhpcyBpcyAvYS8gZml4LCBidXQgSSBkb24ndCB0
aGluayBpdCBpcyB0aGUgcmlnaHQgb25lIGZvciB0aGlzIGNvbW1lbnQuCj5TdXJlbHkgdGhpcyBz
aG91bGQgYmUgInMvdGhlIHRoZS9saWtlIHRoZS8sIG5vPwo+VGhhbmtzLAo+Q29ub3IuCj4KPj4g
ICAgICBzeXNjYWxsLiAgVGhpcyBmdW5jdGlvbiBpcyBhY3R1YWxseSBgcmV0dXJuZWQgdG8nIGZy
b20gc3dpdGNoX3RocmVhZAo+PiAgICAgIChjb3B5X3RocmVhZCBtYWtlcyByZXRfZnJvbV9mb3Jr
IHRoZSByZXR1cm4gYWRkcmVzcyBpbiBlYWNoIG5ldyB0aHJlYWQncwo+PiAgICAgIHNhdmVkIGNv
bnRleHQpLiAgKi8K
