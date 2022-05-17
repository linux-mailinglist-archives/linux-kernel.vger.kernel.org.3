Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCE529DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiEQJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiEQJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:20:11 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270D2AE1B;
        Tue, 17 May 2022 02:20:00 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id eq14so13961686qvb.4;
        Tue, 17 May 2022 02:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Cj6phUb1dq1rPNMVBa9CpWp1pNYYkNb3ArN0qD91+8=;
        b=i1n4q6uRdZqUJHz4D4CfB+nI3eWIn6hf1NdyolBZ3x07Yvopl74Wjqx6jnAbbOdhgr
         ozyQUcfylcxTFa0oPex5P8rWVuke9H2cYDeA9dfi5HiIdlFYKVEstJ4vp2kBY22+fu8W
         peTBCzdM1cdZ1fJaceDnJk9QMQe4YGBqx/dso50SFmVFn7L8JvQUJpMqVljDDwU1mJ/w
         qKzBahO5Q8hHrOiNAugA/DnkhbZuAuB+aQ64mopdJX6oZ/xQJAq1OG8EnVifFP5+BXa7
         OYWl5/J9OvN+LGVJ6/8QTTYpcxe3v1GZ6QNHMDqXHKfQveZQBwbV5w0R715udbeagszf
         DiPw==
X-Gm-Message-State: AOAM5308pSS3q4s9+ZAmTqoaKOgO0+uchp93jWNobrMibPvHbbb/P37W
        aC1jWKjjwtibke/28htG59tM52X8aMzTFw==
X-Google-Smtp-Source: ABdhPJyR1cH1VuhH0NvrMXhcDLyXA/AePoZfxLkI+4sapl3PTrHlC9WUXeOA0SZTXSRpCa0dSvf9Eg==
X-Received: by 2002:a05:6214:768:b0:45a:afdf:ae39 with SMTP id f8-20020a056214076800b0045aafdfae39mr19083851qvz.113.1652779198957;
        Tue, 17 May 2022 02:19:58 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8748c000000b002f39b99f68bsm7285672qtq.37.2022.05.17.02.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:19:58 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id j2so31494426ybu.0;
        Tue, 17 May 2022 02:19:58 -0700 (PDT)
X-Received: by 2002:a25:4150:0:b0:64d:7747:9d93 with SMTP id
 o77-20020a254150000000b0064d77479d93mr13270137yba.36.1652779198364; Tue, 17
 May 2022 02:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 May 2022 11:19:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVc3kShpp8wieX1SSA8-37m8PbxpqKRs5+gxz8Dm6QwsA@mail.gmail.com>
Message-ID: <CAMuHMdVc3kShpp8wieX1SSA8-37m8PbxpqKRs5+gxz8Dm6QwsA@mail.gmail.com>
Subject: Re: [PATCH 00/13] dt-bindings/arm64: dts: qcom: minor cleanups with
 DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 5:13 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The patches are independent, so they can be picked up as is (or everything
> through Qualcomm SoC tree).
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (13):
>   dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
>   dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
>   dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
>   dt-bindings: usb: qcom,dwc3: fix clock matching
>   arm64: dts: qcom: add missing AOSS QMP compatible fallback
>   arm64: dts: qcom: correct DWC3 node names and unit addresses
>   arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
>   arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
>   arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
>   arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
>   arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
>   arm64: dts: qcom: align DWC3 USB clocks with DT schema
>   arm64: dts: qcom: align DWC3 USB interrupts with DT schema

Looks like all but the first two were applied to usb-next by Greg,
causing conflicts with the soc/for-next tree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
