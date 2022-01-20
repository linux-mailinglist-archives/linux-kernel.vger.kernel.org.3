Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770E8494D75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiATLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiATLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:55:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5DFC061574;
        Thu, 20 Jan 2022 03:55:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 298C6B81D51;
        Thu, 20 Jan 2022 11:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E219C340E0;
        Thu, 20 Jan 2022 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642679730;
        bh=WkGYZjENAbz9hyBfyC7E49YSl4obUSaWGBKnCJbSOGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBCNVObbSDYfRMer/fxwcQXHaQctGP3gArGHrOR36vlsxodwS/ghlLErpM77pBYbD
         eumVgCBp7xYbIocm3xhcsNzGs8ls5GvioBKfoBWk4HmbvLjY1/opi2yosLbHiNEY4e
         Zk41fsQvTRs4u0M0wXeByCiigKzhLPL+D0elSYuQ=
Date:   Thu, 20 Jan 2022 12:55:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YelNrzuYajCZ7agG@kroah.com>
References: <20220120093615.2026590-1-xji@analogixsemi.com>
 <20220120093615.2026590-2-xji@analogixsemi.com>
 <YekyOVAjI0EE7VYz@kroah.com>
 <20220120103137.GA2026944@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120103137.GA2026944@anxtwsw-Precision-3640-Tower>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:31:37PM +0800, Xin Ji wrote:
> On Thu, Jan 20, 2022 at 10:58:17AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 20, 2022 at 05:36:15PM +0800, Xin Ji wrote:
> > > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The test robot did not report this to ask for a new driver :(
> Hi Greg, test robot ask me to fix the compile warning issue,
> https://patchwork.kernel.org/project/linux-usb/patch/20220119110141.1020452-2-xji@analogixsemi.com/
> so I think need upstream v2 after fixed the issue. I'll remove the test
> robot tag in the next serial.
> 
> BTW, your robot ask me to add more log at commit message, do I need
> upstream v3 after do that?

Of course, I can't take this as-is.

thanks,

greg k-h
