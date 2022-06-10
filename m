Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB2B546110
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbiFJJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346754AbiFJJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:07:28 -0400
Received: from out0-151.mail.aliyun.com (out0-151.mail.aliyun.com [140.205.0.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1E27E464;
        Fri, 10 Jun 2022 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1654852008; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        bh=e6YItSYSvR2X0RI4hmCMDtqJZC08EPzkVeRsalHStFU=;
        b=f/G9YoMhuId38ijqLTqa4r3FpN1iz7bRYw7BOan19fEbOFZe1QQiiDYrWL1AgnNyxIEQpC/HkS1NA1TWbWgfKJNqwZVgdO1NAzrGaj+b0sGc+h0kZZiEyaMFgmmCQ7rAqQoWHBgt6ERam97lkUV/odb13IAFGeMW5IONrGD6lhE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=zhaowuyun.zwy@alibaba-inc.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.1.30_v5ForWebDing_2126A81F_1654851901386_o7001c428;
Received: from WS-web (zhaowuyun.zwy@alibaba-inc.com[W4_0.1.30_v5ForWebDing_2126A81F_1654851901386_o7001c428]) by ay29a011140100180.et135 at Fri, 10 Jun 2022 17:06:48 +0800
Date:   Fri, 10 Jun 2022 17:06:48 +0800
From:   "=?UTF-8?B?6LW15q2m5LqR?=" <zhaowuyun.zwy@alibaba-inc.com>
To:     "axboe" <axboe@kernel.dk>
Cc:     "linux-block" <linux-block@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "zhaowuyun.zwy" <zhaowuyun.zwy@alibaba-inc.com>
Reply-To: "=?UTF-8?B?6LW15q2m5LqR?=" <zhaowuyun.zwy@alibaba-inc.com>
Message-ID: <fd0ee676-4083-4b89-a58a-429d74fb2d33.zhaowuyun.zwy@alibaba-inc.com>
Subject: =?UTF-8?B?W1BBVENIXSBibG9jazogcGVlayBQTSByZXF1ZXN0cyBkdXJpbmcgcnVudGltZSBQTQ==?=
X-Mailer: [Alimail-Mailagent revision 5][W4_0.1.30][v5ForWebDing][Safari]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_0.1.30_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE1LjIgU2FmYXJpLzYwNS4xLjE1La
Content-Type: multipart/mixed;
  boundary="----=ALIBOUNDARY_75069_7f504c844700_62a309a8_23b95d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=ALIBOUNDARY_75069_7f504c844700_62a309a8_23b95d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgSmVucywKCnBsZWFzZSBjaGVjayB0aGlzIHBhdGNoIGZvciA0LjE5IGluIHRoZSBhdHRhY2ht
ZW50LgpiZWNhdXNlIGkgY2FuIG5vdCB1c2UgZ2l0IHNlbmQtZW1haWwgd2l0aCBlbWFpbCBvZiBv
dXIgY29tcGFueSwgc28gaSBzZW5kIGF0dGFjaG1lbnQuCgoKCg==
------=ALIBOUNDARY_75069_7f504c844700_62a309a8_23b95d
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="=?UTF-8?B?MDAwMS1ibG9jay1wZWVrLVBNLXJlcXVlc3RzLWR1cmluZy1ydW50aW1lLVBNLnBhdGNo?="
Content-Transfer-Encoding: base64

RnJvbSBjNDczM2M3MTY2YjdlNjk2YmE1YzZmNGI3OGUxMGQ0MDkzNmFlYzA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFvIFd1eXVuIDx6aGFvd3V5dW4uend5QGFsaWJhYmEtaW5j
LmNvbT4KRGF0ZTogRnJpLCAxMCBKdW4gMjAyMiAxNjowMTo0MyArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIGJsb2NrOiBwZWVrIFBNIHJlcXVlc3RzIGR1cmluZyBydW50aW1lIFBNCgpxdWV1ZSBibG9j
a2VkIGR1cmluZyBydW50aW1lIFBNIHdoZW4gYXQgdGhlIGZvbGxvd2luZyBzaXR1YXRpb246Cgpw
cm9jZXNzIEE6CiAgICBydW50aW1lIHN1c3BlbmQgcnVuIGFuZCBzZXQgdGhlIFBNIHN0YXR1cyB0
byBSUE1fU1VTUEVORElORwogICAgdGhlbiBydW4gcmVxIHdpdGggUlFGX1BNIHdpdGggYmxrX2V4
ZWN1dGVfcnEocmVxLT5xLCBOVUxMLCByZXEsIDEpCiAgICB0aGVuIHRoZSByZXEgcXVldWVkIHRv
IGhlYWQKICAgIGl0IGlzIG5vdCBleGVjdXRlZCB3aGVuIHRoZSBkcml2ZXIgaXMgYnVzeQoKcHJv
Y2VzcyBCOgogICAgbm9ybWFsIGRldmljZSBtYW5hZ2VtZW50IG9wZXJhdGlvbgogICAgcnVuIHJl
cSB3aXRoIG5vIFJRRl9QTSB3aXRoIGJsa19leGVjdXRlX3JxKHJlcS0+cSwgTlVMTCwgcmVxLCAx
KQogICAgdGhlIHRoZSByZXEgaXMgcXVldWVkIGluIGZyb250IG9mIHRoZSBSUUZfUE0gcmVxIG9m
IHByb2Nlc3MgQQogICAgX19ibGtfcnVuX3F1ZXVlIHN0aWxsIG5vdCBydW4KCmJlY2F1c2UgdGhl
IGZpcnN0IHJlcSBpcyBub24gUlFGX1BNIHJlcSBhbmQgd2l0aCBSUUZfU09GVEJBUlJJRVIsCnNv
IHRoZSBxdWV1ZSBpcyB0b3RhbGx5IGJsb2NrZWQgd2hlbiBhdCBSUE1fU1VTUEVORElORyBzdGF0
dXMuCgpzZWUgdGhlIGZvbGxvd2luZyB0YXNrIGNhbGx0cmFjZToKCnByb2Nlc3MgQToKICAgIFs8
ZmZmZmZmOWQ4N2U4NjE1MD5dIF9fc3dpdGNoX3RvKzB4MTBjCiAgICBbPGZmZmZmZjlkODhlZDhh
YjA+XSBfX3NjaGVkdWxlKzB4NjcwCiAgICBbPGZmZmZmZjlkODhlZDhkMTg+XSBzY2hlZHVsZSsw
eDc0CiAgICBbPGZmZmZmZjlkODhlZGM4ZjQ+XSBzY2hlZHVsZV90aW1lb3V0KzB4MzI4CiAgICBb
PGZmZmZmZjlkODhlZDkxMzA+XSBpb19zY2hlZHVsZV90aW1lb3V0KzB4MjQKICAgIFs8ZmZmZmZm
OWQ4OGVkOWIxMD5dIHdhaXRfZm9yX2NvbW1vbl9pbysweDkwCiAgICBbPGZmZmZmZjlkODhlZDli
YjQ+XSB3YWl0X2Zvcl9jb21wbGV0aW9uX2lvX3RpbWVvdXQrMHgyNAogICAgWzxmZmZmZmY5ZDg4
MjllMWUwPl0gYmxrX2V4ZWN1dGVfcnErMHg4OAogICAgWzxmZmZmZmY5ZDg4NTliM2E0Pl0gc2Nz
aV9leGVjdXRlKzB4MTE0CiAgICBbPGZmZmZmZjlkODg1YzQwNzA+XSBzZF9zeW5jX2NhY2hlKzB4
ZmMKICAgIFs8ZmZmZmZmOWQ4ODVjNDM5Yz5dIHNkX3N1c3BlbmRfY29tbW9uKzB4NTgKICAgIFs8
ZmZmZmZmOWQ4ODVjNDMzOD5dIHNkX3N1c3BlbmRfcnVudGltZSsweDIwCiAgICBbPGZmZmZmZjlk
ODg1YTczY2M+XSBzY3NpX3J1bnRpbWVfc3VzcGVuZCsweDcwCiAgICBbPGZmZmZmZjlkODg1MzQx
ZTg+XSBfX3JwbV9jYWxsYmFjaysweGNjCiAgICBbPGZmZmZmZjlkODg1MzQwZTg+XSBycG1fY2Fs
bGJhY2srMHg1YwogICAgWzxmZmZmZmY5ZDg4NTMyMTM0Pl0gcnBtX3N1c3BlbmQrMHgxZTgKICAg
IFs8ZmZmZmZmOWQ4ODUzM2IyOD5dIHBtX3J1bnRpbWVfd29yaysweDdjCiAgICBbPGZmZmZmZjlk
ODdlZDMxZDQ+XSBwcm9jZXNzX29uZV93b3JrKzB4MWJjCiAgICBbPGZmZmZmZjlkODdlZDM2Njg+
XSB3b3JrZXJfdGhyZWFkKzB4MjE0CiAgICBbPGZmZmZmZjlkODdlZDgzOWM+XSBrdGhyZWFkKzB4
MTFjCiAgICBbPGZmZmZmZjlkODdlODRmY2M+XSByZXRfZnJvbV9mb3JrKzB4MTAKCnByb2Nlc3Mg
QjoKICAgIFs8ZmZmZmZmOWQ4N2U4NjE1MD5dIF9fc3dpdGNoX3RvKzB4MTBjCiAgICBbPGZmZmZm
ZjlkODhlZDhhYjA+XSBfX3NjaGVkdWxlKzB4NjcwCiAgICBbPGZmZmZmZjlkODhlZDhkMTg+XSBz
Y2hlZHVsZSsweDc0CiAgICBbPGZmZmZmZjlkODhlZGM4ZjQ+XSBzY2hlZHVsZV90aW1lb3V0KzB4
MzI4CiAgICBbPGZmZmZmZjlkODhlZDkxMzA+XSBpb19zY2hlZHVsZV90aW1lb3V0KzB4MjQKICAg
IFs8ZmZmZmZmOWQ4OGVkOWIxMD5dIHdhaXRfZm9yX2NvbW1vbl9pbysweDkwCiAgICBbPGZmZmZm
ZjlkODhlZDliYjQ+XSB3YWl0X2Zvcl9jb21wbGV0aW9uX2lvX3RpbWVvdXQrMHgyNAogICAgWzxm
ZmZmZmY5ZDg4MjllMWUwPl0gYmxrX2V4ZWN1dGVfcnErMHg4OAogICAgWzxmZmZmZmY5ZDg4NTli
M2E0Pl0gc2NzaV9leGVjdXRlKzB4MTE0CiAgICBbPGZmZmZmZjlkODg1OWQ4NTQ+XSBzY3NpX3Rl
c3RfdW5pdF9yZWFkeSsweDcwCiAgICBbPGZmZmZmZjlkODg1YzJmNDg+XSBzZF9jaGVja19ldmVu
dHMrMHhkNAogICAgWzxmZmZmZmY5ZDg4MmFiZGU4Pl0gZGlza19jaGVja19ldmVudHMrMHg1OAog
ICAgWzxmZmZmZmY5ZDg4MmFjYzBjPl0gZGlza19ldmVudHNfd29ya2ZuKzB4MjAKICAgIFs8ZmZm
ZmZmOWQ4N2VkMzFkND5dIHByb2Nlc3Nfb25lX3dvcmsrMHgxYmMKICAgIFs8ZmZmZmZmOWQ4N2Vk
MzY2OD5dIHdvcmtlcl90aHJlYWQrMHgyMTQKICAgIFs8ZmZmZmZmOWQ4N2VkODM5Yz5dIGt0aHJl
YWQrMHgxMWMKICAgIFs8ZmZmZmZmOWQ4N2U4NGZjYz5dIHJldF9mcm9tX2ZvcmsrMHgxMAoKU2ln
bmVkLW9mZi1ieTogWmhhbyBXdXl1biA8emhhb3d1eXVuLnp3eUBhbGliYWJhLWluYy5jb20+Ci0t
LQogYmxvY2svYmxrLWNvcmUuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNvcmUuYyBiL2Jsb2NrL2Jsay1jb3Jl
LmMKaW5kZXggYTMzNzc1Y2Q5N2JlLi44YjkyNzJiZmRjMDkgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Js
ay1jb3JlLmMKKysrIGIvYmxvY2svYmxrLWNvcmUuYwpAQCAtMjg1Niw2ICsyODU2LDE1IEBAIHN0
YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqZWx2X25leHRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSkKIAkJCWlmIChibGtfcG1fYWxsb3dfcmVxdWVzdChycSkpCiAJCQkJcmV0dXJuIHJxOwog
CisJCQkvKgorCQkJICogbGV0IHRoZSBQTSByZXF1ZXN0IHJ1biwKKwkJCSAqIG9yIHRoZSBxdWV1
ZSBtYXkgYmUgYmxvY2tlZCBieSB0aGUgbm9uLVBNIHJlcXVlc3QKKwkJCSAqIHdpdGggUlFGX1NP
RlRCQVJSSUVSIGZvcmV2ZXIgd2hpbGUgZG9pbmcgcnVudGltZSBQTS4KKwkJCSAqLworCQkJaWYg
KHEtPnJwbV9zdGF0dXMgPT0gUlBNX1NVU1BFTkRJTkcKKwkJCQkJCXx8IHEtPnJwbV9zdGF0dXMg
PT0gUlBNX1JFU1VNSU5HKQorCQkJCWNvbnRpbnVlOworCiAJCQlpZiAocnEtPnJxX2ZsYWdzICYg
UlFGX1NPRlRCQVJSSUVSKQogCQkJCWJyZWFrOwogCQl9Ci0tIAoyLjMyLjEgKEFwcGxlIEdpdC0x
MzMpCgo=

------=ALIBOUNDARY_75069_7f504c844700_62a309a8_23b95d--

