Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFD55C806
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiF0JQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiF0JQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559563893
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eo8so12106789edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1j2L2IcfKUdxDZ6ZLKtNV5PaauRccjj3l8jhcL2l6Q4=;
        b=zVAfnab2UJJUylY2PC7BEyRkDdK180II4QAdeLiBk5DTZC1isuskvsHpzxEyotxxmS
         DL+zyL/AsuaJP42CknJuLJ2jCUGx3GPTPePQP8VpEIRuRRbJq8Wt30ozMExvRUrPspti
         lrma2fpzEQUA/wMSvlKRcl2H00dE/LBz0LCWwkBsuWdfAlNHGBQ9VrV7M6rBGSl4wSDq
         ebhsKy/TaVmz96RWzLEoeiWG7X+ZPl8IpZH+oEQTWBpETm67ze+1j1ywzp4d6u8osGo5
         Ix/deX3wfzNwq7kIQ3piQNl/fMzD7gWD3s4MROydvY9bUr9U9fCgL+iR4n2I276QeSr7
         drGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1j2L2IcfKUdxDZ6ZLKtNV5PaauRccjj3l8jhcL2l6Q4=;
        b=cgqSBBrMGk7zZS6GrIjlWhNJRUaaTDpTjtkneqg2ZHj7hEt4cnJtP1nlN6/7yzJrR3
         Ld/l7nDe2xQZ/BDENv7030Ycy+FJBSh9OybFyqw1PfLo+wxtsl89wNKsEMGHSaSaBTqU
         ka7y2mo8+wlhcwfdhOT/z0I5paPtGQRu5oa9U40CIuHCcpYQuuvx3RnWxWT0Vs89uGiz
         p3flxBuU7kOae9r6QTdl9+4oX5x5sZpuhHtiYV1Zre1boYxuR7Cmfd6uUFBvORNtRP+6
         HtDcO/wuTkkokTQWkwz/KDvEnF8FBzpeax2KD0I7eCpjuPJ/YVsgAoXwpF2j5lMfb5D9
         R0sA==
X-Gm-Message-State: AJIora94KmFiXKUz26e8H6S8SR/16Oii+I0uBOprSsY8RncZreEkVVmG
        HMKBZqCBAUf1m7+SLfGVGQROzA==
X-Google-Smtp-Source: AGRyM1vJoCCbZTYDA6MQ+EUkv2LvZ9T2FY7i7QnZGQOzD+0NdcgiVuiRnGsJFo9uC0DXtF+5+wrJPQ==
X-Received: by 2002:aa7:c053:0:b0:437:8ef4:4857 with SMTP id k19-20020aa7c053000000b004378ef44857mr6428672edo.77.1656321368821;
        Mon, 27 Jun 2022 02:16:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jh80.chung@samsung.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH 3/5] ARM: dts: s3c64xx: align SDHCI node name with dtschema
Date:   Mon, 27 Jun 2022 11:15:44 +0200
Message-Id: <165632135507.81841.6507362158126641884.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-4-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 14:03:40 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects "mmc".
> 
> 

Applied, thanks!

[3/5] ARM: dts: s3c64xx: align SDHCI node name with dtschema
      https://git.kernel.org/krzk/linux/c/1b90ddb9d942bc75d468758fd2ad632137e733cf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
