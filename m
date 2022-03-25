Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1C4E6ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiCYH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiCYH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:27:16 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9CBD8B7;
        Fri, 25 Mar 2022 00:25:42 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id dr20so13604059ejc.6;
        Fri, 25 Mar 2022 00:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PGD5QqaGJRv1esnTF6Tb03pd+mwDyDYap4xXF2trhtU=;
        b=4uHzH7TJ4O5h2gVSOl+g+ZAaZW7BL6UB5b01MQed+ezJYXnE7bw7rNEkBvijH3PK+X
         3e4j+OXDK8jhE1Y/txdyYP7lSwun19TVbTlT4XzXud444Rd7P+4zhZyWsT/R1bU2vyi1
         D3yZ1Jil45GeHzaT1U6kZKKTwFT1SFEu+mHl8Cv+oi82R0jBRZo2EPFSUJUiVQdFPrjP
         fWlggijqk+eIam8f4dXbjT9IYNaMcF7LCYpQkRRyJPyXCryFKv/vasCEE2JtpVKNERGC
         541X0hEEnIA0C2vbVnbIbuqwXkTZM3uj91siOKXeuFnkhtyoc02WlpfxpAXfqrp9nVMt
         kmxQ==
X-Gm-Message-State: AOAM531e5vGyuJ35G1WGxEOoPVBsMR/xZGOyepG5nmFzaMfLBD22Mk0n
        BYdMP3jT4PbP1ATiTqMKens=
X-Google-Smtp-Source: ABdhPJxc+c0/rm44/n4LJplb86pnVU2nq6rmC9C5azx3YO+GWv/j7x1WVmHxMjH7HZ/yrjNGyUaxLw==
X-Received: by 2002:a17:906:9f28:b0:6df:f811:5286 with SMTP id fy40-20020a1709069f2800b006dff8115286mr9617360ejc.745.1648193141250;
        Fri, 25 Mar 2022 00:25:41 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm2027917ejc.99.2022.03.25.00.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:25:40 -0700 (PDT)
Message-ID: <2e16716b-b3d8-5730-f10c-f0be9526d5c4@kernel.org>
Date:   Fri, 25 Mar 2022 08:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: clock: fix dt_binding_check error for
 qcom,gcc-other.yaml
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323194248.26970-1-ansuelsmth@gmail.com>
 <20220325004910.E0246C340EC@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325004910.E0246C340EC@smtp.kernel.org>
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

On 25/03/2022 01:49, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-23 12:42:48)
>> qcom,gcc-other Documentation lacks a '|' for the description. This cause
>> dt_binding_check to incorrectly parse "See also:" as a new value.
>> Add the missing '|' to correctly parse the description.
>>
>> Fixes: a03965ed1310 ("dt-bindings: clock: split qcom,gcc.yaml to common and specific schema")
>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>> ---

Just to clarify:
This should go with fixed commit (a03965ed1310), so maybe for this merge
window (I don't know the plans for a03965ed1310).


Best regards,
Krzysztof
