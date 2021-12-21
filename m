Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE847BDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhLUJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:51:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLUJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:51:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C76E41F388;
        Tue, 21 Dec 2021 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640080274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69rKQtxOkeEuMD5v4nSaPLhjCWgR4lVs9nzOvHFI09g=;
        b=bqpyeVjsBPvqrawzfw1MqZSxdqjZbOWIo9TuxCVYw8yVys/RcuK9en8dQ9/lmFKcZ4VaOz
        ioJnKvQ7Vs7IIWDAK6h5PYbH3MbP6VqDHLxs2Zxrb3f8mSRJjWKd5hh5jSKpEmkGJkbEdw
        g12MXSoER1ORSE2/wc3vNU8OVWvTUZE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B065CA3B83;
        Tue, 21 Dec 2021 09:51:14 +0000 (UTC)
Date:   Tue, 21 Dec 2021 10:51:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node
 gracefully
Message-ID: <YcGjkvMe2xdGNePx@dhcp22.suse.cz>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-12-21 15:51:31, David Hildenbrand wrote:
[...]
> No surprises found so far. I'll be most offline for the next 2 weeks,
> so an official review might take some more time.

Thanks a lot for the testing and a very instructive step by step howto.
I will note it down.

Don't worry about the review and enjoy the xmas break. I will likely
resubmit early next year.
-- 
Michal Hocko
SUSE Labs
