Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7C4787DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhLQJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLQJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:37:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AF4C061574;
        Fri, 17 Dec 2021 01:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8192EB8276B;
        Fri, 17 Dec 2021 09:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B272BC36AE1;
        Fri, 17 Dec 2021 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639733849;
        bh=6r8T2sdyzJGwgUQDwahngIXT9lHmmrrGeY5d3v0Z6Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnMVDVWcrkBB1bELWT9aba6SQckUMX9p1SBB6dGzE/ZCbRH7r5keISb5fMhqhZumo
         DMkv4pf4xqttz/RdMYKVQHz7EM+eDzi5I3AWH2wzK890iWwLkTKhOSY5Upf61S98II
         r4kxhtCBg72HQ08VrgjSaRkoiaNsEXwPDMk/m7gg=
Date:   Fri, 17 Dec 2021 10:37:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.16-rc6
Message-ID: <YbxaVBsKCgA0a26o@kroah.com>
References: <YbxX3akVsGBNa+KH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbxX3akVsGBNa+KH@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:26:53AM +0100, Johan Hovold wrote:
> The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:
> 
>   Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc6

Pulled and pushed out, thanks.

greg k-h
