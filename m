Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461A57C004
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGTWZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:25:37 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5755B6;
        Wed, 20 Jul 2022 15:25:36 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id x64so34947iof.1;
        Wed, 20 Jul 2022 15:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIsp++bbDVyKD/Z5/vhFgQa3pRLvwVR+ZdMdsFiDRRo=;
        b=cdQ5eDzB4HBOJIdzOrz2NuSpqqDYWpRU+DlcIInAQF7ON2Z67WxJYLGkrKR9p1/I5G
         JefBXUVdz+847G/U5St/Pg9oBoh2SjEC+ZgJk9SBmL7kDT/k/9R+oxktFpnYaxKkH7su
         Z1av2flrfCCFzAacN2I6Vvz2uambTM/1YZE6vffaHQVk0VKhge83p3GByUg2rLFrEuhK
         n565gz5jSJv7BRVqbfgRwOlzzHWuT+7nrAe82SM6oPe7Lause+Gz9QjD+XxYY6QLF9Gs
         IAUBIdi0d0Sl49K8Ijj9WG9IhjCk5oyUwjw0tJ08l58CTf4o1PWl3GPwg0Ijsw2GvETt
         qeFQ==
X-Gm-Message-State: AJIora/f95gFe5BawXvO1nvVT3ElqYYHIBU75qYUhhLrHaQtXPnRF6qD
        10oIEORqn7xz7hTu4CW0EQ==
X-Google-Smtp-Source: AGRyM1tg7SvigfOEEcStrtyZkuB8cWXU8g/ZpktekU4iRTeaV7FOppBvkGsITcfUZXJM1ClbHUHDWQ==
X-Received: by 2002:a05:6602:1587:b0:67c:b28:6e90 with SMTP id e7-20020a056602158700b0067c0b286e90mr8219759iow.16.1658355935299;
        Wed, 20 Jul 2022 15:25:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a18-20020a056e020e1200b002dd06902010sm95509ilk.42.2022.07.20.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:25:34 -0700 (PDT)
Received: (nullmailer pid 4090930 invoked by uid 1000);
        Wed, 20 Jul 2022 22:25:33 -0000
Date:   Wed, 20 Jul 2022 16:25:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        martin.botka@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org, jamipkettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a
 compatible for SM6375
Message-ID: <20220720222533.GA4090870-robh@kernel.org>
References: <20220716192743.454168-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716192743.454168-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 21:27:41 +0200, Konrad Dybcio wrote:
> Document the compatible for SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
