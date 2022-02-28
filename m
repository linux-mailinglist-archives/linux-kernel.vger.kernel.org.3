Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB54C661B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiB1Jus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiB1Juo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:50:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ED6A071
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:50:05 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E9EC33FCA2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041802;
        bh=ectxMCPGM0jarbOBkCu9KZ4bvDNGZx3m+YCA9hoUnz8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fnFGc1cdO9A1q61XJMFKhGCpsMI5FwKVIF9JnrJ1pcgAg1dqg8JOShz77Pn/RaEmB
         QvEUKW0vDcf0H26dS4hB4Dtl2tgRjd0FmVuVi5e3/ZDPlDk7qrNkFt+unAn9u4nPo8
         vc5QIJdFSPgSp0s8F7meaTdj8/F4zKskaeYdOvBA6DWs9+QKj6YMNMLTlCzNxL3exh
         bHRimUneWlD5q0wzx2lTT1qIS3UF1+kW9mRY0VW+ME54QI0fXPj4ao4ukL4pe6W31o
         2iVee0wibAnDZt/zLH8OZvRRRqCZorafJ6hC75qWqTb3pIMESZqmWBGW2dtlJPe/su
         p42mMWENcQzoA==
Received: by mail-ed1-f71.google.com with SMTP id e10-20020a056402190a00b00410f20467abso5539449edz.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ectxMCPGM0jarbOBkCu9KZ4bvDNGZx3m+YCA9hoUnz8=;
        b=zvz2TyoZygFCSPVwQdC07WKgL95Nb5jtbfZL58fqAGwg/gp1h4D6zS8ur9EDAbrTL6
         tT+L9XHFzcnrUk1BQCyONrjeW7+ALVX0JQTAJFJvFPAHhHzQUUlucuIDBdkXINbdlhk/
         JDKXjLVZReBC0TbpLaX4glVShgeEIhwarQ/HXyjfRV/mjbRfRV8R+9NIhCayUW0msTwi
         rG/ZK+4wdwgN+5OR6XNtkSRlxUlT0CPCcQIWYzqXKdAPMMGMNj5ai5jFUdD0viATuKXE
         m/s3CjE5JMExBn7EFR/H3e75hO7zY6L0eLmd/OPeGeZVl/bU+hEmqzqHS1n4UNq6BdBr
         yfiA==
X-Gm-Message-State: AOAM533ZtUHWQ3ugY6Z1IvVzglkLW24a9TTB4D8dc39KUTguPfZbwIsb
        Yr7+0KQWsBZm8X7z1n+nFzyJhRHvcsjCdwFyJc7PR9Q3XODMmYDQjokeYSVrMh/t+dkPpb0/dx4
        oTa94YWE2yymt0Z/zC/9El8pK7ZSHZPrul0+RmSnyHg==
X-Received: by 2002:a17:906:9947:b0:6cf:e903:fb75 with SMTP id zm7-20020a170906994700b006cfe903fb75mr14136907ejb.400.1646041800867;
        Mon, 28 Feb 2022 01:50:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoSz/yW/2BamQye2ioyaZE2tA+1fxGPPHeFOaN4uciiznvM0Ldgztis+ElZDaSR3ouoVVosQ==
X-Received: by 2002:a17:906:9947:b0:6cf:e903:fb75 with SMTP id zm7-20020a170906994700b006cfe903fb75mr14136893ejb.400.1646041800659;
        Mon, 28 Feb 2022 01:50:00 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b006cef3dcd067sm4217812ejx.174.2022.02.28.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:49:59 -0800 (PST)
Message-ID: <7a7c1f00-65e0-add5-0cbc-373c58e160d1@canonical.com>
Date:   Mon, 28 Feb 2022 10:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-usb@vger.kernel.org
References: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 00:15, Lad Prabhakar wrote:
> Document RZ/V2L (R9A07G054) SoC bindings. USBHS block is identical to one
> found on RZ/A2 SoC. No driver changes are required as generic compatible
> string "renesas,rza2-usbhs" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> cover/20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
