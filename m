Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1B482A76
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiABHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 02:14:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 02:14:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE0260DE3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 07:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148CFC36AE9;
        Sun,  2 Jan 2022 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641107696;
        bh=7BXQFMn0x1kg/Sye5p1GEZraVf76AhT9QqQxWqGm5/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egJhsX6rC7BZUGRMRR6rYWx2oQJoc/zeynEx+c9PmzErTJS0b4gf8R8UVvr3VUCCz
         OHrWU3V/HHlYKrKhFBfXSIC3/QfkbVPSyclUwumo5R8QUgi8g1UTMDuXCr5rxbh0ut
         TLdG0CeQY3wcwz+QZHdW8fF7PIERtuooaon/68uqJztMioK6cfj8k6u/OrynNOoW5T
         4GxabDpLMu8nwM4rylX0XN2om4G7L67flllbIVGkAG1OcKqYGn6kqzkq/b9ezGwy25
         WxKuB2PJrbTIEIAZqqMOdqkJX72tMmiTyIu095dQSZwCkx7Ao+GKxbBaOpuz0+W8vG
         pTSGuk3A1UVjw==
Date:   Sun, 2 Jan 2022 09:14:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node
 gracefully
Message-ID: <YdFQ5VFTn2gCVeyy@kernel.org>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com>
 <YcGjkvMe2xdGNePx@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGjkvMe2xdGNePx@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Dec 21, 2021 at 10:51:14AM +0100, Michal Hocko wrote:
> On Fri 17-12-21 15:51:31, David Hildenbrand wrote:
> [...]
> > No surprises found so far. I'll be most offline for the next 2 weeks,
> > so an official review might take some more time.
> 
> Thanks a lot for the testing and a very instructive step by step howto.
> I will note it down.
> 
> Don't worry about the review and enjoy the xmas break. I will likely
> resubmit early next year.

Can you please cc me on that?
I'm way behind on linux-mm, wouldn't want to miss this.

> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
