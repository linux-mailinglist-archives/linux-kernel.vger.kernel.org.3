Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC74DEA12
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiCSSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiCSSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:24:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A321C34AF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:23:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so6808009lfj.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=uNibqQJsY18b43mdTlcpPHoa8q7iBzS63h/TZp5dtaM=;
        b=Bj4QqncBVpaSjbv6iOLVmIT4TVDgGcnxbEtz56JTO2DaNqJrzQT7dxun7tEK/V+hmN
         j5psQckDAdOJOMAmbxHhjH79umeJAMWk2hCj8wqhqQg4qn/JSwIZDZO+VlLsMmGNtw5N
         1U1JiOjcoaL14fMSV8ZZ2ov4hQCynbgUZhQxDxoUeXDaHOCH/XA8A3TokptSA9cRQK5u
         6W9XGLhEsoHGP9jYY3lQ4GHFMaEuih+/lF5p5IFucXYvGbKaJvkOoflf7fEeThxIjOXH
         dJg5X21pW1nENLvw+oNi045G8f6SBMhDMirRpBJ62t+JqAv6GnvxfbHMg84geZyTNu6z
         Pw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=uNibqQJsY18b43mdTlcpPHoa8q7iBzS63h/TZp5dtaM=;
        b=d8rB3ElfX1uwURyo3dZbp+xyd0SccuHvdBqFZ9kgj8j3VEdBpHxT4Ey+6O7ZaNN9r+
         RDAeyTdZn3/eWwsMaPnThhtUE9pPOLNrESUsLV6uebYoeud6LlKR0Jey1I8uoEI/q/sv
         8Tw5SDN/Nme1ImL7bgt8r4BGxcu72wE0ZciLhxNUc24gDeVyFClsE/4ZAs5m4g4el7EZ
         hEv9b/Qub4biAXwi8N2W/lVHzG/Km74xdiFefL2/PCFeOiqMdK1GmZch34n26TlkFd5l
         R0F7N5p2lRVJyI8Rsrr85gbTxY4RIJQ5WR3caIM4HqyS8DXzYLdm/KW9h9yZ5CPL48Eg
         1+fw==
X-Gm-Message-State: AOAM5305eye28TtB8InnuU5ccpFvMDk4esX+CBWfnxr1NqO7oU83JwKR
        NZkbxJZMH7+LpauX2SkrwtM=
X-Google-Smtp-Source: ABdhPJz4sZaNj2/GJ3fVJKviJ07zqU9lPtNEOmz7QI2eyHqw5fBLL5c0ZuZbUvAUv/ixrZfo+NcWRA==
X-Received: by 2002:ac2:4e06:0:b0:448:3218:2e22 with SMTP id e6-20020ac24e06000000b0044832182e22mr10146455lfr.369.1647714187792;
        Sat, 19 Mar 2022 11:23:07 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.145])
        by smtp.gmail.com with ESMTPSA id c1-20020a196541000000b00448bcdccb91sm1260932lfj.231.2022.03.19.11.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 11:23:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0geXwsVQalqTa2xB0VGIHWeE"
Message-ID: <57fc3806-86c6-b1b2-4c44-083b1b7afc8b@gmail.com>
Date:   Sat, 19 Mar 2022 21:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] divide error in dbNextAG
Content-Language: en-US
To:     syzbot <syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b1470105da9622aa@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000b1470105da9622aa@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0geXwsVQalqTa2xB0VGIHWeE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/22 21:07, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    09688c0166e7 Linux 5.17-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=163e5015700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70f75a89c7a0e6bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=46f5c25af73eb8330eb6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132c1d61700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
> 
> divide error: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 3622 Comm: syz-executor.0 Not tainted 5.17.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:dbNextAG+0xfc/0x5f0 fs/jfs/jfs_dmap.c:602

Looks like malicious fs image with bmp->db_numag == 0.

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master




With regards,
Pavel Skripkin
--------------0geXwsVQalqTa2xB0VGIHWeE
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2pmcy9qZnNfZG1hcC5jIGIvZnMvamZzL2pmc19kbWFwLmMKaW5k
ZXggOTFmNGVjOTNkYWIxLi42MzNhOWFmZjA4NjggMTAwNjQ0Ci0tLSBhL2ZzL2pmcy9qZnNf
ZG1hcC5jCisrKyBiL2ZzL2pmcy9qZnNfZG1hcC5jCkBAIC0xNDgsNiArMTQ4LDcgQEAgc3Rh
dGljIGNvbnN0IHM4IGJ1ZHRhYlsyNTZdID0gewogICoJMAktIHN1Y2Nlc3MKICAqCS1FTk9N
RU0JLSBpbnN1ZmZpY2llbnQgbWVtb3J5CiAgKgktRUlPCS0gaS9vIGVycm9yCisgKgktRUlO
VkFMIC0gd3JvbmcgYm1hcCBkYXRhCiAgKi8KIGludCBkYk1vdW50KHN0cnVjdCBpbm9kZSAq
aXBibWFwKQogewpAQCAtMTc5LDYgKzE4MCw5IEBAIGludCBkYk1vdW50KHN0cnVjdCBpbm9k
ZSAqaXBibWFwKQogCWJtcC0+ZGJfbmZyZWUgPSBsZTY0X3RvX2NwdShkYm1wX2xlLT5kbl9u
ZnJlZSk7CiAJYm1wLT5kYl9sMm5icGVycGFnZSA9IGxlMzJfdG9fY3B1KGRibXBfbGUtPmRu
X2wybmJwZXJwYWdlKTsKIAlibXAtPmRiX251bWFnID0gbGUzMl90b19jcHUoZGJtcF9sZS0+
ZG5fbnVtYWcpOworCWlmICghYm1wLT5kYl9udW1hZykKKwkJcmV0dXJuIC1FSU5WQUw7CisK
IAlibXAtPmRiX21heGxldmVsID0gbGUzMl90b19jcHUoZGJtcF9sZS0+ZG5fbWF4bGV2ZWwp
OwogCWJtcC0+ZGJfbWF4YWcgPSBsZTMyX3RvX2NwdShkYm1wX2xlLT5kbl9tYXhhZyk7CiAJ
Ym1wLT5kYl9hZ3ByZWYgPSBsZTMyX3RvX2NwdShkYm1wX2xlLT5kbl9hZ3ByZWYpOwo=

--------------0geXwsVQalqTa2xB0VGIHWeE--
