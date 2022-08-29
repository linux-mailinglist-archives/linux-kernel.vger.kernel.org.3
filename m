Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F695A412C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiH2CyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2CyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:54:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F11ED3CBFF;
        Sun, 28 Aug 2022 19:54:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B768D23A;
        Sun, 28 Aug 2022 19:54:27 -0700 (PDT)
Received: from [10.162.40.15] (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE733F882;
        Sun, 28 Aug 2022 19:54:18 -0700 (PDT)
Message-ID: <f6919bbc-e332-8d93-dffa-0cbe70463542@arm.com>
Date:   Mon, 29 Aug 2022 08:24:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220829085730.142da032@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220829085730.142da032@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

The original posted patch had author's 'Signed-off-by'. Seems like the tip
extraction have cut out portions of the commit message as well, apart from
just dropping the "Signed-off-by" :) We should keep the commit message in
the original form. Could you please fix that ?

Original patch: https://lore.kernel.org/lkml/20220824044822.70230-2-anshuman.khandual@arm.com/
Tip extraction: https://lore.kernel.org/lkml/166155215090.401.870330359879147742.tip-bot2@tip-bot2/

- Anshuman


On 8/29/22 04:27, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   6bc72375dd93 ("perf: Add system error and not in transaction branch types")
> 
> is missing a Signed-off-by from its author.
> 
