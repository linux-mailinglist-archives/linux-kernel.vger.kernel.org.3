Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64546D1E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhLHLUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhLHLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:20:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C5C061746;
        Wed,  8 Dec 2021 03:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34C52CE213B;
        Wed,  8 Dec 2021 11:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB56C00446;
        Wed,  8 Dec 2021 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638962195;
        bh=fhdUJaiGKm5S+ZrwA8IyQ8XLyDaFOO5ozAko2Wy4luI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQW4N2kokb7PyhKeZ9vmPeH9KK6hIZnSDzu7Ibbintlrjzpwx6TSMolbnBi8qpYpL
         c2SbLtg2r5ffHlC7yyD4lWfdIs7v0syYKJwhmxsGrAdzGDjLqUCfgQrpkHWGHjfmnm
         kbSz4DYmuW3UhLp+eRAXYQ3rT+GV9C5znVlr8sKnj2ZqGCm5G0m2jcJPIMcUaFb2A5
         JEv/YuM2yGgbyu9Aje4RA9K6SDJDXHYEuCYapUqyx+8KVS5BPKiVMNM4DKfFKuORZw
         DxpV9MFiMQgIfKwIGutRXA4G/kIpR7/8iQyoEpKAPfbapDQG0x7FLSZoYZ7yX799EJ
         3b3OoQFh3saaw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1muuw5-00AkSz-68; Wed, 08 Dec 2021 11:16:33 +0000
MIME-Version: 1.0
Date:   Wed, 08 Dec 2021 11:16:33 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wudi Wang <wangwudi@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the irqchip-fixes tree
In-Reply-To: <20211208210453.021ac89c@canb.auug.org.au>
References: <20211208210453.021ac89c@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <194af79dcd37229582e675c5b92733ca@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sfr@canb.auug.org.au, wangwudi@hisilicon.com, zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 10:04, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   d094b4332232 ("irqchip/irq-gic-v3-its.c: Force synchronisation when
> issuing INVALL")
> 
> Fixes tag
> 
>   Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git 
> v2.11
>     or later) just making sure it is not set (or set to "auto").

Well spotted. Now fixed.

         M.
-- 
Jazz is not dead. It just smells funny...
