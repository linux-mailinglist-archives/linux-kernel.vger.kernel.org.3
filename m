Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944655160D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiD3Wt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3WtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:49:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF524BE1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:46:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r83so9133717pgr.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZuAdolkaQCq2NicEkVQdhF7k7X3iiqR76mQWbveRdYw=;
        b=j46SnpkMorDJS9YRsSfb59a1ZzS6FrQJt7v4iwZHp0tDEvzwKvIGAqJQ75veRQQI7y
         OG5yws4GnQSwj1IeIZxUV2WpF9HGXk9y5fjhHopdr2ZWWnvAFKeVwO3omGuukSfUWDW+
         M8GuQWQMB9VmBJjhcfdukWGfp9GELUDybM14Uv/I7kDIIYmJlLM2tH7V9mzXVYRd65CR
         M+qDIQUPaWV2PxzEKj+VduYMHJQMwXt3V9Vp56y5r7a9n6/+qjr5ZioG4NlpBm0D28JQ
         kbd7NLyCPSBbbrSyVHpdsaYSQCo/wXyVESKKUwkrJp+7riZmZnLsRtve8GnXNE8ngTji
         LKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZuAdolkaQCq2NicEkVQdhF7k7X3iiqR76mQWbveRdYw=;
        b=i86R8iQcSs28CWlJEz99O6aPEwIRcaqlyhixLsD4oym6Atm8ieiSa9phNhHdNEf7xT
         5ygtbOG+d0nRem8id+P+YAEimuq4bDVHxiyQ3zipAznIVfLfaVHxo+qzFs0pq7gFIt5b
         c36ORBACSSYw8h9ErP3j5G//vdIcd2nA8molQikmu4metKNSeflPI2gn8BJDzhOS5dv/
         u5V8APawkJ5FNrrwLsUPGOc3LeZBdzfjj2sKAAIFlalFfTgRS9/1uTRZ+rziXD8Da9tO
         j7lDzoCkdb1W0QF5xpJXbq+OPxDQI2vV9dPiuzAA4QCXCl/kZuIdFKN4mY9biuIWuXof
         WeGA==
X-Gm-Message-State: AOAM533jbkpSKanahxjQThXz3GCFRbfUWoOaLLYfDyLDj2c1kQvqCT29
        fXYOCQudcqzlVw+B6rU2AsRuKg+lROtEYQ==
X-Google-Smtp-Source: ABdhPJyPeRzNourp0PknjsZhLuve1Bv4aN5XOascM+eWMjYUMxChKgBmRGZggeVYtR9HwPIzWPSQvw==
X-Received: by 2002:a65:684c:0:b0:3ab:7c9c:f648 with SMTP id q12-20020a65684c000000b003ab7c9cf648mr4427528pgt.562.1651358760908;
        Sat, 30 Apr 2022 15:46:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b0050dc7628166sm2011116pfn.64.2022.04.30.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:46:00 -0700 (PDT)
Date:   Sun, 1 May 2022 07:45:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] openrisc: define nop command for simulator reboot
Message-ID: <Ym28JtltM3xzPA9Y@antec>
References: <20220428111139.1330966-1-Jason@zx2c4.com>
 <YmqAx31dtXCaNn7R@antec>
 <YmqLrDfbEGP659EO@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqLrDfbEGP659EO@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:42:20PM +0200, Jason A. Donenfeld wrote:
> On Thu, Apr 28, 2022 at 08:55:51PM +0900, Stafford Horne wrote:
> > On Thu, Apr 28, 2022 at 01:11:39PM +0200, Jason A. Donenfeld wrote:
> > > The simulator defines `l.nop 1` for shutdown, but doesn't have anything
> > > for reboot. Use 13 for this, which is currently unused, dubbed
> > > `NOP_REBOOT`.
> > > 
> > > Cc: Stafford Horne <shorne@gmail.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6@zx2c4.com/
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > ---
> > >  arch/openrisc/kernel/process.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > > index 3c0c91bcdcba..4cce95fa6eb5 100644
> > > --- a/arch/openrisc/kernel/process.c
> > > +++ b/arch/openrisc/kernel/process.c
> > > @@ -52,6 +52,8 @@ void machine_restart(char *cmd)
> > >  {
> > >  	do_kernel_restart(cmd);
> > >  
> > > +	__asm__("l.nop 13");
> > > +
> > >  	/* Give a grace period for failure to restart of 1s */
> > >  	mdelay(1000);
> > >  
> > > -- 
> > > 2.35.1
> > 
> > This seems fair, probably it would be good to have a comment mentioninmg what
> > the nop is for, fyi for context these are the nop numbers used to control
> > simulations.
> > 
> >     #define NOP_NOP          0x0000      /* Normal nop instruction */
> >     #define NOP_EXIT         0x0001      /* End of simulation */
> >     #define NOP_REPORT       0x0002      /* Simple report */
> >     /*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
> >     #define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
> >     #define NOP_CNT_RESET    0x0005      /* Reset statistics counters */
> >     #define NOP_GET_TICKS    0x0006      /* JPB: Get # ticks running */
> >     #define NOP_GET_PS       0x0007      /* JPB: Get picosecs/cycle */
> >     #define NOP_TRACE_ON     0x0008      /* Turn on tracing */
> >     #define NOP_TRACE_OFF    0x0009      /* Turn off tracing */
> >     #define NOP_RANDOM       0x000a      /* Return 4 random bytes */
> >     #define NOP_OR1KSIM      0x000b      /* Return non-zero if this is Or1ksim */
> >     #define NOP_EXIT_SILENT  0x000c      /* End of simulation, quiet version */
> >     /* New! */
> >     #define NOP_RESET        0x000d      /* Reset the cpu */
> 
> Right, that's where I got 13 from. By the way, the .tex file only
> mentions ones up to 11, so at first I chose 12, and then saw this file.

BTW, I have queued this for 5.19.

> > 
> > I will queue this once we update the spec to define some of these, I am thinking
> > if qemu should allow for the shutdown to work in user mode.
> > 
> > BTW, are you working specifically on openrisc? Or just setting up test
> > environments for all architectures?
> 
> Trying to get OpenRISC up on https://build.wireguard.com/ . The other
> architectures were simple, but OpenRISC is requiring some work...

Thanks, any work is appreciated.  Now, I am going to go and replace my openVPN
setup with wireguard.

-Stafford
