Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652B956C3B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiGHWTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiGHWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:19:10 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB78A2E59
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:19:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i126so342050oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I0SFAT4qZWBXThBg4GWRJ3eliYr1SjPFU1PmBCQKjY=;
        b=VT5J0T7E4pFKIRAbym9NqBOwcsZ9faKKxl5ZGxvq5TGos2qyJk3LYjB2971J4CVa7q
         bLPNudve2kGhTXpCa75rp7oBZX35RA8MEt0gya95I2iP05ugUogw4lAvCB4mE1a3NLVP
         WswMBJFw/By37sp4bLo3fDpEN9PLn7Otw8xGgqRwHs84DrAUVLORg3wNg+jnGhSsUVKc
         BxXKgLq6zI4HEGoz98/5/3wRkIb7bCTV7DxooKoEeWVwbsDFRp+bw4yxSf5TIw+lsDiO
         jpew4/bPbnk0SstHbXONoBvkEg6bQpFT/pA5pcNlOOhXHAhOifLyStFbUW7wStyZfjoB
         Jqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I0SFAT4qZWBXThBg4GWRJ3eliYr1SjPFU1PmBCQKjY=;
        b=VNc8K6jMagz69Joj5NHS/nT9Hi/tNThIbi7CF8snqhyUDARTFXfHROCoefxb+lzjDn
         BvkRXYGAdiMyMDb3iWyk/hAM6jFyRz6cn8RxPpQWXIXm9J7CqvRDqnPZx4e4gkel6wz/
         kTWKSHPjFEyqprkJou6mh27jlOco/BwAs7n3iXJ4BOM2cvAauhlQwHQLnKk02boqoVuC
         ygxC0sanRaq74QLZSzul/RR7jDoKeTjw/BqpHizhieEabrFqttQUAaGn6URPjCfmpqk5
         sbqRRSgC9Su/ETbCBKuylmE8igOCfGtsrBBvPOR/w0GEDgLnz97oAJOHT2SqUP6mUYyH
         aPBA==
X-Gm-Message-State: AJIora9NSegnkcQ41qSD78Nln9kdUrez2PEYaZu+58o4zjpvQjwPoaHS
        IjyHMVEik0EBUOSbHrrqoayTqB0lGy470Q==
X-Google-Smtp-Source: AGRyM1vY05jMLlDztoin5TcFW2xwx7InCI2TyZLrvhdC2twO+c8imYn4lby5wgw/K6LsnUrNcZ6WIA==
X-Received: by 2002:a05:6808:16a7:b0:2f9:39c4:c597 with SMTP id bb39-20020a05680816a700b002f939c4c597mr1144426oib.101.1657318747922;
        Fri, 08 Jul 2022 15:19:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y10-20020a9d518a000000b00616a2aa298asm48907otg.75.2022.07.08.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:19:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix usb_0 HS PHY ref clock
Date:   Fri,  8 Jul 2022 17:19:03 -0500
Message-Id: <165731872887.1018153.11340490580715781531.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708072358.4583-1-johan+linaro@kernel.org>
References: <20220708072358.4583-1-johan+linaro@kernel.org>
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

On Fri, 8 Jul 2022 09:23:58 +0200, Johan Hovold wrote:
> Fix the usb_0 HS PHY reference clock which was mistakingly replaced with
> the first usb_2 PHY clock.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix usb_0 HS PHY ref clock
      commit: 43883cee061f46f47ccfd251a28c879f84832a7c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
