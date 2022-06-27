Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9655DFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiF0Vmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbiF0Vme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:42:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8FBA0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:42:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q6so21765368eji.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/m5gEvG4Nkhnu6c3440vB73PXnwZ2jewkhSAliGBXTg=;
        b=CynNGWCzO8u27qkFDIzY+jXsy8vbILCE7VFIfDkmWApFEP/TyAInFPWtLoi8W4oAJv
         yRP1bnPJv+PoEUvfh/hvO8Nnx2y2AjIz/CszaBG+aQkExDPFi7OJbr/+buyNM3cuJzpL
         QiNruHf7RNp23wTV4F7qqgkqzrV/zED8wFZamXl60ftr7DKklUJED02KuOkfGa/+QuqK
         eSR2sUlA7gfJPtbcReFLZRg/BzoXQ6QzGoIAuB2LbOV0xv7nN2/pZ78o8K66JVTTLvLl
         uMcvFqANm4pcYdgcWj6bxJWqXtfIjhIrq59dKA1kQLW4msu2vFcBV7x9IOXQ5mD2jvYT
         iK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/m5gEvG4Nkhnu6c3440vB73PXnwZ2jewkhSAliGBXTg=;
        b=Pg1DvP54kuo0EwkLHXtlHSnp4lNkD0Ibqzrmo0Ncz9T81PUln7k29Sq5H5suRffBBS
         m3GMh50iCTWSW3k8nR+1do/jjoPtQgCEZKj9tIWzzD/w5bOTxz+hrVUYVGnjiUH1jHx+
         wKuWpZ4kjTQJEYgHBLaGpaYLUS6izeJAC2hmA2tExe41GLOyZ/pBaqaLb1ew+Merv/O4
         CqNUNQ762fnY200Xy3ngHOLMO6FipeerURH2z9sMLuAMn4OS8a/eFdg8TKm5ifRgli9q
         B0LiUA2FZv5Yz1e95Sshrdjj9fxz15hYEAkH1tURbZxzEcr0NA6RkSlREcew22G//BSA
         JaZg==
X-Gm-Message-State: AJIora8RtvFsR0YU//gEOtn0uNYllc1sg+S53RB5NH4n20YLU/7gaHnM
        O3X9ySZcprePKobhrhDcmJfiVxVOCHD567PnZh4=
X-Google-Smtp-Source: AGRyM1taWusL4FY3+GMWFIszRF5v07rsqFPHyB0aYp0PK+HTRRFV65ppUhrxHJAFgTBDtn2UdlK/lwl57yxqpNliC0Q=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr5833402ejc.185.1656366151850; Mon, 27
 Jun 2022 14:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220626142053.3373970-1-trix@redhat.com> <f55999ae-4ff3-2616-fda1-a97e5aa11524@amd.com>
In-Reply-To: <f55999ae-4ff3-2616-fda1-a97e5aa11524@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jun 2022 17:42:20 -0400
Message-ID: <CADnq5_Odt0jxU8voLjcmu8y1bQ57gzEd9ZBtAxrLLn9tHY65cg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused globals FORCE_RATE and FORCE_LANE_COUNT
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        George Shen <George.Shen@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jun 27, 2022 at 9:20 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 2022-06-26 10:20, Tom Rix wrote:
> > sparse reports
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3885:6: warning: symbol 'FORCE_RATE' was not declared. Should it be static?
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3886:10: warning: symbol 'FORCE_LANE_COUNT' was not declared. Should it be static?
> >
> > Neither of thse variables is used in dc_link_dp.c.  Reviewing the commit listed in
> > the fixes tag shows neither was used in the original patch.  So remove them.
> >
> > Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index be1dcb0a2a06..f3421f2bd52e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -3882,9 +3882,6 @@ static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_
> >       return true;
> >   }
> >
> > -bool FORCE_RATE = false;
> > -uint32_t FORCE_LANE_COUNT = 0;
> > -
> >   void decide_link_settings(struct dc_stream_state *stream,
> >       struct dc_link_settings *link_setting)
> >   {
>
>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
