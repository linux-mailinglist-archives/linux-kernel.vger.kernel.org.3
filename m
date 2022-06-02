Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180153BBD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiFBPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiFBPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:50:14 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D62E09B;
        Thu,  2 Jun 2022 08:50:12 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id k11so6966781oia.12;
        Thu, 02 Jun 2022 08:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4M65yO1MSPMaaEDxpgxAeSakHO4GbEVK8l/HDI7ey7E=;
        b=iGmzDqhtpsxMzxm22qQgnkRIBwk6TSQ+as4aB4Fnqk3F9hlmPE3g1BI7PGi4QpiIKP
         PBZ73wi9zmxkjL7w+q6r+HeSOrxTig2Ex5qTsNk+yFY2nhlCGlC0eFApAMnzyU4TkuNx
         C+ZIyqmUcfpxjogeNEjE2FP808P2WFkNltT9Ecnqh0JpAn/j5tyRWmzKRouGaELG1hbj
         0JtOBEP3hhsBKwhXw3qgNrQg6rcfO0T8lA2aR7nA/SkA1C9LuKmLaeRjgSdC+85M4K9/
         agGVdiblLongl+GofVWfGAhQyCieMh3FJcsUOTX0mNTLMBZaeiLuPPBcY5zU+NQjUJ1i
         JmKw==
X-Gm-Message-State: AOAM532zbcAqTILS8HI4m6C8e5wE5xCvZNTMl4WEhTjehrDmXjLxY6Aj
        DLeczHowGONZD4R+hEMYUA==
X-Google-Smtp-Source: ABdhPJweeB9Qgg0inliBye4ZwpAwslfzL2dtqBXMZ5lTOF4/7QDMtbhTUga29CdeEcyJUYzgbdCydQ==
X-Received: by 2002:a05:6808:1646:b0:328:ffdf:6821 with SMTP id az6-20020a056808164600b00328ffdf6821mr3065177oib.115.1654185011996;
        Thu, 02 Jun 2022 08:50:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lq10-20020a0568708dca00b000e90544b79fsm2100598oab.41.2022.06.02.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:50:11 -0700 (PDT)
Received: (nullmailer pid 2398310 invoked by uid 1000);
        Thu, 02 Jun 2022 15:50:10 -0000
Date:   Thu, 2 Jun 2022 10:50:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Message-ID: <20220602155010.GA2349024-robh@kernel.org>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-2-ddrokosov@sberdevices.ru>
 <20220602135015.GA2186715-robh@kernel.org>
 <20220602135934.f4exakny4rbrdboy@CAB-WSD-L081021.sigma.sbrf.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602135934.f4exakny4rbrdboy@CAB-WSD-L081021.sigma.sbrf.ru>
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

On Thu, Jun 02, 2022 at 01:59:18PM +0000, Dmitry Rokosov wrote:
> Rob,
> 
> Thank you for the Ack. I'm going to send v3 patch series and don't
> understand, should I append Acked-by line to v3 version of vendor-prefix
> patch... Please suggest me if possible.

Yes. When you send another version, add any acks unless there are 
significant changes that warrant not adding them. You don't need to send 
another version just to add acks. The maintainer will add any given on 
the current version.

Rob

> 
> On Thu, Jun 02, 2022 at 08:50:15AM -0500, Rob Herring wrote:
> > On Wed, 25 May 2022 18:15:30 +0000, Dmitry Rokosov wrote:
> > > MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
> > > electromechanical system technology company which produces micro
> > > electromechanical system microphones and sensors.
> > > MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
> > > in consumer electronics, industrial control, medical electronics
> > > and automotive, and other fields.
> > > 
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> -- 
> Thank you,
> Dmitry
