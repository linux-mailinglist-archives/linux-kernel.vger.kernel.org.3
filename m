Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAD481BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhL3LLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3LLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:11:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40ECC061574;
        Thu, 30 Dec 2021 03:11:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9284CB80B3A;
        Thu, 30 Dec 2021 11:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C52C36AEA;
        Thu, 30 Dec 2021 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640862673;
        bh=kBwUDpy6z1zSj0ft3UeCPbW98secaFdJlM9Xmg7Mxo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UV/e05WiGbOfiYeCR5AJBtXa+b69LjIlAPVsuSCLymdCirqGQi5jJBkq6TsDdlcVW
         4/dYA5EKNr5NBtYryeGOweI66KlVkM/L0S3dALPHwg7z9j0LHCpBV1PIpoQ35zWRyj
         XxyuGbHv/ogQdyjtgPjOFVP3QjyucUtcw4pRbskw=
Date:   Thu, 30 Dec 2021 12:11:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] acpi: Store _PLD information and convert users
Message-ID: <Yc2Tzs1wRGtxZBOg@kroah.com>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jHQmNGsOu9TQhUJD3uoc6XijZwRD1K4GfV_KoD=Q79WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jHQmNGsOu9TQhUJD3uoc6XijZwRD1K4GfV_KoD=Q79WA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:18:16PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 23, 2021 at 9:16 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > The last version (v4) was not properly cleaned up. Should be now OK.
> 
> It looks good to me, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the ACPI-related changes in this series and please feel free to
> route it through the USB tree if that's preferred.

Thanks, I'll take this through the USB tree now.

greg k-h
