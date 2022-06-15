Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8522654D3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345716AbiFOVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245376AbiFOVnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:43:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF9631227
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:43:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so3386496pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WcjULP+xvRapFxRv0FaC6VPZV20BCthIO92kKFiQ9M0=;
        b=B0XNk6D8/gn8a9uQq6IA6wE3unW212NQNc1cQ7qD+JTjkn1rfYHx6zE0/3HjpiSkCg
         rkBrcV1VIEFW9BDgH3rI+yyJ6H0DNqc3yHSSy0SNBw1dCOMt9z1F/Hgek1me+rIr27IE
         +jrW4QVidiYd361KRdfwHeez+SO0MONybOf4004hnfcLT3P/4gmT7iEXkX+NbONX7xA2
         OR9FbegnF4PL9LZziDzPQaCytJfqj74oN6cEQh9iZhqlnVBBtZg6f2ZbL1G0sU3urVF/
         w9RbvMqy0gH+GAbxBRWj+9CAz9L2SnU2UMjZFVJsJP6QagspO5iu1laFW7/rvX4OhhJ8
         cZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WcjULP+xvRapFxRv0FaC6VPZV20BCthIO92kKFiQ9M0=;
        b=xJCrR9CE/V6HeGWE8Y12CAj2aduh0YOzMsPUMkS7Jc2tbZaDZfLSEO7xvabGvJW8ie
         6Z6CuZ1vVO7+swci/sr3Yynn0xsvyPN7SqjIPPqyiiU8KIJlQbkpApGxchTVMOKEADSi
         Th+RuVeig0pJ/Ak7tQo1JigU1Z1mNRPOerPEdGXYExCSD8MVjQ7Y8DM77BwGOzYtd5sA
         qBXQZ60C2b5xLb6Cf5ytm2dS1hHpWhHY8JU8U5qG+6pTGPPqusB2rRzd+ZYKHKgu90JN
         F7NovtQSRG7iKs294epq7Q+FeXjxXbczA4rw1Az0CaH/ihvNcSuLyMXFa5NzSmP5Dstw
         6c7Q==
X-Gm-Message-State: AJIora8MJMM8wd+hUOUPLZaAaAi4/10b1CI2Rz2dHebMbaTajvOZO6Ex
        +bqlCxwB2Pmv7WhVpwdtY2BIyQ==
X-Google-Smtp-Source: AGRyM1vjV11bUqYxz/GH9vFdp7a7E9IJbTAEzFfMt7oHG+sL5zQpKHckTKh0WHupOxdErb81fpFqeQ==
X-Received: by 2002:a17:903:28c:b0:167:6127:ed99 with SMTP id j12-20020a170903028c00b001676127ed99mr1369342plr.94.1655329382784;
        Wed, 15 Jun 2022 14:43:02 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7948f000000b0050dc7628178sm111221pfk.82.2022.06.15.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:43:02 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:43:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entry for max77693 dt after
 merge conflict mess-up
Message-ID: <YqpSZPr0a1raTRm6@google.com>
References: <20220601073511.15721-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601073511.15721-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2022, Lukas Bulwahn wrote:

> Commit b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to
> dtschema") converts max77693.txt to maxim,max77693.yaml and adjusts the
> file entry in MAINTAINERS accordingly.
> 
> Unfortunately, the merge commit afb67df31a8c ("Merge branches [...] into
> ibs-for-mfd-merged") resolves some conflict in MAINTAINERS in such a way
> that the file entry for the converted text file max77693.txt, removed in
> the commit above, is added back into MAINTAINERS.
> 
> Remove the file entry to this converted text file in MAXIM PMIC AND MUIC
> DRIVERS FOR EXYNOS BASED BOARDS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Lee, please pick this minor non-urgent clean-up patch. Thanks.
> 
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
