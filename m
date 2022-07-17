Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A05773A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGQDIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiGQDIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:08:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B83D140AF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso6282497otg.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR3y5c4srMI0k5XyH+pLoxzkf4vj+CXbSdSl7nNS6XU=;
        b=rlVnZOb3J/UV8sZDg0O9I8psHbpeW99aBs0bqKrqunfv7+Z18hV9gwQRoHpM7n0XqK
         7dstmPX1Qw7uY8+0Jfbgp+I61ZTcyrIyAPm4GJc3iKjqa9Yd6kZySUVYcHpISmi+PLmS
         RJ0h5eHDCZK9YlvPRym6X74AxbcG3BqogjDavmzWLww3HAZagJAc//pyKvMFFOTFwMlx
         PbuWLJjsC0Q9ZAyZlcuvB1f53Rgnn5/8fvgwrW+wEmCLt9i2hV8Zd96/oaK4wqqncOgv
         Vq96vmVfT5S2a8sj8nIp+IrLsCfL5fduofEaiUK1sefW1c4Cyv/p6CF/p2tVc7UddrL5
         om4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR3y5c4srMI0k5XyH+pLoxzkf4vj+CXbSdSl7nNS6XU=;
        b=0nNqdqASmA0yad80mIuqaYlw4WKQVNNmukh6Emr6W71tgFUOtYLyGdp99Y7aZFQTka
         HVJQ8v4k/AM+i++JRv8AKDuOc4JwW8XmqHbN2/UK2Kp596Ls7QbaPHebUYS8A5+I6hrj
         LpPJeWz6V2OCcSUOYb5erh9x125Y9iOHgK3HPAwIni2Bb3MY1SPSL3QsTxvDsoC40XPH
         R5nDiUhgjNDeJkjQTGycVz9RrLCnpVhmUQEX/cOIWlkjjhq5R6KyEynQOXqOe2sT+vPU
         c5pMy8+DNlDuqyOL5UfGr3ACD1rMXhUBwREdFftptesg4FSmNUktAsFj3POZkgUgkfOZ
         D2Ow==
X-Gm-Message-State: AJIora8YcpG5IZzakL3HK6+MmdXiGoIOpMRUuVnEDpSCcflj/1DJrgQA
        Th2+2SGRG2yN218oN3cNLnFaegPALFIOQg==
X-Google-Smtp-Source: AGRyM1vDFHDVvYyuorVlMn6sghxgM7CcGK0tgRhwm404+PuwnuhCEj1EptbZZjdSaq9OCQmrkObwgw==
X-Received: by 2002:a9d:76c4:0:b0:61c:36c1:90e1 with SMTP id p4-20020a9d76c4000000b0061c36c190e1mr8714984otl.176.1658027309931;
        Sat, 16 Jul 2022 20:08:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z203-20020a4a49d4000000b0043577be222bsm3203928ooa.22.2022.07.16.20.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:08:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add LPG node to pm8941
Date:   Sat, 16 Jul 2022 22:08:20 -0500
Message-Id: <165802729676.1737676.12212447134864274795.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 13:54:10 -0700, Bjorn Andersson wrote:
> The PM8941 contains 8 LPG channels, as well as TRILED and LUT blocks.
> Add a node for these.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: Add LPG node to pm8941
      commit: 5edd7d3e15a46c8549440a0b596c69be7e2c49fc
[2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
      commit: 27f5947894c596fcfd6da20c061c582e7191e9e1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
