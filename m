Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655F4530267
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiEVK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEVK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:27:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A806381A4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 03:27:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so21068340lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fMNwqXeV2uBe+evUoLZgmTmVyGADR/eLkrGswoXQxA4=;
        b=aiibXUoW6fGLAoY6m08x9kmFx17Wpj3QAahbMWPFXr7lHKX9J/dIS0qEnZTETp7pR6
         BXljZldyjeA/sEDbPTZZxFqRfCKzBghbv9+jA3nEv6XiAyYart5kdSwfL5uFBQFCW+4T
         SYYqBsbg6Zt+sYdVpHpUgJwkGnCl2FTaM3RyUOdqqd8Rk6MYRRvGgwtkng73huayt0mz
         3fL2gI41mb+624m0aYB4Tavh50F77LNgianztzQs8PT4RvbA3dsYUgdeqTagB4s3pZSz
         IbcZGQDhTM0R8D0rSQa16x9DxmFB1/cyNMzcZZusyBUQChqAB1DH0BtZD6QBAvRtwZZ7
         CaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fMNwqXeV2uBe+evUoLZgmTmVyGADR/eLkrGswoXQxA4=;
        b=hHGHXMEDDOFbXGu5v1my9ptnq9W2wz15+WyGxW0QDHuIu3fqmS5zKsLveWk+zFEh5X
         GMlkwmB+JZLR3cyq1IU2xpEWVm8gJ3YOpcCnel6YiLIlMxPoj4pNFzP4wE5oxmHTOPRU
         mupLNB2aagfOulIL6+H72SVo4HtgLK+FPE85kamQUo+MR9Sk7zqFh+sakmc7ErPWm/5S
         KCHcRk2xES5uKqct2CagdkNO3ZZRx52ctsCiDZTf9GeikYT85kSVPac68gItvjhlb7Mb
         3XSA/VW1yUGbFmJMyfcnltNAlZq3R4TOg/NdSAlEjWau9uLHwdvRlaIVAmnin+fMDSje
         5L4w==
X-Gm-Message-State: AOAM532qosv1rOpfJ4cucJo+cyOsHU7reTgsunvNOmJIqxx9y8vQaHJ0
        esNmwrwvMjQAIwwModfJGEQPPA==
X-Google-Smtp-Source: ABdhPJyOR4yZnga56TAbIe1Pgby+ggk+HW859Rb54J83gtSMzvrVoXi6kzlOGEy8W5sTI3Ees33A8Q==
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id bp5-20020a056512158500b00445908bad71mr12439284lfb.200.1653215219755;
        Sun, 22 May 2022 03:26:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512093100b0047255d21162sm1403396lft.145.2022.05.22.03.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 03:26:59 -0700 (PDT)
Message-ID: <eb915633-4d88-ec9a-d51a-7d5f5ecc0843@linaro.org>
Date:   Sun, 22 May 2022 12:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <35051bec-98ea-b4c5-f734-06b3f22f3562@linaro.org>
 <8a90ffbc-b376-9115-fb91-0b46d98873b7@linaro.org>
 <40f29157-52c0-001f-6c14-fb90b351756a@linaro.org>
 <20220519221227.B66D3C385AA@smtp.kernel.org>
 <CAA8EJpqjcAcoooaZ6iTSCy4B1x4=HTUgvJ4VqX_Fr_hSMEbfDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpqjcAcoooaZ6iTSCy4B1x4=HTUgvJ4VqX_Fr_hSMEbfDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 03:39, Dmitry Baryshkov wrote:
> 
>>
>> I vaguely recall that the properties had to be extracted during the
>> boot.img creation process to create a table of contents header. But
>> after some time the bootloader started scanning the DTBs directly for
>> the vendor properties and thus the header was deprecated/removed. If the
>> bootloader is doing the scanning then I'm not sure what is preventing
>> the properties from being documented and allowed. I think the main
>> rejection was that the properties were added purely to be extracted
>> during post processing and placed into the table of contents header,
>> i.e. they weren't actually used by the kernel or the bootloader. If they
>> are now used by the bootloader it sounds OK to me if they're kept
>> around.
> 
> Yes, as far as I understand, they are used by the bootloader directly.
> 

I entirely missed one part - Stephen's patches from 2015 were actually
applied and since 2015 we expect all boards to follow convention:

compatible =
"qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"

The patchset was accepted, although in the thread I do not see "Applied"
message.

Stephen,
can you or anyone else confirm that the dtbTool Qualcomm uses (and/or
bootloader) are adjusted as well to these new compatibles?

If yes, we can simply remove board-id and msm-id properties from new
boards, because 7 years was enough to switch to these new tools...

Best regards,
Krzysztof
