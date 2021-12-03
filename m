Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11746753C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbhLCKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbhLCKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:42:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2CC061757;
        Fri,  3 Dec 2021 02:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA555B825B2;
        Fri,  3 Dec 2021 10:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C478FC53FAD;
        Fri,  3 Dec 2021 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638527962;
        bh=6va5Zk+pAgxRYYsQY3MBmfGvpWl59mzgdzKVy0yOWJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYoNrrPisaSNjpPt4VMudPaJNym6r3oDImPZQrDbpuULRRn9Ewil1SjO3wyJ3GrwD
         TuuU0h4R9vzL9w9i9jKRDhm4IcFbbNDlA6L1ZvZLGvOrvycQQmZ7cQxT6SUwkia4Fm
         nUTgjJ7r2XFLaxJ3y1IFkWgL6DzPDvHwOGMVNkik=
Date:   Fri, 3 Dec 2021 11:39:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yanz1xpZamJVZ0LE@kroah.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:48:45AM +0800, Tony Huang wrote:
> IOP (IO Processor) embedded inside SP7021 which is used as
> Processor for I/O control, RTC wake-up and cooperation with
> CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v2:
>  - Addressed comments from Arnd Bergmann.
>  - Addressed comments from Greg KH.
>  - Addressed comments from kernel test robot.
> 
>  MAINTAINERS                    |   1 +
>  drivers/misc/Kconfig           |   1 +
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/iop/Kconfig       |  13 ++
>  drivers/misc/iop/Makefile      |   6 +

Why do you need a subdirectory for a single .c file?

thanks,

greg k-h
