Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694F7481C63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhL3NNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbhL3NND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:13:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1FC061574;
        Thu, 30 Dec 2021 05:13:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u13so54295711lff.12;
        Thu, 30 Dec 2021 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=IVqgqYM62JDopuY5rF+I4ADLUZ/XXITTt8In+XuYjNI=;
        b=hiyjDpSNuFOX/Uq5kw2JiMPkuFvK3mG6WD/ZqGY6T9nFSutTPADC8e5qLcda1u0tlu
         MSkTnFlKEIpRP9u1z4GPHH4VYW22gfXR/LH7Sb7BqaatAGx3mqhbC9d39hPDDPVB5Br8
         nJeQEKPSNV3pYMRVPXEto9I8yOdvLpHP4Gn1ZWAW9DOckfrWTrX/mTc2sDty/A62CKEI
         3DqtXXxG6+qy7SxxlS1rEKl5yhWiUjdyKYMm3f8+M0cFfCjVujFah7EJab2+yX6mgVWr
         WUHLNBBbDr3vi1TLCYhjkAKsPu6vaoPTGaEy6q/i1a49PxDdk+fbsh3lGchAYqLewdbJ
         Da5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=IVqgqYM62JDopuY5rF+I4ADLUZ/XXITTt8In+XuYjNI=;
        b=LHyk2TPvXchQ6RoDK2UXos+e8B9kkP+p9D7yjldketxqL4sYafNGWhxCuabermrHKj
         j7aWzZ4RkO90F2NcBfhtbSGyO4oZVGEhB33CUq7eqUEwNNfs4o+MqDRyf/ubcxCNzm3V
         P6s1+n58h5D9mMzrCtZfQHgVm2v/onsHmuR19KYcyCs851vjvP/pUUmwqturnuCOljWv
         YdtnHr4UI01qcYKqOCykAxMTcIcxvdrpGQZYBeYtqUxFYSLEMDJfwibJ+kod40EbEoWX
         TTsihxfTBpwa9rbPX+mvSC4Ygl2Zyg0nJXFIc3EDYQkEKDM6jcbxBcwkLjxCgaUvHB9Q
         dSjQ==
X-Gm-Message-State: AOAM531U7ym674zomrt4AGoo9bSt8nq8zg14TewqgcD8ImjnkVV/SFCv
        jIilP11Bg+dXu3i/n6L53fY=
X-Google-Smtp-Source: ABdhPJxbnB4zZ1kov8XjrzubG+Ji7s7QXW61gzCqBHMACIQHyAtYnlWDxarErjEhgVJagpSHy8kmAg==
X-Received: by 2002:a05:6512:38a9:: with SMTP id o9mr13069890lft.109.1640869981568;
        Thu, 30 Dec 2021 05:13:01 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id f18sm337036lfr.5.2021.12.30.05.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 05:13:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------XxA3EXb8FmjqFnogTzieBQSE"
Message-ID: <cb0cbd54-2b26-1c10-eb30-3b97870904d9@gmail.com>
Date:   Thu, 30 Dec 2021 16:12:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [syzbot] WARNING in atp_close (3)
Content-Language: en-US
To:     syzbot <syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000be49b905cd677b9a@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000be49b905cd677b9a@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------XxA3EXb8FmjqFnogTzieBQSE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/21 03:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bf5b1e621a51 Add linux-next specific files for 20210927
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cc5bd3300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58fe22c337ee4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=b88c5eae27386b252bbd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com
> 

dev->work should be initialized before input_register_device(), since 
input_dev->close() calls cancel_work_sync()

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master




With regards,
Pavel Skripkin
--------------XxA3EXb8FmjqFnogTzieBQSE
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbW91c2UvYXBwbGV0b3VjaC5jIGIvZHJpdmVy
cy9pbnB1dC9tb3VzZS9hcHBsZXRvdWNoLmMKaW5kZXggYmZhMjY2NTFjMGJlLi42MjcwNDhi
YzZhMTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvbW91c2UvYXBwbGV0b3VjaC5jCisr
KyBiL2RyaXZlcnMvaW5wdXQvbW91c2UvYXBwbGV0b3VjaC5jCkBAIC05MTYsNiArOTE2LDgg
QEAgc3RhdGljIGludCBhdHBfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmlmYWNlLAog
CXNldF9iaXQoQlROX1RPT0xfVFJJUExFVEFQLCBpbnB1dF9kZXYtPmtleWJpdCk7CiAJc2V0
X2JpdChCVE5fTEVGVCwgaW5wdXRfZGV2LT5rZXliaXQpOwogCisJSU5JVF9XT1JLKCZkZXYt
PndvcmssIGF0cF9yZWluaXQpOworCiAJZXJyb3IgPSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2Uo
ZGV2LT5pbnB1dCk7CiAJaWYgKGVycm9yKQogCQlnb3RvIGVycl9mcmVlX2J1ZmZlcjsKQEAg
LTkyMyw4ICs5MjUsNiBAQCBzdGF0aWMgaW50IGF0cF9wcm9iZShzdHJ1Y3QgdXNiX2ludGVy
ZmFjZSAqaWZhY2UsCiAJLyogc2F2ZSBvdXIgZGF0YSBwb2ludGVyIGluIHRoaXMgaW50ZXJm
YWNlIGRldmljZSAqLwogCXVzYl9zZXRfaW50ZmRhdGEoaWZhY2UsIGRldik7CiAKLQlJTklU
X1dPUksoJmRldi0+d29yaywgYXRwX3JlaW5pdCk7Ci0KIAlyZXR1cm4gMDsKIAogIGVycl9m
cmVlX2J1ZmZlcjoK

--------------XxA3EXb8FmjqFnogTzieBQSE--
