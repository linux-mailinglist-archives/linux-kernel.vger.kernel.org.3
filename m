Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F5B4AE72D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiBICpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbiBIChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:37:18 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34426C061355;
        Tue,  8 Feb 2022 18:37:17 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so871461ooo.13;
        Tue, 08 Feb 2022 18:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tG6MAWrIRzAJ3N/9dub38Yj2UooXcV2O7UbSNG/ESko=;
        b=JVinuTqmB6sEzyqBVv4McZE1/Ic2Bz5ZRohdNTshWu2Pc8fMw++qy2uhcXVbfLLEat
         SamAY98zdRQ1cjOMS90XP1Az2kPHycTk5fDhxZFIYI9gh9EqraydkHEBWXuLYR3QXbLv
         zMkqudMZiG4Nc5pLuYWPw0gNZX6mlozrp4hpkjahZFZ8lYhYpT3/UfMb7m/vjPJYuEfB
         XQ0l9nmuXCWA4gDp5u4M4zi5aDkz8kXHTjcPKaFWTJ7RoS0Dnpqo7ayLpKso218t4Qgv
         OpJODCS6gUjzUYZ+qhgizvkigCSyDSshNwZMTYzyTRVmmq3ZZEX1lJ0e44mmXF8h0CE4
         6F/w==
X-Gm-Message-State: AOAM5320GVDTDHlXagYc1+pVEfrB4lqk5R23C2OcehSGRK43a5E4qlFY
        uFRZVF+kBWhqqoBHIbbyJQ==
X-Google-Smtp-Source: ABdhPJwtj3nyOGboH6MSCet48gbSVJvqfiel4X1W+2fhd3L6PWSfDl5EAZTiNYo/nM91HyvDS40UAA==
X-Received: by 2002:a05:6870:e6d5:: with SMTP id s21mr272959oak.148.1644374236567;
        Tue, 08 Feb 2022 18:37:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m14sm6582685ooj.22.2022.02.08.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:37:15 -0800 (PST)
Received: (nullmailer pid 3501259 invoked by uid 1000);
        Wed, 09 Feb 2022 02:37:14 -0000
Date:   Tue, 8 Feb 2022 20:37:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: make comment indentation
 consistent
Message-ID: <YgMo2mS2ekwpuPFQ@robh.at.kernel.org>
References: <20220114172155.GA3677@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114172155.GA3677@standask-GA-A55M-S2HP>
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

On Fri, 14 Jan 2022 18:21:55 +0100, Stanislav Jakubek wrote:
> Makes the comment indentation consistent across the board.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks!
