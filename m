Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294B4AA833
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiBEKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:53:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36470 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiBEKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFD63B80688
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 10:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB0FC340E8;
        Sat,  5 Feb 2022 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644058421;
        bh=Bs3PE2C2PmOqVsXMufBkS2BmmK5Kdzd1Zcv7lGl18Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyxOhvJ1j3ks+usCZ4ITWDUT4xyN2rUR0B5QEuIghXP9hf1j4cYsR4H85Ziecmdxu
         UkK70EYBzthqgjDBrqa14XfbiC0L1f3TOGE+USHJn/qni7+KqWFstT8r5iOaDH2a73
         QzKJv4yZGFQEfJZDfllVn/POXFRMDbdG+LABQWLc=
Date:   Sat, 5 Feb 2022 11:53:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy fixes for v5.17
Message-ID: <Yf5XI5yvRrYVLVDc@kroah.com>
References: <Yf1YqcqUmResNevN@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf1YqcqUmResNevN@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:17:37PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to recieve the fixes for v5.17 for Generic phy subsystem.
> 
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.17

Pulled and pushed out, thanks.

greg k-h
