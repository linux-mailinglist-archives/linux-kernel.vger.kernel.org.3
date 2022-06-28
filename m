Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E655CFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiF1IXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbiF1IWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610C27FE5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AB9614C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D968C341CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404469;
        bh=H6W3TYRgI00lOJz+gaUoalseegOPq8mXZz09k0yw4K4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNwABfsdmMjNVciKz5JTilKbX8m7ZqQnO0Usy3g7Ef/pLnpQZ840O5yBssSovUaSK
         DAwA91tloFGhXJIkOLXym6dkICE2qVFQ362h3Qt3/lMTfXBqZnKVDN3KWbDW9fLxbJ
         uLmeTC9AzlK5PntMWIJYDWwskVt8jyduUiP8poPwMeaD6P6tqPSch11zTpT14w6IEK
         A4GKSQTjEZyMlYLi9z/6XEhYp+6Zjdu9VTUFayf/Odjk0/P2qn/sQ3LBMZ2DlbpNlo
         q09yJph29J843fUoQvoS0tToELgUtVDyxgbIF9sNX+qWNhs3+UCOfB9AXWJZEedF8n
         QO0w8ZmSNUGsQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31bf327d4b5so19355887b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:21:09 -0700 (PDT)
X-Gm-Message-State: AJIora83i+BzptU4vie3ZmQxxmMSDH2O23EWGd7XLrRoFHPO+20f08g/
        MMs00bjoobfJ+ZuaZbvj1xI3Z8P+VgGleW53FlI=
X-Google-Smtp-Source: AGRyM1voV4Hcm+/4OSy0s9kE+YllDY2//mDg09j0S2x7akstTYn6KOelZMv+OHuyb3TuhPQ1b6m41QhyaYdd35FLIXU=
X-Received: by 2002:a81:32c9:0:b0:317:7278:e377 with SMTP id
 y192-20020a8132c9000000b003177278e377mr19537554ywy.3.1656404468620; Tue, 28
 Jun 2022 01:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-5-ogabbay@kernel.org>
 <Yrqg3vZlqaMvUeeO@kroah.com>
In-Reply-To: <Yrqg3vZlqaMvUeeO@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 11:20:40 +0300
X-Gmail-Original-Message-ID: <CAFCwf10zem5VSa-2AfZtQW4W3Vm+d-jqkiiyyHeEijfrSd6Q0g@mail.gmail.com>
Message-ID: <CAFCwf10zem5VSa-2AfZtQW4W3Vm+d-jqkiiyyHeEijfrSd6Q0g@mail.gmail.com>
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
>
> static?
>
> Did you run sparse on this change?
Not on this change specifically. Sorry, will run on the entire code.

>
> thanks,
>
> greg k-h
