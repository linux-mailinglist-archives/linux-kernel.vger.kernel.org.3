Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6B5A3E98
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiH1QmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiH1QlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE918E38;
        Sun, 28 Aug 2022 09:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28E1BB80B79;
        Sun, 28 Aug 2022 16:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9193C433D6;
        Sun, 28 Aug 2022 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661704873;
        bh=KO6Jyw5BC6Rm6HuuL0JYbgtpOHIOU74g5UFXfpb92UA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CgoUxaWdsxHrwMsdOxWUTwYbWCY499SmaiskWfL9FsffqpA5jeHD6MPR2n4E6wr3O
         dQtVuerAGNTI5A+QKPXdoPvShO38j8mFvsCLxwK99F5Zqw10CyOi0bx9+tE/v3IFae
         og+IbhEDrDAwcZ0xSPDd3qdwlpIz0QPsED5w24qT4i4PcfPoAEl/nT9rmPFMj2xrfb
         Ck2DEc7nu/mtn7Wpz2xQ6sxkqHYXWwhUIG6J+0D1+kC87q4jfvdfYiAs+/MGDtldNt
         NvLwdk0azCP707nHTvtGEttnsNFbtwNdYKRbCxUBFV57InMWCZ8SLYWXPX+bwtcOy9
         DXO1413lmE23Q==
Date:   Sun, 28 Aug 2022 17:06:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio/accel: fix repeated words in comments
Message-ID: <20220828170652.12127638@jic23-huawei>
In-Reply-To: <20220823140023.2567-1-wangjianli@cdjrlc.com>
References: <20220823140023.2567-1-wangjianli@cdjrlc.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 23 Aug 2022 22:00:23 +0800
wangjianli <wangjianli@cdjrlc.com> wrote:

> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Applied,

Thanks,

> ---
>  drivers/iio/accel/kxcjk-1013.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 748b35c2f0c3..b073ab12e6a4 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1064,7 +1064,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
>  
>  	/*
>  	 * We will expect the enable and disable to do operation in
> -	 * in reverse order. This will happen here anyway as our
> +	 * reverse order. This will happen here anyway as our
>  	 * resume operation uses sync mode runtime pm calls, the
>  	 * suspend operation will be delayed by autosuspend delay
>  	 * So the disable operation will still happen in reverse of

