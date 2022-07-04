Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58732564EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiGDH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiGDH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:29:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67063D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:29:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so2466189pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=4MQGn98zHrlAgx/X3OaJuVDgMEpPdUCv8/OPnesR+wc=;
        b=j6QUTe9abTzNfHpLdomuvezuFWq8LestUyWY/mIooWGjBS6ry+zNO9VYQsZudIc9j1
         IuZ67rw2Y4c+CJMgS1/Wx9Ap8ToWFnfOtRKjAeg16C3/ZE7/ucmaITr3YNugBKTyL7C1
         qVdaxxZbTAURYV/tSLefl5G0OnD0ps7ghQsFqq/DNCiNo1f/ew/7EtQGRLKLXyuiV1dr
         s4Z2s8jTq6c68gYef6O6DnvvZpLE0M1rekmhBHfUNPi2aerV7pozL1qhbcY4ZCC/snR9
         zJ6XWbw28lAtv3zcAT4YzfL8ZS3M8pluS0VmyhxkxD98CNWj3iBrw/a9SDhR69nvtRza
         1njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MQGn98zHrlAgx/X3OaJuVDgMEpPdUCv8/OPnesR+wc=;
        b=2iU1dbpdg17Tty4sFBuougBMcgu1grct0Gu2exoVO9SXl0VvSIkfiaAu0hRtDOFW65
         yccmkOq9GWVWMuR2qx22tzZ0fst+xQC0EM9awIDIDLYEiGJD4MeOMLAch/3YIhVKVdpa
         nK5483GzBuRGm2bHwtR9oddbZdHJdsYnJbalC+iuXSkOCr0eSr9X7mCdjFWWfw73crnu
         h83h6wXL8zSbnPcX5vdwyFUuRkx/7BveT7cXCaEX6Xpf3rQDSz3r1GnwK63ZVOUs/rXU
         dMD5MizzaunkRa/c+DxYpBBglndWy9W4a82yeG43b9xDdh+kAjaw0ZBhZ48DAhmkBUI2
         q06w==
X-Gm-Message-State: AJIora8pZ6qlrqLqPZBPivhtkxggVx9OX3GKa3+RE1kFY4fGNebbNlTK
        bqtD9vTPABAzKLo+3iMQRSI=
X-Google-Smtp-Source: AGRyM1uWRKrVkJrRReZbm4+wFVkiK1JjS6ShHybd9j/8csGCaOfx7CUtAaZtyn96HdPQfN28ryymqA==
X-Received: by 2002:a17:902:c792:b0:16b:e725:6f65 with SMTP id w18-20020a170902c79200b0016be7256f65mr1915134pla.58.1656919783238;
        Mon, 04 Jul 2022 00:29:43 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090b0d0900b001ef8912f763sm1231214pjz.7.2022.07.04.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:29:42 -0700 (PDT)
Message-ID: <62c296e6.1c69fb81.41c44.1cca@mx.google.com>
X-Google-Original-Message-ID: <20220704072941.GA1266413@cgel.zte@gmail.com>
Date:   Mon, 4 Jul 2022 07:29:41 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
References: <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
 <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
 <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
 <YsKNJiGA/ruLRS27@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsKNJiGA/ruLRS27@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 08:48:06AM +0200, Michal Hocko wrote:
> On Fri 01-07-22 21:12:56, David Hildenbrand wrote:
> > On 01.07.22 15:19, Michal Hocko wrote:
> > > On Fri 01-07-22 14:39:24, David Hildenbrand wrote:
> > >>> I am not sure about exact details of the KSM implementation but if that
> > >>> is not a desirable behavior then it should be handled on the KSM level.
> > >>> The very sam thing can easily happen in a multithreaded (or in general
> > >>> multi-process with shared mm) environment as well.
> > >>
> > >> I don't quite get what you mean.
> > > 
> > > I meant to say that if KSM needs to be aware of a special CoW semantic
> > > then it should be handled on the KSM layer regardless whether the KSM
> > > has been set by the process itself or any other process that has acccess
> > > to the MM. process_madvise is just another way to access a remote MM
> > > other than sharing the full MM.
> > 
> > Okay.
> > 
> > KSM has been a corner case feature that was restricted to well-defined
> > and well-tested environments. Until recently, R/O pins of any KSM pages
> > was essentially completely unreliably. And applications don't expect
> > such surprises. The shared zeropage is most probably the last
> > problematic piece.
> > 
> > Yes, we're getting there that it's a real feature that can see more
> > (forced) wide-spread use. However, until the known issues in KSM have
> > been fixed (e.g., below -- there is a whole list of papers regarding
> > attacks on memory deduplication), it should be limited to well defined
> > environments and applications only -- IMHO.
> 
> Very much agreed on all this! To be completely honest I am not really
> sure that all those consequences are widely understood and optmizing
> solely on memory savings is a very short sighted strategy IMO. But, it
> seems that there is a demand for this feature and previous attempts for
> APIs were much worse both from the semantic and maintainability POV. I
> am not sure we can get anything more sane than madvise.
> 
> I also very much agree that current shortcomings have to be adressed
> first before we open this can of worms to 3rd party actors. I was not
> aware of those so thank for bringing them up. Maybe I was overly
> optimistic here.
> 
> So I guess we have following questions to answer:
> 1) Do we really want to support KSM triggered by 3rd party? Does it
> impose new challenges other than existing ones in multi "threaded"
> environemnts?
> 2) If yes, is the process_madvise the most appropriate existing API? Or
> do we need a new one?

Maybe new semantics is needed similarly to MADV_NOHUGEPAGE that ensures that
there will *not* be huge pages.

> 3) Should this be a highly privileged operation or we want to allow
> userspace to shoot its feet because consequences are subtle and not very
> well understood?
> 
> > So what I want to express here is that if we're adding an interface that
> > can be used to just enable KSM on the whole system easily, it might be a
> > bit to soon for that. No matter what you document, people will ignore it.
> 
> Agreed.
> 

Agree too.
Thanks.
