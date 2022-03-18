Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D354DD609
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiCRIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCRIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:24:37 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B08564B;
        Fri, 18 Mar 2022 01:23:18 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l20so12892964lfg.12;
        Fri, 18 Mar 2022 01:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dqb0ePcD+b4TLrpjZ4Tf1aNS6FbhCEj7cj4RHoou8S4=;
        b=cmSfycSSApQ1TQbGMIjPmMDyEONVNiyf6LmAgV0GeS/RT1z97KAAlAigQphp64vP64
         erzuQzXEhfLS57UGcK5DipZ5F70yagFKuPsa9iY3LLJ3j8xk2lJb2M8d8zgTBNrRubPZ
         0QFczaPFbxcyYXEXW+47NZEb4U5YoJtAHZ3N4DQjIlRSowVIbRUs1ZhunJmIc76N99xn
         8nwTr3WccVW0xtAz9reEtKuDIv/RRjRffeba62XIloj4y3p/cZGWY85853k2Y42NjPJU
         bnnGzRWkssdvdIT80loKeoDsyTuVxElDFHN4qri/YhqSIP2o4wPUCo/C78AItSm7v9Jk
         nvrw==
X-Gm-Message-State: AOAM531X5e/zo1LuHh3e0XHawGEpm5A8EAcow4y6EDbUe4yE8sJFgOiA
        IcoVDny+QwdraYNk3xXoaqw=
X-Google-Smtp-Source: ABdhPJxRoKIVXIPH+RNx8CFPaHmYc10pgsp6noaAts7Pr/w3SgSSz8FVUcMbe1YpmF/TWXO/0zsQXQ==
X-Received: by 2002:ac2:4c45:0:b0:449:fa17:5917 with SMTP id o5-20020ac24c45000000b00449fa175917mr3973606lfk.133.1647591796844;
        Fri, 18 Mar 2022 01:23:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f15-20020a056512228f00b0044758100491sm743659lfu.116.2022.03.18.01.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:23:16 -0700 (PDT)
Message-ID: <99a2766a-610f-a164-a0e4-72d490dc13e4@kernel.org>
Date:   Fri, 18 Mar 2022 09:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] dt-bindings: power: supply: max17042: Add
 monitored-battery phandle
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-4-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318001048.20922-4-sebastian.krzyszkowiak@puri.sm>
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

On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> In order to let the driver know about the characteristics of the monitored
> battery, allow a standard "monitored-battery" property to be specified.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
