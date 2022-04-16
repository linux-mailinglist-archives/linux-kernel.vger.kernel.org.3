Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402C5037BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiDPRuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDPRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 13:50:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279602314B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 10:47:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DD21D320100E;
        Sat, 16 Apr 2022 13:47:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 16 Apr 2022 13:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650131251; x=
        1650217651; bh=QzHqO3qBPfISWOnlbh83TMK3WpZoHmvC2YIjH+rKF78=; b=X
        qYFGHB+RVrC494RYE04j3twORzmRPRWHFHmUNtG/F3S7lKlXwbg8y3rlKsc/HgMH
        nTCT45Jjk201BGpPWmaEI/nasFGalXwPA3SJH9d/udRj7S3WHunnPkeeNBVJvc6n
        iuFt2IICMx+g7xwOI2Oxs1Ur6l/VYS2yT5WFFAAaY1iIvmftFP7H99hIpNJiwWra
        cVLd13xCyjY3d7hovH3XtR4j8R91tiAK5vObr4WWCMe7WdKTiVFZ744b7oS4vg6G
        hmxTCcAsSlObAZF7bQ06hhWsX3ES7VkHDGzb5c1tB38E2Z5PnZqa8bqI/MBot1RL
        alD2gAiS8TvWSFjCvyZuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650131251; x=1650217651; bh=QzHqO3qBPfISW
        Onlbh83TMK3WpZoHmvC2YIjH+rKF78=; b=t3hTVxaxhK+qcHEB+DRYNqb8Dg3zu
        JjSpBrAVuTDqxFqWDvZdEhLXeMieAVeOZ/cR0w9eO9Zk03ewwb7tFf0BrkrbrJBH
        x0dthUc46+ftxYA6UgjFD6CqmnGc+ClVYuHjLrbXaW/Ikbk5s1tBuf5+VJaa0tNP
        Sejgd42AJJBhq4IifIIBLVESfFF3pxckG74YiHb5ZWXR8DMToewv3khBBhP2ds75
        VS12elzJ/K4BZVqkDR5+gML1pteEe+dbC5eL6DiDcWVM3VYQwdVciozQFokwJu1d
        tKpbivZ+VVKcOd6dz/l6f8yF48w3CsvioUenJ2XKlJMDGSeu7eAPblVMw==
X-ME-Sender: <xms:MgFbYnQSnsFiCpK8yrPGMEu22Tg86COCm56Xq5uoaCxzCT8PFfYBoA>
    <xme:MgFbYowvyFe7Sp-fj8j_dXjiYZ9r429dkc_zT-fXWf_lPr6pQItfDTMYsLVPtisot
    jSDl-_w8_YzV2Wwhg>
X-ME-Received: <xmr:MgFbYs1eZG8-osXH3PG48gEWvwwXw5BrrBw-gOi_WrhjGIdDx5W-y4t4NVm7oE9neilVmpYumx6iUw83O5gGVjwryd14IGR2WO7j3-Ee5rq7_c3v12urBULNlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeljedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduvdelffekjefhudeileehjeetheelfeeiieekgfetueeghfdt
    veekfeevgfehieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:MgFbYnD3xwpEQVkZ6-Uvq23JIMkjoaoA91tUW_gHXh2AaUigocCwVw>
    <xmx:MgFbYgi_9rZ-BaEb2caweWEPcw_ctH05v_UCHBEVoo4PeaNww12b3w>
    <xmx:MgFbYroi9yKuzJhO7BAOjsr-u2g8S0kU-9qH-pR6qRx6nrJxcARCJw>
    <xmx:MwFbYvpX44nV_uY4dVEDK-kF3jxlOSmUOnegGv2pbKhal3n1vzqXTw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Apr 2022 13:47:29 -0400 (EDT)
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org> <YlpxsYREWv/LQ+HY@Red>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
Date:   Sat, 16 Apr 2022 12:47:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YlpxsYREWv/LQ+HY@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/22 2:35 AM, Corentin Labbe wrote:
> Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
>> On 4/15/22 6:26 AM, Corentin Labbe wrote:
>>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
>>>> This series is based on the alternatives changes done in my svpbmt series
>>>> and thus also depends on Atish's isa-extension parsing series.
>>>>
>>>> It implements using the cache-management instructions from the  Zicbom-
>>>> extension to handle cache flush, etc actions on platforms needing them.
>>>>
>>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
>>>> different set of cache instructions. But while they are different,
>>>> instructions they provide the same functionality, so a variant can
>>>> easly hook into the existing alternatives mechanism on those.
>>>>
>>>>
>>>
>>> Hello
>>>
>>> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
>>>
>>> I am hitting a buffer corruption problem with DMA.
>>> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
>>> In fact the buffer is not overran by device but by dma_map_single() operation.
>>>
>>> The following small code show the problem:
>>>
>>> dma_addr_t dma;
>>> u8 *buf;
>>> #define BSIZE 2048
>>> #define DMASIZE 16
>>>
>>> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
>>> for (i = 0; i < BSIZE; i++)
>>>     buf[i] = 0xFE;
>>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
>>> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
>>
>> This function (through dma_direct_map_page()) ends up calling
>> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
>> cache. This is the same thing other architectures do (at least arm, arm64,
>> openrisc, and powerpc). So this appears to be working as intended.
> 
> This behavour is not present at least on ARM and ARM64.
> The sample code I provided does not corrupt the buffer on them.

That can be explained by the 0xFE bytes having been flushed to DRAM already in
your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were still in
a dirty cache line. The cache topology and implementation is totally different
across the SoCs, so this is not too surprising.

Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing a
unidirectional DMA transfer from the device into that buffer. So the contents of
the buffer are "undefined" until the DMA transfer completes. If you are also
writing data into the buffer from the CPU side, then you need DMA_BIDIRECTIONAL.

Regards,
Samuel
