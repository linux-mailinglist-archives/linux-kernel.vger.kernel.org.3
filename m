Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F31478499
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhLQFfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLQFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:35:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B28C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:35:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mj19so1229597pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CTKXdWbXYFCcZS3TCZsbdeP+y1YkG9m0hcHXCbzMHfM=;
        b=A4M9QeI+3ITdTU3nEB+emC4vcyx+RAPXNHc00k+QZaVfIv+tswGciZ0liMjWSBUY1e
         DzU51tl6VIka910nqnfFhTtBy7NN35fgeTEE4y5KpuRqf3O9EneSu9iI6iv3pGqeYbnd
         OftXqjemeUxNgZlZKVGNivuRcYejGt1AfV76STSMgZQ96wBeXb8Ee2HIYjbzyfRI6R4X
         cEtN7hKnS9omG+gm+dWusTvfCsirNk1GtOg7wYiqXixd4c69Eu4FSjYkTYn/4n+fRpIv
         0CjVJ6ZCcf/j39XFI/l+wiVbKsK/0xx81J3peOGp6cK9O8sOkrIyFQZawH0J03RFvRwU
         xfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CTKXdWbXYFCcZS3TCZsbdeP+y1YkG9m0hcHXCbzMHfM=;
        b=JolGUV9YiYDOEUiqW8gppH0upCChTrW8nHNRGD4IvcuDGx4XnT3lgCMBeiCBTbzdzn
         GhT4RbfN8p/EQ8NOMjU8PXfP6I6+z3WEUMq5lvkXbGKcTMGI8xZNfs5QQBCfWbRpUuoL
         ByKoXXk/aroLzCMl/c53ZvmlgSjMpLPbziSC3m0bBsAMXy3Vat7lHqpmjbgjLJJIMs6t
         SKI1UgTAi6FXjCit2YKCHK/tEwqiRvhByB5r6a6XmD8Y8unecnqt8bOVwNyWkWDtlwNo
         CBhuMn8Wc7dC0vL9j67ylJPzf4cqwIn2W82cNL3xb2IFAqsnDS+IHN6EVQihZFgdSa9o
         Bx0g==
X-Gm-Message-State: AOAM532cLNpzoba9Rk60+ugAL8gfwumBCj1k2AoSpRLgylo1og2qOv/C
        EcfhLwa8DUz4g3LmFJAYDJ6wcQ==
X-Google-Smtp-Source: ABdhPJw5nyrUeaDehYt+dPK8PDeUMkeASbVvAJf4VuOnAdah2SxYnJZ8OzLk5tw2P3bphJ0UMxxIgA==
X-Received: by 2002:a17:90a:909:: with SMTP id n9mr1943440pjn.1.1639719301358;
        Thu, 16 Dec 2021 21:35:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m67sm687523pfb.36.2021.12.16.21.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 21:35:00 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:35:00 -0800 (PST)
X-Google-Original-Date: Thu, 16 Dec 2021 21:30:12 PST (-0800)
Subject:     Re: [PATCH v3 4/6] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator
In-Reply-To: <5ab111e71e88d545d7f03233f10b6d84ef3d6c21.1637362542.git.plr.vincent@gmail.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        qiuwenbo@kylinos.com.cn, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        david.abdurachmanov@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     plr.vincent@gmail.com
Message-ID: <mhng-854afd5f-800b-4b58-af68-cdc6afdc0a4a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 14:55:40 PST (-0800), plr.vincent@gmail.com wrote:
> Provides monitoring of core voltage and current:
> tps544b20-i2c-0-1e
> Adapter: i2c-ocores
> vout1:       906.00 mV
> temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
>
> ---
> Note: checkpatch.pl complains about undocumented devicetree binding,
> which is fixed by:
>   https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u
>
> Changes since v2:
> - Fix end-of-commit-message separator so change lists do not end up in them.
> Changes since v1:
> - Added missing "ti," prefix in compatible string.
> - Remove trailing "." on subject line.
> - Rename tree node.

I see this in Rob's for-next as 761de79adc2c ("dt-bindings: hwmon: add
TI DC-DC converters"), so I'm going to hold off on this one until the
bindings land.

I've put the others on fixes.

Thanks!

> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 270360b258b7..6e7775fdae32 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,6 +51,11 @@ &uart1 {
>  &i2c0 {
>  	status = "okay";
>
> +	regulator@1e {
> +		compatible = "ti,tps544b20";
> +		reg = <0x1e>;
> +	};
> +
>  	temperature-sensor@4c {
>  		compatible = "ti,tmp451";
>  		reg = <0x4c>;
