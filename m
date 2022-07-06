Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198A5684F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiGFKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiGFKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB62DC1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:11:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id cl1so21345182wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/9iI6aiORurw35kAJkK2eiiJXZEGQGctIRa+3/X3bM=;
        b=YZRngobA6hqS1ZMBRuNtz1/qmhGayq14Opnp6/lBIxVxziVa6QyHueEgWiWc1Sshvg
         /7EV+SwvVKHSL/xWtRjWVnI/ZYc5u65U9QJXCIA7B2HlTaATBFoSt3E7jBR8XeLwJujH
         5a6LLvNF8gLmo23sA2aRNO+FV015XLfOIgbbIBcAjo4VCBrSZz05x2YTa6MFKyOp0hBj
         mMvS0Bgp1+ZgHcfZH75Xzjj16mg3glNLq6fi9lOI3tmz1HfrZOp6UIlTnpn3zUJQ+bQZ
         4YtHgfe4yK46yMgzkeMBmVVezRSCJKKFmUH0ONm7WsHBb2iZ02VEtdUQn/RhVxVV/sNL
         +i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/9iI6aiORurw35kAJkK2eiiJXZEGQGctIRa+3/X3bM=;
        b=RTzfpuJFp93eikuGtfNmf0yQEQu4CW7cjLnfUBUo2bGEl+O9oe3QUCCjTXJ/rcmkgQ
         I36LIjskZwFINV0E8NFyPYUC0L6arTzA5VBxgiXkaHIM/r0eVlJL4QCBApNnQ0onhWtI
         cg8euiskOTc+RucSpRgShQ3gqVCFt8mMcnPlxZUflGIH2eZaF6WRFIqdW8dJ2kEc2SB2
         1dNF8lA0mRzQJ6kD0fDShVEnrpkJpJkOzqYDDO5VUZLuY68w4nY2FNU6Os9tGLm1nyzh
         SrJyS0Q8I9s8XPu7EhWI5w54qAqPo39r7g5EHAW8iltJ9lo7VhxlzCcTXQf3/djincBa
         QGGw==
X-Gm-Message-State: AJIora/orQPAY2G0LUgZdnmhEccY9Q8dkeCI2RFYYOK5XbpbinxASzZw
        YvWjuv1BHVS+VC3kQbZi/IujUcb5P13D1NGm
X-Google-Smtp-Source: AGRyM1uJcSJwnXyOuFIcCDcz6JLhBt+w/CFxUCRUFLg1MZ1i71ZFoPV82z/I78IczKAE5+3aU/ewAA==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9239:8f28 with SMTP id i8-20020a0560001ac800b0021b92398f28mr37384379wry.517.1657102314117;
        Wed, 06 Jul 2022 03:11:54 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm24826620wmj.35.2022.07.06.03.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:11:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches for 5.20
Date:   Wed,  6 Jul 2022 11:11:29 +0100
Message-Id: <20220706101131.6934-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Here are some trivial SlimBus patches for 5.20,

One of them is to do with typos in comments and other one is to move to
ida_alloc apis from old deprecated ida_simple apis.

Can you please queue them up for 5.20.

Thanks,
Srini

Julia Lawall (1):
  slimbus: messaging: fix typos in comments

keliu (1):
  drivers: slimbus: Directly use ida_alloc()/free()

 drivers/slimbus/core.c      | 6 +++---
 drivers/slimbus/messaging.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

