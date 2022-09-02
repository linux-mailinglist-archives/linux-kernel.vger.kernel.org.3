Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311A5AA72C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiIBFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:20:55 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5618B99F;
        Thu,  1 Sep 2022 22:20:54 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11e9a7135easo2312600fac.6;
        Thu, 01 Sep 2022 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0M41M0g1zyDSIMdScglkRscM+P47aJdZuPKP2PAMAu4=;
        b=LpvtAYXIKuu3kw+LtR4zhkgYLFUkZqWLGU/67/nlDDrm2AvFlmHW5OHimX8VzX3APi
         Nheq0VtWCVHU0jARIwdKfBHdZzur1b+1STrXBZIbnoDo7Ir53kEC12LZDCgSGgqGvZ8i
         ha/uSmIrGjPYNbvLB+F6/o8fvLM0gBFJW07XDPS1NmMOQoH09rDFfGx03TqcZfbdThoc
         Bb9AD2vF+TWf9k+eQqGAfeE7fV1BjX+KGtFhsZ/FJQOkCgKPKqOf58bZUle7t9TUrpKZ
         Z1AphlNaCYC2PAuUPh/tHvn1eUX3FZyEKdAkNo+i+xAhIUeuQ7cRPNAHAumimkaMl3UK
         jvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0M41M0g1zyDSIMdScglkRscM+P47aJdZuPKP2PAMAu4=;
        b=6315xker9UT4LAQYB4Spspp9P3r/YKlDDV+fQnax0RE2A7W88ooIh3VQXprchZnxR+
         z4Q+62CfkJG28GPf/r/DA3r+nq0YdnYxhHggiwvcFpN0QF+PPyPnI2sStAV9uZwg8ZsO
         +XoNzPwDlZdf5ArcYqTHAMIKYPvgwWgRxj68r+k8ryGdObGxccnIR+egVwZivspChHCJ
         SD7Myv/5/Ap1ujJ87RTE7MNbl2vo1O/ux8QUZfsxkuY2dz06k12vNdGOkwnwj6t17s8c
         JuAeklnE/f556x5eiOg1LLZlZoYbo82hkOfYBGYNFLeu7BeqVwquncPJ5y4OgoZ3RtLl
         Wgow==
X-Gm-Message-State: ACgBeo094VcGz4CzKFQnS7AKf33dpxhSDo+2HQusfJxYFnvi2BQiqNkz
        E07ilAKovPAXNTOJsZ+tcYHEqpRRsjm1jlI/1gqG9xWdb7M=
X-Google-Smtp-Source: AA6agR6v9u9AxByCM705v0HqN1vsVuwmslKTgJMUvjgORtAELl7ikO4rppUmnfXm9qvfFTdKl6p6VJdovERU2aZcICE=
X-Received: by 2002:aca:a8d4:0:b0:343:3d2b:dbb8 with SMTP id
 r203-20020acaa8d4000000b003433d2bdbb8mr1150456oie.85.1662096053969; Thu, 01
 Sep 2022 22:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
 <20220828205723.20834-2-joelselvaraj.oss@gmail.com> <d9b5e312-4999-4410-03be-299e95bbe8b2@linaro.org>
In-Reply-To: <d9b5e312-4999-4410-03be-299e95bbe8b2@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
Date:   Fri, 2 Sep 2022 00:20:42 -0500
Message-ID: <CAF+P-ZoAooPFEK8dueEnQg5d5+K4QRmj-W0WsjyUV-btgBfYnw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: qcom: update beryllium
 compatible property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski,

> The board compatibles are not that important for ABI yet this creates
> precedence, so I am against it. Simple renaming should not be a reason
> to change compatibles.

So what should I do now?
1. Retain "xiaomi,beryllium" for tianma and "xiaomi,beryllium-ebbg" for ebbg?
2. If adding new compatible is not an issue, can I do
"xiaomi,beryllium-tianma", "xiaomi,beryllium", "qcom,sdm845" - for tianma
"xiaomi,beryllium-ebbg", "xiaomi,beryllium", "qcom,sdm845" - for ebbg

Kindly let me know if any other possible solution is present.

Thank you,
Joel Selvaraj
