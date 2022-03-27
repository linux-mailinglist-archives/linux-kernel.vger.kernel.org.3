Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE54E872C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiC0JzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiC0JzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 05:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287F237EA;
        Sun, 27 Mar 2022 02:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFD4AB80CD3;
        Sun, 27 Mar 2022 09:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8A2C340ED;
        Sun, 27 Mar 2022 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648374810;
        bh=D7TKBftNVHudjnzZ+Q7TCFeuZbIcquHLJpJS6N4E214=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVChqrcH7xDQAa8ncRkjfEc1I1xto15L4LLovNfkTz709jkscQKQMO5yne9aWHNJT
         gsX0kKYvbhzwcWRG8R2dAurPCo8fVna1lGircUZz7+klIOBFA0ZRWs4scrXSdme1ao
         hrzpSm3F8gZGKKiSC0W74c05ccBuMfJj0eBZZ2dQ=
Date:   Sun, 27 Mar 2022 11:52:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kushagra765@outlook.com
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / dwc3: Fix three doc-build warnings
Message-ID: <YkAzwtC4Eua92Uag@kroah.com>
References: <SI2PR01MB3929034AEEE996FA164D94E9F81C9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB3929034AEEE996FA164D94E9F81C9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 03:05:05PM +0530, kushagra765@outlook.com wrote:
> Two kerneldoc comments in gadget.c have excess function parameter description or wrong
> prototype name and one kerneldoc comment in core.c has a excess function parameter
> description, resulting in these three doc-build warnings:
> 
>    1. ./drivers/usb/dwc3/gadget.c:675: warning: Excess function parameter
>         'nfifos' description in 'dwc3_gadget_calc_tx_fifo_size'
>    2. ./drivers/usb/dwc3/gadget.c:700: warning: expecting prototype for
>         dwc3_gadget_clear_tx_fifo_size(). Prototype was for dwc3_gadget_clear_tx_fifos()
>         instead
>    3. ./drivers/usb/dwc3/core.c:347: warning: Excess function parameter 'ref_clk_per'
>         description in 'dwc3_ref_clk_period'
> 
> Fix the warnings by correcting the prototype name and removing excess parameter descriptions.
> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>

Your "From:" name in your email does not match this name :(

Please fix up and resend.

thanks,

greg k-h
