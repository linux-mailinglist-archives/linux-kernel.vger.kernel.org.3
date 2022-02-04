Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647C94AA3DD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376413AbiBDXAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:00:06 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44618 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359282AbiBDXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:00:00 -0500
Received: by mail-oi1-f178.google.com with SMTP id 4so10192573oil.11;
        Fri, 04 Feb 2022 15:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STXGDBPnP0RX9U6EDzL7J0c/K6aSJxvfGk5fwnYV+K4=;
        b=qaBkwcVgO2Wk7wHie2ZLkW9Ve8KXRJlNHLMr8qMnCE6erxCJ+22zzKt6uahs4Nnu7B
         9th08crP95s7bYdfGcwKwJncQonwhBhEU71gTxKym6XP+ggC9QkOBAYF0I3xW5OwN2Zp
         vWoPOPpyi6wKD4gA0K6i/qLPxl7sd/KYFebws+oltN/wmhJHa97S+JetawaOOSd1iqfk
         LWzIBLwdwecLJ50qEYKfDDFT6HrzIR9BYs96VgxIb4kFWA9goL27a1BKyf1NSB+I9bBD
         USBJ2LAMWZMQD8rd81yapYRqvZdEZZTMF9cm5NVJimIyVzl8FwiFWcUPzlpt9D4mTTWa
         k2fw==
X-Gm-Message-State: AOAM533ubsxz5ZYXxb9IYRIF3BErzKfk3BOk4f2dfaORQ6ddc/BVPXc/
        IbLcLRtCM8AqKcfxZ9a9gA==
X-Google-Smtp-Source: ABdhPJwOCjh7ByHzDx16JRhBZO6cJ4zV+NShLss8PjVDzgeavJ9Lw93uh+T3zobTfz+ll9W5LpNWSg==
X-Received: by 2002:a05:6808:1688:: with SMTP id bb8mr651517oib.163.1644015599923;
        Fri, 04 Feb 2022 14:59:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm1072371oae.36.2022.02.04.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:59:59 -0800 (PST)
Received: (nullmailer pid 3342703 invoked by uid 1000);
        Fri, 04 Feb 2022 22:59:58 -0000
Date:   Fri, 4 Feb 2022 16:59:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     robh+dt@kernel.org, linux-media@vger.kernel.org,
        nicolas.ferre@microchip.com, jacopo+renesas@jmondi.org,
        devicetree@vger.kernel.org, sakari.ailus@iki.fi,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH v4 08/11] dt-bindings: media: microchip,xisc: add
 bus-width of 14
Message-ID: <Yf2v7owZpEDmkdiy@robh.at.kernel.org>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
 <20220121131416.603972-9-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121131416.603972-9-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 15:14:13 +0200, Eugen Hristev wrote:
> The Microchip XISC supports a bus width of 14 bits.
> Add it to the supported bus widths.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/microchip,xisc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
