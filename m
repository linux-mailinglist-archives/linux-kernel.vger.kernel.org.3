Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FC5224A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiEJTWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiEJTWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:22:04 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF931FCE9;
        Tue, 10 May 2022 12:22:02 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-edeb6c3642so200488fac.3;
        Tue, 10 May 2022 12:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOeO/afyFS/XTtDfqJaGTJH459YM3JndEn1z08dciLU=;
        b=nLrDqlUz3zpt/gXv6mZU60/TNkQ0JJqVfDDv/DUPzDRv8QfyQE/qpLYveyDIkPoPiV
         ou033oE0QLqqCI0lVU+YkgPAygKKaQ1bbqn8P2VgmGaU4ST6lj2l2uO0CBH0gAp0fY3a
         CQdGzFeIqId4IzWyhNjqlDzNwgL11DiKCcqzkHZhT0/Sz0DBT444Q8UfoRHAL7Xf5vRw
         HN3GeXrdFRJs96tC9Szx2HbxQ2jUFMEBCIE+2zsTPoAR0wiPPX/HkpZG0T7GalYwWshF
         Xyz3ZaTUfLrQTu7Av2sHaNviBLNwxWD2veTOXv+0X95BcsAfUK40iU+H5wPYJ0wWiryh
         uhNA==
X-Gm-Message-State: AOAM532h3VZ6foH9aWwJgZOUooF1tTv1FMNJR+DXy63KUxGOuZs8Y17x
        VsTB/Unah8/OmCLvLotTMg==
X-Google-Smtp-Source: ABdhPJxpQ1XAsWPMyaBF13bhgHrh4lNMGmsczuL2k3FYenOZZriJV7SoSzmwEwNFMtH4JSzDTWqMXw==
X-Received: by 2002:a05:6870:ecac:b0:ec:f11f:db99 with SMTP id eo44-20020a056870ecac00b000ecf11fdb99mr966384oab.266.1652210522089;
        Tue, 10 May 2022 12:22:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 3-20020a9d0d83000000b00606a6f74748sm11384ots.25.2022.05.10.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:22:01 -0700 (PDT)
Received: (nullmailer pid 2436736 invoked by uid 1000);
        Tue, 10 May 2022 19:22:01 -0000
Date:   Tue, 10 May 2022 14:22:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 3/3] arm64: dts: intel: add device tree for n6000
Message-ID: <20220510192201.GB2427587-robh@kernel.org>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
 <20220508142624.491045-4-matthew.gerlach@linux.intel.com>
 <eee2d4f6-703d-d3bb-3949-493f9d65f676@linaro.org>
 <alpine.DEB.2.22.394.2205100717170.612063@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2205100717170.612063@rhweight-WRK1>
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

On Tue, May 10, 2022 at 07:17:59AM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Mon, 9 May 2022, Krzysztof Kozlowski wrote:
> 
> > On 08/05/2022 16:26, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Add a device tree for the n6000 instantiation of Agilex
> > > Hard Processor System (HPS).
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Kryzysztof,
> 
> Thanks for the Acked-by.  I will add your tag to a v5 patch set submission.

Before I commented, why would there be a v5? TBC, you don't need to 
resend just to add tags. The tools (b4, PW) do this for us. But when you 
do send another version you need to add the tags as the tools don't look 
at prior versions.

Rob
