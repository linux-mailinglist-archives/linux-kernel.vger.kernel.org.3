Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CC4748BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhLNRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:03:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51174 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhLNRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:03:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 787551F381;
        Tue, 14 Dec 2021 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639501422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7c7x5g1D49a/Snvf4ASAMLc6RagfKuMRL1MI2bz6J+Q=;
        b=HRraZuRTQsvGSRUBvesBcmzg72PQ1IAWGjPy4+tBI21Wuv+Cb/jcb4BPSPPKKBjMNUFdFn
        8o4OqIvGb9mLNcq0orN3mOs4t5cOxcOSlJ94EzuJj3FlSb9/lXBaumMHpWLUxyWNOfnkdV
        uBQwq/KTYZGiBFEw4MIs3fHXplH5qwY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 470FB13D17;
        Tue, 14 Dec 2021 17:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rs6+EG7OuGEiFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Dec 2021 17:03:42 +0000
Date:   Tue, 14 Dec 2021 18:03:41 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/6] cgroup: Use open-time credentials for process
 migraton perm checks
Message-ID: <20211214170340.GB52416@blackbody.suse.cz>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213191833.916632-2-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:18:28AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Michal Koutný <mkoutny@suse.com>

Just metadata suggestion:
Fixes: 187fe84067bd ("cgroup: require write perm on common ancestor when moving processes on the default hierarchy")

Besides that
Reviewed-by: Michal Koutný <mkoutny@suse.com>

