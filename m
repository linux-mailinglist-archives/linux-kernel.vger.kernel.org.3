Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC4B024A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiBJB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:28:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiBJB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:28:08 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61420197;
        Wed,  9 Feb 2022 17:28:11 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so2778475otq.5;
        Wed, 09 Feb 2022 17:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=siet+Ao2TH7V5m6SftR2gVXEXyrYhoODYtbaQVg/nkg=;
        b=YNRMeQ04hxyAt6Zpl5OzJOlbVqSXQBqZ0EHbAVqoApo9bi82CP5RXJqAYvlep8w58t
         SS7AH9OvM+tj0fkIpmv/37FL+Bujqd/ymdtuF9UHtqK4oQSKUu0W5AnSltcsRjHDm52m
         vDtf9QI+InPCKT4PTQ99IKjY5JryW1eERxUIJifrnHU2oi7sHBGnoXfq4BnEuWDTWB15
         /7m1M28GKMX6pe3+/y8rht6k7B7Nc5X7nt6iOvQQ6Eo4UmO6I8SERUrI4omfYUvDXabW
         CDlo2s+RtAwPuCZsJ7m0MZhvcjLCXSnfPbwJndWHtXjtSj+truIg2tGwX6E6cVnRicD9
         BLQA==
X-Gm-Message-State: AOAM533UxnDxg/9q66cuB4v5RoOUCRMrGZRCInh8uA0FmnBYLMXQUsvD
        AfGkcc9kUobwU0nx4briy9cdnOT2Clfz
X-Google-Smtp-Source: ABdhPJzmtB6J3X9Ywh+GW7FeYw449wZbfGox6Vdj/LQZjI2yjkhUTsq3PQRmfnSFWvpLXg81YeejXg==
X-Received: by 2002:a05:6830:12cf:: with SMTP id a15mr2071431otq.262.1644453043789;
        Wed, 09 Feb 2022 16:30:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm4402159ood.32.2022.02.09.16.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:30:43 -0800 (PST)
Received: (nullmailer pid 1258215 invoked by uid 1000);
        Thu, 10 Feb 2022 00:30:42 -0000
Date:   Wed, 9 Feb 2022 18:30:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] pinctl: doc: Fix spelling mistake "resisitors" ->
 "resistors"
Message-ID: <YgRcspCc9UW2CRp3@robh.at.kernel.org>
References: <20220202091551.580372-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202091551.580372-1-colin.i.king@gmail.com>
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

On Wed, 02 Feb 2022 09:15:51 +0000, Colin Ian King wrote:
> There is a spelling mistake in the documentation. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
