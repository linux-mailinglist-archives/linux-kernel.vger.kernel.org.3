Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9997E559F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiFXRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiFXRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:09:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635D51E42
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:09:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 9so2965173pgd.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+34mV2GgOppVanfZ9ynO37pzqtHQm+7qlycXpXslgnM=;
        b=eMygqP5xYgaPLOrAm2dSertr6ihOdd7ZvWCAapgpBZ5NGgsxm/XETmCXorvfWcoQOa
         J07BzPskgHYbp428pfpLncjWWyxRqwi/3bRdXq0PAYfYSHUYqSAHylMdzhKNI4CHP5lu
         SBUWGbKnLZ2SJY7ql1yURDYn4LDJuWD3J1PTRyc6yBnFv1jX51anuxioeWgjS0NJgZU0
         2N1GUX6XYwjZLQSjl2pCt8viM3TThqv/uZwWBUZxClSDYXSns25C+/gOJwOHYl0dNFJg
         TN65G2VGP5/xVwrLLc6EWoJxzjKf9FicEyu6FPiO/TFIQelbygVU3kMesI4AaEosYDH4
         IICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+34mV2GgOppVanfZ9ynO37pzqtHQm+7qlycXpXslgnM=;
        b=VfADUNyPQ/UlD9KK0in8Jre79KaatIRTHaWZOrejp+WXKexOTGuAcv51XOOzex2BMn
         4RDNdNaGA1sAIvhjK+W2j7kaRbC9DPMicGjqLquwcPvw5SdZMLvnDEMNXUqoKrenJKuK
         f+qoixTbAs2O0EEjDhKhC4aNx+cCUwXwXcT+OHrC6p/jtUOHuWRO6lHBhQ4yI60WQNu4
         5D3B6oKq1eAD520+mUUj8A8ci2NBYlA/EtD3tgoruAMqKr+bYxaKE4anq5qjy0FzGSrh
         fKbjiN2HkhW2mpURKhK/9UZQonKWCRULg2fj4hDc5W+UTuZfQHc8nWv7sIvJDIItcywG
         h9aQ==
X-Gm-Message-State: AJIora+xuTpaZb47tgTq9VHcMxFYPgS0GWpI+VxnPlHETTuAtXtSup5m
        NCVSoxMj2amwm5Ognd39KbOwqRv0GfmzDQ==
X-Google-Smtp-Source: AGRyM1sFfGPH+nQhntZBQ49g61G9RcFCMhhpVE3+mKE6QpMSt17EeuUnHDPLfMigz6YbdEvv1IP64g==
X-Received: by 2002:aa7:86c9:0:b0:525:3d39:8d0f with SMTP id h9-20020aa786c9000000b005253d398d0fmr170020pfo.54.1656090554666;
        Fri, 24 Jun 2022 10:09:14 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001674d61c1c6sm2023237plb.272.2022.06.24.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:09:13 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:09:09 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        shy828301@gmail.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] mm/huge_memory: fix comment of page_deferred_list
Message-ID: <YrXvtRSm0koKa89w@google.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-15-linmiaohe@huawei.com>
 <YrQVOcF4PirjGa/M@FVFYT0MHHV2J.usts.net>
 <0b1a1633-2e07-87df-b707-3058353f5609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1a1633-2e07-87df-b707-3058353f5609@huawei.com>
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

On 23 Jun 20:26, Miaohe Lin wrote:
> On 2022/6/23 15:24, Muchun Song wrote:
> > On Thu, Jun 23, 2022 at 01:06:25AM +0800, Miaohe Lin wrote:
> >> The current comment is confusing because if global or memcg deferred list
> >> in the second tail page is occupied by compound_head, why we still use
> >> page[2].deferred_list here? I think it wants to say that Global or memcg
> >> deferred list in the first tail page is occupied by compound_mapcount and
> >> compound_pincount so we use the second tail page's deferred_list instead.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  include/linux/huge_mm.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 12b297f9951d..2e8062b3417a 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
> >>  static inline struct list_head *page_deferred_list(struct page *page)
> >>  {
> >>  	/*
> >> -	 * Global or memcg deferred list in the second tail pages is
> >> -	 * occupied by compound_head.
> >> +	 * Global or memcg deferred list in the first tail page is
> >> +	 * occupied by compound_mapcount and compound_pincount.
> >>  	 */
> > 
> > The structure of "struct page" seems to have told us the information that
> > we resue the 2nd tail page to be used as deferred_list. I am not sure the
> 
> Yes, it does.
> 
> > value of those comments. Maybe better to remove them?
> 
> IMHO above comment tries to tell us why deferred list in the second tail page is used
> instead of first tail page. But it should be fine to remove the above comments as they
> don't seem to provide much info (thought I'm not really sure).
> 
> Thanks.
> 

Just a suggestion - feel free to disregard. Maybe we don't need to repeat the
comments in struct page, but maybe a "see organization of tail pages of compound
page in "struct page" definition" would at least point new people to where this
magic 2 comes from.  Maybe an obvious place to check after you're familiar with
overloading struct page data for compound pages - but IMO it's not obvious for
newcomers.

> > 
> > Thanks.
> > 
> >>  	return &page[2].deferred_list;
> >>  }
> >> -- 
> >> 2.23.0
> >>
> >>
> > .
> > 
> 
