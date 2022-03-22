Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8729B4E3D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiCVLEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCVLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:04:18 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08F7EA25;
        Tue, 22 Mar 2022 04:02:51 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id i186so1014146wma.3;
        Tue, 22 Mar 2022 04:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ggFh2/a0C+1lpqeBh9Syc0UkF8/1nYLPIxegFFB/Pc=;
        b=Nl4lLAgve5vLxwFa9h3fLEcj0+QusBqopMQFYPNoX4lJ6Hj+kuzCCA6s69RioHkZZp
         NNRSNk/xYS9CQtrPnVTVyccREfPUZJV0iEERqIun2JEzJbzw21Yxd4utbGMCOBjCP395
         K/XIJ9lPANtbt/FhTQ/lCghZJ3FIgg+fdkBC3UjJe4c6V4cj7Idv6XnEOjff+zEa4G76
         OnasOrySRAoMKz2xfdGqiF2RHVObwj96y7P1VpUOvZnlYHlmxmzIbwwIMsozqrreAaj3
         Y/BqGlcKe1GJVCGJswhyFRRaJ2gtdu/C2DFvQy4mGOPAR6o4/oKyLZA/gxax0xO7PKrM
         HT/w==
X-Gm-Message-State: AOAM532U2EqcsLXOOsmguBZaF1dTn8ZYKMb0jm/6jH+anRSX1sMSP2KG
        J+ATI1qeGhFwsVy5RVEtoyvPUz+mOlU=
X-Google-Smtp-Source: ABdhPJw/w6GpkGUEvPB4iVhhmwX3JFRg3NQctEYzaWFjx0CTAeswStfrvDCu2n5xlN8IfRxa+3jOiQ==
X-Received: by 2002:adf:fe8d:0:b0:203:e02e:c6c7 with SMTP id l13-20020adffe8d000000b00203e02ec6c7mr22330036wrr.37.1647946968736;
        Tue, 22 Mar 2022 04:02:48 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f7-20020a05600c154700b0038c85aade39sm1747828wmg.47.2022.03.22.04.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 04:02:48 -0700 (PDT)
Message-ID: <0bfa2a53-a45f-3691-f473-0e0848a4d7f0@kernel.org>
Date:   Tue, 22 Mar 2022 12:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <ff9d9a9124f1535dbfe68171359be964f6f4e4e2.1647928316.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ff9d9a9124f1535dbfe68171359be964f6f4e4e2.1647928316.git.qinjian@cqplus1.com>
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

On 22/03/2022 07:16, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Since you did not implement changes I was asking for, you cannot use my
review-tag.

NAK.


Best regards,
Krzysztof
