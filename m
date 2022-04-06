Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A84F65CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiDFQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiDFQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:38:33 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390230F0E7;
        Wed,  6 Apr 2022 06:57:38 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-df22f50e0cso2977270fac.3;
        Wed, 06 Apr 2022 06:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IoTrH399V4w8zNS3hx92QeecL6aapQBwIZRVFzEFkyA=;
        b=AydhoGsNhOvR4qLXcmo7wICq+phpgbjf0Q0ePxytNG8olancLb3uKb+bWozUGzKkgN
         nRztUoqOIPks9vpQyUZMXQaUMzCJvPGV+rVpzlNGr9vlj7TJSSmNZxMRN1s72KhwtXf+
         6qw8nl2DIsPqkp+wOhH2TEpmQ08V0IMj9xViNzdVd6GpW+EyzjYJCAPpMJcx5kyozDZc
         CLaDnaMYcuOa5axlWCp/P2osbxAPt2BsDoAwTmZ8b4wZaEvTZi7ozfyx9mxG9LWmvFVp
         PyW7SICCjoqU71MQNdHZ1stDFxSsmcIs00hR+A/op8HQwOn1t9hzHrl3viOUT87Sptis
         v5rw==
X-Gm-Message-State: AOAM5329/G1rcUEBlq5M+rP4da0YN4hXhkW9RJtlrwtP5yghDG2BXQpq
        MkmquYTfvx4p8u3jZ6gdiA==
X-Google-Smtp-Source: ABdhPJyVkLh7kt44PDdY781513MiisiGrnzUUrMoGmsbykheJJX4LewN7PtkNvDUojOPiN2cC9nuCg==
X-Received: by 2002:a05:6870:51cc:b0:e1:e6ee:448f with SMTP id b12-20020a05687051cc00b000e1e6ee448fmr3880243oaj.136.1649253457860;
        Wed, 06 Apr 2022 06:57:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm6478072oab.52.2022.04.06.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:57:37 -0700 (PDT)
Received: (nullmailer pid 2155527 invoked by uid 1000);
        Wed, 06 Apr 2022 13:57:35 -0000
Date:   Wed, 6 Apr 2022 08:57:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
Message-ID: <Yk2cTwmYqAZf4sCz@robh.at.kernel.org>
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Mar 16, 2022 at 08:06:33PM +0000, Lad Prabhakar wrote:
> Now that all the DT drivers have switched to platform_get_irq() we can now
> safely drop the static setup of IRQ resource from DT core code.
> 
> With the above change hierarchical setup of irq domains is no longer
> bypassed and thus allowing hierarchical interrupt domains to describe
> interrupts using "interrupts" DT property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> Sending this as RFC as couple of more drivers need to hit -rc yet with
> the platform_get_irq() change while that is in progress I wanted to get
> some feedback on this patch.

I've applied this now and it is in today's linux-next. Keep an eye out 
for any regression reports. There's one for i.MX8 in kernel-ci, but I 
don't think it is related.

Rob
