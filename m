Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AED484309
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiADOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiADOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:06:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CE4C061761;
        Tue,  4 Jan 2022 06:06:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g26so81935556lfv.11;
        Tue, 04 Jan 2022 06:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=HoqgMl2n4h1rswstJszaOEFazvx0RgkLaBo73mTE2QA=;
        b=bUIjlZWSGMBMg0Vnig7JUwuXm7r39cU965e43gc+Tl053aKax02wu1XH8zrSxjO3uu
         7592Ff6NdGjVWvjM6IjdKmjqTh6eOFmhUdiPYnTg1+HD3bokmD41ZI/FvYGPnl2/bf1v
         051/J6cS2Y0jNtLpr4PXl4Of1iU2JlMjbjReSgmZhb/5SWe16xtW5EVVyw9KjW45NWPc
         rJkZxC8KAOcS8cSkUFtfN9O1Uk3xawEqhO+GKlXqCAnIHxTjpEAKj8x7RtU1ZogT86us
         vO1D2x2AhfEn3F6DAdQuSCaYHHdbPTudXvg22DizULsXy3tovT3JdL8Fjp1xwtuOGuEh
         qgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=HoqgMl2n4h1rswstJszaOEFazvx0RgkLaBo73mTE2QA=;
        b=dJX2S/fCwdsMBvl8JTAUNN9iyrkI1AaGmpzzYtnezLRZim8U5YsmsYyBDnSiKZIFuI
         FLPpHhvR503OdBlTzlkMsqBEUmjn+OICrXciR4cu1zLYFM4nTHEzwi+PJjJ9cvuuZWA2
         zx/QTN0innyiYifxhZqG/RD9GtZFvQwhGrRaTZtIdJP2XWW0UbUAzID5rqZ3AhIIBZuy
         cJHTySspxxX9XsPJTS93MwfbTOu5KJ7BrlgU1nX3T34FJ84BkSZIEygoi4qRScCFJv4r
         RtH4/IWyi5EINHS2IB+JQiRmcgKfLZcUBb9G0Z6+/6ZU6vl0IBBGKkPGNd51PZgrVaOi
         lg9Q==
X-Gm-Message-State: AOAM531dIlzK6XqKBS7h/vybozXyXNhl1KBdp4n+c3rKSdEiFYdINX47
        o003VoX7xwbQlFWn4t0axg4=
X-Google-Smtp-Source: ABdhPJz7Juw/tz6F9foPJT99w/WRPGT/PB/NtLt/ft3gt9HFgFdygMLZLIb7eaKjB3N3cnWp+c/Y5g==
X-Received: by 2002:a05:6512:16a6:: with SMTP id bu38mr22931403lfb.454.1641305201303;
        Tue, 04 Jan 2022 06:06:41 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.38])
        by smtp.gmail.com with ESMTPSA id l14sm3922338lfg.90.2022.01.04.06.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:06:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Abq1EaETT00qTeX0ojmvcZWG"
Message-ID: <e907527f-c071-c5f1-e83a-3786c750cd45@gmail.com>
Date:   Tue, 4 Jan 2022 17:06:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: INFO: trying to register non-static key in hci_uart_tx_wakeup
Content-Language: en-US
To:     kvartet <xyru1999@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
References: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Abq1EaETT00qTeX0ojmvcZWG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/22 11:49, kvartet wrote:
> Hello,
> 
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.
> 
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/plain/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yiru Xu <xyru1999@gmail.com>
> 
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 2 PID: 18524 Comm: syz-executor.5 Not tainted 5.16.0-rc6 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   assign_lock_key kernel/locking/lockdep.c:951 [inline]
>   register_lock_class+0x148d/0x1950 kernel/locking/lockdep.c:1263
>   __lock_acquire+0x106/0x57e0 kernel/locking/lockdep.c:4906
>   lock_acquire kernel/locking/lockdep.c:5637 [inline]
>   lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
>   percpu_down_read_trylock include/linux/percpu-rwsem.h:92 [inline]
>   hci_uart_tx_wakeup+0x12e/0x490 drivers/bluetooth/hci_ldisc.c:124
>   h5_timed_event+0x32f/0x6a0 drivers/bluetooth/hci_h5.c:188
>   call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421

hci_uart_proto.open() functions register timer, which may call 
hci_uart_tx_wakeup(), so we need to initalize rwsem before calling
hci_uart_proto.open()

Just for thoughts


With regards,
Pavel Skripkin

--------------Abq1EaETT00qTeX0ojmvcZWG
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9zZXJkZXYuYyBiL2RyaXZlcnMv
Ymx1ZXRvb3RoL2hjaV9zZXJkZXYuYwppbmRleCAzYjAwZDgyZDM2Y2YuLjRjZGE4OTBjZTY0
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX3NlcmRldi5jCisrKyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2hjaV9zZXJkZXYuYwpAQCAtMzA1LDYgKzMwNSw4IEBAIGludCBo
Y2lfdWFydF9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IGhjaV91YXJ0ICpodSwKIAlpZiAoZXJy
KQogCQlyZXR1cm4gZXJyOwogCisJcGVyY3B1X2luaXRfcndzZW0oJmh1LT5wcm90b19sb2Nr
KTsKKwogCWVyciA9IHAtPm9wZW4oaHUpOwogCWlmIChlcnIpCiAJCWdvdG8gZXJyX29wZW47
CkBAIC0zMjcsNyArMzI5LDYgQEAgaW50IGhjaV91YXJ0X3JlZ2lzdGVyX2RldmljZShzdHJ1
Y3QgaGNpX3VhcnQgKmh1LAogCiAJSU5JVF9XT1JLKCZodS0+aW5pdF9yZWFkeSwgaGNpX3Vh
cnRfaW5pdF93b3JrKTsKIAlJTklUX1dPUksoJmh1LT53cml0ZV93b3JrLCBoY2lfdWFydF93
cml0ZV93b3JrKTsKLQlwZXJjcHVfaW5pdF9yd3NlbSgmaHUtPnByb3RvX2xvY2spOwogCiAJ
LyogT25seSB3aGVuIHZlbmRvciBzcGVjaWZpYyBzZXR1cCBjYWxsYmFjayBpcyBwcm92aWRl
ZCwgY29uc2lkZXIKIAkgKiB0aGUgbWFudWZhY3R1cmVyIGluZm9ybWF0aW9uIHZhbGlkLiBU
aGlzIGF2b2lkcyBmaWxsaW5nIGluIHRoZQo=

--------------Abq1EaETT00qTeX0ojmvcZWG--
