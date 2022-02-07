Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F814AC435
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384289AbiBGPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356394AbiBGPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:35:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF6C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:35:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB278614C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02D3C004E1;
        Mon,  7 Feb 2022 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644248126;
        bh=RlZxHDSYVKyQncJwTIykFVnR5jwQ6UzMj/JHf8Eo/bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3jqawIUx5viDQOdm7EVqhElNHyY1g5h21E/5MFhitMjLvBez3KVFmeMwm9+NYpju
         nwtCDTwQDfha+Lsn1GYjxzpr7k4VQhzk9ZqyVyCtlBoufhHXLo5AaVEivAWZXxPNSU
         1PbB13HbuVrLgulM1Hf4ijucyjWYI7RnCcNROy68=
Date:   Mon, 7 Feb 2022 16:35:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Kumar Pandey <itsankitkp@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes styleguide related issues in tty drivers
Message-ID: <YgE8O1Y7xJTRCCtW@kroah.com>
References: <YgE3wNira6AmpHab@ankit-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgE3wNira6AmpHab@ankit-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:46:16PM +0530, Ankit Kumar Pandey wrote:
> Various styleguide warnings are raised in drivers/tty. This patch aims
> to fix those and bring styleguide warning to zero.
> Signed-off-by: Ankit Kumar Pandey <itsankitkp@gmail.com>
> ---
>  drivers/tty/ehv_bytechan.c | 5 +++--
>  drivers/tty/goldfish.c     | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)

Please practice on stuff like this in the drivers/staging/ portion of
the kernel, as that is what it is there for, and you do not disrupt the
workflows of the other kernel developers by touching files like this in
in correct ways.

good luck!

greg k-h
