Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCC4CEB74
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiCFMMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:12:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA11A833;
        Sun,  6 Mar 2022 04:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0873A60E09;
        Sun,  6 Mar 2022 12:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB2C340EC;
        Sun,  6 Mar 2022 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646568721;
        bh=RdsMn1NV+ee2cT77H5I6utiQ+VayosQE+GCEI/twxPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USMK8bgQ4mCYGXENDtJjq8OiU1m843+JH8xGKlAI4ebgctv2drHgEq9JZKGcUypGm
         Ee7k+sZGvkJte1T7vY9omjdxfGBoCmLiW+tXm0EGX21v/Qw7EKASYbIgBCIwQpeu/u
         Wyom0/8V4z0eXZH1uQIzHlixzdkh8rUNAXzx6Tv0=
Date:   Sun, 6 Mar 2022 13:11:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
Message-ID: <YiSlDqqk0gnUouWd@kroah.com>
References: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
 <YiSOjGLzMCvKOm0G@kroah.com>
 <CAFQXTv1CACLRB-Tx07pR4xFNQncdq=i7Q7=vQzgD3hpdehr7cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXTv1CACLRB-Tx07pR4xFNQncdq=i7Q7=vQzgD3hpdehr7cQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 06:57:08PM +0800, Yunhao Tian wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年3月6日周日 18:36写道：
> >
> > On Sun, Mar 06, 2022 at 06:17:54PM +0800, Yunhao Tian wrote:
> > > Hi everyone,
> > >
> > > I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
> > > RK3308 board. I set up f_rndis gadget with the following script, and
> > > plugged my board to a x86 Linux computer running 5.15.25 kernel:
> >
> > Does the same thing happen with the non-rt kernel?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for your reply!
> 
> This doesn't happen to non-rt kernel. It will only happen when
> PREEMPT_RT is turned on, with rt kernel.

Great, thanks for letting us know.  I'll let you work this out with the
-rt developers :)
