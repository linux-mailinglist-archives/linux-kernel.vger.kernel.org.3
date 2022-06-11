Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB25547215
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbiFKEqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347541AbiFKEqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:46:50 -0400
Received: from out0-138.mail.aliyun.com (out0-138.mail.aliyun.com [140.205.0.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D3719E1;
        Fri, 10 Jun 2022 21:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1654922803; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        bh=QTu5c2AsKOp6O4fWUnSs1v4gHqsCVklvaNllZ7AbTYI=;
        b=i+8/E59a3TELE0fLZsavCKoN6pSlIfGhQEDu2po/PbHBNJYsDdvtvbE1WFQ2789ts47IIs/TBE+BGLUjyar/0XvyYx+hEuPMERtdX0cehaC+1AM6JUw9NiVuQC/K4LPIVzkO39M3widePjZpUSI53mCrV7IEnoBPIxlbuad729U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=zhaowuyun.zwy@alibaba-inc.com;NM=1;PH=DW;RN=5;SR=0;TI=W4_0.1.30_v5ForWebDing_212543F5_1654922517723_o7001c314;
Received: from WS-web (zhaowuyun.zwy@alibaba-inc.com[W4_0.1.30_v5ForWebDing_212543F5_1654922517723_o7001c314]) by ay29a011140100218.et135 at Sat, 11 Jun 2022 12:46:42 +0800
Date:   Sat, 11 Jun 2022 12:46:42 +0800
From:   "=?UTF-8?B?6LW15q2m5LqR?=" <zhaowuyun.zwy@alibaba-inc.com>
To:     "axboe" <axboe@kernel.dk>, "jejb" <jejb@linux.vnet.ibm.com>,
        "martin.petersen" <martin.petersen@oracle.com>
Cc:     "linux-block" <linux-block@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?6LW15q2m5LqR?=" <zhaowuyun.zwy@alibaba-inc.com>
Message-ID: <4a2754ad-d76d-482f-9337-5364d46cd38d.zhaowuyun.zwy@alibaba-inc.com>
Subject: =?UTF-8?B?W1BBVENIXSBibG9jazogcGVlayBQTSByZXF1ZXN0cyBkdXJpbmcgcnVudGltZSBQTQ==?=
X-Mailer: [Alimail-Mailagent revision 5][W4_0.1.30][v5ForWebDing][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_0.1.30_v5ForWebDing_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMi4wLjUwMDUuNjEgU2FmYXJpLzUzNy4zNg==vN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWmhhbyBXdXl1biA8emhhb3d1eXVuLnp3eUBhbGliYWJhLWluYy5jb20+CgpxdWV1ZSBi
bG9ja2VkIGR1cmluZyBydW50aW1lIFBNIHdoZW4gYXQgdGhlIGZvbGxvd2luZyBzaXR1YXRpb246
Cgpwcm9jZXNzIEE6CiAgICBydW50aW1lIHN1c3BlbmQgcnVuIGFuZCBzZXQgdGhlIFBNIHN0YXR1
cyB0byBSUE1fU1VTUEVORElORwogICAgdGhlbiBydW4gcmVxIHdpdGggUlFGX1BNIHdpdGggYmxr
X2V4ZWN1dGVfcnEocmVxLT5xLCBOVUxMLCByZXEsIDEpCiAgICB0aGVuIHRoZSByZXEgcXVldWVk
IHRvIGhlYWQKICAgIGl0IGlzIG5vdCBleGVjdXRlZCB3aGVuIHRoZSBkcml2ZXIgaXMgYnVzeQoK
cHJvY2VzcyBCOgogICAgbm9ybWFsIGRldmljZSBtYW5hZ2VtZW50IG9wZXJhdGlvbgogICAgcnVu
IHJlcSB3aXRoIG5vIFJRRl9QTSB3aXRoIGJsa19leGVjdXRlX3JxKHJlcS0+cSwgTlVMTCwgcmVx
LCAxKQogICAgdGhlIHRoZSByZXEgaXMgcXVldWVkIGluIGZyb250IG9mIHRoZSBSUUZfUE0gcmVx
IG9mIHByb2Nlc3MgQQogICAgX19ibGtfcnVuX3F1ZXVlIHN0aWxsIG5vdCBydW4KCmJlY2F1c2Ug
dGhlIGZpcnN0IHJlcSBpcyBub24gUlFGX1BNIHJlcSBhbmQgd2l0aCBSUUZfU09GVEJBUlJJRVIs
CnNvIHRoZSBxdWV1ZSBpcyB0b3RhbGx5IGJsb2NrZWQgd2hlbiBhdCBSUE1fU1VTUEVORElORyBz
dGF0dXMuCgpzZWUgdGhlIGZvbGxvd2luZyB0YXNrIGNhbGx0cmFjZToKCnByb2Nlc3MgQToKICAg
IFs8ZmZmZmZmOWQ4N2U4NjE1MD5dIF9fc3dpdGNoX3RvKzB4MTBjCiAgICBbPGZmZmZmZjlkODhl
ZDhhYjA+XSBfX3NjaGVkdWxlKzB4NjcwCiAgICBbPGZmZmZmZjlkODhlZDhkMTg+XSBzY2hlZHVs
ZSsweDc0CiAgICBbPGZmZmZmZjlkODhlZGM4ZjQ+XSBzY2hlZHVsZV90aW1lb3V0KzB4MzI4CiAg
ICBbPGZmZmZmZjlkODhlZDkxMzA+XSBpb19zY2hlZHVsZV90aW1lb3V0KzB4MjQKICAgIFs8ZmZm
ZmZmOWQ4OGVkOWIxMD5dIHdhaXRfZm9yX2NvbW1vbl9pbysweDkwCiAgICBbPGZmZmZmZjlkODhl
ZDliYjQ+XSB3YWl0X2Zvcl9jb21wbGV0aW9uX2lvX3RpbWVvdXQrMHgyNAogICAgWzxmZmZmZmY5
ZDg4MjllMWUwPl0gYmxrX2V4ZWN1dGVfcnErMHg4OAogICAgWzxmZmZmZmY5ZDg4NTliM2E0Pl0g
c2NzaV9leGVjdXRlKzB4MTE0CiAgICBbPGZmZmZmZjlkODg1YzQwNzA+XSBzZF9zeW5jX2NhY2hl
KzB4ZmMKICAgIFs8ZmZmZmZmOWQ4ODVjNDM5Yz5dIHNkX3N1c3BlbmRfY29tbW9uKzB4NTgKICAg
IFs8ZmZmZmZmOWQ4ODVjNDMzOD5dIHNkX3N1c3BlbmRfcnVudGltZSsweDIwCiAgICBbPGZmZmZm
ZjlkODg1YTczY2M+XSBzY3NpX3J1bnRpbWVfc3VzcGVuZCsweDcwCiAgICBbPGZmZmZmZjlkODg1
MzQxZTg+XSBfX3JwbV9jYWxsYmFjaysweGNjCiAgICBbPGZmZmZmZjlkODg1MzQwZTg+XSBycG1f
Y2FsbGJhY2srMHg1YwogICAgWzxmZmZmZmY5ZDg4NTMyMTM0Pl0gcnBtX3N1c3BlbmQrMHgxZTgK
ICAgIFs8ZmZmZmZmOWQ4ODUzM2IyOD5dIHBtX3J1bnRpbWVfd29yaysweDdjCiAgICBbPGZmZmZm
ZjlkODdlZDMxZDQ+XSBwcm9jZXNzX29uZV93b3JrKzB4MWJjCiAgICBbPGZmZmZmZjlkODdlZDM2
Njg+XSB3b3JrZXJfdGhyZWFkKzB4MjE0CiAgICBbPGZmZmZmZjlkODdlZDgzOWM+XSBrdGhyZWFk
KzB4MTFjCiAgICBbPGZmZmZmZjlkODdlODRmY2M+XSByZXRfZnJvbV9mb3JrKzB4MTAKCnByb2Nl
c3MgQjoKICAgIFs8ZmZmZmZmOWQ4N2U4NjE1MD5dIF9fc3dpdGNoX3RvKzB4MTBjCiAgICBbPGZm
ZmZmZjlkODhlZDhhYjA+XSBfX3NjaGVkdWxlKzB4NjcwCiAgICBbPGZmZmZmZjlkODhlZDhkMTg+
XSBzY2hlZHVsZSsweDc0CiAgICBbPGZmZmZmZjlkODhlZGM4ZjQ+XSBzY2hlZHVsZV90aW1lb3V0
KzB4MzI4CiAgICBbPGZmZmZmZjlkODhlZDkxMzA+XSBpb19zY2hlZHVsZV90aW1lb3V0KzB4MjQK
ICAgIFs8ZmZmZmZmOWQ4OGVkOWIxMD5dIHdhaXRfZm9yX2NvbW1vbl9pbysweDkwCiAgICBbPGZm
ZmZmZjlkODhlZDliYjQ+XSB3YWl0X2Zvcl9jb21wbGV0aW9uX2lvX3RpbWVvdXQrMHgyNAogICAg
WzxmZmZmZmY5ZDg4MjllMWUwPl0gYmxrX2V4ZWN1dGVfcnErMHg4OAogICAgWzxmZmZmZmY5ZDg4
NTliM2E0Pl0gc2NzaV9leGVjdXRlKzB4MTE0CiAgICBbPGZmZmZmZjlkODg1OWQ4NTQ+XSBzY3Np
X3Rlc3RfdW5pdF9yZWFkeSsweDcwCiAgICBbPGZmZmZmZjlkODg1YzJmNDg+XSBzZF9jaGVja19l
dmVudHMrMHhkNAogICAgWzxmZmZmZmY5ZDg4MmFiZGU4Pl0gZGlza19jaGVja19ldmVudHMrMHg1
OAogICAgWzxmZmZmZmY5ZDg4MmFjYzBjPl0gZGlza19ldmVudHNfd29ya2ZuKzB4MjAKICAgIFs8
ZmZmZmZmOWQ4N2VkMzFkND5dIHByb2Nlc3Nfb25lX3dvcmsrMHgxYmMKICAgIFs8ZmZmZmZmOWQ4
N2VkMzY2OD5dIHdvcmtlcl90aHJlYWQrMHgyMTQKICAgIFs8ZmZmZmZmOWQ4N2VkODM5Yz5dIGt0
aHJlYWQrMHgxMWMKICAgIFs8ZmZmZmZmOWQ4N2U4NGZjYz5dIHJldF9mcm9tX2ZvcmsrMHgxMAoK
U2lnbmVkLW9mZi1ieTogWmhhbyBXdXl1biA8emhhb3d1eXVuLnp3eUBhbGliYWJhLWluYy5jb20+
Ci0tLQogYmxvY2svYmxrLWNvcmUuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNvcmUuYyBiL2Jsb2NrL2Jsay1j
b3JlLmMKaW5kZXggYTMzNzc1Y2Q5N2JlLi44YjkyNzJiZmRjMDkgMTAwNjQ0Ci0tLSBhL2Jsb2Nr
L2Jsay1jb3JlLmMKKysrIGIvYmxvY2svYmxrLWNvcmUuYwpAQCAtMjg1Niw2ICsyODU2LDE1IEBA
IHN0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqZWx2X25leHRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9x
dWV1ZSAqcSkKIAkJCWlmIChibGtfcG1fYWxsb3dfcmVxdWVzdChycSkpCiAJCQkJcmV0dXJuIHJx
OwogCisJCQkvKgorCQkJICogbGV0IHRoZSBQTSByZXF1ZXN0IHJ1biwKKwkJCSAqIG9yIHRoZSBx
dWV1ZSBtYXkgYmUgYmxvY2tlZCBieSB0aGUgbm9uLVBNIHJlcXVlc3QKKwkJCSAqIHdpdGggUlFG
X1NPRlRCQVJSSUVSIGZvcmV2ZXIgd2hpbGUgZG9pbmcgcnVudGltZSBQTS4KKwkJCSAqLworCQkJ
aWYgKHEtPnJwbV9zdGF0dXMgPT0gUlBNX1NVU1BFTkRJTkcKKwkJCQkJCXx8IHEtPnJwbV9zdGF0
dXMgPT0gUlBNX1JFU1VNSU5HKQorCQkJCWNvbnRpbnVlOworCiAJCQlpZiAocnEtPnJxX2ZsYWdz
ICYgUlFGX1NPRlRCQVJSSUVSKQogCQkJCWJyZWFrOwogCQl9Ci0tIAoyLjMyLjEgKEFwcGxlIEdp
dC0xMzMpCgoKCgoK
