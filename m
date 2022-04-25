Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70550E68D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiDYRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiDYRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:11:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7C39148
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:08:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso11204010otj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luUxyYSSREVdQFdtrc0m9ipVrl/3T6wRxhlnsIThqWg=;
        b=Uvx0h2A1RbmYx95kT2LrLn/fl80ZbpTyPe+hSP5lXiPrMqg1QYXJAUAa0P5d0hyA31
         FvsrTAj5Tiqd6JtBwsL1zOowdM8OGoaKKy8lz4M80YoR28IVx/lezur706Ng2wTubKnJ
         +YbvNGCKYk57Z9GaLoDwJ5cSB65YSQgfZsKmQRnxN6x5odqxyIDQpuodN0rPM0K1yTNz
         sQM3l9hKJ3cdfWQ5d1VixIrATddlwSdvk+zYrfY9z/NLFL2rJPQnEEofYuwdTL3E3LL4
         fJeO9m9tCCajV+54TZqkYKQLzVXkCnNUlIfAYV8qGuVvDZYgPPk5M+wPCJhORe5YSBRk
         TnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luUxyYSSREVdQFdtrc0m9ipVrl/3T6wRxhlnsIThqWg=;
        b=14wXySZEf0s9egniX7FtOYv/mRU18qPIv5FHvZ0+dOA51qL7uOiPiT1mAFlv2xlgNB
         WpzNGjEn1vLdYLWAOT1Xs8MNulZjvK6tpwHizkNb6fsYFgBvx9/Y7Ex7UV0YijfBlPuK
         n6LqHJzSjSvrSLrSIq+L7Bi5K4KfaulaRx6/Bg6kiWtb9QH/KxsIGc67s0T28h5KiroH
         /ytDatMSwY5DjhtF+kAu/kVWrKBX8EDNiBDOhOfO5q2gM+IPeA5sYStehM5waHW0j36Z
         M00NnE/6AvBUCCW22fKu66ZMy9FLz+6p7H2gzPG3WGAsDEaZNLzVRVuz8xB75IeJPts4
         2gpQ==
X-Gm-Message-State: AOAM532vbY6GRZb1YFJkqSaehR+NU4H41VOsI0AtXUucLHs1UIj0D33H
        U/cu9XAS50SQClGp7F2l6hVvpT4CkoemjGplhNE=
X-Google-Smtp-Source: ABdhPJxamLKNMhMi1ouviFPH7sECZVbru0DA7KnS0AE1HYXe726Xyj3MnW6JDTe+kIFf6ERxuiU1HtXnqB5q3T+mSG4=
X-Received: by 2002:a9d:7a8f:0:b0:604:25d0:f231 with SMTP id
 l15-20020a9d7a8f000000b0060425d0f231mr7010853otn.200.1650906489686; Mon, 25
 Apr 2022 10:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220423012943.12133-1-rdunlap@infradead.org>
In-Reply-To: <20220423012943.12133-1-rdunlap@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Apr 2022 13:07:58 -0400
Message-ID: <CADnq5_NixUWpRxD0YzxxDSC6FCTr9HsF_bDxMrh=KeaFyWMJhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix non-kernel-doc comment warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        David Airlie <airlied@linux.ie>, Robin Chen <po-tchen@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings for a comment that should not use
> kernel-doc notation:
>
> dmub_psr.c:235: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Set PSR power optimization flags.
> dmub_psr.c:235: warning: missing initial short description on line:
>  * Set PSR power optimization flags.
>
> Fixes: e5dfcd272722 ("drm/amd/display: dc_link_set_psr_allow_active refactoring")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Robin Chen <po-tchen@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -231,7 +231,7 @@ static void dmub_psr_set_level(struct dm
>         dc_dmub_srv_wait_idle(dc->dmub_srv);
>  }
>
> -/**
> +/*
>   * Set PSR power optimization flags.
>   */
>  static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst)
