Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBA48E056
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiAMWfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiAMWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:35:46 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DE7C061574;
        Thu, 13 Jan 2022 14:35:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p12so8414610qvj.6;
        Thu, 13 Jan 2022 14:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PP1423VmXCNEpr6x85pDcRINUY1BVKseyYhoEt1br1Y=;
        b=RMGbk/JLSU6kUhB4j9bf0zcTVb7Wv+IRlRPvm3PqqF+O3xNmPXRYKyavDmR+dg43k4
         LzmhqFkSO0vtg6oDKp8PgtPaPVSgxH1LrSvTkMxRu45MNCPDT4EFztdAmPDsEXag03qH
         1Jz6vo0usc22mEUhUqC1T165qYgckKeSkV3TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PP1423VmXCNEpr6x85pDcRINUY1BVKseyYhoEt1br1Y=;
        b=hWtmuTF1f5umtGM5kBfX3odfxK/ZFrR0Ci6jfrSqLsP3wOMy0FgywEp0f30/O/U9OC
         DaKPBnuJoniz0cx8Cr+aOG1+sQxxuf1yqh/Nm+6nJRak3DisbAo/el5fGqLyKbfZQMEl
         gyHkvPorCgjLnUEAnsjL6yjgEetGLlSX1+3XgSKaH5VxuZHW+So2mW4FWnxM3Je4Ul8R
         isHdxlVmMFe4/H/TpwdXjS7OTFR3lWwI7GQ19PWei18bWbJAP1M1oQHphDzaun568NNG
         xk00Se742cfVxzt0t3dwhtEa0XBJ9O43zZJm+n4QP+NmXcV4F5vpNxuMOo6RUx8+oRy4
         Lfxw==
X-Gm-Message-State: AOAM5300synW4JV7RlBv1gytwFZwrp1Yaau+D/sHamYA/b4LVl8IHzFx
        AJrJ7BkINb5nt8eN6i+UW2P0yaILivx011Jks9OpPGExyso=
X-Google-Smtp-Source: ABdhPJwvS5RkVPDYOyFBURNlUniibOApJPDqsNHMVoAteSeZU6gCk2guyywcY3fghdn9aoaUbS7/UAVUrq8+IrhskWw=
X-Received: by 2002:a05:6214:4101:: with SMTP id kc1mr5991043qvb.49.1642113345011;
 Thu, 13 Jan 2022 14:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20220113211735.37861-1-geissonator@yahoo.com>
In-Reply-To: <20220113211735.37861-1-geissonator@yahoo.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 22:35:32 +0000
Message-ID: <CACPK8XfY58odFjf0KNdYXa5MbCg=A07OEfuyjsbnmMtUmxG6ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: rainier: add reset-cause-pinhole
To:     Andrew Geissler <geissonator@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Geissler <geissonator@yahoo.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, 13 Jan 2022 at 21:18, Andrew Geissler <geissonator@gmail.com> wrote:
>
> This GPIO is used on the rainier system to indicate the BMC was reset
> due to a physical pinhole reset.
>
> See the following doc for more information:
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>

I couldn't apply these cleanly to any tree I had. I think you had a
patch to add battery-voltage-read-enable, but that's not in the tree
yet.

I fixed them up to apply.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index cfaa606666e2..7ea70c7d698f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -247,7 +247,8 @@ &gpio0 {
>         /*C0-C7*/       "","","","","","","","",
>         /*D0-D7*/       "","","","","","","","",
>         /*E0-E7*/       "","","","","","","","",
> -       /*F0-F7*/       "","","battery-voltage-read-enable","","","","factory-reset-toggle","",
> +       /*F0-F7*/       "","","battery-voltage-read-enable","reset-cause-pinhole","","",
> +                               "factory-reset-toggle","",
>         /*G0-G7*/       "","","","","","","","",
>         /*H0-H7*/       "","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
>         /*I0-I7*/       "","","","","","","bmc-secure-boot","",
> --
> 2.25.1
>
