Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDE4F49CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450898AbiDEW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457518AbiDEQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC32BE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3657B61840
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C52C385A1;
        Tue,  5 Apr 2022 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649174313;
        bh=Br6t58Tuy+glHqI224PUEoUg5nKIr3jjTEjx/ZsSSQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baoJ4dIFQGcser5FsYQ6mYTfHXqEb24i9lCM5didS7uQKIjna3gZD0DrE2WN2rwNb
         2FIh7v0XPNSQ+35qsd6TlE2WCxQR/Kmb5ojXLApKoXUrIY+sdiqEVPgyzFUlRcRzha
         E9OXeso53nAvZA23UsSqci3FjEhdh0FOufzrBEw4=
Date:   Tue, 5 Apr 2022 17:58:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy linux kernel <outreachy@lists.linux.dev>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix indentation
Message-ID: <YkxnJvJyo75c/3yk@kroah.com>
References: <20220405150912.GA625670@euclid>
 <YkxdasBGZ3m2Yu66@kroah.com>
 <CAMWRUK7c-hqiz+KEFkqBuvu1syCwSnF4UZzbkPFw-VWABm9qOw@mail.gmail.com>
 <CAMWRUK7Jgs3evt3bC0pnRkbRw3CS1XCULPi8NzjgGh7aLTFKCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMWRUK7Jgs3evt3bC0pnRkbRw3CS1XCULPi8NzjgGh7aLTFKCQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:45:29AM -0400, Sevinj Aghayeva wrote:
> On Tue, Apr 5, 2022 at 11:19 AM Sevinj Aghayeva
> <sevinj.aghayeva@gmail.com> wrote:
> >
> > On Tue, Apr 5, 2022 at 11:17 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 11:09:12AM -0400, Sevinj Aghayeva wrote:
> > > > Adhere to Linux kernel coding style.
> > > >
> > > > Reported by checkpatch:
> > > >
> > > > WARNING: suspect code indent for conditional statements
> > >
> > > You are also removing unneeded comments, right?  Please explain that as
> > > the documentation link the bot pointed you to showed.
> >
> > I specified that under the --- line:
> >
> > v1 -> v2: Remove the comments that became irrelevant with proper indentation.
> 
> I think I misunderstood the bot's response. It looks like you
> triggered it because you wanted me to write a more complete
> description of what the commit is doing. I thought I received it
> because it was the second version of the patch from a previous
> patchset (the last bullet point in the bot response) that didn't
> include v2 in the subject and a v1 -> v2 after the --- line.

That is one reason, yes, but you also need to update the changelog text
to say everything you are doing in the commit.

> I can do a fresh patch with a complete description and no v2 stuff;
> please let me know.

It will be a v3 patch, right?

thanks,

greg k-h
