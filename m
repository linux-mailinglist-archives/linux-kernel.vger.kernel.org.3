Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C003E4EDA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiCaNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiCaNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE7103D8F;
        Thu, 31 Mar 2022 06:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBFE61926;
        Thu, 31 Mar 2022 13:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155CCC340EE;
        Thu, 31 Mar 2022 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648733712;
        bh=aCkusMvkesrwDSvmS3BLFtnpnJ8E1fFKa/EVcuQFOM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdS05gEM0paDn3pjZwCJ9JM09dRKYhqJNi3J03JKqZP8No1NEfXyZZPNAaF89660e
         NT76ADpnFMGIp+y8MimStntvwxZPM10eFEnLKgnll9dlAAfJu48ChBw81aamd+/Hmx
         QTvd0a8gqDMpdsjExwJZVL4YwWgStgCgK4K2b6Ik=
Date:   Thu, 31 Mar 2022 15:35:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>
Subject: Re: [PATCH v5 06/20] rust: add `alloc` crate
Message-ID: <YkWuCenvnvRBkv8V@kroah.com>
References: <20220317181032.15436-1-ojeda@kernel.org>
 <20220317181032.15436-7-ojeda@kernel.org>
 <YkWhs1GffuUmZ4SC@kroah.com>
 <CANiq72mxXY_4wXZPO5VCX76G168X0gynO=n=1xP2shVWBm+yeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mxXY_4wXZPO5VCX76G168X0gynO=n=1xP2shVWBm+yeA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:19:51PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Thu, Mar 31, 2022 at 2:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is a huge patch.  Why not break it into 2, one that adds what is
> > upstream, and then the second adds the "stuff on top" that you need for
> > the kernel.  Otherwise it's hard to know what is, and is not, upstream
> > for us to be able to review from a kernel point of view.
> 
> That is a good idea, will do.
> 
> There are some files from upstream that we do not need, so they are
> already deleted here (e.g. collections), thus what I will do is send
> the first patch without those already and then another patch with the
> modifications/additions we did. If you prefer to see the deleted files
> in an intermediate step, I can also do that.

Nah, I don't care about deleted files :)

thanks,

greg k-h
