Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947704A5280
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiAaWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiAaWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:39:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04D8C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:39:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6D8615CE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F33C340E8;
        Mon, 31 Jan 2022 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643668755;
        bh=Q2ZEQqdLwRPhSxsGyaxZ+JOpmXVNnMzJAHIcJOnnDLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kzue/aCCq9ObTiYIuAjwKTLXibXh5MxhcCj2FpkIONcBP+jWsczIf6y29zwyW1xU+
         RMDnDd+FKFwR5i+54r0oEVsnZ/ss2R42UaDhWCK489xnzu+Vgg2FLlryWI3v5JZ5eN
         GkPe5G+qMV8iMgfppVXqjX9H2FQKqjxgLMf9c0jI=
Date:   Mon, 31 Jan 2022 14:39:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        regressions@lists.linux.dev, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] Revert
 "mm/page_isolation: unset migratetype directly for non Buddy page"
Message-Id: <20220131143914.4cce43a15c2d9a7d53582659@linux-foundation.org>
In-Reply-To: <338bde65-5e1c-4e23-b4f2-671819c637cc@leemhuis.info>
References: <20220117142712.3967624-1-chenwandun@huawei.com>
        <b1966d11-e874-c71e-d14f-c0c88ace297e@suse.cz>
        <c0b74f54-c39a-51f7-08f8-701e9af94e56@huawei.com>
        <338bde65-5e1c-4e23-b4f2-671819c637cc@leemhuis.info>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 10:24:43 +0100 Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> Andrew, I don't see this patch in the list of changes you sent to Linus
> yesterday. Shouldn't it be in there due to above reason alone? And there
> is another reason: it seems to be an issue people actually hit, as
> Guenter mentioned in this thread. It thus complicates things for those
> that want to help testing pre-releases.

I prefer to give fixes some time in linux-next before upstreaming them.
At least a day, worst case.  So I have this patch in this week's pile.
