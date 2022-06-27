Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768255C58D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiF0JbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiF0JbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:31:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD725DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:31:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so12138990wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H8y304HP3NlXSOokRObqerrM0iiWlabzlmfKtvJse0s=;
        b=Kml6u4hIRPvTgl+T0C4EwQA5t2dcaFv/08c7rYoqjmkW55GqYf3/sZ2JPPtWku9PbX
         Ngs+9uvbvnwlxtYO5mZd/23SdpkoaCYB+qtpxmQDSMNnSA/x8JKRGIkHlEEAVZLQzE1y
         lBQ2Nk74+vDTTjUjQOsPWM6u9lchiD/3TVJm6mBozW+7g9D5C1pF057zeTuzoJIrPjtd
         K/791paTxuvcpa/p53a/BW7PKIDMGrIYGwvLCSZ+oDXcf6xf1iRDAixFTjsmr4agMUTG
         uXUzGTClz8esy0GSrpZ9T02EKe20FmNSY+Iwh1+KOSGlu1Yug022rwdgXZr+tTR8sqn9
         b9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H8y304HP3NlXSOokRObqerrM0iiWlabzlmfKtvJse0s=;
        b=Q8MLD8dDmCBmwTGqjk7deY6ZbwgmPUSjU00I1jdJip5QxbxoVjhEM1AgN+XY8zeHIV
         a6WtDkkbw3QOz8kYJ+zcfBOguJ7Q3/XMMMaq2YcAfIjQPLfpBN/KN6AK7TZ5lOTQOe7v
         exvk/2NPG25dhZdNyGQKjhNNEkbtzgtHL8LZlkVbroKQjbtxnviOU3jX2S6h8ohvkDlN
         cITMutV+yqTw1PThvLextdyAB8o9dGDQIcVXagCuUFn1mSOlAeh81vd7pGGUQ8NthGu5
         YS9jGlKZoQgOH0qdam6KaIGH8ra8RKs8I9hukiQWyzEQ4bCCx6a72b8K6DGx6kKM8Nxj
         I2Rw==
X-Gm-Message-State: AJIora+HHyJbfsThX+NWmBD0Ya3zzL1pWRy+9OvR1sB7jlwFThqZrN3v
        2S+xirx2KluAncw1fYCEx7VjdA==
X-Google-Smtp-Source: AGRyM1uS2eYhMjze/AGC4C3IZdKBZ74QEvXPzodxaUs1Io7u823rxUPzkoeeUcanecBM5tjOSqEaqQ==
X-Received: by 2002:a5d:50d0:0:b0:21b:978f:e54 with SMTP id f16-20020a5d50d0000000b0021b978f0e54mr11865553wrt.612.1656322262271;
        Mon, 27 Jun 2022 02:31:02 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b0039c587342d8sm16971415wma.3.2022.06.27.02.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:31:01 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:31:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 10/11] mfd: intel_soc_pmic_bxtwc: Drop unneeded casting
Message-ID: <Yrl41EqRfyctZmKQ@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-10-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> The casting from size_t to ssize_t is not needed in addr_store(),
> drop it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
