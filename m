Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7323480723
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhL1IBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:01:07 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:60836 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhL1IBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:01:05 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 27PrnSAOfOvR027PrnKlv2; Tue, 28 Dec 2021 09:01:03 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 28 Dec 2021 09:01:03 +0100
X-ME-IP: 86.243.171.122
Content-Type: multipart/mixed; boundary="------------8QGKN0DMtEJg3SQKJpxQwPda"
Message-ID: <f1164c41-c262-0413-dd2f-cded7510b8b6@wanadoo.fr>
Date:   Tue, 28 Dec 2021 09:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org
References: <0000000000007d25ff059457342d@google.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <0000000000007d25ff059457342d@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8QGKN0DMtEJg3SQKJpxQwPda
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Hi,

(3rd try - text only format, other git repo to please syzbot - sorry for 
the noise)


first try (ok, 3rd...) to use syzbot. I hope I do it right.
Discussion about the syz report can be found at 
https://lore.kernel.org/linux-kernel/0000000000007d25ff059457342d-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org/

This patch only test if alauda_get_media_status() (and its embedded 
usb_stor_ctrl_transfer()) before using the data.
In case of error, it returns USB_STOR_TRANSPORT_ERROR as done elsewhere.

#syz test: https://github.com/google/kmsan.git master

CJ


--------------8QGKN0DMtEJg3SQKJpxQwPda
Content-Type: text/x-csrc; charset=UTF-8; name="patch_alauda.c"
Content-Disposition: attachment; filename="patch_alauda.c"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3N0b3JhZ2UvYWxhdWRhLmMgYi9kcml2ZXJzL3Vz
Yi9zdG9yYWdlL2FsYXVkYS5jCmluZGV4IDIwYjg1N2U5N2U2MC4uNmM0ODZkOTY0OTExIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3VzYi9zdG9yYWdlL2FsYXVkYS5jCisrKyBiL2RyaXZlcnMv
dXNiL3N0b3JhZ2UvYWxhdWRhLmMKQEAgLTMxOCw3ICszMTgsOCBAQCBzdGF0aWMgaW50IGFs
YXVkYV9nZXRfbWVkaWFfc3RhdHVzKHN0cnVjdCB1c19kYXRhICp1cywgdW5zaWduZWQgY2hh
ciAqZGF0YSkKIAlyYyA9IHVzYl9zdG9yX2N0cmxfdHJhbnNmZXIodXMsIHVzLT5yZWN2X2N0
cmxfcGlwZSwKIAkJY29tbWFuZCwgMHhjMCwgMCwgMSwgZGF0YSwgMik7CiAKLQl1c2Jfc3Rv
cl9kYmcodXMsICJNZWRpYSBzdGF0dXMgJTAyWCAlMDJYXG4iLCBkYXRhWzBdLCBkYXRhWzFd
KTsKKwlpZiAocmMgPT0gVVNCX1NUT1JfWEZFUl9HT09EKQorCQl1c2Jfc3Rvcl9kYmcodXMs
ICJNZWRpYSBzdGF0dXMgJTAyWCAlMDJYXG4iLCBkYXRhWzBdLCBkYXRhWzFdKTsKIAogCXJl
dHVybiByYzsKIH0KQEAgLTQ1Myw4ICs0NTQsMTEgQEAgc3RhdGljIGludCBhbGF1ZGFfY2hl
Y2tfbWVkaWEoc3RydWN0IHVzX2RhdGEgKnVzKQogewogCXN0cnVjdCBhbGF1ZGFfaW5mbyAq
aW5mbyA9IChzdHJ1Y3QgYWxhdWRhX2luZm8gKikgdXMtPmV4dHJhOwogCXVuc2lnbmVkIGNo
YXIgc3RhdHVzWzJdOworCWludCByYzsKIAotCWFsYXVkYV9nZXRfbWVkaWFfc3RhdHVzKHVz
LCBzdGF0dXMpOworCXJjID0gYWxhdWRhX2dldF9tZWRpYV9zdGF0dXModXMsIHN0YXR1cyk7
CisJaWYgKHJjICE9IFVTQl9TVE9SX1RSQU5TUE9SVF9HT09EKQorCQlyZXR1cm4gVVNCX1NU
T1JfVFJBTlNQT1JUX0VSUk9SOwogCiAJLyogQ2hlY2sgZm9yIG5vIG1lZGlhIG9yIGRvb3Ig
b3BlbiAqLwogCWlmICgoc3RhdHVzWzBdICYgMHg4MCkgfHwgKChzdGF0dXNbMF0gJiAweDFG
KSA9PSAweDEwKQo=
--------------8QGKN0DMtEJg3SQKJpxQwPda--

