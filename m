Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7059B2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiHUIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:35:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346E2019B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C39D6B80BE6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF35C433C1;
        Sun, 21 Aug 2022 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661070914;
        bh=dJRLj2Yh+6Z6dojFVG/cgRPsHfQr7JbfY58ziUilRX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0SyUpxl15opjdscNJ9BNLkMcgeUf8M8lc4lXSIZ4TnXzhgaGUbEOeIbkHFY8+zCp
         Vt1Z4WrtQp0hWWsNdigeIMWDB5PlLOOtUrZ8R8YQLvDm2Hd23iRTn2J6yqXLkC4b51
         0uLuyk6Gpzc4KSETWsQz2pUdkmjIybYZL3HX1kFg=
Date:   Sun, 21 Aug 2022 10:35:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: char: mem: changed 'unsigned' to 'unsigned int'
Message-ID: <YwHuSyur7AQ7PUsC@kroah.com>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
 <Yv5SG8XMR2mZGAqG@kroah.com>
 <Yv7s5dedhRaDlsAC@gus-fring.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv7s5dedhRaDlsAC@gus-fring.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:52:37PM -0500, Paul Lemmermann wrote:
> On Thu, Aug 18, 2022 at 04:52:11PM +0200, Greg KH wrote:
> > On Tue, Aug 16, 2022 at 08:35:31PM -0500, Paul Lemmermann wrote:
> > > found with checkpatch.pl
> > 
> > That is a very sparse changelog text.
> > 
> > Why make this change?  Please be descriptive.
> > 
> I wanted to make this change to be more fitting with the kernel coding
> guidelines, and to reduce a WARNING made with checkpatch preferring the
> use of 'unsigned int' over 'unsigned'. With NOMMU_MAP_COPY defined in
> 'include/linux/fs.h' as an unsigned integer, I felt like the change was
> fitting. I was quickly reminded that the changelog was not properly done, 
> and I now understand that, and will learn from my mistake in the future.
> As I am a new kernel contributor, and looking to hone my skills, what are 
> my next steps? 
> 
> Should I:
> 
> o Drop the patch and resubmit it,
> o Simply drop the patch,
> o Could I change it somehow?,
> o Or something else?

Try something else.  Start out by working in drivers/staging/ on basic
coding style fixes and other things listed in the drivers/staging/*/TODO
files.  That's the best place for new developers to get started and then
after you have some experience with how the development process works,
you can branch out into other subsystems doing real work.

hope this helps,

greg k-h
