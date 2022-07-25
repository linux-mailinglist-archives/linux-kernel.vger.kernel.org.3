Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75957F7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiGYBnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYBm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:42:59 -0400
Received: from m13114.mail.163.com (m13114.mail.163.com [220.181.13.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC9DB7E5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BFPOB
        qLpPNPkadBte7xqz0J8AvMFiPRP5JeF1+PIexU=; b=Ek5lD/emKD0t0lyThNiCr
        kiibw5bk82WPE8KYFl+qNF4ZTxCByRSPOOCYSwhXWH4nxpgQcQqMXJPD1PF1kk4W
        aNQ2RRfvtpcs/RtIodZFyQD1O4+H30f7E3oy2TMyqMzwyG9nACuTOHNLWtcVUjJt
        yPjcWT3srxrx/jS5T3di78=
Received: from slark_xiao$163.com ( [112.97.48.126] ) by
 ajax-webmail-wmsvr114 (Coremail) ; Mon, 25 Jul 2022 09:42:44 +0800 (CST)
X-Originating-IP: [112.97.48.126]
Date:   Mon, 25 Jul 2022 09:42:44 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re:Re: [PATCH] xfs: Fix typo 'the the' in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YtrkbL4m6f99omFJ@magnolia>
References: <20220722100654.80002-1-slark_xiao@163.com>
 <YtrkbL4m6f99omFJ@magnolia>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <a6be149.924.18233055819.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowACHv9IU9d1iSQ0lAA--.61776W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQtIZGBbEdc1CAADsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDctMjMgMDE6NTQ6NTIsICJEYXJyaWNrIEouIFdvbmci
IDxkandvbmdAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBGcmksIEp1bCAyMiwgMjAyMiBhdCAwNjow
Njo1NFBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBSZXBsYWNlICd0aGUgdGhlJyB3aXRo
ICd0aGUnIGluIHRoZSBjb21tZW50Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8
c2xhcmtfeGlhb0AxNjMuY29tPgo+Cj5BcHBsaWVkLCB0aG91Z2ggc29tZW9uZSBlbHNlIGFscmVh
ZHkgYmVhdCB5b3UgdG8gdGhlIHNlY29uZCBjaHVuay4KPlJldmlld2VkLWJ5OiBEYXJyaWNrIEou
IFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPgo+Cj4tLUQKVGhhbmtzIQo+Cj4+IC0tLQo+PiAgZnMv
eGZzL2xpYnhmcy94ZnNfYWxsb2MuYyB8IDIgKy0KPj4gIGZzL3hmcy94ZnNfZHF1b3QuYyAgICAg
ICAgfCAyICstCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9mcy94ZnMvbGlieGZzL3hmc19hbGxvYy5jIGIvZnMv
eGZzL2xpYnhmcy94ZnNfYWxsb2MuYwo+PiBpbmRleCA0MTU1N2M0MzBjYjYuLmUyYmRmMDg5YzBh
MyAxMDA2NDQKPj4gLS0tIGEvZnMveGZzL2xpYnhmcy94ZnNfYWxsb2MuYwo+PiArKysgYi9mcy94
ZnMvbGlieGZzL3hmc19hbGxvYy5jCj4+IEBAIC04NCw3ICs4NCw3IEBAIHhmc19wcmVhbGxvY19i
bG9ja3MoCj4+ICAvKgo+PiAgICogVGhlIG51bWJlciBvZiBibG9ja3MgcGVyIEFHIHRoYXQgd2Ug
d2l0aGhvbGQgZnJvbSB4ZnNfbW9kX2ZkYmxvY2tzIHRvCj4+ICAgKiBndWFyYW50ZWUgdGhhdCB3
ZSBjYW4gcmVmaWxsIHRoZSBBR0ZMIHByaW9yIHRvIGFsbG9jYXRpbmcgc3BhY2UgaW4gYSBuZWFy
bHkKPj4gLSAqIGZ1bGwgQUcuICBBbHRob3VnaCB0aGUgdGhlIHNwYWNlIGRlc2NyaWJlZCBieSB0
aGUgZnJlZSBzcGFjZSBidHJlZXMsIHRoZQo+PiArICogZnVsbCBBRy4gIEFsdGhvdWdoIHRoZSBz
cGFjZSBkZXNjcmliZWQgYnkgdGhlIGZyZWUgc3BhY2UgYnRyZWVzLCB0aGUKPj4gICAqIGJsb2Nr
cyB1c2VkIGJ5IHRoZSBmcmVlc3AgYnRyZWVzIHRoZW1zZWx2ZXMsIGFuZCB0aGUgYmxvY2tzIG93
bmVkIGJ5IHRoZQo+PiAgICogQUdGTCBhcmUgY291bnRlZCBpbiB0aGUgb25kaXNrIGZkYmxvY2tz
LCBpdCdzIGEgbWlzdGFrZSB0byBsZXQgdGhlIG9uZGlzawo+PiAgICogZnJlZSBzcGFjZSBpbiB0
aGUgQUcgZHJvcCBzbyBsb3cgdGhhdCB0aGUgZnJlZSBzcGFjZSBidHJlZXMgY2Fubm90IHJlZmls
bCBhbgo+PiBkaWZmIC0tZ2l0IGEvZnMveGZzL3hmc19kcXVvdC5jIGIvZnMveGZzL3hmc19kcXVv
dC5jCj4+IGluZGV4IDVhNmMzYzNjNGRlMi4uOGZiOTBkYTg5Nzg3IDEwMDY0NAo+PiAtLS0gYS9m
cy94ZnMveGZzX2RxdW90LmMKPj4gKysrIGIvZnMveGZzL3hmc19kcXVvdC5jCj4+IEBAIC01NDks
NyArNTQ5LDcgQEAgeGZzX2RxdW90X2NoZWNrX3R5cGUoCj4+ICAJICogYXQgdGhlIHNhbWUgdGlt
ZS4gIFRoZSBub24tdXNlciBxdW90YSBmaWxlIGNhbiBiZSBzd2l0Y2hlZCBiZXR3ZWVuCj4+ICAJ
ICogZ3JvdXAgYW5kIHByb2plY3QgcXVvdGEgdXNlcyBkZXBlbmRpbmcgb24gdGhlIG1vdW50IG9w
dGlvbnMsIHdoaWNoCj4+ICAJICogbWVhbnMgdGhhdCB3ZSBjYW4gZW5jb3VudGVyIHRoZSBvdGhl
ciB0eXBlIHdoZW4gd2UgdHJ5IHRvIGxvYWQgcXVvdGEKPj4gLQkgKiBkZWZhdWx0cy4gIFF1b3Rh
Y2hlY2sgd2lsbCBzb29uIHJlc2V0IHRoZSB0aGUgZW50aXJlIHF1b3RhIGZpbGUKPj4gKwkgKiBk
ZWZhdWx0cy4gIFF1b3RhY2hlY2sgd2lsbCBzb29uIHJlc2V0IHRoZSBlbnRpcmUgcXVvdGEgZmls
ZQo+PiAgCSAqIChpbmNsdWRpbmcgdGhlIHJvb3QgZHF1b3QpIGFueXdheSwgYnV0IGRvbid0IGxv
ZyBzY2FyeSBjb3JydXB0aW9uCj4+ICAJICogcmVwb3J0cyB0byBkbWVzZy4KPj4gIAkgKi8KPj4g
LS0gCj4+IDIuMjUuMQo+PiAK
