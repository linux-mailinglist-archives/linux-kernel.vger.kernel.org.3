Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE724E5411
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiCWOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiCWOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:12:49 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21387CB38;
        Wed, 23 Mar 2022 07:11:19 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id u26so1954875eda.12;
        Wed, 23 Mar 2022 07:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=4HA4+cV5Cx2YJ/wnGG8SlUcCWZl88X9bJXGKc8DKpxk=;
        b=t7q2mFOh4vugfvEI7Ba5gtmGKveibgoNBXLkijBeHjv+/xtxVzqM8jmHfQUiRLvJQO
         i+K4X3Atk2Z83rGZ7SnElJj9FtaQOAgLebfCvSpKCTkzYKLvPk1awJ2ci/bkfvHp7YJC
         ryYwlYYqCecpUYdMJrhnntRotToD6bNeGHbjeQDRU2mdo+CQMbuG/Z0gxy4yNh06idox
         aewuDjkm8j45JrrZNyLBn/ixWFPFGBPIhAEmR1NJIvpE3aZhxmXIEk/SfyMbsCyc8WT0
         DPMfZybANYUNyJf/KJNfNpagYFLltkOIRYeLiyLy3G5WSJf0a6Dno/Cb4TgrlJ928DK5
         py/w==
X-Gm-Message-State: AOAM533l9c1ndfXUqihAilB3HttAchC0ix3TbdFpeSUpDr4+jGRYRHQB
        Lh8Q6YVd5kCWLB4XEKI6roP2N2RYjBqhkg==
X-Google-Smtp-Source: ABdhPJy0t1OjP/Hq1l00yzZQD24L/hzLXOOrAXXXbbnSzOp4xPY+DuUEXsDeBfbMxTTh3SauXo5aCQ==
X-Received: by 2002:a05:6402:4414:b0:419:28bc:55dc with SMTP id y20-20020a056402441400b0041928bc55dcmr316217eda.130.1648044678168;
        Wed, 23 Mar 2022 07:11:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm9974442ejk.119.2022.03.23.07.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:11:17 -0700 (PDT)
Message-ID: <354951e0-d2a8-bf4f-e0c5-081e836bb3c3@kernel.org>
Date:   Wed, 23 Mar 2022 15:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and imx8mp
 compatible fallback
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220323134019.3796178-1-aford173@gmail.com>
 <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
 <CAHCN7x+RLAFnES8b3UMoc6n69ZVSFGOmAZyMeeY1g3aoiDNbZg@mail.gmail.com>
In-Reply-To: <CAHCN7x+RLAFnES8b3UMoc6n69ZVSFGOmAZyMeeY1g3aoiDNbZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 15:00, Adam Ford wrote:
> On Wed, Mar 23, 2022 at 8:56 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 23/03/2022 14:40, Adam Ford wrote:
>>> The SDHC controller in the imx8mn and imx8mp have the same controller
>>> as the imx8mm which is slightly different than that of the imx7d.
>>> Using the fallback of the imx8mm enables the controllers to support
>>> HS400-ES which is not available on the imx7d.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> index 7dbbcae9485c..d6ea73d76bdd 100644
>>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> @@ -39,14 +39,14 @@ properties:
>>>        - items:
>>>            - enum:
>>>                - fsl,imx8mm-usdhc
>>
>> Your change looks reasonable, but why imx8mm is compatible with imx7d?
> 
> I saw that, and I wasn't sure the best way to go about  fixing it.  If
> I move the 8mm out of the imx7d category, do I need to add it to the
> enum list associated with the imx8mm, or can I just delete it from the
> enum leaving the const for imx8mm good enough?
> 

The DTS is using:
  compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc"
which looks incorrect, based on what you wrote in commit description.
Since fsl,imx8mm-usdhc has its own compatibility-group and defines the
properties for entire family (imx8mm + imx8mn + imx8mp), then I would
assume that either fsl,imx8mm-usdhc is not be compatible with imx7d or
everything is compatible with imx7d. IOW, DTS and bindings should be
changed to one of following:
1. Everything compatible with imx7d:
  compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
  compatible = "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";

2. A new group:
  compatible = "fsl,imx8mm-usdhc";
  compatible = "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc";

Which one, I am not sure. My commit 80fd350b95 organized it in (1)
approach, because also that time there was no new group for 8mm (added
in commit 431fae8). I assume NXP engineer knows better, so the better
solution would be (2). In such case, imx8mm has to be moved to the first
enum and all DTS have to be adjusted.


Best regards,
Krzysztof
