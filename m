Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA80580846
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiGYXdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiGYXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:33:05 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEE26AE6;
        Mon, 25 Jul 2022 16:33:05 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s204so15298256oif.5;
        Mon, 25 Jul 2022 16:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=35be8RwrHUGDdl8k/ntz3JQSksF3mPF6MXbq1qdhuHU=;
        b=4c0bPz+499WN8/wvOsb+37H3yIQZNV6aPWYFF8HNvW3PiZtiP3x5K56udw2h2k2V7Y
         NEB3yyQqPKmwTFl1+KLbvf/NBoK23yfv0m/CHYxEj0YAPODgR5CI03TRjiEG1dC3ny1w
         /0LVVJGEibwe+9oy/mKB61pfDgK8bR8OyXrOmZvBNp/ohK9+Do7m+xi7vxUfavT6A4E4
         Og68FuxnYgUmBM2Ge25OqMLDVBbe5yZoDOVHhnIatp59m5NvHZGgaARYO8J/QZ04uVfA
         sWNhnVd0mcYoQLNk/bd/AwHn3exfU22WvZmGKdrV/x0y32T18YcqtCdiZ2WA4Fji4+ef
         LqNg==
X-Gm-Message-State: AJIora+frBJzlU68OxJqlGHPkjRF3h+wam29PF7fzQ/0+AometbGrElJ
        y2OZOWxlN+cKZfzvEgADGg==
X-Google-Smtp-Source: AGRyM1tNQzJxjy2xupFgtOlnhIeZ+EZdU/HB0Xxsyad8N1nbdVc3UgpG6moPKBDToAkVZkHNcoXaaA==
X-Received: by 2002:aca:1a17:0:b0:33a:c75f:8020 with SMTP id a23-20020aca1a17000000b0033ac75f8020mr3599344oia.179.1658791984251;
        Mon, 25 Jul 2022 16:33:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i22-20020a056870221600b000f325409614sm6729181oaf.13.2022.07.25.16.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:33:03 -0700 (PDT)
Received: (nullmailer pid 2964216 invoked by uid 1000);
        Mon, 25 Jul 2022 23:33:01 -0000
Date:   Mon, 25 Jul 2022 17:33:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>, rafal@milecki.pl,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, anand.gore@broadcom.com,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        f.fainelli@gmail.com, kursad.oney@broadcom.com,
        krzysztof.kozlowski@linaro.org, joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dan.beygelman@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Message-ID: <20220725233301.GA2964152-robh@kernel.org>
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-3-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725055402.6013-3-william.zhang@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 22:53:55 -0700, William Zhang wrote:
> Append "brcm,bcmbca" to BCM4908 chip family compatible strings to
> follow the convention of BCMBCA chip and help identifying chip family.
> 
> Also add a bare bone generic 4908 board compatbile string to support any
> 4908 based board. This is useful for board bring-up test and kernel test
> with CPU and memory related change.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> ---
> 
> Changes in v2:
> - Add Acked-by tag
> - Insert the 4908 generic compatible string in alphabetical order
> - Update commit message with more details of 4908 generic board dts
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
