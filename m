Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC94C8674
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiCAI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiCAI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:27:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F660CD7;
        Tue,  1 Mar 2022 00:26:29 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:26:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646123187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naohzTaoaD0YfTsZtWNJ3KH5Wbjuoc53RXX3sX+PbBM=;
        b=RlxQHL0iLLnL4vzlhzZwho/ik5bqvM7mdQcoN0ahtjnIgzmMlza7zvt4fFevkHPOH524zH
        c/CLLqK9wPgGVFQlJS91+5K5i4DK0q2Len38Dtf+gjphP63knvwDqyNSXyeHwcA0XZ3/cK
        /uq1hhQ+ErklfO2MTryISeOnsMiDvyjR27L3KMHjBlpLlm61PbLbEild8mLAI9YzoLmWu6
        C2WYKktrkXYg/UMA4vAGkkr5bj7I1IYyhhiL9K5JUbYZ2LnV6A1u/BvW0OHKFOia5WVMpn
        M4RETBEX2rlbPaUtBvFHL0spA3ESD+Y3Ai0mj43gfrnukzjT8O9pDI0BcbNx/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646123187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naohzTaoaD0YfTsZtWNJ3KH5Wbjuoc53RXX3sX+PbBM=;
        b=FH3K2RGupJlJpLHUcqAH5bka8vxiu6DebYCK0Dy2dUrW4s0W1bdfyNuFlGricTzNaxHd/y
        IHjFdTs4mnrXg+Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: remove unnecessary check in alloc_thread_stack_node()
Message-ID: <Yh3YskVDQ3FL430i@linutronix.de>
References: <20220301080706.GB17208@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301080706.GB17208@kili>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01 11:07:06 [+0300], Dan Carpenter wrote:
> The "stack" pointer cannot be NULL at this point so there is no
> need to check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Which tree is this against? Could you try against -tip, please?

Sebastian
