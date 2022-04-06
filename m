Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075764F66D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiDFRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiDFRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:17:35 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FE41C8AE;
        Wed,  6 Apr 2022 08:13:30 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j83so2689353oih.6;
        Wed, 06 Apr 2022 08:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6cKGjj+bqATtNpTiy+UlEgdvGT8QgL8VDcWJrcBl4k=;
        b=zJOdLf7T4U7OHA5mLQGS1P+UVpv3Lf/ZhzWuFJvjmw3bIxz//Fk4FzBr88MUANMUmY
         /QIQZDfsllNZ4H9+15SXOgUkoMMdDMNzNWD52vq4Pwq37AQFkhlO3dX2/pyCuyeaT3QK
         d28hVxoSfJlS1AEW53mm8GCMcdcHEo9g/6bdrAQG2TwzN1/+jz5g2flXdTEiU2VjcyhE
         W7K2POwJ70NgUcuTsonBFnu8SG2Dd9ncnhsJlZgQUHapwFSIQPNSW/hDofQyZreyZc41
         e//Duln2MbRYdZhroSK+WXrAZSTiNSibuO5tJJv3gcUmEwBR1VM9wVQPL6rpyyzw7eSe
         Ql1w==
X-Gm-Message-State: AOAM532A2RLd3lR8iUbj1IPwPZvOoFTjc0x6/hDFr0tYR6hnHwCHP6Rr
        /WR8vX4YOeode1vnEOl/ZjhUJa2iVQ==
X-Google-Smtp-Source: ABdhPJzTV0ESMpCaV6HUnB9QYxaeKpG6lZgJ2cIo7TZ1nk/oy0qcu/j100Dfwf7uqRdaOHp1htJHHw==
X-Received: by 2002:a05:6808:e86:b0:2f7:5228:5e52 with SMTP id k6-20020a0568080e8600b002f752285e52mr3945666oil.70.1649258009629;
        Wed, 06 Apr 2022 08:13:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0da9000000b005cb437ac0e2sm7036730ots.44.2022.04.06.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:13:29 -0700 (PDT)
Received: (nullmailer pid 2260364 invoked by uid 1000);
        Wed, 06 Apr 2022 15:13:28 -0000
Date:   Wed, 6 Apr 2022 10:13:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, shruthi.sanil@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v10 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <Yk2uGHsu49/seLMT@robh.at.kernel.org>
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
 <20220322130005.16045-2-shruthi.sanil@intel.com>
 <7e711327-bcb8-4c7f-5537-425ba1a79e62@linaro.org>
 <71e82477-16fb-2e7a-e5a9-e22327f31e77@kernel.org>
 <3d74d7e2-1f52-11d8-e458-b7074bc4c070@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d74d7e2-1f52-11d8-e458-b7074bc4c070@linaro.org>
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

On Wed, Apr 06, 2022 at 10:06:00AM +0200, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> On 30/03/2022 13:55, Krzysztof Kozlowski wrote:
> > On 30/03/2022 13:44, Daniel Lezcano wrote:
> > > On 22/03/2022 14:00, shruthi.sanil@intel.com wrote:
> > > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > > > 
> > > > Add Device Tree bindings for the Timer IP, which can be used as
> > > > clocksource and clockevent device in the Intel Keem Bay SoC.
> > > > 
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > > 
> > > 
> > > In order to pick this binding I need an ack from Rob or Krzysztof (added
> > > to the recipients)
> > 
> > Rob was looking into this and there were some comments around v8, so I
> > will leave it to him.
> 
> whenever possible could you review this patch, so I can merge the series
> which has been a long on the mailing list ?

I did... Multiple times.

I don't see any need for 1 node per counter. I don't find 'it might be 
synthesized with a different number of counters' a convincing argument.

Rob

