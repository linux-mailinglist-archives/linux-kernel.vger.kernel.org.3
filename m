Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA95788BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiGRRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiGRRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8B2C648;
        Mon, 18 Jul 2022 10:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3014DB81658;
        Mon, 18 Jul 2022 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E2C341C0;
        Mon, 18 Jul 2022 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658166410;
        bh=fJhXHjK4iR4PrXajXTvrNgHrH8Xm1UQQa3ldL5pU8Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DB8w1PxX6sE2Jqdygs6y9Yra55MUcXmY2BOHTZcAw0DKG02aC1cEIry13uVVG+RV5
         J8RQ/OKz7vypxp6so9gWssYqpA8ROtWd5a+rAed/SpsZeAVCmSwIUQ6RSiBpMlIn0Z
         suW6eJfhov5tckaw8Z4hOytHN+r9T+6K9MEuc2uxXaXw9j31QcH+STlPtSqCl/uGf+
         ag8WEniN/ywrb3G4bXyO0sinsDM4ZofO1O1zuA7aUxiyFrmVOsAL4HYhGXjEdMvheZ
         Q73/UmZArebfTzc4IrUKtoeFSy6hb3+VikVr7scxUGMWYsnNvKL40dCKzQ/o9xuzud
         kpNCNEzPxT+Pg==
Date:   Mon, 18 Jul 2022 18:56:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: add empty line in front of
 bullet list
Message-ID: <20220718185645.0a0ecd84@jic23-huawei>
In-Reply-To: <YsFl9YoSn2YUDHAk@debian.me>
References: <202207021703.lEW6FLT1-lkp@intel.com>
        <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
        <abcaa4f5-7a9b-56b5-c11a-a88fef9d1e0a@gmail.com>
        <YsFl9YoSn2YUDHAk@debian.me>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 16:48:37 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Sun, Jul 03, 2022 at 01:27:47PM +0900, Akira Yokosawa wrote:
> > "make htmldocs" emits a warning of:
> > 
> >     Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
> > 
> > This is due to a missing empty line in front of the bullet list.
> > Fix it.
> > 
> > Note: The line count of 2 in the warning is not exact in this case.
> > 
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> > Link: https://lore.kernel.org/r/202207021703.lEW6FLT1-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Applying this on top of Mauro's fixes [1], no warnings. Thanks.
> 
> So I think Sphinx was pointing the culprit at the wrong location, since
> the problem isn't lie on the field, but rather on the list.
> 
> Mauro, can you please pick this up?
> 
> [1]: https://lore.kernel.org/linux-doc/cover.1656759988.git.mchehab@kernel.org/
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

I've picked it up via the iio tree.  If Mauro has it as well, git will
sort it out for us.

Thanks,

Jonathan
