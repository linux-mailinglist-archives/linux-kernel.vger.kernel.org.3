Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E34DC34F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiCQJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiCQJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:50:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926E139ADC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:48:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso7090626pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HoYGpM2ujsPl21DU6he6HxjpZNCN9QPtvH57hnndq4=;
        b=oGX0nSKp5OaDPt2miS1pqf5TYzLVOgG/hdkHmBbYarMoeOH9Znd9b7nSsbnk7eKYNG
         lPtpRhcoK920snDB5bzYnGagm2wi1YbZT5m/wF3H6ovLhBWycwYMhpUcFP/GqV+bgCic
         MsjGNUjbg4QT0D2RXnNe6WsC6/I7W8Einehv81RHDNpW7UybcZvg74762NLUKgJUcyil
         UO3e3n12EmUpNsMFRCCG49iNWZ1aDnR2ddyvHFYSPFjH9Y/1htFIJuv8N35uNbW0a5es
         2bqb/EkkE3fpLSb3SyvS+Wo7/h0m//SxH9pcGkAlSyl8o2Bm5Xzjpt8UwQu7zthkkZhf
         65CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=3HoYGpM2ujsPl21DU6he6HxjpZNCN9QPtvH57hnndq4=;
        b=v6Yt1/4TeT8wtZ0xwLPddEBrhrU0lxjs1K03PMEyM6sJQCKIP+AXlXQvHtJZjtn6la
         Zcxuz9KSUTy3r4V+LxTU1YZYl4aBeDZ3l4ISOXdb2UqnfOw8sdkD7yszKOlAf86PYerM
         r3c2CoUFWBVpVyx88fYRpLf/AI0RYpaazMBoWyKOzXVjfYV3D5HoPvOy7nv9R2MqYaKY
         Eog02+lGv88XTVUAzn/yxd6686yos5sOmIMW+rVYgM7zdMz1OhveMXq2hS4kE0WLgLWq
         BMbIpL8ZT98Rc365OwItxUBIHA0f5MdZEXLmwBuCZNapGmUKSbAnPthmv0ZlPwhdVepZ
         ug3w==
X-Gm-Message-State: AOAM531mzYDgVMC3v4LPacALQlUKO8w/t5+IpH+AC2Peaqkl9lWz2Fpy
        8XOa94FPFAw3+qS6fgdAc7U=
X-Google-Smtp-Source: ABdhPJzhAy+PJGg7uN7JFcpjGm7+yqehUGXkqR+kesTQnqL4ourpUYKSy44W511JmTqebj10OiwuoQ==
X-Received: by 2002:a17:902:8b87:b0:14b:47b3:c0a2 with SMTP id ay7-20020a1709028b8700b0014b47b3c0a2mr3854437plb.51.1647510530847;
        Thu, 17 Mar 2022 02:48:50 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b004fa042e822bsm6329509pfj.14.2022.03.17.02.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:48:50 -0700 (PDT)
Message-ID: <62330402.1c69fb81.d2ba6.0538@mx.google.com>
X-Google-Original-Message-ID: <20220317094849.GA2139803@cgel.zte@gmail.com>
Date:   Thu, 17 Mar 2022 09:48:49 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
> On 17.03.22 03:03, CGEL wrote:
> > On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
> >> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> >>> From: Yang Yang <yang.yang29@zte.com.cn>
> >>>
> >>> Delay accounting does not track the delay of ksm cow.  When tasks
> >>> have many ksm pages, it may spend a amount of time waiting for ksm
> >>> cow.
> >>>
> >>> To get the impact of tasks in ksm cow, measure the delay when ksm
> >>> cow happens. This could help users to decide whether to user ksm
> >>> or not.
> >>>
> >>> Also update tools/accounting/getdelays.c:
> >>>
> >>>     / # ./getdelays -dl -p 231
> >>>     print delayacct stats ON
> >>>     listen forever
> >>>     PID     231
> >>>
> >>>     CPU             count     real total  virtual total    delay total  delay average
> >>>                      6247     1859000000     2154070021     1674255063          0.268ms
> >>>     IO              count    delay total  delay average
> >>>                         0              0              0ms
> >>>     SWAP            count    delay total  delay average
> >>>                         0              0              0ms
> >>>     RECLAIM         count    delay total  delay average
> >>>                         0              0              0ms
> >>>     THRASHING       count    delay total  delay average
> >>>                         0              0              0ms
> >>>     KSM             count    delay total  delay average
> >>>                      3635      271567604              0ms
> >>>
> >>
> >> TBH I'm not sure how particularly helpful this is and if we want this.
> >>
> > Thanks for replying.
> > 
> > Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> > save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> > get to know how much memory ksm saved by reading
> > /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
> > ksm cow delay, and this is important of some delay sensitive tasks. If
> > users know both saved memory and ksm cow delay, they could better use
> > madvise(, , MADV_MERGEABLE).
> 
> But that happens after the effects, no?
> 
> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
> results.
>
Image user are developing or porting their applications on experiment
machine, they could takes those benchmark as feedback to adjust whether
to use madvise(, , MADV_MERGEABLE) or it's range.

> So how is this interface useful except for somebody writing an
> application and simply being able to benchmark it with vs. without
> MADV_MERGEABLE?
>
> -- 
> Thanks,
> 
> David / dhildenb
