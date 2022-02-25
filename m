Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9054C50FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiBYVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBYVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:51:57 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E180420B17F;
        Fri, 25 Feb 2022 13:51:24 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso8190756ooc.12;
        Fri, 25 Feb 2022 13:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNZDXKjO/1bJ5XgseVVoCjXh1SMdy2uNrqfwQ5cFDT8=;
        b=seljKpxyTl5vZgm/0KlSRUqFKCp1yCdFNT8+RvXXKDtennxGRZ7Ocx6FVLlk9zuaMh
         mDHULB+6njRyVrFNqlQnl3jq9PDiRV9n0o07MeMm1ON7zLoaJvTA37lSFa7PzLQMBPsB
         J1Qza61lW3Xc85lAkyOr7585EBi6bw7wnOgctZVTgY6B5UCfHmr3X8cZJXxGti3V2qP4
         NYRplbeQd/uKvgp/qsrGUlaCGWjnq8cwUObtoBJRvAwpYzoNIV+Q4eNMWMWxsXC1A3uk
         YdvuPOIgWsrbGR5qmYpOvRULkCOcGgPI6IVFXuUyAHTQ4415pFdFCq5UWdsPFERh7Oa9
         sx9Q==
X-Gm-Message-State: AOAM5322A3N2jGlKciDAXar/IYJKa/fIIYFTCmq3JlmEtP8vFoyTxt78
        vcV3utO7qnR1tmFDqsuXDRwP/t4cYA==
X-Google-Smtp-Source: ABdhPJxK2Sgd1udlMS8wtOVclPvdi6Yi93m7seN8s7ei2XP9amzr1TD9kvRtDdN4D33tE9XPlAnlFA==
X-Received: by 2002:a05:6871:7a5:b0:ce:c0c9:648 with SMTP id o37-20020a05687107a500b000cec0c90648mr2374975oap.154.1645825884251;
        Fri, 25 Feb 2022 13:51:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 43-20020a9d0bae000000b005ad3659923asm1671115oth.26.2022.02.25.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 13:51:23 -0800 (PST)
Received: (nullmailer pid 30007 invoked by uid 1000);
        Fri, 25 Feb 2022 21:51:22 -0000
Date:   Fri, 25 Feb 2022 15:51:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, wells.lu@sunplus.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] nvmem: dt-bindings: Fix the error of dt-bindings check
Message-ID: <YhlPWkfH+30TaJCx@robh.at.kernel.org>
References: <1645776611-24774-1-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645776611-24774-1-git-send-email-vincent.sunplus@gmail.com>
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

On Fri, 25 Feb 2022 16:10:11 +0800, Vincent Shih wrote:
> 1. Remove the unnecessary header file for dt-binding check
> 2. Replace OTPRX with 0x15 since it is not defined here.
> 3. Modify the name of the node of the clock driver.
> 
> Fixes: e15d2e3fd7("nvmem: Fix the compilation error for SP7021")
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
