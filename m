Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68204F8D96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiDHEZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiDHEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:25:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B8BB19C18;
        Thu,  7 Apr 2022 21:23:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573E211FB;
        Thu,  7 Apr 2022 21:23:52 -0700 (PDT)
Received: from [10.163.37.138] (unknown [10.163.37.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA423F718;
        Thu,  7 Apr 2022 21:23:48 -0700 (PDT)
Message-ID: <e95dfce9-23a1-7722-7f36-f7ca350e492d@arm.com>
Date:   Fri, 8 Apr 2022 09:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] Documentation: arch_pgtable_helpers: demote pgtable
 list headings
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220407045830.181514-1-bagasdotme@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220407045830.181514-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 10:28, Bagas Sanjaya wrote:
> All page title headings in arch_pgtable_helpers.txt except
> "Architecture Page Table Helpers" should have been subheadings instead.
> 
> Demote them to chapter headings.
> 
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
>  Changes since v1 [1]: 
>    - Rebased on v5.18-rc1
>    - Describe why the patch do the job

I am neutral on this patch, dont have a strong opinion either way.

> 
>  [1]: https://lore.kernel.org/linux-doc/20220326131313.691027-1-bagasdotme@gmail.com/
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
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
