Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030C59C493
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiHVRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650B541D1D;
        Mon, 22 Aug 2022 10:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE5061207;
        Mon, 22 Aug 2022 17:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C6C433C1;
        Mon, 22 Aug 2022 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661187903;
        bh=2RPwxK6mPiQ24V+dniyQlazWwH9XEnmeAVv55idNd7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z799LMiw+FL/IuHbi/9/reeai2+4hyyozmQmWlPVlykp+Hgy7vKNzLv1danQCEfiU
         oH3hucNa2WJcQo3tovRQgpFhzcaXJNJazD5h/tNCjBZQbnlPfRSd+LmMLpXXyMS9EX
         bdYGItA66XzG/Mgwqgiqsj4AJuxdG359istn8KUS5q0000a7aOkBkUQnwi2hvhvdey
         wBvlN+H7/cIexx7n5jz7boF26n0fp32yNHGrfNuTkldGY1uxDUkkCJnueOg5NfGs2h
         tsmx1aPgdi8WmsLaPkkpQoVNq9RBSL3oSG2qS8TaLH4oaXlk2XXKAP3aHj8uGNiBxJ
         WQHn4ZVUWVzpA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Kairui Song <ryncsn@gmail.com>, damon@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date:   Mon, 22 Aug 2022 17:05:00 +0000
Message-Id: <20220822170500.87712-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822165646.87524-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 16:56:46 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Kairui,
> 
> 
> On Mon, 22 Aug 2022 18:56:17 +0800 Kairui Song <ryncsn@gmail.com> wrote:
> 
> > From: Kairui Song <kasong@tencent.com>
> > 
> > The workflow example code is not working since it got the file names
> > wrong. So fix this.
> 
> Nice finding, thank you for this patch!
> 
> > 

Oh, I forgot saying that it would be good to have Fixes: here, like below:

Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")

I wouldn't say this needs to Cc stable@, as this is just a document example
fix.  Nevertheless, if anyone has a different opinion, please shout out.


Thanks,
SJ

> > Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
> > ---
> >  Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index d52f572a90298..ca91ecc290785 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> > @@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
> >  workload as below. ::
> >  
> >      # cd /sys/kernel/mm/damon/admin/
> > -    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
> > +    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
> >      # echo vaddr > kdamonds/0/contexts/0/operations
> > -    # echo 1 > kdamonds/0/contexts/0/targets/nr
> > -    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
> > +    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> > +    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
> >      # echo on > kdamonds/0/state
> >  
> >  Files Hierarchy
> > @@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
> >      # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> >      # cd kdamonds/0/contexts/0/schemes/0
> >      # # set the basic access pattern and the action
> > -    # echo 4096 > access_patterns/sz/min
> > -    # echo 8192 > access_patterns/sz/max
> > -    # echo 0 > access_patterns/nr_accesses/min
> > -    # echo 5 > access_patterns/nr_accesses/max
> > -    # echo 10 > access_patterns/age/min
> > -    # echo 20 > access_patterns/age/max
> > +    # echo 4096 > access_pattern/sz/min
> > +    # echo 8192 > access_pattern/sz/max
> > +    # echo 0 > access_pattern/nr_accesses/min
> > +    # echo 5 > access_pattern/nr_accesses/max
> > +    # echo 10 > access_pattern/age/min
> > +    # echo 20 > access_pattern/age/max
> >      # echo pageout > action
> >      # # set quotas
> >      # echo 10 > quotas/ms
> > -- 
> > 2.35.2
