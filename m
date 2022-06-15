Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0654D358
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbiFOVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbiFOVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:09:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8E3C4AF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:09:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u18so11448507plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QFuhArAfANMedQjjGx66q4XCKo0Im4HDTOF7aCn3jjc=;
        b=tOoUDX9/i8vFknjF2otOGCt2/PBmpZETMDvFFj4tBKJiXEYR+jYq4VQzSF/mM7u2dd
         4TatBpwKy6wFZFp4drcN0kY1Lwg5Gql3qyUrbU+3EVdbZrDz4oRfwfNqOPPPGADl0NdH
         yC2cCVqTmNHm6hNfpdn/GOGBa1qTzLTH9FZxRygA0t9jj71Kld9tTYuBdUM26nh7k6Jm
         GcRjjflXO4l2hLo9doFkNcilIPKvRugdnEzWVApupDNRbhxR/M433dZUXHRwpFFODpmg
         OHfNfQvWyrN5LgCqeduxgqqZhHm6Qe7R4e8T19I/u8hM2p29C/N/VlyGCqXIqoa+Km46
         tfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QFuhArAfANMedQjjGx66q4XCKo0Im4HDTOF7aCn3jjc=;
        b=s7gQX1U2ad5ymzY3WH8Ols+OP//Ejeiy5tXExgqBYYQoMf6zZB0YRfwdcTshuVwdMg
         965lGrEbGE/T8655a0QLzl5//eHAhqRJ1Re68gwLh9KKIxFgP5V9Bjwepwmxk0YbcbcB
         Q96ox3ZFuhQXTbf54CEvkPvrHRkr0Jv797Fg0l0vVSpik6D5QUS8a0+5VsesIMJB9kjV
         nEhidTBfQsidkCi8psGycXAtxNdTQbvSflCsp/+tmizTrGoIO35VD+XdjaObc0qtVt4/
         DOsNYSqb+VNNb+DdDpNFicn860ZeBePpH6Qa1vOzamMY/hMUKGpO9C5PKhJm8Rykqjt+
         Qpzw==
X-Gm-Message-State: AJIora8CcQG5JdQWbiMYfR6HIcFlt2MsuXBmxSEjRVMUKZ9CimGunpif
        rSL4V2a6em8t5ZTo9GCOBmZkf/i0DBEBzKwQ
X-Google-Smtp-Source: AGRyM1tGgSbytyvKH1O6+ffXrY5hkMdPV7TXW9LIXpBtlugQie+7PDy6Z1zPC3zP/nGr/tQqnGZ7MA==
X-Received: by 2002:a17:90b:3e88:b0:1e8:875e:366f with SMTP id rj8-20020a17090b3e8800b001e8875e366fmr12279645pjb.155.1655327359489;
        Wed, 15 Jun 2022 14:09:19 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a004100b001e2fade86c1sm2288742pjb.2.2022.06.15.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:09:19 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:09:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] syscon: Use %pa to format the variable of
 resource_size_t type
Message-ID: <YqpKff3ZAqmsRPNz@google.com>
References: <20220531202404.70282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531202404.70282-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022, Andy Shevchenko wrote:

> Instead of explicit casting, use %pa specifier to format
> the variable of resource_size_t type.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/syscon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
