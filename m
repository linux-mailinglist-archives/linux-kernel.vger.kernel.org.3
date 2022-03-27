Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B894E89A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiC0TXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:23:16 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A7344FC;
        Sun, 27 Mar 2022 12:21:37 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id i67-20020a1c3b46000000b0038ce25c870dso3693765wma.1;
        Sun, 27 Mar 2022 12:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IaJrh1ErRQ9WrEhGm0JWdX4xd9exVXf/cDGcs4E02+o=;
        b=7GjXva75njwE+kMAu+PKtSHyRNZTsRRnyNTPIKqnCiMKrZ8pQbC4lugQqUxSHdGeVS
         f94Jwrz9PtyMj67SInCpeHR+egfmh0elSp4AYV+M+l66tVCaIFunKWbmzzeT7PAwglKe
         7+1lqKVb8gtmCc8YVl19EkR3kpJs4alaDVsOLtInLVk7nHBX/dz0XNop9DHWjx+RcuTY
         4Ypx7wWXMFdIbsvQUPT38H+spSPkVEZ6ECchYWc9L/5cM6NA5qHtZjwNezejS4CloKyR
         TlkcH5nwvT5/WBAiyo+dywYte67Dk6K5RSfaypbBHEX8J+HW89ohB1g6BIG1Vx42HTrR
         owOQ==
X-Gm-Message-State: AOAM531VMtYkkVBzPqnhFQrAXJUj5MPfjtAJ8mOwGPEck0KcAuT3bEKz
        pZdPhAlFkO3BUnOc/BKc8tk=
X-Google-Smtp-Source: ABdhPJyhcijWpjbV0TupkyN0gc2p7xTf0Ai7n+xMGKYV/s5GpiyhjrG8GQQ2f3hFSsyaasj8BeuGPA==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr30102288wmb.157.1648408895809;
        Sun, 27 Mar 2022 12:21:35 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id e8-20020a05600c2dc800b0038d05f2b34dsm1612263wmh.2.2022.03.27.12.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:21:35 -0700 (PDT)
Message-ID: <42c32324-ce22-ae37-6118-35590f4e355c@kernel.org>
Date:   Sun, 27 Mar 2022 21:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: spi: qcom-qspi: Add minItems to
 interconnect-names
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326212134.45759-1-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326212134.45759-1-singh.kuldeep87k@gmail.com>
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

On 26/03/2022 22:21, Kuldeep Singh wrote:
> Qualcomm QSPI DT spec says interconnects has minimum length 1 and
> maximum length 2. Same configuration will be applicable for
> interconnect-names. Schema currently depicts interconnects length
> correctly but not interconnect-names. It can have a single entry, which
> is a valid case yet to be incorporated in the current configuration. The
> schema tries to look for 2 names and fail for DTs with a single entry.
> Thus, add minItems property to interconnect-names to fix it.

Thanks for the patch.

6 sentences which explaining the same, which could be written in one
sentence. In the same time you actually do not explain whether having
one interconnect is correct. You just say what DT spec says about
interconnects, but maybe that's wrong.

So either keep just one sentence or really explain why one or two are
allowed (based on datasheet for example).

> 
> With the change applied, below interconnect-names values are possible:
> ['qspi-config'], ['qspi-config', 'qspi-memory']
> 
> Fixes: 8f9c291558ea ("dt-bindings: spi: Add interconnect binding for QSPI")
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)


Best regards,
Krzysztof
