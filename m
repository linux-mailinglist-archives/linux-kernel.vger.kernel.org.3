Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995734AFE23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiBIUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:19:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBIUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:19:37 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14914E010DBE;
        Wed,  9 Feb 2022 12:19:40 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so3809929ooi.7;
        Wed, 09 Feb 2022 12:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wq4vdKGMeXoIRNXOtMWhnncER4U349yKDpCvUwhL4uI=;
        b=KGt3Uyvqq9FK1vwl86Rn8TtyKKo9PoYRqeB5kRyYYukVKJRXQ1DJO12h79UKF0rRv4
         6DzAtLN5WtOpdHO4XeqgDV6h/bBAcskHLeoDGh1XGapVkFEnoHWmiDosi2L3QwnEHZaJ
         6Czp7gqAL5sEHkiUr6bWfzk7gC3mVpDzm0vUnwkChrCUjxdy1FJiDMRBpJgWRdme5b+j
         ayvInv08P6QeVVz8hq5A+TWru1eLAY/wiqgjFhlX+FT0eohxDUfj28is60CnlI9zPh0p
         6IYlceS6bCOJQTinGAPP/CaawOJMcTKemZCf2D4Ck/68EbB7hh3MvC87+okT2x8hT6Z9
         xEDQ==
X-Gm-Message-State: AOAM533v1P/CJMjtdtCSkzMM3ktQ/1jMhIONcQMBiL5nACEqLKpKwA9P
        SChhWj2jejrsnV4T/DNev0DsqC19Xw==
X-Google-Smtp-Source: ABdhPJwkGIFmvi/YRXr/h/wnQirAhEqYAsd5AzUXVjmhqfax7kfjOA+NyA0T6LZenez6U6kRp4zfUg==
X-Received: by 2002:a05:6870:a583:: with SMTP id c3mr1452455oam.197.1644437979384;
        Wed, 09 Feb 2022 12:19:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d21sm6939901otq.68.2022.02.09.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:19:38 -0800 (PST)
Received: (nullmailer pid 828716 invoked by uid 1000);
        Wed, 09 Feb 2022 20:19:36 -0000
Date:   Wed, 9 Feb 2022 14:19:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 03/15] dt-bindings: devfreq: rk3399_dmc: Fix Hz units
Message-ID: <YgQh2AnJenCuoFgu@robh.at.kernel.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127150615.v2.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
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

On Thu, Jan 27, 2022 at 03:07:14PM -0800, Brian Norris wrote:
> The driver and all downstream device trees [1] are using Hz units, but
> the document claims MHz. DRAM frequency for these systems can't possibly
> exceed 2^32-1 Hz, so the choice of unit doesn't really matter than much.
> 
> Rather than add unnecessary risk in getting the units wrong, let's just
> go with the unofficial convention and make the docs match reality.
> 
> A sub-1MHz frequency is extremely unlikely, so include a minimum in the
> schema, to help catch anybody who might have believed this was MHz.
> 
> [1] And notably, also those trying to upstream them:
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
