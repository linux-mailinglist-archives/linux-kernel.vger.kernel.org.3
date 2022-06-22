Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D8555368
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359862AbiFVSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiFVSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE612D14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A7D6181B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7C5C34114;
        Wed, 22 Jun 2022 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655923422;
        bh=Ux1W9cg1dhtEDASKJfKm5SKzh2E5qU2cYOjw3eiFUCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMz57SoZVdJQToqzt3IjfIncs/MNYbCz1kh3QyZe96mFraFAl9VAR6LOiGsd8g9Mb
         MZ3V0rmu/vp9faUkXxxGihFcd4cu2VRoTsBZonETj5ha+6ys1+EMc5cZ2hjOjWb9yn
         Q26pRSfbuD6GYZDP5pSxfVRglPsPzDoAdOx826Vw=
Date:   Wed, 22 Jun 2022 11:43:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/page_alloc: make the annotations of available memory
 more accurate
Message-Id: <20220622114328.938ef5b4899eb14cc8a285df@linux-foundation.org>
In-Reply-To: <20220622064712.959479-1-yang.yang29@zte.com.cn>
References: <20220622064712.959479-1-yang.yang29@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 06:47:13 +0000 cgel.zte@gmail.com wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Not all the systems use swap, so estimating available memory would
> help to prevent swapping or OOM of system that not use swap.
> 
> And we need to reserve some page cache to prevent swapping or
> thrashing. If somebody is accessing the pages in pagecache,
> and if too much would be freed, most accesses might mean
> reading data from disk, i.e. thrashing.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

This should include your signoff, as described in
Documentation/process/submitting-patches.rst.

And we'd like a full name for that signoff please, not simply a bare
email address.
