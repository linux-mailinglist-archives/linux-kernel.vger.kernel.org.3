Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF55630BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiGAJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiGAJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:52:45 -0400
Received: from m1345.mail.163.com (m1345.mail.163.com [220.181.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33BE76965
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BFKPn
        FK2pUUUs29uImitJOT1oXhn6TNBtWFwHBX7s9I=; b=eHbG5LtycY8T27/U2ZFZr
        FCzb2bnsngza9Sne9/8IQbCZDkAe367FNxNTuK7INakixPptYEd6C95rwjUfT3hC
        t78QMl1jBrWjtr9qVywS1GzXx9b5qwXbmhd9qv5uD72nkPNGKe85Fm1lnzEtWr7i
        6190yJ+qW1k8NBZgYOpQIo=
Received: from 15815827059$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr45 (Coremail) ; Fri, 1 Jul 2022 17:52:18 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Fri, 1 Jul 2022 17:52:18 +0800 (CST)
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
Message-ID: <6332f2cd.5b98.181b92ced64.Coremail.15815827059@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LcGowAAnUzrSw75iCRcdAA--.39784W
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/1tbiwAQxhVXlv1scogADsZ
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

Pk9uIEZyaSwgSnVsIDAxLCAyMDIyIGF0IDAyOjE2OjA2UE0gKzA4MDAsIGh1aGFpIHdyb3RlOgo+
PiBGcm9tOiBodWhhaSA8aHVoYWlAa3lsaW5vcy5jbj4KPj4KPj4gV2hlbiBzY3BpIHByb2JlIGZh
aWxzLCBkbyBub3QganVzdCByZXR1cm4gdGhlIGVycm9yIGNvZGUsIGJ1dCBhbHNvIHJlc2V0Cj4+
IHRoZSBnbG9iYWwgc2NwaV9pbmZvIHRvIE5VTEwsIG90aGVyd2lzZSBzY3BpX2h3bW9uX3Byb2Jl
KCkgbWF5IGdldCBhIFVBRgo+PiBhbmQgY2F1c2UgcGFuaWM6Cj4+Cj4KPkludGVyZXN0aW5nLCB3
aGljaCBwbGF0Zm9ybSBhcmUgeW91IHVzaW5nIHRoaXMgb24gPyBTQ1BJIGlzIGRlcHJlY2F0ZWQg
Zm9yCj5hIHdoaWxlLCBwbGVhc2Ugc3dpdGNoIHRvIFNDTUkgd2hpY2ggaXMgd2VsbCBtYWludGFp
bmVkIGJvdGggaW4gdGVybXMgb2YKPnNwZWNpZmljYXRpb24gYW5kIHN1cHBvcnQgaW4gdGhlIGtl
cm5lbC4gSSBhbHNvIGFzc3VtZSB0aGlzIGlzIDY0LWJpdAo+cGxhdGZvcm0sIHNvIEkgZG9uJ3Qg
d2FudCB5b3UgdG8gZ2V0IHN0dWNrIGluIGZ1dHVyZSBiZWNhdXNlIG9mIGxhY2sKPm9mIHNvbWUg
ZmVhdHVyZSBpbiBTQ1BJLiBQbGVhc2Ugc2VlIGlmIHlvdSBjYW4gbWlncmF0ZSB0byBTQ01JLgo+
Cj4+ICAgc2NwaV9wcm90b2NvbCBGVFNDMDAwMTowMDogaW5jb3JyZWN0IG9yIG5vIFNDUCBmaXJt
d2FyZSBmb3VuZAo+PiAgIC4uLiAuLi4KPj4gICBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMDAK
Pj4gICBNZW0gYWJvcnQgaW5mbzoKPj4KPgo+Wy4uLl0KPgo+SSB0aGluayB3ZSBkb24ndCBzZWUg
dG8gbWFrZSBpdCBjb21wbGV4LiBDYW4ndCBpdCBiZSBhcyBzaW1wbGUgYXM6Cj4KPlJlZ2FyZHMs
Cj5TdWRlZXAKPgo+LS0+OAo+Cj5kaWZmIC0tZ2l0IGkvZHJpdmVycy9maXJtd2FyZS9hcm1fc2Nw
aS5jIHcvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jCj5pbmRleCBkZGYwYjlmZjllMTUuLjZm
YTFhNWIxOTNiOCAxMDA2NDQKPi0tLSBpL2RyaXZlcnMvZmlybXdhcmUvYXJtX3NjcGkuYwo+Kysr
IHcvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jCj5AQCAtNzk5LDcgKzc5OSw3IEBAIHN0YXRp
YyBzdHJ1Y3Qgc2NwaV9vcHMgc2NwaV9vcHMgPSB7Cj4KPiBzdHJ1Y3Qgc2NwaV9vcHMgKmdldF9z
Y3BpX29wcyh2b2lkKQo+IHsKPi0gICAgICAgcmV0dXJuIHNjcGlfaW5mbyA/IHNjcGlfaW5mby0+
c2NwaV9vcHMgOiBOVUxMOwo+KyAgICAgICByZXR1cm4gc2NwaV9pbmZvICYmIHNjcGlfaW5mby0+
c2NwaV9vcHMgPyBzY3BpX2luZm8tPnNjcGlfb3BzIDogTlVMTDsKCkkgZG9uJ3QgdGhpbmsgaXQg
d29yayB3ZWxsLCBiZWNhdXNlIGl0J3MgYSBVQUYgYW5kIHNjcGlfaW5mby0+c2NwaV9vcHMgY291
bGQgYmUgYW55IHZhbHVlIHNldCBieSBvdGhlcnMuCgo+IH0KPiBFWFBPUlRfU1lNQk9MX0dQTChn
ZXRfc2NwaV9vcHMpOwo=
