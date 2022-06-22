Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B3554853
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353181AbiFVL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357066AbiFVL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:58:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839893CA5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:58:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g25so33657395ejh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TubmODShT3jlb3v00kGpERu9RrmPlpU/0Z9qGMR5zOs=;
        b=UYhfGGFbTwqGWb2uOb2hIeLMZDiVaGsArTQT5CtqWMJr/DQwpOs9zzcruTjSyElnZQ
         XLhlSYZvIg8ahvqehcovOnsU/B4gqFkMs/tua5li1r4YkkcxVaYAR3Ct5TcE7hwjbbEx
         +Lg5XIgKixE3Er2SvaxrtIMOuAwzZ2l/qZD06lT/nud2Cg2ZlbQspppvdEUj4rcMDEvU
         tN5BLe84ZtJrVm26EqM8CaJF1eaNv59c7klw9ROBx/GlMvjY5Cd16lzqG0jO8wXJQ7ig
         9UBnc/YjkxMLHPJBlPUHIDzuyMD2mMZZQOo+/LlBrIZ8pNB5s593b4lwjF6zIQqW5uz9
         WMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TubmODShT3jlb3v00kGpERu9RrmPlpU/0Z9qGMR5zOs=;
        b=G+1e3dMdm4zvzt3HA9sNuXshg+lKRG/O79khX0ypWKsUD+Z2L0i6AIuW9z6QZ2k/tc
         AtIthVw3Mo3DnpSuwRlZfW0GzPrEyVbAdllj4Rr5Vhccng2IA+Kd1M+zKoAks5jUsZvv
         hnNi4D9jKKa+TMc1Fo6gn7N2idWZsEtU6IWz/PhoqggLuHMQr6A5bZQYzAHFh8lSTzSa
         wcVeNAEP0CcJcqp4Xu/vHKdhMsPslzfyKV5oQo8W3Fj0iDAXnjhX/up0S+Gwt+LJSEB2
         CssOxhu8dZFKYVprmA92v9Vew//cHGXgTEWq6+kNHU5bh6d5eEz9sPWQPdkaenJAP1E6
         U4Bw==
X-Gm-Message-State: AJIora9H/gHygEfCFnDceUEfAvlNdn5plbuSKNVQNe9wOK4pZS7+h5GF
        cNTcPZOwUfhg2luGAaAwXDIfHg==
X-Google-Smtp-Source: AGRyM1sShVPcdJqilUZ2pSQF6ujR77qLdps0duCEkxqzuEYxDASdWz1FiZ4LSBwOe0AJHI8FJUr52A==
X-Received: by 2002:a17:907:3f95:b0:722:abe4:5132 with SMTP id hr21-20020a1709073f9500b00722abe45132mr2828914ejc.757.1655899135084;
        Wed, 22 Jun 2022 04:58:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qw21-20020a1709066a1500b0070c4abe4706sm1746212ejc.158.2022.06.22.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:58:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, robh+dt@kernel.org,
        pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com,
        jacek.anaszewski@gmail.com
Subject: Re: (subset) [PATCH v2 3/3] ARM: dts: exynos: add function and color to aat1290 flash LED node in Galaxy S3
Date:   Wed, 22 Jun 2022 13:58:50 +0200
Message-Id: <165589912783.8422.8897560005665418003.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620175033.130468-4-krzysztof.kozlowski@linaro.org>
References: <20220620175033.130468-1-krzysztof.kozlowski@linaro.org> <20220620175033.130468-4-krzysztof.kozlowski@linaro.org>
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

On Mon, 20 Jun 2022 19:50:33 +0200, Krzysztof Kozlowski wrote:
> Add common LED properties - the function and color - to aat1290 flash
> LED node in Galaxy S3, so we can drop deprecated label property.
> 
> 

Applied, thanks!

[3/3] ARM: dts: exynos: add function and color to aat1290 flash LED node in Galaxy S3
      https://git.kernel.org/krzk/linux/c/ebadc8a63645f7923dc63154ad8d290313f03101

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
