Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9258877B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiHCGiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiHCGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5B57258
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88172614AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D103C433D7;
        Wed,  3 Aug 2022 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659508678;
        bh=TEWtmPkLhI0RtdjmF1oEpEAhYBlg0ksDz42Myt068Vc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TGEhzl4v8hmbd0W7dEm4f8M5Gw7cwDlIJnU6ieXPBSxMm9Kd9RE0DnH9j/d5CLaTN
         0ayrrR6W5RaIEprReRRxyf3AdHjjW9D24FzDFDLMO/1PrLQBXJSpdfyHOQ5QZiJ974
         ihRMpVFQHpUaMfyQBf8HrFFUSqyxqPeTwQbOVLnk=
Date:   Wed, 3 Aug 2022 08:37:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: add firmware dependency
Message-ID: <YuoXxHjAKKxZOinU@kroah.com>
References: <YukkBu3TNODO3or9@nx64de-df6d00>
 <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
 <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
 <YulcdKfhA8dPQ78s@nx64de-df6d00>
 <YuoQ37PIKzWO1zIY@kroah.com>
 <YuoWvwUer1bF0BtQ@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuoWvwUer1bF0BtQ@nx64de-df6d00>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:33:35AM +0200, Grzegorz Szymaszek wrote:
> On Wed, Aug 03, 2022 at 08:08:31AM +0200, Greg KH wrote:
> > This looks good, and I'll apply it after 5.20-rc1 is out,
> 
> I didn’t Cc stable since the “Submitting patches” guide says it’s for
> “severe bugs”, but would it be possible to backport the patch to the
> older kernels?

Yes, I will tag it for backporting.

> > but you might want to send a follow-on patch that removes the hard-coded
> > string in 2 places in the driver, and just puts it into a single define
> > somewhere, to make it a bit easier over time.
> 
> Good idea, will do so. I didn’t check if the filename is already used.
> Would something like “this patch depends on patch…” (again from the
> guide) be enough (assuming I will send the new patch before this one
> is applied)?

No need to add the "this patch depends on", I'll know that implicitly as
it was sent after this one :)

thanks,

greg k-h
