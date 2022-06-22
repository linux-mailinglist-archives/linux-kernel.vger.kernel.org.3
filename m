Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC215540CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355797AbiFVDMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355715AbiFVDMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:12:22 -0400
Received: from m13110.mail.163.com (m13110.mail.163.com [220.181.13.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887492E9C5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=jmA9M
        iP18s2qx/4bJ8dT774gH74Ts8g2x5gZaMn48jA=; b=f4YWJL+McKECzl+zsLOjv
        nf2Z1+7DcaUqs+EqWWDMqXyFL3ygGWV7cVP6aTv4dtfSYe6umb2ahM/S0Aqm5dUk
        fbUXan6JxnJ/ueOD93WdH9X3tcJ20jAIXQ86QyHa22xOLgG+oOJyMSX88XALBzAU
        9r9f5C4QpdMkdVTnLMHHHY=
Received: from slark_xiao$163.com ( [112.97.63.176] ) by
 ajax-webmail-wmsvr110 (Coremail) ; Wed, 22 Jun 2022 11:11:26 +0800 (CST)
X-Originating-IP: [112.97.63.176]
Date:   Wed, 22 Jun 2022 11:11:26 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Manivannan Sadhasivam" <mani@kernel.org>
Cc:     quic_hemantk@quicinc.com, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.jaillet@wanadoo.fr
Subject: Re:Re: [PATCH] bus: mhi: host: Add support for Cinterion MV31-W
 with new device ID
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220621131751.GD17181@thinkpad>
References: <20220601061915.10946-1-slark_xiao@163.com>
 <20220621131751.GD17181@thinkpad>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <340921be.1572.1818964af76.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bsGowAAHSwReiLJiOOsRAA--.4546W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQEoZGBbD9CRLgACsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yMSAyMToxNzo1MSwgIk1hbml2YW5uYW4gU2FkaGFzaXZhbSIgPG1hbmlA
a2VybmVsLm9yZz4gd3JvdGU6Pk9uIFdlZCwgSnVuIDAxLCAyMDIyIGF0IDAyOjE5OjE1UE0gKzA4
MDAsIFNsYXJrIFhpYW8gd3JvdGU6PgoKPlBsZWFzZSB1c2UgcGNpX2dlbmVyaWMgaW4gdGhlIHN1
YmplY3QgYXMgdGhpcyBjaGFuZ2UgYmVsb25ncyB0byB0aGF0IGRyaXZlcjoKPgo+YnVzOiBtaGk6
IGhvc3Q6IHBjaV9nZW5lcmljOiBBZGQgQ2ludGVyaW9uIE1WMzEtVyB3aXRoIG5ldyBiYXNlbGlu
ZQo+Cj4+IEFzIFRoYWxlcyB3b3VsZCB1c2UgYSBuZXcgYmFzZWxpbmUsIHNvIHdlIG5lZWQgdG8g
YWRkCj4+IGEgbmV3IGRldmljZSBJRCB0byBzZXBhcmF0ZSBpdCBmcm9tIHByZXZpb3VzLgo+PiAK
Pgo+VGhhbGVzIHJlZmVycyB0byBDaW50ZXJpb24gTVYzMS1XLCByaWdodD8gQmV0dGVyIGp1c3Qg
dXNlIENpbnRlcmlvbiBNVjMxLVcuCkhpLCBhY3R1YWxseSBDaW50ZXJpb24gYmVsb25ncyB0byBU
aGFsZXMgR3JvdXAuIEFueXdheSwgSSB3aWxsIHVzZSBDSW50ZXJpb24KZm9yIHRoaXMgcHJvZHVj
dC4KCj5MaWtlLAo+Cj5DaW50ZXJpb24gTVYzMS1XIG1vZGVtIHdpdGggYSBuZXcgYmFzZWxpbmUg
KGZpcm13YXJlKSBpcyBzb2xkIGFzIGEgc2VwYXJhdGUKPnByb2R1Y3Qgd2l0aCBkaWZmZXJlbnQg
ZGV2aWNlIElELiBTbyBhZGQgc3VwcG9ydCBmb3IgdGhlIHNhbWUgcmV1c2luZyB0aGUKPmNvbmZp
Zy4KPgpJIHdpbGwgYXBwbHkgaXQgaW4gVjIuIFRoYW5rcy4KCj5UaGFua3MsCj5NYW5pCj4KPj4g
U2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+PiAtLS0KPj4g
IGRyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgfCAzICsrKwo+PiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL21o
aS9ob3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5j
Cj4+IGluZGV4IDZmYmM1OTE1ZWEzNi4uYTJhNGZkMmNkMTNkIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+ICsrKyBiL2RyaXZlcnMvYnVzL21oaS9o
b3N0L3BjaV9nZW5lcmljLmMKPj4gQEAgLTU3OCw2ICs1NzgsOSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBjaV9kZXZpY2VfaWQgbWhpX3BjaV9pZF90YWJsZVtdID0gewo+PiAgCS8qIE1WMzEtVyAo
Q2ludGVyaW9uKSAqLwo+PiAgCXsgUENJX0RFVklDRSgweDEyNjksIDB4MDBiMyksCj4+ICAJCS5k
cml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9tdjMxX2luZm8gfSwKPj4gKwkvKiBN
VjMxLVcgKENpbnRlcmlvbiksIGJhc2VkIG9uIG5ldyBiYXNlbGluZSAqLwo+PiArCXsgUENJX0RF
VklDRSgweDEyNjksIDB4MDBiNCksCj4+ICsJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdf
dCkgJm1oaV9tdjMxX2luZm8gfSwKPj4gIAkvKiBNVjMyLVdBIChDaW50ZXJpb24pICovCj4+ICAJ
eyBQQ0lfREVWSUNFKDB4MTI2OSwgMHgwMGJhKSwKPj4gIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5l
bF91bG9uZ190KSAmbWhpX212MzJfaW5mbyB9LAo+PiAtLSAKPj4gMi4yNS4xCj4+IAo+Cj4tLSAK
PuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40K
