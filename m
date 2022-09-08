Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77C5B2311
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiIHQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIHQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:05:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69320BC9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:05:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b17so13563519wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W8Bb70RnM7+M3BfzJDsvaPNXFgt0KDaRDT2dCnghNLY=;
        b=u9VZnK2sLRA3fAzJLvEGoYCyXEJz0ktGn67gxCsidBxbRnlDvl0tAqlUr9V2Lc9oUL
         sH49RJg3ivKn8Sya4z6kS78qW+TrI4GGBYmeuEOGPwBVoGemt7276gRkWyPZz71xN3S2
         egkdq7tGhPKiNhjgKFbFBKDqbJBfL4F8FTTUMLzleyEK0nZ6u3yGkCiBeUrzzMs6fus2
         /+lYsY+anOy2DwvV96q1vEUEKmF2TAmgab6KyUk5lrjnjHh+l1tD8Bn9QIEXDCtE+VYo
         9IVFhJZlSKwhVKnfG0YLJAGnJC8NXNi5nj81KXy7wwyLTgkVavcJyfWK0USat3d3l2N/
         nT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W8Bb70RnM7+M3BfzJDsvaPNXFgt0KDaRDT2dCnghNLY=;
        b=nI6R90sMfcyalbTt0J/3nD3r7zhlHhZ3SOzXlrjjKeJFagIsQ6ap25s4QhqKAsNI9a
         +T2uqSvsDdfO1BKHZiS4tHPSyzcLiZF+3IvUi06McHZqrJZ4ohWfL1Hm2K8Xk8Ez1Dly
         wq879zU49edwj9a6QNl2qv4HQzbBsf+zf6OIHKm5oxjjXdyt+lx8WWPWlwalKHUX1GAz
         PkTvuqZjniffZ8mtQXzz85h/ZUyPHytWymTiQUGwwGKYo02ozsJut5xl8XfCJs0z0cH9
         FroaGwXw3lP87TJ4/QW6FmxVJJlrd9Xbr+t43LHleFHM00g+vgNTXjobYwxyFzn+hyhR
         3icg==
X-Gm-Message-State: ACgBeo3tLFhLTu5eVdMfPv0ZlmLslO7/nDFt91oYmPsWBV0RdPNZT5ew
        PoWbuOd1Gh1uZcHqq7XVffWwQA==
X-Google-Smtp-Source: AA6agR5Rq/TrOYVS5sCsQ0Pk0Owlkd3Mi7wHEnFOUO1Xv0O4Z2VskjC8W4FofL7jR0QXRXovg/ryDA==
X-Received: by 2002:a5d:65ce:0:b0:228:d8b6:d1 with SMTP id e14-20020a5d65ce000000b00228d8b600d1mr5509935wrw.486.1662653099589;
        Thu, 08 Sep 2022 09:04:59 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b003a5ee64cc98sm3346012wms.33.2022.09.08.09.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:04:57 -0700 (PDT)
Message-ID: <0334cda1-61c8-84af-eba4-6f2f68a7cb3f@nexus-software.ie>
Date:   Thu, 8 Sep 2022 17:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8953: add MDSS
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906183334.203787-1-luca@z3ntu.xyz>
 <20220906183334.203787-4-luca@z3ntu.xyz>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20220906183334.203787-4-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 19:33, Luca Weiss wrote:
> +				phy-names = "dsi";

Hi Luca.

It looks like the phy-names property drop will go through.
Suggest dropping the above for your V2.

https://lore.kernel.org/all/20220907000105.786265-6-bryan.odonoghue@linaro.org/T/

---
bod
