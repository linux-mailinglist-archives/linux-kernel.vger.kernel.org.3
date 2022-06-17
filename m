Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211654EFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379410AbiFQChR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiFQChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907AD48321
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C68061CFB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50586C34114;
        Fri, 17 Jun 2022 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655433434;
        bh=3sWdTgFsu11yvxcbFA0N0Nt+heeu3ayv8vuMErzAocM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=knIDy8mFBAkjLBd6+tQqqY1Y/wVkrT2ux5LtdSnrAWuoJ0djR1e1jFM4ApFaxBnAh
         HJJWd/49avVQnhj6nOsNcbBY7sO38vs11L+XTG/P6gsrMKw0rS5CAW21lLPq78+4YD
         AvMe/owRHAgEmWxGjJdiNTorE4PWHog/0WJ1gl+Y=
Date:   Thu, 16 Jun 2022 19:37:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 0/3] A few cleanup and fixup patches for swap
Message-Id: <20220616193713.7ca68b49a0dabc749c495a0f@linux-foundation.org>
In-Reply-To: <20220608144031.829-1-linmiaohe@huawei.com>
References: <20220608144031.829-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 22:40:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> This series contains a cleaup patch to remove unneeded swap_cache_info
> statistics, and two bugfix patches to avoid possible data races of
> inuse_pages and so on. More details can be found in the respective
> changelogs. 

It would be nice to get [1/3] reviewed please.


