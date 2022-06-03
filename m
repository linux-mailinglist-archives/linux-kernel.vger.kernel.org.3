Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA953C51D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiFCGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbiFCGlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986738787
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80EF5617A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1631AC385A9;
        Fri,  3 Jun 2022 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654238467;
        bh=OB90MVUtsU5iTehD6WsjKX8mEH92WGNxAwz97OfCibA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4HpNCN6yEwYk4PfFYBdNdhPZO36kikI4aJM/jkRAJuPK3RSyH9jnBSAd4ZHEHqYh
         CFLiMEQFRMl1ZwmqQc+xWlRvyAhiqbIL6tEWR5W+mYic9BSdaqIC7ZrJK6rtoWNCa7
         8ZvN6s55NonpTvW7zwrIHnszZPdZoL6sJP1VlpeQ=
Date:   Fri, 3 Jun 2022 08:41:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH 0/2] New driver for Intel(Altera) FPGA System ID softIP
Message-ID: <YpmtAtIx994hnpP2@kroah.com>
References: <20220602122008.3021030-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602122008.3021030-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:20:09PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Hi,
> Patches have been internally reviewed by colleagues at Intel.

But you did not send them as a series, or as a v2, or send out patch
1/2?

Please take a look at the kernel documentation for how to do this all
properly.

thanks,

greg k-h
