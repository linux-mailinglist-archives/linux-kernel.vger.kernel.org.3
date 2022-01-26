Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9349CBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiAZNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiAZNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:55:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59D1C06161C;
        Wed, 26 Jan 2022 05:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A5161627;
        Wed, 26 Jan 2022 13:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E059C340E3;
        Wed, 26 Jan 2022 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643205347;
        bh=LAuNU5ssQredBFelvvNEobJPcYhRCIFpQ4iH33wFVIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YagHbYyb7r1UqfH/zTNGaitQFkLquxhyISN8PtPrUKimNDuxhPf2pUcvb8enhwZ4
         RHFPJS6sasxM112/eEARbxjEMOXp+Qxj/HnTp/GSGf4E54picq/7DNieCr0bKYzmls
         dPMJAuEs4aZ5reTW4dZDADf36BS8bMS9to9YFjNU=
Date:   Wed, 26 Jan 2022 14:55:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
Message-ID: <YfFS4IHuLguZIl3T@kroah.com>
References: <20220124071430.14907-11-jslaby@suse.cz>
 <202201242255.WTSwb6EN-lkp@intel.com>
 <bf35dee8-4f0c-a91e-de89-0c39c749a650@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf35dee8-4f0c-a91e-de89-0c39c749a650@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:26:48AM +0100, Jiri Slaby wrote:
> On 24. 01. 22, 15:30, kernel test robot wrote:
> > Hi Jiri,
> > 
> > I love your patch! Yet something to improve:
> 
> Please skip this patch. I wonder why the bot didn't catch it in my queue
> already.

Now skipped.  Thanks for all of the other patches, now queued up.

greg k-h

