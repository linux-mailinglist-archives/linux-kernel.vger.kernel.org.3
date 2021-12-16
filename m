Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79A477ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhLPV3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:29:50 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34671 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhLPV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:29:49 -0500
Received: by mail-oi1-f181.google.com with SMTP id t19so818855oij.1;
        Thu, 16 Dec 2021 13:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U23U7mY8KPLC85hut2VPiBNKK+Lf3eiI8eYPXHpTL1c=;
        b=EOPTyV10l369CkEeUMjH+GPpY8s60K2mjA2rxKnYuW+pU6w9be0mNRbUIPuc5/4U7y
         7sJ9lhN2ny2rxhpEwjbf58cPNFp9uxEb9+LpIJOyqObcSmNYBJ3/LDmv6pLqnnQyvLHO
         S7bGUdSJQHLenccVAmLeUbPFewPivEFCHRqlQjlGiF2JaQLtPeL4Kf9wKFqgd/yU13/Z
         cLnh7CA58BuSgXdMP+CLnk08b7ISC+Zp1qf0/332uAYbi0KqHMN4LB9cF6GCYuH/AVdB
         McG0hceqCL3sDStX7QWMtF7NQzmOvHi19YB3YyTm00SmFJGCCTM5ssIc2jRqC/Ve/7D6
         xZew==
X-Gm-Message-State: AOAM531ZsK2rHwW2SlpFpCIX38n+o+AgNcjyY4/8AEIsegC4RGTmOJzA
        6Eyzkm6tAaQNVmRO5hP/Jg==
X-Google-Smtp-Source: ABdhPJxMXpJ8fB9M0+KuYWwf3c5Sh8Zjc4EecIQ1JBKZrcOdt8LRF2BOc65beZQt1vfzNEz/Oo342A==
X-Received: by 2002:a54:4111:: with SMTP id l17mr5656905oic.127.1639690188952;
        Thu, 16 Dec 2021 13:29:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l23sm1261667oti.16.2021.12.16.13.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:29:48 -0800 (PST)
Received: (nullmailer pid 798137 invoked by uid 1000);
        Thu, 16 Dec 2021 21:29:47 -0000
Date:   Thu, 16 Dec 2021 15:29:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: interrupt-controller: sifive,plic:
 Group interrupt tuples
Message-ID: <Ybuvy+YYImEtDal0@robh.at.kernel.org>
References: <cover.1639661878.git.geert@linux-m68k.org>
 <2f1894def1ab4fb4151357a7a0b2f66760165d72.1639661878.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1894def1ab4fb4151357a7a0b2f66760165d72.1639661878.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:41:22 +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Split in two patches.
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
