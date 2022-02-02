Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0D4A6974
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiBBBAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:00:04 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:47027 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiBBBAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:00:03 -0500
Received: by mail-oi1-f179.google.com with SMTP id y23so36734777oia.13;
        Tue, 01 Feb 2022 17:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FwmA6JKPlfYdb8O53eG4VPOnrHtZJfiTdm/qzeAbUSI=;
        b=SYQ96a8I1nh6Jzf6qWyO925ysIHvdFYAPVH2RGa6gSdKUydWKECsAPmW2jfA+4mMAh
         Le74n8R3uS+NrvIzlmn8TdqodGsxSkjhbt4AKBPioMbQLfid6Rf9hfb9Lk7sLdSzH4cP
         uxHqNR8kOIYsKN6TmSD30nj87k2BByPzToHTsh61oKnl+s8isXTS1uzuSU7YkhhjLTl1
         0pibU752N31Zb9Wcj19SUWxoPkV24MbtzbV3LwBUHrvD1++khs+8CnaRrLkrwmB+l4ac
         Y5phY7PgF/lfvkpjl0rynJMV31aOqwIKoqM7oefDLADcewzDXZaQiqaHRU/Pp6bW44vb
         6V2g==
X-Gm-Message-State: AOAM5331ZSRuCmjr1eQZ787ClfMa7rpev0q4/SuFTQxOpdK+B59E+W8Z
        n9SscHbuoppVOJONBw5VfOTsliQEuA==
X-Google-Smtp-Source: ABdhPJx94mzW80s1AVWpJttUhCzADCAhxdp8POgQUBSKTXkKjvBSI6IyPsZx17pLj82OsvpC+Wqtxg==
X-Received: by 2002:a05:6808:1645:: with SMTP id az5mr3359794oib.313.1643763602315;
        Tue, 01 Feb 2022 17:00:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc36sm5100831oob.45.2022.02.01.17.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 17:00:01 -0800 (PST)
Received: (nullmailer pid 1101236 invoked by uid 1000);
        Wed, 02 Feb 2022 01:00:00 -0000
Date:   Tue, 1 Feb 2022 19:00:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, Guo Ren <guoren@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de,
        Rob Herring <robh+dt@kernel.org>, palmer@dabbelt.com,
        samuel@sholland.org
Subject: Re: [PATCH V7 1/2] dt-bindings: update riscv plic compatible string
Message-ID: <YfnXkO98mpm9O0zH@robh.at.kernel.org>
References: <20220130135634.1213301-1-guoren@kernel.org>
 <20220130135634.1213301-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130135634.1213301-2-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 21:56:33 +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support allwinner d1 SOC which contains c906 core.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Samuel Holland <samuel@sholland.org>
> ---
>  .../sifive,plic-1.0.0.yaml                    | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
