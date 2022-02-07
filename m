Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FC4ACD60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbiBHBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbiBGW43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:56:29 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32FC061355;
        Mon,  7 Feb 2022 14:56:28 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so12598051ooi.7;
        Mon, 07 Feb 2022 14:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmFI+q45YMcvomfhfLrjDMiP1+XWJx7omIVN2lFQ8M0=;
        b=H89w3LXioiTGxPy7sEEKoKQuZbxP7qqKtRE1SLq4hmv00veCDdH/F1TQLd27II9IHW
         kF4fLoXS3uGAZP4OqbCWlqtWtAanLeZsxR4U9KZXrxM4a8C85WQ+vjZ0UZ+bVuw9FAY4
         GRzeZkNM7dj0SyrDvPbFh0kUQMDCzzxxIuWAooslIrEAdB38ELPxkT/VpdlDHmUBr9Uv
         1mqA8xdWm6un8X3o2q/J8VTqMSEt00R+1Y6/hCwu5iRE1kLgSUc+X42n49vZpfcfn9kT
         UZMSkFhmNwpl371N15gsUtJOi6pswFlkT64MiAz9nvQFLnszrL4jg0bbimPzKHZSEGMw
         OznQ==
X-Gm-Message-State: AOAM533JUzaABUi67pHiqzBBUPj5UG1vmsprNzORCXjKGbwO2pFS2cWp
        hqv64sbLusDEr60bdo0fvmKuVJxiAg==
X-Google-Smtp-Source: ABdhPJwpY3DiOxQGHIBlNjzmF3SPnnu9F68MKT/GtouYtpE8Lp2q3KAgvciQZOhPYzX5nq/FLGuSTA==
X-Received: by 2002:a05:6871:581:: with SMTP id u1mr390160oan.139.1644274588097;
        Mon, 07 Feb 2022 14:56:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh7sm846291oib.6.2022.02.07.14.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:56:27 -0800 (PST)
Received: (nullmailer pid 1082342 invoked by uid 1000);
        Mon, 07 Feb 2022 22:56:26 -0000
Date:   Mon, 7 Feb 2022 16:56:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add BananaPi R2 Pro Board
Message-ID: <YgGjmtyvioH8Vjrt@robh.at.kernel.org>
References: <20220123135116.136846-1-linux@fw-web.de>
 <20220123135116.136846-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123135116.136846-2-linux@fw-web.de>
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

On Sun, 23 Jan 2022 14:51:15 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Devicetree Binding for Bananapi R2 Pro Board based on rk3568 SoC
> 
> Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
