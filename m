Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92120559D07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiFXPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFXPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:10:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24A4CD5E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:10:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id cs6so4958814qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8sNieh9omUOFpJ9ZXsO4kHaUMQjD/qsybFxiiVOJ6Y=;
        b=Q3+owTKaaiY95Skera0W9ThGSkFBEHovF0Wb86AiuP84qrKYeXyhmGTyvL4ossuTD1
         eDE6AFyU710Q6RGi6+B9SwEUM+UqsRTuWjy0C1PDKkCqvFwaz7GBFp/gGqjsnaE6wsZT
         04vTMi8v7HpXKtbPGYhoixCshDTasxIo3hHZxBd3w5MKzlx0Ea63EYwepWfKj2FKhkGc
         77xVcSvcRQMq2Gil0h8hGm5YTEs0AIZh8Uq7JzVpDAkbgpdbxrMFAT75YUC3EvVNh9P9
         OwrbEurHgFIEa+cbftGBWcP3jkJkQ3lS5P50ViliXl7Cu175iI57DmA4U7togTTeJg+u
         peBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8sNieh9omUOFpJ9ZXsO4kHaUMQjD/qsybFxiiVOJ6Y=;
        b=DovCWOqEpMQOJKnQXdEmjBvlI4dIPdfKh7oZM51WllrGPMaPTpV1NKTvagyf9ALKi2
         GvkvbsZkioAaw+85vXTQBKX+5BWKy8aZjpNe9exOP0+zJvfK5AdDUJ2aOg9AKOUpsVnq
         K90+iECUTVAHarXtMaKkDl+KDxiop+qePVpyMIV87LlTDoKrmLvXG+Um2ft/eXNUeBg0
         4SfX9XbNebPrYK6pnihIXb1qXC+Aj7HjDi+4+M0I6vmJF7s+ykRnEw8+4GL9qA/QFcxb
         2YnOwkQ+68Dtmn4ubyUs90fvxf/6HTsqwkyhdMoGT1avqJL9euFhd6lxB9kr4Xp3Hd0Y
         NCWg==
X-Gm-Message-State: AJIora9TNzpzRyXRtlegmpZLt69yEtzj4bXTlXhhavCVhyYL75rlzsi0
        kwwjjhd8G+SV/Y28/obY9qurEbUTxOI=
X-Google-Smtp-Source: AGRyM1tD490H2+j7yCVy077p+d+//6jZtAg14l2p9bZTwQCh2G46l2/lVMGSQ7jDiAeIxEzIZRGOxw==
X-Received: by 2002:a05:622a:1b9f:b0:317:6815:a902 with SMTP id bp31-20020a05622a1b9f00b003176815a902mr8551085qtb.35.1656083437857;
        Fri, 24 Jun 2022 08:10:37 -0700 (PDT)
Received: from localhost ([2601:c4:c432:5:a356:5d56:1ffb:9cf5])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006aee03a95dfsm1895637qkp.124.2022.06.24.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:10:36 -0700 (PDT)
Date:   Fri, 24 Jun 2022 08:10:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib: bitmap: fix the duplicated comments on
 bitmap_to_arr64()
Message-ID: <YrXT7j62m9MjF93K@yury-laptop>
References: <0d85e1dbad52ad7fb5787c4432bdb36cbd24f632.1656063005.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d85e1dbad52ad7fb5787c4432bdb36cbd24f632.1656063005.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:31:47PM +0800, Qu Wenruo wrote:
> Thanks to the recent commit 0a97953fd221 ("lib: add
> bitmap_{from,to}_arr64") now we can directly convert a U64 value into a
> bitmap and vice verse.
> 
> However when checking the header there is duplicated helper for
> bitmap_to_arr64(), but no bitmap_from_arr64().
> 
> Just fix the copy-n-paste error.

I spotted it as well, but you're the first. :-) Thanks.
Applied in bitmap-for-next.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/linux/bitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2e6cd5681040..f091a1664bf1 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -71,9 +71,9 @@ struct device;
>   *  bitmap_release_region(bitmap, pos, order)   Free specified bit region
>   *  bitmap_allocate_region(bitmap, pos, order)  Allocate specified bit region
>   *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
> + *  bitmap_from_arr64(dst, buf, nbits)          Copy nbits from u64[] buf to dst
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
> - *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
>   *
> -- 
> 2.36.1
