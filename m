Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C654415C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiFICWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:22:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270275C871;
        Wed,  8 Jun 2022 19:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D442DB82ACB;
        Thu,  9 Jun 2022 02:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871AC34116;
        Thu,  9 Jun 2022 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654741326;
        bh=4UJFSbrhIqAE7APyiIraoh6DoS3M8nb6GfnOGTQR41g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PJ6pBayMVOJJDMniK9qhZY4tLjr9DGE+t/FyCyKMBwdj2RSaPpKW/PSH6JKOwJ3Xt
         MkKbijQ2KmvYnSDVP3X29sWbmLB1A5sHvpFUA72qn3Dnb1NB2ENbkU364PTzW6vub/
         nZCt6eyLVAf8vZ9u3WwfW74ihQDiVeoL6aWz5Cto=
Date:   Wed, 8 Jun 2022 19:22:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm tree
Message-Id: <20220608192205.66ebd59dae130d04fbd2b972@linux-foundation.org>
In-Reply-To: <20220609104456.009c53c6@canb.auug.org.au>
References: <20220609104456.009c53c6@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 10:44:56 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   a4bf92bd6e08 ("ocfs2: kill EBUSY from dlmfs_evict_inode")
> 
> is missing a Signed-off-by from its author.
> 
> This is just a patch that went through a mailing list that rewrote its
> From address ... I wonder if we can make git use the Reply-To address
> for the author in these cases?

Thanks.

I fixed my copy.

Best to use an explicit From: line at top-of-changelog when using ocfs2-devel.

The ocfs2-devel list software is the worst thing since windows 95. 
Does all sorts of weird stuff.  Often patches which are cc:me simply
aren't on the list and weren't delivered to me.  I have to hope like hell
that someone cc'ed a vger list.


