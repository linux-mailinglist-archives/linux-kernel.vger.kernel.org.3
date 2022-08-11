Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550045907D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiHKVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHKVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:07:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF998CB8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so6253035pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=JrHUTkJyQWr1jJIPcxndllMl3ULcPf+kBB+IZh69boA=;
        b=QyByDNzU0LLWSP3pCHqJuo1AUxkE432ctIaCVFEaqbh6KSme27t2bncc2YpexJzZZN
         D6Gzxaxx7+JmrmOshKQv5Wiakv025CZocwBVBjYGpOwwmNdh0ZkXePLRcn9mihdwd3bV
         JYriUdKzNglB+n7gKMAfrwGGEaJuS6+aZ3+oaIrtoUIo3GWbRjtnTVOmZTvb4w12LhVW
         1kWtv3jiY/xu+rOKc6Iiv5dznAh21pBsLZ0z4meReseuplORjfdbWe8XFzatF1301QGT
         PGzPxWxX73FVuCnSeN8l9iEU2iLi1i753hcqWHCKNi/F7nOibf+/oKShN+7FyEvIQqrK
         69qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=JrHUTkJyQWr1jJIPcxndllMl3ULcPf+kBB+IZh69boA=;
        b=mk8G5p9Iff0tdrpJftCUNqjkQ2gNZcEScMz2AqZxsqnrv/yZ3Ps+6YGdEhvhNdk+0z
         tNd02sDgYcCXCQF97pGsXUOV3+G65aGS+KAP83PAEOweyJHFlgpMiuNPpGCE1K/y4rpk
         cwKCs+VOGpgOIy9y8BtlI9CUFq7CJxUVhH8zFn7kD4LQ4iFlBdHWt7g0LyJn3fl8QbaN
         qJmDA4pUgS2yJ91kpPxSo0RjBgUw+V4f4HrxAec2eiBMk0CAHVj5om2MjpS6wKlJx0Mu
         xv3V9ZVEis93Q5T1Sj4hn1bbvZ5P3bWrolQfWKeasucttwa3HRyrcztQKibyh4Gpq72V
         dBww==
X-Gm-Message-State: ACgBeo2LvroihZZ5WHLSWHxy3Py6oFpCrrAazFOpCJdkAvdmLrVnRL49
        WtkWiBbf//hDiJnQTtYjPKNnYQ==
X-Google-Smtp-Source: AA6agR6XAQlEc6RM9lomCPThmIuzbW7YQlUvuKU4lrWhPm22PyZgoIEmGk2m2jQZ59bDV3Rt0+Hb7g==
X-Received: by 2002:a17:902:8502:b0:16c:c5c5:a198 with SMTP id bj2-20020a170902850200b0016cc5c5a198mr898604plb.88.1660252016890;
        Thu, 11 Aug 2022 14:06:56 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id lj7-20020a17090b344700b001f731a1ed88sm4150322pjb.2.2022.08.11.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:06:56 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:06:56 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 12:09:15 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: dts: starfive: correct number of external interrupts
In-Reply-To: <20220707185529.19509-1-kettenis@openbsd.org>
CC:     mail@conchuod.ie, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kernel@esmil.dk, kettenis@openbsd.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kettenis@openbsd.org
Message-ID: <mhng-4117ac1c-2f8c-4011-91df-c920e6ab6aad@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2022 11:55:28 PDT (-0700), kettenis@openbsd.org wrote:
> The PLIC integrated on the Vic_U7_Core integrated on the StarFive
> JH7100 SoC actually supports 133 external interrupts.  127 of these
> are exposed to the outside world; the remainder are used by other
> devices that are part of the core-complex such as the L2 cache
> controller.  But all 133 interrupts are external interrupts as far
> as the PLIC is concerned.  Fix the property so that the driver can
> manage these additional interrupts, which is important since the
> interrupts for the L2 cache controller are enabled by default.
>
> Fixes: ec85362fb121 ("RISC-V: Add initial StarFive JH7100 device tree")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>
> ChangeLog:
>
> v2: - Fix commit message
>
>
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index 69f22f9aad9d..f48e232a72a7 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -118,7 +118,7 @@ plic: interrupt-controller@c000000 {
>  			interrupt-controller;
>  			#address-cells = <0>;
>  			#interrupt-cells = <1>;
> -			riscv,ndev = <127>;
> +			riscv,ndev = <133>;
>  		};
>
>  		clkgen: clock-controller@11800000 {

Thanks, this is on for-next.
