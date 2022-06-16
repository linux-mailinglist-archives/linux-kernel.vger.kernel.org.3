Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2954E8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiFPRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiFPRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:55:35 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F77F4CD7A;
        Thu, 16 Jun 2022 10:55:34 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id h8so2224467iof.11;
        Thu, 16 Jun 2022 10:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCSKOFubArDq+VHloMg+XZw1B8bXUpscLNFoCONjN3k=;
        b=ZDHJyjDgZTKjgmekj9FnayTccGhg6L1QLH7UvFokyMVaj53SmeHorMBEIp10ZY8JXu
         DVWU8hB8YUd0XHxHd3gMN1ECwcvmsCgVHZ3T+kUVc0mAnB54jq2Oiob5yXiiSw6M7/e6
         wUV76pHBn9eFTsoYExLQtTOkB3aiHiuYvY5uC4hIB7pciiYJgFfrIc3316yYZbTHhX43
         rUm4P5GcIv8ewA4VC6P+WN0aWoj0WXZG+tRreaNVSq1A1kUI0milCSgV8mACZRmjfvF2
         2iTlrK60HFw62Hm1K3h4M1Yhsokx+UOdiBssh6jES7KLTxEg9j+0R6+D79eTg+YgnVpZ
         18QQ==
X-Gm-Message-State: AJIora8ierJMAbd9EaHy8eLbrs6ZqEAxb1oVnaLWTYtsd1/dKlREnBJW
        yHXKo7xaSMq7VaKr9WeLcw==
X-Google-Smtp-Source: AGRyM1tMLpMB9XlihUQw1iwu/e98dvS1bYPkybTgmIcS7g74288Gn+361K8LstpmpF4HGuseMkNL8g==
X-Received: by 2002:a6b:2ac4:0:b0:66a:3695:abb with SMTP id q187-20020a6b2ac4000000b0066a36950abbmr3075205ioq.34.1655402133762;
        Thu, 16 Jun 2022 10:55:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n24-20020a02cc18000000b0032e168fa56fsm1149921jap.83.2022.06.16.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:55:33 -0700 (PDT)
Received: (nullmailer pid 3721404 invoked by uid 1000);
        Thu, 16 Jun 2022 17:55:31 -0000
Date:   Thu, 16 Jun 2022 11:55:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rcc: stm32: select the "secure" path for
 stm32mp13
Message-ID: <20220616175531.GA3716982-robh@kernel.org>
References: <20220613093815.18334-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613093815.18334-1-alexandre.torgue@foss.st.com>
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

On Mon, Jun 13, 2022 at 11:38:15AM +0200, Alexandre Torgue wrote:
> Like for stm32mp15, when stm32 RCC node is used to interact with a secure

'st,stm32mp1' is stm32mp15?

> context (using clock SCMI protocol), a different path has to be used for
> yaml verification.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> ---
> 
> Hi Rob, Krzysztof, 
> 
> If you agree with this patch, I'll apply it directly in my STM32 tree.
> 
> Thanks
> Alex
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> index f8c474227807..242fe922b035 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> @@ -78,6 +78,7 @@ if:
>        contains:
>          enum:
>            - st,stm32mp1-rcc-secure
> +          - st,stm32mp13-rcc

You don't need '-secure' because it's always secure?

>  then:
>    properties:
>      clocks:
> -- 
> 2.17.1
> 
> 
