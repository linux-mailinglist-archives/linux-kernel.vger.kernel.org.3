Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A187502E98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiDOSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDOSQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:16:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC1D57;
        Fri, 15 Apr 2022 11:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E93C0B82E28;
        Fri, 15 Apr 2022 18:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AB4C385A4;
        Fri, 15 Apr 2022 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650046459;
        bh=cB+yg/yJGCaj03HnQCrHcoKwKc81l2WYRXJIj+kyRDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fc6TYDhBNLkEH2xVgfNS1g/IktwiVFPRInG9IbYE0jAF9DZKuxq8qm5NLTyaOwrrj
         tKyIhHg6w9R5qOpbjsjr/8aoUyMT+RKKdWYjBMPtapdJiR8MLUW8ZkGcPx9qA7uA6c
         1q4O3ClUXmEeJfMFz2/Xsks7ZQsEm/tuCtczr4ZxfCy25rOa2qxGpEap1eKslvV1a5
         lvMmqLv8k2QCkNVK01/rAvNt0LGM5v+CxoDGA9ABJ1hWlg+xrrkYgpKY9xY7120I83
         ArQXqlvQgnQQap1PynzrzNs4WVZ2fDMQ5WXF8Pv0TeUJDbNzzEY77CHndoYdm9o/Oc
         lrWlvaOxBTPWw==
Date:   Fri, 15 Apr 2022 19:22:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: dac: vf610: Drop dependency on OF
Message-ID: <20220415192217.1fb469e4@jic23-huawei>
In-Reply-To: <20220413191611.46204-1-andriy.shevchenko@linux.intel.com>
References: <20220413191611.46204-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:16:11 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
What headers? I'll amend the description to drop that bit.

Applied

Jonathan

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/dac/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 7ab3b0839e55..015d307a9c6d 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -441,7 +441,6 @@ config TI_DAC7612
>  
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
> -	depends on OF
>  	depends on HAS_IOMEM
>  	help
>  	  Say yes here to support Vybrid board digital-to-analog converter.

