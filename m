Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440384748D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhLNREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:04:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhLNRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:04:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F59421129;
        Tue, 14 Dec 2021 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639501457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3o9x6Ukn2VswmoBxUtchiwDehV7TAR9E+p+zjZOoMQ=;
        b=Bz5xR+3zolE7dwJMHrwz6BEN+f7Vc4DQWtW0TX3v7wV/MBobpYEIQlXYBgRGkSUFXmuXTc
        HjIt65DqBENRb9g2jgsZFRfxyl6xYg6ckF24vrJaTOBPjIZ3JJ2JlU5Ya3zAAfA3HfPOXo
        kjeZ/iQXbM4qVUbZko6zvqD+/uPujRQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E960713D17;
        Tue, 14 Dec 2021 17:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TkBNOJDOuGFoFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Dec 2021 17:04:16 +0000
Date:   Tue, 14 Dec 2021 18:04:15 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/6] selftests: cgroup: Test open-time credential usage
 for migration checks
Message-ID: <20211214170415.GA9497@blackbody.suse.cz>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213191833.916632-6-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:18:32AM -1000, Tejun Heo <tj@kernel.org> wrote:
> ---
>  tools/testing/selftests/cgroup/test_core.c | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Tested-by: Michal Koutný <mkoutny@suse.com>

(in the sense it fails on unpatched kernel :-)

