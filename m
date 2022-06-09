Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F34544FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiFIOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiFIOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:50:32 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BE60B99;
        Thu,  9 Jun 2022 07:50:31 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id e80so882251iof.3;
        Thu, 09 Jun 2022 07:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqOhEjQU7/6IK5+BwfzvHD432pBIiSiBOcMf1isHAPk=;
        b=pDIjmcPxYaytVqKaCN+mb8Q6rNpYwkiWqGYiSzZOuA6ZWQH9yPxaxWn49eBAjtpQSO
         5iBuFIn6US3TWD9+NzMRpomDhEYauqsNaxXx6v9CSF7RNs9ZdJ3UzU4RShry47uOwuB/
         Zo5sRnkRexiG+6ggB/fTbf9L4iJab1LVtOW17Ys9/7L+DRQ2a/tQV5AAHYSoQmbUVx8y
         bRo+zAGy+dnFbhhhFIDS1wsoY36pXZethL7aoY2xhSiI6oHVpYBQ6PFS3ImH0YkPl84h
         VvwnjK7dTrc3cC8bWYDDnV4CL5XcTKErO/N88dnDfUB6CyhuWZV9O0eUueXcxwOnqPOP
         zHaw==
X-Gm-Message-State: AOAM530MXuvSmY0tOgHMs00vS9U3DhVtwhmxyPJ0LvauSEmax5/1fHcx
        yW+bVKv7BVnCEUuFf0D9LUst11sbyg==
X-Google-Smtp-Source: ABdhPJwjeyRAVJBIsGO2JpRVvCtk1YV7lhx0UBfY1zeYjWBAid5k3NPSlZFyocmOSHDaJeDGB/tppg==
X-Received: by 2002:a5d:9d9d:0:b0:669:6319:e727 with SMTP id ay29-20020a5d9d9d000000b006696319e727mr8688443iob.116.1654786230416;
        Thu, 09 Jun 2022 07:50:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r186-20020a6b2bc3000000b00669aef0c9e0sm906172ior.36.2022.06.09.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:50:30 -0700 (PDT)
Received: (nullmailer pid 3775141 invoked by uid 1000);
        Thu, 09 Jun 2022 14:50:27 -0000
Date:   Thu, 9 Jun 2022 08:50:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, Rob Herring <robh+dt@kernel.org>,
        anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, samyon.furman@broadcom.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM6856 SoC
Message-ID: <20220609145027.GA3774978-robh@kernel.org>
References: <20220608180437.31971-1-william.zhang@broadcom.com>
 <20220608180437.31971-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608180437.31971-2-william.zhang@broadcom.com>
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

On Wed, 08 Jun 2022 11:04:35 -0700, William Zhang wrote:
> Add BCM6856 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
