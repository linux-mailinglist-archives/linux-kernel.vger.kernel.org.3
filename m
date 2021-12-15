Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67F475173
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbhLODll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhLODlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:41:40 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A2C061574;
        Tue, 14 Dec 2021 19:41:39 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id l25so9518875qkl.5;
        Tue, 14 Dec 2021 19:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYou/sncx/ZOc90DTta97dk0tFp6wdjxFsde2cv+KuI=;
        b=l3W1Skv3cttl6xmZPqh5VhNWfrvwvWNuIrISXSp+LbcsxWRIJj230CXHHv3yPUse0U
         K3NAEntePVy00U5WFkymiOTD9Eju3I93WrQxt5hiT2OYtNzJ8kRuXBDXe53A1wB6/HG6
         gK8E3ofRMtRVYmgvTdL6xvW6MshVBemcQZtuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYou/sncx/ZOc90DTta97dk0tFp6wdjxFsde2cv+KuI=;
        b=MhjyGLZAcOjS439Y6IrEhTWhJQoGS+FyF9X61JnmAsx3VtkNdDRaPI3ODmpv6icCzN
         ADrU7Rhlq3Kd5NVkgYSJSdE/hNdtqqCkDuMpAVbrruTwB4vJ5QlU8s7fO8qETGTNMNw7
         7YXCimfJFBylXCsm0t75lPaAizFYRxBAOp2xkz8lp2F7OtO9wgNcF9hPcx+oHeVInCHY
         B3hgDYkDQUR4Lcuo2OssjIqY7wP0pd1pc50dHVXloHYoJmVU8EGSWhrlcheroUfU09o1
         /OzLoiJxQ7I7JbbDqVX/AnM5LHvNCXK9MylGLsw4QPlRQb3CuO3NAbWZyEYSITN9WouY
         IMOw==
X-Gm-Message-State: AOAM530FLIStu8pNGHMuYbxTqt84mEIg08iedZY7VYRpMNeDcUw6n6XR
        KiEsQWoW+r9cmCF0oz9wzraMqdLarduGXW61cKc=
X-Google-Smtp-Source: ABdhPJz+D6MmqXy3uphrelmMYcf3x4xzGqNjbYJ9LVi3lQsti1ioJGdlxTlTy1QBYZ1VP9UL/KWAIX/qkvoEFc7l98U=
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr7120860qko.165.1639539698999;
 Tue, 14 Dec 2021 19:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20211210145430.3707463-1-gsomlo@gmail.com> <20211210145430.3707463-3-gsomlo@gmail.com>
In-Reply-To: <20211210145430.3707463-3-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 15 Dec 2021 03:41:26 +0000
Message-ID: <CACPK8Xd=Qv_ePGXBTB2gYxSUqqte=MNcuDNgAoqqjecvzNKCPQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 at 14:54, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteSDCard is a small footprint, configurable SDCard core for FPGA
> based system on chips.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
