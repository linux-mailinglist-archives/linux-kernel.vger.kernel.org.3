Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBE4B2AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351684AbiBKQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:45:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351679AbiBKQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:45:13 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A5D65;
        Fri, 11 Feb 2022 08:45:12 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 4so10114277oil.11;
        Fri, 11 Feb 2022 08:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpKsSIgrUxkBB3vTwRKoVrnCiMHMdTbRgtKbLjr8N3U=;
        b=PbGz1ZQwimya1/NzsCliRccnhtan+GLecX4D6gAuFCPTt57+ea2PB9XvOCR8SGDTSA
         58hzySypmK23t3eLcq8aGFaY8fFa6XqimnPu5RuUnkxflUYescMQ2v2/RXLAOJblqoHn
         HvQzFtpC8GzyuEf5O2yWaZEkC5Q8se7NJOe69KSPzYAYW/U0C6QddSrRDcFs8V6G2s4V
         EQegNuuMM2Mg911j5eYFkhsorOfh5IRn/jxCOaBSQL/Dw+hL2YHCU1sq76ngSaeoXUqm
         Cy8vsXUsyoXTizhjQtFT8niIPZXizdLQ3ew1heMeyaOMRT1H7A8T7tpSuGKrGfOQCmk1
         ohdA==
X-Gm-Message-State: AOAM532m4hEJKIX/6SN634SIagUUJmGJSebkh3VOCO6kOn2ODo3Xegq0
        O7uIVd95S8thD5mytLlQBQ==
X-Google-Smtp-Source: ABdhPJwsGPWRnSoi8k6YGa9SndTci5gF+1JgN/VZHMhRX5nXpjjr2kXCh/LVDwe1tJKyCpzZQafF/Q==
X-Received: by 2002:a05:6808:e89:: with SMTP id k9mr570166oil.263.1644597911370;
        Fri, 11 Feb 2022 08:45:11 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id m26sm9630247ooa.36.2022.02.11.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:45:10 -0800 (PST)
Received: (nullmailer pid 496961 invoked by uid 1000);
        Fri, 11 Feb 2022 16:45:07 -0000
Date:   Fri, 11 Feb 2022 10:45:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: r9a06g032: Add the definition
 of the the watchdog clock
Message-ID: <YgaSk6NuSR5GZeLc@robh.at.kernel.org>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
 <20220208183511.2925304-2-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208183511.2925304-2-jjhiblot@traphandler.com>
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

On Tue, 08 Feb 2022 19:35:05 +0100, Jean-Jacques Hiblot wrote:
> This clock is actually the REF_SYNC_D8 clock.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  include/dt-bindings/clock/r9a06g032-sysctrl.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
