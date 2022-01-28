Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3E49FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiA1RbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiA1Ra4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:30:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D1C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:30:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u14so13135278lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5GJA2cUd2TCYXeUPgHGgIRWvVU4WCZd/rHlFfGUmSng=;
        b=E377hvYxX8QvVlmBEXZa2Jdh1SyBKQzj1wweYxTJeQKZzRv0JPbislEPnx7QrLyHEl
         pbEAcdtTwf1OhRifMLiMaXINEvP6CUR36DPAKcO9GjQRZj23uWU9kNAs1fMV51ANDqyE
         iq4iB1AKwYtIyg23tlzdegn2cDvCawQizlfUpUh0y+48MARNEVbTGe3gJWKH0HT/86Oy
         kGG7lAXivyYGVif3F6ErJAsvjOtjc9b37V7zG+9m9T+sjcRuijLGVQVDWhF3knNSomvC
         9K08wD9VSR/SLHuOTdQjUsDr44HdmFLrMNf++K4ELbMBZejkVT0sFymDtwp9kIA3gbwA
         hwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5GJA2cUd2TCYXeUPgHGgIRWvVU4WCZd/rHlFfGUmSng=;
        b=mh0vCekMkrIfyNPj7bf1vH0Gz0Q4tqVH7irCkwdnDCe89F/pEyKFWuRpQpQxW3B7qK
         336MzJuPqvE7ZrT++VtMsZvqJhF5/5Qm2l+wPj5MYPBr+gK1xoop5Una5UTnKus26MPA
         cTusJBEYzq+7Cq0jodZKTlOFQ0zyEdBhyKruqmEqjtutkeIStAXBMVlNXEyW0t3jaq7W
         OpevevFdfjhG6/Q6K8O/IlhhCjO/8//XThTmpfHLlEaak6stpkZrkSeapwjtuvQrk5Lp
         6KUWXhHNKIbAtZvKf/vATXb8qLK8HZx0PwG+vlQsCf3hQnUNSBjAwyte5ob1ZsdXT0ah
         P8vQ==
X-Gm-Message-State: AOAM531JkUv67RrsbRiT0RvCtgvaSsrSOfmW1pp3DGxmhPo2Dd9Gz+mD
        D5DDHQdj7p5OOSwXGvYUyqo=
X-Google-Smtp-Source: ABdhPJzp/i6W1p1VqXHbHX1fC5gFzUFzHUBxhqGcN7+IUPSGbKWHGZ//AFlWyN2+V/P4o3Aa31Kxaw==
X-Received: by 2002:a05:6512:4010:: with SMTP id br16mr7037217lfb.454.1643391054039;
        Fri, 28 Jan 2022 09:30:54 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id j13sm1643757lfu.214.2022.01.28.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:30:53 -0800 (PST)
Message-ID: <d83cc450554d3e37ef1b705152294f6e788a8b10.camel@gmail.com>
Subject: Re: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to
 lib
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 18:30:52 +0100
In-Reply-To: <4eee8241e35fac1fa05eee3525a10672396c18ec.camel@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
         <YfKf74qdUXrPPZHZ@casper.infradead.org>
         <4eee8241e35fac1fa05eee3525a10672396c18ec.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-28 at 12:02 +0100, Karolina Drobnik wrote:
> On Thu, 2022-01-27 at 13:36 +0000, Matthew Wilcox wrote:
> > I don't think it makes much sense to move kmalloc() and not to move
> > the kmem_cache* functions.  They're all provided by slab in the
> > kernel
> > proper, so while you don't use them, I think keeping all the memory
> > allocation functions together is preferable.
> 
> I wasn't sure if these functions would be used by other test suites,
> so
> I left them here. But I can move them if you think it's better to
> keep
> them together.
> 

OK, now I can see why this wouldn't work - kmem_cache_alloc and
kmem_cache_free operate on radix_tree_node struct, making it specific
to this test suite.

So, for this patch, I'm going to tidy up the gfp.h header but leave
radix-tree/linux.c and lib/slab.c as they are now.


