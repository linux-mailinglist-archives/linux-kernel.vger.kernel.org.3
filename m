Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAE4E60CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbiCXJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbiCXJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:04:39 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D439BED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:03:07 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 013067E34E;
        Thu, 24 Mar 2022 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648112587;
        bh=MNeEyv39Qtfb8aDPYDSdUWmYfAJujY2sEqwrQ6vuy64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oZ0/j7kI2TyndzqCChVmbTo3XDnPxDuNCFK0Nw/9zltU102XVsei+ysVPgYkgq3Bb
         9d/2E2NOUVkltOwj0wO+iY+twZv2HluHaweRqcoMOAZU4xQWb7QyjmsgFgNehYJLvp
         L30BeYNdSgdgX7OTkXMgTBZDtuqPtQQg3LVo9Ty+ihAa10bJxYb//38xayTy/orQuf
         G7VAhII0RHJ6wGxOGxFGNmvdDfv/3ta3eYPkSAZnlxVJHgl2mrxVnvgIo9xpZylUsa
         RKqR2y05ytGe+YfkYuiSZQH0Un6Vwcwo9tz3B0so5vOfmmK4ZgHfaeH/BCgPdoFWp+
         c9T2iRouNcASA==
Message-ID: <a537c815-6933-fb37-3037-dab395a442b8@gnuweeb.org>
Date:   Thu, 24 Mar 2022 16:03:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 03/11] tools/nolibc: Replace `asm` with `__asm__`
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
 <20220324073039.140946-4-ammarfaizi2@gnuweeb.org>
 <20220324074123.GB18586@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220324074123.GB18586@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 2:41 PM, Willy Tarreau wrote:
> On Thu, Mar 24, 2022 at 02:30:31PM +0700, Ammar Faizi wrote:
>> Replace `asm` with `__asm__` to support compilation with -std flag.
>> Using `asm` with -std flag makes GCC think `asm()` is a function call
>> instead of an inline assembly.
> 
> OK fair enough, and if we have to do it, better do it early anyway.

I will make this one as the second patch after patch that fixes the
System V ABI document link (in the next version). So this will be
[PATCH 02/N].

Please holler if it should be the first patch.

-- 
Ammar Faizi
