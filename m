Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7658A535
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 06:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiHEENx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 00:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiHEENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 00:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B46A4A6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 21:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AA060F08
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA51C433D6;
        Fri,  5 Aug 2022 04:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659672829;
        bh=gYsacg6yoJQRyWR3sBDt5pes3+3xmeUVstzAqdvDkxA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ELp3++G1Y96F+GghGyAYpU2JPx5YFNvyfrEPFHAUahP95gLlgqNBn1Iro8TcavWuC
         2T+JGMer0Kv3JOQUXVMAWnjGL7piHDNIR75xtAS4pwW6BIagmhlvRsBw53RgDyoSNk
         7CEXoysWQjWUYiOsQPTg2URxk2MttZW6F0K8kSmc=
Date:   Fri, 5 Aug 2022 06:13:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: r8188eu: set firmware path in a macro
Message-ID: <YuyY+N7W6/noGxDZ@kroah.com>
References: <YuoQ37PIKzWO1zIY@kroah.com>
 <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
 <c3b30433-7231-6ebb-b0ea-44e760c4af69@gmail.com>
 <YuxG0OImQ1i0EOFD@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuxG0OImQ1i0EOFD@nx64de-df6d00>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 12:23:12AM +0200, Grzegorz Szymaszek wrote:
> On Thu, Aug 04, 2022 at 10:11:58PM +0200, Philipp Hortmann wrote:
> > On 8/4/22 00:28, Grzegorz Szymaszek wrote:
> > > diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> > > -%<-
> > > -MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> > > +MODULE_FIRMWARE(FW_RTL8188EU);
> > 
> > 
> > It failed to apply your patch as the following line:
> > MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> > is not in the repo. Inserted line in my repo to apply patch.
> 
> I’m sorry, I didn’t add the base tree reference. Right now, git
> format-patch generates the following:
> 
>     base-commit: 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
>     prerequisite-patch-id: 79964bd0bcd260f1df53830a81e009c34993ee6f
> 
> The prerequisite patch is available at
> <https://lore.kernel.org/lkml/YulcdKfhA8dPQ78s@nx64de-df6d00/>.
> 
> > Why is the coverletter missing?
> 
> I didn’t think it would be necessary, since the patches are quite
> simple and there are just three of them. Again, I’m sorry, I don’t want
> to make it harder for anyone to review my patches. Hopefully I will
> learn more of the kernel development practises without wasting too much
> time of patch reviewers.
> 
> Should I send an improved (with the base tree reference and with a short
> cover letter) patch series?

Nah, it's fine as-is, I will take it when my tree opens up again after
-rc1 is out in a week or so.

thanks,

greg k-h
