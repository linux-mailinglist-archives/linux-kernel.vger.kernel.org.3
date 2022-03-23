Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2174E55CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbiCWQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCWQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:00:07 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419F76669;
        Wed, 23 Mar 2022 08:58:33 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-de3f2a19c8so2126222fac.1;
        Wed, 23 Mar 2022 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG0MaL/m0Ugiyb4lvw9XfPJHFjK/vQPjCIXYdlzKaG8=;
        b=AF/l746Uka3aY2pP60be4279oCgCtNT0jaqz8NpjRWMOILMGisN/Ug6d1MFGsSNjBu
         4bqb0K2oY7LUIs7JSFA43qJEtoeO+HDHicwMwC0SkGoKjY9RtYFyyaAn3dJlougRAmLP
         Lc0a+an+TRPh/EUMw5foGPGFySH62WTFnZpevYSWzTBQ6fCqnguVwmFsKZg4gdfiWyDE
         /qB372d/z6X3W63/R7Xoh3iz+C3rHLLowMcF/bCJ+3PfxX9JCN1QBMKJ9Mj9w/ATLzim
         hFfIMnH1P7oYmBBgQUuEomw/dg6wdwkSwiqndl6aNkdmoB9YE/iJo4Wf0EQVnGeAIQWu
         s0Zg==
X-Gm-Message-State: AOAM532UVM2WvHahRSykl2Xz2Y9j1INi8lnp3ieNApo9CXnjuh7b6CwS
        z6n/jZ1EYg728JjidTfd8A==
X-Google-Smtp-Source: ABdhPJzwB2nctudJI6BxharZdhijdzegpU5OW2/Oni8BU/n/uPgULwdatKy2CzcIlrvGMj/w9CBM2w==
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id h20-20020a056870d25400b000db12b50da3mr4592133oac.211.1648051113213;
        Wed, 23 Mar 2022 08:58:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm104610oiv.21.2022.03.23.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:58:32 -0700 (PDT)
Received: (nullmailer pid 4180667 invoked by uid 1000);
        Wed, 23 Mar 2022 15:58:31 -0000
Date:   Wed, 23 Mar 2022 10:58:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     hammer.hsieh@sunplus.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: Add bindings doc for Sunplus
 SoC SP7021 PWM Driver
Message-ID: <YjtDpyGp8pXYcqVH@robh.at.kernel.org>
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
 <1647945781-10191-2-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647945781-10191-2-git-send-email-hammerh0314@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 18:43:00 +0800, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC SP7021 PWM Driver
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v4:
>  - no change
> 
>  .../bindings/pwm/sunplus,sp7021-pwm.yaml           | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
