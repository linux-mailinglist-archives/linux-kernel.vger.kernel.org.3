Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC01492BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiARRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiARRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:06:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D261C061574;
        Tue, 18 Jan 2022 09:06:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j2so884343edj.8;
        Tue, 18 Jan 2022 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+4KTXN2MyPk5h2NaJWjBVuUnjRXsreM7Vqs8LDWdrI=;
        b=pAn+jxyEYSHJdfcoa2E2EcGtseKd1LUSIEE+bIVTWa55oeQ7D1Hw/OGSuWFoAjdI1e
         KQAVVue4LWWIKuYADHF111mi25qZTlscNogoazDmexf/4sFpQtCqY5mtARGMRqSv4iIr
         OxPmaUQST1fcuxNbAqcgJ2v1rFGV+exgWuy0QrLnsbnwZzwmXWrrFsrvk+Rb+QAuKJx/
         Z3qT/SI0RTIOJ1bTUfBAYGKQe8gpPwS+1uvfnvW3jOlMllk197RS57tw0osZl/qFkCB3
         zz82C0Wt7+MfqD4c3Szcjng9Qvto6yGoXkjsx+r5I0Y+rCTKFZi6EAemqMf808HQsP11
         QPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+4KTXN2MyPk5h2NaJWjBVuUnjRXsreM7Vqs8LDWdrI=;
        b=0hWslPAu4QBm5zo0rrwwuxhFprGcX6WzGc9ZYjaykn3uCzFyfMFbkpavGG/omFseRV
         O4a1Y9YKKNAjDjzxs056qTxI06pd3N95rvrgvHC5iGCRhGtiHdVgfo5/AfL7iTZqqeOU
         sQWCTG1ipD50BfjV0UQ15PxFfOqLZQoWryiya3RIc7Rp6pW+oZO24vMbHJKZjLp+8Y5X
         4HqsejWxVXIxJxV3CMdzUS/UdJz9MpMFZJbKGjeQ3QENzzbtH/+3B6GfB+uiejYaj7Re
         Z6KQbbD/Bl80C7oYGcrVldIDrzo1uny8Q5AzPpyaWsO3X31qEkimU2+IsPM7gyE0vMOl
         leFA==
X-Gm-Message-State: AOAM531EqjMsUXapnCbKAqfCRtoK3zZv+mtiF9NNXsDlK8L7gyYACNDx
        wLOkwl5xzBhTBAnfB3lWWS1Nu86T5D1TyOiD7QLLsI2Qbv7E4w==
X-Google-Smtp-Source: ABdhPJz9ajbfoxq27WakO0O+HLS9Uvs5z/U9yrSCS73qihJQQf0dxS+tGGfLSrBrJF9UbJ4U5KfTGp3lY0K4QicV2VY=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr3262885ejo.636.1642525617578;
 Tue, 18 Jan 2022 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20220111115919.14645-1-cristian.pop@analog.com>
 <20220111115919.14645-2-cristian.pop@analog.com> <20220116115228.1f7b4728@jic23-huawei>
In-Reply-To: <20220116115228.1f7b4728@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jan 2022 19:06:20 +0200
Message-ID: <CAHp75VeakSDtDfGO1tcZKgoJ0KTAHgYMKG1v=cYDSHoc-zLUbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit ADC-DAC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 8:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 11 Jan 2022 13:59:19 +0200
> Cristian Pop <cristian.pop@analog.com> wrote:

> > +     st->labels = devm_kzalloc(device, sizeof(*st->labels) * child_num, GFP_KERNEL);
> > +     if (!st->labels)
> > +             return -ENOMEM;
> > +
> > +     i = child_num;
> > +     fwnode_for_each_child_node(fwnode, child) {
> > +             if (fwnode_property_read_u32(child, "reg", &crt_ch))
> > +                     continue;
> > +
> > +             if (crt_ch >= num_channels)
> > +                     continue;
> > +
> > +             if (fwnode_property_read_string(child, "label", &label))
> > +                     continue;
> > +
> > +             chan = &channels[crt_ch];
> ? Not used.
>
> > +             st->labels[--i] = label;

> I've no idea how this works...  Should be looking for the chan->channel
> value as that's what your read uses to index.

It's an implicit memcpy().

> > +     }
> > +
> > +     return 0;
> > +}



-- 
With Best Regards,
Andy Shevchenko
