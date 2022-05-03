Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C25183FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiECMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiECMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032D32EF2;
        Tue,  3 May 2022 05:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16A16167E;
        Tue,  3 May 2022 12:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38705C385A9;
        Tue,  3 May 2022 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651579969;
        bh=vgFAild2JjYBiqVdCQwJNRs0RnamlbN2uPUvKKoc4mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tF5zz26H1yJkYXDAQc03mXv/lf0vh1XwDTbX82pjT8iQon2IteOZSzMv0v1gwin+0
         BoiIH8TZoPvouEI8I6vDY1Qvxz1IpTvCbiX3SvWlszJ2LWCTLRb2H2O4FB1Aio6aDY
         GdFSpRZQDmmU5NvGQvgG4scB/bruuOahC37yuZCU=
Date:   Tue, 3 May 2022 14:12:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] firmware_loader: describe 'module' parameter of
 firmware_upload_register()
Message-ID: <YnEcQMZPDGjuOQUh@kroah.com>
References: <20220502051456.30741-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502051456.30741-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 12:14:56PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reported kernel-doc warning:
> 
> drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function parameter or member 'module' not described in 'firmware_upload_register'
> 
> Fix the warning by describing the 'module' parameter.
> 
> Fixes: 97730bbb242cde ("firmware_loader: Add firmware-upload support")
> Link: https://lore.kernel.org/linux-next/20220502083658.266d55f8@canb.auug.org.au/
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

This should be "Reported-by:"  I'll fix it up when I apply it to my tree
now, thanks.

greg k-h
