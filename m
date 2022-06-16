Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F7254EB99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbiFPUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378742AbiFPUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:48:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9122526
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r1so2176927plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PvNBoLjtwyqGasg8oAONvB3QXsGYBdqQcLxejz9Slz0=;
        b=VXzIxJw8CYUdXBMw5wmaF0i244wePBQmiLsUaXzNJAf86vnv6onUSyNtXhLHpcRgSY
         SHHVM3hpbGw7MzWCvvS0d/6anAzYfSZ7llsN5LAEnflq4I5q8ju2WsILgmdiwGx2DW3b
         SoT0zrNbHBzuhBA+z2Bz4hx73wJGzWDM71q3mR4aaDnBfnBG9mRhxMYJph7Vxl3Qx3e9
         rFtjXLrKZLi8WG7y2JjqTK4xXnsM25drnW9f9SDHNjpcHUeqcTqotqMfPLzRNplKlkeQ
         dyHo26zBRDDvDux3g2qQK0PXxwvrgo1QIrwLMBo76R2MDtgw7VRW4D7hb8jMuHvA9h84
         JJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvNBoLjtwyqGasg8oAONvB3QXsGYBdqQcLxejz9Slz0=;
        b=pj0Tpl7t8URBpnum8pSs6xBwMgxCHoyiqgj7lVo2gybT+PZ2wYgKmAJ9O91LrBpkEd
         oBnFuFSIEp3tWBkbzjpn0xlvEu4j9zTltCe3tWVGXh4Mk/JVlbCVfpjaSA3/HmMH1eY8
         R2ef8AQZUIaEqK6j/4KrHCPhrRlvBDO7MkjiUmtnMBH5YPHN/2NvyHvn2HYSZutAlfiF
         kv+WmkmRV+o26xGa6DnKYu6SYrxd7MeJJc6PzmGSvHB1gIgOENb6ArPM+grm/09d4jT9
         nsqk84wcHFRvpfNaeWgUAEdM1GXcSKvFVGvPdkDqdhfwijPMjR25PbR1lVKX7aLOkFT/
         kAyA==
X-Gm-Message-State: AJIora9zoYD6P3zIxQre4E+er4zxADt70vTpgDflHLY78JHwUlDGFTiU
        1F2crl6V6e7G0vqYDGU5lFHeYg==
X-Google-Smtp-Source: AGRyM1v99UUVEllYZLzQV3c27yoAr72BMNVlEAEpQw5GxHlGFH9dWW1AYHbX3+OLKa/1tQmQOpeekQ==
X-Received: by 2002:a17:902:ef94:b0:168:a730:4abd with SMTP id iz20-20020a170902ef9400b00168a7304abdmr6290135plb.152.1655412478506;
        Thu, 16 Jun 2022 13:47:58 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: lpc: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:19 -0700
Message-Id: <165541242280.9040.6334571802807277520.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203732.831250-1-krzysztof.kozlowski@linaro.org>
References: <20220526203732.831250-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:37:32 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: lpc: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/468aaf56bd5fbd65686320121a6bcf6970ec3b10

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
