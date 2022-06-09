Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87C54530B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiFIRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbiFIRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:33:42 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A495A0BD;
        Thu,  9 Jun 2022 10:33:41 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s1so19293058ilj.0;
        Thu, 09 Jun 2022 10:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWn57S5f9Z9b6oMfI7C9p2j+VVAsmBSYKE64z1PxtCA=;
        b=Km16BNF/8PM2xeCKCu8FVTjtdiMGIRdVh+5wjLCtHppMn0VPVPLfZjDPqdP8kHvY0H
         45Q++xLs7peD0M4BkZSGjduVCi08PF7a0PibrpgLquljo8O3Os4X8kocRENM85CQQD+V
         dpy01+yHR5uq29g6b3DQGS4UF7Rl4zXAuy7SM5WldZ/sY6pl85PRfah4KOc9H8s2f85s
         uec2aSsKxIKIPCDJQ6kJW6hPinlrP4TbJ0XPjHddeONRt1N53wr8PJl/5i+F+zHr1euj
         GOq/hQcCdvN+8Q79fCwXHb3uu+fUFtwQ5tqodBN+IMNt5TtVcFIoI3wHjfWgXe2pY+U3
         TXNg==
X-Gm-Message-State: AOAM532SNAhJ2t1odpStVXipOrgZj1UIN35oOKFmv//xU2Rro3V7bnOb
        rDNNrEH6zLFeWtuLWYCxxA==
X-Google-Smtp-Source: ABdhPJxgW6sqtSbBKLKvdVOjcfP8VNtezsKAqBETIH09H4fJeYpf3l5swm4ZZ3ncSZJMlQ1pxPaicg==
X-Received: by 2002:a05:6e02:1c22:b0:2d1:abab:8806 with SMTP id m2-20020a056e021c2200b002d1abab8806mr21549988ilh.300.1654796020385;
        Thu, 09 Jun 2022 10:33:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t18-20020a056e02011200b002d663b3dac7sm2442366ilm.5.2022.06.09.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:33:39 -0700 (PDT)
Received: (nullmailer pid 4000703 invoked by uid 1000);
        Thu, 09 Jun 2022 17:33:37 -0000
Date:   Thu, 9 Jun 2022 11:33:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzk+dt@kernel.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        openamp-system-reference@lists.openampproject.org
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Message-ID: <20220609173337.GA3996953-robh@kernel.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-2-tanmay.shah@xilinx.com>
 <9722112e-770f-53dd-4b28-48be696c0d12@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9722112e-770f-53dd-4b28-48be696c0d12@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:32:48AM -0700, Tanmay Shah wrote:
> Hi Rob,
> 
> Ping for reviews.

No need to ping me. You can check status of your patch here:

https://patchwork.ozlabs.org/project/devicetree-bindings/list/

If it is listed, Krzysztof or I will get to it.

Rob
