Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C754B027F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiBJB4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:56:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiBJBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:42 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9A2AAAF;
        Wed,  9 Feb 2022 17:40:26 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id o19so11053533ybc.12;
        Wed, 09 Feb 2022 17:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3EibQva733Ukt948OLTo6btkyTLhec3MLRWkEWmaPwg=;
        b=Q6/kKfuSalcaDyhP+3+T/ceswezcknBCvq4MyCnN3Xo8KuT12PCe6fG09UA8kxYPCg
         eNwUl0GX49/8LDtDLJtLquwE8bQeVsz3UwBSEdpd+e9Pi8Xqko7zFcVx0xAw2clLwXXS
         /Nknq2f6t1sW0diqZ2qvnoHjKr8+DboWSZ9qvpj1Z0wE96CNcXTyI+nYhgCSg/TDOn+r
         pPtaUGeyGGHst+xbyI4ji9qPrzCj0xcoKXyEueYTivH0CUkSabmsP25HUbIQGlSHMOc5
         HDShk+DSrv480MHe+zqk3sjbE3zfROhnRFWF526G5bN19/ziEV8YKc4H1B0o+rL916Y7
         jUpQ==
X-Gm-Message-State: AOAM5329iTEWBfJvbtTKA64J+JoGOf9kAU+q0hFm3p8Fn+TAvrW7GIA2
        nHc+lsc+sEUPMwoM1lA5OibUgLZercI5
X-Google-Smtp-Source: ABdhPJxCChio0ovak+VAyXBSpYB+F8cv7odWMUWIQmTPsU6/RvwafuEVhpp5eKU7rVZHTJqHN34+9g==
X-Received: by 2002:a05:6830:43a8:: with SMTP id s40mr1995632otv.98.1644453552318;
        Wed, 09 Feb 2022 16:39:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j9sm7514743otp.23.2022.02.09.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:39:11 -0800 (PST)
Received: (nullmailer pid 1272329 invoked by uid 1000);
        Thu, 10 Feb 2022 00:39:10 -0000
Date:   Wed, 9 Feb 2022 18:39:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     quentin.schulz@theobroma-systems.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, Quentin Schulz <foss+kernel@0leil.net>,
        robh+dt@kernel.org, airlied@linux.ie,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        sam@ravnborg.org, thierry.reding@gmail.com
Subject: Re: [PATCH] dt-bindings: ltk050h3146w: replace Heiko Stuebner by
 myself as maintainer
Message-ID: <YgReroGOJQlWjFvt@robh.at.kernel.org>
References: <20220131165439.717713-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131165439.717713-1-quentin.schulz@theobroma-systems.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 17:54:39 +0100, quentin.schulz@theobroma-systems.com wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Heiko does not work at Theobroma Systems anymore and the boards using
> those panels are downstream, maintained internally by the company, so
> let's relieve Heiko of maintainership duties.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
