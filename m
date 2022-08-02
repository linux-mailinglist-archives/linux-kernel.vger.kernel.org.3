Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144F58769E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiHBFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHBFV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:21:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4251AF2B;
        Mon,  1 Aug 2022 22:21:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e12so7346014qkl.2;
        Mon, 01 Aug 2022 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k7svTWijbOHvAesQ0w5EVWAjAc0X5sP2sPoMjwLsgKk=;
        b=AyTNojgznH7RvlKYPmau0BCzz169o8wYWqsBn70HAoMPN8/aWJyvyGTo7o9KwH39UJ
         0gr45C5VdX3nfPmG8K2FrQI1P8eF0o9QKW74VigdEzcpf8lI3otJyy+S2xn/mgTJW2n0
         arFvEWVQ02Zb6aTtoxL8JkFFSuawp7y4s8/QN2QsA1jSUwpTASFnNE+EidYMbIwGYZtE
         0TO/suv5+trjuqnS0zt58hvnXM27egXlgTVG/n3A9vEvP1L+qggHySmw6tyjZmQFhihD
         FWsZj5vVxR2Lyth2gC0lz/DLu4isYxtvHQRW3JwHSiH/ACfii+q8enQe86ldVe+mMyY7
         uIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k7svTWijbOHvAesQ0w5EVWAjAc0X5sP2sPoMjwLsgKk=;
        b=LRi2D2wB690LDbYfSbFKi41zoKGCid3j4DuLnbnlOneHIcCNgOURflaKzzs+an9RIa
         HdNPU9BwLLavmLDtmFSSs167CMKp+kHUzdLRhbEqfVyCkmnt8B0qadX50IPxxVkOsEP/
         EM1SVe6mr/EBhT6SjPh2UOBs6DySXDO92UfdVLo/Jex+e7QGxXxmnt6lQIZu0WALOm/K
         6suaHRKlZ6poIfdeP5R79wt/A6o3IAc9yozxVqUcMI7cQcmA13eeEDDINcFKEAxGCe/L
         wYiKoCJKdK3YsIGZ3j8fwjptvG5sBxR77QCvBMqVSClhANC0eMo2L/M/Q2A+KuZmj8dD
         L6mA==
X-Gm-Message-State: AJIora9m6Eb4JackTT1jT4qeWjxQ4TLAVqOdSPvRrFqujGmFaLb5JhMf
        KoAwA+dytp38dgFW3/TjvAY=
X-Google-Smtp-Source: AGRyM1vS/GqkW//9PDrWhcECfukLSsdFSrfigwfHztLWyzDXNbSWOeiZMRi07ZNo+/CfK63V6qP4JQ==
X-Received: by 2002:a05:620a:28c8:b0:6b5:e327:3358 with SMTP id l8-20020a05620a28c800b006b5e3273358mr13807751qkp.365.1659417715563;
        Mon, 01 Aug 2022 22:21:55 -0700 (PDT)
Received: from ?IPV6:2600:4040:2036:c00:8cba:859f:2aeb:cce8? ([2600:4040:2036:c00:8cba:859f:2aeb:cce8])
        by smtp.gmail.com with ESMTPSA id bz24-20020a05622a1e9800b003051ea4e7f6sm8377507qtb.48.2022.08.01.22.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 22:21:55 -0700 (PDT)
Message-ID: <cbccc7c3-a45e-43d0-50d9-55776579afa1@gmail.com>
Date:   Tue, 2 Aug 2022 01:21:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: msm8960: add the device node of
 USB1
Content-Language: en-US
To:     Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <76ed8999-c211-f8ea-c70c-21fddd75a896@linaro.org>
 <20220730081412.14297-1-peremen@gmail.com>
From:   Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <20220730081412.14297-1-peremen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > #include <dt-bindings/clock/qcom,lcc-msm8960.h>
Does not apply cleanly to mainline. Please include the above
