Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDB58CB37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbiHHPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbiHHPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:22:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8513F13
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:22:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so11247166wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zNxXh1vvfWAJWRK0y4gc/R2W3M4fjH1jkRI23lt05qY=;
        b=ZVWN1FsWdQ1MY5bGk6ibvIVJfwQtrc9IPbpZPa/ZF0GlhLjx40vDIZeW0U7UOnXZJ9
         CCupSlS1iGSLTKZEOdA6zZT/2fUxyc2q9N4Y8ISuVuqEaqAeHyqlSbdgHtpXY6eWmdT9
         4GgABhC4mT+XTUMvvcB7s8gxkN6Kfssj1+yPEe8EL7JPeLnVtN0T/n4yvDr5/fs9WYX1
         7WZZnwiGqoiGxB+LV76nmDjmthlV45mLYoA1akXGmATqApncUEtvYMKV9rdOqNKqORlM
         ZD24flG6biZG5xe/OTXkJzZ5eeWZXIDKWbmMqj5mylgCs3Ll1hHE0q1dvF0npUU8FxTI
         HJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zNxXh1vvfWAJWRK0y4gc/R2W3M4fjH1jkRI23lt05qY=;
        b=MphXVNoOY3QB1OXx8oRDSgF7EQ0y76KQaV5YeCz5Cugivw9extWuOisSIFec9RG0ZA
         jfHpvfUH3eROyJHmq3OA36Wl/kuv2ZIR0Y9HWTdVZoRNGB/ghjCi+VcaT4RGxNy518+R
         2aKNfB44WeuTOYj4NCy4bZaDINEbL1saZPr9YwuLGxHU3ffvaDgNVGMnE+yNyYo8WhnW
         bADhQQN9P2VZcg51pu6aNXhI9/HprwHd0rq+equ41GqNcyEqqS9QOKocrvHkhDTsPcK8
         oq4XhV3IaqyD/B1b5bP7/GNOPCZQxUbuuyqbte8Sib4T8xnvQl1XMvJ9MIh4d/2WNZMF
         HV4A==
X-Gm-Message-State: ACgBeo1etsOf6HuYWv4FCxp2+kzkFY2tN1xIloVrn5d5sgfC9ojDD5NH
        L5uJtgujBARiWYjvj3eO6WQQhL0Nf1TnCA==
X-Google-Smtp-Source: AA6agR66GsyQ3Kj6SYcCyBWHXk++W+RxCFUkzuUC2DPRwWxlKe+ndU9Wfko80VbBbE6lcKjIg0KzGQ==
X-Received: by 2002:a05:6000:1210:b0:21f:10cc:4e61 with SMTP id e16-20020a056000121000b0021f10cc4e61mr12115572wrx.497.1659972120865;
        Mon, 08 Aug 2022 08:22:00 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b002206261cb6esm11469722wrx.66.2022.08.08.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:22:00 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:21:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee@kernel.org>
Subject: Re: [RESEND][PATCH v1 1/9] mfd: intel_soc_pmic_crc: Use
 devm_regmap_add_irq_chip()
Message-ID: <YvEqFguuc4JMijJk@google.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Andy Shevchenko wrote:

> Use devm_regmap_add_irq_chip() to simplify the code.
> 
> While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
> calling mfd_add_devices().
> 
> Note, the mfd_add_devices() left in non-devm variant here due to
> potentially increased churn while wrapping pwm_remove_table().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)

Doesn't apply, please rebase the set (probably on -next).

-- 
DEPRECATED: Please use lee@kernel.org
