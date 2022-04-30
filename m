Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05515160A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 23:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbiD3Vjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiD3Vju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 17:39:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2C55AC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bnDPlV0Dc9sLm1RymyVAiKBxdIfGczhj1WyheEv8HQE=; b=a6pHHUQGzYqW14TCoRaSs4xOv1
        rE9WS1HZ3jD+28LyqdyXmT9x2Y1eWe/yx+uEEHo7MvSK4VxVc0LwHVUZVX17OgL+V9VtA3cCl8Nft
        +cnRFKeqW7sft25+rB0unT20iMTMxue7wsEUfAlsfsEJ0MWdTINioKPZjfDZiNtQv4gv4X49bIA5y
        GYyS8lJRgDNuo0a0CoRmhsMUkteoqGyoC1NtxlPjxMGOEcessAizYe+q1vFUXXH46RTU8XVMxH8gQ
        gjfX96LsZiQcJ2fytOIUBkUmRHxMCjx4h1sZiHVD6x3zgmO1xyL7gh16d8t2h+Y3f1v7SgqFjpdBQ
        hnXC3YAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkulB-00DblM-Pu; Sat, 30 Apr 2022 21:36:13 +0000
Date:   Sat, 30 Apr 2022 22:36:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 60/69] fs/ntfs/aops.c:378:12: warning:
 stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio'
Message-ID: <Ym2rzWiP8iNRHWxS@casper.infradead.org>
References: <202204301355.hFVoSOPa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204301355.hFVoSOPa-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 01:11:43PM +0800, kernel test robot wrote:
> >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
>    static int ntfs_read_folio(struct file *file, struct folio *folio)
>               ^
>    1 warning generated.

Am I getting this warning because I changed the name of the function?
Or did I do something Bad?
