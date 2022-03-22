Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FD4E457C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiCVRvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCVRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:51:30 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE726132;
        Tue, 22 Mar 2022 10:50:02 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id qx21so37797418ejb.13;
        Tue, 22 Mar 2022 10:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vk/ZSO3ER0fyFrphC0xpBrDpNtBIFt2HDxhamjDelnw=;
        b=rv6SRZ/hkTj/+0FMejQ83/cXRXMV0J3MLWbONSu1JBhmdRs+Ehub5n/R/K2Rf9Vx8G
         eiFB2gpkhDYAG2SKeptzEG6uMIeUPjY4dbFIsRUIRT16DLg6cgv/3VcrhVCOqt7QlPzz
         zIl13fHAUiEyx3vXCsxCBTfGsV+csXB0qQOQv+/IfmElkpvwFT4P3YHY+kVTGwV7l59C
         MpXksZXC8cxIhZqrHm/AgaNT4gsUQHoT7Ncq655EpLAk22vbNM7qgWKUEZ/zmIom3ffb
         BkIE3eBnjQeATAL1HU23xIzDOpl0jAwDHpHzutcgLHr4Sd7w4pGpcy7gMc2Uq5C0FeAG
         rLVg==
X-Gm-Message-State: AOAM530a8rOyOWHiXw7Sk/vEuotgv79yTgWMcZxxeSjXRLZ0R9cLTyoD
        A1XplfwCMENF4zg1cJ3FToM=
X-Google-Smtp-Source: ABdhPJyO0ZZUiCSJheZGl9yardubhlzGcFxXYgnYBBK8HkPJXNY6FoDziIrC5squJpnva+UnLaEfYg==
X-Received: by 2002:a17:906:a404:b0:6df:f4ed:fd5d with SMTP id l4-20020a170906a40400b006dff4edfd5dmr14269059ejz.570.1647971400723;
        Tue, 22 Mar 2022 10:50:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id w22-20020a056402269600b004194f4eb3e7sm2683484edd.19.2022.03.22.10.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:50:00 -0700 (PDT)
Message-ID: <a211b7ba-05bb-2897-0dec-4a14f0b4d090@kernel.org>
Date:   Tue, 22 Mar 2022 18:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] thermal: exynos: Add support for ARTPEC-8
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220322075638.110056-1-hypmean.kim@samsung.com>
 <CGME20220322075618epcas1p3c63582c62099312db6d40d71cfbee15b@epcms2p5>
 <20220322082242epcms2p5b5e9e24a947e1d6c4b77fb9c95baf992@epcms2p5>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220322082242epcms2p5b5e9e24a947e1d6c4b77fb9c95baf992@epcms2p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 09:22, Sang Min Kim wrote:
> Add support thermal management for Axis ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> In the existing thermal management function of exynos, functions that support
> remote sensors have been added.
>  
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>

Use recent kernel for your development, so you will have updated
addresses of people to CC. I recommend linux-next as your base. If you
are using it already, then you use something too old, so please rebase.

Best regards,
Krzysztof
