Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652E849EE42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiA0Wtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiA0Wtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:49:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC7C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:49:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h12so4723805pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+xO8EqLFUCui4EksMPBTtUzqUy69IME3pxskdaGT84=;
        b=S/3NlMq/VzH6n8N/3ItPaKj87TfCkln/Xpf2ZWUcGIww2DDgYlXdWKPg0qHfB9n7s4
         xdOiXsftmKSBycWFZkjTPVNWlFtY1Zf5COYn/bwEUt7AaInIQxQRuj0To48lViySlErr
         KHE25WkSTam4RCChpke3fQtwBFMDfTfzQgEF92epl5Q1jV5Qo7gtwTjo3GhqYuVG2mrV
         AGY9ZkM7jBHnHO1cpXN/E9CaSLinbz2ctsREOUw+jnvInnrMznwRbPxiUgTjrTf058uz
         k5XaSUIDXVaUr7O1YWP1A7ms0N/RNfNHek0VY5lsH9FUySwzHcTT4pg9L33Etx9ukjH2
         SYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+xO8EqLFUCui4EksMPBTtUzqUy69IME3pxskdaGT84=;
        b=qxusmjFGxCytBak7/Oahr/mbPD2s8QVFOP1NJeS7A9ZRvh2js6xUmCN2SYYc0h98KZ
         9m9TnATWEeWkcSZ8gbMJjOIxEG4XV2SJGRSp7M0rB6m7j0YH4wPC3f/CMGVwI5qfJUAO
         MYvxeoqnEtCuTDFv3t5mo07dxDBCFq+cboxXhwTBivjd9oEBFaBZDeeVkSWaKBYqUx+j
         YbsbTLz/0B0XgUSQ4ijsogRn7NpL1i/7+T3Z3BWZJ92/xcg8zywhHzk1ErFvBUn5ksjf
         498iTTRedxfHZXqqwMYJsNVMkEuNCvRh44HAKLxm6HpP4zRxHBOyNtLM9sfF5WOydQD/
         48XA==
X-Gm-Message-State: AOAM533Ol1rMXp1joN7V4Zj0VSaZwBkTeBOmnSPgTFOCOSSKiUDq13KF
        8lcwSvIa1Sob+qqWfQLflOGNiD7SjZwQb/JyFqP6LA==
X-Google-Smtp-Source: ABdhPJzHixJG/xXB3xwpj3793Z17iaq6LfTsT5F2gkjyLAl6ZDQgwQE9zFs+Zx3q+fX/aMrEm2pow6J2TZZv0OWaIp8=
X-Received: by 2002:a17:90b:4a82:: with SMTP id lp2mr6552523pjb.179.1643323792568;
 Thu, 27 Jan 2022 14:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20211215001812.9006-1-tharvey@gateworks.com> <20220126090739.GH4686@dragon>
In-Reply-To: <20220126090739.GH4686@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 27 Jan 2022 14:49:41 -0800
Message-ID: <CAJ+vNU3Xj-b2BSc_6MQrtrh-G=5dMdMmw0S8EtujVz_7FvkQ0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m{m,n}_venice*: add gpio-line-names
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:07 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Dec 14, 2021 at 04:18:12PM -0800, Tim Harvey wrote:
> > Add gpio-line-names for the various GPIO's used on Gateworks Venice
> > boards. Note that these GPIO's are typically 'configured' in Boot
> > Firmware via gpio-hog therefore we only configure line names to keep the
> > boot firmware configuration from changing on kernel init.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> It doesn't apply to my imx/dt64 branch.  Could you rebase?
>

Shawn,

Sure, I'll try to submit another version within a couple of days.

Did you happen to see 'arm64: dts: imx8mm-venice*: add PCIe support'
[1]? It seems to have been archived for some reason and it may have to
be rebased after I re-post this one unless you can take that now.

Best Regards,

Tim
[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211216164149.13333-1-tharvey@gateworks.com/
