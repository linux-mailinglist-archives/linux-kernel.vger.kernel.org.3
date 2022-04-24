Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7B50D3D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiDXRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiDXRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67273FBFD;
        Sun, 24 Apr 2022 10:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788AD611DE;
        Sun, 24 Apr 2022 17:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C77C385A7;
        Sun, 24 Apr 2022 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650820578;
        bh=vmknoXrx1fy+lEXzoLqZcckt9/D0ATbrRUGWXV6qlXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GxRpbzVP3A1patVSTniL+ykvMKXUnW9gbKGJP1BRzrt4V9ulQ4hnl46HHA1EKvaNP
         CfSGfx19lNscO6mxd3wONQ295YBnKB+IiYBbsix1A6m/hJlDkSs3MygePDpbiYSsO1
         EkqxbnxP7VHk2eTdhlTIXxzHpqYxYjNDEk4kyUmHzvvW5CywD1lAvn07PxKbE6gjHF
         p/cI334z1XJ9U7ogLROfNwl7eDWXn6xBvHk9HgX7QknsR6h/aOLpA6LokAEQfk9vJD
         47Qyu++YaUB59D5WkMC9OcnSYwOWgHxZKvoJZ/+7r9AXnO393/0ofzbxABxMIEdHe6
         jjeDmPn1uNqOw==
Date:   Sun, 24 Apr 2022 18:24:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: gyro: mpu3050: Make use of device
 properties
Message-ID: <20220424182426.22c0656b@jic23-huawei>
In-Reply-To: <CACRpkdaiwa4uC2qW38gwauBXmXhCwHxcHn-9nNbP=NSyd0OrTA@mail.gmail.com>
References: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
        <CACRpkdaiwa4uC2qW38gwauBXmXhCwHxcHn-9nNbP=NSyd0OrTA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2022 15:51:46 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Apr 13, 2022 at 6:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> >
> > While at it, reuse temporary device pointer in the same function.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Too late because Jonathan is trigger happy (which is good!) but FWIW:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

By the power of git rebase -i and the fact I'd only pushed out for 0-day
to test it so could still rebase.  Added your RB :)

Jonathan

> 
> Yours,
> Linus Walleij

