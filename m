Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77047BCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhLUJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:17:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbhLUJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:17:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A042B81219
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC26C36AE7;
        Tue, 21 Dec 2021 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640078272;
        bh=q51t2NzmRXmbdnp6VDfo3lr2QfxI4hCXCyzNd96iEVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1+q+4O/Nru5Xthl5rallBW22GoOZFK7gEo4GZ9ElI34MixjRWwW/lye4u+YUrSMr
         4cYWGSulXOJxfJo+LdDEU9D9S+xsMkW4BdaC3/RneY30AFGk59ZyQ8cVn24REfQvsi
         LJYSoLu2aExFlAKtSeGjtu24VTDXsqe+XBFnIqjI=
Date:   Tue, 21 Dec 2021 10:17:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for runtime features
Message-ID: <YcGbvXzvLtgBo+sq@kroah.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
 <20211206112101.24955-2-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206112101.24955-2-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:20:59AM -0800, Ronak Jain wrote:
> Add support for runtime features by using an IOCTL call. The features
>  can be enabled or disabled from the firmware as well as the features
>  can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
>  Similarly, the user can get the configured values of features by
>  querying IOCTL_GET_FEATURE_CONFIG id.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v4:
> - Update commit message
> 
> Changes in v3:
> - Resolved merged conflict
> 
> Changes in v2:
> - Resolved merged conflict
> - Update commit message
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

I still get merge conflicts with this change:

checking file drivers/firmware/xilinx/zynqmp.c
Hunk #1 succeeded at 1156 (offset 27 lines).
checking file include/linux/firmware/xlnx-zynqmp.h
Hunk #1 FAILED at 126.
Hunk #2 succeeded at 376 (offset 17 lines).
Hunk #3 FAILED at 435.
Hunk #4 succeeded at 697 (offset 31 lines).
2 out of 4 hunks FAILED


What branch/tree are you making it against?

thanks,

greg k-h
