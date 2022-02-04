Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3ED4A9FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiBDT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBDT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:26:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31BC061714;
        Fri,  4 Feb 2022 11:26:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k25so22043171ejp.5;
        Fri, 04 Feb 2022 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAQgvbZbf+Jfe1NVQF7RjZIKqkwocaNR3cyKrpFomR4=;
        b=owghA3Xndpxd94nD/h6IzdWdp0xrg1RVr+Zha1xgMLjA9Ph84hd/n2QKTNu1MmaXwY
         HVkKsCkGp60Fol3RO/0l690OrxtuvszvVxoiVX7DIM+vJAzQlGnGPndZV78Eq7zgNKyw
         o4tNDdNlIJzb9PJ/+hCSv9XMapRlPiHjO5yx1SKmHNSLVTjQOKP3GnSqkLFjTc3PRzvD
         QCxzmeMobuUAewI6iNZttTzFcF65BbcpIZ3l50SYInjdTeMXkifcJB0dW3PtlfZ5HC1t
         bmO1xdWYLbZDd4XE/Cb2qe8RnN8zx6kJNfBEB89fAddWv0/liji2kb2vkc/mGR1OIoXP
         1hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAQgvbZbf+Jfe1NVQF7RjZIKqkwocaNR3cyKrpFomR4=;
        b=3fV0LD9vKnS0+PGuw+3h3+kqubSxLIovlmMupZD7dIyNc41F38tx/7s69a7uwlaQJ9
         EbmV6cds98NrIKWLlAEkUilsp+74yb8tzrIBUDIGVZZvVM7TX0pC8COuqYPlB4ebGKGr
         C9HJA8q0AaBr9gJ9aLL9fGiY+JPLfYz/ugyYy41YRN4OGgMmGONIvD0zOc1ieuBJCFQC
         D/58p8NY+7yPf36VfPCfWiQcOT/gRZQrCc+72LNb0Km1FoyNWHLhS6H3CbwZGuA/lgD1
         T4W1YNVwZBrf5vGeDOpbXPO2DZoT0IszwFlUNRBReboAXu4+XNnVf52UsB/Rn4e0uuXP
         ohdw==
X-Gm-Message-State: AOAM531UPtWTn9U69bCadFyrYEqq91yH4Ea6zYYHJeamKTUzadgqUfD7
        npDtENu7ls5QkKSeOgObbCDzN3ZWN7MAejDaazDwoe2z7i0=
X-Google-Smtp-Source: ABdhPJycWwkrN9pRI1l8a4JkOF7Pd2UBIsMZmMJz06bpanLSRDjpU0LssTFChDe6TekuDdGU1tMD98Brd8Knw+/S0rI=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr387025ejc.132.1644002759637;
 Fri, 04 Feb 2022 11:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-6-sean.anderson@seco.com> <CAHp75Vc--RYW7P0wLA8Jcr53xKSkphJV=wTeZiPC-AYu4sGYFA@mail.gmail.com>
 <2c1832a5-1e13-1423-2be8-e31b5ec5195a@seco.com> <CAHp75VfGFNFqOU0BymNwh_FWKVw+rSyJJRDSKOinWY_Z39qaGA@mail.gmail.com>
 <928f7c83-281c-b995-1bf5-be35b7539de6@seco.com>
In-Reply-To: <928f7c83-281c-b995-1bf5-be35b7539de6@seco.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Feb 2022 21:24:25 +0200
Message-ID: <CAHp75VeDs6f7euqsZ2fmD42V2M6eWf1_CQPXyr-GfF0HVWA+Vg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 8:44 PM Sean Anderson <sean.anderson@seco.com> wrote:
> On 2/4/22 1:38 PM, Andy Shevchenko wrote:
> > On Fri, Feb 4, 2022 at 6:00 PM Sean Anderson <sean.anderson@seco.com> wrote:
> >> On 2/4/22 7:54 AM, Andy Shevchenko wrote:
> >> > On Thursday, January 27, 2022, Sean Anderson <sean.anderson@seco.com <mailto:sean.anderson@seco.com>> wrote:

...

> > In order to have more or less unified APIs in the future I would
> > suggest using 'clock-frequency' for the "main" functional clock. For
> > example, 8250_dw uses it for the baud rate generator, while it also
> > utilizes auxiliary clock(s) on some platforms.
>
> OK, I had a look though that driver, and it seems like it uses
> clock-frequency only for the baudclk, and e.g. apb_pclk has no
> corresponding frequency property. For this driver, it would mean that
> the suspend clock would only be configurable through device tree. Is
> that the approach you recommend?


What I meant is to use the "clock-frequency" property as it is kinda
standard de facto for the "main'' functional clock. The rest is up to
the individual drivers. From the API perspective I would expect a
common helper in the future that takes clock name and returns rate
based on clock (if found) or "clock-frequency" property. We may also
extend in far future to support any combinations of the [clock name,
property name] to get a clock rated either via Device Tree or via
ACPI.

-- 
With Best Regards,
Andy Shevchenko
