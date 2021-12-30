Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC96481C50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhL3NBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:01:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42758 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3NBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:01:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D994CE1B95
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02810C36AEC;
        Thu, 30 Dec 2021 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640869292;
        bh=E1MbTScvRc7zvYlmlYeaap8QnkLEIV7binYcs3OWE1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwW4crkg42yBHgfPsrxJicdJQPqprM7hbAiNTeVW2J0ia1HxPaqHCOpCPmH0Oo8tK
         7ZNifsJRWZBbsB44QEjCantYBQQ5XiZjeMQJkk2/VVoh/PnQpjqbBZQ1BPXcVJm8uA
         DqyCtlZS0+lL/aAwOj5Rr1VQtElVZUHOrb6cMWps=
Date:   Thu, 30 Dec 2021 14:01:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.17-rc1
Message-ID: <Yc2tqVbWJC8apccB@kroah.com>
References: <Yc2RmBlAhj5DWjRZ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2RmBlAhj5DWjRZ@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 04:31:44PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the last soundwire pull for this year :). Please pull to receive
> a single patch for Qualcomm driver
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.17-rc1

Pulled and pushed out, thanks.

greg k-h
