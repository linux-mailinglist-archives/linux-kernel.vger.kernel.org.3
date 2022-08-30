Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF695A6B45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiH3RwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiH3Rv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:51:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D1E11CF94
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:48:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id k18so5772215lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PSuf5+uKyRCAUiI+NXml1CeEx283tkYLDjiJC0rmPIc=;
        b=Pa38oV3EVhdVuxDZfh0mLFLLZj0UBeyf9wUuaxsSKLBOQMSwP/+JXnyg/+1bYSvB6P
         clumNFaYdbLtvk3RCoO7z7tXkfk3qhapicwWk09WHdnxzWc6l/jfpXnmuEU6KnrEz6Kt
         VofAZ3ldyFZosiRqzUpeLIlIMVS5EmYCySQI7+EOvU+4cABLf/SL19ENqRy7bEdgXjgl
         v1/C7lRGBdGDQM+im6QASqFK3eALWIvAwXYcsU/o7jVMguTS3WO9LcyxT/iQR3MKPL/T
         5U0Lw0y9tdW7IwO+/VcodE8+Mip00rT3Vv6Vl3fb1N3QUAG1skvdmwM8K6uAuldeB38q
         PIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PSuf5+uKyRCAUiI+NXml1CeEx283tkYLDjiJC0rmPIc=;
        b=OY56XUw43zaY6S5dGYg8LxY+nHefeYA/XQZX6icSOWZ8UnwUQJ0SQkf8WYXRXsYW1c
         B/k0tVDXLaWuFc/jMQz+TtWGamELLDwzh3mzGlDuMhydKgYTOYPRt2fWgTUlo00Lp94I
         8myRD1Esu49JHBszPOIGUlCYJ3tCKdrKc110sFXNMT2rjRghac6eReyaP5Ymhmxvw930
         rYEkxA/naJgxMoB4g7WHTv39Kf510YY0lWDHl9mpywLfcw1WRvY2Qew4os4MZreFWpLU
         W8ePbGooX5xy/yWHPplZ8lZIYVcAkN5fvaryGCEGrXjD7hUhMB380f6SVucEVXAN6T0C
         5Wbg==
X-Gm-Message-State: ACgBeo3YoBu53XvuYIgEvcPwOMM8MrCaTmDmIkH5APKSRa1NFpZiXaTs
        YV1DcJwBZLOXoAZejp9/q4T8pw==
X-Google-Smtp-Source: AA6agR7HZ6jJHiaVODBD57pgKGHlsu+AMUYygh3v4y+9xL4VMk3jrHV/vfKt6fcZwoaqiu0Yk7UBwg==
X-Received: by 2002:a05:651c:905:b0:261:d00c:e71 with SMTP id e5-20020a05651c090500b00261d00c0e71mr7370638ljq.407.1661881702529;
        Tue, 30 Aug 2022 10:48:22 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id n2-20020a05651203e200b0048a757d1303sm997253lfq.217.2022.08.30.10.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:48:22 -0700 (PDT)
Message-ID: <3c319873-72c9-632c-7c32-4ee909aa1e64@linaro.org>
Date:   Tue, 30 Aug 2022 20:48:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] slimbus: qcom-ngd: use correct error in message of
 pdr_add_lookup() failure
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220830121359.634344-1-krzysztof.kozlowski@linaro.org>
 <a437b91a-281d-56b3-41bf-15d9593ece74@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a437b91a-281d-56b3-41bf-15d9593ece74@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 30/08/2022 20:33, Jeff Johnson wrote:
> On 8/30/2022 5:13 AM, Krzysztof Kozlowski wrote:
>> Use cprrect error code, instead of previous 'ret' value, when printing
> 
> s/cprrect/correct/
> 

Thanks. I'll fix it.

Best regards,
Krzysztof
