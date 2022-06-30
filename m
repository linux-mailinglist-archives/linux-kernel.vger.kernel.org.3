Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5C560E97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiF3BHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiF3BHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:07:38 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE4275D9;
        Wed, 29 Jun 2022 18:07:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.1.30_DEFAULT_21283DCF_1656550646787_o7001c510;
Received: from WS-web (liusong@linux.alibaba.com[W4_0.1.30_DEFAULT_21283DCF_1656550646787_o7001c510]) at Thu, 30 Jun 2022 09:07:32 +0800
Date:   Thu, 30 Jun 2022 09:07:32 +0800
From:   "liusong" <liusong@linux.alibaba.com>
To:     "axboe" <axboe@kernel.dk>, "Bart Van Assche" <bvanassche@acm.org>
Cc:     "linux-block" <linux-block@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "liusong" <liusong@linux.alibaba.com>
Message-ID: <aa888597-e905-40a6-89da-5341e2af44b3.liusong@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYmxrLW1xOiBzZXQgQkxLX01RX1NfU1RPUFBFRCBmaXJzdCB0byBhdm9p?=
  =?UTF-8?B?ZCB1bmV4cGVjdGVkIHF1ZXVlIHdvcms=?=
X-Mailer: [Alimail-Mailagent revision 5][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1656479900-58719-1-git-send-email-liusong@linux.alibaba.com>,<28db81c5-27d3-7b83-5021-4507b4dd118a@acm.org>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMi4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <28db81c5-27d3-7b83-5021-4507b4dd118a@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDYvMjgvMjIgMjI6MTgsIExpdSBTb25nIHdyb3RlOgo+PiBGcm9tOiBMaXUgU29uZyA8bGl1
c29uZ0BsaW51eC5hbGliYWJhLmNvbT4KPj4KPj4gSW4gIl9fYmxrX21xX2RlbGF5X3J1bl9od19x
dWV1ZSIsIEJMS19NUV9TX1NUT1BQRUQgaXMgY2hlY2tlZCBmaXJzdCwKPj4gYW5kIHRoZW4gcXVl
dWUgd29yaywgYnV0IGluICJibGtfbXFfc3RvcF9od19xdWV1ZSIsIGV4ZWN1dGUgY2FuY2VsCj4+
IHdvcmsgZmlyc3QgYW5kIHRoZW4gc2V0IEJMS19NUV9TX1NUT1BQRUQsIHNvIHRoZXJlIGlzIGEg
cmlzayBvZgo+PiBxdWV1ZSB3b3JrIGFmdGVyIHNldHRpbmcgQkxLX01RX1NfU1RPUFBFRCwgd2hp
Y2ggY2FuIGJlIHNvbHZlZCBieQo+PiBhZGp1c3RpbmcgdGhlIG9yZGVyLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBMaXUgU29uZyA8bGl1c29uZ0BsaW51eC5hbGliYWJhLmNvbT4KPj4gLS0tCj4+ICAg
YmxvY2svYmxrLW1xLmMgfCA0ICsrLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9i
bG9jay9ibGstbXEuYwo+PiBpbmRleCA5M2Q5ZDYwLi44NjU5MTVlIDEwMDY0NAo+PiAtLS0gYS9i
bG9jay9ibGstbXEuYwo+PiArKysgYi9ibG9jay9ibGstbXEuYwo+PiBAQCAtMjI1OCw5ICsyMjU4
LDkgQEAgYm9vbCBibGtfbXFfcXVldWVfc3RvcHBlZChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkK
Pj4gICAgKi8KPj4gICB2b2lkIGJsa19tcV9zdG9wX2h3X3F1ZXVlKHN0cnVjdCBibGtfbXFfaHdf
Y3R4ICpoY3R4KQo+PiAgIHsKPj4gLSBjYW5jZWxfZGVsYXllZF93b3JrKCZoY3R4LT5ydW5fd29y
ayk7Cj4+IC0KPj4gICAgc2V0X2JpdChCTEtfTVFfU19TVE9QUEVELCAmaGN0eC0+c3RhdGUpOwo+
PiArCj4+ICsgY2FuY2VsX2RlbGF5ZWRfd29yaygmaGN0eC0+cnVuX3dvcmspOwo+PiAgIH0KPj4g
ICBFWFBPUlRfU1lNQk9MKGJsa19tcV9zdG9wX2h3X3F1ZXVlKTsKPgo+V2hhdCBtYWRlIHlvdSBj
b21lIHVwIHdpdGggdGhpcyBwYXRjaD8gU291cmNlIGNvZGUgcmVhZGluZyBvciBzb21ldGhpbmcK
PmVsc2U/IFBsZWFzZSBtZW50aW9uIHRoaXMgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uLgoKSGks
CgpJIGZvdW5kIHRoaXMgYnkgc291cmNlIGNvZGUgcmVhZGluZy4KSXQgaXMgdHJ1ZSB0aGF0ICJi
bGtfbXFfc3RvcF9od19xdWV1ZSIgZG9lcyBub3QgZ3VhcmFudGVlIGFueSBkaXNwYXRjaCB3aWxs
IGJlIGJsb2NrZWQsCmJ1dCBJIHRoaW5rICJibGtfbXFfc3RvcF9od19xdWV1ZSIgYW5kICJfX2Js
a19tcV9kZWxheV9ydW5faHdfcXVldWUiIGhhdmUgYSByZXZlcnNlCm9yZGVyIGluIHRoZSBwcm9j
ZXNzaW5nIGxvZ2ljIG9mICJCTEtfTVFfU19TVE9QUEVEIi4KUGFydCBvZiB0aGUgcmFjZSBwcm9i
bGVtIGNhbiBiZSBzb2x2ZWQgb25seSBieSBhZGp1c3RpbmcgdGhlIGp1ZGdtZW50IG9yZGVyLCBz
byBpdCBpcyBzdGlsbCB2YWx1YWJsZS4KClRoYW5rcwoKPgo+UmVnYXJkaW5nIHRoZSBhYm92ZSBw
YXRjaCwgSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIGZpeGVzIHRoZSBleGlzdGluZwo+cmFjZSBi
ZXR3ZWVuIGJsa19tcV9zdG9wX2h3X3F1ZXVlKCkgYW5kIF9fYmxrX21xX2RlbGF5X3J1bl9od19x
dWV1ZSgpLAo+bm90IGV2ZW4gaWYgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgd291bGQgYmUg
dXNlZC4KPgo+VGhlIGNvbW1lbnQgYmxvY2sgYWJvdmUgYmxrX21xX3N0b3BfaHdfcXVldWUoKSBj
bGVhcmx5IG1lbnRpb25zIHRoYXQgaXQKPmlzIG5vdCBndWFyYW50ZWVkIHRoYXQgdGhpcyBmdW5j
dGlvbiBzdG9wcyBkaXNwYXRjaGluZyBvZiByZXF1ZXN0cwo+aW1tZWRpYXRlbHkuIFNvIHdoeSBi
b3RoZXIgYWJvdXQgZml4aW5nIHRoZSBleGlzdGluZyByYWNlIGNvbmRpdGlvbnMgdGhhdAo+ZG8g
bm90IGFmZmVjdCB3aGF0IGlzIGd1YXJhbnRlZWQgYnkgYmxrX21xX3N0b3BfaHdfcXVldWUoKT8K
Pgo+VGhhbmtzLAo+Cj5CYXJ0Lg==
