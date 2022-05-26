Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897053513B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiEZPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F66237C5;
        Thu, 26 May 2022 08:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4C161B3B;
        Thu, 26 May 2022 15:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918EC385A9;
        Thu, 26 May 2022 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653577754;
        bh=dydi7fFyuY9OpnK8NN7C6YpPCcj1B0Cx7+doASS7d/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeuX6h9UXUGfQKMQTEcuQjUo5aNAh6IEjLtBzj/6DBiEjc8prGcADmr58HWejnZek
         5KWbdGlYOJGuM/A6518EYXj0MrRIB974+oTriqBvOdgbbXaJm4vYcvvynfNPLGA1yK
         VfoKWnxkGSrwHr+VhJAnWweogUmy7tDgjg3aSoAs=
Date:   Thu, 26 May 2022 17:09:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, stable-commits@vger.kernel.org
Subject: Re: Patch "Subject:random" has been added to the 5.17-stable tree
Message-ID: <Yo+YFzs5qMqDFmwO@kroah.com>
References: <16535762872752@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16535762872752@kroah.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:44:47PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     Subject:random
> 
> to the 5.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      random.patch
> and it can be found in the queue-5.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From foo@baz Thu May 26 04:19:10 PM CEST 2022
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Date: Wed, 6 Apr 2022 02:36:16 +0200
> Subject:random
> 
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> 
> commit e3c1c4fd9e6d14059ed93ebfe15e1c57793b1a05 upstream.

Something went wrong here with your scripts?

the subject got confused.

greg k-h
