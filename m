Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8ED5AA106
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiIAUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIAUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:43:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D779A69;
        Thu,  1 Sep 2022 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+R0zLcDvTGRyvxl4zDbTTDzdi+vOOjcTrIaxayIUUvg=; b=Kk7eaJ6Rqf3HJfgflPvOn2S5w9
        0gTgPTEzbYGfIz1iFeWKbkUpOq9BOJy7FCWVBsXwPD4XxmexSlx2jo2e1KcibDcKu2y82RZFRL/FO
        xQF64t6iAkjcKCKmseQv15D9P0cqE+HAL5Coa6uAbF25VCJ5ZORLmPVpGKfgfxlKEElnMTlGq3W9p
        5PSLOrg1zd2+cGDSoAIDBgmsLdhMBmDWGSillVUqYzNStL1QrRwD0fnyFca4klpndJp//F6jNkPkr
        TVllTk1Jvaw3qbP3c124qfCRwNFrtvTIkFXHS5iwWBzXgsUBFOR6mX5E735GYvFTh8f399Cw/cjos
        TEXs18Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTr1t-006Mh0-4C; Thu, 01 Sep 2022 20:43:13 +0000
Date:   Thu, 1 Sep 2022 21:43:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/10] headers/deps: mm: Split <linux/gfp_types.h> out of
 <linux/gfp.h>
Message-ID: <YxEZYUCA0b8Cd1/S@casper.infradead.org>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
 <20220706174253.4175492-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706174253.4175492-9-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:42:51AM -0700, Yury Norov wrote:
> From: Ingo Molnar <mingo@kernel.org>
> 
> This is a much smaller header.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/gfp.h       | 345 +------------------------------------
>  include/linux/gfp_types.h | 348 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 350 insertions(+), 343 deletions(-)

You move a lot of kernel-doc.  Where do you change the rst files?
