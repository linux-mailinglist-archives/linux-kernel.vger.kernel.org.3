Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA04B3AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiBMJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 04:56:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 04:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A05C873
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 01:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 081AE60EFA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9059C004E1;
        Sun, 13 Feb 2022 09:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644746174;
        bh=WznLcmlKCHSyOi66nBvfT5kFkbrjbndNydmARu+Zurc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4v1O6aXyefnEnWVeEbJoJzqBy69isIH5QDeqfkQLVYI0JfaaX8lEo7pWFd7YdbzI
         BeCWp+uazT+pLaMLowjDk3ItOB41thpPi2PPCG0ILeTvBsZEb4BDzm9MdD4GRXAoxg
         urSGeSyg3vz1EFc9ss6c7KXSau5jkbahyuTdG4rM=
Date:   Sun, 13 Feb 2022 10:56:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add driver for GSC controller
Message-ID: <YgjVuyE1n5vl6uR1@kroah.com>
References: <20220213091458.2364014-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213091458.2364014-1-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 11:14:53AM +0200, Alexander Usyskin wrote:
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
> 
> There are two MEI interfaces in GSC: HECI1 and HECI2.
> 
> This series includes instantiation of the auxiliary devices for HECI2
> and mei-gsc auxiliary device driver that binds to the auxiliary device.
> 
> In v2 the platform device was replaced by the auxiliary device.
> v3 is the rebase over drm-tip to make public CI running.
> In v4 the not needed debug prints and empty line were removed,
>       'select' were replaced by 'depends on' in MEI Kconfig,
>       the new include file now listed in the MAINTATINERS file. 
> V5, rebase and add Greg KH Reviewed-by
> V6, rebase and drop redundant assignments found by the kernel test robot.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This line needs to be added to the individual patches if you want any
tool or maintainer to pick that up.

thanks,

greg k-h
