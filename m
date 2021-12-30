Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F606481C54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhL3NDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3NDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:03:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7305C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CDDA4CE1BF4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C6AC36AEA;
        Thu, 30 Dec 2021 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640869420;
        bh=jvoJiCrpybBHSirhemDwLWE6AVj7Q98gYoxNdt5jj4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXvLM9SHUE9scKq7xK6FTG0HArvcHAyknmHh8GVTH9Od69X8RMy/F/19DMtJUeert
         5HJRn3oC7zpEXP08A9S2Zu8JqFwX2l2mzccG31AE/O9TjNOhxwtEEGVVVJb00XIkBK
         rsRm/dq0BFTiK+LTFr7YCIgV2SJlk+5jh1Dtm4+M=
Date:   Thu, 30 Dec 2021 14:02:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] Generic phy updates for v5.17-rc1
Message-ID: <Yc2t9dV0JF2RDcHe@kroah.com>
References: <Yc2e40P2pQrCl1Gn@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2e40P2pQrCl1Gn@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 05:28:27PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive Generic phy updates which includes a bunch of new
> driver and new device support.
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.17

Pulled and pushed out, thanks.

greg k-h
