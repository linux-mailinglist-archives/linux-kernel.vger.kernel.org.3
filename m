Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875F356FF47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiGKKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGKKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE52E5874;
        Mon, 11 Jul 2022 02:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495C961148;
        Mon, 11 Jul 2022 09:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3B4C34115;
        Mon, 11 Jul 2022 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657533019;
        bh=ipGmIvH3yu0xGgpFv83Zks8PEQWUrNox9nI8DbA7GIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKSXXOQSCKDSE24wHTkqy9P1+mJnksZfUmzIK3lT/0cg3Lqt9AZ3cQkOEmGLERj1X
         EpizOBdk0yTGu/n0n4HU5aVb79Seiqjr7XlYMsRyV33Ox9Qilg1YRO4V+N5cbO3HnF
         REXCRoyXg99FDqlzbZWTKpSMszgsaoTqOjhuh1eIaBfBtHeJc1Ny1hlHpY6h5AizDS
         TicFFkboBjSltMVEdBfEOBGgTmj2URhHOj0w3aXVtDkkKZYYaLiZ9rxIzrCG9SgOcb
         c8V7PLY6GnQwkhyTA3bAsNLEpOw4KiuStiSwX8HzA7UpYKhmNaP1gScPgI0MyUUYW5
         QYct7Wwi7F5ag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oAq3Y-0006nB-PS; Mon, 11 Jul 2022 11:50:20 +0200
Date:   Mon, 11 Jul 2022 11:50:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] media: flexcop-usb: probe cleanups
Message-ID: <YsvyXJ2a0ILnB+vu@hovoldconsulting.com>
References: <20220609142605.23620-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609142605.23620-1-johan@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:26:02PM +0200, Johan Hovold wrote:
> This series cleans up the probe helper functions a bit to make the code
> more readable.
> 
> Note that these apply on top of the fix posted here:
> 
> 	https://lore.kernel.org/all/20220609135341.19941-1-johan@kernel.org/

> Johan Hovold (3):
>   media: flexcop-usb: clean up endpoint sanity checks
>   media: flexcop-usb: clean up URB initialisation
>   media: flexcop-usb: use usb_endpoint_maxp()

I haven't received any notification about this series being added to any
tree and the status is still set to "NEW" in the patch tracker so
sending a reminder.

>  drivers/media/usb/b2c2/flexcop-usb.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Johan
