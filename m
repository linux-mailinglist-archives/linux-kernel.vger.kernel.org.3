Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBE47BCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhLUJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhLUJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:28:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A6C061574;
        Tue, 21 Dec 2021 01:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54BB56149F;
        Tue, 21 Dec 2021 09:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379BDC36AE2;
        Tue, 21 Dec 2021 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640078892;
        bh=RZo6lge6X6obq2oOehXsW2SVPZlbm6/HXQ0bWrHOATs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y7eaQL/+s66cWXwvBPdxqQZO1SayEAHzCJAg5oo0c4fkrE1LQpIN6MOlNbeREp/hb
         a1qEEPazkXVmaMrn705X0V+/+01SmwN0Neidr1OtuqGMdlTM8GpvKNfvPyFB++tuLC
         SzS9yHDaBPe3Go8IrzPzbCf9RJ9fQ9ZCvtAKUmwI=
Date:   Tue, 21 Dec 2021 10:28:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v4 01/34] component: Introduce struct aggregate_device
Message-ID: <YcGeKpy/oecKlKZg@kroah.com>
References: <20211202222732.2453851-1-swboyd@chromium.org>
 <20211202222732.2453851-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202222732.2453851-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:26:59PM -0800, Stephen Boyd wrote:
> Replace 'struct master' with 'struct aggregate_device' and then rename
> 'master' to 'adev' everywhere in the code. While we're here, put a
> struct device inside the aggregate device so that we can register it
> with a bus_type in the next patch.

Do not do a "while we are here" type change please.  Do the
rename/replace first, and then make the other change.

> The diff is large but that's because this is mostly a rename, where
> sometimes 'master' is replaced with 'adev' and other times it is
> replaced with 'parent' to indicate that the struct device that was being
> used is actually the parent of the aggregate device and driver.

The diff is 15 lines, how is that "large"?

thanks,

greg k-h
