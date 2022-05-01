Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276D516683
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352770AbiEARN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350764AbiEARNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:13:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D64D9FC;
        Sun,  1 May 2022 10:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4619EB80E95;
        Sun,  1 May 2022 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D022C385AA;
        Sun,  1 May 2022 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651424992;
        bh=J8DY6nNFpxxPxQOvri8uTghVtz0D6TMTfj79LTqEi3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYqdP/MmgE7SynSL4mN/X6rsBGAmwoKOeTEcLVbA1pVULPtCcVW6P+LMf2N1C12ld
         /CAZD+H0x2n3AY5GKjXZsbIZUPODhPX6LJ0djnsWS3Z3fWpxjoLtwc+vNX4i7H850M
         vfJpXhfso6nqhTduUtbw8GBL50Kmr0CnFZR++5jo=
Date:   Sun, 1 May 2022 19:09:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kushagra Verma <kushagra765@outlook.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / dwc3: remove a possible unnecessary 'out of
 memory' message
Message-ID: <Ym6+1wPawNOUKKTr@kroah.com>
References: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
 <Ym6pp/O1fpneA5ZW@kroah.com>
 <8cf3b100a4dc0eaac9214e1a9ea2b6dace7c85bb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf3b100a4dc0eaac9214e1a9ea2b6dace7c85bb.camel@perches.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:50:45AM -0700, Joe Perches wrote:
> On Sun, 2022-05-01 at 17:39 +0200, Greg KH wrote:
> > On Sun, May 01, 2022 at 09:01:36PM +0530, Kushagra Verma wrote:
> > > This patch removes a possible unnecessary out of memory message from
> > > core.c
> > > as reported by checkpatch.pl:
> > >    WARNING: Possible unnecessary 'out of memory' message
> 
> 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
> >   and can not be applied.  Please read the file,
> >   Documentation/email-clients.txt in order to fix this.
> 
> Seems like a patch-bot false positive patch-bot to me.
> 

Try to apply the patch, it is line-wrapped.

It's a good bot :)
