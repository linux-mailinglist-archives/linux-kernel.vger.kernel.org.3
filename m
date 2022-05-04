Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB351B3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382022AbiEDXpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384799AbiEDXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F974B85E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5CC5B82798
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D84C385A5;
        Wed,  4 May 2022 23:20:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KTM0gyBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651706400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKkCVVabyR0xZiqzEwLNse/7F7cIokCI/3IfoTyQOnc=;
        b=KTM0gyBp1TAHxlaJ336yyFFAyVIYJP8Hh0PxVGcHxWqz0yQEQp75i804P5dTj+bT0Mf9GO
        10NEx0O13WfwUr2GZm6apS2wYssQS9L/37U3FODa0OqYjUfG2JQBss3MhJxRRwPsGFu/h2
        NCDlri9kln3DbxMWg1vs5UB/fGtxzXI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 771c9d88 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 23:19:59 +0000 (UTC)
Date:   Thu, 5 May 2022 01:19:57 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: remove bogus nops and shutdowns
Message-ID: <YnMKHdRy/GkAB+9e@zx2c4.com>
References: <20220504110911.283525-1-Jason@zx2c4.com>
 <YnL9MuVLtiGWD2EV@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnL9MuVLtiGWD2EV@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 07:24:50AM +0900, Stafford Horne wrote:
> On Wed, May 04, 2022 at 01:09:11PM +0200, Jason A. Donenfeld wrote:
> > Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> > shut down the simulator, which isn't what we want, since it makes it
> > possible to handle errors.
> 
> Do you mean impossible to handler errors?

Whoops, yes.

> 
> > Cc: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> This looks good to me, I didn't add these debug's I think we can remove them.
> 

