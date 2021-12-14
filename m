Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C34748CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhLNREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:04:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhLNRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:04:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 308491F381;
        Tue, 14 Dec 2021 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639501442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JassOI8n+pYiwu7Y0UzD9+Ipk3J5NDVW1iTSVC/sXq8=;
        b=Ffg0ttVn8I322seSVu4DAylTPWGeoVJsfAj3tLS4FBWhUPy/lgEXnXM/RGy/d+mvvjUxPV
        YUTwoj9u/4XZxg2MtlyT5XX/5DktkA75EZHnv3pTugORZaRuhu6EHZojXjjhDYeiOhADQQ
        OzjdgykPqRVUh1cDlMxHUB4v9SnSGZM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01ADF13D17;
        Tue, 14 Dec 2021 17:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ksdrO4HOuGFLFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Dec 2021 17:04:01 +0000
Date:   Tue, 14 Dec 2021 18:04:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com,
        syzbot+50f5cf33a284ce738b62@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/6] cgroup: Use open-time cgroup namespace for process
 migration perm checks
Message-ID: <20211214170400.GA9116@blackbody.suse.cz>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213191833.916632-4-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:18:30AM -1000, Tejun Heo <tj@kernel.org> wrote:
> ---
>  kernel/cgroup/cgroup-internal.h |  2 ++
>  kernel/cgroup/cgroup.c          | 28 +++++++++++++++++++---------
>  2 files changed, 21 insertions(+), 9 deletions(-)

Reviewed-by: Michal Koutný <mkoutny@suse.com>
