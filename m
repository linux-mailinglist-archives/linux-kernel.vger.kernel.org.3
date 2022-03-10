Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11F4D53F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbiCJVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiCJVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:54:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2FA9942
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:53:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3017FB80CB3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F59C340E8;
        Thu, 10 Mar 2022 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646949196;
        bh=ELDMz4ZJxMMGxscYfx34KKaOhnj2XGHJKkEOFAkp6JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7GxiRBjKwzXfujEBnnTkfhs5eDX3moRl3BTfNw1KfdnaRxeoUs9gB89QwhS3S6/C
         RWWQMTwenRiDdDFUByvSwKZMBIhd4fz2mXgVoRcMPcn8eUzOS5Ary/qTKleAkb71Xh
         l2PYM/LGtF2LhMDiAoR0qbocsd9vNthFyiFNPjEk=
Date:   Thu, 10 Mar 2022 22:52:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] Generic phy updates for v5.18-rc1
Message-ID: <YipzBhbHRbcwlWzt@kroah.com>
References: <YiJM/aHDOqqcvimp@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiJM/aHDOqqcvimp@matsya>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:01:41PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive the Generic phy updates for v5.18. Bunch of new
> device support and updates to few existing drivers.
> 
> The pull is based on fixes tag you had merged earlier. I had merged
> that into next for resolving dependencies between next & fixes.
> 
> The following changes since commit 9a8406ba1a9a2965c27e0db1d7753471d12ee9ff:
> 
>   phy: dphy: Correct clk_pre parameter (2022-02-02 10:33:04 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.18

Pulled and pushed out, thanks.

greg k-h
