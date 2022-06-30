Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D25621E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiF3SQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiF3SQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:16:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F88403E0;
        Thu, 30 Jun 2022 11:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDDA2B82CBF;
        Thu, 30 Jun 2022 18:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781D6C34115;
        Thu, 30 Jun 2022 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656612975;
        bh=WVpQEqGk9zuuL1aUYhT5g/8KiyE/RmhI2jZcnyVZeow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K/roTi+5gxgJE1nCDooNRMRd3nY/bUWad/XWwK8FFKjAVPhh3yVYxXgK2OzEoaL3I
         4t9b7pUaL+W4poDFtR2IW7sfunj5lNwQbCYh8oNAswR0wST8abXc2V6dmtEUuIvBFx
         3nAogg6UJD4+AhRuEWHUeJ6NvgsilAGIyZJGegn0=
Date:   Thu, 30 Jun 2022 11:16:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20220630111614.2b49d552ce5d59964d9f77c9@linux-foundation.org>
In-Reply-To: <20220630152816.pyqzoluhmv2uivpq@revolver>
References: <20220630133712.1a3b0ff9@canb.auug.org.au>
        <20220630152816.pyqzoluhmv2uivpq@revolver>
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

On Thu, 30 Jun 2022 15:28:22 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * Stephen Rothwell <sfr@canb.auug.org.au> [220629 23:37]:
> > Hi all,
> > 
> > In commit
> > 
> >   500caa69a5a0 ("test_maple_tree: add test for spanning store to most of the tree")
> > 
> > Fixes tag
> > 
> >   Fixes: 1d3ae73e4e86 (test_maple_tree: Add test for spanning store to most of the tree)
> > 
> > has these problem(s):
> > 
> >   - Target SHA1 does not exist
> > 
> > It seems to be self referential ...
> 
> This is a result of an added test case then getting fixed by adding one
> more testcase to catch a corner case.
> 
> What you put in the branch is correct.
> 
> Testing was added: 502cefe29b10 "lib/test_maple_tree: add testing for maple tree"
> New test was added, fixing the above: 2197398d8d44 "test_maple_tree: add test for spanning store of entire range"
> One more test added, fixing the above: 500caa69a5a0 "test_maple_tree: add test for spanning store to most of the tree"

These IDs are meaningless until the patches are added to mm-stable -
they'll change every day.  I simply removed the hashes from the Fixes:
lines.

