Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6B544B68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiFIMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbiFIMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:12:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F81A387
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:12:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w27so30870043edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=35+OxtjxgC3eYwAbp4/2PDr0i9pDlp26elktRUGxVwc=;
        b=MzGcAx8cOg3qkErF9kdH7BugrP0alKEVzRHjKFl7onbm5VHBVIRioqj7Ufvce4vD+E
         OQQCZgAhLi4bo36II65Qz47HKCnrI0MfnwCoaSLUlQoU76vq7wt9uEFEX6A0w0nlEV1C
         GraysaFA1hBG0BFBEdfYBwKOreUyt639KhT1WtFwDijJN50hGSIi8cKl2x0PsFKQ6gVu
         uVC9GlmOl8qRmnhNU7lanJSfg2e8D2ZXZ2O1sqPjyA5z9C/mYEHzN6oeVo2WqtCvGmp7
         odEkop7niyv5iHdq61CLOypONyAYgONToGUqoYtdXqgUNuX0A8VbmjwMnj2IeTMg9jTg
         MS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=35+OxtjxgC3eYwAbp4/2PDr0i9pDlp26elktRUGxVwc=;
        b=xx+fn5ypb/QhVtGIdrdHiv8wwAeHEwuiD4TiRK2nE3Fkzb6MkCtw0rsMALlGILTwUD
         uJMfqblA4St1I9Envn2znrIhF9fiTJZzrMciODnmj/mzuwpndSg1vOgziLA2P+mFgO/N
         PPuBWH3n4l0jLt/3uiPGV0QKgNPriIeaRhb2PJk9i0AFaen6wgRS5/N/Yk2r3f/ACI3X
         Mbjerd+vGUKGWp5BfpbQH2f7ZVnkO/Kej0k4G0EJJp9v7u76dwYbMUiVpdZUQ2EheBWG
         L4a31/QwIgVQHafW9gTeU6ow63YIG6WX/Qu2ePnrxe2H+CVaC05pBeQfsJt/5mA3+Tkx
         B3yQ==
X-Gm-Message-State: AOAM531IYaY43QKht3pKuK2GiSaeLENy7dJ//ndKWFnENJlD++7NDjvi
        nIgx7BB6vhdOWM867IU3+EygOw==
X-Google-Smtp-Source: ABdhPJz0+DDVc2ZrkaX5S9IetfY47zQT7j8sKaKAcXh2Dm/QqxGZ8Bbf9nUDCVbDzQnntW97yJMLQQ==
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr44688465edx.128.1654776721243;
        Thu, 09 Jun 2022 05:12:01 -0700 (PDT)
Received: from [192.168.0.197] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906494800b0070c4abe4706sm9006250ejt.158.2022.06.09.05.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 05:12:00 -0700 (PDT)
Message-ID: <fd3ae279-eb0e-ec5b-2611-15ada34a9c66@linaro.org>
Date:   Thu, 9 Jun 2022 14:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] arch: arm64: qcom: sdm845-shift-axolotl: fix
 Bluetooth firmware loading
Content-Language: en-US
To:     Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
References: <20220609095412.211060-1-amartinz@shiftphones.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609095412.211060-1-amartinz@shiftphones.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 11:54, Alexander Martinz wrote:
> From: Dylan Van Assche <me@dylanvanassche.be>
> 
> Add hsuart0 alias, firmware name and prevent garbage data on Bluetooth UART lines
> on the SHIFT 6mq based on the Qualcomm SDM845 chip.
> I discovered that these were missing by comparing the DTS with similar
> devices such as the Oneplus 6/6T and Dragonboard 845c.
> 
> Signed-of-by: Dylan Van Assche <me@dylanvanassche.be>
> Tested-by: Alexander Martinz <amartinz@shiftphones.co>

Thanks for the patch. Instead of your Tested-by (or beside) your SoB is
needed, following Dylan's.

Best regards,
Krzysztof
