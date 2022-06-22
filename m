Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0ED554841
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357462AbiFVL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiFVL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:58:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD03CA6B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:58:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so20788332edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+hoDgmECCxkmEuLXgBpfFKs4eUitUbbxSUfe43Rhe54=;
        b=C+NroklpGh0nlubI+1ZeSqpfsLNzxb/G87D1tEFno3abaQT9GtucS9KDGd/I33ABE9
         B9rvOtees8v8+IHbiU5niiqIqxJ/XsZI+EN5IuNZjMBKaHMCft6W2iOiWM0JHhBVjKzN
         YHIk1ymllRhQooe5avdb1htIEaJDS4e6o7zQ47bl3mEaNvYOoAGMIFg0TNPOpXj6fNCF
         b4mt/VsMqMCslwz9Iw+OrjyyEba9dG9ZWJQXpQNsaWLsfc3+JShLJV+Y7fZS0sSe5aWN
         M+pU75P2Km9lx5B8DOm5BtfByPt89QbqZfxrnqoRJB3hBOCwQjwEx7W1MMn76MXpoLYP
         6aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hoDgmECCxkmEuLXgBpfFKs4eUitUbbxSUfe43Rhe54=;
        b=6eoJb/EoTA88Eqy/CcHAmPXNJR3nz3JNyYDwPhhUzC97d+aws+0ovLzjWGB2W1KDSy
         ZNFf66H0vNT0UKNdiVVMpBHRxh6SyQL4OMRyMfGv71bqDb+RPX0yhSkGwnbJt++/XZBG
         xChutzslJj/Ff+MBaqcDqkEcJ7Y88eTh0j0UoZ0EM+VT7sJP19ddHLekzg1Nyp0PHlf8
         id/sC+832212Z0Hn3JS6FgBx7x7gsoC2btL8TYRUYa44BWqjBJ6GhfC5HRFE704jk9jQ
         UVnYmhvwD48P62V8pfPoJtXG9j+0HSFcA9NpK+kMCtUVfUe8knZnSncej1RSqDvftR8Y
         FGzg==
X-Gm-Message-State: AJIora+35Nzq1JD0ZxmPj1+9B9gkKGs7LdYl6x6Iis77V3ujpR7Wsv5R
        kdzPl2uylrm9636Kv45Bb4BAKQ==
X-Google-Smtp-Source: AGRyM1sV0n+kFPrHjo7J9mlB5BlTGLwd6/VlnulPgYV6wcLDYSE4OUHrGe0vlIYlpXI7KIin0ABbDw==
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id eh13-20020a0564020f8d00b004356df2068amr3762502edb.209.1655899133972;
        Wed, 22 Jun 2022 04:58:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qw21-20020a1709066a1500b0070c4abe4706sm1746212ejc.158.2022.06.22.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:58:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, robh+dt@kernel.org,
        pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com,
        jacek.anaszewski@gmail.com
Subject: Re: (subset) [PATCH v2 2/3] ARM: dts: exynos: align aat1290 flash LED node with bindings in Galaxy S3
Date:   Wed, 22 Jun 2022 13:58:49 +0200
Message-Id: <165589912782.8422.17803439134103733138.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620175033.130468-3-krzysztof.kozlowski@linaro.org>
References: <20220620175033.130468-1-krzysztof.kozlowski@linaro.org> <20220620175033.130468-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 19:50:32 +0200, Krzysztof Kozlowski wrote:
> The bindings expect aat1290 flash LED child node to be named "led".
> 
> 

Applied, thanks!

[2/3] ARM: dts: exynos: align aat1290 flash LED node with bindings in Galaxy S3
      https://git.kernel.org/krzk/linux/c/efbf2c262c89f78f99fd781c77b7305fac23c3c7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
