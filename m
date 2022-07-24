Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18857F716
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiGXUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGXUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:43:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52816D129;
        Sun, 24 Jul 2022 13:43:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t22so8944729lfg.1;
        Sun, 24 Jul 2022 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pA5BfuMOUHYHwO3N3zLiAEa59H7++ZYtYbgRtUC4lS4=;
        b=lJXN7Mz3DhZbhXRMSD1q7ouCf+C/Tq2lVQRBhzyr81PRVogA1pF7cWdnJk2GGE6BEi
         cNWiQECTbjrN8BXsDsfKAIwp3/FqrEmEw4lAMXKd5uMn1ONVR4h7jdD/Lp5J7wO1CZvu
         IKEu1Ui9mjZiVngVLJfsnRUtgh6zg/HCDXZqWE5iqtOfEL8hlVgOg+xoEwOru6aMsUVv
         8ny32y+fgPncX00nKUoKhAlDs3uGaQ0rRNhrLOL7qd85rYwLhQEtynAeUbqHOGb9aCS0
         BS0yooKkzjmULCG2M7VjKIAX1+5qKJLvlpvdaPzMgiQ/GhjOhTNDl76RVLJuE07pNQoc
         wZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pA5BfuMOUHYHwO3N3zLiAEa59H7++ZYtYbgRtUC4lS4=;
        b=RpxXjU0v4v6L5N3l2bk21hYVo1VjCyaDNJax6VYxLJtm+x6BmJqlMBUkkN5lsfuM+h
         U/eyBOYohemPeLfIXAQGEnTf4hM4+SAXOwZpC4mgkTdzUMt0EKebLVfTTm5lQbnobAXN
         jAmOJc4Rzj6FQmoSXzOxqKPjOZRjJIMyTLC8eOsedTLihKnOdYlIJUn/kahTECYqRQ2T
         0q+fhQsCO/TM4ikbl0sRBKPY6xQcYjSFj3IN7h4SrIlLtxTR4DJ6L4U7qGYdyXgEveSF
         pR0vL1bkXwjQxIxpavb7/KIKWTOhasRsz4vCvZg3UDeD1cb8ZKKNTgBrwFmsiwRgQoQN
         kdqg==
X-Gm-Message-State: AJIora/5abX/sE9qorgUV/BekBXiSZR49rfFR0pM44Sba3v8Gct880TZ
        rC8KaNFIboCv76I4EsuBlM8hivMjfNqHF2vo11I=
X-Google-Smtp-Source: AGRyM1vz4PlnN9YFCrpKpPzMIUBnbgCXz3iqng6JaKTnN1dOdYoY0ESf4MOXCwwUG0M3IxQAjIOkvQ==
X-Received: by 2002:a05:6512:2284:b0:48a:7c35:2729 with SMTP id f4-20020a056512228400b0048a7c352729mr3654822lfu.397.1658695382591;
        Sun, 24 Jul 2022 13:43:02 -0700 (PDT)
Received: from [192.168.0.108] (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.googlemail.com with ESMTPSA id r12-20020ac252ac000000b0048a833a14edsm908766lfm.201.2022.07.24.13.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 13:43:02 -0700 (PDT)
Message-ID: <5d500d42-3926-20f1-a677-3b77c4b2e8ca@gmail.com>
Date:   Sun, 24 Jul 2022 23:43:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 10.1 (SM-T530)
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
 <20220724172442.87830-4-matti.lehtimaki@gmail.com>
 <CAA8EJpqUH_v1GXEYF62Z3DBtFu_305_h4D36aCnBr38bo5HoJw@mail.gmail.com>
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <CAA8EJpqUH_v1GXEYF62Z3DBtFu_305_h4D36aCnBr38bo5HoJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.7.2022 21.55, Dmitry Baryshkov wrote:
> On Sun, 24 Jul 2022 at 20:25, Matti Lehtimäki <matti.lehtimaki@gmail.com> wrote:
>> +/delete-node/ &smem_region;
> 
> Please move this to the /reserved-memory node. having it there would
> help understanding that we are just changing the address.

I can move this to /reserved-memory node in next version. Other option
would be to have a comment here, it seems both ways are used.

>> +       i2c-muic {
>> +               compatible = "i2c-gpio";
> 
> Is there any reason for using i2c-gpio rather than blsp_i2c4?
> According to the pinctrl-msm8226, gpio14/15 can be mapped to the blsp.

The reason to use i2c-gpio for this was using the other devices with
similar node as an example. I tested and having the muic node in
blsp_i2c4 worked the same.

-Matti
