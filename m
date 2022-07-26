Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA85818D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiGZRrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiGZRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:47:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3F12757
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:47:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b16so11218305lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cTh/VmIIxa6zND0UMmPraAseD9adZ9TkskNpcYoRdAk=;
        b=q2ltcuqpI8DQqJc1moXciC57Y2UfdkaQNBxBXxX6ty1++FGlekjf7wlfUnrFEHeoU2
         IyPOOdfOzi7yS4wGJW/zYwNkpjF4YtsvXI/BccpH+UKLDOZDEjZj6wZwK0K26x5Sd1Go
         MK9SKucLyTlwtbxI2Sp8DtIOiNVM/5mlXJK1fI/MfWoeAu4FRJMiQcRXPpgdKMErz83n
         oMMx/P6IH1SwLGboZMWjr2gBqp4HgeAcfaDHK5mJFLc51i0Y4/P5VBcL1xHtsE2eaITv
         9ITmx1rTBw7WleUupSKAzrc1Z+p4Uf1EOrhcSKFEy/fJoA43thKEpSDQafn848cNZS9T
         o71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cTh/VmIIxa6zND0UMmPraAseD9adZ9TkskNpcYoRdAk=;
        b=QjWFq6k3NqXwtgunp9CnS/SYOEq1pSqp9stCZ/KUqQwxFP3EGgsjlwLCcpP8sZc+D9
         JgZuhRuXDyz8GpIpTGE5mK9pbyepotDMPRouyzIGKMl3caDVbUrXqO+95KPj90DdBVE1
         pnIVB6glGTsui4OcRvFXwG+5foMoXXizF0OgZ8IPXt6PCBCVAAFu1E7f8r/rky9t5cMI
         aPXenmJFFwGn/hF125smSBxUNbEFY5FYfRduVfXdzY4WmerfdR7AgRAwLU5RyyJtsMUd
         S8TqtEdyBeCywsPQqpSo3HbcGQOxeP0C4TDfeBq64XHgP/w8yQb6MTdSyenxKbfm4OI/
         ZYRg==
X-Gm-Message-State: AJIora/Qn+T19BtZTl2slpXmHlNae3OvClRDTaClGPjJNRvcmtqoHlmE
        wbx/N1m5KxonA5mY+JnKmPQpsg==
X-Google-Smtp-Source: AGRyM1sQWViDqbOuVhkk9dCLiQGiLObMDobj0H5WZA+NU09znGIhyLbA1ayQG/n6sGHWPVQQ4qYXfw==
X-Received: by 2002:a05:6512:4dd:b0:48a:a01b:887c with SMTP id w29-20020a05651204dd00b0048aa01b887cmr1690322lfq.686.1658857637462;
        Tue, 26 Jul 2022 10:47:17 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v9-20020ac258e9000000b0048a8827049bsm1457578lfo.60.2022.07.26.10.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:47:16 -0700 (PDT)
Message-ID: <7555b0ca-2028-dba9-9950-ca0d21c2863c@linaro.org>
Date:   Tue, 26 Jul 2022 19:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V6 0/2] Add ums512 clocks and relative bindings file
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220726102404.564498-1-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726102404.564498-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 12:24, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> This patchset is add the UMS512 clocks support
> 
> v2 changes:
>   adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
>   compatibles to fix match failed logs in the dt_binding_check.
>   add the property license and copyright notice.
> 
> v3 changes:
>   fix wrong indentation and hint: "maxItems" is not needed with an "items"
>   list when use the latest dtschema.
> 
> v4 changes:
>   move the syscon bindins from clk to glbreg yaml file by pickup 
>   chunyan's patch for global registers bindings
>   fix the comments from Krzysztof in v3 patchset
>   add the Acked-by: Krzysztof in patch v4 3/4
>   fix the  warning Prefer "GPL" over "GPL v2"
> 
> v5 changes:
>   Add review tags.
>   fix the comments in ums512-glbreg.yaml.
> 
> v6 changes:
>   No more send the patch 1/4 and 3/4 in V5 for applied by Stephen
>   change GPL to GPL v2 license
>   fix the lack of space in some "{" and "}"
>   add check error for sprd_clk_regmap_init.

That's not good. That was a dependency here (for MFD bindings). You must
describe the dependencies in cover letter so maintainers know how to do it.

Your MFD patch is not applicable now...


Best regards,
Krzysztof
