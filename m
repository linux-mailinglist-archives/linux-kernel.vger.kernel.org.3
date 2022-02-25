Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF54C4DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiBYSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiBYSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:31:27 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5412261C6;
        Fri, 25 Feb 2022 10:30:52 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id x6-20020a4a4106000000b003193022319cso7439937ooa.4;
        Fri, 25 Feb 2022 10:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nO46MVOxeBfrtpgtlpU0KanUna9yJ6hZKlTky8BlctQ=;
        b=YpqbsMG8rmnCi7wV84vccmWgr1YPtz7FZEX6KFVKU4XIKJtRJTo1uhIgP6RkKhWimb
         ZjzHdYmyPwfiQAhsRUllhhlk9zj3d2kKlCZErwbU7EJqdNz1sANIg9hEKKhTWofl/WIU
         yvEnE1filsAsOnx8fhS9CktEXysErYcdQDby8WGYssYYhRjU9vMl54+b8IpqZqlqKzIv
         ysMECoqZO1S4kR8VVZOab5Qr0Q2/GyPurYTBzcOy+ZiKbLs+fXN/jm16BQ/+VHh7skDo
         qV9MilE+/SRSAoGWSC7MsAXrkWiCrUHa0rtYlhNNxlR++aQ6iPtT092dpg7/SrjgAId5
         xRuw==
X-Gm-Message-State: AOAM530TDEPkAN6eqaIyMSkXcHidwddQZdVS1UuoHWKLkybEfl4CeAKT
        +3ZnRMDqHLu6Stk6M6lFKw==
X-Google-Smtp-Source: ABdhPJwze7ScTwIWh5otCQGWo8AuNWqBADfUNufKuQfg4u37IUgUudm8gG9CpH7NlIUPHuoaXkQGjg==
X-Received: by 2002:a05:6870:3048:b0:c4:7dc0:d758 with SMTP id u8-20020a056870304800b000c47dc0d758mr1983376oau.299.1645813851685;
        Fri, 25 Feb 2022 10:30:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm1765902oib.19.2022.02.25.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:30:51 -0800 (PST)
Received: (nullmailer pid 1208822 invoked by uid 1000);
        Fri, 25 Feb 2022 18:30:48 -0000
Date:   Fri, 25 Feb 2022 12:30:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex Nie <rexnie3@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 2/2] dt-bindings: display: simple: Add InnoLux
 n140hca-eac panel
Message-ID: <YhkgWH1Q1T3vA7BG@robh.at.kernel.org>
References: <20220218102815.1634561-1-rexnie3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218102815.1634561-1-rexnie3@gmail.com>
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

On Fri, 18 Feb 2022 18:28:15 +0800, Rex Nie wrote:
> Add support for InnoLux n140hca-eac display panel. It is a 14" eDP panel
> with 1920x1080 display resolution.
> 
> Signed-off-by: Rex Nie <rexnie3@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
