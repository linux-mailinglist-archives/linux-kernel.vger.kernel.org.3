Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF750921B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382528AbiDTVdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382508AbiDTVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:33:15 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198D2655A;
        Wed, 20 Apr 2022 14:30:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e189so3530734oia.8;
        Wed, 20 Apr 2022 14:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oKAyPnurUXqIpBjCXwQJqvX5yNXzu0aL/OrfPo6b7fE=;
        b=72ej5YFKxoOpmIPvWoaG4UMsWSl06JuRkoEU2spjYIqa/yRzTdV3NVWIg1e24CBQb4
         Zvq2oMl3eY7r6PWKqz30kXiuDa9rc1TqSJ1yWVpj+DZiSHUY+SpRs30nMg8DWZfd66jO
         PCOTDfqrx2f0H9Vl22c44vmTRyvdboU+ifvWEpw3q9hi533nVp97EYfmxmk+h3/ECF5Q
         DfAqclOBW4ENdFDuZ9A7aJpfOE431mFQOF75CKRryPReo+wSzoAgYDJ2SlYSB9X7s/Pi
         vUOw2UHYMJJnEwTOqZ72ZK8N0KdGHXAc75sTDTffZc07tyFth7HKY81vNNqp6Dgt07KZ
         mMzQ==
X-Gm-Message-State: AOAM530GAJ4vPpWxKy01F0TnEKBGqCy5t2Mckt5zbzaH4tilwq0Ij0SV
        38tG1nAPPEkQZD/1/kOGml2nAUvuIw==
X-Google-Smtp-Source: ABdhPJxq9dTo9U+3/KCPdMhKSiga9fBO1UGN4lQPRboNsT8JQZfOkPOQL2vKXUutOjDSBWzmgyVeRA==
X-Received: by 2002:a05:6808:1691:b0:2f9:4bd7:581e with SMTP id bb17-20020a056808169100b002f94bd7581emr2558521oib.144.1650490225602;
        Wed, 20 Apr 2022 14:30:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pp23-20020a0568709d1700b000e2d876505dsm406800oab.32.2022.04.20.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:30:25 -0700 (PDT)
Received: (nullmailer pid 1882568 invoked by uid 1000);
        Wed, 20 Apr 2022 21:30:24 -0000
Date:   Wed, 20 Apr 2022 16:30:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add missing
 register & interrupt
Message-ID: <YmB7cE0LsyWoiOsh@robh.at.kernel.org>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
 <20220419070302.16502-2-a-bhatia1@ti.com>
 <Yl7FEuHEy66KUc5F@robh.at.kernel.org>
 <f5eb63b1-8381-99c8-55fa-cc9287103aa8@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eb63b1-8381-99c8-55fa-cc9287103aa8@ideasonboard.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:05:34AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 19/04/2022 17:20, Rob Herring wrote:
> > On Tue, Apr 19, 2022 at 12:33:01PM +0530, Aradhya Bhatia wrote:
> > > The DSS IP on the ti-am65x soc supports an additional register space,
> > > named "common1". Further. the IP services a maximum number of 2
> > > interrupts.
> > > 
> > > Add the missing register space "common1" and the additional interrupt.
> > > 
> > > Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> > > ---
> > >   .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > index 5c7d2cbc4aac..102059e9e0d5 100644
> > > --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > @@ -26,6 +26,7 @@ properties:
> > >         Addresses to each DSS memory region described in the SoC's TRM.
> > >       items:
> > >         - description: common DSS register area
> > > +      - description: common1 DSS register area
> > 
> > You've just broken the ABI.
> > 
> > New entries have to go on the end.
> 
> I'm curious, if the 'reg-names' is a required property, as it is here, does
> this still break the ABI?

Yes, the order is part of the ABI.

Sometimes we just give up with multiple optional entries or inherited 
any order allowed, but here there is no reason. Just add 'common1' to 
the end.

Rob
