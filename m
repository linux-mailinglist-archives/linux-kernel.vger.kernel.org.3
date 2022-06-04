Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84E053D630
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiFDJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFDJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A552CCB8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6EE760F13
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 09:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92142C385B8;
        Sat,  4 Jun 2022 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654333564;
        bh=v549zQPMKzOdZleLwz3oKDZrBcUWHPLP+41CoN3fuqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uc7YbBC9dsIWmK/aeUfSo1rYQAnQAzx8DBkGukLnlhqVvgwaiTPso9gN0AJpOLMk3
         WRzhlfCuv5FiS5sNn2aJOJ3ZuFZTEzZIPDWDBT4GUm4aupb8cB2O3mjAy5oGKM1pvW
         mS3hCOhL0sxBDUx4dHz50lftL4bXmy6dv29GbwQg=
Date:   Sat, 4 Jun 2022 11:06:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core changes for 5.19-rc1
Message-ID: <YpsgoMwbMXAROLZ5@kroah.com>
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
 <CAHk-=wgUHjXWUCyyS9Q5TFS8Wc=qJk2q2-sLFVVtqgUi4vfnrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUHjXWUCyyS9Q5TFS8Wc=qJk2q2-sLFVVtqgUi4vfnrQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:11:29PM -0700, Linus Torvalds wrote:
> On Fri, Jun 3, 2022 at 4:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > It's that last change that I'm the most worried about.  It has been
> > reported to cause boot problems for a number of systems, and I have a
> > tested patch series that resolves this issue.
> 
> Ok, pulled and the two patches applied on top.

Thanks!
