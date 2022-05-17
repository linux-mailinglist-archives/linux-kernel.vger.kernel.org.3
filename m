Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997155295D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiEQAIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346488AbiEQAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:08:26 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69281A18C;
        Mon, 16 May 2022 17:08:23 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id n24so20563621oie.12;
        Mon, 16 May 2022 17:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKV83znyCudARWVx308rDQFv7HrABlDIuf2oPdiJjOU=;
        b=DpkQOdOl4CsEiuXB9kj+Pfe+CG3gvHg8hr5GcuCi9zmuSli/lIeWQcjz8ze0QVqDTg
         snaYLU2Eeh7I31NKklYHpYFFJxPFdR0F2K/Ha06Sa47goXEoFJ56ae79QyRCe43Y9TjH
         A9YP0XMDtAyOJsSE5v02Q/ZEcH48loX+wPsAfsayO7LnstsnVGNF3faXgxDX1yWNE3T6
         +1zwVFRjXhHhc+GokXILgrzoEovT6CNCYR/xYxujYPPpcOgxn3vcyPPrwWRrghcjuMYN
         RbyoWc+REvJ9v5NjoVn0kg+noyLb6no4rZ8HVwWx5FM2Jzsy8SmKncta4bK34fW8zwyC
         mOng==
X-Gm-Message-State: AOAM531kPu5DDH3roWFf1J3XVj2anLsa5lgBG7JEl72Ly7me6e7LmHfZ
        4CPMvO38WAn3qFAFtOL+Dw==
X-Google-Smtp-Source: ABdhPJzWHMMdBcMQOuhzfpc8OdCYszx64sPTWpfWPANxR7pG2clII4YpgP0xIfew29jWrZYjwUbD7Q==
X-Received: by 2002:a05:6808:bc6:b0:326:cf94:db25 with SMTP id o6-20020a0568080bc600b00326cf94db25mr9117555oik.297.1652746102328;
        Mon, 16 May 2022 17:08:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056870450400b000e686d1386dsm5832163oao.7.2022.05.16.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:08:21 -0700 (PDT)
Received: (nullmailer pid 3614833 invoked by uid 1000);
        Tue, 17 May 2022 00:08:20 -0000
Date:   Mon, 16 May 2022 19:08:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Schwermer <sven@svenschwermer.de>
Cc:     pavel@ucw.cz, schuchmann@schleissheimer.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multi-color
 default-intensities property
Message-ID: <20220517000820.GA3614766-robh@kernel.org>
References: <20220502204616.GA27288@ucw.cz>
 <eef2dba9633a860063527628a72f6a4523aaf6cd.1651744128.git.sven.schwermer@disruptive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef2dba9633a860063527628a72f6a4523aaf6cd.1651744128.git.sven.schwermer@disruptive-technologies.com>
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

On Thu, 05 May 2022 11:50:08 +0200, Sven Schwermer wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to assign intensity values to the individual sub LEDs
> (colors) at driver probe time, i.e. most commonly at kernel boot time.
> This is crucial for setting a specific color early in the boot process.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> 
> Notes:
>     V1->V2: no changes
>     V2->V3:
>     - Use color-intensity mapping instead of simple intensity array
>     - Add example DTS snippet
> 
>  .../bindings/leds/leds-class-multicolor.yaml  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
