Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F95619BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiF3L6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3L6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:58:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5F4F1AE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:58:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p136so27108345ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coK/MbX/enOsaX8BnFGLPtPtBRhl8khyvGOH95Tymr0=;
        b=AUomWiIGZJZMHxCZWS1uH5W+AXDmuBT6OpW6D+WtW373gVN46f3tf3j8RLCJbk+TLL
         DQqfZlScCYgRqwLltcQI9iu6NBK70UH1DCZcpWy87UEqKYYX/8I9idY1paWwB8K3Xo4+
         7lOaRSot7beuwTNoV2QAsCepjnsBMA+XjlVzMtc2rc04bRDUk3eEOrN4q4UwlV0QCRnz
         dtodRYcfOx+0oxuKlG3ABFdo9YkNlHUdygrNs6ViWOoVVp3nrFEkl30nnXMOWWNey0cD
         ie21f4JAhNBKGPPLthZdCNhYD5/MXAYy36kdIHSyMLMm49AZf4MrUoLMqsji5it1yR3e
         bjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coK/MbX/enOsaX8BnFGLPtPtBRhl8khyvGOH95Tymr0=;
        b=L7q1w3EvOGVz+mtWZ9F2kfhdAhucAcBl17YSekREtZUDLmmqeJd0+6Ix+SzTH7pl6d
         fV9551bBu3q6H28l8H4Z+4nvWPWdtP15JuMVaOtBYUfIW0BRVzQGQIojN4i/DdV63bL3
         V+C0M2JKjPAaN/t8/oNuvl13B9wmgTMdq1gJMVxlMqfBlW7QkbTXaY6vzPRr4TdU9J5V
         e9mCHftaBrgnHX0HF8X07hrDbD9+KlbuwEIedz/ITjZ0U8eU3bnlPwaibZnPwVwwknNH
         MJ4VUKwWwkjXTGu1be2Ivij+mIjUBGQ2z6SFz5GCgaKZ50DZX/aipNauk0YL9QQoFj8p
         HNqg==
X-Gm-Message-State: AJIora8Bok3qpi5zqcDX6ZuGHLUWjNWBfZrpM/AxB0wyyJ0fdN0yLOrB
        SNFifp1rV7N0v2mGL9pYTlQ/d+8E0Pwa5rUBH1RtTg==
X-Google-Smtp-Source: AGRyM1vD00idhdvt9Rct9elxCcZK0vEkpuiitShjjmWgIAOfrEZL9b1pcCOrGsTgaOsz9jHcxv6vhv8elx2Zm3tUrBc=
X-Received: by 2002:a25:e7d4:0:b0:66c:899b:49c6 with SMTP id
 e203-20020a25e7d4000000b0066c899b49c6mr9546206ybh.291.1656590313452; Thu, 30
 Jun 2022 04:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com> <20220628193906.36350-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220628193906.36350-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Jun 2022 13:58:22 +0200
Message-ID: <CACRpkdbW0dR9hpSXcLgHdfG7n4Ec_NLdipN6=5MRca9Y2E1sKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: adp5588: Do not use defined value for driver
 name and compatible
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's wrong to use defined string literal for three semantically different
> cases, i.e.:
> 1) compatible string, which is part of ABI and has to have specific format;
> 2) I2C ID, which is user space visible and also ABI;
> 3) driver name, that can be changed.
>
> Drop the define and use appropriate string literals in place.
>
> While at it, drop comma at terminator entry of OF ID table.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
