Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222E14C315B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBXQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBXQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:30:56 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870C22A28C;
        Thu, 24 Feb 2022 08:30:14 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 12so3214079oix.12;
        Thu, 24 Feb 2022 08:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yr+sfuOfNHdQyG+q35zEWWVCyPCxhyS4l72NvjqQAQE=;
        b=bwAKUYVov8LbtetHXZSv0kH+VGqDKZdpqDTq/AgpmL08Ruc76j5T+vli0Ih3LkhVwn
         eYt6uajueNlKnok1TZm5ACptYL+aN9IDp7J1LT0uszXrhb9tQXzwkp0jKETUYslPKUmh
         PIYEbpmVV793vhtGx3Hb7/eqoVBywDsgRGUiIqvloa53jeBYe9NSemdLqLUgRjBECUf3
         1FWB5SRB6XPVS6QEzftwrWCz3QNu+WVvRw+jWgqHc77VhjRS+uZ2VFvE0Qvy/2r7PZqc
         4njw6m2Q5ElMBPus0bQzJA1qhaVz6eOW3Fexa5j0KOjgCCmSQM/Y+AeA1AS4Upjz40Xs
         mO5w==
X-Gm-Message-State: AOAM532MsaakvSgyZNWPWFKZKBEsCJ4W6lX79/+pEGpRg/aymlzmN2JY
        Dz5Ry6KmmOMK5Q3+OiMcoA==
X-Google-Smtp-Source: ABdhPJw7DLgArsDvgzMYFWqb/H9wjopgHImxe6PfYCer1KVAkvm2HcsLHQOxN85iEdZE1mf6IU2LGQ==
X-Received: by 2002:a05:6808:f93:b0:2d4:f855:aadd with SMTP id o19-20020a0568080f9300b002d4f855aaddmr1735874oiw.21.1645720213827;
        Thu, 24 Feb 2022 08:30:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w7sm1252982oou.13.2022.02.24.08.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:30:12 -0800 (PST)
Received: (nullmailer pid 3197991 invoked by uid 1000);
        Thu, 24 Feb 2022 16:30:11 -0000
Date:   Thu, 24 Feb 2022 10:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Message-ID: <Yheyk93a8fl5kFsp@robh.at.kernel.org>
References: <20220223130808.13352-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223130808.13352-1-cristian.pop@analog.com>
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

On Wed, 23 Feb 2022 15:08:07 +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in v7:
>  - Fix commit message
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
