Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A3565C94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiGDREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGDREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B51DE9B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFAF861511
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5998FC3411E;
        Mon,  4 Jul 2022 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656954273;
        bh=SB/C7tn3bUOEWtyg9tywoq99dsG7I7PpenQyDjn4dMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJdXF14dQ9CADUSGxKCz36XwONYaIMHlmoG2n/dEBaIAlVBo+iF4YRL4CHnad1L6o
         bgQ8mE0bfaYwW4qgWeFhZzf7jOhd0Eia9vnCu8pP0/HXTxy3vYDVuZ9EpAdn+g5kW2
         4t7bYoJyQ8tjXrfFl0YUJu6grMKEFkLyo0o4p4mxBaKYHkSOx47aeErQAZTDYOOoAw
         Ytle/EamDS5wKICXpj9u8bY0OC3L+Kb0uiliF/PRsF0943T/SC5RktqKcTQxfB88KI
         OcjURUOjbU8vFQ+dxvfHzBQ9A9tyK6KAtXA8M57Zp3fBLb0UxWJb0zKuRK2IpfhOTI
         CNwRRN0srZEgg==
Date:   Mon, 4 Jul 2022 20:04:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YsMdkmTk5uLsBLgD@kernel.org>
References: <cover.1656907314.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656907314.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 11:06:54PM -0500, Rebecca Mckeever wrote:
> These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> simulator, which can be specified when running make. These patches also
> implement the functionality for these options.
> 
> Rebecca Mckeever (4):
>   memblock tests: Makefile: add arguments to control verbosity
>   memblock tests: add verbose output to memblock tests
>   memblock tests: set memblock_debug to enable memblock_dbg() messages
>   memblock tests: remove completed TODO items
 
Applied, thanks!

>  tools/testing/memblock/Makefile               |   4 +
>  tools/testing/memblock/README                 |  10 +-
>  tools/testing/memblock/TODO                   |  14 +-
>  tools/testing/memblock/internal.h             |   7 +
>  .../testing/memblock/scripts/Makefile.include |  10 +
>  tools/testing/memblock/tests/alloc_api.c      | 225 +++++++----
>  .../memblock/tests/alloc_helpers_api.c        | 129 ++++---
>  tools/testing/memblock/tests/alloc_nid_api.c  | 351 +++++++++++-------
>  tools/testing/memblock/tests/basic_api.c      | 337 +++++++++++------
>  tools/testing/memblock/tests/common.c         |  57 +++
>  tools/testing/memblock/tests/common.h         |  62 ++++
>  11 files changed, 850 insertions(+), 356 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
