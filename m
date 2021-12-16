Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7D477ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhLPVai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:30:38 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34765 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbhLPVah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:30:37 -0500
Received: by mail-oi1-f171.google.com with SMTP id t19so821607oij.1;
        Thu, 16 Dec 2021 13:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94tmzfRyz/2ht7p28AZCEvikg92RoVzFn7XAnXNJoM0=;
        b=0ff69PrSD2lLUFXJgX02tht6z1VAPpfX9G6Ks4EIGhXFCa3YGj+lfTFTgKLgE8xZje
         2I+tCiy17QYGlNiaNClH2ARvjMqkqdiunQzN2KVm1j47tvUjJylifZXGiAK+LjOTtLVq
         G54nMzOvRha2StPUKUjOEQ8BN3SGH09kEJ7mvw8TKFCq4I6temr1xGyxmmO3EkclILJl
         oBQZEl3I/xMny5UM3cx6UT+p25n7k1oO1NuHH5oN7jCP/Fn27S7SgMiAftZb1o7OWDnn
         Xxfg9bTJcxFUsGTWlKotLAs2JdYTrftmRb7ysEsQ5GKLSmJ5a66+h+//TsHteeznpCXW
         JMlQ==
X-Gm-Message-State: AOAM531vDLIUhSfvtANjccQqPkj+i4NVwT/8Lnn7FjUsASLuPiq1iAUG
        JhqiZYGPjiGiUhnZVo+8tw==
X-Google-Smtp-Source: ABdhPJzG03I0AExOUVl+P3tfAIYSyiVcZkGh1MO2sf+PYWkhxXBP7uwSnh3PQuEX4rZ0rzXNkgp8UA==
X-Received: by 2002:a05:6808:1246:: with SMTP id o6mr5733670oiv.73.1639690237248;
        Thu, 16 Dec 2021 13:30:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c3sm1313179oiw.8.2021.12.16.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:30:36 -0800 (PST)
Received: (nullmailer pid 799562 invoked by uid 1000);
        Thu, 16 Dec 2021 21:30:36 -0000
Date:   Thu, 16 Dec 2021 15:30:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: timer: sifive,clint: Group interrupt
 tuples
Message-ID: <Ybuv/Jnyn4Ue5KAx@robh.at.kernel.org>
References: <cover.1639662093.git.geert@linux-m68k.org>
 <2859d2377f778b592c7b52597e698abc628de8dc.1639662093.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2859d2377f778b592c7b52597e698abc628de8dc.1639662093.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:43:48 +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Split in two patches.
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
