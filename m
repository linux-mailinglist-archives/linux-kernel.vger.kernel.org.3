Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7074D9C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348624AbiCONYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiCONYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC9C0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76CFD615F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F9C340E8;
        Tue, 15 Mar 2022 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647350580;
        bh=Ei/Y23MgvmDfhjLJWJarlbjup/SwfjWeC1vxGCGrhQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oozIfQgoOJ3cXif9OfRhQDUDA7kcPniBGHrFWFvtVy7uqQAgptLcEDtsBoLYm4hzI
         Z0qCncThtvwWhxz1V4+FTjTt10D5qgHirQfDiM9XXWhMIIBMWr96HcQG+e4X/PPN/x
         JVxy8zIuVm5SUL9gLeS9Q/ak7bs4Hahj3C9SgUuA=
Date:   Tue, 15 Mar 2022 14:22:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] staging: remove ashmem
Message-ID: <YjCTL/2ZJW8EWLHL@kroah.com>
References: <20220315123457.2354812-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315123457.2354812-1-hch@lst.de>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:34:57PM +0100, Christoph Hellwig wrote:
> The mainline replacement for ashmem is memfd, so remove the legacy
> code from drivers/staging/
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

While I know Android devices somehow still rely on this (as many
userspace programs directly accessed the ashmem device), I agree, it's
time to drop this for good.  If Android really needs this for future
devices, they can revert it and maintain it on their own.

I'll go queue this up now, thanks.

greg k-h
