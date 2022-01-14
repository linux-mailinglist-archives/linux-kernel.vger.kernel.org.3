Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCD48E6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiANIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiANIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:48:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B613C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Ts8mzKwk5/uK6yCg9POuKH1Z+Ior51UZ/pOjZ1ex42E=; b=vV6oww0+UedLx1UdMHCHGpwcJ/
        Lv3kbhOiD0lFOP/drjoBFQPGhi2Ko3SjYBEqsj9/G3Gg4WrypIS6EGxoxtfPc47igYQWw7I6ust7u
        9nxp9fBnS0/2S/0/cKgzgKLzYTTF1TGWepMyWym8mIDY6iJZGqVrYKaDsju9VFVfSk8Kho2kKRiPT
        Gylyg3BgaS+Q4bz2omd3r0gKb7tq7Nb/Q2Z6E8rujgR0ZtGB0xeWAGxAvJVq1MBWWwmzTw+0WZk5X
        DRb47jaR3EZOsSmq/SYg7fYlOvrKHiiRCvKP+vINqN3wjsqxPa4QNJvzFw5WSO9EVQ/NSH096MnhG
        Sce35y9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8IGO-005f1A-8o; Fri, 14 Jan 2022 08:48:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B916C3001E1;
        Fri, 14 Jan 2022 09:48:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A79DF266305C3; Fri, 14 Jan 2022 09:48:46 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:48:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Guchun Chen <guchun.chen@amd.com>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] locking/rwsem: drop redundant semicolon of
 down_write_nest_lock
Message-ID: <YeE47hmP5xDZIYOl@hirez.programming.kicks-ass.net>
References: <20220114083742.6219-1-guchun.chen@amd.com>
 <33e93f72-0d5a-b624-f58e-c35155bbda1e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33e93f72-0d5a-b624-f58e-c35155bbda1e@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:40:54AM +0100, Christian König wrote:
> Am 14.01.22 um 09:37 schrieb Guchun Chen:
> > Otherwise, braces are needed when using it.
> > 
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> Peter any objections that we push this upstream through the drm subsystem?

Nah, take it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
