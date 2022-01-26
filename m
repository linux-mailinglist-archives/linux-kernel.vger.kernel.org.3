Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52F49C40D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiAZHIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:08:53 -0500
Received: from out0.migadu.com ([94.23.1.103]:35712 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbiAZHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:08:52 -0500
Date:   Wed, 26 Jan 2022 08:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643180930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50JRhj8xCHSINhFVtiOpyz+7LBIPM7mTDYfmvY3z2Ac=;
        b=AsnH4MllKFzskTP0jOJLUk3M/KhBDtMc9M1LgK75vHLG4kPlcc8eu6TK2m3KQKnSbCr2vo
        cSPoUGYrxeIeUUNQLjMe/GDc4LJc+KqZbEkg67m+sonr8RXsjGE6zY4Ny5zASoA/Ki0flu
        FZJ6xcGRWsyoUV75jGN0tC0HIT+rhoo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>,
        "linuxfancy@googlegroups.com" <linuxfancy@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: usb251xb: add boost-up property support
Message-ID: <YfDzgPwhkIpFv+yR@ltleri2>
References: <20220121232612.7283-1-tomm.merciai@gmail.com>
 <Ye5PUpp9eMX9jSRe@ltleri2>
 <20220125214245.GA4196@tom-ThinkPad-T470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125214245.GA4196@tom-ThinkPad-T470p>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42:45PM +0100, Tommaso Merciai wrote:
> On Mon, Jan 24, 2022 at 07:03:57AM +0000, Richard Leitner - SKIDATA wrote:
> > On Sat, Jan 22, 2022 at 12:26:12AM +0100, Tommaso Merciai wrote:
> > >  
> > > +	if (!of_property_read_u8(np, "boost-up", &property_u8)){
> > > +		hub->boost_up = property_u8;
> > 
> > IMHO we don't need the property_u8 var here as you could pass
> > &hub->boost_up directly to of_property_read_u8() ?
> 
> Hi Richard,
> Thanks for your reply. You mean like:
> 
> if (!of_property_read_u8(np, "boost-up", &hub->boost_up))

exactly.

> 
> Let me know. I'll fix that in v2.
> 

great!

thanks & regards;rl
