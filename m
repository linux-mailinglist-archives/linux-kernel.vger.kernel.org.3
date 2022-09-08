Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C355B1413
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIHFcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:32:09 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5619A6A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 22:32:06 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-346cd4c3d7aso61282807b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 22:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WzVkFxioGR/YRpQq8W57ZtcDnW0QCcrE4C2tY3qbB4s=;
        b=EFOS8MzMKlHLUv0qkYLlhpBc12x9gJbQggXCRBeT2l5zrY/3+dbUqv0UZsv3nTyr9N
         ZBaguiu5aOAiexF9AFkiEFaqctF3jQ0MOqhh+1LLy3iywLcYOFnP6noHJzIiw/A2fnTL
         Fdb7glr3jkkjziKZYhH2EZ8NZwHkSrmB4r4OD5R2Ng5l4JBw4ouqq/+ACvgDokM1Xwi4
         84ntchcfVanLJO6m1gT9o3JgtlnRow2wKJRTbV11ABPh5+iR9TpfboFVbCCzm4Ndm0ZW
         qNKk9nmBz6sGrHfRjkCIE0UcE7gxegRhL7vpBWD1ucSjY6ywr8WMGyq0loNlOFIvVTQ0
         OEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WzVkFxioGR/YRpQq8W57ZtcDnW0QCcrE4C2tY3qbB4s=;
        b=UjsbNLJY6h0/lI7s491l/xw11RmgIcMs1isD2LlRqGnDOMKMM1ehl/Zn95uhxLbBOu
         56UK+7IofpCPeOn2txSNKxP/3XbGCK7JLYvTVdcaGEoAqlKZwABUQN7QILBGjsC6k4bq
         2ElaG0MIacNhcAQsMDX16DJY3orXXRtQ9Yd0VDhe0e0Y5TX5PKeiYkU+hTAuelAf+V3J
         XUmDJzN0lKfnvSzwHBhdsLMOAJhAygB7yD4M7ESW+mm/Ssgo/Xrrb/5VB0gwW3k+dWjQ
         eXDIbeMYAkJD/Wlznk11seWRl/IXlX1OB2+99N6hFWGKv7e3cHgp19+q/KXFA6uOOp6t
         FCyQ==
X-Gm-Message-State: ACgBeo0KPflP6UhgmsAOBL1cRzNa5JdAWSAObwnnw1NbP0d1I2XzST9i
        Fw9vLeL1fAePPtavu0YfAiAT1zohJRzPrHNgWEwkFg==
X-Google-Smtp-Source: AA6agR49hiOOdenvIhboOgBhuYAhs2U/M4B60MYLWkUuCY10Kqgt8MwAaMYXDF7DBkZg7RJbcjEpxv11/1VLavQn2jw=
X-Received: by 2002:a81:a16:0:b0:345:afa:5961 with SMTP id 22-20020a810a16000000b003450afa5961mr5987648ywk.11.1662615125240;
 Wed, 07 Sep 2022 22:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com> <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
 <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com>
 <YxgXd0Z+cqRk7Y7U@localhost.localdomain> <CANpmjNNn0cSpszRJyeF9_ogER9m859MYh745bqOr1DLEp7kibQ@mail.gmail.com>
 <YxliTBGU/gEzLr+S@localhost.localdomain>
In-Reply-To: <YxliTBGU/gEzLr+S@localhost.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Sep 2022 07:31:29 +0200
Message-ID: <CANpmjNO=6wPWWZYaCLN03=-Rk2NF3o8n=ArvgvPAc52mKsFAFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
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

On Thu, 8 Sept 2022 at 05:32, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Sep 07, 2022 at 09:14:35AM +0200, Marco Elver wrote:
> > Why are you casting a stack_record** to a stack_record*? stack_table
> > is already appropriately typed, and there should be no need to cast
> > things around.
> >
> > 'stacks' is supposed to be the bucket? In which case you need to
> > dereference it to get the first entry in the bucket: bucket =
> > stack_table[table_i];
> >
> > stack_i cannot be used to index into the bucket, because the elements
> > in it are a linked list and not necessarily adjacent in memory. You
> > have to traverse the linked list stack_i elements to get to the start:
>
> Yea, I figured that much after thinking about more, but I was overly
> eager.
>
> >   for (int i = 0; stack && i < stack_i; stack = stack->next, ++i);
>
> But this seems suboptimal.
> With this code, we have to walk the list till we find the right index
> every time we enter the function, while the actual code of v2
> or even the patch from v1 [1], we do not really need to do that
> because we already have the pointer to the stack.
>
> So I much rather prefer that, than having to traverse the stacks
> till the find the right one.

I would not prematurely optimize this. It's a hash map, and the only
problem is if there are tons of collisions. Also, this function isn't
performance critical, it's only used for printing, which itself is
slow.

I suggest you collect some stats how many entries each bucket has on
average. If the average is <10, I'd go with the cleaner interface.
