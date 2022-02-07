Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8514ACCEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiBHBEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245750AbiBGXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:30:15 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E54C061355;
        Mon,  7 Feb 2022 15:30:14 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so15567688oos.6;
        Mon, 07 Feb 2022 15:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o06Z2C6ucddM/E1nWqisrFEou44iflZYmFU1CywH1L0=;
        b=n6gw5Kip76L3jTfovcP4WyCQ6hNAobzcnmVUXAr6j1vfIWTK2mJQTD3E8zueVbBHh1
         vFVM4rEKnaUxTY9Jvu8doFIaQffiGjsEcxpv+v1N1hiFiCcC63HGQzCs9AOjPLEAHYnM
         CWJCKo223TGqvDG36X+qiRoKE5Zj/dHsZr28SNjFPkI+mhpK0wDP2bCjTELGwiYiu1SU
         QUev0+nbLLOC61GqYdPj74idVPDqz5W+bRkxVp9BZ/U7iVNxhwx4Ct3YuBvpYWA2Sw7u
         +WcvyD5BaPpNS5crlK5p9olPP/S08uBQzOQtAp+jCQB2t4Wvzwqs72aSpywTg8e+JpUA
         lRTg==
X-Gm-Message-State: AOAM532botc+C2kKrWlXrQQwrQ6Z6ehmddjcTCu84LklUuHQANKgkS47
        BSasrp1D8C0ZMzhdQqIV9XjqCG3+RQ==
X-Google-Smtp-Source: ABdhPJyQ2p7k9w3VIW2xGznTNuWY75mw7aoz+K9xhAqQiRh5W/Y7lLFNY+G1h0WtRY6Dfc/sIIppqA==
X-Received: by 2002:a05:6870:d2a5:: with SMTP id d37mr423134oae.75.1644276613606;
        Mon, 07 Feb 2022 15:30:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i81sm4883348oih.22.2022.02.07.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:30:12 -0800 (PST)
Received: (nullmailer pid 1130737 invoked by uid 1000);
        Mon, 07 Feb 2022 23:30:11 -0000
Date:   Mon, 7 Feb 2022 17:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     pavel@ucw.cz, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: remove ide-disk trigger
Message-ID: <YgGrg7NgHnK5chrE@robh.at.kernel.org>
References: <20220125210537.54036-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125210537.54036-1-clabbe@baylibre.com>
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

On Tue, Jan 25, 2022 at 09:05:37PM +0000, Corentin Labbe wrote:
> No user of ide-disk remains, so remove this deprecated trigger.

Strictly speaking, this would break someone if they didn't update their 
DT. But it only looks like only a few platforms used this and they were 
fixed in 2016. The commit message should say all this so I don't have to 
go research it.

With that,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - remove also DEFINE_LED_TRIGGER(ledtrig_ide)
> 
>  Documentation/devicetree/bindings/leds/common.yaml | 3 ---
>  drivers/leds/trigger/ledtrig-disk.c                | 4 ----
>  2 files changed, 7 deletions(-)
