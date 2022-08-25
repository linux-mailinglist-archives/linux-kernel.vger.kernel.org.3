Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A476B5A0B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiHYINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHYINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:13:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF6564FC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:13:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z20so18691891ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qn5tnLFNpGNvBrf/K98/ZrzIzWDByL2/KUE+XN0e2lI=;
        b=ZAkMiEwm1HWoU57iTsHZcx4crwgdjTbODQ5RTgCOhXbJF2c2UfRpNRQByhuFrxaLt2
         /jt0tiffVj5XoGQirXeuwMRm6rDtV954NtlKcxvgyKZ1/ArLeA0aL45SW76utZHFzVhb
         m8EehFJCDeX0WZDyXTc8PLfidLri9PJD/JP82XqEsBf8Qzy54p6m+5/ltJ+3xHGe50IS
         +kTZLbTvjgmAqUYh41o3UvLDmp2TR9kDXNmQxIeY2yCe8nFQcA9R8762uEUtSHT0ckbP
         gBqwltQVcBlHAuPr+fQX3w4JFdGmbvdTN2l92vMNVEFHACvYYdFugMxeD4P9u6CHei2T
         UDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qn5tnLFNpGNvBrf/K98/ZrzIzWDByL2/KUE+XN0e2lI=;
        b=mM5Jn3NIhtD5GPW3z4WEaXK5de00H4mY4SQZTNHLOkEQ3D7Xjkxksn77WC9JiDdLXo
         WLNfVxNOp85vyqhkgbALivhdwo0CByVZiQXC3XW4sXju9XvGM6iQRCK9eD3BCLjpwRPH
         51+HfpzUP5XyCWpUYcJs9Km9bPwwO+sglsmXpfXlvkKKL9QF+NyCYT8NBLh4vUyPG672
         v3Ex+5XUH8JjpqL5r5eEMPnbsRAOmCuO5Om5PEEu8/q+MnNVk2UoK4dp0UtO79p3CvZD
         xXT684x5wWdTYUGuJjlF+9/HAICc9/MOfpd5hkV8sqUWivAKJNYKRPAt8UZJcvS9AxDU
         RUJw==
X-Gm-Message-State: ACgBeo37OpD+DdW7bsTlyr0afMxf9lCXUCKc0aIweqKCdbIjc8wQ7dIl
        LmRm1S89yh0QeUnIGXZv/5Fyyg==
X-Google-Smtp-Source: AA6agR4WcpGmr3YAjURQJ1NfYCPefM99Q4A+Vkw54i+ZJfnnK14evDd3BR8AXou5krL0fKPpiRaMWg==
X-Received: by 2002:a2e:824c:0:b0:25f:de27:f013 with SMTP id j12-20020a2e824c000000b0025fde27f013mr709733ljh.447.1661415206244;
        Thu, 25 Aug 2022 01:13:26 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id y7-20020a05651c106700b0025e42f8e771sm406559ljm.34.2022.08.25.01.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:13:25 -0700 (PDT)
Message-ID: <eb8dc532-f8d8-15ed-af12-a0d945db9a5e@linaro.org>
Date:   Thu, 25 Aug 2022 11:13:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for
 MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
 <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
 <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 09:59, Bo-Chen Chen wrote:
> 
> Hello Krzysztof,
> 
> Thanks for yor review.
> 
> From the functions perspective:
> 
> Hardware pipeline of VDOSYS0 has these components: COLOR, CCORR, AAL,
> GAMMA, DITHER.
> They are related to PQ (Picture Quality) functions and they makes
> VDOSYS0 supports PQ function while they are not including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component).
> It makes VDOSYS1 supports the HDR function while it's not including in
> VDOSYS0.
> 
> About mediatek ETHDR, you can refer to this series:
> 
> https://lore.kernel.org/all/20220819061456.8042-2-nancy.lin@mediatek.com/
> 
> To summary:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Is this description ok for you?
> If it is ok, I will put them into commit message in next version.
> 

Yes.

Best regards,
Krzysztof
