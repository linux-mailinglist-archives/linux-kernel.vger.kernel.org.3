Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6256748C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiGEQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGEQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:39:16 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875862F2;
        Tue,  5 Jul 2022 09:39:16 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id p69so11612322iod.10;
        Tue, 05 Jul 2022 09:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zmLfujGyrugwJVr+u2X/UngU6N6GyB/BloXYkrJ74w=;
        b=P9k49MRDrAX3Vq80/xNLyK/0bqO6Mbuf9LdAa2ey3F2LMdnLh1sB4H2p4neyy0IvEj
         1LCnZMg645EM4HgRCTu5LOKdP+u2Iyvv+SVbtLD0EdzZKXEpvvdXp+0IJ0zlkZQR2RJo
         sVxJj4Oh6e2ZkR9cWmcCSmomw7FtzmAF7W4FS3EB9ckbK9dYnDozmWQc/SpEPDUCsN4/
         gcjF6NtcT7uwb93ZwkYvV8ieeZXdLiCwhxlSnDyMdRI4KiTlJcv9pESdBe9Bgx3Sw9jn
         fyjsitDyyfCjemfwDUxoOYtoMLNmtJur32u5NeiSDT0zBfdpDaYue7rxdSZKtSvICz2O
         cUOg==
X-Gm-Message-State: AJIora9VqDti9Dtjkxqt4e5XOm2q9K4qU00i7tKMSFhZNfmlMwwAq5ha
        v/AihL3q+kxCofWk/RjaKw==
X-Google-Smtp-Source: AGRyM1veDBs4v9oVVH106fmnEU7/Ou6Mg8CYe75qez47nQMn2d4/1d4FuIDfrS59L/JpyLgX2UzhRw==
X-Received: by 2002:a05:6638:1347:b0:33e:9dd1:d3f6 with SMTP id u7-20020a056638134700b0033e9dd1d3f6mr15751919jad.131.1657039155522;
        Tue, 05 Jul 2022 09:39:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d202-20020a6bb4d3000000b0067275db775fsm15669679iof.36.2022.07.05.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:39:15 -0700 (PDT)
Received: (nullmailer pid 2236594 invoked by uid 1000);
        Tue, 05 Jul 2022 16:39:13 -0000
Date:   Tue, 5 Jul 2022 10:39:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] [v3 1/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
Message-ID: <20220705163913.GA2234759-robh@kernel.org>
References: <SG2PR03MB5006CBD49DB3052D57A6ABF0CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR03MB5006CBD49DB3052D57A6ABF0CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:57:47AM +0800, Jimmy Chen wrote:
> This adds a LTE skus for Chromebook Villager to the yaml.

Your subject is wrong. This is not a .dts file change. Use 'git log 
--oneline' for inspiration as to what the subject should look like for 
this file/directory.

> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
> 
> The format of the added items is based on the below document.
> Documentation/arm/google/chromebook-boot-flow.rst
> 
> Changes in v2:
> - Update the patch title and the commit message
> Changes in v3:
> - Update patch title
> 
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 4dd18fbf20b68..a136b1389c2ac 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -529,11 +529,26 @@ properties:
>            - const: google,herobrine
>            - const: qcom,sc7280
>  
> +      - description: Google Villager (rev0)
> +        items:
> +          - const: google,villager-rev0
> +          - const: qcom,sc7280
> +
>        - description: Google Villager (newest rev)
>          items:
>            - const: google,villager
>            - const: qcom,sc7280
>  
> +      - description: Google Villager with LTE (rev0)
> +        items:
> +          - const: google,villager-rev0-sku0
> +          - const: qcom,sc7280
> +
> +      - description: Google Villager with LTE (newest rev)
> +        items:
> +          - const: google,villager-sku0
> +          - const: qcom,sc7280
> +
>        - items:
>            - enum:
>                - lenovo,flex-5g
> -- 
> 2.25.1
> 
> 
