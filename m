Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A4D7748
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiCMR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiCMR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:29:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB526AC5;
        Sun, 13 Mar 2022 10:27:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q10so18774177ljc.7;
        Sun, 13 Mar 2022 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=7Ot0KnTq6DeYLOMs0KrRgYt66byBQfvupOKuBASSZzQ=;
        b=G7L4Ch4ccUnHGnSNuI14sIkoOvDB2iL/etoiPBMiKWTJrjSSSRese4nTkmoLyuIU3a
         5MyAhodw+LXrOYf+B/9xK2+VKVYjL0V1sjAn0wS0QU0GDDpmYJ2UJGMLeKsGV+0E1M8X
         kOL4yfzXUuH072waC2DCjzs717PwvdNOK9z7ofVRjVfcYtv01RfeYPB9q+2kCGcLeDkj
         nEoNBbkR+UMBSSocrMsJ9jm/Q/Qz5879ppkeRcJskYXVE0imWivA3dZHTd3uh1QHD5bA
         lgnc5IW76BHPfAQrRaktthW+D7Eep7bbWia9U5ErUSLCiUJs3CbCtABquMXcgd6NsAVP
         zbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=7Ot0KnTq6DeYLOMs0KrRgYt66byBQfvupOKuBASSZzQ=;
        b=bC/8u8A07y/hhPdoEtB/iPvSQYFZ0yb/9PjSTXcRsqvLO3wLPNfK6TqBAcgVsCoSCm
         rjkN0fukn8+3vfaOccovTaphgo+NvNLphNEpKNMJpE4KJcQuOZJXXLWvOXZZaWYx/ihA
         7QE5Cfjmf2CcWwqERNIQxHu5IuOixJYJyURZH/yUB9fUQkE5hfD9JpZcjvqP/JikSfNz
         +0LyLQETAin7zkbweq1J3+G8h1+Ep/c1RrnOQw4qOLy1fLiJo5ai3Xk8Jqh8PrC41s/8
         M/ZKedtkYrl7m+JYn5zUGHOsRm5XAmKStaJHVRcuMtpv/vdiTqHNAUIJUsGeGZZx1fYx
         bhWQ==
X-Gm-Message-State: AOAM533iQmccSVTxUeRjebiiuYOI84AK5x7wjeB8rfsdb656cQ05jjfb
        NmIOicDZS9szBMXIElvHaQ8=
X-Google-Smtp-Source: ABdhPJw1S6q9ZdK3Mu2qhvw4J1r23ALus1F47eMtuq0+OMTfPFxY5PFStWQE1jLRkIpppIMMbxLOYg==
X-Received: by 2002:a05:651c:201a:b0:248:3d6:86aa with SMTP id s26-20020a05651c201a00b0024803d686aamr11374808ljo.339.1647192477753;
        Sun, 13 Mar 2022 10:27:57 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e2e0f000000b00247e32add6esm3329336lju.0.2022.03.13.10.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:27:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0J9d59w8SRPNvIU8fOxNB2ZF"
Message-ID: <79d2c7e0-c4ed-fa89-5d97-4b143356f814@gmail.com>
Date:   Sun, 13 Mar 2022 20:27:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
Content-Language: en-US
To:     syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rafael@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000473c1a05da12ee25@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000473c1a05da12ee25@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0J9d59w8SRPNvIU8fOxNB2ZF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/22 08:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92f90cc9fe0e Merge tag 'fuse-fixes-5.17-rc8' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=118cd3be700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
> dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b64e79700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652811a700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
> 

hu->serdev should be checked before passing to pm functions

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git





With regards,
Pavel Skripkin
--------------0J9d59w8SRPNvIU8fOxNB2ZF
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvaGNpX2g1LmMKaW5kZXggMzQyODZmZmUwNTY4Li43YWM2OTA4YTRkZmIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5jCisrKyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2hjaV9oNS5jCkBAIC02MjksOSArNjI5LDExIEBAIHN0YXRpYyBpbnQgaDVfZW5xdWV1
ZShzdHJ1Y3QgaGNpX3VhcnQgKmh1LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCQlicmVhazsK
IAl9CiAKLQlwbV9ydW50aW1lX2dldF9zeW5jKCZodS0+c2VyZGV2LT5kZXYpOwotCXBtX3J1
bnRpbWVfbWFya19sYXN0X2J1c3koJmh1LT5zZXJkZXYtPmRldik7Ci0JcG1fcnVudGltZV9w
dXRfYXV0b3N1c3BlbmQoJmh1LT5zZXJkZXYtPmRldik7CisJaWYgKGh1LT5zZXJkZXYpIHsK
KwkJcG1fcnVudGltZV9nZXRfc3luYygmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGlt
ZV9tYXJrX2xhc3RfYnVzeSgmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGltZV9wdXRf
YXV0b3N1c3BlbmQoJmh1LT5zZXJkZXYtPmRldik7CisJfQogCiAJcmV0dXJuIDA7CiB9Cg==


--------------0J9d59w8SRPNvIU8fOxNB2ZF--
