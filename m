Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF57948A299
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbiAJWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiAJWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:18:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE9C06173F;
        Mon, 10 Jan 2022 14:18:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so59455560edc.11;
        Mon, 10 Jan 2022 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wuC4QBxAL4gvA6QWC/OGqzBQ+FgoNoq9qXBNAbilkI=;
        b=gZ5zUOlenO/ly7lxX8d963S/GMOXF/nLk7n0jgUAQYWSAm4MrJKvTEoKVOpyYY6MJp
         rl4P8gQiJS17IhwHvT71WS8RbtlCGRn2oyHv1iDxLSARz2tItN6biu6sW4CEl/4F92ae
         tU+0NGvG6M1E2i6hhrcvxAog5jE2suyYwCJJsmbozyynu/Wt3oIfNaEBuIXies72Fznj
         +e4hnU6hGbiwt/5WVpc+iOE016WEi4N+kPqMVYMMBAkb0AgMfaFwn7o770IYAv5tbIUU
         ddV6C+vaIlsMuFUSrXm2ED/PmV5XAIVYkQtnQCovbW7o4yQszXBvqv46+gO9Ock/UBCv
         sBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wuC4QBxAL4gvA6QWC/OGqzBQ+FgoNoq9qXBNAbilkI=;
        b=Qdnug6h5SUmiJIiwgJ3JX8Qby7V9wfIYyL2QSHbKnQM8lgqthI6fSWuR8Q3nLbEDKD
         VNRu18vC6JG7oS9t92foaKT5CStYbIObaKmxVEW2Mj53iriNiZi5BqWITR2iu47hZ6e+
         U/KtWciyBYGBbK+7pjcp7DF4YCI3KMWiDpOrl3j+kXJOd8BK0GStZs/hBEFPS+y5+Mn/
         HHs+rXyxa1lTyf7ff1zhFAzoAIcZBSUDQ7w/nk9FX87Q+yeUaDuPMH/mKfveEaedAnFo
         J7vawOCYy8EeeNttYqOpMwvPwDlv1WOrsfS6IGxF4lbPBD+XRFX+D0WkgluVA1wItwSa
         i1+g==
X-Gm-Message-State: AOAM530gloa/T6jUjf5yJmgVC3sg6vQ1afUvOp9uwL2NGG/Y/attgNRz
        L4WuCktrUqi6AnNnrQZan44Bo0BjG0zPLp7TMyM=
X-Google-Smtp-Source: ABdhPJztnzSCV1UM5hQ3Y8AKb2QMmivElfcK6mKeONxweu0vrWguEgxTqC0RXmTiKv6H2RbGvdC+3F2oZ4GCJf7mt0g=
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr1329857ejk.649.1641853124571;
 Mon, 10 Jan 2022 14:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20220107150512.614423-1-narmstrong@baylibre.com>
 <20220107150512.614423-2-narmstrong@baylibre.com> <CAFBinCDRx6VaaAubr6VRLnX=G4Ez8cGg-=6e-9GWrH8FwwBs-g@mail.gmail.com>
 <fad140b9-2940-a24a-ba70-9849bacf617d@baylibre.com>
In-Reply-To: <fad140b9-2940-a24a-ba70-9849bacf617d@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Jan 2022 23:18:33 +0100
Message-ID: <CAFBinCC7wfPjLGVe87E0H7WYXwrFw0e0k_2epF1dDaWKkSvRyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI
 D-PHY bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jan 10, 2022 at 10:25 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 07/01/2022 23:13, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Fri, Jan 7, 2022 at 4:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > [...]
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - "#phy-cells"
> > I also found a "MIPI DSI PHY clock" and "MIPI DSI PHY interrupt" in
> > the datasheet.
> > I'm no expert on this and I'm just asking in case you have missed one of these:
> > Can you confirm that these belong to some other IP?
>
> Indeed the name is misleading, both go to the DSI Transceiver IP (dw-mipi-dsi)
Thank you for clarifying this!

I just found an old comment from Rob on v2 of this series: [0]
He mentions:
"If this is a child of something else, then put a $ref to this schema
and the example in the parent schema."

To be honest: I completely forgot about that comment until now.
If I had remembered it (and assuming that his comment is still valid)
then I would have had to NACK my own
Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
For today it's already late so I'll look into this more tomorrow.


Best regards,
Martin


[0] https://lore.kernel.org/all/20210210165118.GA2311581@robh.at.kernel.org/
