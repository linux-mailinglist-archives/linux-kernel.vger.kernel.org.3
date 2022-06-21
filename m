Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735825537C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353961AbiFUQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbiFUQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:24:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B99513F4A;
        Tue, 21 Jun 2022 09:24:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso10829436pjn.2;
        Tue, 21 Jun 2022 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLDNtNT+J9gfMBCvI90A7ivLG1QZ8VZXqstDqgbYeHk=;
        b=UK0Xap3cY5+46twXdzPzrO/LdSoRuevFS7AZwUiu2q1NRxO8WtFv2FjCkar1IFqeTf
         3EHH+TXgQfiXkbigmEd18pAgHhXas8rlPX6hHS1L3kQzLbVjoRdbGtZD9SPRwb2mNfAC
         Dt5jL+6uBV2jrqBYNRBwb9Z0zyJokF1lstBIa7UlgT65WnnestpoDrEqArK1Xw4YIOp6
         wFcSbIs2Frqm6LNplvb7FV3gu4Aa1Fr9Le5qkKvsV9nuYqax6XOgSU3V/iHfAXsrbito
         qBhFQZsqVi56g5ru72x+o/Jf4eVdJft7E+gC4gfSJKsJveX5ClwD/5wkSQkulXBzu4HW
         psEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLDNtNT+J9gfMBCvI90A7ivLG1QZ8VZXqstDqgbYeHk=;
        b=ZMdrhUyFFF5lYpqz/NYhSPSH/0DL1y9E00c+oqmZb4xK+r/EQYk4fJfiKjA8+3/joK
         GD7+yJ1nOX1/k+D3fwXrJUVz/ZQQ1ja0N7gBuV4bZw6oqapernbcFwUwc8g3PAB+xH8A
         5wvq7jTOrim3D/XOH/iSTWpUKXu1uo7CbBi3IAt8Qp3iRtC+2FrIt9KC+BcKGRepeyux
         5YJoUNHrxch48rm/UWeYH5Ib7gNTjtvibnWwmJPJeoQK6i7mXMlhCuSgQrNI3xFiV51Q
         IJpz7bSgyc4elIiQcwCvFmbovOac8QXRfH0LUCJIUI6c5g9UKb1ZWs6epPmJlPhu6eUG
         BF1A==
X-Gm-Message-State: AJIora91/OFMzwXqow1xwvbx8Pd9bpWLEpnGm+zd6FShBzn0WpeCZJdy
        zdw33rJkhmpzbJlwpnGKeNjFM5ofbgrdwuDNfHv5K2cIb3xuWw==
X-Google-Smtp-Source: AGRyM1vAjrriSVLYQ85GFWzg8gsZgtZA8y3LyzNwk17+JSMGIbjkvo0DPxietELcbRenc+2ksxD8xQDBvc3btNJz3cE=
X-Received: by 2002:a17:902:d2c9:b0:167:1195:3a41 with SMTP id
 n9-20020a170902d2c900b0016711953a41mr30322987plc.126.1655828642768; Tue, 21
 Jun 2022 09:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5D7z=Eg=WYgzrpqn9VoU8HxMeBbEZiv9KLjMVD1_kRo+w@mail.gmail.com>
 <20200701224145.GA3616172@bjorn-Precision-5520> <YrHPA+TBKZU/RuSz@smile.fi.intel.com>
 <87o7ym2fcv.wl-maz@kernel.org>
In-Reply-To: <87o7ym2fcv.wl-maz@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Jun 2022 13:23:50 -0300
Message-ID: <CAOMZO5B6606rwWoG-ydEz2UQpnj9QhUK2b5dCHRtp9u=Pe4new@mail.gmail.com>
Subject: Re: mxs_lradc_ts: Warning due to "0 is an invalid IRQ number"
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Jun 21, 2022 at 12:41 PM Marc Zyngier <maz@kernel.org> wrote:

> Something like the hack below could potentially make things less
> broken, but I'm not holding my breath. If nobody cares, let's remove
> the code altogether.

With your patch applied, the warning is gone, thanks.

The touchscreen is registered:

[    8.207461] input: mxs-lradc-ts as
/devices/soc0/80000000.apb/80040000.apbx/80050000.lradc/mxs-lradc-ts/input/input0

but when I run  "cat /dev/input/event0" and touch the screen, no irq
event is generated.

Looking at cat /proc/interrupts shows that no mxs-lradc-touchscreen
irq happened:

216:          0         -  10 Edge      mxs-lradc-touchscreen

Thanks
