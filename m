Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36895336F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbiEYG4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbiEYG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:56:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAB62E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:56:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ds11so18909050pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnCjWu89qxOeZvUeYKgLrL67m/1ovdJFmFA+h6t4yJg=;
        b=lN4TpjftivnR9SEc4SzLFhhQ4OTw+aIVbrMYJx1nI8YZmfCoQPb+zuEbJgj4oFXvYv
         bm4QsuaiMsoWLUEOn3wAxli9TvRd/cTU9xK2gtFKmPu92Sp/d0nraVzzqB2UzJQcQn16
         3jcU6GNGkaQKJ0IpdUWmy+SpM8j1OC86DVlSeJFdozBCfduYRy1jQ7im/n7S1+oQZIjZ
         Lu5MwJTqEL8+vne855DqNvuo0PUQG+5ZAeZ/dbg3YOIN7NY7ewIZ30SzJ5Ru3gJE0+ih
         fCA5x9uzEN73PvKEKUZciURPhHcZkzZVO6RVFnFLxOWYcupwNByxlUDsfgUIxq4hj+XW
         HFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnCjWu89qxOeZvUeYKgLrL67m/1ovdJFmFA+h6t4yJg=;
        b=D+6wyM7qV4kZof5Cmqq62w9P8+H9UzTFAtgCF0OSTZd4V/Jk2k9ZEJzbJprkqmDN95
         KTba8sAehcY1zZchn8R18Mx4u7TDwm15B7FqkAIu22ytjVAn308HU849ap7/qHFuiaOb
         GcGNwCjyZu+Bpt+ku8e1B8LCK0V415IdJZH6TQNToCPyeKUiylxchevsgCUjxOJx+5TS
         YBnwsM0gqt0wHPjx7BlaIvDXdz7MADEzjLNtry6bJe7Hmv8/6ac2dP59T2TUCVEedfyK
         g0ZbB1gUhfz9DudtmfuKA3B0ATQOf4Qn4jOoon8tHGmZgWfrLNR1gDZm6lX7Ks6rTUwx
         QdvA==
X-Gm-Message-State: AOAM531EkmpXEZJIigotvk6+0veU2mXUbX8juBmWA+2IyBRwi20JWR+2
        LjU6nnv/vXo1ZPhlloOd+uUpb+CsxZI=
X-Google-Smtp-Source: ABdhPJxDQxQxstQoFUs4gh4zJcPHkok1CrbJULV/4CMw409OGkWYE3cii1zC+jFJZUGo1OJZtRhIAg==
X-Received: by 2002:a17:90b:3b8e:b0:1df:fd93:b37b with SMTP id pc14-20020a17090b3b8e00b001dffd93b37bmr8634064pjb.147.1653461768398;
        Tue, 24 May 2022 23:56:08 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b0015e8d4eb29esm8313290pll.232.2022.05.24.23.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 23:56:07 -0700 (PDT)
Message-ID: <628dd307.1c69fb81.91c69.39b2@mx.google.com>
X-Google-Original-Message-ID: <20220525065605.GA53111@cgel.zte@gmail.com>
Date:   Wed, 25 May 2022 06:56:05 +0000
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
 <628c9cb4.1c69fb81.aec05.30a1@mx.google.com>
 <YoyfqAApe+RyUyGk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoyfqAApe+RyUyGk@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 11:04:40AM +0200, Michal Hocko wrote:
> On Tue 24-05-22 08:52:02, CGEL wrote:
> > On Thu, May 19, 2022 at 09:39:57AM +0200, Michal Hocko wrote:
> > > On Thu 19-05-22 06:35:03, CGEL wrote:
> > > > On Wed, May 18, 2022 at 02:14:28PM +0200, Michal Hocko wrote:
> > > > > On Wed 18-05-22 07:40:30, CGEL wrote:
> > > > > [...]
> > > > > > 2. process_madvise is still a kind of madvise. processs_madvise from
> > > > > > another process overrides the intention of origin app code ifself that
> > > > > > also calls madvise, which is unrecoverable. For example, if a process "A"
> > > > > > which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
> > > > > > already, meanwhile, if another process which doesn't know the information
> > > > > > of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
> > > > > > "A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
> > > > > > is erasured permanently.
> > > > > 
> > > > > I do not really follow. How is this any different from an external
> > > > > process modifying the process wide policy via the proc or any other
> > > > > interface?
> > > > 
> > > > In this patch, you can see that we didn't modify the flag of any VMA of
> > > > the target process, which is different from process_madvise. So it is
> > > > easy to keep the original MERGEABLE information of the target process
> > > > when we turn back to the default state from the state "always".
> > > 
> > > This means that /proc/<pid>/smaps doesn't show the real state, right?
> > 
> > Maybe we can add extra information of KSM forcible state in /proc/<pid>/smaps
> > like THPeligible. 
> 
> That information is already printed and I do not think that adding
> another flag or whatever would make the situation much more clear.
> 
> > Really, Michal, I think it again, 'process_ madvise' is really not good. In
> > addition to some shortcomings I said before, If new vmas of the target process
> > are created after the external process calls process_madvise(), then we have to
> > call `process_madvise()` on them again, over and over again, regularly, just like
> > Oleksandr said [1].
> 
> I can see that this is not the most convenient way but so far I haven't
> really heard any arguments that this would be impossible.
> 
> Look, I am not claiming that process_madvise is the only way to achieve
> the goal. I really do not like the proc based interface because it is
> rather adhoc and limited. We have other means to set a process wide
> property and I do not see any strong arguments agaist prctl.
> 

I can agree with you that proc is adhoc and limit. Use prctl extension
is probably better, but the problem is that it can't control external
process directly.

> But more importantly I haven't really seen any serious analysis whether
> per-process (resp. per MM) property is even a desirable interface.
> Especially in the current form when opting out for certain VMAs is not
> possible.

I think the reasons of using per-process (resp. per MM) property are as
follows:

The KSM mandatory attribute is set for the entire mm space rather than
some VMAs. Its system is to allow all eligible VMAs of the entire mm to
participate in KSM. Although marking all VMAs as mergeble can achieve the
same purpose, the concept is different:

From another perspective, for example, the rule of a company is to hold
a morning meeting at 9:30 a.m., but one day, the local law stipulates
that it is illegal to go to work before 10 o'clock, then this rule of
the company have to be covered and invalid. Here, 'mm->ksm_ enabled' is
analogous to local laws, while the company's rule is analogous to VMA
-> flag. One day, after the local law is repealed, the company's rule
can still be restored.

>  
> 
> -- 
> Michal Hocko
> SUSE Labs
