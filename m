Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBB4D078C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbiCGTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiCGTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:06 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03C4BFCC;
        Mon,  7 Mar 2022 11:22:10 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id r22so6429316ljd.4;
        Mon, 07 Mar 2022 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUWOZNP7lyyv8Bcjt+iUqGnuBs8PmikxrWNouw+FZus=;
        b=AOYsE/ObWLYMSmn8dvMGUxXOwmOhlnW1pGeXFAuDR/YHfn4EPqP3f6I0QN9ecssieV
         SlPA70URa6iUo4pQIVCj3Kwgf+6o0lkgfgvCJMMvlQxzMSX8DrkByZvXsIpVg7Yuck0c
         zVSBhSYiw8Y1lwcOqdr1RRuAfZ06PEC8oS+mTQgTBYpTGxsNaMRl4foHCUvuF8oJ146k
         OiyT9WDNX9bo6QeRuvAakb8ReCmMO1ANAzead2enXJTwrbJrEqyUE4vwZOAiZ/4LiwMP
         HxHI3gg0jngqy8IFOVmdIxGlHRLbp2CYUSC0Xe0KNV43eDV+rvs0lGM9pqH+ro5tRIzz
         QY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUWOZNP7lyyv8Bcjt+iUqGnuBs8PmikxrWNouw+FZus=;
        b=0bQaQX/UwJqqmkDw2zKRUxS/+B+QJnarls6QSjDkfjlExNxRqoFHD4hm2ol8RnoF07
         tVjCjjpJtDg8DM6HVOFd2IvqyQx840ZdUatPJA5/Fr6LW/42Fqc+0kwF9swxKXzJETeO
         1JGPvogYEF21rC1W/zHyDqIL2zzke+JxGGcs8dejD1NG1hBVGt0rotofpelTpQEdALgh
         bgyZxukXB8w/Ubu4FDk+wBUzsZpW2oVUuRLCFp+DKcMXKovrCI1UkpBiYNrBDlZ2qQJ6
         w/q/wHI73eALx4hOOdtv0oiGeZMwHzz4NYvOoY0RNhJv2d6RpcVb2SQLlqXN6T2m70Ag
         5f6Q==
X-Gm-Message-State: AOAM532Rd36lgocp8p4bcemu5/2ANORfufyY9XrpsGDklT+vMhF/qMKM
        1cdG78Q0slXrfpv57h2JMjxvyIYqFll+uw==
X-Google-Smtp-Source: ABdhPJw+VVH9nmydJy/e2xOClA+oP2lDtDEHrWsmrzgBIxcbDduv6+O+4K3JdDi8/jkNV0FIJxJnlQ==
X-Received: by 2002:a05:651c:545:b0:247:b6c3:946f with SMTP id q5-20020a05651c054500b00247b6c3946fmr8567231ljp.424.1646680927907;
        Mon, 07 Mar 2022 11:22:07 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004437e92a5e8sm2995671lft.105.2022.03.07.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:22:07 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add SCM and mailbox support on MSM8976
Date:   Mon,  7 Mar 2022 20:17:21 +0100
Message-Id: <20220307191726.10869-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for SCM and mailbox as found on the QCOM
MSM8976 platform.

Changes since v1
================
1. Fixed formatting of patches(lacking empty line before Sob).

Adam Skladowski (4):
  dt-bindings: mailbox: Add compatible for the MSM8976
  mailbox: qcom-apcs-ipc: Add compatible for MSM8976 SoC
  dt-bindings: firmware: qcom-scm: Document msm8976 bindings
  firmware: qcom_scm: Add compatible for MSM8976 SoC

 Documentation/devicetree/bindings/firmware/qcom,scm.txt       | 3 ++-
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 1 +
 drivers/firmware/qcom_scm.c                                   | 4 ++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                       | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

