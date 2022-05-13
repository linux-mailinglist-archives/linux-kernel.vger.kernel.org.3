Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A8525F55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbiEMKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEMKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:04:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC865DA31
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 906FFB82D69
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1EC34113;
        Fri, 13 May 2022 10:04:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o456yJyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652436267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7N6xB4W6thqhcdDfV4PV2FXKnzYMTtVOVwyux6OehkY=;
        b=o456yJybAwDr76wPvhcATttE/rOtmbhc00u1hq6MoEYo621wVNvBnLGFk0nVszOj9xU/7j
        qJcHRUOOQJoUpsQgtwImiiLmtbEwjvaGUHp+83yDazhqftj+B6FsIr+NRk3vWPJM+IY1Qv
        RlYr0KTDrQGNqzf+xyg+FBfBoDyAkIo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b32beb18 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:04:26 +0000 (UTC)
Date:   Fri, 13 May 2022 12:04:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: handle latent entropy and command line from
 random_init()
Message-ID: <Yn4tKA3VqJVeV9KH@zx2c4.com>
References: <20220512124839.20755-1-Jason@zx2c4.com>
 <Yn34RROzSQtHP/rZ@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn34RROzSQtHP/rZ@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:18:45AM +0200, Dominik Brodowski wrote:
> > -static inline void add_latent_entropy(void) {}
> > +static inline void add_latent_entropy(void) { }
> 
> Stray change here, which doesn't seem necessary...

Will remove from this commit. I plan to cleanup random.h anyway and
might change it back then.

Jason
