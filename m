Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36834AC0F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388885AbiBGOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382419AbiBGOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:07:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E9C043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5BB6132E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA00C004E1;
        Mon,  7 Feb 2022 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644242833;
        bh=lRjIYWVVdIi/4oqqXti673TN17KrAL49hwRnJtI+lUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5+4Nf4DbH3YHb9kwcPqwKDppYH4O/O1/E6SlLBri9Bz+fDlZw/hNITLiUKTJDQYt
         7uS2RQtYsT2uFp1wMLNocY9REqlBasjvv5PjBskYkLZUACGBNqA3s0YwTNNKUCT2Sh
         XxR8cHt9vgJzbK2N1KFH601rSS1kElxOZEoMQ6EI=
Date:   Mon, 7 Feb 2022 15:07:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Calculate the monotonic clock from the timespec
 clock to generate PPS elapsed real-time event value and stores the result
 into /sys/class/pps/pps0/assert_elapsed.
Message-ID: <YgEnj/XeOMzvsNh1@kroah.com>
References: <20211118032217.244985-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118032217.244985-1-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:22:16PM -0800, Alexander Komrakov wrote:
> -- 
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Email is now deleted.  This is not compatible with Linux kernel
development for the obvious reasons :(
