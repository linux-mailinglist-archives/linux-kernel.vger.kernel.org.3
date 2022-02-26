Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE614C5489
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiBZH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiBZH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:59:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F721652F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:59:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D96DC60F44
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE77DC340E8;
        Sat, 26 Feb 2022 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645862351;
        bh=VHjr7f2HRH0bpdum7Sn3FYXa463vDmGzha8n5Y5qImY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPIeBCiOzDi5VBowjjOLlNe6PtOuuZ+7BTsmNS67AXSd5BbXi8ERagNt8jn3DCr8q
         r6bQM2SoUz83RV/tl0CNNeyC9u0Nq50UMlkie1YcMsyQCrUL9GWsAEc4QVPD8WUtXJ
         c60Wnh0fJvUb5CcfT/qmIIc+Y9hWl1ES8wehQ0Y8=
Date:   Sat, 26 Feb 2022 08:59:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging driver fix for 5.17-rc6
Message-ID: <Yhndy5cTzhJh7abq@kroah.com>
References: <YhjYPIRvDnV7XAzV@kroah.com>
 <CAHk-=wjLvye-_qj-J=dVWhFf7S8noL6d-szRtFYq_hoOk6J1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLvye-_qj-J=dVWhFf7S8noL6d-szRtFYq_hoOk6J1Eg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:57:43AM -0800, Linus Torvalds wrote:
> On Fri, Feb 25, 2022 at 5:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > It resolves a reported problem in the fbtft fb_st7789v.c driver that
> > could cause the display to be flipped in cold weather.
> 
> LOL. WTF?
> 
> I just had to read the commit message for that odd thing.

Here it is in the real world, I should have added this to the changelog,
but I figured the url might not be permanent:
	https://www.core77.com/posts/111994/Hyundais-Strange-Cold-Weather-UI-Bug-Digital-Dashboard-Rotates-Flips-Display

