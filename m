Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4C4DD280
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiCRBmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:42:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71CE2EE95D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:41:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s8so8245803pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmtP1wcUmvhrUKL1qK3fWTAh+TjdYspAZPkSerDdS8Q=;
        b=heOGcLKGGj75wwn1TCFK8bz8KYJ/dqVSiMCw8Js3rcWA4Nzvq85RFmlaSv4SqUI1EF
         2Hir2aq0+PVY0EtRM57KA9Jr9Pk3jWH0znpJUT5fYFNuB2QzK9t4XFlXLGPVENq13nRw
         HpRn2o+MqfVExYZDei0s6UKVjoQsV12QDhc7WO+e6s6zQbxOQUizy9c3m1VgbBf1xwt3
         wIZHeS4hmlE87hthFUPF2Vfpa+w0b/KXQX/gJd/cV00TIP0LXVjRDRFDrgmf0PJvTMgv
         q6+EnHjbl6dAwM1whHD+TnYLxG5oTVQeOK9afqrPI8I1TsxUzKoUGP3vb7wFviEo7/Cb
         eRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmtP1wcUmvhrUKL1qK3fWTAh+TjdYspAZPkSerDdS8Q=;
        b=5uuAEAk7tXQ3442bIbKpV8qPkOG9Q8cNcWhMeFk+z2o0lOyAzv9j8Hly5ysnonmPZW
         cuXIBqp3iawbQ/8jZpsFurcZitG/EtU0SikBUpaUcmxGE0e4t0SpFvV/fJfqROtCFaUM
         cZtq6+mg1XUSZg/0DNbpKHg635USBE9+g5nLDinCSpS7vI5eVwDZRf/Kko6b51YO1Zp/
         0fJNlzsYr8P8DeSs3tT3beVo6eipajO/P4VOkXtgZSt+RAmiJh0bAbsce7y2RfVlq+g8
         LmuWJb6eSHksKk8tnOXDvinopUU1EdGYiH2oYiVDtzajH55ojgg8LGHIh1nozUEtJzdE
         6eDg==
X-Gm-Message-State: AOAM530PLzzeFM25/aeTPTFTlLRa5aRqQQHmAzTMiI3UX2slFKYKxBK6
        Y1sP0oVp1ZPSJVF34JIwzeI7Ax90LjQ=
X-Google-Smtp-Source: ABdhPJypjKPw7hrzxmlCMsB/EhjFBBTvstwJLhSLSm0kv2K7xYnFlqK/THGz+ACZxGmL4pdD2WgnlA==
X-Received: by 2002:a05:6a00:a2a:b0:4f7:68db:5e60 with SMTP id p42-20020a056a000a2a00b004f768db5e60mr7296975pfh.58.1647567684060;
        Thu, 17 Mar 2022 18:41:24 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004f757a795fesm8093309pfc.219.2022.03.17.18.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:41:22 -0700 (PDT)
Message-ID: <6233e342.1c69fb81.692f.6286@mx.google.com>
X-Google-Original-Message-ID: <20220318014121.GA2142378@cgel.zte@gmail.com>
Date:   Fri, 18 Mar 2022 01:41:21 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from ksm cow
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
 <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
 <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
 <62330402.1c69fb81.d2ba6.0538@mx.google.com>
 <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
> On 17.03.22 10:48, CGEL wrote:
> > On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
> >> On 17.03.22 03:03, CGEL wrote:
> >>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
> >>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> >>>>> From: Yang Yang <yang.yang29@zte.com.cn>
> >>>>>
> >>>>> Delay accounting does not track the delay of ksm cow.  When tasks
> >>>>> have many ksm pages, it may spend a amount of time waiting for ksm
> >>>>> cow.
> >>>>>
> >>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
> >>>>> cow happens. This could help users to decide whether to user ksm
> >>>>> or not.
> >>>>>
> >>>>> Also update tools/accounting/getdelays.c:
> >>>>>
> >>>>>     / # ./getdelays -dl -p 231
> >>>>>     print delayacct stats ON
> >>>>>     listen forever
> >>>>>     PID     231
> >>>>>
> >>>>>     CPU             count     real total  virtual total    delay total  delay average
> >>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
> >>>>>     IO              count    delay total  delay average
> >>>>>                         0              0              0ms
> >>>>>     SWAP            count    delay total  delay average
> >>>>>                         0              0              0ms
> >>>>>     RECLAIM         count    delay total  delay average
> >>>>>                         0              0              0ms
> >>>>>     THRASHING       count    delay total  delay average
> >>>>>                         0              0              0ms
> >>>>>     KSM             count    delay total  delay average
> >>>>>                      3635      271567604              0ms
> >>>>>
> >>>>
> >>>> TBH I'm not sure how particularly helpful this is and if we want this.
> >>>>
> >>> Thanks for replying.
> >>>
> >>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> >>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> >>> get to know how much memory ksm saved by reading
> >>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
> >>> ksm cow delay, and this is important of some delay sensitive tasks. If
> >>> users know both saved memory and ksm cow delay, they could better use
> >>> madvise(, , MADV_MERGEABLE).
> >>
> >> But that happens after the effects, no?
> >>
> >> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
> >> results.
> >>
> > Image user are developing or porting their applications on experiment
> > machine, they could takes those benchmark as feedback to adjust whether
> > to use madvise(, , MADV_MERGEABLE) or it's range.
> 
> And why can't they run it with and without and observe performance using
> existing metrics (or even application-specific metrics?)?
> 
>
I think the reason why we need this patch, is just like why we need                                                                                                     
swap,reclaim,thrashing getdelay information. When system is complex,
it's hard to precise tell which kernel activity impact the observe
performance or application-specific metrics, preempt? cgroup throttle?
swap? reclaim? IO?

So if we could get the factor's precise impact data, when we are tunning
the factor(for this patch it's ksm), it's more efficient.

> -- 
> Thanks,
> 
> David / dhildenb
