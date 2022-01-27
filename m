Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E249E40C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiA0OCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiA0OCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:02:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C480DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eDGpu6oRxFEs4jGSaR8KOXZHTUWDxE84eDvKxLfdLcY=; b=ZXrDA7bv5hhc5C+tDghAmlge4z
        opP1Z90OWBxzgT63wY21IYjiiWmEWSU4K0cxxO3+PjHW+P9kSMW3Hm5XC7PehfhHtewWqEnOHfoa8
        OdAM2AI2pF8gOoQnAkMe18b+uy8THmg8oTijJ/qkUkEi9YDMHfugAUmmYZnbdyJmMffZcs/7mEm9/
        4ZxTJSUoCvrJ7C75YcYV2Sb3zh+RAIBk12qCdWUunI5Mop5iFcVMcDnz1Y2lnPnj0lCAxdW1oMhcZ
        B296tmnFpBVHs+DOAUP6xasJ2HD34TNXkVxzS+o/jSgou9jfZKO8mz28K0nXqh3VHEiS0/6Diptdj
        qWeRonFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5M6-005INy-T8; Thu, 27 Jan 2022 14:02:31 +0000
Date:   Thu, 27 Jan 2022 14:02:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] memblock tests: Add skeleton of the memblock
 simulator
Message-ID: <YfKl9taKJ7Gc2i+8@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:28PM +0100, Karolina Drobnik wrote:
> +++ b/tools/testing/memblock/.gitignore
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +main
> +memblock.c
> +linux/memblock.h
> +asm/cmpxchg.h

Don't put SPDX information in a .gitignore file.
