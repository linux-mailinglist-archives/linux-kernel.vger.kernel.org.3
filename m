Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0CE49FA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiA1NRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbiA1NRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:17:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBFDC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:17:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e2so10886036wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRE6cP7pvi+ZI23Vg5Fh1CMwZmc7C8MWpMozO16RBzU=;
        b=8KM029J1OvRaJgPHOipEGOIcRfssg6B2NfpFNu8YWmSFDgkd9wWf+IJ66xVDuR43n3
         2+D8zdvVWoQ82hebXyvz6dirPC7Ek+lXA1x+TlEfAyd6br1C0uwLt1e98xEzEGvyT0fY
         8JTK9LEH9iYiJvTjwAAeNgHzm3M5OKfLZ8gcDzbf4wKVnixs82hUZiBRDTB290dvE7sO
         541MWF+TQExtk9I6p9OjDMGaI4wtmR+HmrGLEI+kq46EU/6Ab3QlK2EJZGdaKwtE7uZE
         KneFJaj7Rh1Ep3zxWxGtuRQ6lXtfDjOIEai6LlotHYT8H8yrtJV5iIH5hCNKlvFtusdT
         9CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRE6cP7pvi+ZI23Vg5Fh1CMwZmc7C8MWpMozO16RBzU=;
        b=yRk3ex2sb4E7JqP1M+v+0Wu5sxuNShzwFhVAjL+8gM7pC00aMpb9QWCXLf30k8twIU
         tjZwMnsa0nGwVzsvM176p7ER8GShScxU/iPU/XXVF93rTRYH8ED2QLriFcMljCAVJqnl
         IV/43nrIO/3F1yScPwOSSwvYVjgdamWLQq48YgZwcY+67ai5DqH39XcYB6Vt4duGALel
         GxUVFsY/bwM368qMxCe6WzYqXdznFI+4oHGCfMv0lsZHm6TZtha2mdSliULNwgCBidB/
         fvkAilfmMJpWV7CVtqNm7cpmVAEzcGYIMFlZWYQgBgwBcAbPZetbwTXXxl/VMOI1lcud
         TRsA==
X-Gm-Message-State: AOAM533qXDrMTTpz5kEIVYSVNqKarD4NdKqzseNjRcblIIupG3gw/aiM
        9avMjiBT5HdL3YRjO2U1qlNJ6PtKHtp+BBLt5UTFYcVW2G8=
X-Google-Smtp-Source: ABdhPJx0eAbfLbLIvSsOEMT0A5qjXLBP5J080JzYr7ucrMaAqfFeIyIpQaz8SMiXg4gtlqNBVlVuQi8VmjgUIugP5jw=
X-Received: by 2002:a05:6000:1e0a:: with SMTP id bj10mr7007651wrb.313.1643375837116;
 Fri, 28 Jan 2022 05:17:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643360652.git.geert@linux-m68k.org> <62bf4ee6613550c07a99d4bd226ab0d33acae4c4.1643360652.git.geert@linux-m68k.org>
In-Reply-To: <62bf4ee6613550c07a99d4bd226ab0d33acae4c4.1643360652.git.geert@linux-m68k.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Jan 2022 18:47:06 +0530
Message-ID: <CAAhSdy139fUCYdTm=Ge4GhXt2WxnV3ngGHY2RVie4+k1yQnEKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: timer: sifive, clint: Group interrupt tuples
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> v4:
>   - Add Reviewed-by (this time for real ;-),
>
> v3:
>   - Add Reviewed-by,
>
> v2:
>   - Split in two patches.
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index fe4b73c3f269fc0f..e64f46339079fa3f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -57,10 +57,10 @@ examples:
>    - |
>      timer@2000000 {
>        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
> -      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> -                             &cpu2intc 3 &cpu2intc 7
> -                             &cpu3intc 3 &cpu3intc 7
> -                             &cpu4intc 3 &cpu4intc 7>;
> +      interrupts-extended = <&cpu1intc 3>, <&cpu1intc 7>,
> +                            <&cpu2intc 3>, <&cpu2intc 7>,
> +                            <&cpu3intc 3>, <&cpu3intc 7>,
> +                            <&cpu4intc 3>, <&cpu4intc 7>;
>         reg = <0x2000000 0x10000>;
>      };
>  ...
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
