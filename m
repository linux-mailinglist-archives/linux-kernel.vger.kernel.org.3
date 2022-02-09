Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CB4AFE29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiBIUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:21:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiBIUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:21:47 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C34CE016DA6;
        Wed,  9 Feb 2022 12:21:50 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso3841270ooi.1;
        Wed, 09 Feb 2022 12:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmfSzxuqzirL1V0Zykp0UDWGW3LWKCMN5F4vQtCRtPI=;
        b=d0+fVGjcTfbKzxAY3Ur1i2xEYcmjzxm+TLt5+HhHPliuFiDa0et4UW8PXhpoi8sylU
         2htp7gSBKhghhvOk5yvjP//W35BsgVWKwQSra1l7yLZHdFQioLyrwxVDtWJJzy9bnXue
         v3wNgnTVnzy0DiQLWe0xTmxtHg7ZRBdqbbru/GH+V7fFvnkUJLuA6Pfhikwz1cGGavdw
         kuA5merNoEPVkdbaUKwKCDMdX7GIrn2i99C7CQAnC+JsFsdhBIMXPQVgs5lRNDL6lo6B
         jamLOjth9LQbshWbW+diJw4NWMiPDr3r1bAlbM70OOX5sXJT50UajMYEfv+EZsu6dPd6
         A2tQ==
X-Gm-Message-State: AOAM532MDDcdcZC54iJ+WpBurDd4qbhPNdbr9uG0pZfDwaNkQ0yrI8hW
        c2Sr4nON8pfla1IRVNo1sw==
X-Google-Smtp-Source: ABdhPJwRFJgoaGuDGAhOtb0UhcP86Z5hgt7jSmayowRpL9dQ8ELxljV7pJYS2pDBKJqnY1e6nyk9nQ==
X-Received: by 2002:a05:6870:d502:: with SMTP id b2mr1441779oan.94.1644438109620;
        Wed, 09 Feb 2022 12:21:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t4sm7283982oie.14.2022.02.09.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:21:48 -0800 (PST)
Received: (nullmailer pid 832955 invoked by uid 1000);
        Wed, 09 Feb 2022 20:21:47 -0000
Date:   Wed, 9 Feb 2022 14:21:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2 04/15] dt-bindings: devfreq: rk3399_dmc: Specify idle
 params in nanoseconds
Message-ID: <YgQiW8PhI/G6OqR6@robh.at.kernel.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127150615.v2.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
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

On Thu, 27 Jan 2022 15:07:15 -0800, Brian Norris wrote:
> It's inefficient to use the same number of cycles for all OPPs, since
> lower frequencies make for longer idle times. Let's specify the idle
> time instead, so software can pick the optimal number of cycles on its
> own.
> 
> NB: these bindings aren't used anywhere yet.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v2:
>  - New patch
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 50 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
