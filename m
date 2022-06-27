Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9CF55DC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiF0UEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbiF0UDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:41 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC121ADBC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:40 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so2086045ooj.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kg9Lplck6C1OMqSfFDk+G4buDHgPZV23JpoAqicydy0=;
        b=NonGnbSoNI1BC87eY6LKkuQ7kCQUp2Jd1xDjR/w+nrJRBAmPA7j/aNWx5fChsczAVw
         BX0eYT87O2ioJueR2lzpfLGQb7eU2B+bBgSsn/A3gH7QY8lruzBl2lRV/IVFFLYq0FI0
         sHYOWh5fZ+tRstalFzG7mS9iu758EOG1gkC6ziw1YX8eti/4dgveTLQtng7npAoSP1AD
         pn140eYHWthCY6x+MQUwg4cvZQZU9hHBTtiJnr9wNNq2K7PWME/gZiQvO7TzWMEQXb6W
         0S8Ni9A8itSK1VulCt9KQC2Q5oNGMsfSqaxt9S9UVMvNeaw9ibGaVKJSfkPH3gWwD6YB
         gfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kg9Lplck6C1OMqSfFDk+G4buDHgPZV23JpoAqicydy0=;
        b=zn2xaE62EzLunMTxk8P55Eh8wYCcKyM1VKD3lbfImboAjrBh71lq+i+fSYXtNTS9oV
         ECC0cfTlDw/COThkjevR55z790dtkbbxQEhVKyiFL0q4i80hiL9dZIHNxr9q/YTGEk26
         m2JKcF50uVgjStwU2uG6S0PPd+XmOhjkB7JlRaYy0jm67zClwGzJEk5i2U9FRbIbxy9k
         LrSimsOz9gyHZshPpv/WItooywtpAABHOGdsIY/Yg1CJxy2OpQbO0xM/rrAQ4hKgsKU2
         zFYXyvWm/Jnc1kLy4ZfUnWuED+UGlp2hYJnuebo0wIL59nlJCicszej3veEQw6w+x4/s
         kcLg==
X-Gm-Message-State: AJIora/opdMtrMMTb4Yn2zBch0A83GEtAx+3ZL7UpEgCIVldtJHr0Dz3
        waX59tKicncuQm1eDMYECcfg8pVdLurOKw==
X-Google-Smtp-Source: AGRyM1vxJ8WBOYYFjvttN0XXj2vftx4ZWg8xnp23Pud9EBsHMbFUN2i/tcaFfOEegljMuC5wel7TEg==
X-Received: by 2002:a4a:944c:0:b0:41c:18de:d334 with SMTP id j12-20020a4a944c000000b0041c18ded334mr6498382ooi.4.1656360219008;
        Mon, 27 Jun 2022 13:03:39 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: firmware: document Qualcomm QCS404 and SM6125 SCM
Date:   Mon, 27 Jun 2022 15:02:56 -0500
Message-Id: <165636016349.3080661.7253501335863287391.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622115109.6724-1-krzysztof.kozlowski@linaro.org>
References: <20220622115109.6724-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 13:51:09 +0200, Krzysztof Kozlowski wrote:
> Document the compatible for Qualcomm QCS404 and SM6125 SCM.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: document Qualcomm QCS404 and SM6125 SCM
      commit: 86b78de5fd4ba550a239dea9cade355fd58efa56

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
