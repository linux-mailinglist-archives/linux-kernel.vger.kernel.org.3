Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028555D10A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiF0NYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiF0NYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:24:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A790C63AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:24:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so13057529wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=byIxRMuOa27jOrS24MLlEP5RbxFs2hCniyYjzuga7zE=;
        b=UsQIz9AwLFXRZW/611PWA1TGLx/EKjLMG49oOIENwVNA2HfgrdVmjiLA5LE2c44YcD
         8YPlFS2VPog7acW4tS5hrnzECgBp1K+mIZYro2lnBvlDA50dmbuWCkD7jAFL/+JdM663
         Gp7F008ZJoiY8Tjm8JBzHOXFvAEcikK+Hdm0Yjg3ETxhDdzGVUnePuBHBHAzahstZ2pD
         et8PHflKitsdu8eIQidHvcOIJP7QCt8GDtsPGCsX4Id8WHEjH9Ga5CPJbo+fenF0DMlI
         iePtg3KStyqufLeK6JpXhVQKY82V1o4wVcWAh1a9MYwQvqPPa3pKeU2mJAr+P39mziVL
         jnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=byIxRMuOa27jOrS24MLlEP5RbxFs2hCniyYjzuga7zE=;
        b=6FS4XM4M3iAaLmiDzttkVMYfDp1p3Jay4fDar/d7qr25YSXblJC3igVHlA8VSUrU33
         ASPqsR5waEfxI48FsLwsC97iArCOmaCkXaIbRA/xaabRwPc+uDUWlGwd2nzswpJkN7yx
         e2Dz2Cv3vAUt98LSPKifHOylYPiSnQXuoR/6CdTTT7Fouu+QT4d3qGRwzWoXvGlRgsL2
         YPNdXfTEYRqULmc0hxlH5mMWTpYOAH19iQuAQLL4PgcXuTxUGY8EtupxlGCE/bapW7V3
         gBZAtrEm4lvy/bWSwuALnif0SmJriY8VNxdTpnbs/tFipC/RvUn4oRdryutiVQYnwd0l
         228w==
X-Gm-Message-State: AJIora/q/KN9j6mBbuKTu7rfq6XNu4MxCMAbsJeWPGSlq2/VoIziDKqJ
        WV0SO72U4o39zQkhS2UKx21wSg==
X-Google-Smtp-Source: AGRyM1vZAkSBZxxD6y10J1gQ4scZoSfBKuXC2K439nhICMoqoFaJ0bjNcd9Bqjo6KW0lp3JI4jTvZg==
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id n14-20020a5d598e000000b00219ea165a2amr12038693wri.343.1656336289239;
        Mon, 27 Jun 2022 06:24:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003942a244f40sm18232984wmq.25.2022.06.27.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:24:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:24:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 3/9] mfd: intel_soc_pmic_crc: Use
 devm_regmap_add_irq_chip()
Message-ID: <Yrmvny2YaF/IIFnX@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-3-andriy.shevchenko@linux.intel.com>
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

> Use devm_regmap_add_irq_chip() to simplify the code.
> 
> While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
> calling mfd_add_devices().
> 
> Note, the mfd_add_devices() left in non-devm variant here due to
> potentially increased churn while wrapping pwm_remove_table().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
