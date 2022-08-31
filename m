Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9D5A894B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiHaXBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiHaXBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D3A830B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE37B619EE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19173C433D6;
        Wed, 31 Aug 2022 23:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661986872;
        bh=ks+RVCe6hWc5ALQwoQXk7fUY7ACu8b2INLz/utrbZNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6wJv49ehWwFIkdWlmO7ofASHqErMeZXuPyI2Tpdhslrk8aEBCIwzyG90WMCuiuDm
         2u5L9BY0hBEsidPGq9Sr9F3qGk0Cqte6x/oNyPcmA3VRB7zBAi8zKKyCpRWnsK/kMT
         lcF3XrNbUjydOdLiIsgHXftmeT0VcQuCq9K+5E7c=
Date:   Wed, 31 Aug 2022 16:01:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <song@kernel.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <songliubraving@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-Id: <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
In-Reply-To: <20220831052734.3423079-1-song@kernel.org>
References: <20220831052734.3423079-1-song@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 22:27:34 -0700 Song Liu <song@kernel.org> wrote:

> find_vmap_lowest_match() is now able to handle different roots. Make
> similar changes to find_vmap_lowest_match_check() and
> find_vmap_lowest_linear_match() to handle different trees.

What are the runtime effects of this change?
