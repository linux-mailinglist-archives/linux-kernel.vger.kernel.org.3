Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796652E4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbiETGDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiETGDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:03:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B314AC8F;
        Thu, 19 May 2022 23:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55CE0CE28C1;
        Fri, 20 May 2022 06:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395ACC385A9;
        Fri, 20 May 2022 06:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653026626;
        bh=kavH15HxjDABcLAwAacr39uq4nUfy4tlsuWMTt/128Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOfHvGMOxvEuR9SFoPJZPTQfK8HRiFCRtbgNpYwHFUbKX3pf+N/k1xxGmITkUsOpI
         SS9npiymCKID5I11EguHR33/+NDyFPVNu6x5OtdUK25T+jL+V2MqA0wvAx1BhAPHDo
         o7X3eCexebnDZx9IxiGdZZRoA/h369PY02RtaiuU=
Date:   Fri, 20 May 2022 08:03:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Baker <len.baker@gmx.com>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srivathsa Dara <srivathsa729.8@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix checkpatch.pl struct should normally
 be const
Message-ID: <YocvQJNfA8726Kf6@kroah.com>
References: <20220519172503.10821-1-me@wantyapps.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172503.10821-1-me@wantyapps.xyz>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:25:01PM +0300, Uri Arev wrote:
> This simple patch fixes a checkpatch.pl warning in `fbtft/fbtft-core.c`.
> 
> Reported by Checkpatch:
> WARNING: struct fb_ops should normally be const
> 
> Signed-off-by: Uri Arev <me@wantyapps.xyz>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Always test-build your patches before submitting them :(
