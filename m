Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF44D5346
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiCJUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiCJUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:52:17 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1E187E29;
        Thu, 10 Mar 2022 12:51:15 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso4894745ota.3;
        Thu, 10 Mar 2022 12:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slxCGGqrUztha0XPfFAUWL5ID7RQgaEMphARvX9hCBs=;
        b=lJEqe75HzUSBdhrNcJqdqMK20dq5eYZZtKWTCeH8Jo8/8ATWHO5luO0cOxXENzPDGc
         fdbjz0zsefTNo7T4nCrJO6f2mE2yTzFU3s4/fVsINEqTP2iVMp1ZD+2O9cWnv/rlvZfW
         lHdTZUyGgYKIIHtbQUhfhel94OLIyUBMJKIh8RGhMhcdNpbJ1wM1WC70XGxQqMVeR/K5
         GzPdMr86AojoX7o+OQOcwSTykZ7QR76eJx7KQZymUwrzaVu/v02w75XiKWIUTO/0b1Vw
         YAdWpgXpiNF52kXCD5FRsO+SVNB+Ils/DQ9anlTDmaW44IZpFlQnqNEKG9jSTNW7lI8D
         Wr0Q==
X-Gm-Message-State: AOAM53240MQCa7VBTeNEtJ48+zZJ0oVMuwvXg0bcvJVhjyJsd19hRmf8
        vp6dFcrhT5MvfkLGs3CxtA==
X-Google-Smtp-Source: ABdhPJz8G/QtOa+879lxZGa2RhwdFvUCb7Fy+vOXp2rvMTapgI5pc7gEgYdwEjMMeo8zWtoeAvPFGw==
X-Received: by 2002:a05:6830:22f2:b0:5c4:3f05:33cf with SMTP id t18-20020a05683022f200b005c43f0533cfmr2425782otc.330.1646945475301;
        Thu, 10 Mar 2022 12:51:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y8-20020a544d88000000b002d525da014bsm2668280oix.42.2022.03.10.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:51:14 -0800 (PST)
Received: (nullmailer pid 2046461 invoked by uid 1000);
        Thu, 10 Mar 2022 20:51:13 -0000
Date:   Thu, 10 Mar 2022 14:51:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        eran.m@variscite.com, festevam@gmail.com, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        patches@opensource.cirrus.com, perex@perex.cz,
        pierluigi.p@variscite.com, shengjiu.wang@gmail.com, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Re: [PATCH 3/4] ASoC: wm8904: extend device tree support
Message-ID: <YipkwW6rUbWweXn7@robh.at.kernel.org>
References: <20220307141041.27538-1-alifer.m@variscite.com>
 <20220307141041.27538-3-alifer.m@variscite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307141041.27538-3-alifer.m@variscite.com>
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

On Mon, Mar 07, 2022 at 11:10:40AM -0300, Alifer Moraes wrote:
> From: Pierluigi Passaro <pierluigi.p@variscite.com>
> 
> The platform_data structure is not populated when using device trees.
> This patch adds optional dts properties to allow populating it:
> - gpio-cfg
> - mic-cfg
> - num-drc-cfgs
> - drc-cfg-regs
> - drc-cfg-names
> - num-retune-mobile-cfgs
> - retune-mobile-cfg-regs
> - retune-mobile-cfg-names
> - retune-mobile-cfg-rates

If you want to add all this, convert to DT schema first. 

They all need vendor prefixes for starters.

> 
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
> ---
>  .../devicetree/bindings/sound/wm8904.txt      |  53 ++++++++
>  sound/soc/codecs/wm8904.c                     | 113 +++++++++++++++++-

Binding changes go in their own patches.
