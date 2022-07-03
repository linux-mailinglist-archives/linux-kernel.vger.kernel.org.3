Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B4564406
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGCD6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiGCD52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:28 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE5B7D5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so5137961otk.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5rnQK0GUcvVPxrDDSgK2p/s7lZIIHCaW7b06xKldlno=;
        b=DYTi7m5qLnMo5JlRJNelUIRaprIjr0NGrNENP5nD+6D3i7HG7mc64fRRFp5O3tk6AP
         WjXiJ+QFY37bSTblv3KMMVBrQ/CaqHPXyohPTEeOyx1TqnI9cv3sjYCUDmgq8FOiqqDS
         LvMaJOEiPr2wgxcNDVGPaM21EOBbq+YC8aTsBup6TcNWAaTwMeLA/gk9OR6/00Ax+yXc
         kN2m/lQfxCWlYOwhrOwrTVV3op9oW+GaZS3bVtX5A7jS80Gu7YvHGJwWhQjOtK+AwJ0d
         cx401bqo3um7ws3XnIRY36vH4S/G5IoCcnKd5fco4ZIq668754VthxmJAX73ctvfSSkl
         vKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rnQK0GUcvVPxrDDSgK2p/s7lZIIHCaW7b06xKldlno=;
        b=4vQO1JndkhIMFTTAi5BtzAluL963oZMld4RLbV6mWJTzZ6GS0PSR9T1pJwnS0BImgE
         bs/lMGrFVl13pno/9SNGPh79+uS2LAouq/w624ND5gA8i/+H0nG0ESXfQaxILaiQFwun
         a8d4/lEguklMOpLXoXw/YVNxGn5xREx5irDNkLbWmuK18vrTvVx2MdKBzFpyS3CWI4H5
         T41knWIg5ZhfGlIL774wdn8Gmf6gOTTeNs8JY00b/eLfLFZRC6hSxvc2eJRtumcWMc3m
         GvdIoKpsKKLQI466GGHL9sRTPClT6SBaa9kCrVVkGg8hpgvpE243duNenpDKKyJlpXmP
         bgEA==
X-Gm-Message-State: AJIora+Gsn0Nm+YffeQhrOCWxjB+UwwxkXfEb6gDquBUc07Xwg/u+JjS
        MrrRh4eYrx1b3vERbZuPfMn1j6cNwIMiUw==
X-Google-Smtp-Source: AGRyM1tle5VkdfKXJcTNzEcDT1yUEPrXg0Un5vQpHczTx94kjQFetSIREWoCva9PJLAtPXumXsV7FA==
X-Received: by 2002:a05:6830:b88:b0:616:8e13:9b7b with SMTP id a8-20020a0568300b8800b006168e139b7bmr9709557otv.186.1656820640060;
        Sat, 02 Jul 2022 20:57:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 01/12] dt-bindings: vendor-prefixes: add Shift GmbH
Date:   Sat,  2 Jul 2022 22:56:16 -0500
Message-Id: <165682055968.445910.11720677894856934867.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:39 +0200, Krzysztof Kozlowski wrote:
> Add prefix for SHIFT GmbH, phone manufacturer
> (https://www.shiftphones.com/en/).
> 
> 

Applied, thanks!

[10/12] ARM: dts: qcom: ipq4019: fix Micron SPI NOR compatible
        commit: 7afef282d7453ded3b31f71771a31b34dda51aff

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
