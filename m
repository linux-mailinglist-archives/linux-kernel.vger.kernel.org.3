Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8238A4A77A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbiBBSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbiBBSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:15:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D20C061714;
        Wed,  2 Feb 2022 10:15:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m4so138438ejb.9;
        Wed, 02 Feb 2022 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MaOHUJUnenNN9sGhqkZzJ2Y2Vt6iwM6PeXygRWMsT0=;
        b=gVc7NusfzRUOhJkfmIbtXQ03ldpIJfclaq39kA8Pe/IS1KLCFkvvlereG2w87WQe7t
         O5gQzmosnvX33FfWzzmKCOK0PS/nAsRanm/FbApbsH+VUdtpRrNLbupgq4IzWfmG3+y5
         UFwh30ClLSCzVGx04uq7fA0EEY1ifH37dM+SRlirppIuh2NFeFU3P98+Dk6hgeAed7E6
         s9GvuM3bUfTu/jZpQhx9iTpFEljRq+gAGCebrRHeNtP9J/uqlFPlbjQaJdr8wI1tbC0d
         sZSbdChKlti7v4SvStWsjXaO7mGWqyZPPfMx3eXpme6lwJcBJHcNiubrJchZij4GpwoI
         e6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MaOHUJUnenNN9sGhqkZzJ2Y2Vt6iwM6PeXygRWMsT0=;
        b=qfdHGDMDS/p4tfTkdXpzaBi190bTYdn9FQhmYFYNkhV49A9jfU1SJq0HeG3LsIsCLP
         kX/I/adqun3tjcfmXRsY1LXW3ZX6IsWUtzCv+vvV1iJ7SsCIu973XwgwdKn2jKauVKzy
         lOGHXQmjGHiWOxHD4Cnx7izUMEYXod7rullSelCUrx2QCryLDb+P5SpQ8THn9L/SxAPk
         whb4VIAGM+1C0FI2RLJz9tb6MLMJxau3OaU9NL2hVMOZQPuEOVOlbnIVg1He9Kq6Uji2
         sGPRwywMEFHjmNgvghMXt4TSCKrpWqe9v97dNoXCCMtxJ1ei9uTPCbi5Es3LR5cPqbTN
         e1xQ==
X-Gm-Message-State: AOAM5319XdObd2YB3xsASNAvM9qbFwvUHiSKDNWr9rFUrNOjZ6RHreEg
        xmj7/ndId4PNGQxpc0yrLuK3bdZaYxuw6sDs+CE=
X-Google-Smtp-Source: ABdhPJzXOCdS1ycNFt+uem0tG04ixWIiuQ/p2Osy2lwMe55bie/mP5rRnGD3ulmzrIAxMpY3W7IO3WV0rsOsSArkGBM=
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr20913064ejc.658.1643825757500;
 Wed, 02 Feb 2022 10:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20220124082803.94286-1-francesco.dolcini@toradex.com> <20220124082803.94286-3-francesco.dolcini@toradex.com>
In-Reply-To: <20220124082803.94286-3-francesco.dolcini@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Feb 2022 15:15:48 -0300
Message-ID: <CAOMZO5DZQzX0O4-yqg5HaO1zmUkQtO+yMPMBamVyvk1C8chn_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 5:28 AM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> From: Stefan Agner <stefan.agner@toradex.com>
>
> The i.MX 7Solo currently does not have multiple operating points,
> however, in order for the i.MX Thermal driver to successfully probe
> a cpufreq device is required. Add it to the cpufreq-dt-platdev
> driver's blocklist to allow using imx-cpufreq-dt.
>
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
