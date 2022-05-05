Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90B51C645
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382759AbiEERnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382745AbiEERnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D2580F2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E686BB82E0F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B62AC385B6;
        Thu,  5 May 2022 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772389;
        bh=zpop9/ljDn4ZM8M/KZiiF7dejFdxS4E3sMm1qBnY/kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIZp4NGwcDIvw6tMz+ekTb9gopV/lt9oioqxVuOI/tJ6vf3A717pJsPYxCCulP9bs
         NpCaGlGPIezdvLdCfZnFv2Pvb4K/ETLTzIQ685yTzwGeVSjX3Xnt1gPjRXoxLBv7+X
         XDaGcAoFaBDoNpnFiXC3NDqeJaxR6UmxT5mutQGA=
Date:   Thu, 5 May 2022 14:03:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksandr Tymoshenko <ovt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: add option text so it can be enabled by users
Message-ID: <YnO9A6juyW3v0LG7@kroah.com>
References: <20220505045001.363548-1-ovt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505045001.363548-1-ovt@google.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:50:01AM +0000, Oleksandr Tymoshenko wrote:
> This reverts commit 3b32a592ea6e4 ("dma-buf: drop option text so users
> don't select it.") to allow users select DMA_SHARED_BUFFER option
> explicitly. This is required for out-of-tree modules that depend on
> dma-buf functionality, for instance drivers that rely on Google's Gasket
> framework.

We do not add code to the kernel for out of tree code, sorry.  To do so
would be a total nightmare and maintance impossiblity, and not something
you would want us to do as Linux overall would suffer.

As you well know, the correct solution is to get your code merged
upstream.  I have asked many times to get the gasket code upstream
properly, please do so to resolve problems like this.

thanks,

greg k-h
