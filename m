Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03D486D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiAFWRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiAFWRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:17:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A1C061245;
        Thu,  6 Jan 2022 14:17:44 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j11so8820033lfg.3;
        Thu, 06 Jan 2022 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=XNho6nSdUreQ9C5eMbGL1kMRCu6BZwKVSjLAcvi6y5k=;
        b=Q1h+TFrwqkn1VpoXLiOlZDMEh5RGBsH7+xIE71LYhxfYAxdJ3dvsfgUPTtWOeqT208
         jN5yBo3SDbuLhi3+qBmSOlkLKCQclvdBeQN6lFahE6rOcfqwYVeQGe+NA0KKhiY62WNM
         abGUiQlbI5h9xWlzfgArckHsMnW7pkPBBoFwRhOLE39PsJVrfsJKKti560S2Zl/jzu8l
         FvDzOJ6FcSttJoZV/u2KS4ze1RX7rTnsMLlUd0tE6SSYELcaA8CAbKf4zey5Ad0b78iF
         7llFxELOpwCT9hTrZ8vTcXCUZ71QrihyPmynbl4fvJf9/tsQjXzuYypVds0Qo5ymzkjR
         gIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=XNho6nSdUreQ9C5eMbGL1kMRCu6BZwKVSjLAcvi6y5k=;
        b=PyJ2x1P1eMI84/UDKWlYAPipcKbQfArGAJ2qJuQMRpTkHtlV6AZF2Dve9VmUgLl47z
         p3MwTv4EEQTeq8Q6BlYcP65/qFT3scVVDuMZPxYgKzsvJBiG2SfS0QWVtH3Pq9Ta4dyb
         LyQf2ggUfH0iqCVNkjMxxNgzHcBQ7SeGzNHyZHKK+8UeMc2Hucq9AS+n3RZNuUPAwBsd
         VKDEobUIQiKb+gHs7B4fP6/gNmB2++hnwVCeigxCpb4W33EsV0doph2fL97laV/IxjCA
         Su8Dvt7B+NYtbof4npClaK2Dx27AhQM7rHIBOgqsRfpJvQvzaXSZnXEmakv3c7Urqzz+
         VHpQ==
X-Gm-Message-State: AOAM533aXnJ36WDHYlh5KKqAk/u78Qt2RzntOXP1Bxl+x1hYF5Gi53v6
        H4IKXpCDoqkjDO52FtqzA+k=
X-Google-Smtp-Source: ABdhPJwOEuVRxP8RWtF++nWgSy6drYY0+HjpmMlr1TRy3q2Gfi0aFQf5s8Da3E3taPBq5l6Kxifd2A==
X-Received: by 2002:a2e:81ce:: with SMTP id s14mr49323183ljg.250.1641507463114;
        Thu, 06 Jan 2022 14:17:43 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.53])
        by smtp.gmail.com with ESMTPSA id i22sm341405ljh.85.2022.01.06.14.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 14:17:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------8H55T9hPyaNqrV0guVBciFzF"
Message-ID: <60e9caf1-7b9f-c5a4-a3e8-ff9135e16197@gmail.com>
Date:   Fri, 7 Jan 2022 01:17:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [syzbot] KMSAN: kernel-usb-infoleak in usbnet_write_cmd (3)
Content-Language: en-US
To:     syzbot <syzbot+003c0a286b9af5412510@syzkaller.appspotmail.com>,
        glider@google.com, gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
References: <000000000000be665505d4d9ebd6@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000be665505d4d9ebd6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8H55T9hPyaNqrV0guVBciFzF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/22 21:28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a07163b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=003c0a286b9af5412510
> compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100165dbb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c97e77b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+003c0a286b9af5412510@syzkaller.appspotmail.com
> 

Heh, I think, more reports like this will appear soon. Syzbot learned 
how to tweak usb read functions return values, I guess?

#syz test: https://github.com/google/kmsan.git master



With regards,
Pavel Skripkin
--------------8H55T9hPyaNqrV0guVBciFzF
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9tY3M3ODMwLmMgYi9kcml2ZXJzL25ldC91
c2IvbWNzNzgzMC5jCmluZGV4IDMyNmNjNGU3NDlkOC4uMGRhYWU3ZjE2ZGE5IDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC91c2IvbWNzNzgzMC5jCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9t
Y3M3ODMwLmMKQEAgLTEwOCw4ICsxMDgsMTYgQEAgc3RhdGljIGNvbnN0IGNoYXIgZHJpdmVy
X25hbWVbXSA9ICJNT1NDSElQIHVzYi1ldGhlcm5ldCBkcml2ZXIiOwogCiBzdGF0aWMgaW50
IG1jczc4MzBfZ2V0X3JlZyhzdHJ1Y3QgdXNibmV0ICpkZXYsIHUxNiBpbmRleCwgdTE2IHNp
emUsIHZvaWQgKmRhdGEpCiB7Ci0JcmV0dXJuIHVzYm5ldF9yZWFkX2NtZChkZXYsIE1DUzc4
MzBfUkRfQlJFUSwgTUNTNzgzMF9SRF9CTVJFUSwKLQkJCQkweDAwMDAsIGluZGV4LCBkYXRh
LCBzaXplKTsKKwlpbnQgcmV0OworCisJcmV0ID0gdXNibmV0X3JlYWRfY21kKGRldiwgTUNT
NzgzMF9SRF9CUkVRLCBNQ1M3ODMwX1JEX0JNUkVRLAorCQkJICAgICAgMHgwMDAwLCBpbmRl
eCwgZGF0YSwgc2l6ZSk7CisJaWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisJZWxzZSBp
ZiAocmV0IDwgc2l6ZSkKKwkJcmV0dXJuIC1FTk9EQVRBOworCisJcmV0dXJuIDA7CiB9CiAK
IHN0YXRpYyBpbnQgbWNzNzgzMF9zZXRfcmVnKHN0cnVjdCB1c2JuZXQgKmRldiwgdTE2IGlu
ZGV4LCB1MTYgc2l6ZSwgY29uc3Qgdm9pZCAqZGF0YSkK

--------------8H55T9hPyaNqrV0guVBciFzF--
