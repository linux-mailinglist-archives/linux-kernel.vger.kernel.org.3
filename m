Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB54CB17C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiCBVkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiCBVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:40:22 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA4E70067;
        Wed,  2 Mar 2022 13:39:38 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso2854310ots.7;
        Wed, 02 Mar 2022 13:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJX9/TlWRUJexmSe/ehT+qegDC17Vjxv/vgEF02/DTg=;
        b=3wws3fmQYLm1xXQxa6yslRabVh+a803WPho4Fiq9gnZ8bjvfoUOcE2gQPOig0rNz51
         4vNUUzqUOIotepBmb/oSIYZtrNUssDCSVl9BeVVOgwQq/D8XhBmVJzvk/c4z9Dp+kkTZ
         Av0S4GRwhgWotFINi5j//9eVzI5JVmrplqwLbvXSWZGFZ7cHu3hlGuL6W40RjMphxdo5
         BLVMbkg0XxXElLmOd+9uB39nnSJLVBRoNFEcy7HEfZG00hyx7d9SSwlgy+wlxZNKYO4O
         qBHjFN82YtR0sMb83i5glTMHccwGd/kVhISoKbG4WvYyTIk+1En2pplooFGNYHjqihch
         eEAA==
X-Gm-Message-State: AOAM530R286wNC9rrIJtSBpBlzfcT0icC8dr8PhckYy2p43SoATTJ38S
        P+1gaAwp/FCPWveV9lkqgg==
X-Google-Smtp-Source: ABdhPJySKq5l4R0u6GckGgZImJ9UwaXMIQpwqbIazsIiVgBiSpWJiyT3gmPOL8YgDYkXqu0eYQB4mg==
X-Received: by 2002:a05:6830:43a0:b0:5af:e328:6bc7 with SMTP id s32-20020a05683043a000b005afe3286bc7mr13972568otv.62.1646257177730;
        Wed, 02 Mar 2022 13:39:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1-20020a4aa781000000b0031cf8e00738sm81839oom.1.2022.03.02.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:39:36 -0800 (PST)
Received: (nullmailer pid 100688 invoked by uid 1000);
        Wed, 02 Mar 2022 21:39:35 -0000
Date:   Wed, 2 Mar 2022 15:39:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Robert Marko <robert.marko@sartura.hr>, linus.walleij@linaro.org,
        brgl@bgdev.pl, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, luka.perkov@sartura.hr
Subject: Re: [PATCH v10 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers
 bindings
Message-ID: <Yh/kFzNuvbwA2qeE@robh.at.kernel.org>
References: <20220131133049.77780-1-robert.marko@sartura.hr>
 <20220131133049.77780-6-robert.marko@sartura.hr>
 <Yh8vJNc4D6rA68au@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh8vJNc4D6rA68au@google.com>
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

On Wed, Mar 02, 2022 at 08:47:32AM +0000, Lee Jones wrote:
> On Mon, 31 Jan 2022, Robert Marko wrote:
> 
> > Add binding documents for the Delta TN48M CPLD drivers.
> > 
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> This is missing a DT review.

How about this one[1]?

Rob

[1] https://lore.kernel.org/all/20210719225906.GA2769608@robh.at.kernel.org/
