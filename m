Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56FA4C2D99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiBXNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiBXNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:52:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E281375BE;
        Thu, 24 Feb 2022 05:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA73B825DB;
        Thu, 24 Feb 2022 13:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8639C340E9;
        Thu, 24 Feb 2022 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645710741;
        bh=oHv30ZS2rt6I6ccFclpTy5DuQs8S+cRcG19oZA5sRAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6Sesqwim1+HnFtDpUDRRLSX1zsdK+JMAeddrsmC6DFuHNn/8HMnBmrcYmd7Ho/zW
         a2+EBiEFhEtq2NvLF0Qs5JgiFgzweC0xRZQJOvARLtyNOyiXbnvL0oJKks1uqDT4aG
         9tCjxWeMs4HNDigmy83K9j1zxubI2kR2jX2R6ZNM=
Date:   Thu, 24 Feb 2022 14:52:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.17-rc6
Message-ID: <YheNi/To6/6nZjya@kroah.com>
References: <Yhd/L2uKGvBbuQUS@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhd/L2uKGvBbuQUS@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 01:50:55PM +0100, Johan Hovold wrote:
> The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:
> 
>   Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.17-rc6

Pulled and pushed out, thanks.

greg k-h
