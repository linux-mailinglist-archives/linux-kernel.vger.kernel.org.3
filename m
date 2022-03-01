Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC04C977E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiCAVFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiCAVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:05:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676680903;
        Tue,  1 Mar 2022 13:05:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BEF0B81A32;
        Tue,  1 Mar 2022 21:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D72C340EF;
        Tue,  1 Mar 2022 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646168700;
        bh=+giOaAjXTXHBc6Q8z1vDjngTHJyi+4Yw/zEpOyQGKRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jlt84sel6Mj+tBBej8jK6EJrrkyMaV7/S20YoDwiMJjV54mMzUuhWnofEa1BEw040
         AlVsMiugsy/KqZMH56Mbq4Trg7w3W1LFcQTgMNt0os0dUmDxDcitOhWNTpnNQWg5XJ
         c1T6ddAKzJEauBhdZRdxo3T/wdPJG7tMvN3P7J2c=
Date:   Tue, 1 Mar 2022 22:04:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V7 3/6] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Message-ID: <Yh6KedQgtLYkuG7k@kroah.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <20220225073922.3947-4-yu.tu@amlogic.com>
 <CGME20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f@eucas1p1.samsung.com>
 <180d7038-4ae2-80d4-0760-4be24ec11836@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180d7038-4ae2-80d4-0760-4be24ec11836@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:17:53PM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 25.02.2022 08:39, Yu Tu wrote:
> > Using the common Clock code to describe the UART baud rate clock
> > makes it easier for the UART driver to be compatible with the
> > baud rate requirements of the UART IP on different meson chips.
> >
> > Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> 
> This patch landed recently in linux next-20220228 as commit 44023b8e1f14 
> ("tty: serial: meson: Describes the calculation of the UART baud rate 
> clock using a clock frame"). It causes kernel crash on my Amlogic based 
> test boards: Odroid C4/N2 and Khadas VIM3:

Ok, this series is causing lots of problems, I'm just going to revert
the whole thing from my tree, thanks for letting me know.

greg k-h
