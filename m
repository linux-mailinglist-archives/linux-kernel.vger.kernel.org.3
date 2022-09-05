Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C15ACCD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiIEHdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiIEHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:32:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6216CDF81;
        Mon,  5 Sep 2022 00:32:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z8so10167823edb.6;
        Mon, 05 Sep 2022 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KFZqMLqmCNNJgCkCjQcZg7wMtjJMqTFKiKSwJLQrOXM=;
        b=XlYbRNum2TUfQpNOtotlD5LPSnvLYdo5FfFpb7zpNS7CnyFPTqiow0Bhk5G16UaOHn
         oZpPq0KISHNHsdwjWM1MDZW7U/ys1dDPSfqzl9fe9iAtQQMC2RsTXBe08jQkEiiW679N
         8dJWxxBj4qfDOUwOsZkaYcoIfMVUItONGv6+q2V8toEQY1bG5Ewd2PK0m18YzalWFgAD
         s2UN9DtVGGWCbjN/0YgCLdzv7psTNZCc5bN3eCcSXYC++jeLrtLcOccDA3r6dulRnhEf
         AJaisC4MBm4g20p8vJNWcI6i8J182lpP885x3XW7/x5fSkATNA8csfgROStpvNov8Qpw
         j59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KFZqMLqmCNNJgCkCjQcZg7wMtjJMqTFKiKSwJLQrOXM=;
        b=p4gdL4FFs96H4M259FM3OHS2AIXhpkIXD2E/5EtJX8Vqx7xJ7cT9YBRsAdXx9iOSuu
         oWrmYaN5Mrzeku8s9gFF79BDy/8tu6QAeStkVARn0efwic5MPrVCvaSwvRDhC4NPmRHy
         RsE05FbGgc/mASEj9drPe5ChPlAbakcAcTSkMpFTwliO6nT3WH+QhK8JMqx+QrAobBDz
         RVCUkEKEV9yf/Yhm4ez06OGHc9WFpPbaSCWKDovS5FI/RJUYXgzu1l56hsIAWZ170tLD
         e7Yq9c3/rjGVuo4jEDkzIu5omUOMFqJpkCwq48FVj7NiTRPGIx3KpPdaBmBTQT/3Uvbt
         CMNw==
X-Gm-Message-State: ACgBeo2VTviUn6H5F76zgmD7b19N3hEvQCnn//sEds6Q85KbovAbqsO+
        dJFhr4CQ6AQXjbFpCuXkk7Q=
X-Google-Smtp-Source: AA6agR6QSLtTM7mbKeZS/znWAxdxGlZtU9oiulGTfmASctqcoy/oVB1kJZ3DcUuEfaFzFiFc+8p0RQ==
X-Received: by 2002:a05:6402:4407:b0:447:1026:7537 with SMTP id y7-20020a056402440700b0044710267537mr41179894eda.312.1662363165769;
        Mon, 05 Sep 2022 00:32:45 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0044e7d69091asm1771748edt.85.2022.09.05.00.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:32:45 -0700 (PDT)
Message-ID: <c5fc8d51-76e5-dace-a4c8-7de88f622086@gmail.com>
Date:   Mon, 5 Sep 2022 10:32:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/9] dt-bindings: firmware: document Qualcomm SM6115
 SCM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-3-iskren.chernev@gmail.com>
 <423bc933-2049-5bf8-b0ca-7e1ddc1f5852@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <423bc933-2049-5bf8-b0ca-7e1ddc1f5852@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 22:14, Krzysztof Kozlowski wrote:
> On 03/09/2022 20:41, Iskren Chernev wrote:
>> Document the compatible for Qualcomm  SM6115 SCM.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>
> There was such patch:
> https://lore.kernel.org/all/338f2929-aa67-bf63-2d66-5de48f6af1c4@linaro.org/

Yep, but that patch is for .txt schema, and now the schema is .yaml. So if you
applied the other patchset and then ran dtbs_check it would still complain, so
I added a patch here, in case the other patchset is not updated. I hope such
a simple commit won't cause trouble (if you merge one and then try to merge the
other).

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> Best regards,
> Krzysztof
