Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A85A6B95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiH3SBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiH3SBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:15 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B775A8BF;
        Tue, 30 Aug 2022 11:01:01 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so17733239fac.4;
        Tue, 30 Aug 2022 11:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8M/7Lx16+OlBZKe+Y8q5TplQAj/xrxLLqahY/Z66u+I=;
        b=aF/c7ossgPMUHWpfLPqpJQsHIW69LMkF+0mDwVyl02hsp7zIX9xb7PyjC25AJTLCU6
         JLhFXvKPoNL6QCM5ZrJNjWs+BX+Nq0hUFVma+HhqzVq185gAudd3VY6RnuJACbJy6iN6
         KrYjJHTlHNySTb7QJlmiOT6Wz6k8lUWA/NvcgD3wVA34EurMRaWIhDmG+ba9CqURPEm6
         TzBAw6URAnMq3MJoRyGt6loXXPfa++xLRLt6OAvenqNYL5IZQCDmweAlxzRfue6hHyF1
         GUYQg2REin15Qxu30pARQ+VAIX/a0Ki4wMGCgPpon9A4Awg3+Y9arzzuPHb73atALY29
         7N/A==
X-Gm-Message-State: ACgBeo0/wRaHgsS5jDUiimgk18SZTB3svEp5BJrXuLzA6kJhDVl23QSZ
        mr4P56KcL3qOPiFAnYjeo8AlWd5c7A==
X-Google-Smtp-Source: AA6agR7ZDsNAq6OLZ9Us1tI663luQbBgXmT2TSNrkZQM5o6zI6UitXxnefX1mp2lqzQ7fh4fH8qzRw==
X-Received: by 2002:a05:6808:10c2:b0:345:c2da:79b9 with SMTP id s2-20020a05680810c200b00345c2da79b9mr8468377ois.298.1661882461042;
        Tue, 30 Aug 2022 11:01:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o12-20020a4ae58c000000b0044afc1ba91asm7191960oov.44.2022.08.30.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:01:00 -0700 (PDT)
Received: (nullmailer pid 1764917 invoked by uid 1000);
        Tue, 30 Aug 2022 18:00:58 -0000
Date:   Tue, 30 Aug 2022 13:00:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Nelson <robertcnelson@gmail.com>
Cc:     devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone
 AI-64
Message-ID: <20220830180058.GA1764859-robh@kernel.org>
References: <20220822230304.2284952-1-robertcnelson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822230304.2284952-1-robertcnelson@gmail.com>
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

On Mon, 22 Aug 2022 18:03:03 -0500, Robert Nelson wrote:
> This board is based on the ti,j721e
> 
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---
> Changes since v1:
>  - added documenation links
>  - add board in alphabetical order
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
