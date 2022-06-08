Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4B542CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiFHKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiFHKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287D20C27E;
        Wed,  8 Jun 2022 02:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAB41B823D3;
        Wed,  8 Jun 2022 09:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9C1C34116;
        Wed,  8 Jun 2022 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654682340;
        bh=phOVFKShi91IWVGNGLl2V7tOh4WFzXPuXh5r4jKAH90=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gCDc5dTYNLVW3yPPhSW0RiV5xwGIImPnI8w9Sb1qsiUepNsz/w118aREfqxT4wdB3
         Q2bPKM0kJUX4nSv+5fh5lzS1qtpE6G2OS9qlvXdkLjNmp/3a160pMFaBdluCunRB2x
         fiML8uvW23Mw4Szx3vte3YrFKY4eovlDZvs2+XQ1fTIO/MrPpJzaAFh7HmD7X0IcdU
         fwxJg0cjE6DRBQS3ssncyhw2vlhGTg3TlmY7ur3bqX3vPXn5Px5flCf+Z/3mJEvwog
         FkBAakR2QEX0ohYvzN1OOuZ+pe+lIfsWpWuNJ5QhVmcYdUHP13DwN/6Cl5zJdwuFve
         zHo3fCO1b9uEg==
Date:   Wed, 8 Jun 2022 11:58:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
cc:     benjamin.tissoires@redhat.com, lains@riseup.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Fix syntax errors in comments
In-Reply-To: <20220605084343.10514-1-wangxiang@cdjrlc.com>
Message-ID: <nycvar.YFH.7.76.2206081158510.10851@cbobk.fhfr.pm>
References: <20220605084343.10514-1-wangxiang@cdjrlc.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022, Xiang wangx wrote:

> Delete the redundant word 'in'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 81de88ab2ecc..68f9e9d207f4 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1694,7 +1694,7 @@ static int hidpp_battery_get_property(struct power_supply *psy,
>  			val->strval = hidpp->hid_dev->uniq;
>  			break;
>  		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -			/* hardware reports voltage in in mV. sysfs expects uV */
> +			/* hardware reports voltage in mV. sysfs expects uV */
>  			val->intval = hidpp->battery.voltage * 1000;
>  			break;
>  		case POWER_SUPPLY_PROP_CHARGE_TYPE:

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

