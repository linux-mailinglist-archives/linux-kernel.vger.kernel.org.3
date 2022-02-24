Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF04C3642
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiBXT4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBXT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:56:09 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7625D6EC;
        Thu, 24 Feb 2022 11:55:39 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id s5so4571227oic.10;
        Thu, 24 Feb 2022 11:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/48U/SMEVzdXIrBsKPYPiGgB7YAdCZUvIfVb2uJmNzU=;
        b=LEZ0IHES15Gl5VWs5rjo4jKsCxs7+Gjo4nLlKCckwU/tg1hWN+4X7tQTnB4JuYT6Kd
         RqoN3TlTk2Ps8b+Sld9vrYqjHj6fWx37YqnjLB4XeYlua/J5IHyh3LthqniZICAdvgFo
         sXPOaPPjwV67GJB1nYSJpbJkxBg8mu9GIEXek0gt8KvDXSbHXo4yKrDjPaoKiDUYUl9/
         y6qZTbUalE/AcDArzd8tKAkokdBDYZe+4Dre318s7iTF0qKP3i6exPbtkHrOLHtRsD5D
         zGLdE/D6WIzY7BOJykoFgYV8zdTciAiMEtlsiTmk5ZJu2v8E1Oera3c+5G+1nnOqhE80
         UNXA==
X-Gm-Message-State: AOAM532HhCblAaLufEvspK1V6eC/d08XI0/eHiCPJSRLjdXE5Aq4JkGZ
        Is8prxfHVZaq+UwGGJj5uQ==
X-Google-Smtp-Source: ABdhPJwsni0oyv5Isyt48ty0qDvHIrzDlmpRR0YrGhd3iRPPY9uGnFYnegdpoMxqF8jqmIDyYj9SGQ==
X-Received: by 2002:aca:90e:0:b0:2d4:8fb3:2674 with SMTP id 14-20020aca090e000000b002d48fb32674mr2332252oij.124.1645732538912;
        Thu, 24 Feb 2022 11:55:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t82-20020a4a3e55000000b0031847b47aaasm127848oot.26.2022.02.24.11.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:55:37 -0800 (PST)
Received: (nullmailer pid 3484414 invoked by uid 1000);
        Thu, 24 Feb 2022 19:55:36 -0000
Date:   Thu, 24 Feb 2022 13:55:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH V3 2/3] dt-bindings: nvmem: brcm,nvram: add basic NVMEM
 cells
Message-ID: <YhfiuDZgIUidrySY@robh.at.kernel.org>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
 <20220218070729.3256-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218070729.3256-3-zajec5@gmail.com>
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

On Fri, 18 Feb 2022 08:07:28 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVRAM doesn't have cells at hardcoded addresses. They are stored in
> internal struct (custom & dynamic format). It's still important to
> define relevant cells in DT so NVMEM consumers can reference them.
> 
> Update binding to allow including basic cells as NVMEM device subnodes.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add children nodes description per Rob's request
> V3: Document NVMEM cells as properties
> ---
>  .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
