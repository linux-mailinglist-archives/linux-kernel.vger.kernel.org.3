Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E451929F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiEDAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbiEDAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:16:28 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1912ACF;
        Tue,  3 May 2022 17:12:54 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id m3-20020a4ac683000000b0035f13dde9ccso589853ooq.6;
        Tue, 03 May 2022 17:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NpgcwOXxUIOD9DVencnySKK5YuvmcBy25ONszQmYt3g=;
        b=W5r0UwBdWk2ChgPxWAHrX+eMgKZyW7tItP4QwYhn49lQJa3pmMcf4o263c7pY4/ME3
         ZXWTJ3kh1/E4AHyTApLkrbAun4A4M6A2pXAGkhidm6gFiuY9HBgn6HtKTAJc9OGqIFEK
         2EhHncG1yHPWkGV204AnSgRpTeRCg9+26slTA01pYI5Y9sB+VxhWh/9+WofPsOqgchte
         CBxwkEr3BGYACV7B7lFSnBszVU6mXZz5gX5Dh9BqREg1iLR1Xc71WgNl7lB28+X6fuee
         cS3boRPg5czj26BvHQWoHDRB8FdDHL814bum3AtRRNvSemLUH8jbQz1XiKTgAVJeeCSZ
         y0yA==
X-Gm-Message-State: AOAM531imGKOsX8OymfQOgC/4RsSM8pAzRdp+Hc1ccu1abVjCYZCjnpc
        9FkGEjBFsYdaDM4tizYmx6SXACdmXg==
X-Google-Smtp-Source: ABdhPJyGBo9TWKVr3K3lIp/Txn9XdD6mgw1baqvv55+V+9a5WK6OdIb8Y4bF69xigWn6fvkFAmDQKw==
X-Received: by 2002:a4a:8783:0:b0:324:b9a2:d605 with SMTP id b3-20020a4a8783000000b00324b9a2d605mr6498711ooi.38.1651623173315;
        Tue, 03 May 2022 17:12:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6651000000b006060322127dsm4487354otm.77.2022.05.03.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 17:12:52 -0700 (PDT)
Received: (nullmailer pid 290579 invoked by uid 1000);
        Wed, 04 May 2022 00:12:51 -0000
Date:   Tue, 3 May 2022 19:12:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     icenowy@outlook.com, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: Re: [PATCH 05/12] dt-bindings: clock: sunxi-ng: add bindings for
 R329 CCUs
Message-ID: <YnHFA9NKHYDUuLKW@robh.at.kernel.org>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
 <YnBOY2EjW5ZWCAkx@robh.at.kernel.org>
 <1910544.usQuhbGJ8B@kista>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1910544.usQuhbGJ8B@kista>
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

On Tue, May 03, 2022 at 09:55:08PM +0200, Jernej Škrabec wrote:
> Dne ponedeljek, 02. maj 2022 ob 23:34:27 CEST je Rob Herring napisal(a):
> > On Fri, Apr 22, 2022 at 11:41:08PM +0800, icenowy@outlook.com wrote:
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > > 
> > > R329 has a CPUX CCU and a R-CCU, with all PLLs in R-CCU.
> > > 
> > > Add bindings for them, with R-CCU only taking 3 oscillators as input and
> > > main CCU taking oscillators + PLLs as input.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---

> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/sun50i-r329-ccu.h
> > > @@ -0,0 +1,73 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2021 Sipeed
> > 
> > It's 2022.
> > 
> > > diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-
> bindings/clock/sun50i-r329-r-ccu.h
> > > new file mode 100644
> > > index 000000000000..c327d1a1b602
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > 
> > > diff --git a/include/dt-bindings/reset/sun50i-r329-ccu.h b/include/dt-
> bindings/reset/sun50i-r329-ccu.h
> > > new file mode 100644
> > > index 000000000000..bb704a82443f
> > > --- /dev/null
> > > +++ b/include/dt-bindings/reset/sun50i-r329-ccu.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> > 
> > > diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-
> bindings/reset/sun50i-r329-r-ccu.h
> > > new file mode 100644
> > > index 000000000000..40644f2f21c6
> > > --- /dev/null
> > > +++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> > 
> > Why the different licenses? GPL-2.0 OR BSD-2-Clause is preferred. MIT is 
> > fine if that's what matches the dts files.
> 
> Yes, most, if not all, DT files for Allwinner are dual licensed under GPL2+ and 
> MIT. There are still some files under include/dt-bindings which are dual 
> licensed under GPL2+ and X11, but I believe those files are for older SoCs.

Okay. FWIW, the SPDX definition of X11 means copyrighted by Xorg 
Consortium or something where as MIT is the same license with any other 
copyright.

Rob
