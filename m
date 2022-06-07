Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916BA542256
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442333AbiFHCAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837409AbiFGX77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:59:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEE280B19
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:35:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so24338531lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qoW1gmVljAUL2+6Knzn6x1gPtTMWpq+iXyTdn9hlFNI=;
        b=AxPXfe8Xqon4nlX+FDGyThgVp0Nb8SmKaPWlg+LsEItxm+v26x/Q/zKjDd9PdWlC0o
         Rkyh1ZjBkn+P2P0RRC6C6NFdXQeLsxI2Yo985tlacocLxk7Obpyoa173oDBH/yIjPW/o
         WkSvmlIfAQRMvMSG0gF3+POYP/X1/SbeVtj6VGXakmpPNElBmtlfytt+9VCHX9ukcGCa
         42OVURr34xEWPmvTIQ1J6Dn7qsNBN9AnI0lAMKqagsEuxZOXBZscPl3fWji8hXzn1x72
         TzqIuYdHEWuK+L9AzgIBL2YuI/C1Kzd+W5zOkCny2v9CTz1HR1joCZotKiHQDm7JNeQC
         pGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qoW1gmVljAUL2+6Knzn6x1gPtTMWpq+iXyTdn9hlFNI=;
        b=DC4+lq/eb/j1nw0RaeMKsgIenluOar0B23xD/dePJhAYZFjHs4bimaR9ncMg1ohCvl
         ftT9oPtADnd9LcY3FPlqQ008qJe3fCMJQh4lCkKTNBY1dShDHXKFfY0hsmTSXpDx0UA/
         NNoJ+gt2NZxqnd8P+i0PC5sq5H7pUgWeh/oYjwILDUFqK9Lg1p0gCr0kJkgSsQPGyKFc
         1DvdtkpcvFBg/48NxJawLsQj/Af5C6ctHJ89tRlgHBqSYJ9bzRDv8+YUYuqIPmhD5ibD
         zqHw62RHrdEZ5mnsG+tQtIKU8ta+gN3AhDQZuzNmb1nuQpsSY63jc/X8PadFmHk13I2q
         /OIw==
X-Gm-Message-State: AOAM53264LXrNC5KqKWoPlPeyi1H+LGbgWg985esFdee2GG6UaprGr7R
        jse+QGBpPrEnARDvCJI0cJrTRg==
X-Google-Smtp-Source: ABdhPJzCfE5fl1O6+eZqnTJpd4HzsWT6PV949KVeMp1srMc//o0rggoboGViIvouXtvg2Af4hURThg==
X-Received: by 2002:a05:6512:545:b0:479:b15:6671 with SMTP id h5-20020a056512054500b004790b156671mr19852457lfl.579.1654641295093;
        Tue, 07 Jun 2022 15:34:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p4-20020a056512312400b0047255d211f7sm3418559lfd.294.2022.06.07.15.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:34:54 -0700 (PDT)
Message-ID: <9077f91b-0e1d-25bc-56a9-66a500e16ff4@linaro.org>
Date:   Wed, 8 Jun 2022 01:34:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/5] phy: qcom: Add SC8280XP UNI and COMBO USB phys
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 00:35, Bjorn Andersson wrote:
> The Qualcomm SC8280XP has two pairs of USB phys; a pair of combo phys and a
> pair of uni phys. Introduce support for these.
> 
> This is based ontop of Dmitry's refactoring of the QMP driver:
> https://lore.kernel.org/all/20220602070909.1666068-1-dmitry.baryshkov@linaro.org/
> 
> A first version of this series was posted with only the UNI phy, this fixes a
> few comments and add the combo phy as well.
> 
> Bjorn Andersson (5):
>    dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys
>    phy: qcom-qmp: Add USB3 5NM QMP UNI registers
>    phy: qcom-qmp: Add USB4 5NM QMP combo PHY registers

I've noted, which symbols look close enough to be folded into existing 
namespaces. Could you please doublecheck my analysis and merge the tables?

>    phy: qcom-qmp: Add SC8280XP USB3 UNI phy
>    phy: qcom-qmp: Add sc8280xp USB/DP combo phys
> 
>   .../devicetree/bindings/phy/qcom,qmp-phy.yaml |    2 +
>   .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    |    1 +
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |  205 +++
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  138 ++
>   drivers/phy/qualcomm/phy-qcom-qmp.h           |   13 +
>   .../phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h  |  617 +++++++
>   .../qualcomm/phy-qcom-usb4-5nm-qmp-combo.h    | 1547 +++++++++++++++++
>   7 files changed, 2523 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> 


-- 
With best wishes
Dmitry
