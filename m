Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E858E085
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiHITzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345329AbiHITzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:55:17 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699610D9;
        Tue,  9 Aug 2022 12:55:16 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h138so10451179iof.12;
        Tue, 09 Aug 2022 12:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NmRiglbyS3f2eZJNSmpjxkkODRr60iCR5V5oFeVX7Yg=;
        b=TQFQQzcKPqZiLEjNc0OPPJqbD5CVtJnwsI0RKi53eDWPBzOlCWtCJO3nhajQ5ghm/0
         moaILt/CIfgZz0vAG/DOxdrT1lXSylGXb5MRa0rfkaVRvg966x+WfPgVDXnFhu95uram
         6NYncUE1MJWO2RBtIqH1KCPVqfzpL1eU3PW6Gwy95Wrj1eHJ1e2UYi4rm+8Qlt/aueUL
         nrkbJYk8qDk7cBfT9KMmciKjWjRxjOcSkWESeuF69Cv+NiYwecDpaRtcLzbQRnMGfxDn
         sP9S3GYzwDOLJcXkb+Ma4hVFZ16ynZmdgQIETCQzZebgqeEOWEgvkZbxGc4Ohdf0GyjV
         FcMA==
X-Gm-Message-State: ACgBeo3ZQB2QyLm6tQZ5s8FVAkfMitnmAZ0DI6/J1AUeBElvoQN3kMKK
        xmSMYHf8h+u7Jsq0dhbkdQ==
X-Google-Smtp-Source: AA6agR6cqChrqIDYR3Ko5vcObSAMv92y6qwdjRLtpx40VfdXKfVMvdj5N5v2nZfgMRstlLkPya01EQ==
X-Received: by 2002:a05:6638:3801:b0:343:29b3:d459 with SMTP id i1-20020a056638380100b0034329b3d459mr2398142jav.302.1660074916021;
        Tue, 09 Aug 2022 12:55:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s17-20020a02b151000000b003433b686389sm139055jah.62.2022.08.09.12.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:55:15 -0700 (PDT)
Received: (nullmailer pid 2286622 invoked by uid 1000);
        Tue, 09 Aug 2022 19:55:13 -0000
Date:   Tue, 9 Aug 2022 13:55:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     ayufan@ayufan.eu, linux-rockchip@lists.infradead.org,
        martijn@brixit.nl, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, megi@xff.cz
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add PinePhone Pro
 bindings
Message-ID: <20220809195513.GA2286588-robh@kernel.org>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-3-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805234411.303055-3-tom@tom-fitzhenry.me.uk>
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

On Sat, 06 Aug 2022 09:44:10 +1000, Tom Fitzhenry wrote:
> Document board compatible names for Pine64 PinePhonePro.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
