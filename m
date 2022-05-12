Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8F5253AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357064AbiELRaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiELRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:30:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63626BC86;
        Thu, 12 May 2022 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bHhDJY4678gCF8Z5uA4n3ckQezyDMemB7BdtWkCEB8o=; b=WY9TQZs3o6cHUvQ+qQvdpRchty
        d++4WIC3XVH1/Q6dJjBZbF0E+4n6WnETsAYS5r+7RjLDwLuhP4R9MPqL4Km+7i6IJDd/O11KcZd+8
        u51+nLdnNULeN52d6kClRPWwwXanDwHWPR6iQc1MSg4M+Zic4NtGpBWX3SFBXtb6jayJMEH/B3oEU
        PD5FDx81PKmP9eEnwcHXMYv1dM4GOBL3eLD2rt5R5208tx6musdgeQGopuY/zjNOiaKZZ9MthehrF
        PNoCTHhztYUK40rKgadQGUhyAiB+awhV5ChwZo/rcHOi4+g95V9z6zy5ne1XxGpAAurII1WPJGJhc
        gkBTD7rg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npCdh-00D0O5-TP; Thu, 12 May 2022 17:30:13 +0000
Date:   Thu, 12 May 2022 10:30:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, onkarnath.1@samsung.com
Subject: Re: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <Yn1EJZOSdu9q/V4w@bombadil.infradead.org>
References: <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcas5p4.samsung.com>
 <20220421041542.9195-1-maninder1.s@samsung.com>
 <202205111513.3AD646936@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205111513.3AD646936@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:25:14PM -0700, Kees Cook wrote:
> On Thu, Apr 21, 2022 at 09:45:42AM +0530, Maninder Singh wrote:
> > print module information when KALLSYMS is disabled.
> 
> I'd like this patch reverted from -next.
> - too many logical changes is a single patch
> - addition of dangerous API usage
> - duplicated logic (maybe? hard to review due to the changes)

Yanked out.

  Luis
