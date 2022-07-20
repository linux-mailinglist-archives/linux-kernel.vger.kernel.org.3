Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9157B0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiGTGPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiGTGPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:15:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44F2CC83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:15:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p6so19940485ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tXE548Ck2Ie+d7x6mhU9K/Ck4K3DClRihhNx2H7HDqo=;
        b=ooXRdgOWqxmz8XVGgBZgIdj7/7XZ+8am+8YsGikyMxw0dtER0vJAhF/lVH/NX1TLsS
         W56RPhxBYKGU0xWef4P6+1TcXixSkBHWTIimzbdyTVztukDO5j1e02PUZ6a5HX5HTsrh
         JZYjzkeG4hv1qqQsqyM/VZ8utZBzKSMGvoRoBbAJ/fKU0oR/i5NWMrlpiM8rbz66WelK
         cVw9aqdQC16jU1UD16je6Bw5Vh/nfsKJ/3oQxuSFTCCUdlzBCyxYrvR4rF9d+9/+II1s
         aelM2f9Sg6WkwwCfdUG4g7G7KLhf+0TDdYsT29Aort0jDoct2y00qfQ85zFkzIABftkT
         uFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tXE548Ck2Ie+d7x6mhU9K/Ck4K3DClRihhNx2H7HDqo=;
        b=XL5njxdep1ZnLUoi3g9guLs7wbaEgkOTKoReVwDaBpzEmfEtgQOwmIymk6snTN7oX3
         rj2/AXqJCk6aQUjxE8QzElcDn1YGn1XHza78M/1ax3yI7ojocEi5SpwaJjOIXjpbdBrs
         UOHRCtkef/R8fcsfx/6Rw6FC1iekbALPaDuDmRP/oubhO8rQ0kU38c8gAgjkHGJ8Zi3u
         /tODxJk6CAjWbZK2pf8tW6ltE2/l3rfxyhRiyfP2+YIy69+cg5WRbJ4OgAp/QCs42ulg
         aSrnxBWRW/p9+TrRDEL6YtANP6niBuoUW01R7/VH1eYs0dAoGJt9BpdeUVVZ0p9ZzmEV
         An8A==
X-Gm-Message-State: AJIora+SHS0wPiKyzSza4DyX7e4ImLt2NmfGDEKof6bvTB5T5bu52P4B
        UsDGYs7v9PU04ro1zVJnb/jSPw4X0VHj96Sq
X-Google-Smtp-Source: AGRyM1utNqgAaKCZA2ZalNHL1Km0tdkASa2QZLPj5OBvb96KlXyPXI88nz4ox0xmaR6NlBBNO3AAhg==
X-Received: by 2002:a2e:a317:0:b0:25d:83e8:ce60 with SMTP id l23-20020a2ea317000000b0025d83e8ce60mr16860005lje.111.1658297728369;
        Tue, 19 Jul 2022 23:15:28 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id r13-20020ac25f8d000000b0047f6e07ded3sm3577313lfe.152.2022.07.19.23.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 23:15:27 -0700 (PDT)
Message-ID: <0bc494bc-8788-46e6-a485-cdefdb8682a4@linaro.org>
Date:   Wed, 20 Jul 2022 08:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     appanad@amd.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-2-appana.durga.kedareswara.rao@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720060016.1646317-2-appana.durga.kedareswara.rao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 08:00, Appana Durga Kedareswara rao wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
> subsystem is fault-tolerant and continues to operate nominally after
> encountering an error. Together with the capability to detect and recover
> from errors, the implementation ensures the reliability of the entire
> subsystem.  TMR Manager is responsible for performing recovery of the
> subsystem detects the fault via a break signal it invokes microblaze
> software break handler which calls the tmr manager driver api to
> update the error count and status.
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Use one identity, not two.

> ---
> Changes for v2:
> --> Improved description for xlnx,magic1 property as suggested by Krzysztof.
> --> Fixed style issues (indentation of example node title description
> etc..)
>  .../bindings/misc/xlnx,tmr-manager.yaml       | 47 +++++++++++++++++++

It's a pity it was put into misc, but since we did not reach consensus
during last discussion and there is no fault-handler-like subsystem yet,
we might move it there later:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
