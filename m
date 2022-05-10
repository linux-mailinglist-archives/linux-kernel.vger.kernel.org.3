Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302E520CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiEJEWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiEJEUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:20:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894539173;
        Mon,  9 May 2022 21:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC267B81B0D;
        Tue, 10 May 2022 04:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156BC385C8;
        Tue, 10 May 2022 04:15:49 +0000 (UTC)
Message-ID: <798b6222-d21e-d6b7-8cea-afcd536f094f@linux-m68k.org>
Date:   Tue, 10 May 2022 14:15:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: manual merge of the m68knommu tree with the m68k tree
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220510094442.26826532@canb.auug.org.au>
 <7bcb1248-7329-9aee-5d81-7e846cd1e461@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <7bcb1248-7329-9aee-5d81-7e846cd1e461@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/5/22 13:37, Michael Schmitz wrote:
> Hi Stephen,
> 
> apologies on my part - I had thought that I had copied in Greg on my patch series. And I evidently missed that his ELF patch would have clashed with mine.

You definitely did, I still have your patches in my inbox too :-)


> Geert and Greg coordinate well as a rule, and both patches had been seen on the linux-m68k mailing list (just too far apart to jog my memory).

Yeah, this was really an accident of timing between Geert applying your series
to his for-next branch, and me applying the regset changes to my for-next
branch.

The two changes are quite distinct, but they overlap in location within
ptrace.c file. The fixup patch is pretty strait forward, and Stephen has that
right.

Regards
Greg



> Won't happen again this decade (I hope).
> 
> Cheers,
> 
>      Michael
> 
> 
> Am 10.05.2022 um 11:44 schrieb Stephen Rothwell:
>> Hi all,
>>
>> Today's linux-next merge of the m68knommu tree got a conflict in:
>>
>>   arch/m68k/kernel/ptrace.c
>>
>> between commit:
>>
>>   c862fe70b023 ("m68k: Wire up syscall_trace_enter/leave for m68k")
>>
>> from the m68k tree and commit:
>>
>>   0d91043d8bdf ("m68knommu: implement minimal regset support")
>>
>> from the m68knommu tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
