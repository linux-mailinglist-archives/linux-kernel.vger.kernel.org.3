Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFB58E3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiHIX5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiHIX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:57:44 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78180491;
        Tue,  9 Aug 2022 16:57:43 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l8so5112563qvr.5;
        Tue, 09 Aug 2022 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5ieeVHUhK9lB+3MqvAlvGIRiaFfu/R6p+XaOT3hiyPU=;
        b=JLCE7r8re+Wlwod+55zbqv3DIfdFytLLboyqhXaRwqaI8EK5xijE2JuN4ESJP7Flhw
         HsFJBaSHvqNmv8d6BOb/iRqPUz4Aink8Pe86nX28oUGWVND/4JkyyXwMPxfW9qBRH4YA
         TEdiISlxWZKp/MqgkrJedjGNvOufIo15m7Mi/QvEgPLRJ2X+ROgheUoikYs2ee/2A+t9
         tayFjWj8LE7v2TZq8nYu5Cq+yXDTybWmCyRy0UFZg4AcoOkf4P9y7X8W55c81tlP2HBj
         pxwRfkIhw9i+8zkSd8sGGxar4WYvTH6sPwz43X2Q3LAe0Awgvo5nXjSQoHcx8yKIZIX5
         9xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5ieeVHUhK9lB+3MqvAlvGIRiaFfu/R6p+XaOT3hiyPU=;
        b=5gPbLQhd3ltOvd2/KLFdV6GtsC0ZoWQiJmMa+COcKbnb/luO7HZs3Nfx+izynJUQKI
         +FFMKkVLMhB9vwe3Ahm4dGkCcv+5WHfSiSWiI2ZNGFq+GylBQlQUnEymIuxVFNBIu8Wh
         OcQejk3vuBfKD9r2aaclISCJ0opv7YsgW0Y2+i3B76nt9hkigr1i3nxlvWVPgfCM0fcx
         M+B8U98QI5S/Vas+hqTYPzERwU6WgIGTY6HoRfuBiVcBJN+VP4uzSrA0XY0TVRqD7duQ
         3IA6dl1Xpk7NGmAj8IJF2H1dsWOzokRGz4cSieLdPu8rYDxx/T11Qf/7YcGd4lQe0IIe
         TJNQ==
X-Gm-Message-State: ACgBeo3d6yWtO801wT08EJBNVdWkbW9J7dSinlUwVTmkAoiXdklQej+m
        FYi406ebEM3XnD9MwmxFiswQahY2cZSAkXIgDis=
X-Google-Smtp-Source: AA6agR4acMRXy5qzUtdJsI+ibwQkw9ggoF+j4hNPxhKBkiftE+Q6QnlF6V0u6wUfohaot6lt45HEQg==
X-Received: by 2002:a05:6214:529e:b0:476:93ab:155c with SMTP id kj30-20020a056214529e00b0047693ab155cmr22176071qvb.25.1660089462471;
        Tue, 09 Aug 2022 16:57:42 -0700 (PDT)
Received: from ?IPV6:2600:4040:2036:c00:b4e5:ed6d:fb38:84a5? ([2600:4040:2036:c00:b4e5:ed6d:fb38:84a5])
        by smtp.gmail.com with ESMTPSA id bz19-20020a05622a1e9300b00341f912e64dsm6627943qtb.93.2022.08.09.16.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 16:57:41 -0700 (PDT)
Message-ID: <479a6fa3-7214-2cca-14b0-b9b335146168@gmail.com>
Date:   Tue, 9 Aug 2022 19:57:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] ARM: msm8960: Add Samsung Galaxy Express support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
 <20220809000300.6384-2-guptarud@gmail.com>
 <27f83048-ac75-97eb-c9f0-0829de30e1ad@linaro.org>
From:   Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <27f83048-ac75-97eb-c9f0-0829de30e1ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > OK, I'll abandon the review. This file is really not matching anything

 > in the upstream. Please start your work from a proper upstreamed, recent

 > board.

I based it off of qcom-msm8960-cdp.dts. If there is a dts that you would 
like

me to model off of, please link it to me. Otherwise, I will find another 
recent

dts and model off of that

