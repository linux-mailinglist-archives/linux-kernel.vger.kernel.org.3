Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32757FE45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiGYLXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:23:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32714D08;
        Mon, 25 Jul 2022 04:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F0DB80E4B;
        Mon, 25 Jul 2022 11:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B5FC341C6;
        Mon, 25 Jul 2022 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658748187;
        bh=0IIAYshbz5A3pRgoMrl6JuShGW3ecxOFOPEaKrdoSE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ic4+4ho6edsY2dPPnjJLfbAb0kgjLEbkRVMDSOo7ihh5/hJhc4RMA44DkV+OH2Y4u
         mv/ZItSwUyUEUKwkUa5wjRj5OezKJGWLWm+TN1nWvRWI2wOVjMhk7RvPn5ydXD+iYB
         qwn2lHL1VnrhoQCBYuMniJwQ+hoHM5bf+jFv24Axj8RTctqIIKp0FrU/z7ZOxp9wdV
         jVMuxbqLySFyC+1r8OkIMANPUSEpguK4OGm0/kbQs0+sf4QL43sUqxJLfonJepqnJu
         q/Ytkv17qK0WtGgEYPRAZsJDEMjB/FemCWW3kmI3KGrSaFAKEHvxatSsnw6oMC8/TW
         S+8U61eGPLc/Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFwBC-0003kT-W7; Mon, 25 Jul 2022 13:23:19 +0200
Date:   Mon, 25 Jul 2022 13:23:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] media: flexcop-usb: probe cleanups
Message-ID: <Yt59Jv6PWPHQEuJR@hovoldconsulting.com>
References: <20220609142605.23620-1-johan@kernel.org>
 <YsvyXJ2a0ILnB+vu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsvyXJ2a0ILnB+vu@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:50:20AM +0200, Johan Hovold wrote:
> On Thu, Jun 09, 2022 at 04:26:02PM +0200, Johan Hovold wrote:
> > This series cleans up the probe helper functions a bit to make the code
> > more readable.
> > 
> > Note that these apply on top of the fix posted here:
> > 
> > 	https://lore.kernel.org/all/20220609135341.19941-1-johan@kernel.org/
> 
> > Johan Hovold (3):
> >   media: flexcop-usb: clean up endpoint sanity checks
> >   media: flexcop-usb: clean up URB initialisation
> >   media: flexcop-usb: use usb_endpoint_maxp()
> 
> I haven't received any notification about this series being added to any
> tree and the status is still set to "NEW" in the patch tracker so
> sending a reminder.

Another two weeks without a reply so sending another reminder.

Any chance of getting these (and the separate fix) into 5.20?

> >  drivers/media/usb/b2c2/flexcop-usb.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)

Johan
