Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE34CC417
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiCCRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCCRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:38:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1F5E756;
        Thu,  3 Mar 2022 09:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70516B82664;
        Thu,  3 Mar 2022 17:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08654C004E1;
        Thu,  3 Mar 2022 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646329073;
        bh=AwsKZjrCfieTvEUDAR753VxI0pVb5/yxhVzdc73s6Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tF5Eio8uUmDzrs/3lfLgba6ZKgS7Ii7J/dwr0kY6gz/UhLzHURAFIaI/M5dyQ6ucz
         NlbPzoiUdcbga83R9Y7yZr5Q6rOasQ/j1He7GtMgLXb/dSTBXTabb31tRcCwU/Yh9I
         xK6TxKV9UEG4QZejP9tBw354Xm+JsNnGhWoyRt6s3oFeh2ouyEOXpldXxopj1WfIEf
         o/RGNS29GXVTg2jsc8SR3sLzL9IqRaGEjML0ROExY5AnsbsL/B7Y/VF7dQKm1xTYx4
         tS9Gga8Y1p0BkuOS3N875xSu8a9VmeDAwlj2WuBGqeSbLgqoUneElE7AIKAcbMX/2Z
         K2otOXLxE4u6g==
Date:   Thu, 3 Mar 2022 10:37:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
Message-ID: <YiD86pay2ENCebkR@dev-arch.thelio-3990X>
References: <20220301145233.3689119-1-arnd@kernel.org>
 <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
 <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
 <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sedat,

On Thu, Mar 03, 2022 at 07:26:05AM +0100, Sedat Dilek wrote:
> Hey Nick!
> 
> This only applies 1/3.
> 
> $ b4 --version
> 0.8.0
> 
> $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@kernel.org/
> -o - | git am -3
> Analyzing 14 messages in the thread
> Will use the latest revision: v3
> You can pick other revisions using the -vN flag
> Checking attestation on all messages, may take a moment...
> ---
>  ✓ [PATCH v3 1/3] Kbuild: move to -std=gnu11
>    ✓ Signed: DKIM/kernel.org
>    + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (✓ DKIM/kernel.org)
>  ERROR: missing [2/3]!
>  ERROR: missing [3/3]!
>  ---
>  NOTE: install patatt for end-to-end signature verification
> ---
> Total patches: 1
> ---
> WARNING: Thread incomplete!
> Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@kernel.org
> Base: not specified
> Wende an: Kbuild: move to -std=gnu11

It looks like the threading somehow got broken, likely due to the [v3]
on the first patch and not the second or third:

This worked for me on v5.17-rc6:

$ for i in $(seq 1 3); do b4 shazam -P _ 20220301145233.3689119-"$i"-arnd@kernel.org; done

"b4 shazam" is the equivalent of "b4 am -o - ... | git am" and the
"-P _" tells b4 to only fetch that exact message ID, not the whole
thread.

Cheers,
Nathan
