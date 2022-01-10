Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112D4489E28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiAJRQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:16:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33316 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiAJRQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:16:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ACC1F210EC;
        Mon, 10 Jan 2022 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641834967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5aM/6FqZVjWgMmEtpDqnnfWuGy/rSpxBC30JYJdpNo=;
        b=GZkZpOQNG42M4a76wDS+Jh9WblpZM7qdFVLuvNS5957jEUC7YcIzUs2Kd+UQQU1IUk5U05
        PWc7ONk7mDQqyhnhnMvRB/qA6b1oSSfG7B/uMgBmcXpZvbXF4cBdEmdwVUE9VCFrJqQoTm
        h8Or7tnkugW6DxBpe4Ihnk6OO7bSchU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 768FFA3B81;
        Mon, 10 Jan 2022 17:16:07 +0000 (UTC)
Date:   Mon, 10 Jan 2022 18:16:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Ydxp13PMUcL8DxWB@dhcp22.suse.cz>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com>
 <YcGjkvMe2xdGNePx@dhcp22.suse.cz>
 <YdFQ5VFTn2gCVeyy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdFQ5VFTn2gCVeyy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02-01-22 09:14:45, Mike Rapoport wrote:
> Hi Michal,
> 
> On Tue, Dec 21, 2021 at 10:51:14AM +0100, Michal Hocko wrote:
> > On Fri 17-12-21 15:51:31, David Hildenbrand wrote:
> > [...]
> > > No surprises found so far. I'll be most offline for the next 2 weeks,
> > > so an official review might take some more time.
> > 
> > Thanks a lot for the testing and a very instructive step by step howto.
> > I will note it down.
> > 
> > Don't worry about the review and enjoy the xmas break. I will likely
> > resubmit early next year.
> 
> Can you please cc me on that?
> I'm way behind on linux-mm, wouldn't want to miss this.

Sure thing. I plan to repost after the merge window.
-- 
Michal Hocko
SUSE Labs
