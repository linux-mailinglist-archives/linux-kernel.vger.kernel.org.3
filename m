Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076C454507B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbiFIPRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbiFIPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:17:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866ED49F20;
        Thu,  9 Jun 2022 08:17:41 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id p128so2984972iof.1;
        Thu, 09 Jun 2022 08:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7CNQXhlme5eQIHXbnsgkUH7CMFXIeljNmFCXWsWvWE4=;
        b=6MG45JKnkbBSYHM2m1QGG/M7OQ7gEUAK2TycdbOCi27CbKK6/W77zRmwvBN27ho/Z5
         QxvDB9d1Qqs7QTVQ9HtLkFRxBZFJWTo41tpwx/tMng+fjRCUzl6YnfYLd5zsnSTwVrm+
         q+2j8hiSv48gKt22e9XnA1q1LMGLzmFRm5RN7Ub7rDUGezdy3SmDb+uwubusOshQ6ldC
         sfvv0sATYvaqxc8531pjjFJAl2WevZ94gE06Gnu81+1OCMvPMq7Msy3iMLiFXam8Rm6v
         ao8yrFrJK7V9/EEac3gQVdCREnccSZUBqDR5OIb+JvwS0RZlzT10dLtiixqRj81kGr09
         8CAA==
X-Gm-Message-State: AOAM533XFQ5szRGATNhVDcOw5ZvGNR7rtG2JnHEmg1WicvnQVzrEZfy4
        bSBT+X4rtoAuDpnLcE4B+Q==
X-Google-Smtp-Source: ABdhPJxJRrvWySB45UK6FLQxD5ol1vphUXTZCU3F4uQ4ESUHx/oZ/n2249kg4HzMx/J2Z7cR3VtiOw==
X-Received: by 2002:a6b:2bc8:0:b0:669:af77:34bd with SMTP id r191-20020a6b2bc8000000b00669af7734bdmr1442822ior.182.1654787860556;
        Thu, 09 Jun 2022 08:17:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f6-20020a056602038600b00665862d12bbsm9438447iov.46.2022.06.09.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:17:40 -0700 (PDT)
Received: (nullmailer pid 3812662 invoked by uid 1000);
        Thu, 09 Jun 2022 15:17:38 -0000
Date:   Thu, 9 Jun 2022 09:17:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 01/48] dt-bindings: input: gpio-keys: enforce node
 names to match all properties
Message-ID: <20220609151738.GA3812591-robh@kernel.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609113843.380260-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609113843.380260-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 09 Jun 2022 13:38:43 +0200, Krzysztof Kozlowski wrote:
> The gpio-keys DT schema matches all properties with a wide pattern and
> applies specific schema to children.  This has drawback - all regular
> properties are also matched and are silently ignored, even if they are
> not described in schema.  Basically this allows any non-object property
> to be present.
> 
> Enforce specific naming pattern for children (keys) to narrow the
> pattern thus do not match other properties.  This will require all
> children to be named with 'key-' prefix or '-key' suffix.
> 
> Removal of "if:" within patternProperties causes drop of one indentation
> level, but there are no other changes in the affected block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 157 +++++++++---------
>  1 file changed, 77 insertions(+), 80 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
