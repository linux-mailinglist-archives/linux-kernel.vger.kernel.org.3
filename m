Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD04FA9BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiDIQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbiDIQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:54:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBCDFFB0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:52:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc2so2396487ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPCpRLMafl4W/IlVxBjo7dtIzbIUznmlplI2v7Gu31g=;
        b=OPT5JzOx2fwcy9VSQ0l1ROxLox8eg3/G+5NcV5eE5z4LfNHu+vZDVmxVSPfCnjTVWD
         cxRRqV0TCr0jF8xtO2LweuRdkpk2naUd4uM/KB/u7yCtYnqo8jN5HFJdilBC4fbhEDxr
         S/g7nlazX2+Uxg/xxqgeAfwiErumzra3TVOVDb1gLOfTYndflx/MsWVv8rUhqCtuGwfB
         wL/lGmEpFxW/AmDlaKXK+cbEKcW3wgxgBp+aQxCFrA+/2eei8WTOdMOkt84iA4m43NxT
         odsRFWurBB0kDqs2mjWhzbbyMvMwCidCuCyCculFfCxRrJjxWft/flppe18YQuucfEIY
         UL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPCpRLMafl4W/IlVxBjo7dtIzbIUznmlplI2v7Gu31g=;
        b=k0nFDglW+JdOCSIKm1VUzTuMK8allXSGobmtGba6vu0625RC+eWcr206vWJp+mAnZ+
         MjeUzGlXaM/8CdsMZfDulyHypMbMvEPXjF6YOiE8qgONw5vYbhZ2ffG2PuXZ7d8PW+Rj
         gsMA1YNSCAO73hTgupqOtVg9/GPPEIEnrccMhzd5K8MReSE8W2NJUS8z8o2c8jGd1bjy
         aCTCnpD443LZR1xZW+XbQtSGo2p0TgCAuEN18jPEnI+k6PIhz6teSlZGpTEMWE68ZVqX
         q248HJs1kAxNooPyBc0ofhK+mRlF2lqTM5176wYuTVsO5SJfSL+8G2xIg1AtjPzJHJK8
         TQVg==
X-Gm-Message-State: AOAM532y87Y9KDS/tH9c82798fnR+lkpeyevPVelx6mmu2xU30I0LLVW
        qKsZKDohARa/GsyDXiJeLnjn2g==
X-Google-Smtp-Source: ABdhPJznsOg3HL6c+Ur+PZxcu3Z6Q3fCmW7cw5Oy8nvw5G70mq8IPVQthLWtmjnISl7uKlnPIJpMFA==
X-Received: by 2002:a17:906:4789:b0:6e8:7ab7:e843 with SMTP id cw9-20020a170906478900b006e87ab7e843mr1315788ejc.374.1649523141431;
        Sat, 09 Apr 2022 09:52:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g2-20020a50bf42000000b0041cc5233252sm8947630edk.57.2022.04.09.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 09:52:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     krzk@kernel.org, alim.akhtar@samsung.com,
        Jonathan Bakker <xc-racer2@live.ca>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ARM: dts: s5pv210: Bugfixes, features, and improvements
Date:   Sat,  9 Apr 2022 18:52:19 +0200
Message-Id: <164952313432.108518.3346102412412022215.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CY4PR04MB056763D8667AD2BC418B7026CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com> <CY4PR04MB056763D8667AD2BC418B7026CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
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

On Sun, 27 Mar 2022 11:08:49 -0700, Jonathan Bakker wrote:
> Various cleanups to fix warnings when running make dtbs_check are included,
> as are bugfixes for the panel CS pin and bluetooth interrupt name on Aries.
> 
> Changes in v2:
> - Re-ordered patches to include bugfixes at start
> - CC Stable where appropriate
> - Drop sound-dai-cells changes
> - Drop charger-manager and related changes
> - Adjust memory reg entries commit to retain one node per device
> 
> [...]

Applied, thanks!

[1/5] ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries
      commit: 096f58507374e1293a9e9cff8a1ccd5f37780a20
[2/5] ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
      commit: 3f5e3d3a8b895c8a11da8b0063ba2022dd9e2045
[3/5] ARM: dts: s5pv210: Adjust memory reg entries to match spec
      commit: 9576ec12261c4b639cd802fd9c13e3c9605165da
[4/5] ARM: dts: s5pv210: Adjust DMA node names to match spec
      commit: 21e4b7d151af9a3191fb251e2b4044e361a56102
[5/5] ARM: dts: s5pv210: align DMA channels with dtschema
      commit: 9e916fb9bc3d16066286f19fc9c51d26a6aec6bd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
