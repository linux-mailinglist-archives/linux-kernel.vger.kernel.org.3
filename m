Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199C4B25EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243075AbiBKMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiBKMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:38:40 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BD1A4;
        Fri, 11 Feb 2022 04:38:38 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso10071492oop.9;
        Fri, 11 Feb 2022 04:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=marrboxrkvy6rFSJaOQ3G7fIKmfU+2w0NS1Nneww1Eo=;
        b=iGaB2nUTsgg68j0Z4DPoCVolRERDw72CiQZzEiHojNcnu83cOZ3iidhpRxq83FBI3T
         6RUHhU+PshJAoRp+/qGlumzbnl8WzZjkDQKBhBRwHhjYrT1lsrLfTIN/iOPQwOvRIzYQ
         OgsxnIkkM3SnwUJ550LYcHwtH2qN0cnZ8kkGVFCvNrN8ibE83y2+OnDxEHAX718F0loP
         ygobd8GCiRYxo81pnj6Tq9f46qqZADzwa3GO19CMbnyHz1xNtlOCKY7BP7m5+yKEGFku
         IckMfJoiCgVKqIZZCbThh2O2t8O+1inNuZHQ80KI4AlyJ5fhAc5662SkbpcqT+OLW7pj
         gHWg==
X-Gm-Message-State: AOAM532/jLOdXkT0ifneKDntF9yYbFZ4QUBNZo+V5GAezM4TjRm0xoC5
        yykAtdgnF5lspB85f4OfTg==
X-Google-Smtp-Source: ABdhPJztdF3qpCFo97FLt5c6G18W/gBnuWv5aekVuuXR4+Yv1NMOgOAWJVVJKPnXuO4Ks4Xz7CC8Gg==
X-Received: by 2002:a05:6871:4101:: with SMTP id la1mr48544oab.238.1644583117936;
        Fri, 11 Feb 2022 04:38:37 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d4:10b7:69a2:33cd:1782:fb47])
        by smtp.gmail.com with ESMTPSA id 5sm6206333oai.15.2022.02.11.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:38:37 -0800 (PST)
Received: (nullmailer pid 183082 invoked by uid 1000);
        Fri, 11 Feb 2022 12:38:34 -0000
Date:   Fri, 11 Feb 2022 06:38:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: make "reg" property optional
Message-ID: <YgZYyl5NsBc/2LeJ@robh.at.kernel.org>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220124160300.25131-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124160300.25131-2-zajec5@gmail.com>
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

On Mon, 24 Jan 2022 17:02:58 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Most NVMEM providers have cells at hardcoded addresses however there are
> some exceptions. Some devices store cells layout in internal structs
> using custom formats.
> 
> It's important to allow NVMEM consumers to still reference such NVMEM
> cells. Making "reg" optional allows defining NVMEM cells by their names
> only and using them with phandles.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
