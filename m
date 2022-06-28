Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3A55C558
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiF1IXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbiF1IWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:22:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758365EF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59BCFB81C0F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ACCC341C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404512;
        bh=iACa9QxBhxvPLX/AuqFq3ZfuLfcIRGBq0bd2dgiRJk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KkoW0sUidRNIPSH6cz7GuUSI+Tq7/GX/6bMAuxot7IFbJdcqA7jTLj/4UhqOgSGX6
         UtDTwIhS59Da9TofH4vl5dz7q0d3LUZidqC9YkSEL7X/gM/TSnxrF1uSuCammbiCn8
         O1LyZtiMuZ9NLYYmN3FfxF5kH7riL1B9GR8pTNjfprY78uJP5lmg1gFCLIxGQRz9gA
         GG5O4mxMoAwpIE59dsvD7C19e0fWyygoqw+JLaLSOLt4l1QP4iy3zmItjD+io4qEte
         kAli6UgGB5/z8ibiDpJ4Kcvw2b9YPBFl8IAXfRX/XW88k6ni4or/qoPl2nICxk/VIO
         vYQ/ufS/Mezag==
Received: by mail-yb1-f173.google.com with SMTP id v38so10234013ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:21:52 -0700 (PDT)
X-Gm-Message-State: AJIora/nKUUrhsjtXBeEC/8ZoJLSVcdjJCU9iZC1qrp8d+5a0iypu9oG
        wEmdFXDW+WMXa7ICx27ttgWAZ/9vVhvAM+3OLag=
X-Google-Smtp-Source: AGRyM1sn6BS0JBrqxao0aSfaTcvkF7uy6zXRIyxmu3fJR8LwDPaiFOtgpFRPzEvBTjj/q1iSJUdY8dpXIfayfTRUHvQ=
X-Received: by 2002:a25:b74a:0:b0:66a:775d:a257 with SMTP id
 e10-20020a25b74a000000b0066a775da257mr18578781ybm.381.1656404511118; Tue, 28
 Jun 2022 01:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-5-ogabbay@kernel.org>
 <Yrqg+6bBxRMmomrm@kroah.com>
In-Reply-To: <Yrqg+6bBxRMmomrm@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 11:21:24 +0300
X-Gmail-Original-Message-ID: <CAFCwf12mXA9u8+ZE6msZL4R11DsE8SVN2GxpxOfo=_0aGnY7nQ@mail.gmail.com>
Message-ID: <CAFCwf12mXA9u8+ZE6msZL4R11DsE8SVN2GxpxOfo=_0aGnY7nQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] habanalabs: add unsupported functions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 27, 2022 at 11:26:12PM +0300, Oded Gabbay wrote:
> > There are a number of new ASIC-specific functions that were added
> > for Gaudi2. To make the common code work, we need to define empty
> > implementations of those functions for Goya and Gaudi.
> >
> > Some functions will return error if called with Goya/Gaudi.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > ---
> >  drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
> >  drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > index ae894335e9f8..f4581220ecd5 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
> >       gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
> >  }
> >
> > +int gaudi_pre_schedule_cs(struct hl_cs *cs)
> > +{
> > +     return 0;
> > +}
> > +
> >  static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
> >  {
> >       return gaudi_cq_assignment[cq_idx];
> > @@ -8959,6 +8964,14 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
> >               gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
> >  }
> >
> > +int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
> > +                                                     u64 mmu_cap_mask)
> > +{
> > +     dev_err(hdev->dev, "mmu_error function is not supported\n");
>
> Can userspace trigger this?  if so, make it debug, as you don't want to
> give userspace a way to spam the logs.

Only via a debugfs node which is exposed only to root user.
What is your recommendation in that case ?

Thanks,
Oded
>
> thanks,
>
> greg k-h
