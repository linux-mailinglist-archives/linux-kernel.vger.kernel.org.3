Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640BE5348CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbiEZCSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiEZCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:18:22 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B0BC6F6;
        Wed, 25 May 2022 19:18:18 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l9-20020a056830268900b006054381dd35so173354otu.4;
        Wed, 25 May 2022 19:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUQ9SiZVPAN24uE2JQeZo4XP8qsZ/j7rMIYhAswoj04=;
        b=MS6oMGIKO//h3Zz3bxhLLTGFLSmaZwzN0bhupsGCqsBvTP3uHkUDVZXihd1MjNonhj
         XdVj1k8oahccoSiUVCSaXvax6RbX2w74nLgDx7U2QC9lXiuOXTDd+aruJdFem/6txHdj
         oBD09CxQ41yak17Stl4BlMpF5kbMYYosDfJmt8fI3ctIAcqNW0Wud1t3Iu+WoJxCK1yU
         sbf0wX3l0fld4NbSlwzq8D06Cl5ulKbfKAjZJXNohGThvNiAIvlZYYsPPpSCaf11700F
         8O/aTYGFdJEf+sYh98SmtKhZ3jNn4bTqL70j+1m9h7vAnM/TJD9qLxT0TQgoMZk4kih3
         ElUw==
X-Gm-Message-State: AOAM531Xx3Fu3tXOugQOEvKfZ3sD9jqIOSEE0aARtd+IPu2fq1lgvGRK
        YHXrMmZmwf9N4snvZ0LHHgAbYEykAw==
X-Google-Smtp-Source: ABdhPJyKdNx1ygST7g1BJvQ+OaZ3sMcoR//b5X22QjXHkasp5LxmvBz87YH+SSFEyb4r8eioLpOzVA==
X-Received: by 2002:a05:6830:124e:b0:60a:fff3:c05b with SMTP id s14-20020a056830124e00b0060afff3c05bmr9034053otp.264.1653531497982;
        Wed, 25 May 2022 19:18:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id li23-20020a056871421700b000f28a948dd2sm187766oab.21.2022.05.25.19.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:18:17 -0700 (PDT)
Received: (nullmailer pid 2930226 invoked by uid 1000);
        Thu, 26 May 2022 02:18:16 -0000
Date:   Wed, 25 May 2022 21:18:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 01/12] dt-bindings: vendor-prefixes: add Shift GmbH
Message-ID: <20220526021816.GA2930168-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 18:45:39 +0200, Krzysztof Kozlowski wrote:
> Add prefix for SHIFT GmbH, phone manufacturer
> (https://www.shiftphones.com/en/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
