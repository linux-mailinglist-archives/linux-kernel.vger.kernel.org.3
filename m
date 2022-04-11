Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6400D4FBB0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiDKLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiDKLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:36:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2E13DF9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:34:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c64so5817829edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PriMJtte/5hgjriSNEToIdFfrLkuSVpCW0l+e7C3lOg=;
        b=YW/bjohkH5YlnoINwYy8ZTkU/kPoS6OSYhi2Nmyw7qdSMmHEjs6NR3ndPlfr4QwKhB
         3Da1O5Tfe5om2Fo0lnNVVIocYfoarmWleA9BaF0Fw/5Y0uZ1OrEzmRUS4VMyFkNRGcnS
         MaDeUeLNE7oiI86kaZTbibpAbvxLWXC6SYJKuWCDtAgdV79dKBBwn6ZfLwElfbesdWbj
         pA3EzTQ55zndlfF9NH+onk5bNc8VAUfNp4XWPRpBdEj/Nne63MNOv/B8RfvSbjsOnKVb
         5Hvl47nRTYDjy35vU4upXpJ5E795ux/CuVBX7DA3iEPxFNGUEyMCB250FS9PYrQVqoM4
         i8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PriMJtte/5hgjriSNEToIdFfrLkuSVpCW0l+e7C3lOg=;
        b=eXU9S2p2IR0rU5tSaFr9eZtSfrKSGcsxFr6rPyCN44zhUM8y/BuYCW+W9HAs8toAQE
         UBV2GgwwftG2bZZkU2376eQlVyQvPa8ULdQaLxLfc8gNkcF9wa8ehI7zs4MGIVOabo8l
         iS4fGcfs81xVSlty+FoVHwec3DDspC9enwj3SPlvm8ntjzttwJ5gfY9/UILuaeWBHNGw
         G01YLS9zRh1d+W89EFyR17Z12TS30r19/9OUznDkK+WZKGhjkdHylteHSR850JCExVnB
         HC3RVvOuC52bBtk0etELqjUIoPyFyFuwUN132J6zPGNS9O4yXour7+Rva5gA/dz1cUty
         wWwA==
X-Gm-Message-State: AOAM533qomQrfZU6zAsRJ8G1Cc6GUvzxOqYz1Yx141wJUsFE1A7hsN01
        lyopDDuHTFVueXYP4xTsRKjJog==
X-Google-Smtp-Source: ABdhPJwWKcguqGqBLwNOxShWwcd7Yc3YcqboI8pqcx86iqrVVgwAv1TKmUt48U31rdiVBxs5t/VMew==
X-Received: by 2002:a05:6402:5210:b0:419:d802:626e with SMTP id s16-20020a056402521000b00419d802626emr33267210edd.11.1649676857289;
        Mon, 11 Apr 2022 04:34:17 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm11793292ejc.28.2022.04.11.04.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 04:34:16 -0700 (PDT)
Message-ID: <aefe5080-475b-946e-d6c7-1c39dc90da1c@linaro.org>
Date:   Mon, 11 Apr 2022 13:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/2] regulator: dt-bindings: qcom,rpmh: document
 supplies per variant
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
 <20220411110344.231903-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411110344.231903-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 13:03, Krzysztof Kozlowski wrote:
> The RPMH regulator binding covers several devices with different
> regulator supplies, so it uses patterns matching broad range of these
> supplies.  This works fine but is not specific and might miss actual
> mistakes when a wrong supply property is used for given variant.
> 
> Add separate child schema which describes the supplies depending on the
> compatible.


(...)

> -additionalProperties: false
> -
>  required:
>    - compatible
>    - qcom,pmic-id
>  
> +allOf:
> +  - $ref: qcom,rpmh-regulator-supplies.yaml#
> +
> +additionalProperties: false

This should be unevaluatedProperties:false, although this makes schema
matching any property. :(


Best regards,
Krzysztof
