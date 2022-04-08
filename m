Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF14F9806
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiDHOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiDHOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:30:25 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473E2E0A0;
        Fri,  8 Apr 2022 07:28:16 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id v75so9001740oie.1;
        Fri, 08 Apr 2022 07:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXgCguQ66oOF41SzdSpgngpMaWsUgrrgSYYn8bnZP4w=;
        b=Bl0yeygJnxnGE4NLdc7ZKyoKYRyIcDsisUXziichehaoV8brrXEvEmHpRJ42zak50O
         pbWxy521km44Uis47P/5/oaGtNxIGXa9sBUJchn4sbq9Y+xh5nI2gOAhbK5NhePGcMkB
         Jvj6lFW4I5RNitNfoPlGv7ox7JjJ1gjiE7oyoApQbu6+VM5assmwcUS829igY9xNq2ZR
         BUbueVnC0mWo9hsA85v88hCc6EcaI8CW1LH+vWzskjWqOcEsvESEpQRq3327R0mk6DsC
         IdICPOo4XrRUT23JmcEirWpQR7y4qBNL/KnxC+lTwBwgM/aBqoZJ3YAyvBbUa9JAqv/w
         FE/A==
X-Gm-Message-State: AOAM532futc0OLPG5UNQMzNp0i5HGHIGXJ7jR+hywqipZkSLWgmRR6SH
        SKpeKIGzmnaBP5SNiwAFYWFBPgWnCg==
X-Google-Smtp-Source: ABdhPJxZqAGJzAtPAXsAQAHCDpuhQU+DE+9vx32+m0bAsC0m5cSXZFcsYO2+K2n/Qmmz2ny429LIOw==
X-Received: by 2002:aca:2119:0:b0:2ec:a7ff:c042 with SMTP id 25-20020aca2119000000b002eca7ffc042mr8209366oiz.73.1649428095334;
        Fri, 08 Apr 2022 07:28:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020a056830121300b005cdb11a7b85sm9254050otp.29.2022.04.08.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:28:15 -0700 (PDT)
Received: (nullmailer pid 3435369 invoked by uid 1000);
        Fri, 08 Apr 2022 14:28:14 -0000
Date:   Fri, 8 Apr 2022 09:28:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: thermal: tsens: Add SM6350 compatible
Message-ID: <YlBGfqNex49CgXze@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-6-luca.weiss@fairphone.com>
 <YbpLqwFJI/nfvxd9@robh.at.kernel.org>
 <CJ4TKNHK955X.2YYNAV248UMK8@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CJ4TKNHK955X.2YYNAV248UMK8@otso>
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

On Fri, Apr 08, 2022 at 01:25:26PM +0200, Luca Weiss wrote:
> Hi all,
> 
> On Wed Dec 15, 2021 at 9:10 PM CET, Rob Herring wrote:
> > On Mon, 13 Dec 2021 09:26:06 +0100, Luca Weiss wrote:
> > > Add devicetree compatible for tsens on SM6350 SoC.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> It looks like this patch hasn't been applied yet. Could the responsible
> maintainer please pick it up?

Normally that should be the thermal maintainers, but I've applied this.

Rob
