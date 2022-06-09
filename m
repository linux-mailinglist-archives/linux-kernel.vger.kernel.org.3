Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B0545439
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiFISgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiFISgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:36:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B4A1124EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:36:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o10so32318921edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS0F0xF44OrhpUzHcgWnaO9zl27M85PA7+iC6oDvwFw=;
        b=rlTa6JN50cfUP58MF2NDKCooR6wx3jnlIhPVbuevnucd9ATK9w5/z+fQnm8yY2mtcY
         nfwMil61CNgqvNWqJu9GSTc5lSQzqYwCN1YmGBFzWgs3V4YO4EzL0LrMFvy0dbJcy3Bq
         pnXDjGOFQH50qAT9ZurXc/KDLgrGb/lXtiStkTUEfBdSEcInz3nrGxtv5/yBsYIfFePW
         C8M5mkZsbcy/SNNtLF8uNKWyn6eEEvJgiGXV19MU8fDFyJn0z3Gc0rrrDAr/6Sr3R6nn
         mvH/nuQFckTFG5HXwHv2FgQpT3F5d/+sN9XA3//31z5fUsUEOPPToZQJLLL2BHqmI2Lj
         afzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS0F0xF44OrhpUzHcgWnaO9zl27M85PA7+iC6oDvwFw=;
        b=zE7+VlsyJsjyLAvNYLXxdPqSAfZr2GsUeevtOzkEsEhJIvR1Kh5Yg152whTuDOCPWx
         S439WzhL40U3e+FERaBsRWYjeUvVsLv+KFr7YaDCXrLLkTUbAyTZ+ERykXEobafcUb4Y
         RK+HfADSLa7YbRuE+z9B0wjwtRURm0wGFa5or6cZwedEpZckt2Avs795CbpcYGqPWUjx
         KXOFKp6dvZ4D2OpLb/edpWBWmCH9UkNrlNFCwqbPXvoRCOI3011cx/IDzxkYf+kj5zZg
         Wse2BRhs5RYoYEIFTk0Op/6eyhzyEp8Td3+CCaBOj6Ui9Z78NiKO0Bca8rCxyagDhign
         phQQ==
X-Gm-Message-State: AOAM532a1bckFBU88HWK1etPgU4juw9pyiRG3iZFw4rq679pX8tTBuk3
        y+JDP7HBNsowL4LHQSkFAOpIEQ==
X-Google-Smtp-Source: ABdhPJzrhVsIuBb+GPyUZxwF0QC0jZZbwdDB1H5ULrMozR25WAWgwaMGfFKg36D6Mf7ZN/pGDvkLhQ==
X-Received: by 2002:a05:6402:32a6:b0:42d:ed8b:3d8 with SMTP id f38-20020a05640232a600b0042ded8b03d8mr46204738eda.225.1654799776873;
        Thu, 09 Jun 2022 11:36:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm11000545ejc.197.2022.06.09.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:36:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 v3] ARM: s3c: Kconfig: Style cleanups
Date:   Thu,  9 Jun 2022 20:36:12 +0200
Message-Id: <165479976638.441878.1537054219489252757.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609082154.115301-1-juerg.haefliger@canonical.com>
References: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org> <20220609082154.115301-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 10:21:51 +0200, Juerg Haefliger wrote:
> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
> 
> While at it, add missing trailing comments to endif statements and replace
> tabs before comments with whitespaces (which seems to be more common).
> 
> [...]

Applied, thanks!

[1/3] ARM: s3c: Kconfig: Fix indentation
      https://git.kernel.org/krzk/linux/c/1afde294a99d3dd2a2aa4e28d15590755927f66e
[2/3] ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
      https://git.kernel.org/krzk/linux/c/48bf4b8497419f5b9a29da19c72e00dc2b8d498c
[3/3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
      https://git.kernel.org/krzk/linux/c/d1065293010a010261f0b1478daff40d5a3dc241

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
