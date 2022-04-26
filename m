Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A33510A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354913AbiDZUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354803AbiDZUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:31:14 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3389644F4;
        Tue, 26 Apr 2022 13:28:05 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e922e68b0fso9525513fac.1;
        Tue, 26 Apr 2022 13:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTGhasCc9yjmHmaD0NPU5EnnIkuDiiXDBCOCrMNlv4s=;
        b=k0FfoMLaMUSI8rqH6Z/WqjFdX9NIpde1MchVq3u2QeXjkVjn69v2bFAG1V2jrP9Ue0
         ZbRNyRS9bhNwPCIEOUaDWHw+c6pUdlg1qgFSHtBCD8dexqL0dJ3X9qINbJdOJLIPFKhF
         4MGtfgKA27fKlmZRSOMBSlG7a0gf2CutN+KbEATRya25DzhRrW4PSI8dc8O+N+XcnH4G
         exUT+tbo81FslN8yQolSgyeKPLDzE1EPPkjVESiTbfnLRsx9Gk5izOlCeezpWkjD4wFA
         nvw7rOZ1CI7jdZZ0H+fIzvukMRy3d9yNZRht1zbZP5qACQM3JDQG+yP095fH2yl/5CYx
         vOZQ==
X-Gm-Message-State: AOAM5324bvTvIXItXbo3M3DPjvQjh2B/BF8Oqg+k4mSxa3+fX7e1P9Pd
        4Fup2VEDOnTX/e//Z9+VXLulLCf6fw==
X-Google-Smtp-Source: ABdhPJzpYq2n0nv2TF39pmx4gCvCf5QPLF2pDEuRzAiYZ6jaA4GaZqpDkfJDsAum61zRxBRLqrUmgA==
X-Received: by 2002:a05:6870:638d:b0:e9:1d25:3c74 with SMTP id t13-20020a056870638d00b000e91d253c74mr6848732oap.233.1651004885191;
        Tue, 26 Apr 2022 13:28:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m126-20020aca3f84000000b002ef895f4bf8sm5136284oia.24.2022.04.26.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:28:04 -0700 (PDT)
Received: (nullmailer pid 2480905 invoked by uid 1000);
        Tue, 26 Apr 2022 20:28:03 -0000
Date:   Tue, 26 Apr 2022 15:28:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
Cc:     "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Message-ID: <YmhV08V2jTeB448O@robh.at.kernel.org>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-2-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419154555.24191-2-ddrokosov@sberdevices.ru>
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

On Tue, Apr 19, 2022 at 03:45:51PM +0000, Rokosov Dmitry Dmitrievich wrote:
> MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
> electromechanical system technology company which produces micro
> electromechanical system microphones and sensors.
> MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
> in consumer electronics, industrial control, medical electronics
> and automotive, and other fields.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 294093d..d8f29ad 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -737,6 +737,8 @@ patternProperties:
>      description: Mellanox Technologies
>    "^memsic,.*":
>      description: MEMSIC Inc.
> +  "^memsensing,.*":
> +    description: MEMSensing Microsystems Co., Ltd.

Alphabetical order. This needs to be before memsic.

>    "^menlo,.*":
>      description: Menlo Systems GmbH
>    "^mentor,.*":
> -- 
> 2.9.5
> 
