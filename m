Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45C58235E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiG0JlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiG0JlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:41:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A453FA20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE231B81FFA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1CBC433C1;
        Wed, 27 Jul 2022 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658914870;
        bh=QPFk5LyXjXwuPDjKAAtyafwy5DsakHirnFpbMfhIawI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfIXgJB65HnWZg6RjOxNuOgNxV6yMennna8GEwqJKo4d7Te9L7oadEfrtuSUeK3vp
         lZeOUpcer0JohUmVvKZybOmsJRuHRswcAhNWaapszb1SosXCqe8o8xonEEJH4R4YrR
         wt9JPaY3VFFmlNiI7EKlamvp+La7DhEKXJ8r6gv8qde8FSPIW0yVsTjGl0IXoFBx5G
         pEZRhYetpOiWJ1AME7hobDfKw49kKSYovIVBuOar+lkioYjp7KbTqpJRKVIfWvw72e
         G6IdxzRvXVrQDG3XFOClV7ACXkG4I78Gbi0o2oQrjXhQi3d/NchL76yFpNTR5+fikI
         I8zVX9BkzLT8w==
Date:   Wed, 27 Jul 2022 12:40:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] memblock test: Modify the obsolete description in README
Message-ID: <YuEIKdxSJcuLia15@kernel.org>
References: <20220728001615.19099-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728001615.19099-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:16:15PM -0600, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> The VERBOSE option in Makefile has been moved, but there still have the
> description left in README. For now, we use `-v` options when running
> memblock test to print information, so also add some description about
> it.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>  tools/testing/memblock/README | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> index 058146b528a5..f39cc0aa6b76 100644
> --- a/tools/testing/memblock/README
> +++ b/tools/testing/memblock/README
> @@ -33,20 +33,21 @@ To run the tests, build the main target and run it:
>  
>  $ make && ./main
>  
> -A successful run produces no output. It is also possible to override different
> -configuration parameters. For example, to include verbose output, specify the
> -VERBOSE flag when building the main target:

The description of VERBOSE build option was a logical continuation of the
previous sentence.

Instead of doing mechanical changes, please rearrange the text so it'll
make sense.

> +A successful run produces no output. It it also possible to override different
> +configuration parameters. For example, to simulate enabled NUMA, use:
>  
> -$ make VERBOSE=1
> +$ make NUMA=1
>  
> -This will print information about which functions are being tested and the
> -number of test cases that passed.
> +For the full list of options, see `make help`.
>  
> -To simulate enabled NUMA, use:
> +It is also possible to pass options at run time. For example:
>  
> -$ make NUMA=1
> +$ ./main -v
>  
> -For the full list of options, see `make help`.
> +This will print information about which functions are being tested and the
> +number of test cases that passed.
> +
> +For the full list of options, see `./main --help`.
>  
>  Project structure
>  =================
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
