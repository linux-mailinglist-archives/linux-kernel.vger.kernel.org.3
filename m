Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347445796C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiGSJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiGSJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:55:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C5A2635
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:55:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e15so15530734wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pE7C5CD9QamlKASIwAJB2oFosm0oC32ktD2XTfPoUNc=;
        b=YgAn1ixv74RxyLG7/A2X2r8blmWYVjEjxGbX1vHCS4rs/D1m+Jma66PGJWKvAH9p7v
         OSqe9L3q3cwi+1MxVp4qttTiedFpKo6cdsrK1I7vEqJn7xbHJM9q6EUDtq/qx9DC1Yx0
         /mpuYfmf35FVKQiPBwCSvPjJYb/LhKe4vw7GnMPUc9OCqLuhBvenE53HcigUhYJaNGR/
         wdKkQ7NVBUHna6wf/OblYV00dv7zr0dmOKv/DNn1DqVEApvaA/GIvC3I+bFXCjcvBi/I
         EnNEnRD871SiTR3qOHt3cx+0E5MgQYg5DL6eiXsu2+KNjJfz3CCg3N/aIrMeRn2LS6nc
         GFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pE7C5CD9QamlKASIwAJB2oFosm0oC32ktD2XTfPoUNc=;
        b=CHbaYpUggfsJLtuZ5XlickZTlTKQWR2Tp5WafxKmRp8l11YCQJya1EObFQvh7EdEG9
         GtYd2V3MTPyyByiMidBWSAHitCrgYQAyLrDaQ/OlTXlpUmWwjh1zAgwUcdTTACXKaWue
         PhxsjhsAtoq8MM5fmgq+JREy7uPLcZYVHMmMH6XODDLiL/gdRwkVCYOB6ArJb9BobwHg
         vfcMq0Tc1qFA9mHlmZvFvobsAGaEPd5NycBRrs2+mgqaTEwhb/LQfSAJjnWhd3LuPtNe
         0Ze+o68uQUnUrpSX53iFboEzvUsTcix13lGSCnPzgcvxbSuEWhnVBUWF+Wxr/jxjEVSJ
         /8HA==
X-Gm-Message-State: AJIora+y16FR62Zpq5RXOceVa9Po81lb61w9wbTcSOo0D6+4RRnMZd0x
        5nvwvJnM0z2FXsmTMWpVB7Dj//GmV4LMBQ==
X-Google-Smtp-Source: AGRyM1tSyEk0a/Ktm5gie0z8QmHZ+IOiv8g0gaoE2+zRXJmYHG1WNNI2hwMK9Yen5xEzhdocDun4oA==
X-Received: by 2002:adf:e84c:0:b0:21d:83ed:2ce with SMTP id d12-20020adfe84c000000b0021d83ed02cemr25624129wrn.582.1658224506022;
        Tue, 19 Jul 2022 02:55:06 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe84d000000b0020fcaba73bcsm12851199wrn.104.2022.07.19.02.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:55:05 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:55:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] MAINTAINERS: Use Lee Jones' kernel.org address for
 MFD submissions
Message-ID: <YtZ/d02sX4MWgLbt@google.com>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-2-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714112533.539910-2-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, Lee Jones wrote:

> Going forward, I'll be using my kernel.org for upstream work.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
