Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A542568BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiGFOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:48:56 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303051B791;
        Wed,  6 Jul 2022 07:48:56 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id u13so4997336iln.6;
        Wed, 06 Jul 2022 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=badKAwxl6oMYcNxW/h/2c+73UYSFXg04UnT39V63dEY=;
        b=drnFzMiMKglMs3v3dL2yeHtJOdXe5G5KVUfOrMDwuBtkEbpb7wSJpF86daJwFhCsB+
         S+4KuMAQSshFHOYtPf5sErqPo4438LU3eoHOWCrMQPmM6/zzd9rlz9P0P2XpynfJz0sP
         944cYFVM5XFXnIlm3VZm6a33VFeQyzvkrADitjr739u87FvB4S0LdVb8gRanXyr+qpL8
         mMpsM8sLD+qD+Rc3Gk9o4LbKTUqL/8LjXrk0kp528CCnRTtLH+BRnfjDhemKSs4K5/Jp
         ShUHcLSlz9nf/I8ZOuxa8sq13PzewvEs4ZzTeaRKONpBAZz3iDeV4fY79WwwXi16aUcs
         Trjg==
X-Gm-Message-State: AJIora/USItJIjFct7YyRCZr6qTpi7bYXdYj5WbEt2W9wJQxCVNrO3xb
        PbM6thzNZlfWbQ7r6vEh2Qx4adr4fw==
X-Google-Smtp-Source: AGRyM1tBrNnki+lfPqg2cOAqAZB5OjGxdYUw+1gtao/4Tl9wpSN/tJZyuxCChwl49Gwzpzh0Ru1Rqg==
X-Received: by 2002:a05:6e02:1a2f:b0:2dc:31f1:2976 with SMTP id g15-20020a056e021a2f00b002dc31f12976mr2718982ile.179.1657118935408;
        Wed, 06 Jul 2022 07:48:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b18-20020a92c852000000b002dc251040besm1968252ilq.46.2022.07.06.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:48:55 -0700 (PDT)
Received: (nullmailer pid 22489 invoked by uid 1000);
        Wed, 06 Jul 2022 14:48:52 -0000
Date:   Wed, 6 Jul 2022 08:48:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     mahesh.r.vaidya@intel.com, kenchappa.demakkanavar@intel.com,
        robh+dt@kernel.org, furong.zhou@intel.com, broonie@kernel.org,
        fancer.lancer@gmail.com, mgross@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, rashmi.a@intel.com,
        devicetree@vger.kernel.org, kris.pan@intel.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <20220706144852.GA22435-robh@kernel.org>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-3-nandhini.srikandan@intel.com>
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

On Wed, 06 Jul 2022 12:20:37 +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
