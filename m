Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296857FBE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiGYI54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGYI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC54B4C;
        Mon, 25 Jul 2022 01:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7011E611B1;
        Mon, 25 Jul 2022 08:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D1BC341C6;
        Mon, 25 Jul 2022 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658739472;
        bh=rf5Z7s4elvO8Fri1LRLNFT3ks76MVvfWrJ0qPBTBAy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PonU/TDFHeItS7Ovx0MlyVxR2SVV8y5KBjkqGTCzaZsArCVQ6W1FQvYGomjMd40it
         JjaAbK84k0mVZjbA+eIfsszF7l+i9rkOCEya43rPCDMZx2r0Zfn84LiPhffcVv/svD
         kJKUBS48tm9t6RzRwkhWxlImYCOiD5kcraZQRRxgMJiRWkSnUiXOLIjcbJRiqvqbDo
         bU7D6uB6Cz94qzfLl9PEjKuQMfwsUc6Klk4z7oyI3cMAEYolrJyPQjdWvFgjrbO00c
         dKS4A6vC6vUCgTucT+Nhqy/kgHwxPq2J0Mlo4ig+BBOglY8ErKCTXr+/SSAalZW2Kt
         cpS0WKYd9nheg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFtud-0000yS-Rq; Mon, 25 Jul 2022 10:58:03 +0200
Date:   Mon, 25 Jul 2022 10:58:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: fix tty-port initialized comments
Message-ID: <Yt5bGx79ymjsrK2A@hovoldconsulting.com>
References: <20220725084457.3010-1-johan@kernel.org>
 <Yt5aIiA8mvU905eB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5aIiA8mvU905eB@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:53:54AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 25, 2022 at 10:44:57AM +0200, Johan Hovold wrote:
> > Fix up the tty-port initialized comments which got truncated and
> > obfuscated when replacing the old ASYNCB_INITIALIZED flag.
> > 
> > Fixes: d41861ca19c9 ("tty: Replace ASYNC_INITIALIZED bit and update atomically")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Looks good, want me to take this now as my tree should be "closed" for
> 5.20-rc1 now, but stuff like this can sneak in.

I was hoping to be able to use that extra week that -rc8 bought us.

I have a three trivial cleanups in my -next branch. Mind if I add this
one on top and send it to you straight away?

> If not, and you want to send it to me later, feel free to add:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Johan
