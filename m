Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3707518899
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiECPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiECPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:35:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5A2CC85
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:31:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p4so20356323edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z92TtqNZrx4pGwhJNSa83P5rI6YqvZPEHu/3Ye9xYhQ=;
        b=hIG82t34MdZuo5O6xnUk6Pjq693373tUzvKwWHDTGxAQul28qo+EG5t7qNxyGw2fMJ
         YBTW+w9vF3TrSCGTOpmdrKN0//ynsXkLypnUJ30leWymDLHv+pa8evwsqEJm2flzI1/F
         9io3qXEB/JN+HcqFOXSEXgUhS41DMgL3SYLXJvs41lYbw8op3AwgVQ9ndtWYLzugWZWu
         wDLG/q9JuJQZRvQMKcUS0ivk56MMQ0ub84g8tOb67Up7HX/NguFZc+sYZ04kiDbSMQCN
         STF14wwYoEy3+YC7BihXHnG+ois8p9/mjSh0R6r2hrh68sB49KmFETslz9Np6HTEblJV
         DYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z92TtqNZrx4pGwhJNSa83P5rI6YqvZPEHu/3Ye9xYhQ=;
        b=U4MWU09T7/mEqLOt2HfLS1SLWlNyF0A4kGU9rg+C5Ylv+8xvHn2xgzK4uznTt0cBNq
         WSgEsbAJAV71Yr7dE3ORPmdHVqIyHbHKtf9boE+Vdhu3E2N4RUFcTNun6HhnEbOuk52m
         JZtWcVzHuo8qvRaVgvBOlaGc2vtqboymiTKe/RupBjfj7+URTYCEu39ZBz67tdTYV+Wi
         GM2+zW8umtUO7ddRefH8UqPqAkNgBQ8PL15o2MoyppZ4v3FEjAmhKODi7oSFKr+hHHAC
         ucgsEHpDMW3xSOSP99AtGJiGpUNyZT+SRgif4YrGkitX9Fy96qY+uN+jD06z02PA23l7
         WzNg==
X-Gm-Message-State: AOAM533YuoVtpPaYGGQSRnJsqdHmaPkHiXckcRUlQ85NuOi7+7HiN2p/
        91tbhUyAQK4EiyLzeS6eMbileQ==
X-Google-Smtp-Source: ABdhPJw/t+sBsY7vQEN5qF5aRPB4PGFzv75oJlU5R9Ei2VuVTB7gvsbJih5P1SOe/TqyrgP1YMvZ5w==
X-Received: by 2002:a05:6402:b4d:b0:425:ec4a:a37e with SMTP id bx13-20020a0564020b4d00b00425ec4aa37emr18324721edb.292.1651591899700;
        Tue, 03 May 2022 08:31:39 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id er9-20020a170907738900b006f3ef214e6asm4692722ejc.208.2022.05.03.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:31:38 -0700 (PDT)
Message-ID: <dbcb45d6-d495-1e5d-b7ad-963096e5fe9d@linaro.org>
Date:   Tue, 3 May 2022 17:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
Content-Language: en-US
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 10:15, Joseph S. Barrera III wrote:
> Quackingstick is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
> 
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>

(...)

> +/*
> + * Google Quackingstick board device tree source
> + *
> + * Copyright 2021 Google LLC.
> + *
> + * SKU: 0x601 => 1537
> + *  - bits 11..8: Panel ID: 0x6 (AUO)
> + */
> +
> +#include "sc7180-trogdor-quackingstick.dtsi"
> +
> +/ {
> +	model = "Google Quackingstick (rev0+)";
> +	compatible = "google,quackingstick-sku1537", "qcom,sc7180";

Here and in other patches you keep adding undocumented board compatibles.


Best regards,
Krzysztof
