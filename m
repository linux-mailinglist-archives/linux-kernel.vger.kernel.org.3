Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30353E374
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiFFGLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFFGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:11:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B62EF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 991F6CE13C5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0986C385A9;
        Mon,  6 Jun 2022 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654495857;
        bh=4/5NEymG1UDzDdn8M6SuObew1HoxRYtX4PVktnUJ7q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs7sCzMXF8xrbv1j5rRHz88GLBQd3ocAchiZl/tVtiPgpVLQPa1gkZYH1JWRpiYwb
         7Z0iPN3RTLtZAXFbIM9upoFCqkFU5Ekkqkd1ia4W/AwHaj4XFkaD5NqV6gHUgHgiBu
         Bt336NfMDqZCUP5TsSXPq5qkJ3WF2MSaICOPb6Tc=
Date:   Mon, 6 Jun 2022 08:10:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 0/2] Fix some compile warnings in v5.18+
Message-ID: <Yp2abkhKL7HRmn9Y@kroah.com>
References: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
 <YpW4WKxKIIgY0l7m@equinox>
 <bf78b567-5c69-c968-3dc4-6c94eeb8d77a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf78b567-5c69-c968-3dc4-6c94eeb8d77a@lwfinger.net>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:16:58PM -0500, Larry Finger wrote:
> On 5/31/22 01:40, Phillip Potter wrote:
> > 
> > Hi Larry,
> > 
> > Both patches look good to me, however I've already submitted a patch 10
> > days ago that does exactly what your rtw_xmit.c patch does, in
> > addition to fixing the changed error handling semantics for the relevant
> > function (in f94b47c6bde6) which broke the driver.
> 
> Phil,
> 
> Sorry I missed your patch. I have been really busy the past month on another
> problem, and I was not paying much attention to r8188eu.
> 
> When I built a mainline kernel in the middle of the merge from 5.18 to 5.19,
> those two warnings stood out.
> 
> Your patch should be ahead of mine in Greg's queue, thus mine should fail,
> and I will get the "does not apply" message. At that time, I will send the
> other patch. As both of us missed the 5.19 merge, the build warnings will
> persist until 5.20, but no harm.

I've taken Phillip's patch, and your second patch here, both for
5.19-final, so all should be good now.

thanks,

greg k-h
