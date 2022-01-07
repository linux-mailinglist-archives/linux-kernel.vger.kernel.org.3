Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359C24879F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbiAGPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiAGPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:54:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDFC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:54:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u13so16955564lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZO/W9rGLOxOpKaVamlRqS2vqDyG5yS3id6+AvMs5yjg=;
        b=trRMaGODxAyUdqkqVw17H/6Wktal/N4fmj24uECvOEBch+PgmF/YkUDKm8DDCkI/c1
         Vu3txWOgsJuTx3iFPu2sln8SLaYqkaqL2PCMTTd1LfgzmRvfI+evy2P9KswuoYfd7in5
         Pv5kj6AHEfDfvieYAwng/hwjyJxWllp/N/BNSgvRy5Cr5teRXul359Gep5MxACwprHCb
         vl+RaPMQzSJcotC6BPnlHcmsVlYwxfNrYpithBaI1kTS6p+n+zn6vCgJHfjgYWwF24Bw
         3KJozjeFpowjT2oA6JEgtakhSua+Q+k3aonuwi0KGm+RfWs2EVr7xVGzFPRcQllUXZfB
         fyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZO/W9rGLOxOpKaVamlRqS2vqDyG5yS3id6+AvMs5yjg=;
        b=qSW/RqJcgUnjQh6bTNhZRFApbA0gN/z6D+cdPohM30xOcptOJ0AiJJHT2FMqJBUpNL
         LJrUWhyn/PZUf+MHpAT9mkx8zMt4FkegYubw+qVJt1AEn/IWU+b7N3aLgPLeN7rZXyMV
         cq18Zd828F82WonPEhL5mvMNMCqNr0nAx6v6tVeIvaKCKq/gZmgFd6o+6jPmVkWognEW
         7yS9r+3MfGSjpRFTX+wJR0ti2c80o4ih8aJrz47GLkgAAg5m0O0Blv+/lmdIEQZFHafi
         CC8arQptXGepbxCsWBTiJ8KlyTfP98sXVIMKdhVHZEJlgQAo8yWULOaxYME8o/h4wp6Z
         SylA==
X-Gm-Message-State: AOAM532Nc/rvjxQ+v63rUN14+TLIz5wjQDFa/xsR0CKQ/TPgW4Y821ut
        1wdH72l/AI2l/lNPMjlLuw//zd82U7GZK/9Btn1ynP4xAkAXYs4s
X-Google-Smtp-Source: ABdhPJyQeu9mN7kR7KthJ1yYHTKt2DUQkemDvvaMggnz/5gzMvRlBtgUbPtaNUKQGsHMsCuQliyQ9twCV00Ok/bMpqw=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr57521918lfb.233.1641570877566;
 Fri, 07 Jan 2022 07:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org> <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
In-Reply-To: <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 16:54:01 +0100
Message-ID: <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> >> +                              const struct dtpm_node *it, struct dtpm *parent)
> >> +{
> >> +       struct dtpm *dtpm;
> >> +       int i, ret;
> >> +
> >> +       for (i = 0; hierarchy[i].name; i++) {
> >> +
> >> +               if (hierarchy[i].parent != it)
> >> +                       continue;
> >> +
> >> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> >> +               if (!dtpm || IS_ERR(dtpm))
> >> +                       continue;
> >> +
> >> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> >
> > Why do you need to recursively call dtpm_for_each_child() here?
> >
> > Is there a restriction on how the dtpm core code manages adding
> > children/parents?
>
> [ ... ]
>
> The recursive call is needed given the structure of the tree in an array
> in order to connect with the parent.

Right, I believe I understand what you are trying to do here, but I am
not sure if this is the best approach to do this. Maybe it is.

The problem is that we are also allocating memory for a dtpm and we
call dtpm_register() on it in this execution path - and this memory
doesn't get freed up nor unregistered, if any of the later recursive
calls to dtpm_for_each_child() fails.

The point is, it looks like it can get rather messy with the recursive
calls to cope with the error path. Maybe it's easier to store the
allocated dtpms in a list somewhere and use this to also find a
reference of a parent?

Later on, when we may decide to implement "dtpm_destroy_hierarchy()"
(or whatever we would call such interface), you probably need a list
of the allocated dtpms anyway, don't you think?

[...]

Kind regards
Uffe
