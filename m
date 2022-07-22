Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70BE57E64E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiGVSLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGVSLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:11:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8097482
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:11:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by8so6315309ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sF47G7O9fURgeWbYq6SM8JLxkTXZ90+QCRb2I+D4fvs=;
        b=fqE1UBpfr9ntPuKNYHYPRIx9xqjUyJlDyUdp5wU6l6mXMUuOGyONsUHh6gAucLpOCl
         NItaTKk0owHMCRPhfa2/XiiOyEI27zmYQ1i6dryZKwLTgfdzeffV0lwiORESIDLzPpQC
         3qZgnXAWCufbkvLvrM2xDAxDVDNLlfIyhT4YhDvUoyoPXALY9Fa65lUmkGnhVWd+e6Uw
         sVHbHbn6WQJnnLfAdh2O6KKwO8MkCSiYlZ4GPMt1Gb2KviJ8C4vNMnT6MCHUNW77sHPZ
         sKQFJ+g/WA/0W6mQDOuzzEzLqr4dYYiqhzzn6Ctv3dnNPi7dYn2snSQuetszpLde6IzK
         xh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sF47G7O9fURgeWbYq6SM8JLxkTXZ90+QCRb2I+D4fvs=;
        b=nu3jODRERQ6FkD6hFW6mUUUWY/0Nj68Ug9ga/CGH08G9ocPqEI4RVf0DtkNUfe5g3S
         jcZvCc9c72cYtO2QkFTvkXjNU9Eu1P/zMBX92M29W2oPLfAKXWfRPphBjXFWcCK3wDSN
         tqSkIGofNF7RJCdeAljCV4pbVRNyqWTswCgTQevtioYEcjB3+E9SnfeOh7t21fZ+QJHw
         8TdugwsxvWFvpG0MO118sD/j2aWWqUmInRnltVoUeMsJEZYFRBNjuWcS93NoYjWVNmqy
         RL6X97XLbFF69f6F7+vAn6m4bEcr0CSi+1Zbm1KahyEUfTr1xoF47hzCuQ/83gLbnFUt
         8Dvg==
X-Gm-Message-State: AJIora/s/N1OVxbdOME4wDGf8Ef6eauaxK1+Q07/egHre9h0OJCEU+tx
        JaPbYjmxwITuK2075vX4buR2zQ==
X-Google-Smtp-Source: AGRyM1ut/MyzG1aFPvGJobPk9EcGlGQWeCmS9H+NDOfkAZKB+g2prKmG5v0BqSshVP+aFhgspdw4tQ==
X-Received: by 2002:a05:651c:b21:b0:25d:f3d8:9776 with SMTP id b33-20020a05651c0b2100b0025df3d89776mr453477ljr.38.1658513494705;
        Fri, 22 Jul 2022 11:11:34 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id q29-20020ac2515d000000b00489cfd58ef6sm1184536lfd.88.2022.07.22.11.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:11:34 -0700 (PDT)
Message-ID: <da7d3c3c-6c9f-c639-67d8-48c2730c1776@linaro.org>
Date:   Fri, 22 Jul 2022 20:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/4] dt-bindings: qcom: Document bindings for new
 msm8916-samsung-e2015 devices
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220721235205.74741-1-linmengbo0689@protonmail.com>
 <20220721235323.75227-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721235323.75227-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 01:54, Lin, Meng-Bo wrote:
> Document the new samsung,e5/e7/grandmax device tree bindings used in their
> device trees.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.



Best regards,
Krzysztof
