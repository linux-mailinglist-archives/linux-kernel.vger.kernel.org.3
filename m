Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770F4D3987
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiCITIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiCITHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:07:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D1125CA0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:06:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t1so3920379edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2g8teGb2ODn0CDQ8nSQb9mMJm/KJVOTIv5pQ0Q8Uuk=;
        b=pk/rjukV1mbmtZOj/nxQwS7XII4oIhUGwxrukbtopTgJ5A2TVqsAp1wL/GyoYG8FoU
         anpE67JrDtCU1pwnh0LeRo9++vt4IjORS1/A2dDyNJEqJt0eGizGCh2EkWRUvgFCP2O7
         wFC6O+P9qYRVOgeSIIqM05DIRgWtzWSP/ciAEOPq/7w/k9k4p0UYEIenyd+MOVQoiXzP
         dkBfsLjsEJ/kUcJkElKLbNfTt2IpG7HhnrDwseV4t+rWXQhFlbwcT3iPBF9Vmway2rlm
         P/GECQSLo4ohhNJHSfw0XElBQ1tokltfQ5stAD+QWM5K0HgSygxJMUt4MHighzOnyG4b
         3LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2g8teGb2ODn0CDQ8nSQb9mMJm/KJVOTIv5pQ0Q8Uuk=;
        b=BCSFW9oaLkoGrIisa3JTBIjTmnbKKx7pIbwHG8p4gVxeLuxu5Grzwc0Tq/8HZ6alL/
         eKY8X8uqWg4ARtnJaaFbEPB3euwYSmF5rrqy5hKTXBi2prfYM7CgvUrNczocxoJhuvAy
         g2CIkpZ6SoJ2nSN2yPcBCUOXthbEsPW1uXP1bboxcMu062kV1MoVFMK4LnsaXG8nwLTY
         7bRAosn9+pIG8Rmdz5tVjEvPBhCq0vkaKJMZniC/QFwlUA0zQ8YzGsfr4OofPSHYafjy
         /CTYQ6uRi1qB5M6zHuRkj+qWhaic9jPJunGt/TEd8p5FgmOiL9hKw0kyeHZsXWk8d+pr
         ZOAQ==
X-Gm-Message-State: AOAM532R8burwRWcHFCdQxdPCjnNMBhmk+9cK2vPuX9HppUiko11/Bqc
        xZ8GQmfMPXyQ3UgoaFYMnXg2gxcy34MEIA==
X-Google-Smtp-Source: ABdhPJxN0XNCZSxxiO+Tu9bNLiocKNU7p1Ep26SRnUfIPUlxvXFIWSeC7OC5gJzxvnXNY7LlUJOpRA==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr951228edt.246.1646852812691;
        Wed, 09 Mar 2022 11:06:52 -0800 (PST)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id c6-20020a05640227c600b00415e926bbe1sm1147153ede.89.2022.03.09.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:06:52 -0800 (PST)
Date:   Wed, 9 Mar 2022 20:06:51 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220309190651.GA3735@pswork>
References: <20220307184011.GA2570@pswork>
 <20220308163600.3109f19854c7b051924f262b@kernel.org>
 <20220308174829.GA2471@pswork>
 <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:01:24PM +0900, Masami Hiramatsu wrote:
> On Tue, 8 Mar 2022 18:48:29 +0100
> Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> 
> > Hello Masami Hiramatsu,
> > 
> > On Tue, Mar 08, 2022 at 04:36:00PM +0900, Masami Hiramatsu wrote:
> > > Hello Padmanabha,
> > > 
> > > On Mon, 7 Mar 2022 19:40:11 +0100
> > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > 
> > > > Hello Masami Hiramatsu,
> > > > 
> > > > Thanks for detailed explanation on boot time tracing using early boot configuration file.
> > > > https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf
> > > > 
> > > > Also for https://lwn.net/Articles/806002/.
> > > > 
> > > > Latter link also states we can embed boot config into the kernel image for non intrd based system.
> > > 
> > > Ah, that was an original plan, but since no one interested in, I didn't implement it.
> > > So we still need the initrd for bootconfig.
> > >
> > Ok.
> > > > 
> > > > I tried searching mailing lists not able to find pointer for same.
> > > > 
> > > > A hint/pointer on how-to will be very helpful. 
> > > 
> > > BTW, what is your problem, could you share your use-case?
> > > 
> > 
> > I have hetrogenous system which donot use intrd.
> > 
> > The use-case is to capture __system wide__ event based tracing for
> > boot-up sequence, which also covers early stage of default init programs
> > used.
> > 
> > As buffer size is limited, will have hand-picked events set configured.
> 
> Hm, so I guess you will boot linux from your custom bootloader (or binary loader on sub processor?).
>
Yes, customised implemation which loads linux. 

> Can you even try to add a dummy initrd? or are you OK to rebuild kernel for embedding the bootconfig data?
Yes, re-building the kernel image to appended bootconfig data is feasable option.

> If both don't work, the solution will be architecture or bootloader specific.
> 
> Thank you,
>

Thanks and Regards,
Padmanabha.S
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
