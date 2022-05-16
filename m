Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE75528CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbiEPS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbiEPS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:27:37 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D03DA64;
        Mon, 16 May 2022 11:27:36 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id q7-20020a4adc47000000b0035f4d798376so4185084oov.6;
        Mon, 16 May 2022 11:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eGkfhUFgjWI/Bjo7LSuv+5m0MHqyEX6fPWIcrjvd4Gg=;
        b=8Esa8Pv/ZAqUjK5vDxvmsID1YfAJ//euZStkd00+cqbEtKWbRjDNDB4pY/Arqfoo/p
         /b+qGvFDa3QivFhyWYMrf8Qhj/k0wpAxq4S2BX5FeGY5XUiJ1r8zXypAK6iRh1kmpSWF
         RsBBg8MBDXZ8GiQBZgcR7I2rOTq4kE7RB+ECL5ds8NtDSGErZS8t347yhJmSqqBUNv+b
         xQAgkLXVNwrWy0SkGCZ5IDU3CqPfaY9nPcBUXbf/869xL8dsZEBBpq8446nriFAiybJ7
         8VUzcX8jtzPOZhfAzQS1e6Kem86i4TpPdyir+nRHcHR/aO04oI42SFdS472EnpQXjQk7
         Hr3g==
X-Gm-Message-State: AOAM5320NeR3jthMApHxo56zLTKsLyjzZjWTmn2XsQw95TiQhPpHj9m5
        En0ugjBlc47osSxFhsvn0Q==
X-Google-Smtp-Source: ABdhPJxGa8SVbc2owUr356FqfNxkiSRJC0NLZKMzV2XtAcN7cf8aVrGPgfIUC5ekoMb1Bk9Pc3u+bw==
X-Received: by 2002:a4a:de4b:0:b0:35e:bac9:807f with SMTP id z11-20020a4ade4b000000b0035ebac9807fmr6525697oot.16.1652725655870;
        Mon, 16 May 2022 11:27:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a056870890700b000ead8b89484sm6026613oao.5.2022.05.16.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:27:35 -0700 (PDT)
Received: (nullmailer pid 3032272 invoked by uid 1000);
        Mon, 16 May 2022 18:27:34 -0000
Date:   Mon, 16 May 2022 13:27:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ken Kurematsu <k.kurematsu@nskint.co.jp>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: arm: fix typos in compatible
Message-ID: <20220516182734.GA3032199-robh@kernel.org>
References: <OSBPR01MB32880CB4C49E50DAB7C6B664DBC89@OSBPR01MB3288.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB32880CB4C49E50DAB7C6B664DBC89@OSBPR01MB3288.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 07:01:56 +0000, Ken Kurematsu wrote:
> Fix typo "cortex"
> 
> Signed-off-by: Ken Kurematsu <k.kurematsu@nskint.co.jp>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
