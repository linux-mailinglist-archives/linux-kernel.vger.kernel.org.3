Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4A54219A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiFHDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383693AbiFHDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:06:01 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com (gproxy4-pub.mail.unifiedlayer.com [69.89.23.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8038A97C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:47:04 -0700 (PDT)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway6.mail.pro1.eigbox.com (Postfix) with ESMTP id 59AE010041221
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:46:55 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id yg6Ink5Pqcfa4yg6Jnt2Qt; Tue, 07 Jun 2022 20:46:55 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=eq8acqlX c=1 sm=1 tr=0 ts=629fb93f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=JPEYwPQDsx4A:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=FDXPpHPgRJWCp2rMUuoA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yPiHGqKsGbhSH2O3uOVjEGQO1t3l3ZCczdGfr/fjGfY=; b=esuVSpsGq0mTBzUDjf/iWJo/Gl
        ck6jcfSL37XcusiPq+rtpfPUlhouLtrc8tedChFRFDZbj7i1jSEYwPl3fEnfjVRfo/ckeOGN6BOcH
        FJMnMurxB6ggzOgRKjj1ObhYg2HSBYA0zrv/Zdiwy3/pqKBEM3L8MMC7IYynRTGDtdwRzhPA1wh7i
        z6FFu9luLCVWYJew2tO9eOAJHjNUXNOenrSD1743E6wpXLOTBkQJVtOxsqXkuXUVDF8c6ccimWZ3F
        qjM3ffsanIQCfVSPTH+uaC0mzNieXrSQWU1+rzMuA1rTb51Lwa9PiFvkS4ju+zcivHssAOcB6oBI5
        y+0adxjA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:54014 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1nyg6I-001GrC-GR;
        Tue, 07 Jun 2022 14:46:54 -0600
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
From:   Ron Economos <re@w6rz.net>
Message-ID: <d7c8ee82-ce85-5d55-2865-4b610c9d3b9d@w6rz.net>
Date:   Tue, 7 Jun 2022 13:46:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
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
X-Exim-ID: 1nyg6I-001GrC-GR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:54014
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 10:13 AM, Palmer Dabbelt wrote:
> The following changes since commit 9282d0996936c5fbf877c0d096a3feb456c878ad:
>
>    csky: Move to generic ticket-spinlock (2022-05-11 11:50:15 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0
>
> for you to fetch changes up to 7699f7aacf3ebfee51c670b6f796b2797f0f7487:
>
>    RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add] (2022-05-30 16:04:37 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.19 Merge Window, Part 1
>
> * Support for the Svpbmt extension, which allows memory attributes to be
>    encoded in pages.
>
>
> Heiko Stuebner (12):
>        riscv: integrate alternatives better into the main architecture
>        riscv: allow different stages with alternatives
>        riscv: implement module alternatives
>        riscv: implement ALTERNATIVE_2 macro
>        riscv: extend concatenated alternatives-lines to the same length
>        riscv: prevent compressed instructions in alternatives
>        riscv: move boot alternatives to after fill_hwcap
>        riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>        riscv: add RISC-V Svpbmt extension support
>        riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>        riscv: don't use global static vars to store alternative data
>        riscv: add memory-type errata for T-Head
>
An issue was found on the HiFive Unmatched with the 5.19-rc1 kernel. The 
following warning occurs during boot:

riscv64 kernel: 
----------------------------------------------------------------
riscv64 kernel: WARNING: Missing the following errata may cause 
potential issues
riscv64 kernel:         SiFive Errata[0]:cip-453
riscv64 kernel:         SiFive Errata[1]:cip-1200
riscv64 kernel: Please enable the corresponding Kconfig to apply them
riscv64 kernel: 
----------------------------------------------------------------

I've manually bisected the problem to this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff689fd21cb13098305bae3f8d0c0065df2e2fc1

