Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D676957E756
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiGVTZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiGVTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC413F93;
        Fri, 22 Jul 2022 12:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57D86192A;
        Fri, 22 Jul 2022 19:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F02C341C6;
        Fri, 22 Jul 2022 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658517918;
        bh=xuKtXsTHkn0pTkQYNaGYt7up+YxyXAU6zKa8/F8cb4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GvVYEz0XVqnnIsn/hR7I+ZMQYYiGNijjl3vDCaO3PrCyIBGadxMl1Lym1d6CZOFYU
         jXG3IRvDRcyb1jtrPEFjCf5zUoP1AwSdyVmbGXq0yYYGtEsJeJ3rzXHkEP8zMWsLWA
         2jdQlEMa0uoblsJ9U3ojOVp/Q5wQ1QnLymTnQ9q4hNURDXqCiHF8801S03fKjNh1B2
         AKez12l/WgOBFyzQOwiVFeBJdQIetKO91HmKRJfq+M0B+CyPrynklOF+JT31gyUwAq
         I+RPJ0zEhdSeLfy2qcnFOTDAsg+t2kpfsh90wjFjfxtUAoSCOATz+l7efrG+mFtcU4
         duPVtPhCFkcog==
Date:   Fri, 22 Jul 2022 21:25:12 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: media: zoran: Deleted dead code
Message-ID: <20220722212512.265cc13d@coco.lan>
In-Reply-To: <614ce7e3-ff4e-5d76-e940-2aa222535743@gmail.com>
References: <20220722182622.23719-1-abhijeet.srivastava2308@gmail.com>
        <614ce7e3-ff4e-5d76-e940-2aa222535743@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 22 Jul 2022 20:52:29 +0200
Philipp Hortmann <philipp.g.hortmann@gmail.com> escreveu:

> On 7/22/22 20:26, Abhijeet Srivastava wrote:
> > Deleted part of code in block comment
> > 
> > Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> > ---
> >   drivers/staging/media/zoran/zoran_driver.c | 9 ---------
> >   1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
> > index b408c1d4e0a7..836edf623571 100644
> > --- a/drivers/staging/media/zoran/zoran_driver.c
> > +++ b/drivers/staging/media/zoran/zoran_driver.c
> > @@ -746,11 +746,6 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
> >   	.vidioc_enum_input		    = zoran_enum_input,
> >   	.vidioc_g_input			    = zoran_g_input,
> >   	.vidioc_s_input			    = zoran_s_input,
> > -
> > -/*	.vidioc_enum_output		    = zoran_enum_output,
> > - *	.vidioc_g_output		    = zoran_g_output,
> > - *	.vidioc_s_output		    = zoran_s_output,
> > - */
> >   	.vidioc_g_std			    = zoran_g_std,
> >   	.vidioc_s_std			    = zoran_s_std,
> >   	.vidioc_create_bufs		    = vb2_ioctl_create_bufs,
> > @@ -762,13 +757,9 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
> >   	.vidioc_streamon		    = vb2_ioctl_streamon,
> >   	.vidioc_streamoff		    = vb2_ioctl_streamoff,
> >   	.vidioc_enum_fmt_vid_cap	    = zoran_enum_fmt_vid_cap,
> > -/*	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,*/
> >   	.vidioc_g_fmt_vid_cap		    = zoran_g_fmt_vid_cap,
> > -/*	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,*/
> >   	.vidioc_s_fmt_vid_cap		    = zoran_s_fmt_vid_cap,
> > -/*	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,*/
> >   	.vidioc_try_fmt_vid_cap		    = zoran_try_fmt_vid_cap,
> > -/*	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,*/
> >   	.vidioc_subscribe_event             = v4l2_ctrl_subscribe_event,
> >   	.vidioc_unsubscribe_event           = v4l2_event_unsubscribe,
> >   };  
> 
> Why does the subject line start with "media:" The subsystem is 
> "staging:" so the subject should start with "staging: media: ..."
> 
> I have no clue if this is accepted.

The subsystem is media. The drivers for both drivers/media and
drivers/staging/media have the same maintainers. The "staging" is 
just a place where we place stuff that are either not ready for
upstream or are under deprecation.

So, we expect that all subjects start with media:. I prefer if 
they don't have "staging" at the subject, as makes the driver
logs more coherent when they're moved in/out staging dir.

Regards,
Mauro
