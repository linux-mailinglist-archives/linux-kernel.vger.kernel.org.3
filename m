Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8893457FB90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiGYIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiGYIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D714015
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFA161208
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151E3C341CF;
        Mon, 25 Jul 2022 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658738477;
        bh=/HB3Uzk9dZaAy+A6UzvSrfBCRCsObkHLmT+uzcqVNZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nxo+3JCJsKzBfvAD6tdUtTaL5q34i7obsjm9cH5pxB4Wf49ZZMZ1QUPibI8XRPlRK
         ltMqEaVeHBqRi+05IQZTi/4Z6PZFgQistjtcAnJeULjpZxNGra9ZT2keQ4weG/YH3y
         joEv+imbR6PTuXamXvAT+Pz4l69j6xg+vZW1EgaI=
Date:   Mon, 25 Jul 2022 10:41:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Yu <renyu@nfschina.com>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
Subject: Re: [PATCH 1/3] lkdtm/fortify: Check possible NULL pointer returned
 by kmalloc()
Message-ID: <Yt5XKEzSz3uAvjCJ@kroah.com>
References: <20220725081000.19407-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725081000.19407-1-renyu@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:10:00PM +0800, Ren Yu wrote:
> As the possible alloc failure of the kmalloc(),the return pointer
> could be NULL,therefore it should be better to check it.
> 
> Signed-off-by: Ren Yu <renyu@nfschina.com>
> ---
>  drivers/misc/lkdtm/fortify.c | 3 +++
>  1 file changed, 3 insertions(+)

For some reason this patch series is not properly threaded, so our tools
can not pick them up automatically.  Can you please resend them threaded
properly (git send-email can do this for you)?

thanks,

greg k-h
