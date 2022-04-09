Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C04FA7BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiDIMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiDIMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:46:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0BA177D33
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:43:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so22167375ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qFqeqNjaO9GxDFF6ku8GcKf8eCW7YzW8WlCYcuIhXtw=;
        b=k7qgK3YBC2ZfwWfBq974Auw9JESCchzvmVpnSkvd2Wh/jNBRtf2QzUXjuM6QDOC9WM
         MPpiekFZ4AAUK19lFab93vvPSScrJmv0YP9biKIdieYfTpNX6o8XQlOObgooo/n/zi/M
         Y3xoONQc85T07imeYdn+5hF3rp17wTf91pj7Q0YnA+wCbthgDElRQKF4HlvLNMGBmPSI
         EuyBB6bigXaIU+2XGPRL2IRoPpCw80QfF8g/Pf5lCM8CrVVt9vSrW3g/VFmwiimTbKRr
         60cZtoPeTk/UD1k+YWNHEth0bfD5Ng8rbGhMK7LSYif8uQrFASWeiTokQkEQpZ4ODFhA
         MXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qFqeqNjaO9GxDFF6ku8GcKf8eCW7YzW8WlCYcuIhXtw=;
        b=Kc42/U7Li4RG12rWMZwj7ndyQSL1hPH3kNKXxi7yhPsyNT7lQSwqv1VNcdKREmcuMp
         OaCVJHS3g5KxnNvsKnlobxdg7hYRKwdPoXni8UndSu2iwLXr6+4h5p2eJfNTMQERMkgp
         v4uci+LCCvVXIB7E10TvcPJ+PZv8dr2YGtI6v8EMxch9Z/Dpw3zM1fUIhcy3oNzsUG5Q
         OaeTAwwQ3H382I4/UT2tVVMH1UA2cBIoFzktytNGe6pmX3ARh3Krqnbp+504QcNSW5dN
         p8xnj8AwU2VXgK7Bpze1hXIJSS4KAgIqjvaejHALamzUgNK6JB4mQA2S/47ut+XzgiVJ
         /5Bg==
X-Gm-Message-State: AOAM5332aNYxCjFT/7H1sqFhsL9EyIxdnAK5HmX6Q0SlZmbdTSdq3FH/
        5lrZCVwztgmhgEZJdnxb3b95Mh24Zq+nfNPO
X-Google-Smtp-Source: ABdhPJwLYMPowNdTkLJ34QzaeN9tFdTwYfvdX4sZzVVl0Iw2FtIgFVDuXXt10tP1iVV/54OpJmp2hw==
X-Received: by 2002:a17:906:469a:b0:6e8:76c2:1d58 with SMTP id a26-20020a170906469a00b006e876c21d58mr1213716ejr.371.1649508236783;
        Sat, 09 Apr 2022 05:43:56 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gv9-20020a170906f10900b006d7128b2e6fsm9749886ejb.162.2022.04.09.05.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:43:56 -0700 (PDT)
Message-ID: <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
Date:   Sat, 9 Apr 2022 14:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 14:26, Mikhail Zhilkin wrote:
>>
>> In any case this requires vendor prefix.
> 
> I'm not sure that "scpart-id" is necessary here. "sercomm,sc-partitions"
> is necessary. I'm going to add vendor prefix in a separate patch. Is this
> ok?

Yes.

> 
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..65ff22364fb3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1082,6 +1082,8 @@ patternProperties:
>      description: Sensirion AG
>    "^sensortek,.*":
>      description: Sensortek Technology Corporation
> +  "^sercomm,.*":
> +    description: Sercomm (Suzhou) Corporation
>    "^sff,.*":
>      description: Small Form Factor Committee
>    "^sgd,.*":
> --
> 
>>> +
>>> +required:
>>> +  - compatible
>> Missing reg.
> 
> reg isn't required. Parser can read partition offsets and sizes from
> SC PART MAP table. Or do you mean something else?  All is ok
> without reg definition in "Example" (except the warns that reg property
> is missing).

reg might not be required for current implementation but it is required
by devicetree for every node with unit address. Do you expect here nodes
without unit addresses?

>> Are you sure that you tested your bindings? You miss here address/size
>> cells and children, so you should have big fat warning.
>>
>> Plus your DTS example has error and does not compile...
> 
> Whole dts, for the real device (not for example), was tested many times.

Yeah, I did not speak about whole DTS, but bindings and example in the
bindings.

> Thank you for your feedback! I checked the another examples and there
> are no any warnings now. But I'm not yet sure that "properties" and
> "required" are correct.
> What do you think (or what else I have to read / check)?

There is no way you tested the bindings. There are for sure warnings
because it simply cannot be even compiled. The writing-schema.rst
describes how to test it.

Best regards,
Krzysztof
