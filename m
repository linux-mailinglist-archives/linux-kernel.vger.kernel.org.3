Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5968057F627
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiGXRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGXRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:24:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19009E00A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:24:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 666715C00C4;
        Sun, 24 Jul 2022 13:24:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 24 Jul 2022 13:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658683481; x=
        1658769881; bh=EeV+NW65LBch6mNGDCLaD34T6kF11Zy8g4cFp+FfFpE=; b=m
        hcSLTA/X5S34jIznRsDMB58z1ovfW7VrGARmMvEhIrUs1o6DMHxEqiW3HLnvHNfU
        Ura+VB8voaJQ/yjEEY9tj2ojbd93aILI8N7qnUgwpStwG2TOhnGOrsoMAjNSxR87
        1ZPZDnmxiBPwlLAIp/hkUP/P3dN4OYwPVW6mg5IHZS7njbb8qI0UUlTx9Wns62Sd
        2EpcqNBdtisir4/3WwVk635fvnZOeVbylHBWROXfMUIRFKQlZ68zogIT7LhUZfZJ
        tFwcKbKZXsoz9SXFXMMP/wl4+L2S/5PHcs1VT5yhGs990BTMqqCOMdUe/EPhNFcK
        YiBuBa7AYJXZIbjCTcpdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658683481; x=
        1658769881; bh=EeV+NW65LBch6mNGDCLaD34T6kF11Zy8g4cFp+FfFpE=; b=c
        nJWRDAYNaKT4xPxchZ0Xi4zjs2FbLYgfLW6Whbw4hy4E/UUKF9ucormtJlZrmlxX
        AjjTRn8sSBcYh+0o33N8zgUkDnh5X0EFUiaRYsr/Gs/PZGoSxKjXiSYRELrJLoAC
        8utw7pR61PaC78tFNHzFtijGYNZVxP6r6oGHeGgr/F1CLYNKLD5/x74Yusksnqg3
        F1RZN0E1UQ8A0pQTLVN1JTjtRCDEmqkOvrxwEme1JY1KMnkmzrnL/Ve2fuk9Fkqb
        66szOc3MRQQoMF4qgK6ZNWUP1kBnXm9/NZH4W+BqeEKith338x8uxKJKntFDPfqN
        J+3ODcg2U2Ztbp8slieTA==
X-ME-Sender: <xms:WIDdYpf1RNRqXIHwvyLFh0NTvgwRpt2a5dmqlvjilIYfoeW-s23zQg>
    <xme:WIDdYnNXLPdyyDjVNhNE5jB-qZ6qYQFbjGkEUfVU7q6acl0d7vmFiuigV_b7sYEDW
    52BEgZozYH5OtJiWA>
X-ME-Received: <xmr:WIDdYijm1mMUEDj9HckjAhtAlgeF5kIZ09gGWyvGf5t7xgXmhV-7wNd8xibHW6dTOGXmSmmwRrr6yOcZgfxMHuW-SUq6UcHPDjeYPIMQGmiS0sAa4b8wSPtVAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnheptdevhfehhefgvdekteffleduueduheduuedvtdevleelkeev
    vdeuvdeihfekueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:WYDdYi9bC7ej5a8z5_P5LSGugFEfQegcAqHhGKvLZh4Ymy15wt6ULg>
    <xmx:WYDdYlvRWTGxxavkNUOWxjx4HpexuiepRTFa5MCIE7FdlIN8OZya6Q>
    <xmx:WYDdYhGCICBWtHj9wioMiBHwVl9bN3P62nn9axM3ccqRj4N77gDWnw>
    <xmx:WYDdYtK4FpZnBRyjneEv-dfhu9sRCXk2ocidw2oreqp1nPp580pYmQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Jul 2022 13:24:40 -0400 (EDT)
Subject: Re: [PATCH 0/2] riscv: Add macro for multiple nop instructions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-24b00ffb-dcaa-40b3-8da3-2c2fe26ea3aa@palmer-mbp2014>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d684ed27-2530-4470-a320-80baadbb6197@sholland.org>
Date:   Sun, 24 Jul 2022 12:24:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <mhng-24b00ffb-dcaa-40b3-8da3-2c2fe26ea3aa@palmer-mbp2014>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 7/21/22 9:16 PM, Palmer Dabbelt wrote:
> On Tue, 07 Jun 2022 07:30:57 PDT (-0700), heiko@sntech.de wrote:
>> Some cases need multiple nop instructions and arm64 already has a
>> nice helper for not needing to write all of them out but instead
>> use a helper to add n nops.
>>
>> So add a similar thing to riscv and convert the T-Head PMA
>> alternative to use it.
>>
>>
>> Heiko Stuebner (2):
>>   riscv: introduce nops and __nops macros for NOP sequences
>>   riscv: convert the t-head pbmt errata to use the __nops macro
>>
>>  arch/riscv/include/asm/asm.h         | 15 +++++++++++++++
>>  arch/riscv/include/asm/barrier.h     |  2 ++
>>  arch/riscv/include/asm/errata_list.h |  8 +-------
>>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> Thanks, these are on for-next.  I had to fix up some minor conflicts, but
> hopefuly nothing went wrong.

The conflicts are because the patch was sent on top of fixes, specifically
e83031564137 ("riscv: Fix ALT_THEAD_PMA's asm parameters"). Since you applied
this patch without pulling fixes in to for-next, now for-next conflicts with master.

Regards,
Samuel
