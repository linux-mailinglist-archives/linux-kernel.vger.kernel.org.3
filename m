Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088864AE797
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiBIDIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350597AbiBIDGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:06:50 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC12C061355;
        Tue,  8 Feb 2022 19:06:49 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id u3so1134057oiv.12;
        Tue, 08 Feb 2022 19:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVeDVNu/BCICylDILAovuwAjxje6g+Ysjhgt1fngzyo=;
        b=s4KY/WE7aA8yQjdAmtSpuWj3H04Zf0yzuyjnK24hWRtBiq6ayYhHwGQamZNHMeJKAW
         BLRMDrpGFLWY/0PWT+k+FwFppZmrDcH5ocynxswTRLW6XWluGJ4KxmNl3IVoyydXRSo3
         b7kmr/liRAFgU38UCi+E34SgMnPsb4lQ5KatvSHTMC+CLA9B0zTlkdCMht2xhyePklen
         vg7BUjzX5o91RoyV1oyw1yq7cM7O2AkkR+IjlKp5hV4qqzMltq5ERD1iuDCBbYiCdbTE
         IaP+FDS9Gk4hE3rqthJLLyGR5YwWBa8HLsHdUqCbj/q55pmNUZrD1+u+GPX6r4h8Pu4P
         naSQ==
X-Gm-Message-State: AOAM532ExdH1GlsA0g8YLe4Z9GheJ3wHENvuFdRfdYoZptlqrRaqpYof
        ETkJNE2iT4sT0/muLf0kuA==
X-Google-Smtp-Source: ABdhPJx7cq9TDX0KZTFuW81BDWG1EoY4kxSCvCuwLrOluU5T0RnjLOr+uJoVJdCOGfn8uJmNHIWu7Q==
X-Received: by 2002:a05:6808:1702:: with SMTP id bc2mr484788oib.214.1644376009186;
        Tue, 08 Feb 2022 19:06:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j19sm6006307ots.21.2022.02.08.19.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:06:47 -0800 (PST)
Received: (nullmailer pid 3546662 invoked by uid 1000);
        Wed, 09 Feb 2022 03:06:46 -0000
Date:   Tue, 8 Feb 2022 21:06:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Colin Cross <ccross@android.com>, Daniel Vetter <daniel@ffwll.ch>,
        Anton Vorontsov <anton@enomsg.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: display: visionox-rm69299: document new
 compatible string
Message-ID: <YgMvxpbUpgw3XdxS@robh.at.kernel.org>
References: <20220123173650.290349-4-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123173650.290349-4-caleb@connolly.tech>
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

On Sun, 23 Jan 2022 17:37:41 +0000, Caleb Connolly wrote:
> Document a new compatible string for the second panel variant.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../devicetree/bindings/display/panel/visionox,rm69299.yaml   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
