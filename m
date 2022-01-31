Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47FD4A4897
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379130AbiAaNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:48:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379114AbiAaNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:48:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2351A612B3;
        Mon, 31 Jan 2022 13:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0012BC340E8;
        Mon, 31 Jan 2022 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643636930;
        bh=gYUYds47kHZ94ccteftaphg2yke9U1WSadhULxENiFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2V1fEED/KqCSYu9KhHlsqWfMTS/WkH+xUGgQWJyGWzrdhjBFUpE7KQxY6Digwh2H
         xC1x96pD04RU9cWmTiLCDliUWvKifCNWqBfQJzOLmiq4nPW7rCkblW9yd+qx2ym9Mu
         wi6XzqwS6tB1JYK1pio+K2khcMy3gdBI684iCg7c=
Date:   Mon, 31 Jan 2022 14:48:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 01/35] component: Replace most references to 'master'
 with 'aggregate device'
Message-ID: <Yffov1k/TIxdDn8o@kroah.com>
References: <20220127200141.1295328-1-swboyd@chromium.org>
 <20220127200141.1295328-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127200141.1295328-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:01:07PM -0800, Stephen Boyd wrote:
> Remove most references to 'master' in the code and replace them with
> some form of 'aggregate device'. This better reflects the reality of
> what this code does, i.e. an aggregate device that represents a
> device like a GPU card once some set of devices that make up the
> aggregate device probe and register with the component framework.
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/component.c  | 242 +++++++++++++++++++-------------------
>  include/linux/component.h |  18 +--
>  2 files changed, 128 insertions(+), 132 deletions(-)

This one change is fine as-is and I will queue it up now, thanks for
doing it.

greg k-h
