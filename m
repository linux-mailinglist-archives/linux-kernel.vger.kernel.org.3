Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3463951E59E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446107AbiEGIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446093AbiEGIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA453710;
        Sat,  7 May 2022 01:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6081961033;
        Sat,  7 May 2022 08:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8AC385AC;
        Sat,  7 May 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651912409;
        bh=eieCeE9Fdh+mCSq7kvDqUtqD4dWmttb7ZzhtYGZmMhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02sb1bav56AqxmyArlrAX21IGgeG1DopOeTzyubuc25nQZRtkFcUnmmwdZwUUUUPs
         OY63D6KlNDo8TblbXBPoRpa4TpHokrst1y0/x2OVYqK8/uFCBbASkg07cBIFpC+Db9
         L0Uue1gdqUxJvOVbFKRQqTVTEHKgTDmQXZaK/0+k=
Date:   Sat, 7 May 2022 10:33:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     lizhe <sensor1010@163.com>, lee.jones@linaro.org,
        fthain@linux-m68k.org, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        jjherne@linux.ibm.com, freude@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, zbr@ioremap.net, perex@perex.cz,
        tiwai@suse.com, bvanassche@acm.org, dan.j.williams@intel.com,
        srinivas.kandagatla@linaro.org, wens@csie.org,
        colin.king@intel.com, hare@suse.de, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] kernel/drivers: Remove redundant driver match function
Message-ID: <YnYu1XGeyRvMn77g@kroah.com>
References: <20220506045952.136290-1-sensor1010@163.com>
 <20220507082137.i23gbxkbjwt36ggd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507082137.i23gbxkbjwt36ggd@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 10:21:37AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, May 05, 2022 at 09:59:52PM -0700, lizhe wrote:
> > If there is no driver match function, the driver core assumes that each
> > candidate pair (driver, device) matches, see driver_match_device().
> 
> I wonder who is supposed to apply this patch. Either it should be split
> by file and go in via the respective maintainers, or it goes in via
> Greg's tree? I added Greg to To: for him to chime in.

It should be split up into each subsystem patch and submitted that way.

> Best regards
> Uwe
>  
> > Signed-off-by: lizhe <sensor1010@163.com>

We also need a "real name" here that is used to sign legal documents.  I
doubt an all-lower-case name is used that way, so I have to ask.

thanks,

greg k-h
