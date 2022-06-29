Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7657E560B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiF2VJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2VJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:09:56 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA8286E0;
        Wed, 29 Jun 2022 14:09:55 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id u20so17277193iob.8;
        Wed, 29 Jun 2022 14:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCX26RJlBP+sKZaW9dC7qwlnorfKgdpacF1Ro/OGjvQ=;
        b=cfj+mRR8cuwzwkIPzUz2fvG9UsjCVOAnyTC47xGJGFgHhClOD6ULqV4Ytbw2iZZvwW
         PxoEQHbQFQcO7g4sFsb2D2BfNB46jZ5BQhVbiiUPuwRxHTj9eXUc4ttUxULcIOwycRvJ
         2pddBsCi1mEeKKdaWMBrM2Dzfd7sPHzRdhl7SUEFFT+e883GYPF03jZyyjEjKTjP+PmN
         kOtO83avLU2g4XiRjfv+PtPGyi4X7nJRyXr/lCyq7rBPahDi0pF8FnjexgfaSxKrYggt
         yaDnlC8pabyYNDJPK41xjvStZeaF1x4tFE9zlDOKWF/BTkTOwXLru29eVfQ8CVVkYUZt
         sfaA==
X-Gm-Message-State: AJIora/fYWIeJ3+aJegTPWBGQWywRwVTsS3DP7HZZElJboVXMc4ZFCsF
        5lZb4i4UGObvRHhVrKOt3WMAt7elag==
X-Google-Smtp-Source: AGRyM1s1+EZnDDXifeQDhJuExBLrpNV2hMBSraaKfa4jGDVT2PmN10hy8xMv1Jmi7QNk0DE3Q1Oaaw==
X-Received: by 2002:a02:c85c:0:b0:339:dc91:d486 with SMTP id r28-20020a02c85c000000b00339dc91d486mr3144022jao.199.1656536994754;
        Wed, 29 Jun 2022 14:09:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g24-20020a05663810f800b0033cbfb5202esm2205787jae.11.2022.06.29.14.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:09:54 -0700 (PDT)
Received: (nullmailer pid 831594 invoked by uid 1000);
        Wed, 29 Jun 2022 21:09:53 -0000
Date:   Wed, 29 Jun 2022 15:09:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: rc: Allow 'ir-receiver' node
 names
Message-ID: <20220629210953.GA829883-robh@kernel.org>
References: <20220606184944.1067068-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606184944.1067068-1-robh@kernel.org>
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

On Mon, Jun 06, 2022 at 01:49:43PM -0500, Rob Herring wrote:
> Most existing 'gpio-ir-receiver' nodes use 'ir-receiver' for their node
> name, so add it as an allowed node name.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/rc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It's been 3 weeks and no replies, so I've applied these to the DT tree.

Rob

