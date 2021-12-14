Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5977A4746D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhLNPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:51:22 -0500
Received: from out203-205-221-192.mail.qq.com ([203.205.221.192]:39638 "EHLO
        out203-205-221-192.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbhLNPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:51:21 -0500
X-Greylist: delayed 104307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 10:51:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639497076;
        bh=Y7I+DhADi4wXreZEiHsEexSJLft7Hw7ifujt/mt7TXI=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=X6Qay0Hbgx9IDkyPFD+akm3lSNGEQH+Qb+4Nm5rAIC60ia8FgRQdfgRveaOtDfhLx
         kNYZtUxynmoHYNw9J4+1/dO9zVxdLZLkk2/90g3ivo3HNalqM9avMQ1vFRl3RSjMal
         6l8bJlUu40ZLBzXsouuxNLj93lFdTkM2zeZOggUU=
X-QQ-FEAT: oHWrrGTW1dDQiAipz2ZtDt0sp8RnsZZi
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMAILINFO: NcD/h+zV4Bs9Hya2zZ0mBqtu8DhkiotZboDLaKcUOOrrmcAmcdZdgmP/2U0S1b
         KoRn/YO3XULjGBlgPw9dt7wdg4pS4rQjeC8bl2401RjBYjX63C6mPJUGmMWaDYYbezUR2G3XqPLOD
         3S4Q0PTlqhdx/pEBC2hwRAaavF2N1xah4ZJ535ylJML6LS/lEaa3V7ogG6SQ/2TrVgh1S03Q0J2TV
         Q3+BIgoSVlNcnf6RdMdHgTwg4zlFCQ2eYc/5u1iVkEN7ap5XllxsKrlBdQkOQasaZymVIN2WdiTaD
         LR8T8FFfZgZ8fBSl2MGIkf35dOYmSRBF7XAob2ZP+jGHT/J2Zwi7v6oN+7uv2HE/BskCfOLQBLHge
         YWqr7/KUAfIjJHkjQplfkMQPW5oWbpiNt5hTI14qJ9cRVqA8zsAACRswvgr2GyrgXT6NTm8dF/YXf
         Asj0C+Fz4qUgNkcqsKNdBjNc0JkOXLp+4sjEopmG/waO9J9hDIVCRf8kcVnbxXVPErUwMquHsVu5j
         Kz450rSpakuFmdTPJVr7ZPMlI/zBTObdrh+5mZL+tH5odnOZ8HfeBhHFHY4FWPGcoM5y/BJ1gsTz3
         Ch5Yqr7eTHZVyHmtNDfEk/ezQ+F1KygsO48Giq4jVYBD1p6BHQlJ5i0PIvG+btzE/NcbVfn0mdpRm
         7VaEoAUUaZnmf7eB02loTi8vXsVz12GhmANuM030P9Y/1WBXRtlSbPIzDPTmRnBREY710Hq/N5ePB
         CFCxjiORayXqxIflhk5TyMm6YxfFz++C7Iw3aZvepWI7YGxQ7dXJgI9fVUv9ht+hMvDIUdywMIuHl
         /+rK2S+YuTrYdWdr4f30QLdX1GQ4bBBgqAO5dcCw9FfN
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.75.155.17
In-Reply-To: <20211214160334.6e493a32@coco.lan>
References: <tencent_07FF16C8253370EE140700057438B052FD06@qq.com>
        <20211214160334.6e493a32@coco.lan>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1639497075t8462544
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?TWF1cm8gQ2FydmFsaG8gQ2hlaGFi?=" 
        <mchehab+huawei@kernel.org>
Cc:     "=?ISO-8859-1?B?Y3JvcGU=?=" <crope@iki.fi>,
        "=?ISO-8859-1?B?bGludXgtbWVkaWE=?=" <linux-media@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: usb: dvb-usb-v2: check the return value of kstrdup()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Tue, 14 Dec 2021 23:51:15 +0800
X-Priority: 3
Message-ID: <tencent_E823831C300BE6E670B851B086F7294DFD0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBEZWMgMTQsIDIwMjEgMTE6MDMgUE0gKzA4MDAsIE1hdXJvIENhcnZhbGhvIENo
ZWhhYiB3cm90ZToKPj4gKyAgICAgICBpZiAoIWRldm5hbWUpCj4+ICsgICAgICAgICAgICAg
ICBkZXZfZXJyKCZkLT51ZGV2LT5kZXYsICIlczoga3N0cmR1cCgpIGZhaWxlZFxuIiwgS0JV
SUxEX01PRE5BTUUpOwo+PiArCj4gRG9uJ3QgdXNlIEtCVUlMRF9NT0ROQU1FLCBhcyBkZXZf
ZXJyIHdpbGwgYWxyZWFkeSBhZGQgdGhlIGRyaXZlci9kZXZpY2Uncwo+IG5hbWUuCgpIZXJl
IEkga25vdyBJIG5lZWQgdG8gY2hhbmdlIGl0IHRvOiBkZXZfZXJyKCZkLT51ZGV2LT5kZXYs
ICJrc3RyZHVwKCkgZmFpbGVkXG4iKTsKCj4+IC0gICAgICAgcHJfaW5mbygiJXM6ICclczol
cycgc3VjY2Vzc2Z1bGx5IGRlaW5pdGlhbGl6ZWQgYW5kIGRpc2Nvbm5lY3RlZFxuIiwKPj4g
LSAgICAgICAgICAgICAgIEtCVUlMRF9NT0ROQU1FLCBkcnZuYW1lLCBkZXZuYW1lKTsKPgo+
IEJldHRlciB0byB1c2U6Cj4gZGV2X2RiZygmZC0+dWRldi0+ZGV2LCAic3VjY2Vzc2Z1bGx5
IGRlaW5pdGlhbGl6ZWQgYW5kIGRpc2Nvbm5lY3RlZFxuIik7Cj4KPj4gLSAgICAgICBrZnJl
ZShkZXZuYW1lKTsKPiBObyBuZWVkIHRvIHBsYWNlIGtmcmVlKCkgaW5zaWRlIGFuIGlmLCBh
cyBrZnJlZShOVUxMKSBpcyBzYWZlLgoKSGVyZSBJIGtub3cgSSBuZWVkIHRvIHB1dCBrZnJl
ZSgpIGF0IHRoZSBlbmQgb2YgdGhpcyBmdW5jdGlvbi4KSG93ZXZlciwgaWYgSSByZXBsYWNl
IHRoZSBvcmlnaW5hbCBwcl9pbmZvKC4uLikgd2l0aDoKPiBkZXZfZGJnKCZkLT51ZGV2LT5k
ZXYsICJzdWNjZXNzZnVsbHkgZGVpbml0aWFsaXplZCBhbmQgZGlzY29ubmVjdGVkXG4iKTsK
VGhlbiBkZXZuYW1lIGFuZCBkcnZuYW1lIHNlZW1zIGNhbiBiZSBhbGwgcmVtb3ZlZCwgYXMg
dGhleSBhcmUgdXNlbGVzcwppbiBkdmJfdXNidjJfZGlzY29ubmVjdCgpIGFueW1vcmUuIEkg
YW0gbm90IHN1cmUgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseS4KSWYgc28sIEkgd2lsbCBq
dXN0IHJlbW92ZSB0aGVtIGFuZCBjaGFuZ2UgcHJfaW5mbygpIC0+IGRldl9kYmcoKSBpbiBu
ZXh0IAp2ZXJzaW9uLg==

