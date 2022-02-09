Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCE4AE7B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiBIDJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiBIDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:08:40 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0637C061355;
        Tue,  8 Feb 2022 19:08:39 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id r27so1191776oiw.4;
        Tue, 08 Feb 2022 19:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPqHFGhkJ+vhTZOk3oqnFLw3EWUTrG27MAVUaUc4r+8=;
        b=YZ7XkRiJfAc+3H3wr/tPJxUvOLJJ2Vrkh0+eXuosBCOulwSOhyG4jwft8TU9bqI7vm
         4LFWibD3ZgsCL0IszxDAI8t2cSHYDcdTEOlJO/TWmNlQyxpRmSO7xM2f25tqJVMSJ2Jb
         Jpq+2TVG6Tqsq0Exj1KnppQ1vhxLoZA8Icko37lV2NdW01E9+PHsJrx9UCCdUwNRNK6G
         S6/5Lrisk+mXSJ3+vGwpPomlt4IWSbNtdb9l7GaQyYmd6g9vhXFdpJteJrTri5GYtv+W
         YmD3qWJYicqXJrdNcEJe4NyHdYxrzidg3MxLPZOvHEwc26BeIGMEuJhTrydDsIrBYhjt
         zVmw==
X-Gm-Message-State: AOAM531/gjn4o6wwiYEaH9pIhOKc+LN938XRjrYVrAByA4WQw3b538Jt
        wEMYIwQoEWiAG5aDshlKRMuNUo3KWg==
X-Google-Smtp-Source: ABdhPJxrynX5OJQ0KsCRxSK3maGJzN0rFfqQDdtf0twzTw7pIuDxTKbaejeHqqKfz9MMQYG+nsUbeA==
X-Received: by 2002:a05:6808:1b2c:: with SMTP id bx44mr456906oib.15.1644376119101;
        Tue, 08 Feb 2022 19:08:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm2537469oam.5.2022.02.08.19.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:08:38 -0800 (PST)
Received: (nullmailer pid 3549554 invoked by uid 1000);
        Wed, 09 Feb 2022 03:08:37 -0000
Date:   Tue, 8 Feb 2022 21:08:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        tomas.melin@vaisala.com, devicetree@vger.kernel.org,
        qing-wu.li@leica-geosystems.com.cn, robh+dt@kernel.org,
        lars@metafoo.de, jic23@kernel.org
Subject: Re: [PATCH V1 6/6] dt-bindings: iio: accel: sca3300: Document
 murata,scl3300
Message-ID: <YgMwNbv17MA2YtnX@robh.at.kernel.org>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220124093912.2429190-7-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124093912.2429190-7-Qing-wu.Li@leica-geosystems.com.cn>
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

On Mon, 24 Jan 2022 09:39:12 +0000, LI Qingwu wrote:
> initial DT bindings for Murata scl3300 inclinometer.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
