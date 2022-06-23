Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5DC5574A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiFWH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiFWH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:57:33 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA80947383
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:57:32 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-fe023ab520so25597254fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DdiVvT5LEZWM3p/GkJXqZ5Fwws2OCqyXJjXQPVvZIhA=;
        b=VVVgIPkcIUN6epQHOGYeK4s3ZT1GWvMoRfiTVUnKKmGawQgBhPW0QZ3mfRnVXhrLjU
         WZrj9A7MYPOEYh4qW0OyltSjadtEuVJxnvpYxyn2NqfWLTwtozGzgH2uf8PnbEJI9Jz9
         +o9Szae9yxyFzHd6o+UMSchclo4+GDgk2fNS+Uf/ZtZXRtsQUiIxQN7AOIJNilC9aSDz
         3ZmvH79HapETDCX31eiEIs5W7BTuor6s/9ksnnbkyZ7wYkIRUSWO9xL1CS+b9TvHtXl8
         YtPkepYmv0hWYeelqy275L79jQ119+bkJ84thLybMJ+O+7d9zSGGxY8mIIoZLkTGf0Px
         EsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdiVvT5LEZWM3p/GkJXqZ5Fwws2OCqyXJjXQPVvZIhA=;
        b=OmvcWTuLfBateTZHW+yZb+zqF7Lr/fnnq95WduMMZxh9ExYs87E56nyOOEzKcDX9tD
         j+vwK7YUMjHFIwswHCAbPUEg8KwRoDqJbQmSUzWPrBo17Iu2c7lEzcBK4CLvny4WbK8Y
         bKBM92rU3ck8IZBfu3DAVNf6jhgPQQHY/LtShLs/ZTQcMVJLPDInqV3KekceNxREkVsK
         CZB0oH1m//043qKM7xRhhGL9ASKh7pVSfXeSq/8k85hyQkeL2PA8TtLzIfV5l/sXAZCn
         10QExWgL33k29UwViVxHy8lqgo+HVcAKgsFuywTmQt5GiqvHoh4/SYRCb+VsXdS1UIaO
         BGmw==
X-Gm-Message-State: AJIora95V1r85fMMNvmN7ANklQNyterDC4JabcwiVmrUoICPOb0tzyre
        MNfuqEI+s/rhzYthnpZ2xUW2sOk65o8=
X-Google-Smtp-Source: AGRyM1vzb5Ug0C5+qaDMtia5rDOiS/NbHsSE/fmei84BqRf2iQQVh8xaDabe5W7IhwYv1YdblUBDdg==
X-Received: by 2002:a05:6870:339e:b0:f3:cd8:6156 with SMTP id w30-20020a056870339e00b000f30cd86156mr1671150oae.292.1655971051997;
        Thu, 23 Jun 2022 00:57:31 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000e90544b79fsm12194057oab.41.2022.06.23.00.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:57:31 -0700 (PDT)
Date:   Thu, 23 Jun 2022 02:57:30 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Huang, Shaoqin" <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrQc6kl2q4VyuW6E@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <b7e6565b-d9f7-a5cc-8e66-087ea7b270d1@intel.com>
 <YrO3uyXee9DcMTzz@bertie>
 <d53b547a-1450-82de-a3c5-4bb09f2a728d@intel.com>
 <YrPmhzZDd9YFyEUa@kernel.org>
 <YrPyfqENPHfUCaq4@bertie>
 <YrP0YVMKo19Wrv44@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrP0YVMKo19Wrv44@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:04:33AM -0500, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 11:56:30PM -0500, Rebecca Mckeever wrote:
> > On Wed, Jun 22, 2022 at 11:05:27PM -0500, Mike Rapoport wrote:
> > > On Thu, Jun 23, 2022 at 09:29:05AM +0800, Huang, Shaoqin wrote:
> > > > 
> > > > 
> > > > On 6/23/2022 8:45 AM, Rebecca Mckeever wrote:
> > > > > On Wed, Jun 22, 2022 at 06:32:04PM +0800, Huang, Shaoqin wrote:
> > > > > > Just test it and everything works fine. And I think there are some thing can
> > > > > > improve:
> > > > > > 
> > > > > >      The prefix_push() and prefix_pop() are used in so many functions and
> > > > > > almost of them just put the prefix_push(__func__) begin in the head and the
> > > > > > prefix_pop() in the end.
> > > > > >      May be you can define some macro that when you output something and
> > > > > > automatically push the __func__ as prefix. And when leave the function,
> > > > > > automatically pop it. And only in some special place, you call it manually.
> > > > > > 
> > > > > Thank you for your review. I'm not sure how you would automatically push
> > > > > __func__ since you have to be inside the function to access that
> > > > > variable. Let me know if you have any suggestions. I am thinking about
> > > > > adding another function in common.c that just calls test_pass() followed
> > > > > by prefix_pop() since those are called together so often.
> > > > 
> > > > Just like:
> > > > #define test_pass_macro()               \
> > > >          do {                            \
> > > >                  prefix_push(__func__);  \
> > > >                  test_pass();            \
> > > >                  prefix_pop();           \
> > > >          } while (0)
> > > 
> > > This will not print the name of the failing test, e.g. instead of 
> > > 
> > > not ok 28 : memblock_alloc: alloc_bottom_up_disjoint_check: failed
> > > 
> > > with Rebecca's implementation it'll print
> > > 
> > > not ok 28 : memblock_alloc: failed
> > > 
> > Oh yeah, prefix_push() needs to be called before the asserts.
> > 
> > > How about
> > > 
> > > #define PREFIX_PUSH() 	prefix_push(__func__)?
> > >  
> > Good idea. What about 
> > 
> > #define TEST_PASS() do { \
> > 	test_pass(); \
> > 	prefix_pop(); \
> > } while (0)
> > 
> > ? Or would it be better to make a function?
> 
> static inline function would be better.
> 
Would there be any advantage to defining a different version for each
side of #ifdef VERBOSE? 

> > Thanks,
> > Rebecca
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
