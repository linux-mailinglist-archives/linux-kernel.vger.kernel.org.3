Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804C3522C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiEKGXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbiEKGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD601F8C4E;
        Tue, 10 May 2022 23:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95C73B82142;
        Wed, 11 May 2022 06:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF1C385D1;
        Wed, 11 May 2022 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652250179;
        bh=dr1sS53G4Pm1TyL5NsyZonMQdvda/MUhmA20m7oW+z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCHRDyaGR/wgK9C5TITSFPPM9YlIjPDgY0oE8C8NjR7J+qG1gD8mlS/Cvn8MihHwq
         0ZuQFmf6VbMmJB/OtN3emjcuijgLE2JhdCaL24vp8q30p98Uv+lr0x960Y6+uT/Vmd
         ERIluI0KmC+Px3sf0zdAJ+X0HzEpMgPydBrZ1Hjs=
Date:   Wed, 11 May 2022 08:22:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
Message-ID: <YntWQIXSqMCd6TYV@kroah.com>
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com>
 <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:06:47PM +1000, Dave Airlie wrote:
> > And use it to store expectations about what the drm/msm driver is
> > supposed to pass in the IGT test suite.
> 
> I wanted to loop in Linus/Greg to see if there are any issues raised
> by adding CI results file to the tree in their minds, or if any other
> subsystem has done this already, and it's all fine.

Why does the results need to be added to the tree?  Shouldn't they be
either "all is good" or "constantly changing and a constant churn"?

> I think this is a good thing after our Mesa experience, but Mesa has a
> lot tighter integration here, so I want to get some more opinions
> outside the group.

For systems that have "tight integration" this might make sense as proof
that all is working for a specific commit, but I can't see how this will
help the kernel out much.

What are you going to do with these results being checked in all the
time?

thanks,

greg k-h
