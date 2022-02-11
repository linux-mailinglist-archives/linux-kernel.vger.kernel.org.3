Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340974B294E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiBKPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:45:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiBKPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:45:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BA21F;
        Fri, 11 Feb 2022 07:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8130CB82A9B;
        Fri, 11 Feb 2022 15:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DAAC340E9;
        Fri, 11 Feb 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644594300;
        bh=Cwb25r5eUpmN7pzfNiEaMUwwtBbCYaIlJyD33yZRuSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnUQr0fJQmRQuPfjzWiutxYQ/GwR+5oG+DKxscGILSPm8ewRr421M8pGgTImtxlMQ
         mN4Y1xhZh8+ydS7KH0p0lwcag1uqzn3EeHmzodBV93yhEu0S+vKTf/kG6knj8u/H2R
         Vx03SSla3Urnp7cQa0gQt6wmNCkmBiLuAJWmgfvI=
Date:   Fri, 11 Feb 2022 16:44:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.17-rc4
Message-ID: <YgaEcWf7fCkrt3l4@kroah.com>
References: <YgZ/dFV1smMu64Bi@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgZ/dFV1smMu64Bi@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 04:23:32PM +0100, Johan Hovold wrote:
> The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:
> 
>   Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.17-rc4

Pulled and pushed out, thanks.

greg k-h
