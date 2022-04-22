Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2E50ADEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443457AbiDVCpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345655AbiDVCpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:45:46 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7B4C435
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:42:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DW;RN=5;SR=0;TI=W4_0.1.30_DEFAULT_21254256_1650595228754_o7001c117k;
Received: from WS-web (cuibixuan@linux.alibaba.com[W4_0.1.30_DEFAULT_21254256_1650595228754_o7001c117k]) by ay29a033018045223.et135 at Fri, 22 Apr 2022 10:42:51 +0800
Date:   Fri, 22 Apr 2022 10:42:51 +0800
From:   "cuibixuan" <cuibixuan@linux.alibaba.com>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "rostedt" <rostedt@goodmis.org>, "mingo" <mingo@redhat.com>,
        "yi.zhang" <yi.zhang@huawei.com>, "jack" <jack@suse.cz>
Reply-To: "cuibixuan" <cuibixuan@linux.alibaba.com>
Message-ID: <df9b8f54-274d-404c-a698-c88a18849810.cuibixuan@linux.alibaba.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIC1uZXh0XSBqYmQyOiB1c2UgdGhlIGNvcnJlY3QgcHJpbnQgZm9y?=
  =?UTF-8?B?bWF0?=
X-Mailer: [Alimail-Mailagent][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>,<20220321092503.liyi6eqrar52cc5n@quack3.lan>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkwLjAuNDQzMC4yMTIgU2FmYXJpLzUzNy4zNg==vN
In-Reply-To: <20220321092503.liyi6eqrar52cc5n@quack3.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIApUaGlzIHBhdGNoIGRvZXNuJ3Qgc2VlbSB0byBiZSBtZXJnZWQgaW50byB0aGUgbmV4dCBi
cmFuY2guICA6LSkKClRoYW5rcywKQml4dWFuIEN1aQoKT24gRnJpIDE4LTAzLTIyIDIzOjU2OjQw
LCBCaXh1YW4gQ3VpIHdyb3RlOgoKPiBUaGUgcHJpbnQgZm9ybWF0IGVycm9yIHdhcyBmb3VuZCB3
aGVuIHVzaW5nIGZ0cmFjZSBldmVudDoKPiAgICAgPC4uLj4tMTQwNiBbMDAwXSAuLi4uIDIzNTk5
NDQyLjg5NTgyMzogamJkMl9lbmRfY29tbWl0OiBkZXYgMjUyLDggdHJhbnNhY3Rpb24gLTE4NjYy
MTY5NjUgc3luYyAwIGhlYWQgLTE4NjYyMTczNjgKPiAgICAgPC4uLj4tMTQwNiBbMDAwXSAuLi4u
IDIzNTk5NDQyLjg5NjI5OTogamJkMl9zdGFydF9jb21taXQ6IGRldiAyNTIsOCB0cmFuc2FjdGlv
biAtMTg2NjIxNjk2NCBzeW5jIDAKPiAKPiBQcmludCB0cmFuc2FjdGlvbiBhbmQgaGVhZCB3aXRo
IHRoZSB1bnNpZ25lZCBmb3JtYXQgIiV1IiBpbnN0ZWFkLgo+IAo+IEZpeGVzOiA4NzljNWU2Yjdj
YjQgKCdqYmQyOiBjb252ZXJ0IGluc3RydW1lbnRhdGlvbiBmcm9tIG1hcmtlcnMgdG8gdHJhY2Vw
b2ludHMnKQo+IFNpZ25lZC1vZmYtYnk6IEJpeHVhbiBDdWkgPGN1aWJpeHVhbkBsaW51eC5hbGli
YWJhLmNvbT4KCk1ha2VzIHNlbnNlLiBUaGFua3MgZm9yIHRoZSBmaXguIEZlZWwgZnJlZSB0byBh
ZGQ6CgpSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KCiAgICAgICAgSG9uemEK
Cj4gLS0tCj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL2piZDIuaCB8IDEwICsrKysrLS0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvamJkMi5oIGIvaW5jbHVkZS90cmFjZS9ldmVu
dHMvamJkMi5oCj4gaW5kZXggYTRkZmUwMDU5ODNkLi41YmUxYWExNjkxZmIgMTAwNjQ0Cj4gLS0t
IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvamJkMi5oCj4gKysrIGIvaW5jbHVkZS90cmFjZS9ldmVu
dHMvamJkMi5oCj4gQEAgLTQwLDcgKzQwLDcgQEAgREVDTEFSRV9FVkVOVF9DTEFTUyhqYmQyX2Nv
bW1pdCwKPiAgIFRQX1NUUlVDVF9fZW50cnkoCj4gICAgX19maWVsZCggZGV2X3QsIGRldiAgICkK
PiAgICBfX2ZpZWxkKCBjaGFyLCBzeW5jX2NvbW1pdCAgICApCj4gLSAgX19maWVsZCggaW50LCB0
cmFuc2FjdGlvbiAgICApCj4gKyAgX19maWVsZCggdGlkX3QsIHRyYW5zYWN0aW9uICAgICkKPiAg
ICksCj4gIAo+ICAgVFBfZmFzdF9hc3NpZ24oCj4gQEAgLTQ5LDcgKzQ5LDcgQEAgREVDTEFSRV9F
VkVOVF9DTEFTUyhqYmQyX2NvbW1pdCwKPiAgICBfX2VudHJ5LT50cmFuc2FjdGlvbiA9IGNvbW1p
dF90cmFuc2FjdGlvbi0+dF90aWQ7Cj4gICApLAo+ICAKPiAtIFRQX3ByaW50aygiZGV2ICVkLCVk
IHRyYW5zYWN0aW9uICVkIHN5bmMgJWQiLAo+ICsgVFBfcHJpbnRrKCJkZXYgJWQsJWQgdHJhbnNh
Y3Rpb24gJXUgc3luYyAlZCIsCj4gICAgICBNQUpPUihfX2VudHJ5LT5kZXYpLCBNSU5PUihfX2Vu
dHJ5LT5kZXYpLAo+ICAgICAgX19lbnRyeS0+dHJhbnNhY3Rpb24sIF9fZW50cnktPnN5bmNfY29t
bWl0KQo+ICApOwo+IEBAIC05Nyw4ICs5Nyw4IEBAIFRSQUNFX0VWRU5UKGpiZDJfZW5kX2NvbW1p
dCwKPiAgIFRQX1NUUlVDVF9fZW50cnkoCj4gICAgX19maWVsZCggZGV2X3QsIGRldiAgICkKPiAg
ICBfX2ZpZWxkKCBjaGFyLCBzeW5jX2NvbW1pdCAgICApCj4gLSAgX19maWVsZCggaW50LCB0cmFu
c2FjdGlvbiAgICApCj4gLSAgX19maWVsZCggaW50LCBoZWFkICAgICAgICkKPiArICBfX2ZpZWxk
KCB0aWRfdCwgdHJhbnNhY3Rpb24gICAgKQo+ICsgIF9fZmllbGQoIHRpZF90LCBoZWFkICAgICAg
ICkKPiAgICksCj4gIAo+ICAgVFBfZmFzdF9hc3NpZ24oCj4gQEAgLTEwOCw3ICsxMDgsNyBAQCBU
UkFDRV9FVkVOVChqYmQyX2VuZF9jb21taXQsCj4gICAgX19lbnRyeS0+aGVhZCAgPSBqb3VybmFs
LT5qX3RhaWxfc2VxdWVuY2U7Cj4gICApLAo+ICAKPiAtIFRQX3ByaW50aygiZGV2ICVkLCVkIHRy
YW5zYWN0aW9uICVkIHN5bmMgJWQgaGVhZCAlZCIsCj4gKyBUUF9wcmludGsoImRldiAlZCwlZCB0
cmFuc2FjdGlvbiAldSBzeW5jICVkIGhlYWQgJXUiLAo+ICAgICAgTUFKT1IoX19lbnRyeS0+ZGV2
KSwgTUlOT1IoX19lbnRyeS0+ZGV2KSwKPiAgICAgIF9fZW50cnktPnRyYW5zYWN0aW9uLCBfX2Vu
dHJ5LT5zeW5jX2NvbW1pdCwgX19lbnRyeS0+aGVhZCkKPiAgKTsKPiAtLSAKPiAyLjE5LjEuNi5n
YjQ4NTcxMGIKPiAKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENS
