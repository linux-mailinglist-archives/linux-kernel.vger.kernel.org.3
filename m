Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7298592671
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiHNVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHNVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:01:11 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB02108E;
        Sun, 14 Aug 2022 14:01:10 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-10cf9f5b500so6459355fac.2;
        Sun, 14 Aug 2022 14:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iuKZ+J3/DBkephGowobWrfjfbh+M+qEWFBtWjffj1JE=;
        b=fClx4KvBsEiA0/MuZ5NL/Rn6J8fXwL2e1Pb06DvV4HtOQZ5Rc0i4aD15Xh8WAM4hkw
         LqcGlHUxVZ6SmxO5I/deBv0AcUJ1/Sa61+QekMJt/bkOL9tKHD08xnhovKpL3M3AQanB
         dMeXIP8NIc/ijFk7npaw3pCBhLvbQ9z8BwEJW/sOXu3jzG/szY6qqB0suZgy9Msiw7MN
         WCgZYDdXi3dSw8H1YDtzzQSDHoPlQ/Tqj2tY/4uHmOelwfTB4oWQYQtAqDOliPCsRg1C
         HLFuot5hdcUNUaLEEm5wnsEcOXF19zUwjWT6VPqH7xmpjuBuGwzk3eScNrARURkuhuW4
         9/iQ==
X-Gm-Message-State: ACgBeo3CSK+k6ZRjeYIn6Cr6jAwkChyyl1CDzgulzS8NrPL4Zp5Mu9Lh
        kvmV31p/hHelxvp+lm9MhA==
X-Google-Smtp-Source: AA6agR4y2J309doUMXH2NNHSX11zssUgXFnaZYxlqHRcotR0+jDLkmtl8lq9M0qY2TnUnp6qUwSHOQ==
X-Received: by 2002:a05:6870:970a:b0:10f:1162:cdeb with SMTP id n10-20020a056870970a00b0010f1162cdebmr9352536oaq.111.1660510868981;
        Sun, 14 Aug 2022 14:01:08 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id s7-20020a4ae487000000b0044584998c9asm1465054oov.38.2022.08.14.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 14:01:07 -0700 (PDT)
Received: (nullmailer pid 702123 invoked by uid 1000);
        Sun, 14 Aug 2022 21:01:04 -0000
Date:   Sun, 14 Aug 2022 15:01:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20220814210104.GA690892-robh@kernel.org>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
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

On Thu, Aug 11, 2022 at 12:14:48PM +0300, Krzysztof Kozlowski wrote:
> On 10/08/2022 23:47, Bjorn Andersson wrote:
> > Introduce a binding for GPIO-based mux hardware used for connecting,
> > disconnecting and switching orientation of the SBU lines in USB Type-C
> > applications.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > new file mode 100644
> > index 000000000000..7d8aca40c7ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: GPIO-based SBU mux
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description:
> > +  In USB Type-C applications the SBU lines needs to be connected, disconnected
> > +  and swapped depending on the altmode and orientation. This binding describes
> > +  a family of hardware which perform this based on GPIO controls.
> 
> +Cc few folks.
> 
> This looks familiar to:
> 
> https://lore.kernel.org/linux-devicetree/eaf2fda8-0cd6-b518-10cb-4e21b5f8c909@linaro.org/T/#m39254b7f8970b3e1264f9d1a979557bb46ab162c
> 
> Rob and Stephen had several concerns about that approach.

My overall concern is a bunch of one-off bindings with no one thinking 
about a variety of USB-C h/w. I need h/w diagrams and corresponding 
bindings. The key part being more than 1. I'm not all that familiar with 
the former to help on the bindings.

Rob
