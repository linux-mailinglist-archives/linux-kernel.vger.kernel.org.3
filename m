Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AE4DD9FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiCRMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94375434AE;
        Fri, 18 Mar 2022 05:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE71B82270;
        Fri, 18 Mar 2022 12:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39AC340E8;
        Fri, 18 Mar 2022 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647607985;
        bh=rTQbhPYYVJZgomybu+cN6oILoN69uaVjQZtcndr1FFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUyBeQKyk6l9YfLYfuD0D5RDqVMG+2q+g7Uoq10Rpv/IHBD5JRwda/n81wiOw6QRK
         UcA0IPIfsi5cIbvb42rjRZHCjA5ua7OiOkLrmXJx+PBnI1Epb4RBuZF9Fh9By7n48I
         OOlYGhhqlwhCnvy+SaeR+qaZqCjnSovqGHD6EzPk=
Date:   Fri, 18 Mar 2022 13:53:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ricky WU <ricky_wu@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: fix indenting in rts5228_extra_init_hw()
Message-ID: <YjSArZ10NZLsJ3vb@kroah.com>
References: <20220307141421.GC18867@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307141421.GC18867@kili>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:14:21PM +0300, Dan Carpenter wrote:
> This code should be indented one more tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Introduced in commit 86f4c65fd500 ("misc: rtsx: rts522a rts5228 rts5261
> support Runtime PM").  No Fixes tag because it's not a bug.
> 
>  drivers/misc/cardreader/rts5228.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
> index af581f4f74d1..ec97854e1f70 100644
> --- a/drivers/misc/cardreader/rts5228.c
> +++ b/drivers/misc/cardreader/rts5228.c
> @@ -491,9 +491,9 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
>  
>  	if (pcr->rtd3_en) {
>  		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
> -	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> -				FORCE_PM_CONTROL | FORCE_PM_VALUE,
> -				FORCE_PM_CONTROL | FORCE_PM_VALUE);
> +		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> +					FORCE_PM_CONTROL | FORCE_PM_VALUE,
> +					FORCE_PM_CONTROL | FORCE_PM_VALUE);
>  	} else {
>  		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
>  		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> -- 
> 2.20.1
> 

Someone beat you to it:
	https://lore.kernel.org/r/20220303020206.98911-1-yang.lee@linux.alibaba.com
