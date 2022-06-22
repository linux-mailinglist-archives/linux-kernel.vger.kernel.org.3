Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989F55479B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiFVIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiFVIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:21:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B87381A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:21:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j22so11785829ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hH4k7mItas1ozJafGvT+HMnXj4jefZuKB4OxUVSVNAM=;
        b=mJkFkMl2HoaHNHloqTF8OhEapW5qRboQ3QqXnKasJMpkRIzVZNkat8VeBcpTvmA6fE
         i6ILOZgsDuHbTHwa+vsDXfq2jzHfqaO7eOmm9G28tI67ezFcu3tE2mjlJHgoZqVjCf3I
         GYXmqEM+WWluAHFwKj26fzP9Z1BLgV/XHWXJ7+f1NrY8u8C8wrO3EJ/U9QU1AW3PWCAD
         f2jGXng3nolkxfxTRwe7rCoQ+e7cG0mu2QxfXV5KT9d5kwL0sE+yD6Zd6vtLOIhYF6eS
         ulN+9LndwNre2tKRSZZtdFiKkNoeXQF1VNujqPEAh+KWmgxQxCiuF3h5qTAf6AbV1bQP
         SV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hH4k7mItas1ozJafGvT+HMnXj4jefZuKB4OxUVSVNAM=;
        b=aZE7xyK8dvQOx6/VN1DzuEV7oE4LodNZuKzcGZ/B8s/8QhBKiIdclHziwJF5SlXoCf
         Y7ACYGrvlnR6FnkJgZnEislagJUcBI9MzhvYHGP3Z+hDS3He+aTy5BdtVGj1ZCaNxubW
         lBJ1VFDNyziQz8EyG706upmhoazaUADxqV74vBqwUWWVFt0/chFimfFR1AgabHH2nFbg
         QgVPtLVEUx/3EMo70hC9xJbYJ+UCMVjZCGEGbh0+v+DQiGdre15reRMXvLVzORKXTnAo
         rM7XYoiqtX4ws5HyXiWhbYTGE/C3cMPNGAkAF0snQxyAwhut1+xjcdcWRD24tSYRE4qa
         dqfQ==
X-Gm-Message-State: AJIora9EPv4FCXUi0owIavBrbg/GrMEjp4KKKqy7uQ/EjLr/wPAW2x2X
        2y8tyFxY1hkyokxSBT4WReGu6Q==
X-Google-Smtp-Source: AGRyM1vZI4BCaoHbqoZW1pO9dUwTGGxOVqzVqDXrvgflmNzYZJzZL3puwPzeX8wGyGh3wFeYnsEV7w==
X-Received: by 2002:a05:651c:20d:b0:255:7ad5:50c2 with SMTP id y13-20020a05651c020d00b002557ad550c2mr1159916ljn.438.1655886073351;
        Wed, 22 Jun 2022 01:21:13 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x27-20020a19e01b000000b0047975170628sm2474802lfg.96.2022.06.22.01.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:21:12 -0700 (PDT)
Message-ID: <c072077a-cc16-c8f8-fcfa-891b3357cb66@linaro.org>
Date:   Wed, 22 Jun 2022 11:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220522195138.35943-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 22:51, Konrad Dybcio wrote:
> Hi,
> 
> removing these properties will not bring almost any benefit (other than making
> some checks happy any saving some <200 LoC) and will make the lives of almost
> all people doing independent development for linux-on-msm harder. There are
> almost unironically like 3 people outside Linaro and QUIC who have
> non-vendor-fused development boards AND the sources to rebuild the
> bootloader on their own. Making it harder to boot is only going to
> discourage people from developing on these devices, which is already not
> that pleasant, especially with newer platforms where you have to fight with
> the oh-so-bright ideas of Android boot chain..
> 
> This only concerns devices released before sm8350, as the new ones will not
> even boot with these properties present (or at least SONY Sagami, but I
> doubt it's an isolated case), so other than completing support for older
> devices, it won't be an issue going forward, anyway.

I almost missed this part of the discussion (and Krzysztof had to point 
me to it in discussion of his patches).

I think this is a Sony peculiarity. At least the distributed SM8350 
(lahaina) and SM8450 (waipio) Qualcomm device trees use these properties:

https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-hdk.dts
https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-v2.1.dtsi
https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-qrd-pm8010.dts
https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-v2.dtsi


-- 
With best wishes
Dmitry
