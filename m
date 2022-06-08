Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F854265A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389505AbiFHCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445990AbiFHCNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:13:50 -0400
Received: from qproxy6-pub.mail.unifiedlayer.com (qproxy6-pub.mail.unifiedlayer.com [69.89.23.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0736420BE6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:12:52 -0700 (PDT)
Received: from outbound-ss-761.bluehost.com (outbound-ss-761.bluehost.com [74.220.211.250])
        by qproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id 060068032891
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:12:50 +0000 (UTC)
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by progateway8.mail.pro1.eigbox.com (Postfix) with ESMTP id 300291005DDC0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:12:49 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id yjJYn2vaOvL44yjJYnJifB; Wed, 08 Jun 2022 00:12:49 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=ZebYiuZA c=1 sm=1 tr=0 ts=629fe981
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=JPEYwPQDsx4A:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=RudyytyL_DxIq4wlthoA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AFc4b+RBT46WI3QejiWcwvr+sEfKp2r/9zyP6eQJ2qM=; b=oEg/9GyhqVPg4k0DLQciPL3Xkc
        ckOu+Xb2obXE9Wi4V6TbRLgNIrD/lDb1WUXCezHAqDMgkHgOZ+WUeIWd0i75tordp4AGUROc7JQuU
        xoecucEXfTz0Fh0Fz0+Cfxf2gUPuZKIGwMD24zPLOR1jdlYHNcaDKcYyKNSElvy8sidB6KU8Rfqz6
        V+25T79pRabnb6OBcYGjRXC/bweh3t6bXgmeAGPRvOK+T/je97vaqWNVZ2Jux6LvoSy1pfMUoDwds
        lbVTDbUO7S1OTLJSed8qdxh4qKmbIuA5HsG9Utes1OjyRTGgRYIzQokTVE3WzHSSptUMuOHGbWIQ6
        Nyv3h2wA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:54124 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1nyjJY-002WuX-AZ;
        Tue, 07 Jun 2022 18:12:48 -0600
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
 <d7c8ee82-ce85-5d55-2865-4b610c9d3b9d@w6rz.net> <827324415.0ifERbkFSE@diego>
From:   Ron Economos <re@w6rz.net>
Message-ID: <06c46bde-5d3f-9123-93b4-9e0f3824ac3a@w6rz.net>
Date:   Tue, 7 Jun 2022 17:12:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <827324415.0ifERbkFSE@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1nyjJY-002WuX-AZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:54124
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 4:36 PM, Heiko Stübner wrote:
> Hi Ron,
>
> Am Dienstag, 7. Juni 2022, 22:46:52 CEST schrieb Ron Economos:
>> On 5/31/22 10:13 AM, Palmer Dabbelt wrote:
>>> The following changes since commit 9282d0996936c5fbf877c0d096a3feb456c878ad:
>>>
>>>     csky: Move to generic ticket-spinlock (2022-05-11 11:50:15 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0
>>>
>>> for you to fetch changes up to 7699f7aacf3ebfee51c670b6f796b2797f0f7487:
>>>
>>>     RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add] (2022-05-30 16:04:37 -0700)
>>>
>>> ----------------------------------------------------------------
>>> RISC-V Patches for the 5.19 Merge Window, Part 1
>>>
>>> * Support for the Svpbmt extension, which allows memory attributes to be
>>>     encoded in pages.
>>>
>>>
>>> Heiko Stuebner (12):
>>>         riscv: integrate alternatives better into the main architecture
>>>         riscv: allow different stages with alternatives
>>>         riscv: implement module alternatives
>>>         riscv: implement ALTERNATIVE_2 macro
>>>         riscv: extend concatenated alternatives-lines to the same length
>>>         riscv: prevent compressed instructions in alternatives
>>>         riscv: move boot alternatives to after fill_hwcap
>>>         riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>>>         riscv: add RISC-V Svpbmt extension support
>>>         riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>>>         riscv: don't use global static vars to store alternative data
>>>         riscv: add memory-type errata for T-Head
>>>
>> An issue was found on the HiFive Unmatched with the 5.19-rc1 kernel. The
>> following warning occurs during boot:
>>
>> riscv64 kernel:
>> ----------------------------------------------------------------
>> riscv64 kernel: WARNING: Missing the following errata may cause
>> potential issues
>> riscv64 kernel:         SiFive Errata[0]:cip-453
>> riscv64 kernel:         SiFive Errata[1]:cip-1200
>> riscv64 kernel: Please enable the corresponding Kconfig to apply them
>> riscv64 kernel:
>> ----------------------------------------------------------------
>>
>> I've manually bisected the problem to this commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff689fd21cb13098305bae3f8d0c0065df2e2fc1
> hmm, on first glance I can't really see how that specific commit would
> affect Sifive erratas. Patches directly before this one did change
> alternative / errata things though.
>
> (1) From looking at your output, it seems at least CONFIG_ERRATA_SIFIVE
> is enabled as the general sifive errata code is running, but are the
> individual erratas also still enabled in your config?
> They're default=y forever and weren't touched by the svpbmt series,
> but it'd be nice to know how the config looks, to see if the Kconfig
> settings are strange somewhere
>
>
> (2) Going from the list on
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=ff689fd21cb13098305bae3f8d0c0065df2e2fc1
>
> could you maybe check if it's really working with the parent of the
> commit you found. (i.e. patches before the svpbmt addition).
>
> Also just to be sure, it still works correctly with 5.18, right?
>
>
> Thanks
> Heiko
>
>
Yes, that commit was surprising. I also thought it would have been one 
of the previous "alternatives" commits. But I tested them all, and the 
warning only appears with the "add RISC-V Svpbmt extension support" 
commit. In other words, "git checkout 100631b" works fine, but "git 
checkout ff689fd" does not.

I have these settings in my .config:

CONFIG_ERRATA_SIFIVE=y
CONFIG_ERRATA_SIFIVE_CIP_453=y
CONFIG_ERRATA_SIFIVE_CIP_1200=y

CONFIG_RISCV_ALTERNATIVE=y

I've uploaded the complete .config file here:

https://www.w6rz.net/config-5.19-rc1

It's based on a modified version of the Ubuntu 22.04 config file.

Linux 5.18 (including 5.18.2) is fine (with the same .config).

You can also find me on irc.libera.chat #riscv with nick drmpeg.

Ron

