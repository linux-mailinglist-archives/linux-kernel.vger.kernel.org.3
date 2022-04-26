Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF250FB46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiDZKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349051AbiDZKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:45:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1641F4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:36:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so35171893ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=03JHyVcnDtVRCT1SZNlsYY6E7LDhShIBmeQH7UCWb5Q=;
        b=TLmerg/GnvN27In+YodvcDqxMfddqh49b8DPl2i75Ctw7YdreDnekmhoIONxgupBK3
         cljPnMDHPuHi+TqxLolsnnSvvO5THxbVDg7QIxBJVf+OA5hZ7yfGtDuje2WZf7gQAKt9
         nOMgs/BZ5KjfMPVQ43XeMYpOMBAJvJM9kOGEPfyXNbcTowT743xsqsfabmWcKwGsrBsS
         xP7V72u+YQwHg40v3OKtYOGtEjS3HllQvWrXtbxAM0GUMTc/OFZJtR/UYB0oZwfz+BzQ
         +c4QxCLjqHXATif+W/FxwIi6kgXHwAEJELnuUkE9MCiWiGcO8pm/Vbi5L2mned/HUKn+
         Nkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=03JHyVcnDtVRCT1SZNlsYY6E7LDhShIBmeQH7UCWb5Q=;
        b=WxKFY0IEnzdsYc3zSfVG4hyTd1SJHKgQDEFJyubedZVns+wm9sjA6xM8/ijiKHVDi4
         YVFRJ16Y2d0+YBBVD4DW61bomFn7MqO6Q1VW6thzt0WW4RH8qdjL/mVmrBuL/oeRV+ju
         0+UP0Gy00B4igjhSOQoodCjReMDfHzmwIstyFWFFWYVROIN6NRJKIh7JSoEpQQemiaUd
         vVc0EpfkdooitoRDzzBI2z6lTWyWcuKqH6T9DUbzPXNfYWwYg1d3PzJ8qB9MFn4+mgI8
         qLimQa/baGk0Z9dJCGWBz8Dn0Noxye7uCwlMSNsD+zFDJ955FYfjhweVb2fl8gXJSCdp
         4GAQ==
X-Gm-Message-State: AOAM533rJ3xm4pgCpfBKvtjd3cHxNPE7NcGSLe7g6iYS+8dNbjjQkx53
        LiM8MMvMIEOtrReO+z43g+julA==
X-Google-Smtp-Source: ABdhPJw6DaMltbJJc7Yzq1Tp0x7WQkv+N3L4u8ibEqiMFEoXnXRu3hTBOVsKOG02p9gMJClHF/WxHg==
X-Received: by 2002:a17:907:a425:b0:6f3:6b5d:a29c with SMTP id sg37-20020a170907a42500b006f36b5da29cmr15857758ejc.144.1650969393687;
        Tue, 26 Apr 2022 03:36:33 -0700 (PDT)
Received: from [192.168.0.249] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i12-20020a05640200cc00b00421058b175esm5978605edu.53.2022.04.26.03.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:36:33 -0700 (PDT)
Message-ID: <d1cd8e2c-d882-5f6b-863a-2c623fa38edb@linaro.org>
Date:   Tue, 26 Apr 2022 12:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: qcom-ipcc: simplify the example
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Alex Elder <elder@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20220402155551.16509-1-krzysztof.kozlowski@linaro.org>
 <a3edf0e1-644a-38b2-b23d-30cc01005786@linaro.org>
 <CABb+yY3uRxKdQ_Q-yvWipmOqLNbJXmJ141oYJnq1di_Yu66T_Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABb+yY3uRxKdQ_Q-yvWipmOqLNbJXmJ141oYJnq1di_Yu66T_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 16:22, Jassi Brar wrote:
> On Wed, Apr 20, 2022 at 3:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/04/2022 17:55, Krzysztof Kozlowski wrote:
>>> Consumer examples in the bindings of resource providers are trivial,
>>> useless and duplicating code.  Additionally the incomplete qcom,smp2p
>>> example triggers DT schema warnings.
>>>
>>> Cleanup the example by removing the consumer part and fixing the
>>> indentation to DT schema convention.
>>>
>>> Reported-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Jassi,
>> Do you plan to pick this mailbox patch?
>>
> Yes, I do.  I am ok too, if you want it through some other tree as a
> part of some bigger patchset.

It's not going through any other tree, so please pick it up.

Best regards,
Krzysztof
