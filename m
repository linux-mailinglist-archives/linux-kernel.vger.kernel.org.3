Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2D5242C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiELCdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiELCdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:33:07 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CEC5E6B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:33:04 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 24C2Wxk5035551
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:32:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1652322774; x=1654914774;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/9Nv+1JztQ0pEZvkFRAl5cgwfegzNft3ByletLjOI2Q=;
        b=TbTD5b6Z1PRLqtt2iDyZfy6yTx6pxUulvAXyLGg6PjPXTPFCR4WQhnrplSJ74Ai+
        dpQqOqaHajN6sqo7iof5eyIvKI5uZese7fOhBJExRH3wm2pdmcjdKpbYCMVPlHnZ
        8VFGWG11xVRZWNkAvxPi/DQkfccn+ufEc8PHZpKxtR6WxzziFH4CVVQZJz7iwPYd
        W3zaDiG86PzvNuCgWYah84Q9yhjXsanvhxp8mAPTCEWJUFL37rFCYVSdpPU/377P
        6LEIUK3Cu6esL4QTwr3Xmk+QRJh/UTRAMIXjMmoXYOArbiftjd/TUl+pkCmfeqPk
        e2/sohW9jECEq+gzUMFnxA==;
X-AuditID: 8b5b014d-f66b97000000641e-87-627c71d5b27f
Received: from enigma.ics.forth.gr (enigma-1.ics.forth.gr [139.91.151.34])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 84.F5.25630.5D17C726; Thu, 12 May 2022 05:32:53 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
MIME-Version: 1.0
Date:   Thu, 12 May 2022 05:32:50 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, wangkefeng.wang@huawei.com, rppt@kernel.org,
        alex@ghiti.fr, twd2.me@gmail.com, david@redhat.com,
        seanjc@google.com, petr.pavlu@suse.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: Re: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
In-Reply-To: <20220511111851.559684-1-xianting.tian@linux.alibaba.com>
References: <20220511111851.559684-1-xianting.tian@linux.alibaba.com>
Message-ID: <c794b22ed0e91356e2c1a39849a4b893@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
Organization: FORTH
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXSHT1dSfdqYU2SwZ7fNhZz1q9hs3h25yur
        RcuHd6wWW3/PYrfY/P8Ls8XX9b+YLS7vmsNmse1zC5tF87tz7BYvL/cwW7TN4rdY+uUds8WR
        9duZLI6ev8Vksffge3aLxs/3GS32dyxkcxD0mPr7DIvHm5cvWTwOd3xh97h3Yhqrx85Zd9k9
        Fmwq9Wg58pbV4+GmS0wem1Z1snmcmPGbxWPnQ0uPzUvqPd7vu8rmcWNWhMel5uvsHuu3XGUJ
        EIzisklJzcksSy3St0vgylhz8yF7wTPZikMb9rA2MM6U6GLk5JAQMJGYO6mLsYuRi0NI4Dij
        xJ/+/8wQCUuJzZ9esoDYvAKCEidnPgGzWQRUJc6dvckGYrMJaErMv3QQLC4iYCxx/cwjZpBB
        zAIbmSX+PpjMDpIQFgiV2LZ3G9AGDg5OATeJu7PSQMJCAq4SnZPOsULMd5FYfe8PG8ReFYkP
        vx+AtfILCEt8unuRFaSVWcBaon2PAUiYWUBeYvvbOcwTGAVmIbluFkLVLCRVCxiZVzEKJJYZ
        62UmF+ul5ReVZOilF21iBEcoo+8Oxtub3+odYmTiYDzEKMHBrCTCu7+vIkmINyWxsiq1KD++
        qDQntfgQozQHi5I4L/uz8CQhgfTEktTs1NSC1CKYLBMHp1QDU8G87zsuvfJ9deOGZkH4hOD+
        GQfe9JTELFveNUdr1/Wktq1PmLYzpOqsuNJRspl9wa0NVtuO/GJL9t/R4L+trop7ssbxxeX5
        9zQ1jBPeahralW99sadCZMK7rBv7uaa7aNdks7D4fI09wH6vc73AtufCUXE6zHrr31evvqP1
        ZfeBvL4JZfr3r2W/0UoQjpgf+/l8BbfpzvW7tbbJ6GSvCIm+y9P68VqVcRQTw629G+K1p6zn
        CJW6vf+HTZ2d1Jntb/ellx6WkJyY8lLiyG+b89pmkZdsb/pzKAgtfZr86rXa9dqQh2kyLU4G
        XwsymEQd84+yLwtOuBzGkHi79SJz5JMOC1WbB2HfxdK5Hf+HK7EUZyQaajEXFScCAC1LXTA/
        AwAA
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xianting,

> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..71f2966b1474 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -214,7 +214,7 @@ static void __init init_resources(void)
> 
>  		if (unlikely(memblock_is_nomap(region))) {
>  			res->name = "Reserved";
> -			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +			res->flags = IORESOURCE_MEM;
>  		} else {
>  			res->name = "System RAM";
>  			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;

The short story:

This makes sense but we should at least mark them as 
IORESOURCE_EXCLUSIVE, and also remove IORESOURCE_BUSY from line 192 
above 
(https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/riscv/kernel/setup.c#L192).

The long story:

The spec says about no-map:

"
Indicates the operating system must not create a virtual mapping
of the region as part of its standard mapping of system memory,
nor permit speculative access to it under any circumstances other
than under the control of the device driver using the region.
"

It basically says that only the driver that uses the region should be 
able to create mappings for it and access it, and even that is not 
enough to prevent speculative access to the region by someone other than 
the driver. The thing is we can't implement this in a simple way because 
-to begin with- we don't have a way to pin those regions to specific 
devices/drivers, the memory-region binding doesn't say anything about 
that. When using devm_ioremap_resource() the first driver to claim the 
resource will mark it as busy so other drivers using the same api won't 
be able to use it, however the region can still be mapped in other ways 
(e.g. through ioremap directly) so using the resource tree to 
track/protect the regions marked with no-map isn't enough. They can even 
be accessed from userspace through /dev/mem unless we add them to the 
resource tree as IORESOURCE_MEM and enable/set 
CONFIG_IO_STRICT_DEVMEM/iomem=strict, but even then in case the 
corresponding ioresource isn't busy (e.g. hasn't been claimed by a 
driver yet through devm_ioremap_resource) we still have to mark them as 
IORESOURCE_EXCLUSIVE for iomem_is_exclusive() to do the trick 
(https://elixir.bootlin.com/linux/v5.18-rc6/source/kernel/resource.c#L1739) 
and prevent access through /dev/mem.

Finally the definition of no-map and the definition of MEMBLOCK_NOMAP 
are not the same, all MEMBLOCK_NOMAP says is "don't add to kernel direct 
mapping" so ioremap that uses vmalloc can still be used by everyone, in 
general it's a mess. It becomes worse, if you mark a reserved-memory 
region with no-map and that region overlaps with /memory, 
early_init_dt_reserve_memory_arch() will isolate it, mark it as 
MEMBLOCK_NOMAP and won't add it to memblock.reserved, if it doesn't 
overlap it will just ignore it and still not add it to 
memblock.reserved. So if we want to add a reserved-memory region that 
doesn't overlap with /memory (a valid scenario allowed by the binding), 
there is no way to mark it with no-map.

When I wrote that code I was looking for a way to prevent access to 
reserved regions through /dev/mem and by other drivers, regardless of 
being part of /memory or not, and since I couldn't mark them with no-map 
to track them because of early_init_dt_reserve_memory_arch(), I marked 
them as busy and then used them from the driver with ioremap directly. 
It was a temporary measure until I had a better approach (e.g. override 
ioremap / devmem_is_allowed like other archs do) but I never got the 
time to finish it, sorry for the mess !

Regards,
Nick
