Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CAD4D123C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbiCHI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbiCHI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:29:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EE3F314
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:28:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e24so14202797wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/uGXHNy/zDLI/MTkJ+zXxBEMLylwMy1wmMJ4HzLQpqg=;
        b=mx6SxlDWkIf87UH9JfXgftYx+tfPlL1e7u0ITMXbv4LqLWgHZ6Kim/bBTNZDWsNK+J
         6xzmoI8Zcuwn9zaGfZ6bSIDftCnQAN93XWUyAuH01477nvqn82x4zC2KPoYeB44nid2t
         ZI4TOm+IUphdKBUM89Wvx7S8aUHj5NSvoRYLnEh2b2hLYUIOSVhkk1D8sTxLwCsZK9TJ
         nfoBTEw7BiD8MeakcJgeIa3gK8nxqfjwHuPoEFHKCT5LogEUHcecaAHzmajcyJ9WeIDe
         e9XEwXJXfZ7ObuUb2XzZbEpyUPsrkIqvUv3Rmi5DvONgjvcfcmHM85Hd1WnHJvUqlJ/q
         24Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/uGXHNy/zDLI/MTkJ+zXxBEMLylwMy1wmMJ4HzLQpqg=;
        b=0JbvcdsTz8Ii6WRRt5nfj83zm2F5JvXI6Y/wFh/21Ge2WJ5LQ4+XpD2Ly1QrsExQ6u
         GBXJH/lkXCoHKJfK0CDXYF8Tw7NxGYKzYmC7ULg0xlWHVkZnyLPut5giRRPqkkm0J12V
         hD0hPzV5ix0/GuyQ/SzcA6vkKZKNvWK0AHhdSXbW8cNcFoUO6dLJ7T/fFVG0kkveZhU6
         ZRa2Ccro9E0s8Q5IO1yWkTZ8eAfZHuPwpDaLpeo3voAUS5bcywH+RsUw1rhz9RvWAs26
         LxwxobUm2+RmPHYeHDga6LpmfNRRrJruD8SnESLvXj5HKDSz+Yef3pY/DwIePeChAyZx
         XH0g==
X-Gm-Message-State: AOAM530NsVrm6I+3e4UeV4TSvM5KbllXISyvQ8wY/B9qQL0GUYpBp6D3
        BCUObAhnTeEnoM0IMJ8LDitWbA==
X-Google-Smtp-Source: ABdhPJzxeRffR9PjeILKkoPeUlAK7yU/4mJF9TwYU/She3MTYwCOmDE8rq/V0HY8DnDtvF8cI6RfCg==
X-Received: by 2002:adf:f849:0:b0:1ef:5d80:c68a with SMTP id d9-20020adff849000000b001ef5d80c68amr10888216wrq.280.1646728126427;
        Tue, 08 Mar 2022 00:28:46 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm12968877wrj.92.2022.03.08.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:28:45 -0800 (PST)
Date:   Tue, 8 Mar 2022 08:28:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Johnson Wang <johnson.wang@mediatek.com>, broonie@kernel.org
Cc:     robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: [GIT PULL - FAO MARK BROWN]: Immutable branch for MediaTek MT6366
 due for the v5.18 merge window
Message-ID: <YicTu6FwOR7zIC6I@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106065407.16036-1-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

This one is just for you, so you can merge the other patches.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-mediatek-mt6366-v5.18

for you to fetch changes up to c47383f849097c2b3547e28365578cd9e5811378:

  mfd: Add support for the MediaTek MT6366 PMIC (2022-03-07 14:59:44 +0000)

----------------------------------------------------------------
Immutable branch for MediaTek MT6366 due for the v5.18 merge window

----------------------------------------------------------------
Johnson Wang (1):
      mfd: Add support for the MediaTek MT6366 PMIC

 drivers/mfd/mt6358-irq.c             | 1 +
 include/linux/mfd/mt6358/registers.h | 7 +++++++
 include/linux/mfd/mt6397/core.h      | 1 +
 3 files changed, 9 insertions(+)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
