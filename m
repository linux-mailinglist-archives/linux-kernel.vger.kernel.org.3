Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BF52DF29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiESVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiESVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:22:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9B1053E5;
        Thu, 19 May 2022 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kfSt1Dp7t1l6C/x62PEX59b7+Eo442+B+bqu78xv2Qo=; b=M6NBdZkdBnRBmxgfJO0TuLZBMx
        E2JVvEToUGBjwvwG6whjRFqV/ePAo5k8t4fxto2L7qp+0q0zCw6fbtVpv/q0wePt+o3AnwCFk2SIB
        DYWjSf9Qzek5BAyKL8uf4ZYc5U66b6gQlRAn7LYuPUa4ulgg0Aafmk8Nuzvv4tRx2RZlFcHvxikso
        uHiJAtSVg+y4c2thmEnuAmVfh6KAHDYqivN/hACEil7eeozfg1RcGIvOXFXbLSB0GHBT445Gox93P
        X0j2orYkzHBb46nGYwv/VgtvOdU89GF0IV6GLVyU1rsLjuExPOSx/M3Ts+wwZKyktDD1/lWgaqtEd
        wFPEU7JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnbE-00D6os-Dr; Thu, 19 May 2022 21:22:24 +0000
Date:   Thu, 19 May 2022 22:22:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <Yoa1EBOQuwErmFTq@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
 <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
 <YoazuWvIU63zNGJr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoazuWvIU63zNGJr@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:16:41AM +0300, Andy Shevchenko wrote:
> I run `make W=1`, but I think the kernel doc validator is run anyway.

No, it's too slow and used to emit too many warnings to run it at any
time.  That's why I made it opt-in with W=1 (and even that caused
screeches from people who were compiling with W=1 in their CI frameworks
;-)

