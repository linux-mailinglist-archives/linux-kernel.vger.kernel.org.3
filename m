Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD04C7BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiB1VXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiB1VXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:23:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76F38BC2;
        Mon, 28 Feb 2022 13:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A03B81674;
        Mon, 28 Feb 2022 21:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77792C340F1;
        Mon, 28 Feb 2022 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646083370;
        bh=tb2aIw9Bk+OfDUZ8YaWhmfxIxuM92KdPR56wkPBsvsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdcFSOxpLoF8NXjbhXbxwfujjSxgRuvZMDBnNuRO5mRQK65qplNufblSQ4EkU5f3f
         4o51om4pGE+VIfO1W7yN7D2twnlCsaSlFxabKdvbgA3aiU9/HCGtNNT7ceOSdqEs1N
         TSyN7btlGjzISAn5trz6m64c0y82iNjghJxb6qG0=
Date:   Mon, 28 Feb 2022 22:22:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Message-ID: <Yh09JjLDuqoTFCbX@kroah.com>
References: <20220228090351.9976-1-yu.tu@amlogic.com>
 <790952bd-b066-0b41-545c-1f65cd4244af@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790952bd-b066-0b41-545c-1f65cd4244af@baylibre.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:52:15AM +0100, Neil Armstrong wrote:
> i,
> 
> On 28/02/2022 10:03, Yu Tu wrote:
> > Describes the calculation of the UART baud rate clock using a clock
> > frame. Forgot to add in Kconfig kernel test Robot compilation error
> > due to COMMON_CLK dependency.
> > 
> > Fixes: 44023b8e1f14 ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
> 
> AFAIK this commit is not in an uptream/feature branch, so you should simply fix your `Use CCF to describe the UART baud rate clock` instead.

This commit is in my tree and in linux-next, it is correctly listed
here.

thanks,

greg k-h
