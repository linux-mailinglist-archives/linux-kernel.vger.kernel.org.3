Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A914F869D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiDGRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbiDGRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95C22EBE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EE661976
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3832C385A4;
        Thu,  7 Apr 2022 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649353863;
        bh=iBZxPWDIqKLn9hWgPpT2DzF41eYn3xaK1WuVBDT9kLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv4C6fFhFdNrF+mn6KNyC1rHVUJ42ECR/3tD6579FzZhMQxJk0hqN7t29aISztqOo
         s5gKFaflSIeBKeuUzilYcTpLB/2wlj97czZCH4fc9OfaucwI7Zx914WCBD0Qvp5HKR
         LOKRpyMrm9ibvvFZnylA9crvK9SPH8B83cdY/02E=
Date:   Thu, 7 Apr 2022 19:51:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     paskripkin@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: check the return of kzalloc()
Message-ID: <Yk8khN/Htc0zVY9d@kroah.com>
References: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com>
 <tencent_15C23F2EC8197361EE200714C54E78B45206@qq.com>
 <9c307f1e-aa95-08e6-3a01-825caba19a30@gmail.com>
 <tencent_0D5C6E0E160AA0702025FDFF35906EE69E07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0D5C6E0E160AA0702025FDFF35906EE69E07@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:03:49AM +0800, xkernel.wang@foxmail.com wrote:
> On Thursday, April 7, 2022 3:22 AM +0800, paskripkin@gmail.com wrote:
> > > -void rtw_alloc_hwxmits(struct adapter *padapter)
> > > +s32 rtw_alloc_hwxmits(struct adapter *padapter)
> > >   {
> > 
> > What about plain 'int'? I know that s32 is typedef for 'int', but 'int'
> > looks more natural
> > 
> 
> I agree with you.
> Since the type of `_rtw_init_xmit_priv` is `s32`, I directly changed the
> type of `rtw_alloc_hwxmits` to `s32` (they are neighbors in rtw_xmit.h).
> In fact, there are many places where `s32` appears together with `int` 
> in related files, so maybe we can leave it as a future work to make all 
> of them a unified form.

No, get this one right to start with.

thanks,

greg k-h
