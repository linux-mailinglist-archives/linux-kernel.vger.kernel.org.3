Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2442A569A69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiGGGWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiGGGWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:22:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71D26573
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:22:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f39so29442795lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K9tr6KcnhachYdviyEdzrx/B25kvNR6jdvTIxCztc+M=;
        b=m8SLb0PXb3Vg2eJO8SbIvdWVK9IDAd+mBaFKyEB2VmiyRWoo7gJ4oK+6dub5rKs6Mc
         SF8En/qWmU2nl4466IHgX+Hm3h6XYKVVhUvHVUkjDD1P2ongoVO0LON181kFQlEEBYVr
         KU9HJhb68dRpCkBvjPz3+09CzLF9Dn2jgtIQ3SYv9tXuULNxFRbXKC9gSlvqnSsRXcom
         KTN5jXMjhXrB61iL+tYx0o/BMkQ9U+4iYMrJB8dUpPV9ieLqt6n7IOqE99tvcKu0zo4X
         wNXIPUNR6f683NkjFPNkFGEL1dZXuPcmvJ4r23lPd0ROyvgAJxXs9FcCwAzlfT32CUEV
         fTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K9tr6KcnhachYdviyEdzrx/B25kvNR6jdvTIxCztc+M=;
        b=KNRhQ0zAsvbXUh+x/A3oCLUis6ezlfK0N/VorCuD6Df8DiAk84v5OEPj7gUGC2DR5f
         GxCMN6M+jjamrFiTArC1KGmTz+ZpyWIMo4sGfMjcV8LyKg182otl6UKsnd9nFFtggZpD
         qS3hyN2SA7p2L8WO7UlBW9jtzI8jnOFQPoiGXPudRm17eBb+yLqeskbhlMhX6ULIXnIn
         sQBCzJGTfJEZw5sSw171piOD8mJoGaROGZSEaORXxvvinl8SN18NZ6l6NhiN6oNhFh1g
         afZyFFw+rfJEnqzQgwS5UHwJmCfXNdsDbtNJVjHiENaEIur5AGz8I/c/4nFlqvB0odA2
         fPLg==
X-Gm-Message-State: AJIora+3BClhBGj2RmdLCFP+eGgjCevdN2carC/52S0v3k4AfiX2lU1E
        pMLNxvw50p2NbpxO2YJM5Jg52w==
X-Google-Smtp-Source: AGRyM1se1WO4CHVfBfT/K6BtyPtkWxpUzbgz0tpvSMviOF1zQkYsa6iAW47Mb577NI8daYMc821GdQ==
X-Received: by 2002:a05:6512:b14:b0:482:a9b1:ea3 with SMTP id w20-20020a0565120b1400b00482a9b10ea3mr16254431lfu.353.1657174922060;
        Wed, 06 Jul 2022 23:22:02 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512344a00b0047f71771969sm6664533lfr.113.2022.07.06.23.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:22:01 -0700 (PDT)
Message-ID: <d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org>
Date:   Thu, 7 Jul 2022 08:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] [V1,1/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        Andy Gross <agross@kernel.org>,
        alan-huang@quanta.corp-partner.google.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <cfc2c27a-444d-8bd8-84a7-b6b1f99258f9@linaro.org>
 <SG2PR03MB5006AB4C7E356CE321F628D9CC809@SG2PR03MB5006.apcprd03.prod.outlook.com>
 <8f9651b2-ca9a-413c-d94f-9ecf3717343c@linaro.org>
 <CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 01:40, Doug Anderson wrote:
> Relevant links:
> 
> * You saying you liked the enum [1].
> * Me saying I liked them separate and that switching from a
> "description" to a comment was opposite of what Stephen had previous
> voted for [2], but could change if there was overwhelming need to make
> them an enum.
> * Rob saying he prefers an enum but lets sub-arch maintainers decide [3].
> * Bjorn (the sub-arch maintainer) landing the patch without the enum [4].

Ah, so the argument to my comment about using enum was that Bjorn
apparently prefers such way. OK.


Best regards,
Krzysztof
