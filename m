Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF653596139
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiHPReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHPReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:34:09 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812D5EDD4;
        Tue, 16 Aug 2022 10:34:03 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id k12so1710279ilq.10;
        Tue, 16 Aug 2022 10:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ocfp5I9qK0ctx9cDxA5y/IUHuXfnD9Ka2G82jMVWFSc=;
        b=E4TYHbUAqf/y9L62+W3xPr1V9OcxvGBmMFynZh7O0I9lC9D6XkehyxgZ+IT6WN2OzJ
         TXjX5ahYjpWhiMeXhbthv5chj8Du9Q3nzTrzXfQhsnSahOlitZz5tEl6gmoMTxe447Ne
         gFl1M8IiOrQeJrReYZX+XDPyq0/StDlF1HH3iFmLyzHrGulJKHHSvM8a/lfDaNIxDUpJ
         kH3xuDr2Pk86N+m/+yePgcwxdooinq4NDTwrRc84dfTl/y6/hiGbD5Wbr+nsgGFwgqiC
         5prPySr9f6chJ1Glm82wQ633DNZYT1LRuPSpvqD+lkfcOFeWbBZJATR7hnEjEl5hakR9
         HH2g==
X-Gm-Message-State: ACgBeo0D0wMarKLDqs83/cHf9dNDZ2iORzrpVM0zKgLzvZtXHoqG0a87
        p4Ile2aJPLanrF/gwz9BJw==
X-Google-Smtp-Source: AA6agR4j3pIZz7KH8vmLyJaoyp/zdHchsnP+VUwuYzNv9GLi6f5Yj8ZmNmusErup5y9k+atidjnVGQ==
X-Received: by 2002:a05:6e02:20e9:b0:2e5:e584:d616 with SMTP id q9-20020a056e0220e900b002e5e584d616mr3358602ilv.236.1660671242323;
        Tue, 16 Aug 2022 10:34:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b16-20020a05663801b000b0034602e741f0sm2976099jaq.67.2022.08.16.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:34:01 -0700 (PDT)
Received: (nullmailer pid 2424370 invoked by uid 1000);
        Tue, 16 Aug 2022 17:34:00 -0000
Date:   Tue, 16 Aug 2022 11:34:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 02/12] dt-bindings: riscv: Add T-HEAD C906 and C910
 compatibles
Message-ID: <20220816173400.GA2424313-robh@kernel.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815050815.22340-3-samuel@sholland.org>
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

On Mon, 15 Aug 2022 00:08:05 -0500, Samuel Holland wrote:
> The C906 and C910 are RISC-V CPU cores from T-HEAD Semiconductor.
> Notably, the C906 core is used in the Allwinner D1 SoC.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
