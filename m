Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912447210D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhLMG1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:27:32 -0500
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233]:45152 "EHLO
        out203-205-221-233.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232176AbhLMG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:27:31 -0500
X-Greylist: delayed 51215 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 01:27:30 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639376849;
        bh=0Q6VnTr5SGW3kzpVwfmAO+56hCYf2WTdqo4y/9exOXk=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=GbOK4gqMF5wn1NLzIxjiJthDp4dQB96fpNygSnOEzUBlcaKBkwBCRyeWGhHsdvNSM
         seLI1F2tjnpZf6vq5hKBVgIKEH53RkfNMwKHfEHhqn29k2y7PT0SOa0RD4i1iDZALj
         p8jrkxWdb3svpqTYw2Y4lSdUNT7PxSfvOYymGAvw=
X-QQ-FEAT: oHWrrGTW1dB69m49duS3mdhuyhfj4A9h
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: NitsDAv9uCbJ1ysSWxVlFuoEitg2Y/gWkgppySOi8GZutLDNjbqp0RUjiuiK6y
         H+aA5Ne4G2rOlX0ZqjXE0qn55G/t/RJo7S+DKnpKp05MKLoj/y3Fu+ANXlTwwjhrVM91Z6tgWixml
         N5t4jQ0UlixUQfdKCVloh1lALwWr/p/WNosfgh7Xrr397ejz2SWu+TNUM0ffYV2Sfj5BmzbiOUwEz
         XJ7mcPf2k01LzbHXQtdZM3u7Q2ZGpfW2nkftUe2TQKWNyiJzh+hfpxw3vLP1LygW9qxjzO75R9Xg2
         ZopRI7MlTE+aK/KTn+9Mk4vuVjTFUjQlZvvLCe92hS8GT1lRur/L4fryE6AIRvw4I+QDBbeWrm+mJ
         xKL+g3PvDvFeljnCSn/oop26ca+49FAwzk4mykl2MMGKBPz7TSwtiygBXVV9EPQPFjtnYthol8dDS
         sYjw2UM4lKwJdryzZfJKB+JBcNBvZ4Se6rf1GXfsM6MMPe2h9NCV2saYvzjPBhuKiPy+YqYPk+HLW
         nBozc3So4svd/Bjr+wdQBkBOI3ocdL9QtxlwzF8VJvA0WlcbhzffFIUk/VmJeDz/nRYKf1W56xJcg
         /JFK3F5+v4IHp7QppBFp42FIJaf1wMN83aXqhmIWf9EANO9Ws/uGnusoOsUFg77zr/Z5UhrFa9rnx
         Mnsk0g1wLiIQAUvTG1YjgmPLqkwvZmnNAhhrzZ2lK7ile6Zww+7zV41uNVkrmxea2Et7dXZOBtzPq
         L3AEvuk00Aip+DfUPAaYKRBzO65zAwb35kwBXsNP0n9sbamBVRJI+SkARIcRrtOT/iyV36ga7R+xJ
         6u8x9iGoZv1CD+mSBo4lnPxYiKu8h7IOppfV0o+ngdMJPVOiiXNcyAo=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.75.155.17
In-Reply-To: <Ybbj470ocCf7bj68@kroah.com>
References: <tencent_1AB342AE1B4723454E78A4D2FD3F33C81306@qq.com>
        <Ybbj470ocCf7bj68@kroah.com>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1639376848t6984519
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc:     "=?ISO-8859-1?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?ISO-8859-1?B?YW5kcmVhcy5ub2V2ZXI=?=" <andreas.noever@gmail.com>,
        "=?ISO-8859-1?B?bWljaGFlbC5qYW1ldA==?=" <michael.jamet@intel.com>,
        "=?ISO-8859-1?B?bWlrYS53ZXN0ZXJiZXJn?=" 
        <mika.westerberg@linux.intel.com>,
        "=?ISO-8859-1?B?WWVoZXprZWxTaEI=?=" <YehezkelShB@gmail.com>
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Mon, 13 Dec 2021 14:27:28 +0800
X-Priority: 3
Message-ID: <tencent_D34525AAFF71905A66815C118E0E8A96F007@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBEZWMgMTMsIDIwMjEgMDI6MTAgUE0sIEdyZWcgS0ggd3JvdGU6Cj4ga21lbWR1
cCgpIHJldHVybiBOVUxMIHdoZW4gc29tZSBpbnRlcm5hbCBtZW1vcnkgZXJyb3JzIGhhcHBl
biwgaXQgaXMKPiBiZXR0ZXIgdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiBpdC4gT3Ro
ZXJ3aXNlLCBzb21lIG1lbW9yeSBlcnJvcnMKPiB3aWxsIG5vdCBiZSBjYXRjaGVkIGluIHRp
bWUgYW5kIG1heSBmdXJ0aGVyIHJlc3VsdCBpbiB3cm9uZyBtZW1vcnk+IGFjY2Vzcy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiB4a2VybmVsIDx4a2VybmVsLndhbmdAZm94bWFpbC5jb20+Cj4K
PiBQbGVhc2UgdXNlIHlvdXIgImZ1bGwiIG5hbWUsIEkgZG91YnQgeW91IHNpZ24gZG9jdW1l
bnRzIGFzICJ4a2VybmVsIi4gOikKPgo+IHRoYW5rcywKPgo+IGdyZWcgay1oCgpJIGFtIHZl
cnkgc29ycnkgYWJvdXQgdGhhdCwgbXkgZnVsbCBuYW1lIGlzICJYaWFva2UgV2FuZyIu

