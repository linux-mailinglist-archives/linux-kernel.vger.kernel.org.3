Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A614EEE74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiDANvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDANvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:51:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7133CA0E8;
        Fri,  1 Apr 2022 06:49:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BC051FCFF;
        Fri,  1 Apr 2022 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648820963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz7xTr9l8MJUB0+OMSqplN0cGq108K0n8faUQPVz55Q=;
        b=Yu6NjHMt7T3hEovFrCYTCNQDHNBMSEIGAC7vtE5HdIeJTjdGaWPWuvtWkga9n+f3kw4n0n
        PqfdHfFycik3IpsR4/PmGi/vQOQ0uItdxsWVm4bR3cwidS1vlHAXFuPREHmtv48DMB9I8Y
        5ch54gnY21D9R4t1J5IzGwMspvIfdEk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90A10A3B82;
        Fri,  1 Apr 2022 13:49:22 +0000 (UTC)
Date:   Fri, 1 Apr 2022 15:49:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <YkcC3z5ReeQ5vdg9@dhcp22.suse.cz>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-03-22 10:25:23, Roman Gushchin wrote:
> On Thu, Mar 31, 2022 at 08:41:51AM +0000, Yosry Ahmed wrote:
[...]
> > - A similar per-node interface can also be added to support proactive
> >   reclaim and reclaim-based demotion in systems without memcg.
> 
> Maybe an option to specify a timeout? That might simplify the userspace part.

What do you mean by timeout here? Isn't
timeout $N echo $RECLAIM > ....

enough?
-- 
Michal Hocko
SUSE Labs
