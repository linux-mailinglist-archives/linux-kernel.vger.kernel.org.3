Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB5F496187
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351271AbiAUOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351247AbiAUOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:47:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C59C06173D;
        Fri, 21 Jan 2022 06:47:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C50618D9;
        Fri, 21 Jan 2022 14:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A0BC340E1;
        Fri, 21 Jan 2022 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642776455;
        bh=VIGt77avKEHv+W9gw/dLm58slX0hKWo685G7tWYTgDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btypg3EO8SDQUd6fysuYgllEWDcRkoRZlQe0kiSEpr6g53/HYwtnoFm5KO7YnjefN
         dzPq1cDKSJVPfKCmWfbQhE59ryABX/AWPcOzT4wchjccb+CcOsh9Nu42m+mxBS4crm
         L1a7Oen/wf/LaNRwDQjXjqaduMgnq2BZoIz70Dt+X6x6vUPKxOKFf1yhBVGm8O9Et1
         A6Ls9kMOkxdyIuCw2zposUKQb9iq78JAYhOK14YGTvCbSGROs2Z8n5f8EW/lfjnJck
         mcqJe9ESGO+uvqNsnMvT2E98Rm0yz0thaaRa9oNi07VuI2aFdDEOqT1rYYfqcCctHt
         TOiMgACFSZkPg==
Date:   Fri, 21 Jan 2022 15:47:32 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     tglx@linutronix.de, mark.rutland@arm.com, paulmck@kernel.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, corbet@lwn.net
Subject: Re: [PATCH v4 1/2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <20220121144732.GA233613@lothringen>
References: <20220110105044.94423-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110105044.94423-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:50:43AM +0100, Nicolas Saenz Julienne wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The entry/exit handling for exceptions, interrupts, syscalls and KVM is
> not really documented except for some comments.
> 
> Fill the gaps.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de
> Co-developed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Nice!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
