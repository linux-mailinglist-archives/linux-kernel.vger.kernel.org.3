Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B125B1BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiIHLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiIHLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:38:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01699119783
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:38:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f11so13236142lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=grqX19KGO8eCpQz3LigCL9EjlFRHcaI3gD40UOrTb78=;
        b=aq7Pf89eDR+03e/1BvAyg2jjoqYLAHFBBg6Jzpu+powYbJ3VkVxIalvphU7patc+AL
         28woYXGvjt1KmUAHQAcf5IeParcnJvnbZItooWH/18XzKJ8E3DXaCYVmgx5fHqidhVXR
         4Rt2POJc0bYdUyEcbA05kiI8YSew9OoiRuXatoiWStgki6FfqC1QafVC3ZLQSoiBl580
         PKYNAPh2W02ywtxJ+vRnh+oO9660gC+ZoYxcmUyu2RXSVCRer1PSOAyc16KDopjGQFoj
         Uth/jmyWrJRxyomiSsHA3JTylisEmBNH3jBl1iojO8EZjn1NkgDPKiOUHthoomm3EXSX
         Kytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=grqX19KGO8eCpQz3LigCL9EjlFRHcaI3gD40UOrTb78=;
        b=jLk9I33RU5ZHa5IuzVKGdDH85wWn+IJUdpXnvnhC+TY+bLACOdUaSg9kb/j92+cc/d
         MRXKb+9Jh9StRWTQBabltTxN/x0o9xIFPKi2xODsUsZhorwB8PZIYOPKx4O3g4G6B0Vs
         EAy5pkHKnciBRLD5qxfmpUxA/DBhIMhEbRZZToCFfm6GdSFmdDPRFuwT48wBzRAv4v+8
         56M+JkAkpGPidVZnA3T0oc7fVR9h860h6TXKKnvhhxkbqiMxDJudmTghhmybUeC6cUPQ
         F3z8yfLO3FLvmG5hdbaiTdEwNDcaDsYZ75J7oys3e6nIBK/n5rTMtG3jWlfZXnM1yJ2L
         RhQg==
X-Gm-Message-State: ACgBeo1En1vHf/oIQTI7y4eAXrsnavbkYMmlspgp2ikEoPk9gs3AU3RW
        3F6eoWPATgDLXX7ZGnuIsL6NFQ==
X-Google-Smtp-Source: AA6agR7OdszDXca1mtiu9oJ1zsvD0Ie5SZlza967cSFAEmoFSH0tSdNxKFXyn0iKi2nrmxkRabnGvw==
X-Received: by 2002:a05:6512:312d:b0:497:a3df:a08b with SMTP id p13-20020a056512312d00b00497a3dfa08bmr2406053lfd.462.1662637114396;
        Thu, 08 Sep 2022 04:38:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512345200b004979ec19387sm1480626lfr.305.2022.09.08.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:38:33 -0700 (PDT)
Message-ID: <43c63dce-60fc-f21e-4ca3-5ba2518b79b7@linaro.org>
Date:   Thu, 8 Sep 2022 13:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2
 block
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 01:04, Lad Prabhakar wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L (and alike) SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thank you for your patch. There is something to discuss/improve.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    csi: csi2@10830400 {

That's still not properly named. Node name just "csi".

With that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
