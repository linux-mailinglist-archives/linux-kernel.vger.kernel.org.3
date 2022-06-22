Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB51E554348
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351859AbiFVG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiFVG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:56:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF655BC;
        Tue, 21 Jun 2022 23:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79901B80E07;
        Wed, 22 Jun 2022 06:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF90C34114;
        Wed, 22 Jun 2022 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655880972;
        bh=dl/V5G6SFKWVJwEQeGuEow3fYgwtjJNdISHZ5alKukk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blfspkQYzl0jl5oebc+hUEPZSNvWbrHM7jXF8a/wCtjM2ldnGgRD3aDirjEdcLpNX
         MPmaXY4yUIECPMHe3RY08YXlJN616nh9od+yvFclx3Mu9HiiP79TsJs0RXjr+tago4
         psrp6pBHtfDeqEZg5aSa9JR/OLppHm6WF6t7V6rxyBIv6Q5SOEY4xEfHb6SPJzqU+w
         GRS0w69nLjoadqP+EUzrCyzRynG/7dPTllxR3pjGW+bZLOlzsrhGudRLAY2E0ParpU
         ExYG9GS9hojsQCDq0pYh67037B+E30uB6b3QJt7N48hwcDAHzrnedW9y7ASmtpHrpW
         VWCN+/l9dyWFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3uHZ-0005LY-5R; Wed, 22 Jun 2022 08:56:09 +0200
Date:   Wed, 22 Jun 2022 08:56:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: option: add Quectel EM05-G modem
Message-ID: <YrK9CcvsQpz2Qaz9@hovoldconsulting.com>
References: <MEYP282MB23748DE15DA9B962E7A2E7A7FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB23748DE15DA9B962E7A2E7A7FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:37:53PM +0800, Yonglin Tan wrote:
> The EM05-G modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "RMNET"	: AT + DIAG + NMEA + Modem + QMI
> "MBIM"	: MBIM + AT + DIAG + NMEA + Modem
> 
> The detailed description of the USB configuration for each mode as follows:

> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
> ---
> V2:
>   1. Add the description of the usb interface configurations.
>   2. Add QMI Interface description.
> 
> V3:
>   1. Move the entry to where the other Quectel entries with numerical PIDs are.
>   2. Define the macro and remove the comment.
> V4:
>   1. Remove a blank space at the end of the new entry.
>   2. Change the permission bit of the source file.

Now applied, thanks.

Johan
