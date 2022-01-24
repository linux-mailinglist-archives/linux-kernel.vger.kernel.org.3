Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F62497C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiAXJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiAXJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:46:13 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C0C06173B;
        Mon, 24 Jan 2022 01:46:12 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id n15so28268092uaq.5;
        Mon, 24 Jan 2022 01:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p96M4E4XtTOqPEwsF9Q62UadvumL5u9cv+LYUa/tLkg=;
        b=e2npIRYt1QpQa5AgxDkUjImJZXm7wGZZB6WohSkMkAy3+C8cLPw1lBl/gzda2bsLuC
         25YGpBqJWDN8LbIw1esHepWbMHGNKzI9Fxm+yAfOKUyuNoRKtKYPTmDbR0q5ynINtGO3
         EuZ1TYrXW7HC8IrFh2lIMsP9O4r1zI1y5QnLuntd+mHvwgmgD0Tutyri+ESZokbchSgV
         colnpndUYf5CaZ88WGeqttP1SIAwFZRApeIHc1P6X+qqu/iRoOMSkr9fk90dGKEUQIpi
         h1INxM8a6jFfo/qLQ7Gp3LffuqkshDQts39vysQxlJmlyiikpX1xKNG4Jq2bLzlgqL3M
         MKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p96M4E4XtTOqPEwsF9Q62UadvumL5u9cv+LYUa/tLkg=;
        b=l2mxP4Pbx1W9zUgiQhvoaCZbPbqJX/5Tkkb/J5MZhFTtEsX97/wBbhoIwGzcSYBK1u
         ZKZiQmLQ71jLl1mQWQ4mAjGWDran4RB/oeM7APYcpnf8JBhX1Ejni6eJi2dnVHhI/08h
         EK0QR1QMjOOTZSOz6egatQruqoldFmgMHKFx9lM1uvHp3dCfxicmdP2lMNkvPhs3BhqA
         45YyouPOj+cwhSL3mu8Ar1ZJcoqGtjhWYG8+r/EU491nyD1CjlU4LxKPuOPROnuLihRs
         rz7+1RqCX9wT9QaR7aIe7jJql5cCgUELimmbSc/ISLODqQJG1XNxg4RnYN0afYNbJyr3
         Bk5g==
X-Gm-Message-State: AOAM532xITLRWhzIT4G0R1kvSwAqwM7+lZjdYBNc9zhDTDEs1DuhI3Al
        vCaqenbh9FDIZXaLog+Pf6DVINGKO48WaLpeB8I=
X-Google-Smtp-Source: ABdhPJwQFXBcNaW/Sbw2W4Dmnvaq4tSnfxGNL0yLRBNzy5KCrBIahgE3R+dOKvstiUbD988TVquZsL+d46navZZUVcA=
X-Received: by 2002:a05:6102:9d0:: with SMTP id g16mr4062881vsi.40.1643017571848;
 Mon, 24 Jan 2022 01:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20220123174031.3109-1-rdunlap@infradead.org>
In-Reply-To: <20220123174031.3109-1-rdunlap@infradead.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 24 Jan 2022 10:45:36 +0100
Message-ID: <CAOLZvyH1UTf4e94xa-yF2CasqOCbyCOz5YZEs9QjLBOyVipt4A@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux-MIPS <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jan 23, 2022 at 6:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> When the MIPS_ALCHEMY board selection is MIPS_XXS1500 instead of
> MIPS_DB1XXX, the PCMCIA driver 'db1xxx_ss' has build errors due
> to missing DB1XXX symbols. The PCMCIA driver should be restricted
> to MIPS_DB1XXX instead of MIPS_ALCHEMY to fix this build error.

>  config PCMCIA_ALCHEMY_DEVBOARD
>         tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
> -       depends on MIPS_ALCHEMY && PCMCIA
> +       depends on MIPS_DB1XXX && PCMCIA
>         help
>           Enable this driver of you want PCMCIA support on your Alchemy
>           Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300

Seems sensible.
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>

Thank you!
      Manuel
