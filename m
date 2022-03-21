Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271BA4E2C52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350283AbiCUPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiCUPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:32:45 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C5169798;
        Mon, 21 Mar 2022 08:31:19 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id q20so8786567wmq.1;
        Mon, 21 Mar 2022 08:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/5/C1gYgp4VfvcuFi8LRcN8/3RmQ7G2v7pTXWSD0gyk=;
        b=ikU2jUK8bO2Y8uvXIouxrNntLlS3zOteRo7pzh6zSJRj+Ehe9WRh/zqCub/FMm6ZFE
         8+An2O5WYwx3ZZZuaUzvuwgHA+AHZSnlyUihi/ubWUBemyi6cgTxgkdSAprvoBE0n4UM
         lF7orA/1anN4N2UpAjsL6Tqbb8u5r5J4IfutZzY4642oTcq/SQK1K/H82+C1ohgdtwnC
         JTOnvkNnkkq5xjE3IZ4/U20tLcCK29y7NARKK/EQO63LANKYmQcmFOFFN4JOE4r3LWS8
         YnzOiDlISRizVea3inz3abGIS5JeJFVCrtw+ZukGGWE5swmzIIYq5d2PueRiK8Dp+hy6
         DTMA==
X-Gm-Message-State: AOAM530i74lfKoB8ZztmbTWKiowtw+9vhMnjvvLHMoj+34QDKOLm+6WC
        yKPN83MC2Zr0UG49p7itY1E=
X-Google-Smtp-Source: ABdhPJwVJp0KtpTuBf4c2VyunnMuFCDqiKloKbAIJMgm6G95zkywhdBK4Zy0uSs2jpqDnjxCqCmmuw==
X-Received: by 2002:a05:600c:1d9f:b0:389:a1c4:f400 with SMTP id p31-20020a05600c1d9f00b00389a1c4f400mr27473867wms.171.1647876678403;
        Mon, 21 Mar 2022 08:31:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id h188-20020a1c21c5000000b0038c6c37efc3sm14255712wmh.12.2022.03.21.08.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:31:17 -0700 (PDT)
Message-ID: <24ba0e3e-b6ba-8434-059a-8bda197a74e3@kernel.org>
Date:   Mon, 21 Mar 2022 16:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 14/18] dt-bindings: clock: Convert qcom,krait-cc to
 yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-15-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321144825.11736-15-ansuelsmth@gmail.com>
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

On 21/03/2022 15:48, Ansuel Smith wrote:
> Convert qcom,krait-cc to yaml Documentation.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
