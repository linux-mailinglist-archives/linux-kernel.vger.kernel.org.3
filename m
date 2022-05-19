Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA8E52DCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbiESSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiESSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:33:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EE46B3F;
        Thu, 19 May 2022 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JPnuYHeYuExXgRSy47MniI0wGLVIyp+nPIdDYMHdz30=; b=gtTgmoUaqxD2j0K5OeHJ1zVMu2
        2uamhPnGuXiw8Z4YjN9MPRLwq53fudi45ZuEJ5Ktkvjc6m0wYVWHVkoJAjsNligT4QkgoWYGyS/Hz
        8Z//G7OaLtxujt3FPfQn6T7IHRso+7FAMS2B/JPn2cmb2u0yhdNT2vqet3pPyyBUnZiVwZUzRO0kU
        g59juKPXmsuoeyqg+eDAWW8YbMH5AZ0KaO8LOMMAo9UXoUIgDPkx/QOE+3Tvbz+MudUSe89zCsvJ8
        F2uX8pNqv7LInvDt91kz4p34wUl+uhqhVIX69ZAyjza9qjokcrBnJhqz1KSmOnyHvPUA0+GJQxZfc
        blsyFJTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrkxo-00D05A-3o; Thu, 19 May 2022 18:33:32 +0000
Date:   Thu, 19 May 2022 19:33:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <YoaNfEwEWGhrJuSd@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-4-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:23:56PM -0400, Kent Overstreet wrote:
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -625,6 +625,25 @@ Examples::
>  	%p4cc	Y10  little-endian (0x20303159)
>  	%p4cc	NV12 big-endian (0xb231564e)
>  
> +Calling a pretty printer function
> +---------------------------------
> +
> +::
> +
> +        %p(%p)     pretty printer function taking one argument
> +        %p(%p,%p)  pretty printer function taking two arguments

Needs to be updated to the %pf change.

> +        printf("%p(%p)", foo_to_text, foo);

Likewise

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
