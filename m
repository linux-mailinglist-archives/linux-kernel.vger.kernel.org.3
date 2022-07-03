Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CA5643D1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGCD5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiGCD5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A1B1DE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:01 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s188so8707090oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2q5yDngeaVXtBRHY8oUTYo4VOMxZ5qwHipj+5IYs+kI=;
        b=ayEA/gzsU5xbA6BMZjqmbEUJw8Dn3G7BfxyOz1rNzHA7lAVEKIo+EO4T1dpqFwKBKn
         mrx98Oil+BVXN8LvovgHwRSMn2pp1suxHWykdH01DkJ9+cIqeC27hRyPZHYATbwif/1K
         51nxEZ8J6N26OhcXhxaJNDYNQmqumHMQt4tO7B3hc+CZp5t2jkgzgsDPLcTLTxUS1XLE
         mlOGFEyELA2rRnGaE9x5WJPAmthJcrak1a8OyB9/c5NXqK+OBa4e/rIQN78HgJ6L9n+0
         Pnsy/aV8v859ZJoCHuPS5pv5Rn7TmB1BYmj5pkU6m9+RZPH6yVQV2R5nSFmtDfksjr6Z
         Lm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2q5yDngeaVXtBRHY8oUTYo4VOMxZ5qwHipj+5IYs+kI=;
        b=x+bxpLC8vBxFF6A/XHe8d292wLHutGvbbn910AV+iRc7nsdM6Sm15Srqlyx2I4pDcz
         ySLYCdpWZovCi2XTCvuU6pA3WtA+fk8ee57n9YrdyLdJqwsghlQlvaP+DQsv93ScFbVr
         l2f0uUMXtr6nJLIuwwym5+bazQgLA2VxaIAmpEjIxVj5n6rwKPJOD1tfSacUF8zvO+bI
         c71yq1C47ISWYYld1070Xmr/vB6xA+2fvT253RlvcdZWhb56hTvb5ZHPZMcxrrI/UCf2
         8UrQvQdrP/gXYSyly8ITlqy32ODetuZnrrLl3Vc6HcX/Y8HZt7XCODGzBNdgF7cxb5Kc
         tnng==
X-Gm-Message-State: AJIora8CMji6cgHSI9jbptIoDq8RFop73/jSpdpugPT1teAbDJV9Uza2
        55bZNuhC8sS38h0XpBnch3YP4nlgUSwYCg==
X-Google-Smtp-Source: AGRyM1tlEHGR7z1guqXflw/ly96NNulGTaxySN2cM/F/SHfKo7+0zUn6XzIZnBFt/impytRHRkzd3A==
X-Received: by 2002:a54:4e05:0:b0:32e:68e5:8606 with SMTP id a5-20020a544e05000000b0032e68e58606mr13354821oiy.102.1656820621059;
        Sat, 02 Jul 2022 20:57:01 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     robh@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/6] arm64: dts: qcom: Fix 'sdhci' nodes for 'make dtbs_check'
Date:   Sat,  2 Jul 2022 22:55:57 -0500
Message-Id: <165682055969.445910.12459477570300688258.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
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

On Sun, 15 May 2022 03:24:18 +0530, Bhupesh Sharma wrote:
> Changes since v1:
> ----------------
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20220429214420.854335-1-bhupesh.sharma@linaro.org/
> - Fixed Bjorn's comments received on v1.
> - Added 3 more dts fix-up patches [PATCH 1/6], [PATCH 5/6]
>   and [PATCH 6/6] in v2.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: Fix sdhci node names - use 'mmc@'
      commit: 2477d81901a23ad80045798edbeb7f91b5ff6143
[2/6] arm64: dts: qcom: sdm630: Fix 'interconnect-names' for sdhci nodes
      commit: 40940823cb582acc13f5fda5688a5287893b3281
[3/6] arm64: dts: qcom: Fix node names for sdhci 'opp-table' nodes (across dts files)
      (no commit info)
[4/6] arm64: dts: qcom: Fix ordering of 'clocks' & 'clock-names' for sdhci nodes
      commit: 4ff12270dbbe245cf92c0247bcc1a2bfbc03639c
[5/6] arm64: dts: qcom: Fix 'reg-names' for sdhci nodes
      commit: afcbe252e9c19161e4d4c95f33faaf592f1de086

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
