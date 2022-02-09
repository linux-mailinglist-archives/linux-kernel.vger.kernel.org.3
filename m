Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8094AE889
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiBIEO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiBIEFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:05:39 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413CC061577;
        Tue,  8 Feb 2022 20:05:38 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so1116987oos.6;
        Tue, 08 Feb 2022 20:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YJEp1y8iCJ2S4WFtcvM5uy6fuG8c3Ku48eFSnwsHWA=;
        b=ZzEuDwCu5paM2q53qV3EIyAIlj7764Sx//DUE9tBTeoPWoRmoU5U+U1wYgodh4FBQN
         e7mf6/O2EnClQIrYmYcbNMZHmKShZ+A1K7whJoOX6JgC010rkMMGHEoJFlWvQMG1jAmC
         FLSkR/rjk2NxtCysfr2XISyS1GI/2qhIfVJujnzrkldU862AKjG01COHO84oH1GGN88S
         VTJSFstsgwRokwKpQY87n+oG0TmHAWWkB215VVACRhNx8uOckvHEj8aYbHjN8VYc4oeq
         LTljsCFJ0/G3NoIA8BH20LYrgiuYAiriITEm8wHJscEK7MAMHNZdul0c1mvX7Sq2XpRH
         kc4Q==
X-Gm-Message-State: AOAM533eCwFBVr+ehc0AB1VQEUZmYsUimAyRCE6X7oey2HIOzfkiH+oX
        zI5hwscz9vznYebsQu1y9Q==
X-Google-Smtp-Source: ABdhPJxtfxlnaGd0pCly9Xm4mmWh9iuw4ZqsWb6mTNbxfLnoSwVVtfymonRJeYWvvV7WHMD1SK6z/A==
X-Received: by 2002:a05:6870:5311:: with SMTP id j17mr158071oan.143.1644379537255;
        Tue, 08 Feb 2022 20:05:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v26sm6086382ooq.20.2022.02.08.20.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:05:36 -0800 (PST)
Received: (nullmailer pid 3633873 invoked by uid 1000);
        Wed, 09 Feb 2022 04:05:35 -0000
Date:   Tue, 8 Feb 2022 22:05:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: timer: add compatible for Nuclei
 UX600 CLINT-compat timer
Message-ID: <YgM9j99CBBaB+CRT@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-5-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-5-icenowy@nucleisys.com>
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

On Thu, 27 Jan 2022 23:16:39 +0800, Icenowy Zheng wrote:
> Nuclei UX600's timer has a part which is compatible with CLINT.
> 
> Add a DT compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
