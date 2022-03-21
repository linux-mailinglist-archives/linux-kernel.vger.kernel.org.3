Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0B4E3B67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiCVJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiCVJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249213E0ED;
        Tue, 22 Mar 2022 02:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B92CFB81C62;
        Tue, 22 Mar 2022 09:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FCFC340EC;
        Tue, 22 Mar 2022 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647939826;
        bh=cuS4EBFQSf1WkgTqWY0pfA9MH0SboyS8hCKdIfOlgLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmsjzzqVmN+Lfq7lQlRy1DhmnZrQ64SpGK+bZut33VcwZI7dn6SPfBo7DvIDJqYSt
         vg3fDZit94hGTHYTwe/SmOHiZxnRZ7wcbyPrUFDDW8sdRKe6rmiAfw0lu8IzDj02IN
         eviq9oYRSdBuYaVakUPRNrC/jEp7vgpXlk/Va2Hk=
Date:   Mon, 21 Mar 2022 16:53:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     linux-kernel@vger.kernel.org, sec@valis.email,
        steffen.klassert@secunet.com, stable-commits@vger.kernel.org
Subject: Re: Patch "esp: Fix possible buffer overflow in ESP transformation"
 has been added to the 4.19-stable tree
Message-ID: <YjifgTsDes+hiKq6@kroah.com>
References: <16478662281158@kroah.com>
 <Yjh5rcxI/VW40j1+@kroah.com>
 <97b7e9f3-8ec3-b824-1301-9cea0a4d3437@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b7e9f3-8ec3-b824-1301-9cea0a4d3437@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:47:20AM -0700, Tadeusz Struk wrote:
> On 3/21/22 06:12, Greg KH wrote:
> > On Mon, Mar 21, 2022 at 01:37:08PM +0100, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >      esp: Fix possible buffer overflow in ESP transformation
> > > 
> > > to the 4.19-stable tree which can be found at:
> > >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >       esp-fix-possible-buffer-overflow-in-esp-transformation.patch
> > > and it can be found in the queue-4.19 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Oops, nope, sorry this breaks the build on 5.4 and older kernels, now
> > dropped.
> 
> Yes, that is for 5.10 only.

Can you provide a working backport for 4.14, 4.19, and 5.4?  They also
are affected here.

thanks,

greg k-h
