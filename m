Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA951CC27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386378AbiEEWiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386356AbiEEWiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCD6004D;
        Thu,  5 May 2022 15:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B5E61E53;
        Thu,  5 May 2022 22:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5974AC385A4;
        Thu,  5 May 2022 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790066;
        bh=Fjpze9p+LviKLUP0aU8SZtUfet1POQ58RsbqdrFG4aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwneceNDSaXq0hOFu7m5dCZ1neE5qHMCBgJzH3zC53YNIaSFbDNDny3OnGfu2GNJg
         XQanp2o4W4s0eA6VsGWPNCgBGEmW9HZo1YKXAoWwYvsJL2lfK441u05n2CtAU30dMk
         nVi/vU5qjS8pFdXl687zzS49PRYxHKyxY4WJA8EE=
Date:   Thu, 5 May 2022 22:48:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
Message-ID: <YnQ4Ngu8xt7DBi5C@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:15PM +0530, Shubhrajyoti Datta wrote:
> Many of the stuff is reported by static analysis
> changes are 
> 
> - Update the copyright text
> - Check the return valuesof runtime and clock enable calls
> - Check the ignore_status in the isr 
> - Prevent writing to the fifo when controller is disabled.
> 
> Michal Simek (1):
>   xilinx: Update copyright text to correct format
> 
> Shubhrajyoti Datta (6):
>   tty: xilinx_uartps: Check the clk_enable return value
>   tty: xilinx_uartps: Add check for runtime_get_sync calls
>   tty: xilinx_uartps: Check clk_enable return type
>   tty: xilinx_uartps: Make the timeout unsigned
>   serial: uartps: Fix the ignore_status
>   serial: uartps: Prevent writes when the controller is disabled

Nit, why is the subject line prefix not unified here?  Shouldn't they
all be "tty: xilinx_uartps:" like 4 of them are?

Can you fix up and resend?

thanks,

greg k-h
