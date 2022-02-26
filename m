Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D34C56D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiBZQcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiBZQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:32:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C824DEE5;
        Sat, 26 Feb 2022 08:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C55A60BBD;
        Sat, 26 Feb 2022 16:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC156C340E8;
        Sat, 26 Feb 2022 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645893135;
        bh=JIVnVPR5itRuwZnH80P4NOCj7Kr4fqQ4kQyZO3sUUcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nf1uZWprEJ7KLB82ozSwEVAxVikYZ3hxO98I0/viiUNo8+zbh0YSiBehdDNvj1F3S
         tgducp9CeMSRoLxc/RK+0XV1yOdzMNkBGaJ0/+NWSTCB10ttlGBLYJbk8AjWnGTrMv
         lbfsl6Bg3Q0Xiu2ISOoM0THdR4RtDluE81HwVd51iJTan1fmR+uyqgl1G2ZkMED6BV
         IJ782tiOPHHMWN/D9tTAPRP4TIbjqIswWjtfe4h/bcDSPgL1fNK29+u6kS/cMj9QuC
         pydIbNg1LPLFwQItVlrxp3K4E2R+wWDGvDObYIRdS+87R6Xtaqk8nf894ubmhuKBHW
         5ra+dBGO2YnQw==
Date:   Sat, 26 Feb 2022 16:39:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Message-ID: <20220226163916.39b9421f@jic23-huawei>
In-Reply-To: <Yf7COufm4GG7VkJu@smile.fi.intel.com>
References: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
        <20220205173854.14a7aca0@jic23-huawei>
        <Yf7COufm4GG7VkJu@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2022 20:30:18 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 05, 2022 at 05:38:54PM +0000, Jonathan Cameron wrote:
> > On Wed,  2 Feb 2022 22:44:27 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Looks good to me, but as it's complex I'd like Peter + anyone else interested
> > to have a bit more time to take a look before I apply this one.  
> 
> Sure, I would love to see more eyes and hear comments!
> 

Peter, do you have time to take a look at this one?
No problem if you are too busy, I'll just take another look myself and apply
it if I think it looks fine.

Thanks,

Jonathan
