Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7855C90D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiF0J13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiF0J11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:27:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BF615D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:27:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i1so7629660wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ngDA699t5/fc5QduHkZKiFS/k/3T2h3U9SmqREeaQC8=;
        b=EwF60B/l9mZJpzJGJZnBU2A+KSsjXUG1AqFBedf/P2o5w4u1/WUnMd0efEPzPiLam6
         L/jm6MYM2jdnPE0YTocZTRsDFKEVgzBbYhp6PtY8VR07T3HAARdAuZWK1hUjDIoDe28+
         T6bbCs7cSWTv9KEDLjmFpfVyfln1zPfNBb5ZQb/Sk5CSTMgZb9wD5a42Wk4Tw27fVma6
         avE4d0fO7fFMvwUfk7ica7EVUV4GL4p42TLDbYwUfJA+E4idiVkmBhXKPlcgXj6m4eQ/
         H+/UKWNr2bWcbyUWe6I70FbQ9VGSnql+N/wDcFaxYkKCeGqhw+lka+BnZfO/q3paUske
         mqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ngDA699t5/fc5QduHkZKiFS/k/3T2h3U9SmqREeaQC8=;
        b=iRWsEtwabc8V8XuQLhNdLxK1SssZozecL/Hn4trQwknQCvqIcvBWZ9Yry990zK2YkT
         LDKbS2grF7b1sU2JE2Gy+4FC3C8Bx6ucEHIfx5gtXaRvOKda5DhagsjBOTGQgka0A2lw
         8GwW6sD926Xv3nbNrICazJJL3D+p1dwFVR9LBBV90BvR7301miemPP6u7p6/OX/qcGQo
         jCO8yeFBJr7rsU4DfWttDxWnXnLRjK0wEGzgR4SAuwXv9+LX/aYGG2TtPJNTu/skSxmL
         lEYrBQJ8cw6WAicdvNmfAmQu+nYeUZOSZW6wnTc/aH32m1ZRJ1b5yX0Ogs6Tjk30q184
         oYzA==
X-Gm-Message-State: AJIora83wXqSNw8Cuk863ABvzkEELBadaLRNJ3lInsBrrqeog1Xv1D8w
        XbWidS0hMRCv+/xkR2tFEmV7/9Q5zVOQ0A==
X-Google-Smtp-Source: AGRyM1siz0Ka9wHj2W241rzTLbDqYnBffqpYaxLsXFtJt4T+7WAAcQIRqmlunFrS2dOu15E4kiGp3A==
X-Received: by 2002:adf:e5d2:0:b0:21b:bfd5:cacd with SMTP id a18-20020adfe5d2000000b0021bbfd5cacdmr9494249wrn.474.1656322044400;
        Mon, 27 Jun 2022 02:27:24 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b0021bc663ed67sm4482700wri.56.2022.06.27.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:27:23 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:27:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 05/11] mfd: intel_soc_pmic_bxtwc: Extend use of
 temporary variable for struct device
Message-ID: <Yrl3+uKSgPvjvGTu@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-5-andriy.shevchenko@linux.intel.com>
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

> Extend use of temporary variable for struct device to make code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
