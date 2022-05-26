Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D895E53514D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbiEZPTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiEZPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:19:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8A95DD4;
        Thu, 26 May 2022 08:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F09B82106;
        Thu, 26 May 2022 15:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D5C385A9;
        Thu, 26 May 2022 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653578356;
        bh=1AWzzdEtnYlFnhzQJKtAs2x1gkjOs+Qsr71YfNjCPtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMpscyhrLSgWhnIhh8RJyX1kUhIhxp98radNTZDghAXwOSOk0is7hf9n0sXv+0SQ5
         XVQ9L37Dly78NJ0OuhWC51m3sAQXKPWPZU7M7hVbCz+2gEeQLBJtS5F30slhTSSlMa
         cj/lARG7NNLMX1lMb0MkqT9rHEuusQrT+XFdhT5g=
Date:   Thu, 26 May 2022 17:19:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, stable-commits@vger.kernel.org
Subject: Re: Patch "Subject:random" has been added to the 5.17-stable tree
Message-ID: <Yo+acT8AhgtgkZLZ@kroah.com>
References: <16535762872752@kroah.com>
 <Yo+YFzs5qMqDFmwO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+YFzs5qMqDFmwO@kroah.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 05:09:11PM +0200, Greg KH wrote:
> On Thu, May 26, 2022 at 04:44:47PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Subject:random
> > 
> > to the 5.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      random.patch
> > and it can be found in the queue-5.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > >From foo@baz Thu May 26 04:19:10 PM CEST 2022
> > From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Date: Wed, 6 Apr 2022 02:36:16 +0200
> > Subject:random
> > 
> > From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > 
> > commit e3c1c4fd9e6d14059ed93ebfe15e1c57793b1a05 upstream.
> 
> Something went wrong here with your scripts?
> 
> the subject got confused.

Looks like something went odd on my end, I'll fix it up by hand, sorry
for the noise.

greg k-h
