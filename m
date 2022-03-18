Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E14DD6EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiCRJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiCRJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:14:57 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F111A845D;
        Fri, 18 Mar 2022 02:13:33 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id p6so5917539lfh.1;
        Fri, 18 Mar 2022 02:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UI9Vq4s9otmuB+Na7hKKAjBDN1lzET031KK56Vy+gj8=;
        b=xZfttNRrsCSLqK6f4Pzklk6PnUWxY5kRZo0MZ5esUt4V8LMiN2sbwRRgJJFibxb3Yk
         +M0LV9IZsMezlLfZBQVdYfCPHmosuMmCogCOMEkRkvdIdCvj2PB4pQ6hf03HPL0Wb68G
         zi98dUPYKJglzsxKQzh6Oq/wLrsd2t+OcDqMnkG/p2DfbkZz7/jkTFTeqlT8iuY6DtO6
         fbmUrtoeMd1bDkhn++DMe3KU894pE4h8QAxX51dSxpirUMGcY+hw6UJxNMlqrkDvIyHN
         1cbW4M0XSSiMVRFqvaq9Af4N0wwNC+B47T2pYZTfE3vwlC6McLDfUPUNQB7E7cCdG1Bi
         hV9w==
X-Gm-Message-State: AOAM530/0I3rADBzGXknvgzeb4JiWucTpAqyATuGDytOnsXUMELyWd1/
        qN3LCA87Vv3MmCiZB40Z5TPQb5Lr8lY=
X-Google-Smtp-Source: ABdhPJxpUVC7xbquP0bSt/ZE7923EuUbvUavCYLr+5v/posKLUjV1dUpg8Jupqsj9mLkJoutoHMcdg==
X-Received: by 2002:a05:6512:3619:b0:443:1597:8293 with SMTP id f25-20020a056512361900b0044315978293mr5497427lfs.439.1647594812054;
        Fri, 18 Mar 2022 02:13:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id h38-20020a0565123ca600b0044a0d14f1bfsm175951lfv.263.2022.03.18.02.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:13:31 -0700 (PDT)
Message-ID: <c0d9d9af-45ad-6a01-1504-59d03f64cb9e@kernel.org>
Date:   Fri, 18 Mar 2022 10:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/5 v2] dt-bindings: gnss: Modify u-blox to use common
 bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-2-linus.walleij@linaro.org>
In-Reply-To: <20220317225844.1262643-2-linus.walleij@linaro.org>
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

On 17/03/2022 23:58, Linus Walleij wrote:
> This modifies the existing U-Blox GNSS bindings to reference
> the common GNSS YAML bindings.
> 
> Fixed an unrelated whitespace error while at it.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Change additionalProperties to unevaluatedProperties and
>   cut the :true insertion of properties from the common
>   props so new common properties get available immediately.
> ---
>  .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
