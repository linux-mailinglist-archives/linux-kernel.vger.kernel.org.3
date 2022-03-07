Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A44D0224
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiCGOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiCGOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:55:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342A3BBFA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:54:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q20so7006823wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vnv/T0jtIsN6/gFrs/X2gg4CwShLcXUqKrzBTNpYqaQ=;
        b=PS+ggUAj/n2BR6SUJ3nS2pcJSAimRbrhrOKO+cR3qWhjJGEdBPC2/OQfY3Qy4AU/d/
         Kd9PIjcytkrxzzcTGB4FiMZcTwB8NgkyCczAOviXIrOTjbDvPpOjxS6z+YWAXzJrOIpY
         +/Y0LBV82jKsiEM6rrOews+0e1Z4evU56wYsC61a37P8A5zq4AgXAcQqMwIaX0sTrHKN
         V3JJvMhjNaAmRyLb4yJUFK8efCiVJ8PeIQFCXzugWCgejlxIAxtYyJYMikqPQE4M50+l
         3pWHbpmo2RfTaLXAyuDU/bzhOn9KE0MPa0/Hab6vvbjRNmTdPRAT1ixHH+jiktanW9Ic
         P9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vnv/T0jtIsN6/gFrs/X2gg4CwShLcXUqKrzBTNpYqaQ=;
        b=qHqsWyjr0X2IGi7X+Kq8NgIHSqr3AfNVG4kU1sSM1BWOOrI5tZFzJyRNdOQZz+bHty
         g+kumQ1Jo4Yi4/AdCaxurp3k10arrc4hvwwHOdtS9NbcQfHx2hKwVG8eYZMGjCESN2oq
         ibWWlChQOwbZpOdZJWTp1N7sEVOm0+yuH5OMiYe59B7d5uCxqwK0TMCUy6Mq43/Yx8vm
         UQjFhQOPRjMTE0qBnIY4lt2Ajr/mo1hYWffKI9PRfMB/ch3pnFsgwhjqJbszQxUtLNfc
         ikdu6N4KAjA4OnVl7G8e+QhWHUa49pj/flLuD6WPhGb28+6gkfa2mfavgmKkddulm2vZ
         QTag==
X-Gm-Message-State: AOAM531Kap3MCvJbiAr5fCzgzrydIBJKGtd1dTCc3PNrElP+lXwAh48H
        ayUYxZL6fhIWiEKfBQx3owRcjcYNPQWLKQ==
X-Google-Smtp-Source: ABdhPJzAeWe3VEXyIIxRTMHLSkAE8gpROG5jXFruV7JLNY57Qm1zLZG3hOTbUTnEPgc9wWDflMMLAQ==
X-Received: by 2002:a05:600c:216:b0:387:d3c0:8214 with SMTP id 22-20020a05600c021600b00387d3c08214mr9842987wmi.96.1646664870245;
        Mon, 07 Mar 2022 06:54:30 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm11384327wrx.47.2022.03.07.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:54:29 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:54:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the driver
Message-ID: <YiYcpDJZlmjMEEWw@google.com>
References: <20220301205056.79810-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301205056.79810-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022, Andy Shevchenko wrote:

> The SPI driver wants to know the exact type of the controller.
> Provide this information to it, hence it allows to fix the
> Intel Cannon Lake and others in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 41 ++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
