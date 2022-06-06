Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A453E0C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiFFFxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFFFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55764F4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1455760F95
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC5DC385A9;
        Mon,  6 Jun 2022 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494785;
        bh=dQNfnKYOLlIfCF+niI0syigSL7bjO0G2DVTxEbIA84A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGF3yFXR0ZaDwDTJIkeCNOQ3JkZguJj03r49JcZG3SnMQ2cH2ezKYkCBIkNok0a20
         FDK/5ibDuSmvjTd3GwTHeg+AY6umshkZOgoGvER3rT6wn8R5lPOx2Cnqj4PjUQS7Y1
         xchBbmL8vDGzFjjdtCKQDeiJql4un+J9hWQxAH0w=
Date:   Mon, 6 Jun 2022 07:53:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: r8188eu: Fix kernel-doc
Message-ID: <Yp2WPrOz85/70CZx@kroah.com>
References: <20220524083914.68736-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524083914.68736-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:39:14PM +0800, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
> 
> drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:291: warning: expecting
> prototype for Function(). Prototype was for rtl8188e_PHY_SetRFReg()
> instead.
> 
> drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:257: warning: expecting
> prototype for Function(). Prototype was for rtl8188e_PHY_QueryRFReg()
> instead.

Please put build warning lines all on one line.

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

No, gcc reported this, not a robot, right?

You have read Documentation/process/researcher-guidelines.rst for how to
properly document patches that are created by research tools like this,
right?  Please fix this commit up to follow those requirements please.

thanks,

greg k-h
