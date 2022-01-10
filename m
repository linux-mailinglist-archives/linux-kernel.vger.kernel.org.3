Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEB489853
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiAJMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245270AbiAJMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:13:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4EC06173F;
        Mon, 10 Jan 2022 04:13:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r10so18706017wrc.3;
        Mon, 10 Jan 2022 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OOzBzIjFVN6u7BElcoEO6FkXJ9FWYf3IYXCFi7b2xh4=;
        b=PRBS3100yx21XLaSTy7o0vC1OAHBG7s88Sx5bs8uRqBTPNgw9wKhpaORrxP9UiG4Vy
         o2GvOnJc80ag/7xolxsPifxxGPBYThGC0PD1GeSsAAPCuGP7Oku3/33LO7RANN8KsDdX
         nYRUGlsZUBYIcwVjnDnGv25N2CE98M75fx0YpDRt+665QFjhrSM66tM0u1vyBW5/V+ol
         dhz1rUKPcAotMWlQlMgwl/jv6ak+wMEaJ6fh6ZcDjHzTSJ883q/2y3ZH7QJq+ibUZ/Rk
         xdgs0VUmu2sd48T1pW+f2WkzLKGZJMEkAs6Mw6gtw0uZvdsxFRMsnVr25lVl5uvuaVbM
         W5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOzBzIjFVN6u7BElcoEO6FkXJ9FWYf3IYXCFi7b2xh4=;
        b=eKExryc5IzSAtKvNYK1+yp8FKx5ibJh/SGo15r9bs1BxRekJpjkdf3PO4MYCucHvor
         h7gIWD5E2zxwmJSBQ19CjADqIbxc6pwe5FhK3iVVyLXirvC0QWtWF9fLRBsWO6mDVy62
         Y+hl+vskorVT4Zuw4ZoJtp0rt7V5d4ko+412+f/eDGbbMXKaWZZazI5sFWpbJt2vmpHv
         WsasW/wXTfDCH4vqsKhwUV1jMhYh7qpUIyIMIh0WTtLJ7+ijGX2G8LYqRChmyMxpwxa6
         SmkQICjTeJmICeKph18E4vJtWsKTHbPu/WeKX60si2LLvfMxsJ25Pw7mPn2yxYY1FG12
         uzMA==
X-Gm-Message-State: AOAM533CYhCa1rYbM8Xb+Rkb1mrmghMiEbzV5Z3TAmSFhiytcDESltnQ
        yuWuoRu3fau8nlzSUuZuNMyiaJs9iDc=
X-Google-Smtp-Source: ABdhPJxw4SDUrC4jil/wgwV/DimbC98CLJ5B1fXVHcCv3ERHTE4W73PCauhOfIgvvVH1LawPmh5wig==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr2543026wrm.610.1641816790070;
        Mon, 10 Jan 2022 04:13:10 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id d5sm6222633wms.28.2022.01.10.04.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:13:09 -0800 (PST)
Date:   Mon, 10 Jan 2022 13:13:07 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <20220110121307.GA1894@standask-GA-A55M-S2HP>
References: <20220109132311.GA2827@standask-GA-A55M-S2HP>
 <20220110095543.00001ac0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110095543.00001ac0@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:55:43AM +0000, Jonathan Cameron wrote:
> On Sun, 9 Jan 2022 14:23:11 +0100
> Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> 
> > Add vendor prefix for Huawei (https://www.huawei.com/en/)
> 
> Patch description should say why...  Is there an existing binding
> using a huawei vendor prefix?

Not sure about bindings, but there are device trees using the huawei 
vendor prefix. I'm aware of at least these two:
/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts

Similar situation with the other vendor prefix patches I've sent yesterday.

Should I send a v2 with an updated patch description for this and
the other patches?

Thanks,

Stanislav

> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index a13d6a19c2b4..18ffa2d7379f 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -515,6 +515,8 @@ patternProperties:
> >      description: HannStar Display Co.
> >    "^holtek,.*":
> >      description: Holtek Semiconductor, Inc.
> > +  "^huawei,.*":
> > +    description: Huawei Technologies Co., Ltd.
> >    "^hugsun,.*":
> >      description: Shenzhen Hugsun Technology Co. Ltd.
> >    "^hwacom,.*":
> 
