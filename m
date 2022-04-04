Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010064F167F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359119AbiDDNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358481AbiDDNwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:52:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8151DA6B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:50:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0C2341F385;
        Mon,  4 Apr 2022 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649080207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbFj/eiu3go+zCzrfYe6IvNnLjC0hQFhm9FhjPLNudY=;
        b=Isz09+/dUd8S3Z2gXYQeaV+P7u+vnqqZCUZcdbu+DLjSp8NryOwoCXoKCNARhTgsbHDMuU
        FRxAXCojxjuFWDTZPj8BbHQh+6ZIeeThnnr1gO66KNxh3s6u0/0NXJ4cDZRFeu9NIX7gy0
        TBpjVCh5+oJdm+TEy6zP5Mfoi2fSbnQ=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AECEFA3B96;
        Mon,  4 Apr 2022 13:50:04 +0000 (UTC)
Date:   Mon, 4 Apr 2022 15:50:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Add FAT messages to printk index
Message-ID: <20220404135003.GA22550@pathway.suse.cz>
References: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648687832.git.jof@thejof.com>
 <8aaa2dd7995e820292bb40d2120ab69756662c65.1648688136.git.jof@thejof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648688136.git.jof@thejof.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-30 17:58:00, Jonathan Lassoff wrote:
> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage the printk indexing system.
> This printk index enables kernel developers to use calls to printk()
> with changable ad-hoc format strings (as they always have; no change
> of expectations), while enabling end users to examine format strings to
> detect changes.
> Since end users are using regular expressions to match messages printed
> through printk(), being able to detect changes in chosen format strings
> from release to release provides a useful signal to review
> printk()-matching regular expressions for any necessary updates.
> 
> So that detailed FAT messages are captured by this printk index, this patch
> wraps fat_msg with a macro.
> 
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
