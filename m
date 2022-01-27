Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6E49E3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiA0Nyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiA0Nyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:54:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81305C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zbTlD7Vb3Z4rFPtDsfUIAfz+fZe4eO2NmvnUWDIogk=; b=o9Voac63tzeMidBk9tHh5fshN8
        BzPwaUCjF0ZBzarWVolSwPhQBwqZJCHWbFtYgVgPyBxBXvugjZyYig6AHMLZuMXBTIVly+Q8WnsD1
        s+wL0ulOpVCurNRIc1CQbk5ZLRAmp7BeVksl3bEoTTAx94TE7s7tfuE+lB5pk0CU09C38hmk7xXa0
        Aqk0VW7YnjkU1eB4Aiym2I+5E5xKEVhfuL2zFnwsfrPTDtSgvew6Z0FisYRhvb5twAS5xRv4kX0p5
        4lHA8Ism/DMfGVDIwusK+peHAMG3l3jkg3vHRmr4ef3ca2LEQ+xspqZQbtH2ui0jzMcBrdEoRPhIl
        hEKcm1vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5EQ-005Hyl-FD; Thu, 27 Jan 2022 13:54:34 +0000
Date:   Thu, 27 Jan 2022 13:54:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] tools/include: Add _RET_IP_ and math definitions
 to kernel.h
Message-ID: <YfKkGga3QKDwFdHJ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <5baa036aadb6436c7c36589ce591baaf827aec0b.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baa036aadb6436c7c36589ce591baaf827aec0b.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:21PM +0100, Karolina Drobnik wrote:
> Add max_t, min_t and clamp functions, together with _RET_IP_
> definition, so they can be used in testing.

Rather than adding our own definitions of min/max/clamp, have
you considered using #include "../../../include/linux/minmax.h"?
In my experience reusing this kind of "leaf" header works out
better than duplicating it.
