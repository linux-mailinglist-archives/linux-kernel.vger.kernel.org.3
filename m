Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7114AC0ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388137AbiBGOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388139AbiBGOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:08:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E218C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA1B6132F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA560C340EF;
        Mon,  7 Feb 2022 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644242889;
        bh=DT0k99X7gHEt39Vk+s4oXGf3A4XZjlb/MtEA/YK8z3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn2ZSMgkfnO0ZsRrdABpiGoqtxOCfJ/GxCuyhNZQep+CWkp6mzOi6+CBHkTK+SkBm
         8ZShtAjMiIMn9srlbQ/0CvtDsOESxOjpUgCwqp6NizegYTaLrb5JdJUTyrmA+z1yxd
         4w4kWLf+xnrjtJKw7d8WR2rcFxsHieTRKHPodvHE=
Date:   Mon, 7 Feb 2022 15:08:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Alexander Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Calculate the monotonic clock from the timespec
 clock to generate PPS elapsed real-time event value and stores the result
 into /sys/class/pps/pps0/assert_elapsed.
Message-ID: <YgEnxmD9ZE4jVhP5@kroah.com>
References: <20211118032217.244985-1-alexander.komrakov@broadcom.com>
 <20211118032217.244985-2-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118032217.244985-2-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:22:17PM -0800, Alexander Komrakov wrote:
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

Now deleted, we can't take patches with this footer, as per your legal
team's requirements.  Please fix this.
