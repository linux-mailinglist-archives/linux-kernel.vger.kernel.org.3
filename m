Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD124FEE75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiDMFW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiDMFW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:22:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4290E1EEDD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:20:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o2so1468246lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ca0htyBTZDClNQcS0BpnnySSwxIQpPspnwepfriH2zg=;
        b=JOIOBh/n+hVr/JanzyxVVF+Qm1MZZSnmB2+9zH9ZDQaD12D7XKvqwEqhFZmfnHq9KH
         HpN0BW542LZL1NwgfwcUnW/jOTSzccfLl2ZjWKndjHY+z8Djhq9iTmWCYJu1+cnKXVYk
         L/GYRex/oDwV+EpsyM93znh4JGx5R7ggELwuCV6wtnbwV1DwM6CNBRnK1LHsBRZC8OcF
         flD2WhEWdW3B2unyYHqTbuQU9LNDw8Rw/40bk7xMLq/aWZHhnSzOy//D5BuisYw75BGU
         IszKhyUmZJLbFoHuKELwAVsfUrej7LqPAiRg5kYXVV67Rqprfig2BQ/QjmWtJl5zownc
         EHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ca0htyBTZDClNQcS0BpnnySSwxIQpPspnwepfriH2zg=;
        b=sJMnYReSG4TbY3VgoSQuVWzKwuAlVZD+R5pejY74pRVKdxIjxMER+hW5XCEyRNVAgm
         3CcVLLjvqJd1br52xBcjd61WujeK0M7yfhSOg1P0tPkbfSuNZHcQa0zboOUefbemMoCF
         4FFQm1Zqao2iYeyg0zRYkBy07gPZZiNyw+5JpnjaPw0h4/z28jPx9HRRt1IvoEjRr2hK
         bBPWF+7e43fOmSN+9tEQnygpEWWIovVqHneldB8ypMUhZbTjotBYjofWgxIXNXCnrwrj
         KUojkosPbR04jfAsL4YgyEAoNoMKy3fGLa+3CHqCILtMCKYkFku+D0V9/1MWPfg9wGzw
         iRyQ==
X-Gm-Message-State: AOAM5305F/MH/NcNHfCkWkyOg8LtEOCDuDGdXekO7v9FHFxQat14emQE
        UJAR2V/IBydYPNKv9AB7v427Ww==
X-Google-Smtp-Source: ABdhPJwpIiCQxFPp7E79MGXcRSajv7a3kTj8WKIJPwkZ1nV5/rQhPlPMTlX/5paOpqG9h/YTAq2J+A==
X-Received: by 2002:ac2:4290:0:b0:464:f225:1a37 with SMTP id m16-20020ac24290000000b00464f2251a37mr20940630lfh.140.1649827204493;
        Tue, 12 Apr 2022 22:20:04 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id c3-20020a19e343000000b0046bbd85a014sm465772lfk.25.2022.04.12.22.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:20:03 -0700 (PDT)
Date:   Wed, 13 Apr 2022 07:20:01 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [[GIT PULL] OP-TEE fix for v5.18
Message-ID: <20220413052001.GA49798@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix for the error handling path in
the FF-A probe function.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v5.18

for you to fetch changes up to b5e22886839ae466fcf03295150094516c0fd8eb:

  tee: optee: add missing mutext_destroy in optee_ffa_probe (2022-04-05 08:56:26 +0200)

----------------------------------------------------------------
OP-TEE fix missing mutex_destroy in probe error handling path

----------------------------------------------------------------
Dongliang Mu (1):
      tee: optee: add missing mutext_destroy in optee_ffa_probe

 drivers/tee/optee/ffa_abi.c | 1 +
 1 file changed, 1 insertion(+)
