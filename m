Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735C55C70B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiF0NjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiF0NjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:39:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857CF2632
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:39:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so733358wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A2rpvdTdJky26gjxX0wluRuHNjBpznBQ1xsrTKGuRiY=;
        b=kYWrWYmuFgWQPrgKzLox1BngJgLIExXP9CaHuJesiYeTlxZT1HZ6OvOn8JXBkX7vU8
         3P1n4NSnyaMgPp3+8c/Ph8658Tf3g6osU8LqI084DKJE9OXidUsja5tuE8f6PXdZPBPq
         0IQ+Rgy9vwkN3C2kKHtfVrk6TYtLaWcJEEFNzl/dNDjCWT8Ehvgq9iWisTn4Sf1i6KG3
         Xr1zFV9A7zyJH0zKqsHUWyp9AFYj1wcb801K/1bNSXp8WC2d43bV3gXSSxlqqGNFrRaS
         O95SjZXOq5LT6enfnrdTlyiOmt6qJiPIHfyfQSNTVHWYNfvCdLUVYM9ZGSdSgUbY09ED
         0u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A2rpvdTdJky26gjxX0wluRuHNjBpznBQ1xsrTKGuRiY=;
        b=CgAFjAW2sLrk813yL5R3ECVHcUz0k8zXMaVjgchT4c8leS6bxo7u+z0hPQ99lsMeTa
         CZqPcSplwHF514AwbtzhQmjO9AKJmCxSNS1m5k+/TlZzSXSXOCgjLOb8R9pdsrucZ0Xu
         Dvyw7acPgN3A1IZKg196yTkhEBsbzJpsY5K0AjUjRMl0f3f/QFTgpQUuet0ZA+m4juvn
         g6MzZi572TELKkV6AYsJFKXuNg1BsYxLACjO8QWh50vQ+rjRW8bQYzVjUtG50UuHB14u
         Og7cBYEGnG4t7kFG7182q9ksNdZfxs+cm6ci0F/8fkQc1Ag9QzHc285Drqdtt6h7lvDy
         Cd3A==
X-Gm-Message-State: AJIora//iB/+tJqLvUuBex+9BUfCnKZgJJ8unATErw/q2t62FuRsUuE3
        KmL4kLw9gzO92KZp+Ll/p1xXgA6398Q5CQ==
X-Google-Smtp-Source: AGRyM1sMQjhIbSaVz08xa6KLJWDsUxHu+zWE7lpsNUzkKnVT0e73zTMwhlQuatwI5VcI3SvwY1O0tA==
X-Received: by 2002:a5d:6da3:0:b0:21b:aaf5:b814 with SMTP id u3-20020a5d6da3000000b0021baaf5b814mr12161489wrs.140.1656337159092;
        Mon, 27 Jun 2022 06:39:19 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0021b9e8d4c22sm10621650wrw.61.2022.06.27.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:39:18 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:39:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 5/9] mfd: intel_soc_pmic_crc: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <YrmzBCSTizn8Z8XK@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-5-andriy.shevchenko@linux.intel.com>
 <YrmwBxjN9lCgS01X@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrmwBxjN9lCgS01X@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022, Lee Jones wrote:

> On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less error prone than the
> > use of #ifdef based kernel configuration guards.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_crc.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Applied, thanks.

Sorry, wrong key combo - long day:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
