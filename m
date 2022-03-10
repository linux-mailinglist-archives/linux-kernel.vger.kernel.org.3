Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7144D44D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiCJKml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiCJKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:42:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931613913F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5B8F611C9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A8FC340E8;
        Thu, 10 Mar 2022 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646908898;
        bh=fHKQNGSz/V5HOJIZrj0uai9Cj+ISv5gFJroWTRzw8mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JilwpExAc1R0Ip+ugwq/ql3K0QGGU34Ys8WZC/aq3IzrJpKN27rOXrygEpvmFj4E0
         fpSxQpZqfDMajRWRcP6QJwOfQW276Du52ATcwQa+Gd9PJCPMiUHe6xn3A9kELEqGSJ
         WpMca0mH8JQUpEwUlgEYaJSnP/sFgQz2eHagyssO+I2sgTKbj+6pCTuueERzfDVa9x
         Z1r7fA1jmcX4kR2q5Jh+NE1/gKDYoNsL9oF8Lvd3YKW71huNqPnUJ0RqWUz1TEc1Ho
         6JUqfdY6RcltwOr2qmRX5xOpwNEWEdjMIMY731u89o+PLlqPP85f8w+hcQvuIU3nno
         oeg7F5oynjZ8g==
Received: by pali.im (Postfix)
        id 7E5C47FC; Thu, 10 Mar 2022 11:41:35 +0100 (CET)
Date:   Thu, 10 Mar 2022 11:41:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: marvell: armada-37xx: Remap IO space to
 bus address 0x0
Message-ID: <20220310104135.licbldjs2dvy2nm4@pali>
References: <20220218212526.16021-1-pali@kernel.org>
 <20220304163027.29357-1-pali@kernel.org>
 <87k0d2i0mr.fsf@BL-laptop>
 <20220310100943.m33wsynnvexw7dts@pali>
 <CAK8P3a2Q5fVUMKHz=co0_D5suLBk0rCyGKz3g854fv-HS=G3Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2Q5fVUMKHz=co0_D5suLBk0rCyGKz3g854fv-HS=G3Sw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2022 11:22:38 Arnd Bergmann wrote:
> On Thu, Mar 10, 2022 at 11:09 AM Pali Rohár <pali@kernel.org> wrote:
> > On Thursday 10 March 2022 11:05:00 Gregory CLEMENT wrote:
> 
> > >
> > > This patch has been refused by Arnd so I removed it from the mvebu/fixes
> > > branch so you should not apply anything on top of it.
> >
> > Ok, so what is wrong with a change which increase size of IO space to 1 MB?
> 
> It should not cause any harm, but there is really no point in this if no known
> devices use more than a few bytes, and Linux only maps the first 64KB of
> the I/O space for each host bridge. I don't actually see where we limit the
> size to 64KB, so maybe that changed recently.
> 
>         Arnd

Ok. Anyway, I was told that DTS should describe HW properties and not to
be bound with SW implementation or SW limitations, like case here if
Linux SW limits some sizes.
