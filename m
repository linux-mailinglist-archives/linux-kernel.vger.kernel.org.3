Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7605A23F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiHZJRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbiHZJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:17:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727ED6BA4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l23so1012454lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gYsFMN+g+GxD6rUR2apTN69OkkHzWFQoxe7BTU96rQs=;
        b=AKMQhvqPLk9fWOGayRMjeoSp/FWWIStRNk9RBugNq/YDB/80F8SUMqlSv1kBM/Z5Vw
         o80cWHpHnSNvQXgpTujv0Ymga4WiYey1e75FSuyZMjzDjbvD592zd0BD+7UNyTU0eDjI
         wF6ggU6GDy2hdDgI9oKox8ErkFRWppc0a2jvBdqIusPPjJMoiwJFf2UBUMOjXky3quGH
         uSMszJXOJ1f/sBmQmVNS2wAfeXCC+swXcxdTEn9j0++NsqjUT2eyIRSjtTfeEcV4DDri
         8uxqav722at4HDeFrkj0Bp7OWpifsL5OI9veT8XaCT22nKKLO2LJFYmnCw0QTPMYQ93Z
         pRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gYsFMN+g+GxD6rUR2apTN69OkkHzWFQoxe7BTU96rQs=;
        b=Zz5PTNrWuUgfkNR77p3Jt3hIudfh4T1lBu6v1K0bk1iOwumkQST2tb5SrvqLB9VR1I
         VzB++3l1bbN+NEMsB4GKoI/MIHyHjIuP1neqevl+dkvJ6+dzGxbQW0k6KJ4g4zJDmE2m
         qpyB6QJD1Of3FHduh43LlTFMU0rZwTQvlp0/ACfK0j2zhlxb59v9oFZ9iL/WNu5C4ic8
         7qdowvUCF8qPbtFIC60Gm7LS2gvLIr/Nt+iH+3wCxI1a/vkE77Uz4EwakM9BESAm8bKZ
         2xIlTpwQOs0j9LdQV8AVbH8P9q8GtYoBq6iod0YLYepOph9k/wMFzJxl3xSLEoqjksal
         sT8w==
X-Gm-Message-State: ACgBeo1q3vWXjVt4fL9MIYSnQRJkRPBliOVfnHIE/CRJfkDKv5IIa4Rg
        BWCjrFKYf4/MBjFUL/fWLqbTvw==
X-Google-Smtp-Source: AA6agR7HfMg53H9SWry1dNNIM8pJBfY/YwO3/DSSgcw7FpOTWrAGwbJuYep+jTOr8CaFXKheTFyOqA==
X-Received: by 2002:a2e:b711:0:b0:261:d3b3:706e with SMTP id j17-20020a2eb711000000b00261d3b3706emr1908025ljo.381.1661505438506;
        Fri, 26 Aug 2022 02:17:18 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05651c231300b00261e7e7b698sm386722ljb.123.2022.08.26.02.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:17:17 -0700 (PDT)
Message-ID: <56360b65-a704-d754-53f8-e6b7cb89756f@linaro.org>
Date:   Fri, 26 Aug 2022 12:17:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <20220826075332.30609-1-sai.krishna.potthuri@amd.com>
 <20220826075332.30609-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826075332.30609-2-sai.krishna.potthuri@amd.com>
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

On 26/08/2022 10:53, Sai Krishna Potthuri wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add bindings for Xilinx ZynqMP OCM controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
