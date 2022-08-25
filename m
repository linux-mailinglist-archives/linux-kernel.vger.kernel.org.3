Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C85A0D66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiHYJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiHYJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:57:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189592124D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:57:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq23so18471618lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=yPQTjek19dVxANcg2e3WvPol3YwRVRICz8w3fymbirY=;
        b=ahhl9xUT7wWMaxQJsVd/s12OzETtJzJFtjCcd2xC/A415hBGBmjvEelSL4KaeG/5eQ
         QPgCLbWagwJn/qtv5HclgmhTZp1Pxh2R0Igvz1AZDiggkWJaXnY9IGDKU1GNf1mYMn0I
         gLXLBva7qKA62qcxMVcJEj6T25tv1rCywpWodT4//PHvXItxVSoC0d/XbdtB7wDOTWMH
         61pnT1doMDledkZQYI4TfOlH9Z8TNhnjo+NvkshX9szI935uLCkZC4wtYNu9mEprOUL4
         E418SN71jLRgA8NCwQRv17MkCOhL1c0svsGewijZZbdMCHc7QTV0BoJWCOvYeg8hLq0G
         yitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=yPQTjek19dVxANcg2e3WvPol3YwRVRICz8w3fymbirY=;
        b=j3BN4VkGYPKIRRomg0RMiSGge1EnPWs6LFYwW/KIDJXoqf/77HIz1xqFVjfj4oU5um
         gBmc94lCgzzeFVEHuhK1GbmPvLMBmjpI4Y3jFFuC0rYXE6wIA8eODCgnSts2IpVyEJty
         fpoEpGe1VowRmiOeBpFvJVWGTgnIOkuVHfqIqhsX+GENqvT6xaIdSjN6D8mIyosx3Ch0
         RMjPk6oC5FdWNtdVqx2yxdzlqRVSBPDyPF69BAru7jLTZNqkhkVISPO8yKOIK3/dQQur
         eDw/dfYCnaardbks4FDrbrRhALgXg0DtrsXzyB3QWt/e49QpT4cifqM/xEU9YuWKAecC
         E8CA==
X-Gm-Message-State: ACgBeo0uXVQ2dshvxUj8v3mrEkqigbVbscvzAuq1xNXbQcTEN4NxpJpc
        m/c2eIU7jSo4efBWhkSk5DlP0A==
X-Google-Smtp-Source: AA6agR6d5FacAMHe4GmbVd8uFGIcTWuWpvV14leXcjzWEufYUIWFu+RUixDMXPJq3HROWsi5uM+tqg==
X-Received: by 2002:a05:6512:39c2:b0:492:d15f:d246 with SMTP id k2-20020a05651239c200b00492d15fd246mr1022150lfu.517.1661421428010;
        Thu, 25 Aug 2022 02:57:08 -0700 (PDT)
Received: from jade ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id w25-20020ac254b9000000b0048b06f34566sm414602lfk.76.2022.08.25.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 02:57:07 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:57:05 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix TEE system compiler warning fo4r v6.0
Message-ID: <YwdHcdEUib7obbbW@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which fixes a recently introduced compiler
warning the TEE subsystem.

Thanks,
Jens

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-fix-for-v6.0

for you to fetch changes up to eccd7439709810127563e7e3e49b8b44c7b2791d:

  tee: fix compiler warning in tee_shm_register() (2022-08-25 11:40:06 +0200)

----------------------------------------------------------------
Add a missing include in the TEE subsystem

----------------------------------------------------------------
Jens Wiklander (1):
      tee: fix compiler warning in tee_shm_register()

 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)
