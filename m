Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17C512CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbiD1HcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiD1HcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:32:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932149AE74
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:28:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p18so4477065edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LzAss+yWW53YzSONceMNkK0Q7IigElaU4OnCLX+9NDc=;
        b=ExKfTnzhRCQc2W2mn0A5I7yP94j59JDTD5atexxyP/btGR4lJkhtcZ6J1YNX0GmLNg
         yaIkG852LKYA29T1UX5tH/wCQUohRdhTwcKcfPV/+ImCbeHfdyn/5rSRSVEYVvlFShuc
         gCBcdX9u5mD/n/MWVNG/AQvGnz6DiqZ8GHj/gmmIBk/ZP192kCIx+lBjCffpxJ2KtGzA
         4lQmZnOEzinIA6eCka8PA3xR8HUDDhn3i5paIvgWmWHy1GqG3yuOUT6InP4ElmxTzja9
         Z5Ij1BTqMcIg499GREScTqLwJnzkLwwrwYxeRb2q964aTeFLtDRj1hAUZsTSeUrn+ZqD
         MApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LzAss+yWW53YzSONceMNkK0Q7IigElaU4OnCLX+9NDc=;
        b=DuGLP2BwFy4U5lJRGgTWJIEpb9XoafgJtI2l2gHAMcxOUTZ+R94pIOuDGTRFPmkSUT
         a8WIS8nqvbI0YhU4qqy8PMKTl9JX6hr9cS88VNM0b5+wtnJNH1IEL6MQk7ZdTRIM4VCn
         HHAc9yOekGkpv8PCKiFBQ5tnYN533AlzCssexwckd/V70VfOT504tvFSwairlrdpxpDU
         0YgGTp4XhF6YVAsfaS3vb/Dkj0S4NAtpcFseDYcZ+Pr9n4AESa8Dg+6GmHanM2Du4e8f
         hHAEEVyZ0S/xlig1H1T/bIoH8WPIqt7kVeisLShtollRhrQX5Srlu+AS47sMRtUbQe0k
         hJeg==
X-Gm-Message-State: AOAM533sKPLah1ACD+44AYJUUEIVhJqcs+LQ0L0GHnlNiatD3VI6EIiQ
        iEiqaI708JTFJfiBlTe5fmQBmA==
X-Google-Smtp-Source: ABdhPJyK1jHpX+NE6cA3JKcnEjDunX0hlgWftKz57IHJeSxi6G2OWUgrhcIRVO9fBzAuaKhXf2RzjA==
X-Received: by 2002:a05:6402:43c7:b0:425:f1cd:5f13 with SMTP id p7-20020a05640243c700b00425f1cd5f13mr700720edc.208.1651130927826;
        Thu, 28 Apr 2022 00:28:47 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g12-20020a170906c18c00b006f3b99d29e0sm3573545ejz.223.2022.04.28.00.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:28:47 -0700 (PDT)
Message-ID: <9c93c210-dab5-8c2a-81fb-2e52e6a4d38c@linaro.org>
Date:   Thu, 28 Apr 2022 09:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Aw: Re: [RFC/RFT v2 05/11] dt-bindings: pci: add bifurcation
 option to Rockchip DesignWare binding
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-6-linux@fw-web.de>
 <ea6ccec6-81a3-b22d-46db-c31a9f1e85f3@linaro.org>
 <trinity-fcca248f-cb76-474a-8227-5b7188140bdf-1651130723782@3c-app-gmx-bs20>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-fcca248f-cb76-474a-8227-5b7188140bdf-1651130723782@3c-app-gmx-bs20>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 09:25, Frank Wunderlich wrote:
> 
> i guess same here, description+type needed, but how to describe an array of int in yaml? do you know any examples?

https://elixir.bootlin.com/linux/v5.17-rc4/source/Documentation/devicetree/bindings/arm/l2c2x0.yaml#L74
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml#L101

Best regards,
Krzysztof
