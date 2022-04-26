Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18D510980
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiDZUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiDZUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F026513C67E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 527A0B8228F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0237C385A0;
        Tue, 26 Apr 2022 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651003565;
        bh=otG+m8WO8dgV9HmWE1Q0aI4ceMjbtO+nIixWzrPrKUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kNRWgAys7fGJ5dIvy67a0ZM205Ni9wXslKgweTZHCAimZY2jjnRxsH/gsmF9nqr4y
         +ryBKYHUwDS7HAUMopzL2ruTCXQMwbQ97WxYH9RsGTUwOARBjj0Jw5jHENhudRBpru
         b4IfXqhq0KuZt75/dvaMf/6VFMfy2qOiTP2nHdxo=
Date:   Tue, 26 Apr 2022 13:06:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-Id: <20220426130603.2fa538088d10d38a740a0bdd@linux-foundation.org>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 15:06:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Please replace the patches in your mglru-maple branch with this set.  It should
> be a drop in replacement for my patch range with the fixes into these
> patches.  Adding the preallocation to work around the fs-reclaim LOCKDEP
> issue caused enough changes to the patches to warrant a respin.

OK, thanks.  I'll give these a bit of testing locally with a view to
having a run in -next soon.

It's all not looking very reviewed.  Any thoughts on who we could
attempt to presuade to hep out here?

> The last patch on the branch is still needed to fix vmscan after mglru
> is applied.  ee4b1fc24f30 "mm/vmscan: Use VMA_ITERATOR in
> get_next_vma()"

OK, someone please send that at me when the next rev of mglru surfaces?

