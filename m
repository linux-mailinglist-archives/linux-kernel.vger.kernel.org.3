Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9150E8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiDYS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiDYS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:56:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62338B7163;
        Mon, 25 Apr 2022 11:53:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w1so27838985lfa.4;
        Mon, 25 Apr 2022 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzTyrWH6+Wmk4+451HNCK7O6EmDtB2NHfsrNY09RFZs=;
        b=HH8AORSsfgDEfn76V7UwF3hOOxtho3xvZ0tLDir4jXG21k7MkZLS67kn2igk6xuVtR
         CiitBHALNRsQrsODtOsyZpbBzwNU2DgbueO+okSkhikdkg4bOq5oeHf6u3gbQITQ/opY
         SZPtI7PWdX6wqyKxcdOX0SR14KEBhTvYrecjy/27KmCYdXj6jnKjKJa9fzx7ZrtncJ+B
         GMgIx2AaUmY+NvedS2hVXuojvnKG8P1uGFByte5ioDtRtEzALRWzcHg/rFbKwhEMjgW+
         6Ps3s9KJuugUdUyLu8fv7Rq7e+NIvZgs9QXwVts37+p+w7ckfUveBDBqDijK4Xpgx/tV
         jlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzTyrWH6+Wmk4+451HNCK7O6EmDtB2NHfsrNY09RFZs=;
        b=ZGtdxt0prC70CE/s6eu8bPRbx4yy53RdeECvcacK2+fdq1O5j/9DzavYt3qat8DdPV
         QrTCY4dPqcE5H3n2eFHc3jjN31UGo5k0rArJucyQwpQZ6qMizG+f7qij98T7D9nxD9RP
         RaNKBDm/84a0wQgxKnr9wZQwuyO67BEch1Mrk+sl74uKiuyl62H4dov+ix5F4jTQsQCr
         Kz3KSEQYUgDV0enhGRcE2nJ+dTtpVQXq8CWk4R1GGVcSPZttN7AM6kFjm0+ykfRwIKbf
         8y0k53Z2S1jfb2fCK7J0vrHYkrc8N52ngg/PwVxDJj5+4ezlT3AkSA31CnS0hg1YPXDD
         z4eA==
X-Gm-Message-State: AOAM53124wdB8kyOYrbetqdZeAI7UMEUz7VCXVk3DjTA0e1D1ONdvnRC
        iNsNn/v8pFfAg/YhhM8w3wKbJmSmSfs=
X-Google-Smtp-Source: ABdhPJxNJrgjtFLeb/dKqVCKzs9JdNGuIEMDQUNTOSSAC1RSYOZ4HfsCWdfpge8QEkSN7TSv9Dne5A==
X-Received: by 2002:a05:6512:11cc:b0:44a:5770:7425 with SMTP id h12-20020a05651211cc00b0044a57707425mr13478200lfr.406.1650912785452;
        Mon, 25 Apr 2022 11:53:05 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id r20-20020ac25f94000000b00471fcf5b4basm913135lfe.90.2022.04.25.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:53:05 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] MSM8976 GCC updates
Date:   Mon, 25 Apr 2022 20:51:37 +0200
Message-Id: <20220425185140.15154-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series brings small fixes for SDCC clocks and adds reset for modem.

Adam Skladowski (3):
  clk: qcom: gcc-msm8976: Set floor ops for SDCC
  dt-bindings: clk: qcom: gcc-msm8976:Add modem reset
  clk: qcom: gcc-msm8976:Add modem reset

 drivers/clk/qcom/gcc-msm8976.c               | 7 ++++---
 include/dt-bindings/clock/qcom,gcc-msm8976.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

