Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A773B490577
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiAQJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:54:57 -0500
Received: from m1397.mail.163.com ([220.181.13.97]:1859 "EHLO
        m1397.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiAQJy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=9dnuf
        rMMtk3itgkWFpthNjv+i06kMuBtg0W7wPYLTxE=; b=aZEAQoaYt6Naomu1ING73
        u96ooLZwi/o/Fx/YAWUDip1zLxg+uBUkzJngziUIaWit60L0jAg4AjomBsb/46Sg
        KCA45ornegWjnovlhwI10ui3yuCiAyIIoxXe0oIEU3txItRo1LVgqDNr6kuU6Gfx
        1afLPav9IyVXJdOOdGlcuU=
Received: from slark_xiao$163.com ( [112.97.53.17] ) by ajax-webmail-wmsvr97
 (Coremail) ; Mon, 17 Jan 2022 17:54:37 +0800 (CST)
X-Originating-IP: [112.97.53.17]
Date:   Mon, 17 Jan 2022 17:54:37 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Manivannan Sadhasivam" <mani@kernel.org>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH net v2] For default mechanism, product would use
 default MRU 3500 if they didn't define it. But for Foxconn SDX55, there is
 a known issue which MRU 3500 would lead to data connection lost. So we
 align it with Qualcomm default MRU settings.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220117084432.GB4209@thinkpad>
References: <20220117081644.21121-1-slark_xiao@163.com>
 <20220117084432.GB4209@thinkpad>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <50e92997.386b.17e6775c20b.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: YcGowADnCyvdPOVhWi0NAA--.52199W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDR+LZFaEG24L7QACs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKQXQgMjAyMi0wMS0xNyAxNjo0NDozMiwgIk1hbml2YW5uYW4gU2FkaGFzaXZhbSIgPG1h
bmlAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBNb24sIEphbiAxNywgMjAyMiBhdCAwNDoxNjo0NFBN
ICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBGaXhlczogNWMyYzg1MzE1OTQ4ICgiYnVzOiBt
aGk6IHBjaS1nZW5lcmljOiBjb25maWd1cmFibGUgbmV0d29yayBpbnRlcmZhY2UgTVJVIikKPgo+
WW91IGhhdmUgbWVzc2VkIHVwIHRoZSBwYXRjaCBzdWJqZWN0LCBwbGVhc2UgZml4IGl0LiBBbHNv
LCB0aGUgY29ycmVjdCBmaXhlcyB0YWcKPnNob3VsZCBiZSB0aGUgb25lIGFkZGVkIHRoZSBGb3hj
b25uIG1vZGVtIHN1cHBvcnQsIHByZWNpc2VseSAiYWFjNDI2NTYyZjU2Ii4KPgpZZXMsIHNvcnJ5
IGZvciB0aGlzIG1pc3Rha2UuIAo+T25lIG1vcmUgdGhpbmcsIHBsZWFzZSBtYWtlIHN1cmUgdGhp
cyBNUlUgdmFsdWUgd29ya3Mgd2VsbCBmb3Igb3RoZXIgRm94Y29ubgo+bW9kZW1zIHN1cHBvcnRl
ZCBieSB0aGlzIGNvbmZpZy4KPgpJIGFtIHN1cmUgdGhpcyB3b3VsZCB3b3JrIGZvciBhbGwgIG91
ciBkZXZpY2UuIEJUVywgSSB3YW50IHRvIGFkZCB0aGlzIG1ydV9kZWZhdWx0IHRvIApjaW50ZXJp
b24tbXYzMSBQUk9EVUNULiBTaGFsbCBJIHVzZSB2MyBvciBjcmVhdGUgYSBuZXcgdmVyc2lvbiBm
b3IgdGhhdD8gSXQncyBjb25maXJtZWQgCnRoYXQgdGhpcyBjaGFuZ2UgY291bGQgaGVscCBmaXgg
aXNzdWUgb24gdGhhdCBwcm9kdWN0Lgo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFy
a194aWFvQDE2My5jb20+Cj4KPllvdSBzaG91bGQgaGF2ZSBhZGRlZCBteSBSZXZpZXdlZC1ieSB0
YWcgdG9vLi4uClNoYWxsIEkgYWRkIHJldmlld2QtYnkgdGFnIGlmIEkgYWRkIGNoYW5nZXMgb24g
TVYzMSBwcm9kdWN0Pwo+Cj5UaGFua3MsCj5NYW5pCj4KPj4gCj4+IC0tLQo+PiB2MjogQWRkIEZp
eGVzIHRhZwo+PiAtLS0KPj4gIGRyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZXJpYy5jIHwgMSArCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2J1cy9taGkvcGNpX2dlbmVyaWMuYyBiL2RyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZXJpYy5j
Cj4+IGluZGV4IDNhMjU4YTY3N2RmOC4uNzRlOGZjMzQyY2ZkIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2J1cy9taGkvcGNpX2dlbmVyaWMuYwo+PiArKysgYi9kcml2ZXJzL2J1cy9taGkvcGNpX2dl
bmVyaWMuYwo+PiBAQCAtMzY2LDYgKzM2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWhpX3Bj
aV9kZXZfaW5mbyBtaGlfZm94Y29ubl9zZHg1NV9pbmZvID0gewo+PiAgCS5jb25maWcgPSAmbW9k
ZW1fZm94Y29ubl9zZHg1NV9jb25maWcsCj4+ICAJLmJhcl9udW0gPSBNSElfUENJX0RFRkFVTFRf
QkFSX05VTSwKPj4gIAkuZG1hX2RhdGFfd2lkdGggPSAzMiwKPj4gKwkubXJ1X2RlZmF1bHQgPSAz
Mjc2OCwKPj4gIAkuc2lkZWJhbmRfd2FrZSA9IGZhbHNlLAo+PiAgfTsKPj4gIAo+PiAtLSAKPj4g
Mi4yNS4xCj4+IAo=
