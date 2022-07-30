Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37991585940
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiG3IsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3IsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C032B631
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 01:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E1260B3F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65B9C433D6;
        Sat, 30 Jul 2022 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659170887;
        bh=VgUDT0CHq5xXwgXx5dUDrl0wzXv+0S+jSbH+6URRswM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/nRY3OEu7X4Lw6tfdqct/bqN21HMcA0HSjTu/cEPmk4+fz/kHgsi2s6U+rXc79mq
         wd2vv/fRHdos4RfUdYFkHiVMyHuteEbYflFleRD2NLvsZQzwZ6mLhEpNMFqU2W1Hfw
         mfldxJHLuKmUK0DhFUf/GHstEPWvJRjYzZ8V7zvpDuyoxEmBASZ5dHmFfq1lXmD49O
         x3OVh3gEco0SwzuLYj+PTnK5fySq53BIMdnuQ3SrkDT8OtT/fZW0QnQEgRylmle8pg
         LASGZ/vVD4d0+DL9aI2LLGX7+YZDsPXQy25gA8zHz5NFIp4C4TJ5/1siVTJi0WLqnD
         F9DrNfXJMay8g==
Date:   Sat, 30 Jul 2022 11:47:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memblock test: Modify the obsolete description in
 README
Message-ID: <YuTwOjRMNXss3dZi@kernel.org>
References: <20220729161125.190845-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729161125.190845-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:11:25AM -0600, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> The VERBOSE option in Makefile has been moved, but there still have the
> description left in README. For now, we use `-v` options when running
> memblock test to print information, so using the new to replace the
> obsolete items.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
> Changelog:
> ----------
> v3:
>   - Using `build options` replace `options` to make it more clear.
> v2:
>   - Tweak the sentence to make it more clear and continuesly.
>   - Commit log changes.
> 
>  tools/testing/memblock/README | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied, thanks!
 
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> index 058146b528a5..72162b5f4a76 100644
> --- a/tools/testing/memblock/README
> +++ b/tools/testing/memblock/README
> @@ -33,20 +33,23 @@ To run the tests, build the main target and run it:
>  
>  $ make && ./main
>  
> -A successful run produces no output. It is also possible to override different
> -configuration parameters. For example, to include verbose output, specify the
> -VERBOSE flag when building the main target:
> +A successful run produces no output. It is possible to control the behavior
> +by passing options from command line. For example, to include verbose output,
> +append the `-v` options when you run the tests:
>  
> -$ make VERBOSE=1
> +$ ./main -v
>  
>  This will print information about which functions are being tested and the
>  number of test cases that passed.
>  
> -To simulate enabled NUMA, use:
> +For the full list of options from command line, see `./main --help`.
> +
> +It is also possible to override different configuration parameters to change it
> +test functions. For example, To simulate enabled NUMA, use:
>  
>  $ make NUMA=1
>  
> -For the full list of options, see `make help`.
> +For the full list of build options, see `make help`.
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
