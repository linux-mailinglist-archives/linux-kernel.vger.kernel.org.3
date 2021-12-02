Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E845E466BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377138AbhLBVpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349087AbhLBVpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:45:33 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EBC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:42:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x131so831268pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=z0U7sXMXxzMUq0YKyxwQpm+mPxbKf8cT9s5Pmci6eQY=;
        b=ZuspXtWGVJDGGe9JWYuxvvDTFWIFkBZiIM39a98ZoP3vxlhoP6X2BpPBaImkSLc67j
         1Hfaerxw3P4CtaQ+crg4U75T8v8t6D5tIsq0LN1JS/bxcd1yBud5o8j718phmq3ramjy
         qYp7YDWyH7m09TrMZC9HgXwfXAevv6rUZSEYViHT9mgjmEXbLAM0ErNVsDO45fixVyu9
         uVpubcc3YDbQuzgTY0Ajg8oCQmLWcU93AVUknSK1v/QUzPAJ/1iNuBqi6fGP9MSl6vky
         2/k0whPWWFSJZ92b4YUwv7kp0mvd2/INHhLTjRq8wLsIC98om92Y1eW95VF57Vg8cCsK
         VP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=z0U7sXMXxzMUq0YKyxwQpm+mPxbKf8cT9s5Pmci6eQY=;
        b=yVtZ7xkEK0Sc99KvyhVhQZnMD70SdjJUXQAhuc+YOhVhpa+WL2ietXzokqaI307c7R
         rl93NqRz2b1XhXlWCFl62nIa3/blJ3eBgz5FqokDWYYQimqxelzyhLAm/AJfV+D7k71n
         GTC0UYaMJYUcLxgUUJ6JVuCzw6RK3Cw2N8ztZGX9ZZmO+F1vhl9sod0gPTJV+pUFBjp9
         yWvqnoVTAwR6K+1lDoXGk/yJ5049ZEK2Kkpl/SqTFVxMgH/wowTeQgmF9CexO8ansQxB
         iKkBOfhqJIHK38FomGj8PseonCeeVs1RjN8DLSCzXzzk+9mwHRNl9WRbJie7JHyEb/4U
         UvYQ==
X-Gm-Message-State: AOAM5329RuqXkRQrdoIZUnlABmcdlvuNysCp5nfzLMzed5+u3ki7ypUk
        4DIJqj50yP3swYOYXh18Hm/u0w==
X-Google-Smtp-Source: ABdhPJxUWsu0qmz5BcX8JlOveaV/OQsmmKH4peFVYNTsS8Dby17MNH0bj2HinBjsziaJi1FXGhVfjQ==
X-Received: by 2002:a62:798e:0:b0:4a7:89cf:8526 with SMTP id u136-20020a62798e000000b004a789cf8526mr15288855pfc.10.1638481329518;
        Thu, 02 Dec 2021 13:42:09 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g22sm758662pfj.29.2021.12.02.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 13:42:09 -0800 (PST)
Date:   Thu, 02 Dec 2021 13:42:09 -0800 (PST)
X-Google-Original-Date: Thu, 02 Dec 2021 13:41:58 PST (-0800)
Subject:     Re: [PATCH v3 5/6] riscv: dts: sifive unmatched: Fix regulator for board rev3
In-Reply-To: <537742e7af4a21baf79429469ba7c30947ddca7a.1637362542.git.plr.vincent@gmail.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        qiuwenbo@kylinos.com.cn, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        david.abdurachmanov@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     plr.vincent@gmail.com
Message-ID: <mhng-25baa8a5-d7c1-4a37-8489-123fd12499f0@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 14:55:41 PST (-0800), plr.vincent@gmail.com wrote:
> The existing values are rejected by the da9063 regulator driver, as they
> are unachievable with the declared chip setup (non-merged vcore and bmem
> are unable to provide the declared curent).
>
> Fix voltages to match rev3 schematics, which also matches their boot-up

There's a few references to rev 3 here.  I'm not sure if that means we 
should have multiple device trees -- this one seems pretty benign, but 
some of the regulator stuff worries me there, where anything rev 3 
specific might not be safe on other revisions.

Did any previous revisions make it out of the lab?

> configuration within the chip's available precision.
> Declare bcore1/bcore2 and bmem/bio as merged.
> Set ldo09 and ldo10 as always-on as their consumers are not declared but
> exist.
> Drop ldo current limits as there is no current limit feature for these
> regulators in the DA9063. Fixes warnings like:
>   DA9063_LDO3: Operation of current configuration missing
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
>
> ---
> Changes since v2:
> - Fix end-of-commit-message separator so change lists do not end up in them.
> Changes since v1:
> - Remove trailing "." on subject line.
> ---
>  .../boot/dts/sifive/hifive-unmatched-a00.dts  | 84 ++++++-------------
>  1 file changed, 24 insertions(+), 60 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 6e7775fdae32..1abad0eec02e 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -93,47 +93,31 @@ wdt {
>  		};
>
>  		regulators {
> -			vdd_bcore1: bcore1 {
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-min-microamp = <5000000>;
> -				regulator-max-microamp = <5000000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_bcore2: bcore2 {
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-min-microamp = <5000000>;
> -				regulator-max-microamp = <5000000>;
> +			vdd_bcore: bcores-merged {
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-min-microamp = <4800000>;
> +				regulator-max-microamp = <4800000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_bpro: bpro {
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <2500000>;
> -				regulator-max-microamp = <2500000>;
> +				regulator-min-microamp = <2400000>;
> +				regulator-max-microamp = <2400000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_bperi: bperi {
> -				regulator-min-microvolt = <1050000>;
> -				regulator-max-microvolt = <1050000>;
> +				regulator-min-microvolt = <1060000>;
> +				regulator-max-microvolt = <1060000>;
>  				regulator-min-microamp = <1500000>;
>  				regulator-max-microamp = <1500000>;
>  				regulator-always-on;
>  			};
>
> -			vdd_bmem: bmem {
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-min-microamp = <3000000>;
> -				regulator-max-microamp = <3000000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_bio: bio {
> +			vdd_bmem_bio: bmem-bio-merged {
>  				regulator-min-microvolt = <1200000>;
>  				regulator-max-microvolt = <1200000>;
>  				regulator-min-microamp = <3000000>;
> @@ -144,86 +128,66 @@ vdd_bio: bio {
>  			vdd_ldo1: ldo1 {
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <100000>;
> -				regulator-max-microamp = <100000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo2: ldo2 {
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo3: ldo3 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo4: ldo4 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo5: ldo5 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <100000>;
> -				regulator-max-microamp = <100000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo6: ldo6 {
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo7: ldo7 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ldo8: ldo8 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>
>  			vdd_ld09: ldo9 {
>  				regulator-min-microvolt = <1050000>;
>  				regulator-max-microvolt = <1050000>;
> -				regulator-min-microamp = <200000>;
> -				regulator-max-microamp = <200000>;
> +				regulator-always-on;
>  			};
>
>  			vdd_ldo10: ldo10 {
>  				regulator-min-microvolt = <1000000>;
>  				regulator-max-microvolt = <1000000>;
> -				regulator-min-microamp = <300000>;
> -				regulator-max-microamp = <300000>;
> +				regulator-always-on;
>  			};
>
>  			vdd_ldo11: ldo11 {
>  				regulator-min-microvolt = <2500000>;
>  				regulator-max-microvolt = <2500000>;
> -				regulator-min-microamp = <300000>;
> -				regulator-max-microamp = <300000>;
>  				regulator-always-on;
>  			};
>  		};
