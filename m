Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7373E5A1AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiHYVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiHYVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:23:30 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F68BB03F;
        Thu, 25 Aug 2022 14:23:29 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso14799358otv.1;
        Thu, 25 Aug 2022 14:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=51otqrz0GPgz+ixQCPPF1nsKQtLGKD6gtswOkCmqupY=;
        b=r49Uawrho4E26aRNOAUw11L+WdKPp5DBV5iBucQb1TAkVw5IbQFSikPWTsilIlH82Q
         QQTceKSrqUfrmP6ZCtCml+nPckMYvX2WbaLKnX5fxW2n4EGdFSJoIfoJMOx9SSasvtFM
         t4MPLVX43N7BWq8xSxFf0O23iiVWAFqBCGq/97P0FT/NtITBBqDZ/hxEXT3CBffGHKx2
         +CCvQ57ZVa6gUoZPpHTgCsfzwRm2vQzjJ+fUZfoZUh6m2SgDLJ1tFL36oHriUXSXUr9R
         lcVfVM8eAq/MKAxLkL3YtsIUSZGMEcbuSLLHBkJEqWfuofbeBbY2o2rJ2DQY0eWmPjWB
         xprg==
X-Gm-Message-State: ACgBeo3R1O/edtjDSWL/9eCt4HpKAYTffmezMebuo90rQbxteCV97iAb
        2tqm9ZPCAy0yBxRvvVBLAg==
X-Google-Smtp-Source: AA6agR6PhtqkCr+FV3HlhKF7GnDgDMVSpDf5Wzi8ihB9/ihsD9LmNjahCY9mq7ClC16Dz+LsK4odQQ==
X-Received: by 2002:a9d:6d1a:0:b0:638:b3a7:c1da with SMTP id o26-20020a9d6d1a000000b00638b3a7c1damr362646otp.324.1661462608348;
        Thu, 25 Aug 2022 14:23:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d30-20020a9d2921000000b00636deb2bfe6sm58809otb.68.2022.08.25.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:23:27 -0700 (PDT)
Received: (nullmailer pid 1712083 invoked by uid 1000);
        Thu, 25 Aug 2022 21:23:27 -0000
Date:   Thu, 25 Aug 2022 16:23:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerry Ray <jerry.ray@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [linux][PATCH v2 1/2] dts: arm: Adding docs for SAMA5D3-EDS board
Message-ID: <20220825212327.GA1712004-robh@kernel.org>
References: <20220822181314.8325-1-jerry.ray@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822181314.8325-1-jerry.ray@microchip.com>
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

On Mon, 22 Aug 2022 13:13:13 -0500, Jerry Ray wrote:
> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
> description yaml file.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v1->v2:
>  - Added Device Tree documentation for Microchip SAMA5D3-EDS board
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
