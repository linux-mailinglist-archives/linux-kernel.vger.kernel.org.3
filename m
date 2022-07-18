Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDE578C52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiGRVBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiGRVBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:01:32 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10132056;
        Mon, 18 Jul 2022 14:01:31 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id l24so10309316ion.13;
        Mon, 18 Jul 2022 14:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqL86C209CC8ohrgAyiDSpRFiZ1P/S4D3Xek1TgOKQI=;
        b=lbYdAnQR0fcf1DEE5hSRsKK0s+6OdTshGD832o/f7rYH2/2B2I+BPDU+Xy+hx7z8Qn
         JOoq5tZqmj2eHC0dMjJ6TGmrZbS2Ucm2jtg2voQ9Bg7KSUDh2AlUE67tbdFf5c2mxbuh
         QF1pA4kLqu4dbslCOLJnsnGWG+FSmUKFafad34M+wEcluhnDHVB2Jt34PWMgLTWWX8or
         r0Ye2SnTi/nv9t/yqxWAjuxb7Lg/XT2AZW/ke2LQFBf7S36oxAthwZgS2kGFFjMHx+0q
         N9awktJp6j6d+bVKUM9WwQQqdERv42raQLp/c2Vs8+1dVritwEAJyBYP8b3/t7htBN5X
         gyaw==
X-Gm-Message-State: AJIora+aptMnf+H3DnmKHzUDZ0pPd2G07OgPx0hSFZeb5t7b1c3SV7/O
        PC/pELT+polymPgM/Y0MuA==
X-Google-Smtp-Source: AGRyM1scB1e0UcZfWG4sbyNpZb9boSCI1uuwuTztjvbMFTwT+Tk74zgSZm3E2sO5wAbfRJ/MrRc2RA==
X-Received: by 2002:a02:c904:0:b0:33a:6af1:8bcc with SMTP id t4-20020a02c904000000b0033a6af18bccmr15611927jao.108.1658178091055;
        Mon, 18 Jul 2022 14:01:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t1-20020a056e02060100b002dc251040besm5214975ils.46.2022.07.18.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:01:30 -0700 (PDT)
Received: (nullmailer pid 3547487 invoked by uid 1000);
        Mon, 18 Jul 2022 21:01:29 -0000
Date:   Mon, 18 Jul 2022 15:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: mfd: syscon: Update Lee Jones' email
 address
Message-ID: <20220718210129.GA3547454-robh@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-8-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714112533.539910-8-lee@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 12:25:32 +0100, Lee Jones wrote:
> Going forward, I'll be using my kernel.org for upstream work.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
