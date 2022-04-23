Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE250C706
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiDWDtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiDWDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A917E18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:43 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e2afb80550so10652554fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ra9WJazw1Fb231ITwJYo6ORz8hO6Lpwzm+CXlVX1y8g=;
        b=ls81e046Y329pYLiVwNLstXqUPs0QoxJgkmm8Jwi1/eMAxVPJeGRRi2Ja8swO68Foq
         j6TbsZKnPxb5ow+ubbQTvD5FkjUS0Db6yPvmZIrHN/+h6VJtioGFkBTTFV6Bqb58/A7K
         7jWxV2Ari/oJfxhfVxo8tqOe088o9SlcZ2gBVrUpL9L5Nceq8lhKSKc1zPlLWHzWHOtq
         0SJyniKHQnjkxYOlSkYay7J9Mlc17fjE29QWq8ZrGVcUR9IqW864anxqfhPJEmEX74sI
         uXfFCtEJPtBjBow0EGICmrq49pNwQ7OwIGU1krSdDIUa/ibEnBq3DmFtPD4so4Za/xaw
         xuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ra9WJazw1Fb231ITwJYo6ORz8hO6Lpwzm+CXlVX1y8g=;
        b=P5i3MpWAuJih2ewP8JYMYQkQeMblbWc1jKS17iijA5Ai+FMo8/Fk8N9DuwV2sKjQZ5
         FVcW1b+ndGC/1UK6KTRSp0vk2zksICG1AVDr3XWFGTs88fbm3zt+hMfYIjCWr1wXJNVk
         ULVl31fCS6gl7woN/e2HHkTTyGSntwrmyG1puk9U9LgF9CFUm+sJt26R1J6c0FlevHUt
         9guguGXcg7Io6Q9D54x/F56IFXYidx7FWeeOBZ63lqZdBrgo7ENUdgU+EkE6fkZbXz7e
         zXrk5e3xyAp5nfaHdifK1GLC+ABpU5beqpoQfgVojwbcS+tlIYy+xpINkl3I1/ZB/Sf+
         CHXg==
X-Gm-Message-State: AOAM5320tFWTUefnAdADlyCscbNffS3Xpe6VOCxz7regxIP3WaTyKrAT
        VhwR/ziVmij7HWGxlb3Aq/Ibzg==
X-Google-Smtp-Source: ABdhPJz2Ri8u50Iv8oX2URJSf7giYX7VYds+V9AepF/eSWczA+mNngCA+P4sge/OTQ2auhRzKgpvKA==
X-Received: by 2002:a05:6870:d620:b0:e9:11d4:7529 with SMTP id a32-20020a056870d62000b000e911d47529mr1100194oaq.32.1650685603065;
        Fri, 22 Apr 2022 20:46:43 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm1440218oia.31.2022.04.22.20.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 20:46:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair
Date:   Fri, 22 Apr 2022 22:46:39 -0500
Message-Id: <165068558593.2759280.1092230425379952109.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408220539.625301-1-bjorn.andersson@linaro.org>
References: <20220408220539.625301-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 15:05:38 -0700, Bjorn Andersson wrote:
> Add the Qualcomm sc8280xp ADSP and NSP pairs to the binding.
> 
> 

Applied, thanks!

[1/2] dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair
      commit: ee651cd1e944df7d1553bb2c5593e887f12d6cda
[2/2] remoteproc: qcom: pas: Add sc8280xp remoteprocs
      commit: 4e55a6cf48119243ca05c16bcb3bd3887a3c68b5

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
