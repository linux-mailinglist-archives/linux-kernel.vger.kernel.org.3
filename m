Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99227508E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381119AbiDTReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376886AbiDTReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D804FDB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5D961A6C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA73C385A0;
        Wed, 20 Apr 2022 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650475908;
        bh=AoJih/yENvkldo/ZH5HAJi42bBZDC+vxjLtBK2Y+Xag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D98mcaF8ZQFX+4p6o7XSCi2q5pOpFWTU+dY8UgNJamvrVAn6FdXnXpdpKtJaGjdZt
         pHdDeadwCL5WGHT++0Hz3GCthVEyLFJmnRmbfK+cDJS+t/ArKhBxqE0osT+6AKJs+y
         aGLx5D43nZN1kmgQL0p+aE+CCon7H8I/EkhrJ6n4=
Date:   Wed, 20 Apr 2022 19:31:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?55m95rWp5paH?= <baihaowen@meizu.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: edd: Remove redundant condition
Message-ID: <YmBDgRYGdcjz3ppn@kroah.com>
References: <tjhedku0cwqypq8pujvusn6i.1647642604045@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tjhedku0cwqypq8pujvusn6i.1647642604045@email.android.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:33:12PM +0000, 白浩文 wrote:
> Dear Greg KH
> 
> But the logic here is:
>         (!A || (A && B))
> not:
>         (!A || A && B)
> 
> as you write
> 
> No, what I wrote is
> 
> the logic here is:
>         (!A || (A && B))
> Is the same:
>         (!A || B)

That is not what your changelog text says, and I quote:

> > The logic !A || A && B is equivalent to !A || B. so we have
> > to make code clear.

(note, top-posting is horrid and is why we do not do this, please fix
this in the future.)

So can you please fix up your changelog text to be correct and resend
it?

thanks,

greg k-h
