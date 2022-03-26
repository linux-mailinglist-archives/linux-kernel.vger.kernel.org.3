Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB784E7FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiCZIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiCZIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:15:55 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D41CABD3;
        Sat, 26 Mar 2022 01:14:19 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id p15so19361808ejc.7;
        Sat, 26 Mar 2022 01:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T8ebr2iFGoh7ryNOjBQ98YHXu8uvdUYMxvGrKpFpiQU=;
        b=dpOqmcq7OTfTzp+vXSbWmrrPoyRh9tuAzAd3nhLaq/plb3IyK772zhhBvZj/mhLOpz
         ylGlVK/NFISLKdLcc/57ruZrfHb73iI/tvNe/B7zytyoX3smRfGInIiPKX2zSMZffh1f
         lYLylJZnJIqC9G9nc40+mIbrtcCe3gZc/AT3UIAy+LdGqwN1znny/YwHFcHYGC8WUS3m
         CVadlzuPRPCrywOyi/+OSJMYCR/6/qt5KkJuH8mBovvhLsc9u4LIZi07RJ7BL+BoZ9hf
         4nBjycQmuYPQwIQmXS5dfNQUO+XJu2CWgRkteUtzxrdl0tMswi0uIegaRYhqRaaXB3rG
         w7kQ==
X-Gm-Message-State: AOAM530GGv8m2fT/r7ocGSp43VXPqSk6q0yX1Y+MTqtqDpOFGgfvtGc+
        RTLHlcmnVglTbuz21odHMgJOwJ1fRcfRMw==
X-Google-Smtp-Source: ABdhPJziycJCmOI8ifnO12TtKmV3cON6H184IhBIaccU6Xwb1dxUxQjhgncFsXLalZs3koHg4AKxDg==
X-Received: by 2002:a17:906:58d3:b0:6da:bdb2:2727 with SMTP id e19-20020a17090658d300b006dabdb22727mr15838125ejs.549.1648282457756;
        Sat, 26 Mar 2022 01:14:17 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm3265161ejc.117.2022.03.26.01.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 01:14:17 -0700 (PDT)
Message-ID: <c1e9175e-e33d-ec51-4d9a-ce5c441a0ba4@kernel.org>
Date:   Sat, 26 Mar 2022 09:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326080726.30372-1-rogerq@kernel.org>
 <20220326080726.30372-3-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326080726.30372-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 09:07, Roger Quadros wrote:
> TI's AM64 SoC has the Error Locator Module. Add compatible and
> related properties to support ELM on AM64 SoC.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
