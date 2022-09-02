Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619215AB3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiIBOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiIBOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:38:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7ACD6BA8;
        Fri,  2 Sep 2022 06:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4597CB82C04;
        Fri,  2 Sep 2022 13:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422BC433D6;
        Fri,  2 Sep 2022 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662127123;
        bh=CPhgVqNKtUm3TA/iDUpO4lt9jWqZzOhC6IARmgyorh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yg9eXfSLnYFOEbwEK8J7lnKI39D4JvK4jqJyCix8N+u1jHyZMns/ZWeWvYBjCsf9k
         AEwZGcvGc4wePiMX0gKbsau46khk1q9BP2A8o/oIffodEjKvkyGbD3eHhffE7KkKdt
         +j99BdhH/Ipu5M3XaTejsvBtWKd+qDGeMuKMhmAs=
Date:   Fri, 2 Sep 2022 06:58:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the block tree
Message-Id: <20220902065842.904d01fcfd377b84b2293197@linux-foundation.org>
In-Reply-To: <87d96d36-fd13-2268-122b-fea806090942@nvidia.com>
References: <20220901161722.739d2013@canb.auug.org.au>
        <1a6632f1-5e23-5fb3-1af2-6d653e4338d4@nvidia.com>
        <f80623f2-7c19-c121-6eff-f5bb4f1cfc48@kernel.dk>
        <87d96d36-fd13-2268-122b-fea806090942@nvidia.com>
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

On Fri, 2 Sep 2022 00:02:19 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> Andrew, is that OK with you? The first two patches will still get
> reviewed by mm, and they shouldn't conflict with mm, even if they
> go up through the block tree.

Sure. 
