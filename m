Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885DF4AEDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiBIJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:17:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBIJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:17:51 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632BC0DE7E0;
        Wed,  9 Feb 2022 01:17:43 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JtvRG3HCWz9sq8;
        Wed,  9 Feb 2022 10:17:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644398248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0oOnGnZNW4E43AWDbU3YQ3rIFI9kV+U/+S0E/9n4M8=;
        b=nH3ARItDa0KrY1Mq9FasHYsBBwiTdmGysdfN3UHtvWsPXXBSvuDo0U+lrsBvYhZHw5fqns
        Nmnz90GqtyTzJipRnAkOky434kf6pXQseaXCp9oGwqRW8LGKIcZaEqDtr8l/ZHG5+o0jw1
        /KrT3s7UNcBwo9w3nZ2AeSVMaKSUo5Vj2FIw1dzzhpd2Ix5FQnwbgfbHB66YE8WvaECObn
        9uaF/TCpgtjIDp+tJGnZ8GIxRJResMHFydT89AftNz8dppSLSpz+b8ene2RDPtnBDdOgqi
        I9Va0fBE13s1plv6SPZisVj+rVvZcLCyFDKsvlf5vYRbh7WBJ2GlsmYNz1s70Q==
Message-ID: <45823dddd3cf4a93a640b646026a89d1b7fed7f3.camel@sylv.io>
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add Vicor
 Corporation
From:   sylv <sylv@sylv.io>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Feb 2022 10:17:24 +0100
In-Reply-To: <YgMr84b8BKHBNQwq@robh.at.kernel.org>
References: <cover.1642434222.git.sylv@sylv.io>
         <58d2c7501edf746f3677681327c283fc3faaf872.1642434222.git.sylv@sylv.io>
         <YgMr84b8BKHBNQwq@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:50 -0600, Rob Herring wrote:
> On Mon, Jan 17, 2022 at 05:12:47PM +0100, Marcello Sylvester Bauer
> wrote:
> > Add vendor prefix for Vicor Corporation.
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 66d6432fd781..8a2a205d6d34 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1273,6 +1273,8 @@ patternProperties:
> >    "^vdl,.*":
> >      description: Van der Laan b.v.
> >    "^via,.*":
> > +    description: Vicor Corporation
> 
> You just changed the description for VIA.

Indeed. My bad.

> 
> > +  "^vicor,.*":
> >      description: VIA Technologies, Inc.
> >    "^videostrong,.*":
> >      description: Videostrong Technology Co., Ltd.
> > -- 
> > 2.33.1
> > 
> > 

