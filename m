Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33A45017EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiDNPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358853AbiDNPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:42:21 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8990EFF83;
        Thu, 14 Apr 2022 08:25:19 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q129so5748821oif.4;
        Thu, 14 Apr 2022 08:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGvtGvGGEIxpm5BQlfNMXTkv7Z8pGaPcOXe2M6C3Cas=;
        b=aYt6X9BzMYljJX4kKcZt1mAmjd+cndcYi0uxv33poCvLCL/lfueW8sF2m/J6tLKtCh
         18YJQw9yecW31YLCv77RtxtyY5YDdVc65vuJdriYjsPeWjV6ofVUOGg87kj2EoBtsQBD
         Ex1609o1WhFxcqVDb2hu6xvW8dgRrQywM3o4NPOfZkykHfKk+T3kZMPg7CH4TSamuvUr
         hhekA5SA8+hzk4ZC+ZMR5w7Ll+H/Xz6zPJk9NHwI6g+IWSBLgZFX5jL2PYmM1x0Eukvn
         3GKg04fQm1dMgQAE6laY1yfrN3i/bDBeGzXCudDgMccaRNfpOXUYvX0pxEOg35o6Cn5G
         T9kw==
X-Gm-Message-State: AOAM530+teyKRDnmnscr9xQKt5hl1T68csu3NHEadhVOij5bS0TsmGtw
        czGld5fDII7gdkXsf2Z8+Q==
X-Google-Smtp-Source: ABdhPJzIxerz58hWNig5nTrpL6dkloaMuyfdKXuIbiX9eWx++lxdk+IcTfSHEMKJGaZJEi6lhXlV3Q==
X-Received: by 2002:a05:6808:144d:b0:2f9:d667:19f7 with SMTP id x13-20020a056808144d00b002f9d66719f7mr1706639oiv.64.1649949919023;
        Thu, 14 Apr 2022 08:25:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be21-20020a056808219500b002fa6227ba8dsm135067oib.34.2022.04.14.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:25:18 -0700 (PDT)
Received: (nullmailer pid 2083464 invoked by uid 1000);
        Thu, 14 Apr 2022 15:25:17 -0000
Date:   Thu, 14 Apr 2022 10:25:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] dt-bindings: ufs: common: add OPP table
Message-ID: <Ylg83Ub7wuElT+Bu@robh.at.kernel.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-4-krzysztof.kozlowski@linaro.org>
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

On Mon, Apr 11, 2022 at 05:43:44PM +0200, Krzysztof Kozlowski wrote:
> Except scaling UFS and bus clocks, it's necessary to scale also the
> voltages of regulators or power domain performance state levels.  Adding
> Operating Performance Points table allows to adjust power domain
> performance state, depending on the UFS clock speed.
> 
> OPPv2 deprecates previous property limited to clock scaling:
> freq-table-hz.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not adding Rob's review tag because patch changed significantly.
> ---
>  .../devicetree/bindings/ufs/ufs-common.yaml   | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> index 47a4e9e1a775..d7d2c8a136bb 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> @@ -20,11 +20,24 @@ properties:
>        items:
>          - description: Minimum frequency for given clock in Hz
>          - description: Maximum frequency for given clock in Hz
> +    deprecated: true
>      description: |
> +      Preferred is operating-points-v2.
> +
>        Array of <min max> operating frequencies in Hz stored in the same order
> -      as the clocks property. If this property is not defined or a value in the
> -      array is "0" then it is assumed that the frequency is set by the parent
> -      clock or a fixed rate clock source.
> +      as the clocks property. If either this property or operating-points-v2 is
> +      not defined or a value in the array is "0" then it is assumed that the
> +      frequency is set by the parent clock or a fixed rate clock source.
> +
> +  operating-points-v2:
> +    description:
> +      Preferred over freq-table-hz.
> +      If present, each OPP must contain array of frequencies stored in the same
> +      order for each clock.  If clock frequency in the array is "0" then it is
> +      assumed that the frequency is set by the parent clock or a fixed rate
> +      clock source.
> +
> +  opp-table: true
>  
>    interrupts:
>      maxItems: 1
> @@ -75,8 +88,23 @@ properties:
>  
>  dependencies:
>    freq-table-hz: [ 'clocks' ]
> +  operating-points-v2: [ 'clocks', 'clock-names' ]
>  
>  required:
>    - interrupts
>  
> +allOf:
> +  - if:
> +      required:
> +        - freq-table-hz
> +    then:
> +      properties:
> +        operating-points-v2: false
> +  - if:
> +      required:
> +        - operating-points-v2
> +    then:
> +      properties:
> +        freq-table-hz: false

You could also express this as:

oneOf:
  - required: [ freq-table-hz ]
  - required: [ operating-points-v2 ]
  - not:
      required: [ freq-table-hz, operating-points-v2 ]


> +
>  additionalProperties: true
> -- 
> 2.32.0
> 
> 
