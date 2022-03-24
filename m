Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80194E625F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiCXLXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiCXLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:22:55 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7C558B;
        Thu, 24 Mar 2022 04:21:23 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id lr4so41755ejb.11;
        Thu, 24 Mar 2022 04:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vCtXvC6NKv02vJBz9LwhC/wnC/pxcDKfv/yu+jbUxCw=;
        b=WnO7W+D4zCkjflkpcOP6eubCKOXUG6KE9hdKLdtEuHdptehxDwpXj2+qGniJaBTKIp
         DinDQwothfNOcKDlBMZ8SQf2wlnnmcNdkYIcd5I3fI6CumuDlTQRge6ZiKF+nr8bZ2r5
         ELkMmHIKQipkIlLTjdWwLP9Z2HuZaAmrE3PPMKimlIYYkG9DpAEXh/hS3BsXf8DVK7ot
         uedAtZ5M6vmGHfW5YYR4XHASL+CI03fnRu65Uvz6xSTMojjWJP4poOqzln5cKs3Jzuih
         O8KyKYVEsISybRwuFl042cQCQdx2cZco0tnZee5J0BAyAk+eptpem/8W07teWN6MCF6K
         yOUg==
X-Gm-Message-State: AOAM5323g5yljcOwtN9l/p40SrEQvqC9Z5sUdRIjHDXsilL7QWdSbOAd
        L0/UJ4r2s1K8MQ6UZvFdMuQ=
X-Google-Smtp-Source: ABdhPJyCTxGliZdVLfNGUT8I7TgpabWX5335rJB94c1ko8edVYQAv0GtvE97R3/yB5clVvYbu1npPQ==
X-Received: by 2002:a17:907:c05:b0:6db:f118:8834 with SMTP id ga5-20020a1709070c0500b006dbf1188834mr5284672ejc.536.1648120881620;
        Thu, 24 Mar 2022 04:21:21 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id a18-20020a1709063e9200b006e0527baa77sm996889ejj.92.2022.03.24.04.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:21:20 -0700 (PDT)
Message-ID: <b15567c7-98e9-2d01-d1a5-7675136c625d@kernel.org>
Date:   Thu, 24 Mar 2022 12:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: clock: fix dt_binding_check error for
 qcom,gcc-other.yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220323194248.26970-1-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323194248.26970-1-ansuelsmth@gmail.com>
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

On 23/03/2022 20:42, Ansuel Smith wrote:
> qcom,gcc-other Documentation lacks a '|' for the description. This cause
> dt_binding_check to incorrectly parse "See also:" as a new value.
> Add the missing '|' to correctly parse the description.
> 
> Fixes: a03965ed1310 ("dt-bindings: clock: split qcom,gcc.yaml to common and specific schema")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reported-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
