Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6E592C42
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiHOIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiHOIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E61EC45;
        Mon, 15 Aug 2022 01:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBB060F04;
        Mon, 15 Aug 2022 08:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07DBC433C1;
        Mon, 15 Aug 2022 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660550944;
        bh=x9/M2mX9vnyTHUrrswpTyVgnP3xkk9B9vMLWt4rKHIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNeIjLUKy9E0m8Zt69cGB/MtPTXssQr+AgOX1pExgDw9ykEjwwspZ4jVWJYHc1lop
         UpF2TJzQc+disxH03h/TSm+a5mRr7v8C5mUU6K5N6lrcPwcVd3g5KwWkjakrt+xiHY
         XHWPIAexSc0qG2+oo8JNsOB0WvtNp6wCQaglY6tY=
Date:   Mon, 15 Aug 2022 10:09:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "J.D. Yue" <jindong.yue@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: adjust
 SERIAL_FSL_LPUART_CONSOLE config dependency
Message-ID: <Yvn/HEbnE9ALCoKm@kroah.com>
References: <20220802101613.30879-1-sherry.sun@nxp.com>
 <AS8PR04MB8404508CDE3446CDF690107092689@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404508CDE3446CDF690107092689@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Aug 15, 2022 at 08:03:55AM +0000, Sherry Sun wrote:
> Gentle ping...

The merge window closed just a few hours ago, and I have over 1500+
patches to now review in my queue.  Please relax, there is no rush here.

To make things easier for me, please take the time to review other
serial patches that were submitted during this time on the list so as to
make my load lighter.  Otherwise you are asking others to do tasks you
don't even want to do, and I do not think you mean to do that.

thanks,

greg k-h
