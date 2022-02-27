Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2ED4C5B12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiB0MfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0MfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:35:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3F5F4FC;
        Sun, 27 Feb 2022 04:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D3ECB80C6D;
        Sun, 27 Feb 2022 12:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8005AC340E9;
        Sun, 27 Feb 2022 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645965273;
        bh=vd9yXUJzbfAqJNvLQ36xEL06P/YDGwf4z5Bmi1SooMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fL8puGmU5pIMV7kzPIjuWYDn/T+26sQczTlq67IceZ4vpjtB5+YeeucZsX5AjNQrz
         BkZy5fem9/ie/TBF8tBhZgYSKKrMMvodYb2lnQsz9Fbl2xwuFBTRCxOJ+weh348vcu
         OIIPVK10WK2OogrgeXlI7jJkfgJ6sbX35LA23/ztm9d/oyiwKApoJE24jUru9EJtwm
         c9Whzi9QV6lqLKWEN9JdXk1siWDUIPyYO/WeNaVlxis/z5hNw4baqhaDCFwJUzoIVM
         exmf8lGHu4nAlul0IwmpLB7abja8pDh3kSyFQUJj8sMMnNGj/WCccBj8R5QRj1rF0Q
         PYftWF0JswJRg==
Date:   Sun, 27 Feb 2022 12:41:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl355: use fwnode_irq_get_byname()
Message-ID: <20220227124134.4d4e4644@jic23-huawei>
In-Reply-To: <YflfEpKj0ilHnQQm@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
        <20211109200840.135019-3-puranjay12@gmail.com>
        <YflfEpKj0ilHnQQm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 18:25:54 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Nov 10, 2021 at 01:38:40AM +0530, Puranjay Mohan wrote:
> > Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
> > to get the IRQ number from the interrupt pin.  
> 
> Heads up, the fwnode_irq_get_byname() is in I2C tree and if Jonathan wants to
> apply this one, the PR [1] can be used.
> 
> [1]: https://lore.kernel.org/linux-i2c/YfRiGR3AT8tzyweG@shikoro/T/#u
> 

Thanks Andy. 

I'm going to let this go the slow way and pick up this patch after the
merge window when I can avoid pulling in that PR.

Basically I'm feeling lazy today :)

Jonathan
