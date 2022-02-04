Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C844A9B61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356191AbiBDOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:47:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46030 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiBDOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:47:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01AA8B837A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE04C004E1;
        Fri,  4 Feb 2022 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643986063;
        bh=4d6kciG+IrnOCaMvAZVA17DWe8cweVJp1Pm3ncEVaoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPLLUZs8ezAaYzieYEKuGW62eqMF64xdqFaKaFr973xbkabOJYQhhOM9vAgkmqlzM
         yYlXBMKl9o6HdEvKzRu29U3Y6p5WBAla2jTEaLTzR+TUJF7f+XFmgWuFLkDtuYK4/v
         wH5nG6VWdvBbJkEKcvSctk0Vyi6Opsr/vI53b6Ro=
Date:   Fri, 4 Feb 2022 15:47:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] mux-for-5.17-rc1
Message-ID: <Yf08jcyZfESaYlVr@kroah.com>
References: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:43:43AM +0100, Peter Rosin wrote:
> Hi Greg!
> 
> Since last I improved a couple of commit messages. I.e. adding a body to
> "mux: fix grammar, missing "is"."
> and a Link tag to
> "mux: Add support for reading mux state from consumer DT node"
> 
> Further, I removed the exports of the new functions mux_state_get()
> and mux_state_put() as there are no users, not even in the wings as
> is the case for devm_mux_state_get().
> 
> Cheers,
> Peter
> 
> Aswath Govindraju (1):
>   mux: Add support for reading mux state from consumer DT node
> 
> Peter Rosin (2):
>   mux: add missing mux_state_get
>   mux: fix grammar, missing "is".
> 
> Yang Li (1):
>   mux: Fix struct mux_state kernel-doc comment
> 
>  .../driver-api/driver-model/devres.rst        |   1 +
>  drivers/mux/core.c                            | 239 ++++++++++++++++--
>  include/linux/mux/consumer.h                  |  18 ++
>  3 files changed, 236 insertions(+), 22 deletions(-)
> 

Sorry for the delay, now applied.

greg k-h
