Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D14B2A74
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351544AbiBKQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:33:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351558AbiBKQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:33:05 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755DD65;
        Fri, 11 Feb 2022 08:33:04 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id b5so9481674qtq.11;
        Fri, 11 Feb 2022 08:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XWQ6qpMBxyFXvOuunDNuZGV3l0rq5uolQRh0yB7rCUg=;
        b=v4wNaW0JPHpnHnbA/tOZ3OaJnOmSDs6JWLR3/Xk10xwVfmaS5UvKS1xEig+N/Mpvq5
         Mu4UKW1/s3VefbyZ0Qg2pgC+HQUHTDvA14oumTbqj3YzvXu3UTlFItWhxqWKS+e+O073
         ft8Dt3Fgri6o0+itUN5l58CgHhRMfOXS22AXaCJ1qwOtTWjFX0j3CuObCf46tjhqJ23x
         New2KnbJCOvs8Ph4PKAiIPUc81G5BVtQFSK0dYbVnLMsyRuPcZQKu+uET6drpoDIcPTe
         S9uB5W4rEUNObipkSlozeLYvTQPSfeYqlkyaeNLh0eAY3m1EeEYwU8TE/qtrLlu/Y0zO
         6guw==
X-Gm-Message-State: AOAM5309CaR5bj4qxdaPZuXcP5JCvir5ZHnNcSbBrG1HZ50wQT3grbMS
        dQ9NXcW3z866W80N6ywr/Q==
X-Google-Smtp-Source: ABdhPJwqT8XUzqvXOrzJ0UVL71RZhhtQUx62acf1utFNCBTr8elSdBHLpnzakIG6SXsfu1ZPJq611g==
X-Received: by 2002:a05:622a:354:: with SMTP id r20mr1673830qtw.0.1644597183473;
        Fri, 11 Feb 2022 08:33:03 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id u16sm12964656qtx.46.2022.02.11.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:33:02 -0800 (PST)
Received: (nullmailer pid 478597 invoked by uid 1000);
        Fri, 11 Feb 2022 16:33:00 -0000
Date:   Fri, 11 Feb 2022 10:33:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     linux-leds@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add ocs prefix
Message-ID: <YgaPvIpgotlFs5d6@robh.at.kernel.org>
References: <20211117091405.7412-1-git@apitzsch.eu>
 <20220207230638.56730-1-git@apitzsch.eu>
 <20220207230638.56730-2-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207230638.56730-2-git@apitzsch.eu>
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

On Tue, 08 Feb 2022 00:06:36 +0100, André Apitzsch wrote:
> Add the prefix for Orient Chip Technology.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
