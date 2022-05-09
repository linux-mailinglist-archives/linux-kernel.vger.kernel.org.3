Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D415205A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiEIUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiEIUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABB1FE1E8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9A67B818D0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8C1C385B2;
        Mon,  9 May 2022 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652126564;
        bh=UMOOB7YSujiMAdtG/QEVVPNAqwI1asrAIi+csk8CC7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MEPtD8bChgy0mijeAFAlbSdzU2bmICfo+J3qJZWE1D1kjCVb3TXYogJztDE+InuvT
         Q5Sm7CKHDmamp/l1rBY+alU2vuvVQe7WKmb05dPHpEmN+M6HHOz3GOoIYimgvPL8cT
         SjbzrYGh6Vzn5arOQXy7QHqa8ljxgy5BFoGk8uZo=
Date:   Mon, 9 May 2022 13:02:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/69] Maple Tree v9
Message-Id: <20220509130243.b4de05da6a1c3e1acf57c8ba@linux-foundation.org>
In-Reply-To: <20220509185524.p5hqqv6jqhql4sup@revolver>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
        <20220505192518.72ae9ada349f2880ba90c3e9@linux-foundation.org>
        <20220509185524.p5hqqv6jqhql4sup@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 18:55:43 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [220505 19:30]:
> > On Wed, 4 May 2022 01:07:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > Please merge this patch set into the mm tree.
> > 
> > Well that was kinda confusing ;)
> 
> Yes, sorry about that mess.
> 
> > 
> > I have it all landed and compiling, thanks.  I'll suppress the usual
> > added-to-mm emails - an armistice in my war against `d' keys.
> > 
> 
> 
> Which git branch will have these changes?

mm-unstable, which is the "all hotfixes and all MM" branch.

Current branch structure is

master
  mm-hotfixes-stable
  mm-stable
  mm-nonmm-stable

mm-hotfixes-unstable is mm-hotfixes-stable + hotfixes quilt

mm-unstable is mm-hotfixes-unstable + mm-stable + mm quilt

mm-nonmm-unstable is mm-nonmm-stable + nonmm quilt

mm-everything is mm-unstable + mm-nonmm-unstable
