Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0993E52570F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiELVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358745AbiELVcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:32:03 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152B520F74F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:32:01 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q4so2523437uas.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAEvdTjpMiH02kk60TytbztnqV1ZmA0Yb2xj1ek1p2c=;
        b=AQd8ugEBqMeVcQ3c+P4owmAOI3jptgmmv/yVY0Hzubgs1BBkmPok2U3o4M4aCk+f9G
         bEmzXF7EAuns52hfOWdAIBe2eeGl6SJHg2wuaNag32vrrilFFSFqQw9E+vCOmlJuaYJL
         znmmUGgr18xmZC9qrjprWUDXibliidJx8DxzkUX7xZfi1wajzi/WYEIikt9z8aUiT5cp
         pMqJnOziS0on8jMnrq2brRt0OI3EtBN33RdO1PHJCzBAhjL7EjDjPEJmdwGSwheiA/tK
         9cWCtEnahNxMgy0+sd0rvPJWcdzATvKC6vFKqbHb9wxLzNWiXts5Bx8pmjdUhPnDXY27
         pdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAEvdTjpMiH02kk60TytbztnqV1ZmA0Yb2xj1ek1p2c=;
        b=37ot6hAoo7b/nolW/C/+XL0QHFLW5mOZX1RwGjnE8L6W5Nh5TT77qMMdbPRlaW/z6t
         tUC9M8V/Ekap1dP66jUNbQNSneIiI9o+8A+gpmg+ukqlTQwvD6KlglKZkp1A4vzHFNaC
         rJqf8WST9dvf/xkJ+DS96oCTWuobJPe2sAv48jKc/h06G5dZ2Ug0zOp0xChRnwUYESTa
         cnZ2PxzSzXLKAKuoA7cssJ0OI8z6ed4gh7UGLu91RJMdFTya4Dig2zodCxal5yIa0E88
         HCIsG5DfHb1QxrO1Ur2Wn24BYRC/zqjUZYYQeFjI0MF3U2v+ULKIbUyB2QrR3TqOcc0T
         xGdg==
X-Gm-Message-State: AOAM532mJiTc/shFTtRIDT6clBR9jYDRGU/FQ0ZNr6vW/e5KjP+xvquT
        WQY0CvfvtLV/XJOeaXi/V53ftc4uXElZdvpbOBSvow==
X-Google-Smtp-Source: ABdhPJzUBFca9v1LokdN/wm4ymV/l1Ks2bnzIIoADv2YZ78qVG92Y28zMfMniJ4L1epdqiiQt2gndkyf7XXgySKXvH8=
X-Received: by 2002:ab0:e14:0:b0:360:e13:e5d7 with SMTP id g20-20020ab00e14000000b003600e13e5d7mr1229790uak.95.1652391120104;
 Thu, 12 May 2022 14:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
 <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com> <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
 <87y1z7jj85.fsf@linux.ibm.com> <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
 <333438929a8680317bdae02da921d1e50fb9b0b3.camel@linux.intel.com>
In-Reply-To: <333438929a8680317bdae02da921d1e50fb9b0b3.camel@linux.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 12 May 2022 14:31:49 -0700
Message-ID: <CAAPL-u-nhj-JBH8xA1+BjuC3A_kfd5FSv2qKCL3g71h-cu0WLg@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 2:13 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Thu, 2022-05-12 at 01:15 -0700, Wei Xu wrote:
> >
> > I am OK with moving back the memory tier nodelist into node/.  When
> > there are more memory tier attributes needed, we can then create the
> > memory tier subtree and replace the tier nodelist in node/ with
> > symlinks.
> >
> > So the revised sysfs interfaces are:
> >
> > * /sys/devices/system/node/memory_tierN (read-only)
> >
> >   where N = 0, 1, 2
> >
> >   Format: node_list
> >
> > * /sys/devices/system/node/nodeN/memory_tier (read/write)
> >
> >   where N = 0, 1, ...
> >
> >   Format: int or empty
>
> This looks good to me.  Just wonder if having just 1 tier
> lower than DRAM is sufficient. We could have wide performance
> range for such secondary memories and is one tier sufficient for them?
>
> Tim

The tier design can be extended to more than 3 tiers (e.g. via
CONFIG_MAX_MEMORY_TIERS).  MAX_MEMORY_TIERS is set to 3 for now
because without enough memory device performance information provided
by the firmware, it is difficult for the kernel to properly initialize
the memory tier hierarchy beyond 3 tiers (GPU, DRAM, PMEM).  We will
have to resort to the userspace override to set up such many-tier
systems.
