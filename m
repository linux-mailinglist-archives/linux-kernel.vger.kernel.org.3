Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159374F4887
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiDEVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457612AbiDEQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:17:09 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBB192B9;
        Tue,  5 Apr 2022 09:15:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDADA30D;
        Tue,  5 Apr 2022 16:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDADA30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649175311; bh=rE6rzCNpDJ68w+IwBoDN9Cf1DCDHPiYHstqLXZaFU7k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J2Ns1jRSjvyM1mYJSL3V7kG1cTsmgZwyNrjCkiP+k84kUWO3JPqurBKy7zBAjPMyJ
         Ott5DZyA+QJyeTCEwJKDoMCcshoGoh8CwR/L1ba8KNK4xcW/aA6rXiBpefXdAMte3C
         PjftgljOkwDF4D29WR8nfffJwfRMAX70J4wLBLgJCLGM+1pb0HUTarmpcgm7YpWYgg
         Qw3nh1LZ831VdmtW6NcllXeV8I2RpC0CSezs5Hg20lPSITd6kIt6hVyMJ83Q7/8z+m
         h15UmZZLua6OFynX3VKxyUD5pRB4baQ3+uOlokTwt8cEc0XAdIs24491ouc5FZPpLR
         1LExVsq2eG6ew==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arch_pgtable_helpers: demote pgtable
 list headings
In-Reply-To: <20220326131313.691027-1-bagasdotme@gmail.com>
References: <20220326131313.691027-1-bagasdotme@gmail.com>
Date:   Tue, 05 Apr 2022 10:15:10 -0600
Message-ID: <87k0c3ecc1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Demote pgtable list headings from title heading to chapter heading.

This is a classic example of the sort of changelog that says *what* the
patch does (which we can also see from the patch itself) but not *why*.
Why do these headings need to be changed?

Thanks,

jon

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/vm/arch_pgtable_helpers.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
> index f8b225fc919047..cbaee9e592410f 100644
> --- a/Documentation/vm/arch_pgtable_helpers.rst
> +++ b/Documentation/vm/arch_pgtable_helpers.rst
> @@ -13,7 +13,7 @@ Following tables describe the expected semantics which can also be tested during
>  boot via CONFIG_DEBUG_VM_PGTABLE option. All future changes in here or the debug
>  test need to be in sync.
>  
> -======================
> +
>  PTE Page Table Helpers
>  ======================
>  
> @@ -79,7 +79,7 @@ PTE Page Table Helpers
>  | ptep_set_access_flags     | Converts into a more permissive PTE              |
>  +---------------------------+--------------------------------------------------+
>  
> -======================
> +
>  PMD Page Table Helpers
>  ======================
>  
> @@ -153,7 +153,7 @@ PMD Page Table Helpers
>  | pmdp_set_access_flags     | Converts into a more permissive PMD              |
>  +---------------------------+--------------------------------------------------+
>  
> -======================
> +
>  PUD Page Table Helpers
>  ======================
>  
> @@ -209,7 +209,7 @@ PUD Page Table Helpers
>  | pudp_set_access_flags     | Converts into a more permissive PUD              |
>  +---------------------------+--------------------------------------------------+
>  
> -==========================
> +
>  HugeTLB Page Table Helpers
>  ==========================
>  
> @@ -235,7 +235,7 @@ HugeTLB Page Table Helpers
>  | huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
>  +---------------------------+--------------------------------------------------+
>  
> -========================
> +
>  SWAP Page Table Helpers
>  ========================
>  
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> -- 
> An old man doll... just what I always wanted! - Clara
