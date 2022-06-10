Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD45467CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349470AbiFJNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiFJNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7E515B9;
        Fri, 10 Jun 2022 06:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13F5DB83537;
        Fri, 10 Jun 2022 13:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A03C3411F;
        Fri, 10 Jun 2022 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654869262;
        bh=mPg6bfZMXXacmXro0sQ+0OEfahDPZlcqrGsx38/fb8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkuritKrLb753MyMAs+tWvofUCRWHuqtMkc8hu088Y24qkbonNV3/gwcol+jpi7UV
         gyl65+RTgzJUES7BFn0JznyZ6O3K3xK5h+dZDDu1N/JFXw3iSM0j6AKU2cG5gFjNcN
         KYMNWuf47VMpob673gcq2frd76YnFDDKWF03yV1w=
Date:   Fri, 10 Jun 2022 15:54:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: Introduce device_find_any_child()
 helper
Message-ID: <YqNNDOpPNB5r0SYN@kroah.com>
References: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:02:18PM +0300, Andy Shevchenko wrote:
> There are several places in the kernel where this kind of functionality is
> being used. Provide a generic helper for such cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: renamed method (Greg), refactored it (Rafael)

Much nicer, thanks, I'll go queue this up now.

greg k-h
