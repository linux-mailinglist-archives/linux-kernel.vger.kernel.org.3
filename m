Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032D5477ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbhLPV2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:28:39 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37419 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbhLPV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:28:37 -0500
Received: by mail-oi1-f178.google.com with SMTP id bj13so788407oib.4;
        Thu, 16 Dec 2021 13:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4WrGs7AdiwIx2WRnezyl9BaCDZ2jmqPsdo8O4vRvLg=;
        b=dBdUIwsYWyHxBWfTgawTw734iJs2J5XfjykAemrcfjjGUzvoZs51gv2n0/F+GvZlGR
         9DiK/KVc8WmqVJWTQGQ2N6HdzMlLVDJliKrNpzVUlWmV2FysG5jmmunia0QMIgWqNK+7
         RQvRWQjpyB9134dqLgX+6aHYW/CIi0GMyBwCZ8D1O2So0JIQlDwT4hmSuKyiTaCtxWar
         klb4CNzN++8SRaQkuFjY5D89HB3jqlkbnZoVmO7xmRkxmbAEB7vb5t7wn9zp4qWidhrH
         mIWaDeYme/rN5GaNWR2DO+8hB3bNRfnX/R0UrBU2vHLgjENqcSEB7Peha/vxoTi/f/Al
         c6hA==
X-Gm-Message-State: AOAM532OcPBcfDjdfsYKbrR0fP/BvW2Dx1CJvOv3NhQNtdjDz8FjtOhE
        E3vaLp+DVpiTLQwBqjz3pQ==
X-Google-Smtp-Source: ABdhPJwMsfm6t0C73XAGqvrX19MQsCB+oVAihTHhjvFl3IBepH5UAiLP2WGaDOH0asSNG05WV2Js7g==
X-Received: by 2002:a05:6808:23cb:: with SMTP id bq11mr5580232oib.2.1639690116754;
        Thu, 16 Dec 2021 13:28:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k8sm1302776oon.2.2021.12.16.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:28:36 -0800 (PST)
Received: (nullmailer pid 796072 invoked by uid 1000);
        Thu, 16 Dec 2021 21:28:35 -0000
Date:   Thu, 16 Dec 2021 15:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/2] dt-bindings: interrupt-controller: sifive,plic:
 Miscellaneous improvements
Message-ID: <Ybuvg3h+VLCMji4J@robh.at.kernel.org>
References: <cover.1639661878.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639661878.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Konstantin

On Thu, Dec 16, 2021 at 02:41:20PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains two improvements for the SiFive PLIC DT
> bindings.

Lore is thoroughly confused with this and several other series. It seems 
to be doing subject matching and pretty loosely.

Rob

> 
> Changes compared to v1[1]:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/r/20211125152233.162868-1-geert@linux-m68k.org
> 
> Geert Uytterhoeven (2):
>   dt-bindings: interrupt-controller: sifive,plic: Fix number of
>     interrupts
>   dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples
> 
>  .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
