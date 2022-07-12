Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E957229E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiGLS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGLS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:28:35 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EDAC3A;
        Tue, 12 Jul 2022 11:28:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id k1so5374905ilu.1;
        Tue, 12 Jul 2022 11:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6W8B6L9eDM4m8/MJ0avbA+DgywTO7XdB8xPvfv0PlGg=;
        b=1wbdy2i8SlMUxxaqW+Y+8EUofUwOygMa/V8td+FfunEA0+eaheWADD4YuDkEMZB02J
         8CYyLE68aWyEAHpZc1cRjwju6jbtmbYZ9nTGz52hE70ItdssARk3G9sZE1wP/h1qZrp7
         8497cNBh0uxmwCNl50I9crma197EVLIrKJ6wT5YwHQDo1ez4bQGVS4PSUIX/lqxeA7ng
         eOMKTRTsOtD5NAtprk0TrUP0uxT/jR+FRGfSrk00Z9wAbvjQqSzE5iQySVTUP+rZALuy
         VxWcNa0yPBRIBFZuGMCeJAl0vjRbgDdkZnvkCDEbValVA904X5Y3GF80I/bT9F0UHx52
         /6vQ==
X-Gm-Message-State: AJIora90/Gww1wAWGI23I9qpMFFcgLLumrgRKdWQ2l2kq66XJ9H0y9GE
        t0HQpxtxmKEmmrj2HMi2wxTB+Jim4g==
X-Google-Smtp-Source: AGRyM1tqayz6OkehiOObvstt1flcNF/02sFSRVCz/33Rytko2Q7ZxfWFu+sRlacCZZQZ5KGAvFw0Yw==
X-Received: by 2002:a92:c242:0:b0:2dc:2df2:a3d1 with SMTP id k2-20020a92c242000000b002dc2df2a3d1mr13172826ilo.111.1657650513726;
        Tue, 12 Jul 2022 11:28:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o17-20020a92d4d1000000b002dbee570531sm3992059ilm.18.2022.07.12.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:28:33 -0700 (PDT)
Received: (nullmailer pid 2143588 invoked by uid 1000);
        Tue, 12 Jul 2022 18:28:32 -0000
Date:   Tue, 12 Jul 2022 12:28:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kabel@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Message-ID: <20220712182832.GJ1823936-robh@kernel.org>
References: <20220705001023.14660-1-pali@kernel.org>
 <20220706150726.GA40600-robh@kernel.org>
 <20220707122730.45jtopop5cj7beni@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707122730.45jtopop5cj7beni@pali>
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

On Thu, Jul 07, 2022 at 02:27:30PM +0200, Pali Rohár wrote:
> On Wednesday 06 July 2022 09:07:26 Rob Herring wrote:
> > On Tue, Jul 05, 2022 at 02:10:22AM +0200, Pali Rohár wrote:
> > > GPIO is optional and used for WDI logic.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > > Changes in v3:
> > > * Extend description
> > > ---
> > >  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > index ab9641e845db..a0cf9e6c371d 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > @@ -27,6 +27,10 @@ properties:
> > >      description: This is a 1-byte memory-mapped address
> > >      maxItems: 1
> > >  
> > > +  gpios:
> > 
> > As I said before, add a name prefix: wdi-gpios
> 
> So gpio with output direction should be really named that is input?

Names are based on the pins they connect to, so yes. The flags cell will 
make it clear it is a GPIO output.

> I really do not understand this kind of thinking and making every device
> tree description totally illogical and inconsistent with all other.

I don't understand what you mean.

When there is a 2nd GPIO used for this binding, what do we call it? 
'gpios' doesn't scale.

> > > +    description: Optional GPIO used for controlling WDI (watchdog input) when WDI bit is not mapped to memory

Look at it this way, why do I have to find and read the description here 
to know what 'gpios' is for when instead, it can be self-describing when 
I look at the datasheet and the DT to see this is the GPIO connection 
to WDI signal.

Rob
