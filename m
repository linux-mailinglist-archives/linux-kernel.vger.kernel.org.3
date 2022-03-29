Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E64EA79E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiC2GFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiC2GFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A33BF57
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4232D614D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EF7C34100;
        Tue, 29 Mar 2022 06:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648533800;
        bh=3Df4SOsonTFYbgOYxLg8njXVR9m6FZjiAi5CUkGWaRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK0IwWYq446LY3WTLHv5T87rODeXNxBjkiURfD7hmj5BPoi18p+X4a5rXGsIlifwR
         qDPmPe6NGcGRDrLJKIRSCYK5HbTbx3cvtncmo9VKYGv+TbWrgodvwpCq63Ntsq21yb
         WjALAlsB9kR8BZ9HpldJ3xIB0vbTlJVkt5Z1lxc8=
Date:   Tue, 29 Mar 2022 08:03:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core changes for 5.18-rc1
Message-ID: <YkKhJcLXeoh6qJEt@kroah.com>
References: <YkG6qJsnjjzF0iFD@kroah.com>
 <CAHk-=wgqY_5oWAFvp=zO_HqbdYsQLK+5O3DFgEpRM3MLjNZ9eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqY_5oWAFvp=zO_HqbdYsQLK+5O3DFgEpRM3MLjNZ9eQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:43:39PM -0700, Linus Torvalds wrote:
> On Mon, Mar 28, 2022 at 6:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > There will be a merge conflict in drivers/power/supply/ab8500_chargalg.c
> > with your tree, the merge conflict should be easy (take all the
> > changes).
> 
> And by "take all the changes", I'm sure you mean "take none of them,
> since the code was removed upstream in the meantime".
> 
> Easy typo to make.

Heh, yes, "typo".  :(

You are right, I did the merge the wrong way, yours was correct, thanks
for catching that.

greg k-h
