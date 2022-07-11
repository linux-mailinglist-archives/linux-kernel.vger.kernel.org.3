Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADD570009
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiGKLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGKLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EF273B;
        Mon, 11 Jul 2022 03:40:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bf9so7946610lfb.13;
        Mon, 11 Jul 2022 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKUP88tFfL4ob57kLuQtLQDMBfz35DAQY6r3VlU1mf0=;
        b=a9PmZb1xGozPn2iBGEJ+GaeXt02e0hsZkWJj7XS4kv2H1XgVVprv2HeDALTTfu+Z6r
         umWMgZnd8unLH1HrkEgbSIvx7bvu2gl6DDtu9TQrlQIiwsMXvmbzAbSrhBSUD9yUgnl/
         iY/nhDDf5ZpsBjxfRhsOl7P/N1k2vyVUfJAQjkJ/eWnffLuaDeuJ6K6ELIj9fvDtQLaN
         jflsV5WgBROyRRc6wYdOev/rHUsDtr75eGW/tWjkuliyLgstVsDPei1c8ZCGqeOf2SpY
         lJL4EDfOxknhQpv0U2XpwS+6FmeHcnXh1xZLTQKfIegNMnJL0dJb3Y6EVMiyaeE65Fk6
         XUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKUP88tFfL4ob57kLuQtLQDMBfz35DAQY6r3VlU1mf0=;
        b=PywIo/h/e8AKLuXMAPuFq5O2Wzo7E8UXFpl8976460TAdlqdTdUqD18d+ePEsIs9t7
         jprgXFpdmdAehCONn3ihahbb/tSqRIxI20R1YribyKn5rSQIaNkeQmhciuTsVJsBoUCG
         xWEwiWT/3YALVPDkvtNlgx9ik7inmdxlIY8csJYzhZgrmSzR0VMoYfOwVi3unpvoJFxl
         Z/77xJdEqPtBiKy0OEbyDz36KlpNgELd3oMRFyKujDiBYE5itF8wr2zzPLCtwltdV4dc
         M435HBxZUbfpdXzui4/DFLekM1P0ht9vfhA3H0rIl3sXFvhXP/wqQYhigNVqlo0U1Edz
         Cwcw==
X-Gm-Message-State: AJIora9GJw1pUCmwwjq+utKD9vUjGslQRUIN8BAcFufrnimfczcD8mQF
        wr95PvF33OIpnWHSV3963W4=
X-Google-Smtp-Source: AGRyM1vVW9WXDcKATAA7avv9aPKQVo3u32IId2Oc4FUeeoT0beEGc9ikNKwuWa5D7Eq8T/yf801bvQ==
X-Received: by 2002:a05:6512:1698:b0:47f:b5a6:6870 with SMTP id bu24-20020a056512169800b0047fb5a66870mr11063346lfb.578.1657536054874;
        Mon, 11 Jul 2022 03:40:54 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id m5-20020a2ea885000000b0025a7338317esm1625353ljq.64.2022.07.11.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:40:54 -0700 (PDT)
Date:   Mon, 11 Jul 2022 13:40:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@vger.kernel.org, gerg@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220711104052.ddefbgd34xbbjykg@mobilestation>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220711083848.GE6084@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711083848.GE6084@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 10:38:48AM +0200, Thomas Bogendoerfer wrote:
> On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> > It is permissible for kernel code to call virt_to_phys() against virtual
> > addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> > types. Add a final condition that ensures that the virtual address is
> > below KSEG2.
> > 
> > Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  arch/mips/mm/physaddr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> > index a1ced5e44951..a82f8f57a652 100644
> > --- a/arch/mips/mm/physaddr.c
> > +++ b/arch/mips/mm/physaddr.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/mmdebug.h>
> >  #include <linux/mm.h>
> >  
> > +#include <asm/addrspace.h>
> >  #include <asm/sections.h>
> >  #include <asm/io.h>
> >  #include <asm/page.h>
> > @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
> >  	if (x == MAX_DMA_ADDRESS)
> >  		return true;
> >  
> > -	return false;
> > +	return KSEGX(x) < KSEG2;
> >  }
> >  
> >  phys_addr_t __virt_to_phys(volatile const void *x)
> > -- 
> > 2.25.1
> 

> applied to mips-next.

Are you sure it was ready to be applied?
Link: https://lore.kernel.org/linux-mips/20220708115851.ejsooiilxcopkoei@mobilestation/

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
