Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62048A969
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348943AbiAKIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:34:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbiAKIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:34:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2095212B5;
        Tue, 11 Jan 2022 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641890090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lub5q1qgOvncD1Ba+apCc8E7PLbL4JMxqnJyN9TDEZU=;
        b=jlOT/CFH0Og1QGmvac+XxAhfNJ90peYIrP6zUK+wIy3AU3T4xXvtkJWF1aO8E6onwjtT8N
        4y7jvRl0PgWAhftDgmEnmUyjJzP+X49fE9YLBM2qdmDdRfD5JaA2DhD65RDsGbBqGBBkny
        2x556g8VpcVU1Z/pkHYyaoqMsoU/ZlQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62F7BA3B81;
        Tue, 11 Jan 2022 08:34:50 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:34:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rafael Aquini <raquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node
 gracefully
Message-ID: <Yd1BKSU9y5miP2U5@dhcp22.suse.cz>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <YdyiFq+A25Mg0odE@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyiFq+A25Mg0odE@optiplex-lnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-01-22 16:16:06, Rafael Aquini wrote:
> On Tue, Dec 14, 2021 at 11:07:28AM +0100, Michal Hocko wrote:
> > Hi,
> > this should be the full bundle for now. I have ended up with 4 patches.
> > The primary fix is patch 2 (should be reasonably easy to backport to
> > older kernels if there is any need for that). Patches 3 and 4 are mere
> > clean ups.
> >
> > I will repost once this can get some testing from Alexey. Shouldn't be
> > too much different from http://lkml.kernel.org/r/YbHfBgPQMkjtuHYF@dhcp22.suse.cz
> > with the follow up fix squashed in.
> > 
> > I would really appreciate to hear more about http://lkml.kernel.org/r/YbMZsczMGpChaWz0@dhcp22.suse.cz
> > because I would like to add that information to the changelog as well.
> > 
> > Thanks for the review and testing.
> > 
> 
> FWIW, you can add my Acked-by on your repost Michal.
> 
> I reviewed your patches and tested them against that PPC crash on boot 
> described at https://lore.kernel.org/all/YdxoXhTqCmVrT0R5@optiplex-fbsd/
> 
> Everything has worked like a charm, AFAICT.
> 
> Thank you for letting me know about these patches, and thanks for
> working on them as a follow-up to that problem reported by Nico.

Thanks a lot for review and testing Rafael!

-- 
Michal Hocko
SUSE Labs
