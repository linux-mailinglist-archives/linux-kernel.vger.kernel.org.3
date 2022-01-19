Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB05493C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355256AbiASOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:47:09 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33714 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355269AbiASOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:47:07 -0500
Received: by mail-ot1-f44.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so3462069otu.0;
        Wed, 19 Jan 2022 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By8MCaOUBXm4JFsoFgchXDiBCHq73b/VK8JwUra9Jqg=;
        b=n22PQpmiTDIAzaJYMEPL7jrd3ES9QPCcygW9DJkrEx9ugspQd4D2VLURVe2R1K6ZJr
         XiZ7UX+1Oh6iqoXcRXHNWdeoixEFuf4zR8BIYLAWaZxRVLeGdl1P+8MDaFWe7irbHyqz
         10No200JR9TaNJVUAPxg+AXWUp86XA4u0sQzBr0bCLeqS804QhvoFlY77LZWh8cEowFw
         KTgnyBhF+2PO95b/8LWeTd70x7FUzPck78HF97hj+sdHFNjMDFPipqSZc80iBHaGEPWI
         3ZmNwYMmjDMyIqpFdBxrsMBApnIVEXfNDwU9KO8QsOt3ZigYw8ACqSAuRZxe2v1AHrks
         VZLw==
X-Gm-Message-State: AOAM5308sS/pFNP/LKnL+20yBssb+gPBeqHH8DV6nsaB8QLEyt4Vrq3N
        WiJNR3zcWZ++16jIgELL8A==
X-Google-Smtp-Source: ABdhPJxp9A2YTb4rIod/BHhcjrN+GmXr5oaQ5Ihbp3C5qD7s5hWwFzjwRycYR3w87G4fUPsDUSaq9g==
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr19236753otr.259.1642603626375;
        Wed, 19 Jan 2022 06:47:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm10264392oib.1.2022.01.19.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:47:05 -0800 (PST)
Received: (nullmailer pid 3537590 invoked by uid 1000);
        Wed, 19 Jan 2022 14:47:04 -0000
Date:   Wed, 19 Jan 2022 08:47:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com, robh+dt@kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v3 2/2] dt: bindings: KTD20xx: Introduce the ktd20xx
 family of RGB drivers
Message-ID: <YegkaA49xZONJcrx@robh.at.kernel.org>
References: <20220117124741.7165-1-fe@dev.tdt.de>
 <20220117124741.7165-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117124741.7165-3-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 13:47:41 +0100, Florian Eckert wrote:
> Introduce the bindings for the Kinetic KTD2061/58/59/60RGB LED device
> driver. The KTD20xx can control RGB LEDs individually. Because of the
> hardware limitations, only 7 colors and the color black (off) can be set.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

