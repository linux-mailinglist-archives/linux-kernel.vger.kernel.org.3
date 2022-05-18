Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3452BD12
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiERNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiERNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:36:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B152DFD;
        Wed, 18 May 2022 06:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 543C4B82083;
        Wed, 18 May 2022 13:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89616C385A5;
        Wed, 18 May 2022 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652880966;
        bh=oJgGE/U/600vozHy4AelMqkmeOz+tzQfDwltmuWAQPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KsBIZPmx/Fm1G53huMfh7NxwlHW6csG8TbCvHk3u8f9DkrUSwAgIXK8V2z8ydyzNL
         urNz97aVVwDzm+1ewrXeAKM+pLk7domZdR5srRIfnl3nUMY+Gacb8KNKJtHE7PcHCh
         YXYZjaMQuW75VFu+3bVYIPpzTbC8BKA7lRHLk/4E=
Date:   Wed, 18 May 2022 15:36:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 8/9] scripts/spdxcheck: Exclude dot files
Message-ID: <YoT2QwOuaQXs17Bk@kroah.com>
References: <20220516101901.475557433@linutronix.de>
 <20220516102615.884180377@linutronix.de>
 <CANiq72kSqKqoUsiFhg0+a65vc3KPTW4zpt-Dh8geVWUMPkWFwg@mail.gmail.com>
 <875ym5qpw7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ym5qpw7.ffs@tglx>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:43:52PM +0200, Thomas Gleixner wrote:
> On Mon, May 16 2022 at 16:22, Miguel Ojeda wrote:
> > On Mon, May 16, 2022 at 3:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> None of these files
> >>
> >>      .clang-format, .cocciconfig, .get_maintainer.ignore, .gitattributes,
> >>      .gitignore, .mailmap
> >>
> >> have copyrightable content. They are configuration files which use a
> >> publicly documented format.
> >
> > Should this files remove their SPDX-License-Identifier? If yes, we
> > should do that for `.clang-format`.
> >
> > As another suggestion, we should check that the ignored files actually
> > do _not_ have the `SPDX-License-Identifier` (i.e. so the above case
> > would trigger a diagnostic).
> 
> Good questions. I'm happy to drop this patch for now until this
> discussion has been settled.

I've now taken all patches in this series except for this one.

thanks for doing this work,

greg k-h
