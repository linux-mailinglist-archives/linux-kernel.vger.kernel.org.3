Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A1549DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiFMTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241245AbiFMTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:36:12 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023793FDB3;
        Mon, 13 Jun 2022 11:03:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p1so4826308ilj.9;
        Mon, 13 Jun 2022 11:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHzia+bhaBA7DMXVkKIrTmOmhwAsD0Y7KThGYZ8Hdc4=;
        b=v7TbA+Nz78VTC/4yKG1e+Zp2e1pWPUTnBI/vhWqgJyZokJVUsFuTd2vKuuQ0UlPltx
         Aw8uGHYpeqza/aRWnX2SD3ZrNuY3zQvbg88HYUdnUQh+Gq5PiT8e2fi8tQMPCz5Dq6ZH
         JmwFTTF9/S6yxyo1k8uyP8mgZ/Lzeuiby3wwZzf+gG9MFenAyV4cQGZ9HS1i8/rd0qJW
         o0KJr/Kmit5eUUx2qec34iiyDx4GtL2xlYFduk7IBM9K4Y5DxiZpVWoO+PyfVmq+O9lo
         2EtP9bddITJUTkg4zIzyRPEQiUPH9DEYyOLWxxAkJHeEeSlp3mXXin556VweUBpSth4e
         ZAIQ==
X-Gm-Message-State: AJIora9U4g0AdCuK9grGUhNgeLyV54+n8p7a6ASJjkauUu3JuAxbMBtJ
        +/kX+UX9P+74eRWanHOMMA==
X-Google-Smtp-Source: AGRyM1sAK2tNW0/E5Y94TDRjcKisI2L7QGgHIU7/awk1+gkGynbDfPu/INUy24XIlHKadZ/NU5nSIg==
X-Received: by 2002:a05:6e02:1b0c:b0:2d3:bfdf:e3c5 with SMTP id i12-20020a056e021b0c00b002d3bfdfe3c5mr631830ilv.138.1655143400248;
        Mon, 13 Jun 2022 11:03:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c2-20020a92c8c2000000b002d11397f4f9sm4191996ilq.74.2022.06.13.11.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:03:19 -0700 (PDT)
Received: (nullmailer pid 3990444 invoked by uid 1000);
        Mon, 13 Jun 2022 18:03:18 -0000
Date:   Mon, 13 Jun 2022 12:03:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     anand.gore@broadcom.com, samyon.furman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        f.fainelli@gmail.com, devicetree@vger.kernel.org,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        linux-kernel@vger.kernel.org, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add BCM63148 SoC
Message-ID: <20220613180318.GA3990308-robh@kernel.org>
References: <20220610002113.14483-1-william.zhang@broadcom.com>
 <20220610002113.14483-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610002113.14483-2-william.zhang@broadcom.com>
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

On Thu, 09 Jun 2022 17:21:11 -0700, William Zhang wrote:
> Add BCM63148 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
