Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4150EDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiDZBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiDZBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:04:17 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF373299F;
        Mon, 25 Apr 2022 18:01:11 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso12022279otk.10;
        Mon, 25 Apr 2022 18:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNMvbeh6CmKsuVbitVoBG6zb4mWj/erln3N3WDOCa4w=;
        b=10HLeqBukZ7Cgu2lFVcdlE6xGZbcNnn/auauhEYX881a4v/BZHFImnCGN7AZmExFok
         cKNZ2SosPI9h5WJUQMnmh7vkI+7M6pF/3SnEhbg+M1ZJiVvtYFjkvt/K5zTpcAwni9lp
         peddDi7HWw9ARQhMlsjarmY646HmWdkRT2/EXzDVPsysrtY2EBhY7Bsuo5HyhWJDwY5X
         dmZxJpi0ETj0VLeltsfXR8x+BaOsoSCVG4mJk4NocCjEDjtNlz3+wPdostBvTynCOPdE
         Bk+men/YsuA5Ik2q1/Xxq2xUBDhYHXuAS1JfFqftNZSCMdj24QfkrkpUk4OM2fwDr+2O
         dMeA==
X-Gm-Message-State: AOAM532MVCHB8j65QKAVtvsJjaEktDKovFtH5l+E05qSB5IEkJ3KWJcF
        L9gzqUt0OvYa5l7QebNA3Q==
X-Google-Smtp-Source: ABdhPJwcsNOjg64oeOxWjiiwJ07Dfh4RGUgyiYcxXinuXMLcboejeDwaCf4pBAggk1NSNXd6y7wlQQ==
X-Received: by 2002:a9d:798d:0:b0:605:463f:63ea with SMTP id h13-20020a9d798d000000b00605463f63eamr7430992otm.83.1650934870492;
        Mon, 25 Apr 2022 18:01:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a056830141400b00604d7cb9bb1sm4537935otp.43.2022.04.25.18.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 18:01:10 -0700 (PDT)
Received: (nullmailer pid 667736 invoked by uid 1000);
        Tue, 26 Apr 2022 01:01:09 -0000
Date:   Mon, 25 Apr 2022 20:01:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Message-ID: <YmdEVZVCNAXfiMpL@robh.at.kernel.org>
References: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
 <3a0838f71653f57be9a866c96dda5921cb10a653.1650606541.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0838f71653f57be9a866c96dda5921cb10a653.1650606541.git.helmut.grohne@intenta.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 08:16:55 +0200, Helmut Grohne wrote:
> The DA9062 can be used to power off a system if it is appropriately
> wired.
> 
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> This series effectively is a rebased resend. The earlier posting was
> https://lore.kernel.org/all/20200107120613.GA746@laureti-dev/. Back then, this
> patch was Acked-by: Rob Herring, but I'm not including that ack here, because
> this patch required a non-trivial rebase.
> 
> Helmut
> 

Acked-by: Rob Herring <robh@kernel.org>
