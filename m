Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3855727B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFWFL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFWFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:10:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2443EF6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:56:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l24-20020a0568301d7800b0060c1ebc6438so14634504oti.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WnUFtf8gRIUJdZWQiDSTROqEf9Dm/04GkQLOBBLX/W0=;
        b=mLYN2k91EY0HnDmHRuowvOPijbgBSlF6oVnCCJj43YLFy8P5v4fqlqXeVp5D6qRBc9
         PC0jjbFcy+MbotqA2QxWAen7+H3DQ8phYvzAqYy/wlRN3w2OBBSPebR7WmIVGebw4Stl
         CjAqsCctdyY7iZZORXh3dTPoCfkb+fclrI4BrgHFFE95klYMfKjP0dAzUj5FGFqKAxvq
         UtV/vKD3KLQIPz5taNidhpLbm4Coizf3O0rxJeWFjYyceePFa1g6Nh4Ogt8Zwyl1SGTG
         ih4362BjjEFFVznZOeRbr7WWw8lrKVL2wvis+w+Ki9zCjS0dmhb5LfK5oVPIyVbdSHT7
         JdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnUFtf8gRIUJdZWQiDSTROqEf9Dm/04GkQLOBBLX/W0=;
        b=lNK3BS40WYPrjnBtTg6rWnzIOSLkly0/7UkQCOUZTJ4uYMvevQT5x1Ebz9gTTH2WvC
         xq3tmAITs8l93mRFDCeJ1l9niY5a5dlBjHXF1N1eJEvnEvhvkv7LoQT04Oq6NgiaFrwl
         WjTK4xWcy06IdjRH4eM65fcsTFfk5h+vhRyWXV3Lb+Oe0D/zG0lx4h2KDU97/VhwJkoc
         yUgrYL5K+fxsC16xh9GDq5rmVe7fOh/HEea6I9WXrRU2kNfgJOAVsznxFNK6xFKXdwgP
         5m04lLa29eHn91JFdVH7dguQGQfqvm4bUOXYbrTk/xQu7fTUjSqiybRebvQdmHWbMR2f
         FvRw==
X-Gm-Message-State: AJIora9rX5e8EvL9gaFlwSIjRqNqev/mputrbmh1qqaHvy8NEs/rVEWL
        Ja21qphiRiRLcoxEzH6tDnc=
X-Google-Smtp-Source: AGRyM1tGSijN8TRH9ApBIewTplW5vaQsotF8T0mCpLteedkyaH0qAWygxVEjTmNs5jYvZ0xeXFw0yg==
X-Received: by 2002:a9d:6b13:0:b0:60c:16aa:9ddc with SMTP id g19-20020a9d6b13000000b0060c16aa9ddcmr3062891otp.114.1655960191428;
        Wed, 22 Jun 2022 21:56:31 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id r204-20020acaf3d5000000b0032e3ffc5513sm12283028oih.4.2022.06.22.21.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:56:31 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:56:30 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Huang, Shaoqin" <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrPyfqENPHfUCaq4@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <b7e6565b-d9f7-a5cc-8e66-087ea7b270d1@intel.com>
 <YrO3uyXee9DcMTzz@bertie>
 <d53b547a-1450-82de-a3c5-4bb09f2a728d@intel.com>
 <YrPmhzZDd9YFyEUa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPmhzZDd9YFyEUa@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:05:27PM -0500, Mike Rapoport wrote:
> On Thu, Jun 23, 2022 at 09:29:05AM +0800, Huang, Shaoqin wrote:
> > 
> > 
> > On 6/23/2022 8:45 AM, Rebecca Mckeever wrote:
> > > On Wed, Jun 22, 2022 at 06:32:04PM +0800, Huang, Shaoqin wrote:
> > > > Just test it and everything works fine. And I think there are some thing can
> > > > improve:
> > > > 
> > > >      The prefix_push() and prefix_pop() are used in so many functions and
> > > > almost of them just put the prefix_push(__func__) begin in the head and the
> > > > prefix_pop() in the end.
> > > >      May be you can define some macro that when you output something and
> > > > automatically push the __func__ as prefix. And when leave the function,
> > > > automatically pop it. And only in some special place, you call it manually.
> > > > 
> > > Thank you for your review. I'm not sure how you would automatically push
> > > __func__ since you have to be inside the function to access that
> > > variable. Let me know if you have any suggestions. I am thinking about
> > > adding another function in common.c that just calls test_pass() followed
> > > by prefix_pop() since those are called together so often.
> > 
> > Just like:
> > #define test_pass_macro()               \
> >          do {                            \
> >                  prefix_push(__func__);  \
> >                  test_pass();            \
> >                  prefix_pop();           \
> >          } while (0)
> 
> This will not print the name of the failing test, e.g. instead of 
> 
> not ok 28 : memblock_alloc: alloc_bottom_up_disjoint_check: failed
> 
> with Rebecca's implementation it'll print
> 
> not ok 28 : memblock_alloc: failed
> 
Oh yeah, prefix_push() needs to be called before the asserts.

> How about
> 
> #define PREFIX_PUSH() 	prefix_push(__func__)?
>  
Good idea. What about 

#define TEST_PASS() do { \
	test_pass(); \
	prefix_pop(); \
} while (0)

? Or would it be better to make a function?

> > This macro will automatically push the __fun__ as prefix when you call
> > test_pass_macro(). And then pop it after test_pass() output.
> > 
> > And use this macro() to hidden most of the paired prefix_* functions.
> > 
> > And I think that's the simplist way. May be someone has a better solution.
> > 
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
