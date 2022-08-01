Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D8586B07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHAMnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiHAMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:42:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF04B4AC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F2E5B8102E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B31EC433C1;
        Mon,  1 Aug 2022 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659356605;
        bh=iGJbH/WY0pOpKZEcFcog6gW4Baah6IrvPgqG1mwDY4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uinyRCt8xp/RobxaTIKI5w6bpbgO2zFCT2GxZGO/jxey1G3Gz/07dENb3uPpgILFP
         ix+vyHUlWuLWj/fxYYmosR5M+6XxSx3THsjOGhbhordts0+q2gBXK5AEL6R2sTiiY8
         hjj5abVFguoMxd/duomHt8XjaVw0HJL61yjtlBMg=
Date:   Mon, 1 Aug 2022 14:23:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
Subject: Re: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Message-ID: <YufFutiRVHHWMNQ0@kroah.com>
References: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
 <Yue3LpR7FdHygLze@kroah.com>
 <OSAPR01MB506015B38A0A9DC6BE90F7A3B09A9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB506015B38A0A9DC6BE90F7A3B09A9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:13:25PM +0000, DLG Adam Thomson wrote:
> On 01 August 2022 12:21, Greg Kroah-Hartman wrote:
> 
> > >  DIALOG SEMICONDUCTOR DRIVERS
> > > -M:	Support Opensource <support.opensource@diasemi.com>
> > > +M:	DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
> > 
> > I strongly discourage any anonymous "group alias" for maintainers of any
> > kernel code, as that takes away the personal responsibility from the
> > maintainer entirely, which defeats one of the strongest reasons that
> > open source development efforts work so well.
> > 
> > Why not just switch this over to you instead?
> 
> Appreciate the input. I will no longer be part of Renesas as of the end of this
> week, so wanted to update the mailing list address before I leave. The actual
> mailing list itself hasn't changed in terms of the people on it, aside from
> myself dropping off of course.

Then why not just list the people on that list?  That would be easiest,
right?

thanks,

greg k-h
