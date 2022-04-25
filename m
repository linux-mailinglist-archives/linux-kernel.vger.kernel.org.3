Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70850E4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiDYP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiDYP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:59:11 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533083F31D;
        Mon, 25 Apr 2022 08:56:07 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e93ff05b23so3390699fac.9;
        Mon, 25 Apr 2022 08:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzWHzJwvI1YDOjifiK5zK9xLEEWNcPatflkVwV3CNuo=;
        b=5bcLOFvpgJIbHkTPGUjTriBCtBJt9Sas59xoqTuqw7NPl7WxK3ZL8vPr/U/WRMnsV4
         g9YEVFrX/EWdFoYlcYUM0ZiSuwLMkBxPiFLXAmZSUSPCAe4GLC/1Zp8ND+3+zZz5GnU3
         AG893nalRydA2yys+QIP7UX3HMuWAves+W/AICuGlWPdFF4VR4DwFxxIlfi9wBaRppOQ
         apfG2XZWbFKX6KMxwOIuo4WRAbcp0s0UzqMegvkui/rbvHHIWcOSrFOmVuH5EiBL9v9Y
         kKvkc6zwVmSGaSp7Ab3D6ZCB/agu+oYIWsboaSW3OH2cGOME3dgGyi4qaLd0QbHf/iIu
         QVPA==
X-Gm-Message-State: AOAM532kYsNYsdQ7wBq5/71+XjzIHy1B39N0HwNE2j/hap1Xnc15e37j
        5+XYrCleA9U8/jrKkBtglg==
X-Google-Smtp-Source: ABdhPJyPQ8/QljI2VNCdMD5ZCs9UmxeOXcXs7325MEcBQ5fMSfUVDwchl6dRhxjgfuxnOxX9p2s6EA==
X-Received: by 2002:a05:6870:961b:b0:e2:ffb9:f526 with SMTP id d27-20020a056870961b00b000e2ffb9f526mr11477742oaq.146.1650902166630;
        Mon, 25 Apr 2022 08:56:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lc23-20020a056871419700b000e70c74e060sm3330025oab.8.2022.04.25.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:56:06 -0700 (PDT)
Received: (nullmailer pid 3956143 invoked by uid 1000);
        Mon, 25 Apr 2022 15:56:04 -0000
Date:   Mon, 25 Apr 2022 10:56:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org, Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Subject: Re: [PATCH v4 1/2] of: overlay: rename variables to be consistent
Message-ID: <YmbElDC2GBUNY1E+@robh.at.kernel.org>
References: <20220420222505.928492-1-frowand.list@gmail.com>
 <20220420222505.928492-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420222505.928492-2-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 17:25:04 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Variables change name across function calls when there is not a good
> reason to do so.  Fix by changing "fdt" to "new_fdt" and "tree" to
> "overlay_root".
> 
> The name disparity was confusing when creating the following commit.
> The name changes are in this separate commit to make review of the
> following commmit less complex.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> ---
> Changes since v3:
>    - none
> 
> Changes since v2:
>    - use new variable name "overlay_root" instead of new variable
>      new "overlay_tree"
> 
>  drivers/of/overlay.c | 94 ++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> 

Applied, thanks!
