Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2847754EB84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378763AbiFPUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378470AbiFPUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0863813F3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e11so2477559pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4NQgDuIIXTYadOaxWU51CqTGV+QZF/iMVezfiW1wi/8=;
        b=Su2KSpa1O+LyVRVo1T1KQ4tcJSXloCboD7syrjoGtB5Xktnnu/5FMuDF8nwJ1fDAVd
         XcHOv0CZv75GsS55AgCBWGpVYLrS7R0iCAld4MbmtC+dSFWb0hX/+nDlYncXAgDEVTLI
         u6EdXlOjD+4is7sJq25gsumfEkMD69qCIZvR+ERtPYSpxgwbtyEK75DDJoRRpVlzCUIS
         88SrNz+v2+UoxBd8df+Ghxnb9f8HsG6oWJ18kOOzzJLkxjlE3wYx79GYOhpbcP+1X/jL
         PPtEESD4iSFgHVGnFvIXdg3Y6IYj3bUPY4Vf1ICADqflgfLSrGk6SPKMkSUJc7Fi42gW
         8B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NQgDuIIXTYadOaxWU51CqTGV+QZF/iMVezfiW1wi/8=;
        b=6Yidy0xHCY1xYG70Tbs53GAUKOKja7SBxy9izMoo9jGyECVnHseGLCz8bqGPk+cnCb
         1uD+xI1hpwz1ksCTI0dIFffx3MVDeJgob9HrqAuBYk8bH1JpIvmA34jBX7t2kfIuPLUj
         hCIAeeDAMVxVoA2a8VAsYTom2VK0033cbmvHWL3R8axGO/au/YanbmDiIqTX6vMcoyn4
         RkAboqLESncOLQeR5GACis/s8D5wEsNFza1s98xaUHlV36KWU9bJ4CgSkSJJa13JSaRb
         614czwkVi8PeOkOcXC9Yeg8KMHznpaGe9EUD6gvoLo7e7INnWBkxu6TRLOVQaBlXjQxb
         bg2w==
X-Gm-Message-State: AJIora+K0Cswz6LakiLboPkBZJJih5PTATqzP849D4mLdvTOUv7eYq9f
        NAxzwGF88vkoxw2YwrqAU8yC4A==
X-Google-Smtp-Source: AGRyM1uxZaheukjW6+Yg/EPIaZ6GwKyP7I+d7NbkSFUw3UIzSN5kYw5/zPmioOZkTgXHXEArETs+tw==
X-Received: by 2002:aa7:9e9c:0:b0:51b:e1b8:271c with SMTP id p28-20020aa79e9c000000b0051be1b8271cmr6549078pfq.73.1655412469561;
        Thu, 16 Jun 2022 13:47:49 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] ARM: dts: sti: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:09 -0700
Message-Id: <165541242280.9040.13630887348595575911.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
References: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:36:31 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/2] ARM: dts: sti: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/53f2ade4b0a36a38c3c29134586857d6db6f6dcb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
