Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA73F5033B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiDPCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiDPCV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:21:58 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C43CA78
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:19:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4DAE23202175;
        Fri, 15 Apr 2022 22:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Apr 2022 22:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650075565; x=
        1650161965; bh=uR0sd88BLmMrf7MsnBeqOtT78ti+J0aJP6bHQT/zSLE=; b=E
        glxmXf+SI4CDdpXMXB7wN8WI0nFOSI23u7ZE/NmHcY9fcYGe5lROyBIcXGYYigE0
        ThIPTBbNiL8GaKnb58hGC3jCNtT4y8XeKMFhye1oE2meRNObKP9M+tBkCkiD8FMW
        XrjpIEV11wbY5nEL+zBy7noJuVyeIMxnXQGCIvmPQ5wr3G8ynoKqd9tt/x9LTUro
        WaJ7+oSzZWRh4LG6rzB/ngcmEH+wLjsgXd+jmsoTkSSxQ+drzoHjOlL0VikdsGLb
        Krw3Cseicac7j+KqGDTeeqGTj9nydcJ/rSIYGxMmuYdvPAhjUPXo+d3M3fm1JIRT
        zBxC4Sv+n+GInvJEEaUhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650075565; x=1650161965; bh=uR0sd88BLmMrf
        7MsnBeqOtT78ti+J0aJP6bHQT/zSLE=; b=Gt8Zt2lEArqf2/mO0KiViDbQJwwy5
        7c+w+8bceIV1BuacYNqOx9IXV7IqXnZK367s+nyObbpceND2jFQw6TJXgl3/LZAC
        cBKHDkiQ0+WUYDmy1enCRpXDS3c9z89hAlSzeSaJPX/9NY5iKdnhMr0STOPifX/J
        V7tPQ5EeCTJ/fUh731G9K56SdkrzZJyjn4M1SjNLJCgCbB/rw90ZcRdNuXZv28s5
        tRHTdCIWP8HPL8Ld2kBvkzvsCddXaNx8rxxYWC4fNy8DNdbxSN0rPXzv1A64bLHd
        a1gWNHRU23X1+pNkzYEglYUjC7Hr/WjAOPoVYleybNJldiebeVAU5v6UQ==
X-ME-Sender: <xms:rSdaYpQF3FHxxFJdLWe3j1gDZh8kZQoHZ_LkqpAvSV3V4U3n1GRoaw>
    <xme:rSdaYix0F0wSy7kbb5KSp939cAV2wSJ48fKFocqw2E2NxnJMPPGKnIM_mn7dRMiPo
    NcN91x9mmc-l_OquQ>
X-ME-Received: <xmr:rSdaYu1WTLDnreKBpf_s2hxCYV6N16iX-S-zJPg4QbVHzjYvaRiw7lWJ40uKboB3zZK0j2TLAtAwVHRe21bcf4qUCkXSC7uzfHr0IxBrXaggc4IrgkNXkVry5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeliedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuddvleffkeejhfduieelheejteehleefieeikefgteeugefhtdev
    keefvefgheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:rSdaYhBd-ZNa7gitLBsclKr6QZWZ2V3UbqPAuTNMlYzS0_HdYVoNNg>
    <xmx:rSdaYijEzPHMR23ne-4-5q70_FDxXZgyRtY17ZyG4ziRssMGLNvFkA>
    <xmx:rSdaYloRMvK_8NrirfsYODhuSAHB-uMLHfo7QqHECIZZ2K2r3f0xaA>
    <xmx:rSdaYpouN75HsdXz_4oKjYy2bBVDVZIPbxIqvnxa2fKvNdxEr4e95Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 22:19:24 -0400 (EDT)
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
Date:   Fri, 15 Apr 2022 21:19:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YllWTN+15CoskNBt@Red>
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

On 4/15/22 6:26 AM, Corentin Labbe wrote:
> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
>> This series is based on the alternatives changes done in my svpbmt series
>> and thus also depends on Atish's isa-extension parsing series.
>>
>> It implements using the cache-management instructions from the  Zicbom-
>> extension to handle cache flush, etc actions on platforms needing them.
>>
>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
>> different set of cache instructions. But while they are different,
>> instructions they provide the same functionality, so a variant can
>> easly hook into the existing alternatives mechanism on those.
>>
>>
> 
> Hello
> 
> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> 
> I am hitting a buffer corruption problem with DMA.
> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> In fact the buffer is not overran by device but by dma_map_single() operation.
> 
> The following small code show the problem:
> 
> dma_addr_t dma;
> u8 *buf;
> #define BSIZE 2048
> #define DMASIZE 16
> 
> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> for (i = 0; i < BSIZE; i++)
>     buf[i] = 0xFE;
> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);

This function (through dma_direct_map_page()) ends up calling
arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
cache. This is the same thing other architectures do (at least arm, arm64,
openrisc, and powerpc). So this appears to be working as intended.

Regards,
Samuel

> dma_unmap_single(ce->dev, dma, DMASIZE, DMA_FROM_DEVICE);
> print_hex_dump(KERN_INFO, "DMATEST3:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> 
> Will lead to:
> [    2.960040] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.965354] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.970709] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.976069] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.981440] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.986814] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.992188] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    2.997560] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.002934] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.008307] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.013680] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.019054] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.024427] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.029802] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.035175] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.040546] DMATEST1:fefefefe fefefefe fefefefe fefefefe
> [    3.401647] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
> [    3.406982] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
> [    3.412350] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
> [    3.417720] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
> [    3.423094] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.428468] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.433841] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.439213] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.444588] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.449962] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.455334] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.460707] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.466081] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.471454] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.476828] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> [    3.482200] DMATEST3:fefefefe fefefefe fefefefe fefefefe
> 
> Even with no DMA action, the buffer is corrupted.
> 
> Regards
> 

