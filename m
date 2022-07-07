Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00658569807
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiGGCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiGGCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:31:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23C2F3A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:31:26 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so13067141otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/x5XITTrlVQeQ5M/vXR5Vvmaik57UVGMDSMhKmHqew=;
        b=eYhD085KIjk6psYVDhdZC/Pbf6S/2+IBlvBt0i80joTcPKEltGJGpMCqBWfD7+SvGJ
         NlPk0Et700/hTXief6ZBt587lwVf1Jfk4xhTm4jsfJKkUboH7/tAq/nHkkg2judMztYa
         a1JZItiMj48okLvocCMAdcjdYRaPMx+MdOy8tqy35ILOJrKfJUY8FAC/U4H67ZeTisJA
         KiMBVq2YRnOAIi8dkaOzq5xhaclu8vwbOYcLQtaBLzqGI6lXfV4fREO6PApVEfq8rE+6
         +anPFvJPwaIJnzTTbcWNxIEFnRr5zWAIB2VkAcJADwRfhCr4FBC76fTtFZJ+U74agJYY
         JnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/x5XITTrlVQeQ5M/vXR5Vvmaik57UVGMDSMhKmHqew=;
        b=VN247jZWJljKrz6sgUO2sj6DDolLds2ynxJOOkKOLHhuN+0NdJHZYgUbCU+7q/7Kwo
         9XVjV13XT+eI16GeQBafj6onXtHRYK+JemOAduleU1X05LRb96yRraLlpJC0AKNT3acX
         WWkeXJMGprAIh/tdG3ugCUMme+Kq2Cuj3J8lKVmbt0zbmmQEcTfrLIPWoXdsr871roRC
         SKknN1Yj9kLA8zS20klJCkeH5Jw2mAezStVSnyOSZAyX8BZin4h0z86ohwMcIYm615fb
         UkCiylaupKQVLm0m4asig19KibV7FYiVXWhHybR7BLu2OOhGc+nC3NiHrQa3Br+vUkFd
         Z+SA==
X-Gm-Message-State: AJIora/ytclJ+vG/pepvysI8txNrJncWv+M2+TI1dCl7ITPhKnmRaGbI
        RAWmxEOqhg6CfXC5iKlp2e/1OA==
X-Google-Smtp-Source: AGRyM1sSG+4fgVbHTo1Z7KR6jfuJfK01/l9hdolHJ9/sVZAmhnmEHHtEecz4i9vK67NLS3ojIjnpNA==
X-Received: by 2002:a05:6830:6402:b0:616:97c8:580f with SMTP id cj2-20020a056830640200b0061697c8580fmr18084270otb.293.1657161085558;
        Wed, 06 Jul 2022 19:31:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: qcom: Add a few LPG LEDs
Date:   Wed,  6 Jul 2022 21:31:03 -0500
Message-Id: <165716107314.864223.151200806087476612.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
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

On Wed, 4 May 2022 19:27:02 -0700, Bjorn Andersson wrote:
> Now that the LPG binding is accepted, sprinkle some lpg definitions in various
> PMIC files and define the LPG attached LEDs for RB3 and db820c.
> 
> Bjorn Andersson (4):
>   arm64: dts: qcom: Add LPG to pm8916, pm8994, pmi8994 and pmi8998
>   arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
>   arm64: dts: qcom: pmi8994: Define MPP block
>   arm64: dts: qcom: db820c: Add user LEDs
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: Add LPG to pm8916, pm8994, pmi8994 and pmi8998
      commit: e79a1385ab74451e2e61efd5e59de3c1d3b4cd05
[2/4] arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
      commit: f23f1fa880bfbf47404aef9aaaff1dc7804d4df7
[3/4] arm64: dts: qcom: pmi8994: Define MPP block
      commit: f041bb3cd77fb68b59cbec8031bfe65eeff15823
[4/4] arm64: dts: qcom: db820c: Add user LEDs
      commit: d1a405d2228f686a3fecf0f0374b61ae81d441aa

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
