Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4359F3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiHXGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHXGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:55:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA056B91
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w6RhqyoqH6BSTeN6EShgE/XnFp7pNDPLZa4RD6/f7dw=; b=GJMb3dG/Q8z7tbsQvPKgCaHpj+
        3/Wa5M1XSAsoxnEI74GDYyeJM0Qtv3DE/395kqzsylb/BtZqEHry6XqzKn91elwR4KAFzalLHFuf9
        8ioeEHXrYN4VSgxBE1W5pXIkz1iRIShRshEfmGhgOAEwHseBGa2Dd0SVou0HS1db9qnULsoTSTTDd
        nGvrPeVJyP7th+PzF2xqeassDFy58GkCl02eLuo4Gw1aDY81MTmalGUhzPnL4Xi3KhAsAwQ+Y/PbB
        eHrWq+wyP7LwMy4s4KxBK0WlPFzEgGD5KtYRNnxXRuRtJ818fOz+7ynMDcJHvCOTlYwa80nIm1Y/M
        uG+cwkgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQkIU-00G5bF-Hj; Wed, 24 Aug 2022 06:55:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AABF980403; Wed, 24 Aug 2022 08:55:29 +0200 (CEST)
Date:   Wed, 24 Aug 2022 08:55:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/cpu: Add new Raptor Lake CPU model number
Message-ID: <YwXLYced9p6OCJae@worktop.programming.kicks-ass.net>
References: <20220823174819.223941-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823174819.223941-1-tony.luck@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 10:48:19AM -0700, Tony Luck wrote:
> Note1: Model 0xB7 already claimed the "no suffix" #define for a regular
> client part, so add (yet another) suffix "S" to distinguish this new
> part from the earlier one.
> 
> Note2: the RAPTORLAKE* and ALDERLAKE* processors are very similar from a
> software enabling point of view.  There are no known features that have
> model-specific enabling and also differ between the two.  In other words,
> every single place that list *one* or more RAPTORLAKE* or ALDERLAKE*
> processors should list all of them.

Note3: Except when they should not: https://lore.kernel.org/all/Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net/?q=Alder+Lake+N
