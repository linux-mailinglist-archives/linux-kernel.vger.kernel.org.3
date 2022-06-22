Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5755435F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351999AbiFVG67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352003AbiFVG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115C36689;
        Tue, 21 Jun 2022 23:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F78BB81C5F;
        Wed, 22 Jun 2022 06:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57721C34114;
        Wed, 22 Jun 2022 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655881107;
        bh=yq7veC2Reg7jzXdI8hgrIoO435aeJmXk5Hzvc2Ci5Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DB9G13ZJy4dwfAw3w+Et/TS6R20KTDciEwB4sWGEzBnXgsqg29nGQD5FAYnGlWwN7
         iz/K3QWvibdbzd/L9doZXZ51rYAotczCAPU8wTFkaclyx/DPaUhLsQegcHF8p25/mt
         MAk/TSNfi03wa8H7zGLvVMoHm1w5nwxXyI4TIZolYKao48GumM8UWLV0RPoYftwCmr
         YMJXwB6n5Gc66KG/EdpP+g2JMkv7mnd+Iil/XCa/GV+oqPJGBezsjaphLHgHWLVRyg
         CUGvXuHcCRqd3QK1qug192ZS6iFjGegMqFjIVkeDpy0+PTeVbcZFrAbVCrTIrPGs2Y
         SFTwc6xCqEgRQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3uJk-0007GC-9K; Wed, 22 Jun 2022 08:58:24 +0200
Date:   Wed, 22 Jun 2022 08:58:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: use kmemdup instead of kmalloc + memcpy
Message-ID: <YrK9kKawH06f9T4h@hovoldconsulting.com>
References: <20220622062113.8762-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622062113.8762-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:21:13PM +0800, Slark Xiao wrote:
> For code neat purpose, we can use kmemdup to replace
> kmalloc + memcpy.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add garmin_gps.c
> ---
>  drivers/usb/serial/garmin_gps.c | 4 +---
>  drivers/usb/serial/opticon.c    | 4 +---
>  drivers/usb/serial/sierra.c     | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)

Applied for -next, thanks.

Johan
