Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A360F59B2D4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiHUIqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHUIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CED237C2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E41360C95
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD46C433C1;
        Sun, 21 Aug 2022 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661071574;
        bh=KSvjY3lK/TpsVdGUuwm3DhwMl9q0nnxDdrUhtNsvEXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/fz+JoonaXfLWFDZZlK5dXsdGYkiHrmXZtB2BwJEKygSIzF8Dq+yw1ZJPTy3BZft
         RCWIJP9po0gH3TIUHveqKpaDV+EtT8t+3PbdTNESaLEY83kbUiw2Utvlp/rrQYe6X6
         4uNe0dJWyCBHGfZPMUF7F9zTOQyZDwz1m9UbRW3U=
Date:   Sun, 21 Aug 2022 10:46:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhishek Shah <abhishek.shah@columbia.edu>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        bjohannesmeyer@gmail.com, jakobkoschel@gmail.com,
        xiam0nd.tong@gmail.com, Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: data-race in set_console / vt_ioctl
Message-ID: <YwHw4IlvxWgCrhB4@kroah.com>
References: <CAEHB249P1XurGDtvfjzkEzP4qWEaL6FG4ENM=PYjk7-JZfnKrQ@mail.gmail.com>
 <Yv82cwVT9MXX2nx/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv82cwVT9MXX2nx/@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 09:06:27AM +0200, Greg KH wrote:
> On Thu, Aug 18, 2022 at 09:17:00PM -0400, Abhishek Shah wrote:
> > Hi all,
> > 
> > We found a data race involving the *vt_dont_switch* variable. Upon further
> > investigation, we see that this racing variable controls whether the
> > callbacks will be scheduled in the console (see here
> > <https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/tty/vt/vt.c#L3032>),
> > but we are not sure of its security implications. Please let us know what
> > you think.
> 
> Again, any patch that you might have to resolve this would be great, as
> that's the easiest thing to review.

Given the your lack of responses to the developer's responding to your
emails, and the fact that all of your original emails were sent in html
format which was rejected by the public mailing lists so no one else
could see them, I'm going to just drop all of these reports as being
something pretty useless.

If you wish to submit future reports, please read the
Documentation/process/researcher-guidelines.rst file on how to do this
properly in a way that will be useful, and be sure to actually respond
to developers who take the time to write back to your reports.

This is not a one-way process.

thanks,

greg k-h
