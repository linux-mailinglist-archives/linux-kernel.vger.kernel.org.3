Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534A58C410
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiHHHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiHHHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:35:29 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B906FD0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:35:28 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.5.6])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oKxIL-0029jq-14; Mon, 08 Aug 2022 08:35:25 +0100
Message-ID: <76d4f1d3-e72e-ef2e-12d0-f241fe680717@codethink.co.uk>
Date:   Mon, 8 Aug 2022 08:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] RISC-V Patches for the 5.20 Merge Window, Part 1
Content-Language: en-GB
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 00:36, Palmer Dabbelt wrote:
> The following changes since commit 924cbb8cbe3460ea192e6243017ceb0ceb255b1b:
> 
>    riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol (2022-06-16 15:47:39 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw0
> 
> for you to fetch changes up to ba6cfef057e1c594c456627aad81c2343fdb5d13:
> 
>    riscv: enable Docker requirements in defconfig (2022-07-22 13:43:28 -0700)
> 
> ----------------------------------------------------------------
> RISC-V Patches for the 5.20 Merge Window, Part 1
> 
> * Enabling the FPU is now a static_key.
> * Improvements to the Svpbmt support.
> * CPU topology bindings for a handful of systems.
> * Support for systems with 64-bit hart IDs.
> * Many settings have been enabled in the defconfig, including both
>    support for the StarFive systems and many of the Docker requirements.
> 
> There are also a handful of cleanups and improvements, like usual.
> 

Hi, are some of mine and Connor's fixes planned for part2?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
