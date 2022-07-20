Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F313057AB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiGTA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiGTA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:59:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0DD422D1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:59:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso622982pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMqpq+6+yoPLVRxuqGlUD9PzJdpOdFM4+KM/Do+P/P4=;
        b=zXISU7imtSyM8keXKHfu+RbyJ1d2MZ5O6ob4x2/Fa+/4IfT8j3orPgO+bJrF8Ovg6N
         RaJljrcCqrngnnj/2niRvPDEIdujQeCpyIKx1Deh2cj6q0IVASBpagRmaOQyWwWQ0Zso
         KZ/CCx0NVAcTRGPWpnN+C/0LIgfWLyUe3JV07xD4WTkktb8EnVO92bDmvwqT9IiDDqxD
         HMPkRm7uOoKdQ0v2yaBKjtXoTCrX9wIINAMpz851fVUg5hNLM1QLP7ck1tc/FpBOmi2L
         YvJB/STir26x4yvyZB5POdAzWYkmE8iQ+fDdYyua0WQ5rS4CNRuVwGb9U2RfDqLRFcgz
         jP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMqpq+6+yoPLVRxuqGlUD9PzJdpOdFM4+KM/Do+P/P4=;
        b=ujXHqdWXTn047I12EFPNvKWxiI4g/Vcj31tBlmwzxVtQuKBPTBaGV3hSYyclFu28EO
         +cycbSK0a4RACy8saFf+PS+cLP2XwKDvkDVJa6Ysg3mEA4YImcOiOXUvPQgkZQIyv7K2
         0bYvf88E9H+5OQVZrypR5areNdIh+lZ/AfBzky/9+kwvtQK9VKTMh/Kt1EKSjcxgsS/f
         QSzjFRjrgctZAeqY5PBc9sCovRcxwolpdbrr34UsSYDZukfWDlkFTVeIf3AeTE6qacTt
         jMWzwLJEHb0ZjVC+CYjeDZOFTm71gfEAdkbMw+q325bPVIrBy0IShNZegCuZ0LEFodVb
         DJBw==
X-Gm-Message-State: AJIora9kUWe25PM+ZDVq1rOQjNfXNrgDz4IEUD7bvQO5IbkcCedLHdx7
        /lxZrqK1OpKslcTkIa4gkKxVWG2PHaZAYvhnMZOidw==
X-Google-Smtp-Source: AGRyM1tqE0o6Xmvg+LICCVUDMbQDW1UImgVhQXsbysUQxDJu6Z6mJ5BwwppnF55vHTiTzl9zv6CM/ORA/UZoQemK/yQ=
X-Received: by 2002:a17:90b:4f82:b0:1f0:95d:c029 with SMTP id
 qe2-20020a17090b4f8200b001f0095dc029mr2480358pjb.66.1658278758841; Tue, 19
 Jul 2022 17:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com> <1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 19 Jul 2022 17:59:07 -0700
Message-ID: <CAJ+vNU0FM_zs9nQ6rX=xNJzsgaH=5WOeNDNCS9rs5VF2Av5eRQ@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 2:49 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Support more than Gen2 speed link mode, since i.MX8MP PCIe supports up
> to Gen3 link speed.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 30641d2dda14..37012f9a33a0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -809,8 +809,8 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>
>         dw_pcie_wait_for_link(pci);
>
> -       if (pci->link_gen == 2) {
> -               /* Allow Gen2 mode after the link is up. */
> +       if (pci->link_gen > 1) {
> +               /* Allow faster modes after the link is up. */
>                 dw_pcie_dbi_ro_wr_en(pci);
>                 tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>                 tmp &= ~PCI_EXP_LNKCAP_SLS;
> --

Richard,

I noticed that your imx8mp pcie series [1] will force the imx8mp to
link only at gen1 speeds unless support like the above is added. I
believe you would also need the following:
-               tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
+               tmp |= pci->link_gen;

When I used this along with your imx8mp series however I only get a gen1 link.

Have you made any progress on a v3 of your imx8mp series?

Do you know if the downstream NXP vendor kernel [2] supports imx8mp Gen3 links?

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-pci/list/?series=620887&state=*
[2] https://source.codeaurora.org/external/imx/linux-imx/
