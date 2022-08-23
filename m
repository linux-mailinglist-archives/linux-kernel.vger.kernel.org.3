Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33A59D247
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbiHWHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbiHWHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:31:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40163F2D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:31:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x25so12690697ljm.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LMfa0g4iXajYSsq7G/GJjCw48iziR27HSljCF4whntw=;
        b=sWZVI0duRZy6+VSu2/gbHRkb8m9W+UfstMbvXlE8WFEOVWsPIE3QJobZv7VXJXvnmp
         dE2H4KN1fIGFMeAA43u/OgQw1t/0FAYn5QEnOY9JcWG4FHwMF8I9UY/DCUSldfhTMXAK
         9NYwEO+UtDcBtWCJHXSgmC58I0IXPSJjNkW5ff0pY+UXeR+b/o95lTPwxSmmScUgKAkK
         PPxiyu47AL1Gf9VB+pRwHurkUoAywLdinc5tGY+SP8Nw4YZ8FH2lUVdCy1B0RxWFOu0H
         nG392sW3vRd8ejbCVmhuaKaxRzldrEkjYN32tfeYE0giX+EdHPdfl2KNOiHDyJInN80W
         Z8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LMfa0g4iXajYSsq7G/GJjCw48iziR27HSljCF4whntw=;
        b=y6z30Lmx8KeTy9bpOrx5AfUy9HkbGrj3GhDmmWdlqSTBjzLt9FbDqY7AMJE3HttOq1
         u55k1B3+ZuersZd86tUlfgTY6MpHz5uBAJ6jjU/k8kI5fqlMWvsax+rBVwr2MQoxd2dV
         tZMcYW3AL4SJudxil8oOKbEqINt/U8zh9rx9JKzGc3d3l+7+GdwdccMpzzT7NWqW0Loc
         t/k5dJ+JXOvENQz1arV8kXYXNduNpSu1D1kcM2JNgN3njTn4WBdz0PLF7mbcwnH5IzvB
         QWyPL2Vci/wmVt7CAqr++cq+ruqFQu17wX0kN7ab99qzawKPe54bAL0dMIw3pYNT70qr
         CkyA==
X-Gm-Message-State: ACgBeo1sNuaTAKeaM7ePdtlg1vEn1pBDnogXJ8dnrZOFToSSK0JzpuBs
        dIT75iYnBb8uem8ecGlC3bfyog==
X-Google-Smtp-Source: AA6agR5ZiE2iR7OITJAmUSXeFVJVKHlOku91yjT7bxk6l+HmPGlr36uB3C/mcMlUH8N/ps0Zs/nEaw==
X-Received: by 2002:a05:651c:a04:b0:25e:753b:db42 with SMTP id k4-20020a05651c0a0400b0025e753bdb42mr6594777ljq.529.1661239898975;
        Tue, 23 Aug 2022 00:31:38 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id w8-20020a056512098800b0048b1ab313b2sm2363642lft.60.2022.08.23.00.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 00:31:38 -0700 (PDT)
Message-ID: <d5beeb47-3b50-c41d-2176-d4b46811c5cb@linaro.org>
Date:   Tue, 23 Aug 2022 10:31:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: exynos: Add SysMMU nodes for Exynos850
Content-Language: en-US
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
References: <20220823073006.358764-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823073006.358764-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 10:30, Krzysztof Kozlowski wrote:
> From: Sam Protsenko <semen.protsenko@linaro.org>
> 
> Add all SysMMU nodes to Exynos850 SoC device tree.

Apologies, that was a mistake to send.

Best regards,
Krzysztof
