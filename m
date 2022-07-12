Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C945712C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGLHGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGLHGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AC1D0EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E753C6145E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E416C3411E;
        Tue, 12 Jul 2022 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657609588;
        bh=MP0uzzFcceumWSBM4lX//R6k5kdcxpj+GchyzR+eBz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcqvrkIGixWxHLTsQtaMtD02SRT1TTYKGZfezw+/xrrEe4nqCZ+iTexPGIAHMjfXu
         df7njvHnp84LljzFRWV5dKQI2Y8pvNo+5fsfLgDxYroISx/jPVmxZu2VmVlokCTW2u
         L0IHaHskPR/wyzvcL9h4frNzAPKnx7MulviC21+U=
Date:   Tue, 12 Jul 2022 09:06:22 +0200
From:   Greg Kroah-Hartmann <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 0/1] drivers: mcb: updates for 5.20
Message-ID: <Ys0dbseAdP4/u76H@kroah.com>
References: <cover.1657607743.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1657607743.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:50:07PM -0700, Johannes Thumshirn wrote:
> Hi Greg,
> 
> Here's one patch for drivers/mcb aimed at 5.20. It's a simple change from
> ida_simple_get()/ida_simple_remove() to ida_alloc() and ida_free() from keliu.

I'll take this, but you need to fix up your email infrastructure, it is
sending out bad DKIM signatures, which do not make me the most
comfortable taking, as anyone could be spoofing your address:

Looking up https://lore.kernel.org/r/480676bee970da16bf1fa8565277240014395ba3.1657607743.git.johannes.thumshirn%40wdc.com
Grabbing thread from lore.kernel.org/all/480676bee970da16bf1fa8565277240014395ba3.1657607743.git.johannes.thumshirn%40wdc.com/t.mbox.gz
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH 1/1] drivers: mcb: directly use ida_alloc()/free()
  ---
  ✗ BADSIG: DKIM/wdc.com
---
Total patches: 1
---

Can you please work with your email admins to fix this up?

thanks,

greg k-h
