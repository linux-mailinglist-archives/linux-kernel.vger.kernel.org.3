Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1C4E56F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbiCWQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245585AbiCWQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:51:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B129832
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNN7HWnFWy+fdeE99vwLpUXCXAGTZ1oVZ0UYC79jYwI=; b=HZnAuN0PFlLVL+0nwLA9rF7iCx
        QTZMAzXa44A28aJ4E1lm1Ev/IabTqLoDAYbT4GJh2dIQM2VBya9X8kLEkZhjc3GFEGJQn2S19x1O3
        MhkjFE9hWZ3RYOEctnK1JG4U78jJ8Wjv/x2njW4yc/tLhG332f5k0HENMAG+M2pYmDc73jDcdU/aP
        kK8vZOlPO6ULSgujCrYtcLtMlPUnW1dZyHgykrjrb+OkoHcNLlMZginWxjE5rUPu9z/A5wWIvw9rR
        ygJdIctADTBDEWiXE6y48sXVFxMSHza+zgYj43KTg/SqRSxjJvxXEimrMR4qUaSETg7rXZfjheDyj
        MQypegBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX4B9-00EImC-3o; Wed, 23 Mar 2022 16:49:47 +0000
Date:   Wed, 23 Mar 2022 09:49:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjtPq1V7hbxc93aj@infradead.org>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org>
 <YjtPUec8jiqUXGuf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtPUec8jiqUXGuf@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:48:17AM -0700, Jaegeuk Kim wrote:
> Christoph, I proposed,
> 
> "I've been waiting for a generic solution as suggested here. Until then, I'd like
> to keep this in f2fs *only* in order to ship the fix in products. Once there's
> a right fix, let me drop or revise this patch again."
> 
> https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/

That counts as ignoring the advice to me.
