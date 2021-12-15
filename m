Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34FC4753D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhLOHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:37:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55300 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLOHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:37:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7614212BC;
        Wed, 15 Dec 2021 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639553831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afPtQsBnmiWxIGjtv274vf+8ekFRVc6ieIN1HuXzGoc=;
        b=OVU1NEXs6px2EQvO5K5/GPEXaIrJvw3uMn8aS+G1hwcicMNYe0hpd0xWXyL6FWz3ZPndKP
        sGNe1HxfUPbFFaSQcr98BIcwinfOoLrfIwMONte8hicK/rqe5eNv/3lU1wHtEjZ/CP/qx/
        lr/I4Sl/ZLMBrAvVx59hm6eGFc4UMZ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8413D13A9F;
        Wed, 15 Dec 2021 07:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NnesHyebuWGJIAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Dec 2021 07:37:11 +0000
Date:   Wed, 15 Dec 2021 08:37:10 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <20211215073710.GB9653@blackbody.suse.cz>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-3-tj@kernel.org>
 <20211214170352.GA7969@blackbody.suse.cz>
 <Ybj0GqMfY4n2TSSn@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ybj0GqMfY4n2TSSn@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:44:26AM -1000, Tejun Heo <tj@kernel.org> wrote:
>  kernel/cgroup/cgroup-internal.h | 17 +++++++++++
>  kernel/cgroup/cgroup-v1.c       | 26 ++++++++--------
>  kernel/cgroup/cgroup.c          | 53 +++++++++++++++++++++------------
>  3 files changed, 65 insertions(+), 31 deletions(-)

Thanks. This last one member of the series can have therefore

Reviewed-by: Michal Koutný <mkoutny@suse.com>
