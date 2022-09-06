Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0595AF87A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIFXnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIFXnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:43:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E1C868A3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:43:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id iw17so6165926plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/qu2n9BlVn7Hcbe1BO172p4KxMySv9JPsd+DqpGVTAU=;
        b=bMZjQCiygEcwxhJnXa9R9YZP7JXsM125Q0KenhaZn15zQhU9FrF7bsgd4LBLa7mZsr
         D9dsj3DLjoyN9yufdg1WnDe4N4JXU3qYJbPLXqxfSVBvmTIvTdJvW627WeWHvJQo6h7p
         Bvff4fbhgquyQh892WIxr5eqJrLRtnb/txmWbR+P/YfnqcwSGx3rROaJpsFGJrGr/man
         K/JT/ZzhW54VgS+b8c+NL7VFwQ13V8vOudEwGyKJI63vhrjLBFklscwuEVrQAEL8e+Xk
         aTZRxs6FchWNO7q0Xzv9hHZIw+Wy56xYLXyrkpP7vwhpjvOYfrtOB3JyII25C9y98Yfu
         aQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/qu2n9BlVn7Hcbe1BO172p4KxMySv9JPsd+DqpGVTAU=;
        b=YehVQpPRS8K3+pEZzcvrnSDPseDJOfTqG+m3SFAi2Qbbjvq1/qjVZ/9YSIRO0QgJeW
         zCsNFayxsjPGJToJKwVY605uNeQaJuoI2QwqYTlcgeY/SOdkqaLrDMafSkeEEe0Sq65/
         KcSpuWyBaf1I8UGsW+Cg3vO8dpV/WHrwpO3Sz5aQ46H+kIUmd+rbHZ+VGBeOKehxIKF3
         pnPCB0Yl/vZOtiujAKLMkxfazpkdUVnj9vE25OZM/oQ88qe5XzOWZt3A7Ibb2/wdi3q9
         RTbsBOC57f8XnmNsMm9xjec5a2+NCX0V/RWKMoeZN4J2BTGYxE45EKCb/OHTjHZaPZqo
         jPSg==
X-Gm-Message-State: ACgBeo1UPQ50kzr04dLYVMvkjuSZHSwJLtLMQIuLLcIJc3GBTNXr+1+W
        wkHkcFQjQKaW4ng0cBrLzPIG0cpK9lMS5iBB
X-Google-Smtp-Source: AA6agR6e6bJhlmKpwxoAHPb43L8BCb+CSDaRKxAwiDg+TlnwBrniT4OcUn1qUKbTLCwSxNbTeAxMFw==
X-Received: by 2002:a17:902:ebc8:b0:172:549d:e392 with SMTP id p8-20020a170902ebc800b00172549de392mr1055168plg.141.1662507789398;
        Tue, 06 Sep 2022 16:43:09 -0700 (PDT)
Received: from sophie ([169.150.203.49])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a708100b001fbb0f0b00fsm13269789pjk.35.2022.09.06.16.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 16:43:08 -0700 (PDT)
Date:   Tue, 6 Sep 2022 18:43:06 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220906234306.GA4053@sophie>
References: <cover.1662264560.git.remckee0@gmail.com>
 <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
 <d57009d3-fd40-5061-31ae-203dff1e0ef7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57009d3-fd40-5061-31ae-203dff1e0ef7@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:17:46PM +0200, David Hildenbrand wrote:
> On 04.09.22 06:21, Rebecca Mckeever wrote:
> > Add function setup_numa_memblock() for setting up a memory layout with
> > multiple NUMA nodes in a previously allocated dummy physical memory.
> > This function can be used in place of setup_memblock() in tests that need
> > to simulate a NUMA system.
> > 
> > setup_numa_memblock():
> > - allows for setting up a memory layout by specifying the fraction of
> >    MEM_SIZE in each node
> > 
> > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > 16 NUMA nodes.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   .../testing/memblock/scripts/Makefile.include |  2 +-
> >   tools/testing/memblock/tests/common.c         | 29 +++++++++++++++++++
> >   tools/testing/memblock/tests/common.h         |  4 ++-
> >   3 files changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > index aa6d82d56a23..998281723590 100644
> > --- a/tools/testing/memblock/scripts/Makefile.include
> > +++ b/tools/testing/memblock/scripts/Makefile.include
> > @@ -3,7 +3,7 @@
> >   # Simulate CONFIG_NUMA=y
> >   ifeq ($(NUMA), 1)
> > -	CFLAGS += -D CONFIG_NUMA
> > +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> >   endif
> >   # Use 32 bit physical addresses.
> > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > index eec6901081af..b6110df21b2a 100644
> > --- a/tools/testing/memblock/tests/common.c
> > +++ b/tools/testing/memblock/tests/common.c
> > @@ -72,6 +72,35 @@ void setup_memblock(void)
> >   	fill_memblock();
> >   }
> > +/**
> > + * setup_numa_memblock:
> > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > + * dummy physical memory.
> > + * @nodes: an array containing the denominators of the fractions of MEM_SIZE
> > + *         contained in each node (e.g., if nodes[0] = SZ_8, node 0 will
> > + *         contain 1/8th of MEM_SIZE)
> > + *
> > + * The nids will be set to 0 through NUMA_NODES - 1.
> > + */
> > +void setup_numa_memblock(const phys_addr_t nodes[])
> > +{
> > +	phys_addr_t base;
> > +	int flags;
> > +
> > +	reset_memblock_regions();
> > +	base = (phys_addr_t)memory_block.base;
> > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > +
> > +	for (int i = 0; i < NUMA_NODES; i++) {
> > +		assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);
> 
> I think it would be even easier to get if this would just be a fraction.
> E.g., instead of "1/8 * MEM_SIZE" just "1/8". All values have to add up to
> 1.
> 
> ... but then we'd have to mess with floats eventually, so I guess this makes
> it easier to handle these fractions.
> 
> 
> We could use "int" and simply specify the fraction in percent, like
> 
> nodes[0] = 50;
> nodes[1] = 25;
> nodes[2] = 25;
> 
> and everything has to add up to 100.
> 
This would still be a float for 1/8th (12.5) and 1/16th (6.25). What if
it was the "percent" of 256 (i.e., 0x100)?
> 
> > +		phys_addr_t size = MEM_SIZE / nodes[i];
> 
> 
> Hmmm, assuming a single node with "MEM_SIZE", we would get size=1.
> 
For a single node of MEM_SIZE, nodes[0] would be 1.

> Shouldn't this be "size = nodes[i]"
> 
> ?
No, not with the current implementation. The nodes array stores the
denominator of the fraction that will be multiplied by MEM_SIZE to
determine the size of that node (the numerator is always 1). So if the
size of the node should be 1/8 * MEM_SIZE, the nodes array just stores
the 8. I think the name of the array is misleading. Do you have any
suggestions for a better name?
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
