Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527C95325A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiEXIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiEXIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:52:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5067D21
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:52:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c14so15906580pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5mOl2Uo5pCwJnv90x/yHkDj4UN/bNx3LCnduTlcWjo=;
        b=i4zg+Y7MIIF4uJ9R1w/Eo3gDfPpT0F1CXJcbTeIfJRWe+Dl9WvvD+GxiE0OGSqNYkp
         r1//YqBVgQ1OGfAcR+HuN2rIT3bLetHJCS9X3AFMEtvE0Jco2ypCyj5AW4zhXEsAziYK
         EEsAUu1Q1QwkAakCl//L0bAUpAHj5EucsZbPm+n7He+dOo1R4mZrPO4zARvSmGXVDMKL
         3hzchPtS54AlbzOJPKZjJyr7iUPsuxp1ctJVqpekTWhhSfdzZeBuidRLXhwOvHWyX/tl
         9nasJTdm+W/h7b6gWvBfMepGYm+hJdEtb1lR8B6NYUTZyyrmhfNyfAVDeQ5LCAjQLCvW
         G3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5mOl2Uo5pCwJnv90x/yHkDj4UN/bNx3LCnduTlcWjo=;
        b=WBXd5q0zP63JgiuIrsgV6wy40BMNOy+GJ7gEExAg8pz4NR3otGibZGYkybS6Jhaplo
         5nenlMpQFUZX8bM3MSOjSq34UvNoGG8ejGT2TTjHIabl2YVdLSGvGzpLXGbBtc4d2UdY
         Y4L1begdxgsil3r5xrz/NGrcxeulgBhqiWRNJtGkv8oAWGz2ISX/vUSzHdRbNkL+n9vp
         KHSpxWgTLSYcZCsYxWMxF97ufwJXdumxcfN3zE5jMO9MSKVS0+2fodYT5ixLwyVBh4qO
         7og6SX7CxSYyS/c1imnpHNkY6O8GYpzkzsQYrBfcVEdnlWceq3Oxi5Ab9EMdJRtJVKke
         2Ibw==
X-Gm-Message-State: AOAM533mQYQqetMlQquHp20fct9ZaLefxPdO2vuTYV1nBm0fh+ZWRk5C
        s/drwFHf8yANkPH8gRUD0PQ=
X-Google-Smtp-Source: ABdhPJy/6FsFaURgzvPIkmOwFayEsPRqCnbqFBf9gzfqCLnY+rTy2QpBUj7FydyL2tDndNV7vJLz2w==
X-Received: by 2002:a65:61b0:0:b0:3f6:5569:94e4 with SMTP id i16-20020a6561b0000000b003f6556994e4mr20902783pgv.430.1653382325044;
        Tue, 24 May 2022 01:52:05 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id rv9-20020a17090b2c0900b001d97f7fca06sm1161451pjb.24.2022.05.24.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:52:04 -0700 (PDT)
Message-ID: <628c9cb4.1c69fb81.aec05.30a1@mx.google.com>
X-Google-Original-Message-ID: <20220524085202.GA18754@cgel.zte@gmail.com>
Date:   Tue, 24 May 2022 08:52:02 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        ammarfaizi2@gnuweeb.org, oleksandr@natalenko.name,
        willy@infradead.org, linux-mm@kvack.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each processg
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoSZE7Iak3AYA4VE@balbir-desktop>
 <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
 <YoTjJH7+QD+DSrW8@dhcp22.suse.cz>
 <6285e519.1c69fb81.4f3fe.8057@mx.google.com>
 <YoX0TWoNw3HqH/X/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoX0TWoNw3HqH/X/@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:39:57AM +0200, Michal Hocko wrote:
> On Thu 19-05-22 06:35:03, CGEL wrote:
> > On Wed, May 18, 2022 at 02:14:28PM +0200, Michal Hocko wrote:
> > > On Wed 18-05-22 07:40:30, CGEL wrote:
> > > [...]
> > > > 2. process_madvise is still a kind of madvise. processs_madvise from
> > > > another process overrides the intention of origin app code ifself that
> > > > also calls madvise, which is unrecoverable. For example, if a process "A"
> > > > which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
> > > > already, meanwhile, if another process which doesn't know the information
> > > > of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
> > > > "A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
> > > > is erasured permanently.
> > > 
> > > I do not really follow. How is this any different from an external
> > > process modifying the process wide policy via the proc or any other
> > > interface?
> > 
> > In this patch, you can see that we didn't modify the flag of any VMA of
> > the target process, which is different from process_madvise. So it is
> > easy to keep the original MERGEABLE information of the target process
> > when we turn back to the default state from the state "always".
> 
> This means that /proc/<pid>/smaps doesn't show the real state, right?

Maybe we can add extra information of KSM forcible state in /proc/<pid>/smaps
like THPeligible. 

Really, Michal, I think it again, 'process_ madvise' is really not good. In
addition to some shortcomings I said before, If new vmas of the target process
are created after the external process calls process_madvise(), then we have to
call `process_madvise()` on them again, over and over again, regularly, just like
Oleksandr said [1].

[1]: https://lore.kernel.org/lkml/1817008.tdWV9SEqCh@natalenko.name/


> 
> -- 
> Michal Hocko
> SUSE Labs
