Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0674AE878
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348323AbiBIELk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiBIEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:05:48 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C7C061577;
        Tue,  8 Feb 2022 20:05:48 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so688533oth.12;
        Tue, 08 Feb 2022 20:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3YMeRwUz1ntDWPYVtPYMrCAxcHYKG6DDEiI0zJMrfg=;
        b=KnNK8ez/GdaB6zPZw9XZJu/1vd2ygrGTZ29yeSTo8uSEXR/naKeV18p4XmjHpAx2rS
         1rFPa3zKhvjKWcPyKCSzT7UDJ7A31R+PhI0TzHzznHgjAez7bUKfTCf3EFFL1sTg+TJr
         UkSB/VwdybL0ANoAGyw9f8Vxmn5rkztspsPGN8BJcT9qJoIYo5qQ3hWRWki2NPyIssC1
         A8xuyj08/fBJB5Jf6SAPcRuKKTyfpg9FffDdfR3jZkddIoTHThcW/VctYhmttxjFsv3z
         YgNbCYrLyeu/Km5JAZDC36ndpzfehPm+y0Zxxdbo9tiBwrbZ97mKMwOG1o+iMi9Z41c9
         /Zqg==
X-Gm-Message-State: AOAM531pfHJe+tCtEpU64S0R6efomCOzGn6so6pwF60ilhGFX7ojZQAw
        kgklpE97csd7yWhHSjagUQ==
X-Google-Smtp-Source: ABdhPJz9jfeHHaiH+4zU1BTJWQ08GH8RdUKft2JUKLvjWaGoFuEonXdybnOG23G7sSVt+nWlCflSsg==
X-Received: by 2002:a9d:73da:: with SMTP id m26mr225820otk.72.1644379547459;
        Tue, 08 Feb 2022 20:05:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s13sm6218679ooh.43.2022.02.08.20.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:05:46 -0800 (PST)
Received: (nullmailer pid 3634207 invoked by uid 1000);
        Wed, 09 Feb 2022 04:05:45 -0000
Date:   Tue, 8 Feb 2022 22:05:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 05/12] dt-bindings: interrupt-controller: add compatible
 string for UX600 PLIC
Message-ID: <YgM9mdKvrjlEKRN0@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-6-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-6-icenowy@nucleisys.com>
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

On Thu, 27 Jan 2022 23:16:40 +0800, Icenowy Zheng wrote:
> Nuclei UX600 series CPU has an optional PLIC (recommended when running
> Linux).
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
