Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B3484204
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiADNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:02:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiADNCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:02:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D9D91F37F;
        Tue,  4 Jan 2022 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641301366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVLLhEQYQWh7fsPPxI8AmUA0ONkykTLg8cvTVO+Pk/U=;
        b=I3+IEreJklrxH+PfSeSz1kn7cQukiK0NHvGC5B9p3mYoKgqj5wrmN+728hkRGpIRh68DtE
        3v8Q1ldOXlWAGp9H0JF2UaCSeeZHmerbOJsmcvxC3KRUTdCMvnugqI78NCSvRLwPh5yIDM
        tKps63EtVKcY9tHZamTPwIL3alJFAQg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F7D4A3B8A;
        Tue,  4 Jan 2022 13:02:45 +0000 (UTC)
Date:   Tue, 4 Jan 2022 14:02:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the livepatching
 tree
Message-ID: <YdRFdRx0IuPhJmTZ@alley>
References: <20211224080027.63028aa9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224080027.63028aa9@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-12-24 08:00:27, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   bf01c2975925 ("livepatch: Fix kobject refcount bug on klp_init_patch_early failure path")
> 
> is missing a Signed-off-by from its committer.

Thanks a lot for catching this. It should be fixed now.

Best Regards,
Petr
