Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0F452E83C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiETJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbiETJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:04:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E6EAD2A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4000B82A58
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C3EC385AA;
        Fri, 20 May 2022 09:04:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hAh4Rder"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653037467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8KCCzNHU6eZS5j43N+vGh9MzBxmspA77WafJzA/ZWQ=;
        b=hAh4RderabuCLS7xkNQqYfxEsjUVXiLmYTc310iSFFCGHnWzC9gz7NMLTySRJmxztXw4Vb
        6LN+zKdf/fOk+sNzKZ3z3+jMAFpgaqcg9LzxYVv+dPFdFIG90f9n2/0GpvUxsu9qqgAhFy
        m9mcBVOgtV1EyGxifF588oZE7HJVrog=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b51b5a08 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:04:27 +0000 (UTC)
Date:   Fri, 20 May 2022 11:04:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] random: convert to using fops->read_iter()
Message-ID: <YodZmaC5Vga/fR/1@zx2c4.com>
References: <20220520004058.96691-1-Jason@zx2c4.com>
 <20220520004058.96691-2-Jason@zx2c4.com>
 <656e0873-8f8c-341e-b0ad-b793610eea3c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <656e0873-8f8c-341e-b0ad-b793610eea3c@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 07:11:37PM -0600, Jens Axboe wrote:
> On 5/19/22 6:40 PM, Jason A. Donenfeld wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > 
> > This is a pre-requisite to writing up splice() again for the random
> > and urandom drivers.
> 
> s/writing/wiring
> 
> Looks like I typo'ed that one.

Will fix.

Jason
