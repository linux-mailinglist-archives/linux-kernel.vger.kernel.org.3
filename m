Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDA49E0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiA0Lb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:31:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55768 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiA0Lb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:31:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C266B82229
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82722C340E4;
        Thu, 27 Jan 2022 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643283114;
        bh=nUcH8znezYjW1WS7mB1iqNEDvlkOO2kpsNW6OLVyPLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztx6Y9DovvzvuGzel7vHJHGDf/2WMYKUp/TtGM6dlJqVZSkdwiTaIXI0/qzAYOoPE
         OwitjAJPOFn08XJfwJG+PPZ5tTy5RTCUhTxpQ1bGNJq7qCWdfBnyNy42gq31rxnyxb
         qe873sysQgyASv8QwKAvEqezPDxR50hUXVfhdxso=
Date:   Thu, 27 Jan 2022 12:31:51 +0100
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
Subject: Re: [PATCH v4 0/5] Add driver for GSC controller
Message-ID: <YfKCp9zmDwp3Qz7j@kroah.com>
References: <20220127112103.2336871-1-alexander.usyskin@intel.com>
 <YfKCe9ALCjrUO+89@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKCe9ALCjrUO+89@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:31:07PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 27, 2022 at 01:20:58PM +0200, Alexander Usyskin wrote:
> > GSC is a graphics system controller, it provides
> > a chassis controller for graphics discrete cards.
> > 
> > There are two MEI interfaces in GSC: HECI1 and HECI2.
> > 
> > This series includes instantiation of the auxiliary devices for HECI2
> > and mei-gsc auxiliary device driver that binds to the auxiliary device.
> > 
> > In v2 the platform device was replaced by the auxiliary device.
> > v3 is the rebase over drm-tip to make public CI running.
> > In v4 the not needed debug prints and empty line were removed,
> >       'select' were replaced by 'depends on' in MEI Kconfig,
> >       the new include file now listed in the MAINTATINERS file. 
> > 
> > Greg KH, please review and ACK the MEI patches after main merge window closure.
> 
> The merge window already closed, did you forget to update your email?
> 
> > We are pushing all through gfx tree as the auxiliary device belongs there.
> 
> I'll get to this in a week or so, please be patient.

In the meantime, while you are waiting, please review other patches on
the mailing lists to help with maintainer's workloads.

greg k-h
