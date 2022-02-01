Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934574A5980
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiBAJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:51:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37352 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiBAJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:51:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A31A81F383;
        Tue,  1 Feb 2022 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643709099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXtpcbJyDyk4mWH2FPATZeadgV4+yzsbRgqmF24oHa4=;
        b=OMiyGHQYaQUqTDF5tmaaHhkhcGdEldbHEITKVnuK6dPYV56pnh7Z0gWgx9TqGo+dF+QMXv
        +PjZStCvY+miMlj1c1TlikXtuSEX6bnY2jPxKUPNVBwsDEJPs29RippT1erCf8UfGh/Dk5
        Qd9epi9v5DzYcvVB/bmawc/0Q3/2F5Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66F41A3B85;
        Tue,  1 Feb 2022 09:51:39 +0000 (UTC)
Date:   Tue, 1 Feb 2022 10:51:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 6/6] memcg: do not tweak node in
 alloc_mem_cgroup_per_node_info
Message-ID: <YfkCq5U4dBbmvOOf@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-7-mhocko@kernel.org>
 <20220201024544.p2iqj2mz7bgq4pf3@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201024544.p2iqj2mz7bgq4pf3@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-02-22 02:45:44, Wei Yang wrote:
> On Thu, Jan 27, 2022 at 09:53:05AM +0100, Michal Hocko wrote:
> >From: Wei Yang <richard.weiyang@gmail.com>
> >
> >alloc_mem_cgroup_per_node_info is allocated for each possible node and
> >this used to be a problem because not !node_online nodes didn't have
>                                    ^^^ a typo here?
> 
> 				   !node_online nodes is enough?

Yes. Fixed up. Thx!

 
> >appropriate data structure allocated. This has changed by "mm: handle
> >uninitialized numa nodes gracefully" so we can drop the special casing
> >here.
> >
> >Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Michal Hocko
SUSE Labs
