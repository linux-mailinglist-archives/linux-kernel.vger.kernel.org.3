Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656B849E405
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiA0OAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiA0OAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:00:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF564C061751
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBGITkfIunbEoV1e27SDyy1KmsKjH8Nm3KYduSoAfDA=; b=Syad0HX5ez35G0TzuGzTkI6zHj
        O7yIRtoNzaxGhoaWeCQZEWGzT2yvDAv2xV2luitje0tfDHo9nKrAdteeUBJ7/7UpylgR2WSEbTDgf
        V0G5EyEC2DwiSvXow+8zzfjdYGYXdi6cBmWet/DvH4joVZD7GlylS6qgFJ0SvQ3qnGhCZhH0L9Hce
        s9csYHLrTJQNoVZcjWuTAlElBA3T0eSachBfaD+XEz3UzdaseffgxzMVwWwFC3DKUPQgEkmQqT4R9
        bLWPFlJ/BiBV3pdi5UFYsdrCCxB+CSo1FFbn33d63a4klJ3ONFyqZM4OQ0jt0oMvLHGrGrEY/qso6
        1jRq9STg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5KA-005IHE-4q; Thu, 27 Jan 2022 14:00:30 +0000
Date:   Thu, 27 Jan 2022 14:00:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] tools/include: Add cache.h stub
Message-ID: <YfKlfoKXyFZxB/UD@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <fa6e6abc6a214f85089c8a10b8df72d0402c6166.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6e6abc6a214f85089c8a10b8df72d0402c6166.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:24PM +0100, Karolina Drobnik wrote:
> +++ b/tools/include/linux/cache.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_LINUX_CACHE_H
> +#define _TOOLS_LINUX_CACHE_H
> +
> +#define L1_CACHE_SHIFT		5
> +#define L1_CACHE_BYTES		BIT(L1_CACHE_SHIFT)
> +
> +#define SMP_CACHE_BYTES L1_CACHE_BYTES
> +
> +#endif

You've added an implicit dependency on include/vdso/bits.h which seems
unpleasant ...
