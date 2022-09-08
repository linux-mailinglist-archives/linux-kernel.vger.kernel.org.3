Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DED5B192B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIHJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIHJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:46:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B45113649
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5989CE1E99
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C4FC433D6;
        Thu,  8 Sep 2022 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662630393;
        bh=cpScdSqdudyAriHc6VtgOIXiwBHx2RRwGv6UcY80d2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C29Bma4Io81bpUecj3/T9Eab6e0qDig04tCjJGyWYCxuRAUfDGbpvRT+Hhe8J6Yjd
         unHA5gEzm30pTmvwNg48wOx22yTKykg9BBMmVodni7hk3FF9F9Rc2l8GUEFWdNODqx
         KHvwS7jhyTToha2264mx8f8Wf7EQXUGtom6wc6F/bDH/3zOaK8BU+XnCHGSer/XrSi
         kOLC674FtzyZQ9ak6+jOmfFr5wvf9cWKWHaD0FXnMOw5MlySUbUGmKEk1KW6IM0t+A
         bX6iKM0xsfnbTdXT2bqsnZtdKRGGxdAuE1bHeFI1dRP5MRa4JpI9Z6N9SEoe4pIExu
         c7tML5XiaO3/Q==
Date:   Thu, 8 Sep 2022 10:46:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [RESEND][PATCH v1 1/1] mfd: intel_soc_pmic_chtdc_ti: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Message-ID: <Yxm59bk/kVw3eDcn@google.com>
References: <20220906134256.14293-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906134256.14293-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Sep 2022, Andy Shevchenko wrote:

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> than the use of __maybe_unused attributes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
