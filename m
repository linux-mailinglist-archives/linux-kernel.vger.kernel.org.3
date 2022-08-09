Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9481558E3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiHIX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHIX4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:56:30 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B677822B;
        Tue,  9 Aug 2022 16:56:29 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id x64so10945126iof.1;
        Tue, 09 Aug 2022 16:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cUmU0GC1UDSnmJIVXi+8Ee4MtJwwMLWlPOVyazdN9nY=;
        b=gggOX8JIHFgYj49ATvlI9J1ujz4dAt0ZM5uOzRQ0+K4ng3v3DaJ6rgRkA0xtWg5kw6
         ZaQ91IDhWAFVZz454+21ABE4xisM892D4nKo4F+XLKAwSg8KSi9AuBmoUZ3IAiyacfsS
         551ul8O0UmKKtHpyuJnEiMkbRXnhtO50sle2BJCHqfdygrvA+UdZQEIKy3vb/ydKjXjz
         q6Ig2AtmwcPAeliS7eG17wJqO4IT9ryXvQFpWlQcv/BeKGzreh27GvumAezGrYSNoSNg
         tr1F5yACkcefmtnykK71xrQvLX8xjQn16Yaq5DAMElQ3qMXDsaZIEM5A3B92AhJw4BLB
         pt5g==
X-Gm-Message-State: ACgBeo2BYy8h6QDjnVSK8lEQmXVyGJdMfdghUqmKOxuPhXSvQqQePG/V
        O982HL21aO86DHsxVgVNyyuzcOF9ZQ==
X-Google-Smtp-Source: AA6agR5qxvy7CdtVRG9jiGXSr7Vt8aDiVERxPZIrGVpkhfJWW35dEu/5hZcoDydvcPduGht/pQei7Q==
X-Received: by 2002:a05:6602:3c8:b0:672:4e60:7294 with SMTP id g8-20020a05660203c800b006724e607294mr10329634iov.17.1660089388879;
        Tue, 09 Aug 2022 16:56:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j2-20020a056e02014200b002df56aceb87sm1565516ilr.60.2022.08.09.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:56:28 -0700 (PDT)
Received: (nullmailer pid 2776475 invoked by uid 1000);
        Tue, 09 Aug 2022 23:56:25 -0000
Date:   Tue, 9 Aug 2022 17:56:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <20220809235625.GA2775377-robh@kernel.org>
References: <20220626191630.176835-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626191630.176835-1-david@ixit.cz>
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

On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>  - filled many missing compatibles
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - added subnodes, there are two not converted to YAML yet, but it works
>  - now it prints milion directly unrelated warning to this binding
>    (it's related to the included subnodes bindings, can be merged,
>     but it'll generate more warnings and preferably anyone can takeover
>     from here)
>  - add qcom,pmx65
> 
> v2:
>  - changed author to myself, kept Caleb as co-author
>  - moved nodename to properties
>  - add nodenames for pm* with deprecated property
>  - add ^$ to pattern properties
>  - dropped interrupt-names property
>  - added reg prop. to the nodes which have register in nodename
>  - added compatible pmx55
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
>  2 files changed, 191 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 

As this hasn't been picked up, I applied it. Thanks!
