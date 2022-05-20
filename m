Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADD52E6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346781AbiETIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346764AbiETH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:59:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945115E485;
        Fri, 20 May 2022 00:59:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 32DA521B62;
        Fri, 20 May 2022 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653033592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ONbGgnv3zbgbzeidBMZy3YNCoQZ655Ohcr0KuG8fEY=;
        b=gtRnHEOvVNgf7nRCjMJqY1mdpLA9NnNyiBy4LxGlue8p+v8zKlZBACX16szCvamP7INy7M
        QdKcW6coXBBQbcH3ZNfEIakR938LEz+kDgWgD3QvYRhBnhxiJcbpf4X64eoggVDG9rwYY+
        HJqCi+lCsxo1+PO54/yJHo9j0G8L1hQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5B442C141;
        Fri, 20 May 2022 07:59:51 +0000 (UTC)
Date:   Fri, 20 May 2022 09:59:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 23/28] mm/memcontrol.c: Convert to printbuf
Message-ID: <YodKd/orDGzLeubj@dhcp22.suse.cz>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-24-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-24-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 13:24:16, Kent Overstreet wrote:
> This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> simalar to seq_buf except that it heap allocates the string buffer:
> here, we were already heap allocating the buffer with kmalloc() so the
> conversion is trivial.

I have asked when you posted this last time around but I do not remember
any response. Let me try again. Why do we want this?
-- 
Michal Hocko
SUSE Labs
