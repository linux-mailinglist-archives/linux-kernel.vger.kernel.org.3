Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0DD52F3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353222AbiETTbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiETTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:31:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5D1912E4;
        Fri, 20 May 2022 12:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58CC3B82DBE;
        Fri, 20 May 2022 19:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F6C385AA;
        Fri, 20 May 2022 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653075104;
        bh=YaIDiCWlOXtRnsQVw55wq+n7dKsB1zYc/A2yaxKR4ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV0Aan+lSFEc0f+E9EuD22ZG0U1CPIbK5KIJt9vqbSOk3w1L5iTO6nhJzk7eLzivz
         Io799aeZxcMXRB1I7eXu09SuMONoieLAJWIfCPbMmnte1S8yQgLY/LDNNLGdxxQIfs
         F50e28zhy7DpW0PSAlZDkqVWgurdjwflYYvOPPEw=
Date:   Fri, 20 May 2022 21:15:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.19-rc1
Message-ID: <Yofo6iHErGpKmOWM@kroah.com>
References: <YoeFosQDeA5fQqCw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoeFosQDeA5fQqCw@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:12:18PM +0200, Johan Hovold wrote:
> The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:
> 
>   Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc1

Pulled and pushed out, thanks.

greg k-h
