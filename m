Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7C4C4D13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiBYR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiBYR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE01BBF5C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so5634957wrg.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGOsLwo97hntRN/WgBvbjfTp9y6xVKG9ve20Mc9hxe4=;
        b=i8OOS0fhUxKJx1Oa5gaNUNjLLkuOXYDe2kgZrGCik5kJi+ueExK1bXbtb4hNKkAOKU
         RwHOpLKRQRMzPxab+B4rxlj2P8mEE8DA5mgM8EUXhLXYwgUzmhyGhuzNGQRuQWTZWKcq
         S517amq4d3DD0Q4ESlTg1NtvUgCX2OwBArsR7moc2+H62UcW6G9uWavWUQHRyMub37JZ
         8BJX8bTEGmmjfd4jf4g81zQuQiWnF9Y+39dh5zNUhJQObo5/8BBiIgcu5yw12hjOZ13/
         Ax5pWeTd6goSExfjcyTpe2FjU9Rr/WLSIBV4bhNukp1deha5ydajEL1thlu/T7RGuKoS
         Zbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGOsLwo97hntRN/WgBvbjfTp9y6xVKG9ve20Mc9hxe4=;
        b=aQ7dEjq3UIZAWZlfLPb1BCgMlNzeg6aAqXN924o2MwsIyZYcBOaOu9jCPibvAfcFU1
         RO0e9ysAV2/6tsIdB9AAuvH+P30axxFOE08cgebMf4TDZY2HG1mAVMi4bvrr5nfYqh4Z
         qGLUsewALems13ifMngxRMX26lBidBptRSqV7qrQGmMAsUGZ/sp8MoGzocLQBKolM35Z
         cTx0I5h+192xFiby3rV/a9vgCYoG38C3mtRGcnEeoRfMZJ+suPmrLj3ZtrjlAb1NxQBo
         B91WP6ddV8okUnza1QQgcC0PKP2jgdRC7zKnTGOOfOtU+BzHslPh90f5t3kI1xMCbHKe
         xeNQ==
X-Gm-Message-State: AOAM532jlG/VV9bSXAaWSNwseJFQwPZ+3D8RKw32j8/CZkaSfxZAhlXs
        5q2N63hvcK3pKy1SxGAoAqrk1NgPpURNVw==
X-Google-Smtp-Source: ABdhPJwoMR5h09XCdldjH7K22Ht0OaCn0AlCXScmoCaxXlHnBenhqF5eQoP9O+uLL43pNrG5nwV3eQ==
X-Received: by 2002:adf:e58a:0:b0:1ed:e2f2:783a with SMTP id l10-20020adfe58a000000b001ede2f2783amr6966681wrm.457.1645811922812;
        Fri, 25 Feb 2022 09:58:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b00381428ad88dsm74172wmn.15.2022.02.25.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:58:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: patches (set 3) for 5.18
Date:   Fri, 25 Feb 2022 17:58:18 +0000
Message-Id: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Greg,

Here is set of nvmem patches for 5.18 which includes

- A fix for dt_bindings check failure on Sunplus nvmem bindings.
- update to nvmem bindings
- Parse cells from pre-encoded info in brcm nvmem provider.

Can you please queue them up for 5.18.

Thanks,
srini

Rafał Miłecki (3):
  nvmem: brcm_nvram: parse NVRAM content into NVMEM cells
  dt-bindings: nvmem: make "reg" property optional
  dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells

Vincent Shih (1):
  nvmem: dt-bindings: Fix the error of dt-bindings check

 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++-
 .../devicetree/bindings/nvmem/nvmem.yaml      |  3 -
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  4 +-
 drivers/nvmem/brcm_nvram.c                    | 90 +++++++++++++++++++
 4 files changed, 114 insertions(+), 8 deletions(-)

-- 
2.21.0

