Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F347748AA66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiAKJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiAKJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA18C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BD66153D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4361AC36AE3;
        Tue, 11 Jan 2022 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641893030;
        bh=6t6YCClSTT9r0sfBfii3AuO/rHG3R0rHeIdA3jKtDH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNNzye0VkLoBDDLVT5tc2kfw5pFbYQHpQvykk3g5FnXwU8sBrhw5ENFVlKskfRRFU
         +IrOlI1mV2rD4zJwahY8Y7seWfnyy4RtEmYdYafGY4XAK0mvmEgmCIzv+pMys3yl9A
         BvWCme+uGDY1jz3AtuFJX1qlroI198VTywbERQYc=
Date:   Tue, 11 Jan 2022 10:23:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 5.17-rc1
Message-ID: <Yd1Mo+L95lTdfEhB@kroah.com>
References: <YdxKNTuKaZK0m9nl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxKNTuKaZK0m9nl@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:01:09PM +0100, Johan Hovold wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.17-rc1

Pulled and pushed out, thanks.

greg k-h
