Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2375B2127
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiIHOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIHOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:49:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF93F594
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:49:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s15so20206338ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ut+6+GHTEICNA7ARRyDpmqFiyJAYBfsFDNEudOIcnFU=;
        b=xKr+UIhts1BsmjNion1l0ldQVeXP4Y+ar/N1BOFGy7ziQBCK3XWgOech1R594ZmImi
         E4+Unsm5u9AG2PUL7Ks487sEC6Eqisq+kD28gjcWE/AXZfC5QrXP/kxSsMnr35Rx8rWG
         5qk6vnokWK337ypudwoY9ZEeZZy2uzYLr0MllitcR2Q45Ii+GsuykYh66ogYdGrWUsVi
         cLdwKplS2qPwlwA+b6Vgr4sCK1zn/UhrVEwXVyUmf0MYuxrbckKWV8IPDzYmDaKsM4zJ
         gQ4P+VqQZgRmuUMDPGZIEeV+dQTdVekKeH0gQhHVQPgpZTPoywgCKKoyP/ThwE4gNWG5
         nC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ut+6+GHTEICNA7ARRyDpmqFiyJAYBfsFDNEudOIcnFU=;
        b=XT0Q4Df8E9VxcWKc3pvfY1WzCITD5mBT7+ivliF0srDoJtrWo9YPPTwB6//X029HHP
         H4gl0n46HVt27UsXp7M2L+valYcddnCU31alNWYhwTbAkn6TZZRc9a8leOE00LEb11Qf
         0sVqbI+xLVl+7xEvPVeGcmj8GUstt9nnvPtcyLxwXp05GD5OmX4e6bB3aFBgIBxyy3fg
         uhKxpmyWGgOEEzxTOgL8xTO+RYEqXSQUruBQucpoobubJ5nDUE9ylgkNjWDo8l+Khjpd
         tY71oEBv+i5uRiWq1c3F8HTK4Dyqm3jgN2v6DSPdmfzdecGT3EKNQ47Ow367C4nABhf8
         pWyA==
X-Gm-Message-State: ACgBeo2W3vr2cOK5On2yhe0RSyO01VkjQD8QcAkj0r/jHZDll/vAvZlX
        OgzQMhjxTYocGIevPD/oKiWtUw==
X-Google-Smtp-Source: AA6agR521+jsUKpfWc/AlOeRJLePpE2cmN/a1UcS6slsZUu506QQ53WECHefUHSL+0tgWMS85mzEXA==
X-Received: by 2002:a2e:a4a3:0:b0:268:c24b:6832 with SMTP id g3-20020a2ea4a3000000b00268c24b6832mr2623904ljm.55.1662648576726;
        Thu, 08 Sep 2022 07:49:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b00497aae401f8sm834938lfp.184.2022.09.08.07.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:49:36 -0700 (PDT)
Message-ID: <89901095-07bf-4043-a97f-560606baaaa2@linaro.org>
Date:   Thu, 8 Sep 2022 16:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <abad381a-dfe7-9337-ff35-f657bf373d44@linaro.org>
 <CAD=FV=VmnKtx9smitqvNgmiCs-UCnLGFgbPnKd41QWeo1t3c9g@mail.gmail.com>
 <168cde58-d061-97e7-54a5-5d3cccf3ce22@linaro.org>
 <CAD=FV=VMKGOLR5uupTk9Z2vyDfCksYjJLHF6DDM36rgh+=0xLA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VMKGOLR5uupTk9Z2vyDfCksYjJLHF6DDM36rgh+=0xLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 16:38, Doug Anderson wrote:
> 
> From looking at the source code of Linux:
> 
> * allow-set-load basically says whether the core regulator framework
> even pays attention when drivers specify how much load they're using.
> 
> * On RPM then if allow-set-load is set then we'll sum up all of the
> load requests from clients and pass it to hardware.
> 
> * On RPMH, if allow-set-load is set then we'll sum up all the load
> requests, translate that to a mode, validate it against the set of
> "allowable" modes, and if it's valid then pass it to hardware.

OK, makes sense.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
