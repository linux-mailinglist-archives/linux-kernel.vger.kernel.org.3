Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683E04E2FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbiCUSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiCUSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:14:57 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579193CA67;
        Mon, 21 Mar 2022 11:13:32 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id q3-20020a05683031a300b005cd8cd111c7so2478576ots.12;
        Mon, 21 Mar 2022 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRFMn1osWa/ZYKOPqZAXKgS+FnppMTrQVFsT7zg78RU=;
        b=g76ZN/M23tM7Jey8C+wqQ+D81hx/VNvlSFy8OfakS2Q5Zg7iJ2yTSrX0aYqw+X8oMD
         QUkiZH+AG//M20NI8cMM6ith5k7lnuYJvbaIj2vWzR+94OXjd4S5QvocgCCXIw572B8v
         poV+ONy0k4u40ndr0DD5vNf8x493qBLHrZuY0A243t1rUDSKjnfM0BOCQtzXahRrgh/m
         9HXo4SMeD5QQEzFKADr/Iq1BpADsVuTe4m21WBcnq9qyCgqcjcRttzZluUsKJuDonQxD
         2OHikbs4ATpJXc5nJkPEcYbTjEApUk3jp+FXObvFyzuMCvKD/uyinzstRWFfO0GDKJVX
         VuPg==
X-Gm-Message-State: AOAM533ppiid7OtQUOaSHZkQgND7m3Ry0x2bdm/owyg3WLD4tzeupP3J
        vejG+7ABcT/ms9goKcqWDQ==
X-Google-Smtp-Source: ABdhPJw3NCN6bCabR/1zNiPRXLa1nZaKXjuYShlzUrxsSO5OfK3O+erAXjSIWX4kDwohV7Tanc1Njg==
X-Received: by 2002:a9d:6e89:0:b0:5b2:4c01:2210 with SMTP id a9-20020a9d6e89000000b005b24c012210mr8596541otr.85.1647886411634;
        Mon, 21 Mar 2022 11:13:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gb8-20020a056870670800b000ddd2bbe036sm3859842oab.45.2022.03.21.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:13:30 -0700 (PDT)
Received: (nullmailer pid 305316 invoked by uid 1000);
        Mon, 21 Mar 2022 18:13:29 -0000
Date:   Mon, 21 Mar 2022 13:13:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/5] dt-bindings: usb: samsung,exynos-usb2: add missing
 required reg
Message-ID: <YjjASQAhMmCShuaf@robh.at.kernel.org>
References: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
 <20220314181948.246434-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314181948.246434-4-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 19:19:47 +0100, Krzysztof Kozlowski wrote:
> "reg" property is required on Samsung S5PV210/Exynos EHCI/OHCI
> controllers.
> 
> Fixes: 4bf2283cb208 ("dt-bindings: usb: samsung,exynos-usb2: convert to dtschema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Fixed commit in current next. If this should go as fix, I can split it
> from the second commit.
> ---
>  Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
