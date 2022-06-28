Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF80E55E181
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiF1JOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344080AbiF1JN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:13:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3512639
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 679CEB81D30
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD88C3411D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656407636;
        bh=UVt5GJOzrusdiAeVz2MUCA37lIY3b+fHQP3hg2kfMTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cmIfxhDJLXfwPbwJSF7R/NbFV3xzRGwRdSNQ6xgJwFtZphCJxFHxXEWTsfkIOh1H4
         hFNf7wli8LbZ/K7tvqgXmlTYORA9+BuB4RHWj/28fjCP5xu/m/mdef2m+HG7W6fyLd
         +OPYpY4MKL3xYkYE00EOFRybrChHys3OG0swabtceFlS6ZJsLoVJbFO2CrCJIE+ysU
         d2trhurKGev2YfsSU7db/OAUaNb18Wk05TYO9NHyIu7G2Gzeg2w6xbnaw88wFh+ZZ/
         TGnOqbo1xOnYZZBoaEbMaN/gTgmNuUNDUOn82cYREfBgHN72DSDDP54KrrKWAj1S9A
         puHDmZsAuiGgg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3176b6ed923so109855787b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:13:56 -0700 (PDT)
X-Gm-Message-State: AJIora/+a4PLuDprDytwSvz4nxhmsqVJwV7ahCNFVdH6lQYB+QQexT6e
        LhJt0cWIZ5dxr4xV85wVzJNE1pz24wuSG4oKPfk=
X-Google-Smtp-Source: AGRyM1ucX/GJvdnAHB/+qsTKe08RIktILui9oKuaHPlErIW/8Z8gy8P+NjRK0m4FKAZ+wFekDMGu+c833X2Iyvb1RpQ=
X-Received: by 2002:a81:5f54:0:b0:317:dd64:4da2 with SMTP id
 t81-20020a815f54000000b00317dd644da2mr19385203ywb.206.1656407635148; Tue, 28
 Jun 2022 02:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-5-ogabbay@kernel.org>
 <Yrqg+6bBxRMmomrm@kroah.com> <CAFCwf12mXA9u8+ZE6msZL4R11DsE8SVN2GxpxOfo=_0aGnY7nQ@mail.gmail.com>
 <YrrGDbUTxyZi2hdT@kroah.com>
In-Reply-To: <YrrGDbUTxyZi2hdT@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 12:13:28 +0300
X-Gmail-Original-Message-ID: <CAFCwf12-NgU0zA2UQ6DeoctZoq1Guer79DfqHUtW2MRXeZJDAQ@mail.gmail.com>
Message-ID: <CAFCwf12-NgU0zA2UQ6DeoctZoq1Guer79DfqHUtW2MRXeZJDAQ@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 12:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 28, 2022 at 11:21:24AM +0300, Oded Gabbay wrote:
> > On Tue, Jun 28, 2022 at 9:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 11:26:12PM +0300, Oded Gabbay wrote:
> > > > There are a number of new ASIC-specific functions that were added
> > > > for Gaudi2. To make the common code work, we need to define empty
> > > > implementations of those functions for Goya and Gaudi.
> > > >
> > > > Some functions will return error if called with Goya/Gaudi.
> > > >
> > > > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > > > ---
> > > >  drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
> > > >  drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
> > > >  2 files changed, 48 insertions(+)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > > index ae894335e9f8..f4581220ecd5 100644
> > > > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > > > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > > @@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
> > > >       gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
> > > >  }
> > > >
> > > > +int gaudi_pre_schedule_cs(struct hl_cs *cs)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
> > > >  {
> > > >       return gaudi_cq_assignment[cq_idx];
> > > > @@ -8959,6 +8964,14 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
> > > >               gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
> > > >  }
> > > >
> > > > +int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
> > > > +                                                     u64 mmu_cap_mask)
> > > > +{
> > > > +     dev_err(hdev->dev, "mmu_error function is not supported\n");
> > >
> > > Can userspace trigger this?  if so, make it debug, as you don't want to
> > > give userspace a way to spam the logs.
> >
> > Only via a debugfs node which is exposed only to root user.
> > What is your recommendation in that case ?
>
> What does this error message help out with?  Why not just return an
> error and be done with it?  No need to spam the kernel log, right?
Sure, np.  I'm with you on that.

Thanks,
Oded
>
> thanks,
>
> greg k-h
