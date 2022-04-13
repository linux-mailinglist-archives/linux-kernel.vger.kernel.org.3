Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEB4FFF02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiDMTTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiDMTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:19:21 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A354992F;
        Wed, 13 Apr 2022 12:17:00 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so1812689otq.13;
        Wed, 13 Apr 2022 12:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OG6/xlTJb1VDtxX/jYuWE/Aaym3px7iuUI1gWT/4wA=;
        b=B/7zp0Nuruk+a1RW4AyBz6KaBYgD0aKB46CQkJQNDYoPOuqdb6CsqADeDCVZKxjGjz
         ktYMz78vOatqRUZD/4g3JvNJ2PhaPm1xh0bhIFArqKlPqvMGyO55mvC0Pa2WuX68ofv7
         Tu2R7X9p8q8sjDf0yPhrPSPsxG7TEFqFapOv6SSMMoau75C4f8+71vGQy0GHj0UkKuC8
         xtICG7HFhqcwstPHeCfNMOAqwt9ar+SlN13Pkt+6sgIb6fGEhT1mEr1cEwHzthVWw+h+
         TYJ9T+hzlw0ukgdVDATXAr3FXWq0tNexVVvabZBBcNiX14pF/+ne7/vxLxTTbo3mGnft
         EvKQ==
X-Gm-Message-State: AOAM533MjwCmXl/G+lwKOsaJABwV+lyot9QfocWeXNCiTv//eCBvTXy+
        POByy9VsvLjTn65RmQGV7A==
X-Google-Smtp-Source: ABdhPJxR6fL0BeHk55waAbvl1lont9ShYBHrDZMSZblOEWzhOcpz9SxmqlxDK3tj/6hnHimY9uzsXg==
X-Received: by 2002:a05:6830:2b13:b0:5c9:467b:3d8 with SMTP id l19-20020a0568302b1300b005c9467b03d8mr15309899otv.13.1649877419443;
        Wed, 13 Apr 2022 12:16:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ace88000000b00321598cd45dsm14045436oos.33.2022.04.13.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:16:59 -0700 (PDT)
Received: (nullmailer pid 3671797 invoked by uid 1000);
        Wed, 13 Apr 2022 19:16:58 -0000
Date:   Wed, 13 Apr 2022 14:16:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux@armlinux.org.uk,
        p.zabel@pengutronix.de, sre@kernel.org,
        cristian.birsan@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v3 04/10] dt-bindings: reset: add sama7g5 definitions
Message-ID: <YlchqlqI49tKIlMc@robh.at.kernel.org>
References: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
 <20220408080031.2527232-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408080031.2527232-5-claudiu.beznea@microchip.com>
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

On Fri, 08 Apr 2022 11:00:25 +0300, Claudiu Beznea wrote:
> Add reset bindings for SAMA7G5. At the moment only USB PHYs are
> included.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  include/dt-bindings/reset/sama7g5-reset.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 include/dt-bindings/reset/sama7g5-reset.h
> 

Acked-by: Rob Herring <robh@kernel.org>
