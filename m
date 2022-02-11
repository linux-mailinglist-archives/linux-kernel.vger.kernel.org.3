Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215C4B2791
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiBKOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:11:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBKOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:11:05 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AACDA0;
        Fri, 11 Feb 2022 06:11:04 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso6145386ott.7;
        Fri, 11 Feb 2022 06:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5ZV7c1BTvMQrTyTrzEO6DcoPIchCnNdxyU34RYMtBQ=;
        b=RwVznML1ZWi14Ynw+SL39pw5p/xZko5YLyFF8kLgwPF+Xkmwzbvj3b9JKcOVtVyOuD
         3f5D2PhnG0lXOJWQL24CPrNfSPNnv1BWfVuHlpwDRTSWrFgNxC08Do+UCSYgFVeeYTnw
         yebWHsXw+dy2JSUk1C0kFrkDX+D5Fky1rnGnBtK0FQr4mfT0kz8g8fEOY+ZjLr1WwDBw
         f+nXwvF1oU0fZ32Ch+6hEwrvLZiieqFd+X/8QsP58FEbbyD7oD4mqmdFRIUM35Ou+fli
         fkgL3HDmHsOxNm1y3HKau1Po7zOhI4N8JGz3AozGvNsyurJG9G+S+rmej4+gLAv6u5jP
         R6bA==
X-Gm-Message-State: AOAM533fqrno7gG1FbVbTXczX2FyoIGcDHmXZf0EgCqregk5NNEelGki
        U08CpAA30lN7zK5zSQoVN6Bae8qRtw==
X-Google-Smtp-Source: ABdhPJyKWbhcqqaXHUhFOSUILAVFEVK5o6LBarx/UMn9LkNa0U2xhLya5magcik/sXf8dQUQLFAsJg==
X-Received: by 2002:a05:6830:1686:: with SMTP id k6mr653137otr.181.1644588662739;
        Fri, 11 Feb 2022 06:11:02 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id i26sm1694751oos.35.2022.02.11.06.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:11:02 -0800 (PST)
Received: (nullmailer pid 288430 invoked by uid 1000);
        Fri, 11 Feb 2022 14:11:00 -0000
Date:   Fri, 11 Feb 2022 08:11:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: ti: Add clock-output-names for
 clockctrl
Message-ID: <YgZudCnBK64ilTwX@robh.at.kernel.org>
References: <20220203112337.19821-1-tony@atomide.com>
 <20220203112337.19821-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203112337.19821-2-tony@atomide.com>
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

On Thu, 03 Feb 2022 13:23:36 +0200, Tony Lindgren wrote:
> This allows us to use clock-output-names for the clockctrl instance
> name instead of relying on a custom compatible or non-standard node
> names.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/clock/ti-clkctrl.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
