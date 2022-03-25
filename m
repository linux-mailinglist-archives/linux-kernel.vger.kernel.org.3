Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C64E6E12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbiCYGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiCYGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16AFE5;
        Thu, 24 Mar 2022 23:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A0DE61793;
        Fri, 25 Mar 2022 06:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FA2C340EE;
        Fri, 25 Mar 2022 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648188189;
        bh=uMslnPIEGizFw14Eq8iNuDrCriB8IrxjffzF+WIa8is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOYdcXlZ7nCpw+DWJjUopLj7ft9STepJ0Xwp4XjbnXoRZp/hXbhjuIJUMxdnnKcre
         oF6PkxFnF3vbH4baikPqa0PTPuB6pvK4Ly2KLGFLRRywAh6narv7j9JjAJGsBoF24V
         c9KyVHaRG71KL9yhDkdq03ShICLyPx+BXOVCNb0s=
Date:   Fri, 25 Mar 2022 07:03:07 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Message-ID: <Yj1bG57vfmem4EVT@kroah.com>
References: <20220321112211.8895-1-sherry.sun@nxp.com>
 <AS8PR04MB84041B39303666AA30E90DD7921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB84041B39303666AA30E90DD7921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:27:05AM +0000, Sherry Sun wrote:
> Gentle ping...

It is the middle of the merge window.  I can't do anything with new
changes until after 5.18-rc1 is out.  Please wait until then.

In the meantime, please help out by reviewing other pending patches from
the mailing list.

thanks!

greg k-h
