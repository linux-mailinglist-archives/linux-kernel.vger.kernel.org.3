Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFF51244A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiD0VIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiD0VIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47A89CC9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A861C61053
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C233DC385A9;
        Wed, 27 Apr 2022 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651093506;
        bh=hEdBttjHJE5rEw6yCHHL5thD+4DG3iJXGtFJXcSK8Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kqAY/KyH+LCJHhIKKNZ9hhMVbDKmB95Paj8LLAL7Zz04lq3Qss2ttW+MSpz73FwUq
         Cx/ITaRPj0zt7aPcwEVkkB+dU7sNsrkK7tkVG37yPxuyj7lvZ4SAL4Wxmhvl+LfKVl
         i9B/Gx/eAYG8kHrYwUH3nzj4WkA6d1cuNvD98W2c=
Date:   Wed, 27 Apr 2022 14:05:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] A minor hotplug refactoring
Message-Id: <20220427140504.373ea577efe31decce72c236@linux-foundation.org>
In-Reply-To: <20220307150725.6810-1-osalvador@suse.de>
References: <20220307150725.6810-1-osalvador@suse.de>
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

On Mon,  7 Mar 2022 16:07:22 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> Hi,
> 
> These are a few cleanups that go on top of Michal's work [1].
> 

Has anyone (else) had a chance to review these?

Thanks.
