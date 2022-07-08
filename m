Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA956B03A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiGHBZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiGHBZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:25:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83472ECE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8891BB823D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876FDC3411E;
        Fri,  8 Jul 2022 01:24:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oT8QKgA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657243496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLW50yiQl4S5ZAgqtQsUJi4rrChTHAzX5WUrzwZlz6E=;
        b=oT8QKgA63i8mYNfn5cryjQHjd82+LLx4Fmn9vZpq095O4HuOoAdGpfDHGrbMVVKhtpJups
        ioeMjpr5qHZIEHNnh+DsWO9YoSznEKqNCCvJ65H1p9SohHEfYPZn8PW7GJIggp6C4Xyd2E
        /Hl6y5FlHyvPjoG+5n8EzIBbfucgdW4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dacab3a7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Jul 2022 01:24:56 +0000 (UTC)
Date:   Fri, 8 Jul 2022 03:24:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] m68k: virt: Kconfig minor fixes
Message-ID: <YseHZq/u9OkVltxW@zx2c4.com>
References: <20220531174514.1586248-1-laurent@vivier.eu>
 <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Jun 02, 2022 at 09:13:14AM +0200, Geert Uytterhoeven wrote:
> On Tue, May 31, 2022 at 7:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.
> >
> > Add an ending period at the end the virt machine help message.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v5.20 branch.

Shouldn't this fix make it for 5.19? It causes Kconfig warnings during
builds. So this seems like a ordinary mid-cycle bug that can be fixed.

For example, if you ctrl+f for "unmet direct" in this log, you'll see
this splat in the wireguard CI:
https://build.wireguard.com/random/108f4fea7b6053dfd09039af74c0ac0c32c956be/m68k.log

Jason
