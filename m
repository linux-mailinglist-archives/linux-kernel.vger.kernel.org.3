Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780A55470A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354548AbiFVJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiFVJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:31:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFDE3818C;
        Wed, 22 Jun 2022 02:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4ED0B81D0D;
        Wed, 22 Jun 2022 09:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C68C34114;
        Wed, 22 Jun 2022 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655890295;
        bh=gJbuu5vGqf2XP7XCLsrycKuNkuUFjX1GzTZr69JaEoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFdMtxT5pZTfDp986/Ykn52jVqW0sZEsqs8kDbbNmUrjdFAygHBrfSPh2TuPgD1AT
         AU+6o3Ym5R6wBEVafFGzv9gjJ+/g0seDNUEVBuWQ3+dbsy5PWloCUqTOGLfGDyZtky
         XUTpBb8Rsh6UEHiqgvr3nFLREtXkEFe9p8pLF/Vw=
Date:   Wed, 22 Jun 2022 11:31:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Bujdoso <artur.bujdoso@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon-usb: move driver out of staging
Message-ID: <YrLhdFdHssZg+Va5@kroah.com>
References: <Yo0HBIlSXOBM+//9@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0HBIlSXOBM+//9@crux>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:25:40PM +0200, Artur Bujdoso wrote:
> The Octeon usb driver has been in staging for a long time and used in
> Ubiquiti routers for a while now.
> It's been built and then tested on real hardware with several usb devices
> and it is proven to be stable and ready to be moved to its proper place
> in the kernel tree.
> 
> Move it to drivers/usb/host and adjust its Makefile, Kconfig and defconfig
> dependencies.
> 
> Many thanks to the developers who made it happen.
> 
> Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> ---
> Changes in v2:
>   - Write a better changelog.

I added this to a branch and then pulled it into both the staging.git
and usb.git trees so that we have a common place to work off of.  I'll
take changes going forward in the usb.git tree only to the driver.

thanks,

greg k-h
