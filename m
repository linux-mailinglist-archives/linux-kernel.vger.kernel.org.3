Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C0554DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358747AbiFVOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357824AbiFVOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:49:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E53A721;
        Wed, 22 Jun 2022 07:49:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so16913301edb.6;
        Wed, 22 Jun 2022 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RD2cwjPA5P2jV8EBzP33SAlDW2zeqBVaGNd3Sjigp2Y=;
        b=ee5vFxzvKjc5YEyWXafj95MWK8o1oWYdAX8MXuFXxdzbtzcBhae53uyR7q8EtVI30T
         GDfltGkWi7qf0tKg76c6Q7mXhmHkW1Xi6DwcbQ9LvHd9RVH7CJGhI+CmvLygVUU3bV2C
         +SlJJhsegUMn9KpncxIbO3yFJgzlO8u8dSPqRGOUn347ldUrNYwlxBysOAl8Z3bmwb3B
         +UvusYMqbrW9DH+P/CUSKx5xgEkGaQkd3IKcarf6pS8PIeh+sYKaZ+VSTZvHxPuGGXOx
         qXiMIKIjsfHm2zpSCTVW0l7E9CTsarbCidmGQCHOmYKN8+dnBmgzATxxACHnl4l0VeIA
         cf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RD2cwjPA5P2jV8EBzP33SAlDW2zeqBVaGNd3Sjigp2Y=;
        b=vLMO/AFBVG84Oi9saFuL/tzbNtlxOkqudJE/kc48hFV8z1hnCiydnfSFCZrmE8Zok7
         IEPUtMyMQiXuyTXgUAlwQfcoqcODSGzXQNHui1O4QpOc3/6r83lJdoON20wdeLLoC7J5
         3H+D4LCVlGKcfmja+JwTS0Qo3pucz7lu8btw2yuWP+D1mX+fOGdr76Qw7uDYCMKTHeFE
         5+t94SJz1+/GPsZxwK7dhBbQU6+fIg3vblEXa4Dm7349TeJADtZhNYtRbqQKZOE6hcGA
         rSDVRNTpncxpm7kFhkjU4IhCuOdrZVfBKa9tLhwDvjYoGFHW1WUe353s+SThL8hy+g5w
         Fcsw==
X-Gm-Message-State: AJIora9Xffz9sIToT6l+TFfiEkWNLSfFdAy5NOzZ0dYrej311aRZuj8D
        EYUptAjA0nXTAHQDJzNGoqYugsEGuJt3s+t5Cig=
X-Google-Smtp-Source: AGRyM1uqmSsaIA95pJYmjAXkOfrm5ik10/xwWeSmX+s73UTm8EvbEqaAgigYRv3jJjGRaLteSH2hfFdbVl+nvtUfnpE=
X-Received: by 2002:a05:6402:158e:b0:435:7d0f:ac85 with SMTP id
 c14-20020a056402158e00b004357d0fac85mr4436400edv.93.1655909342730; Wed, 22
 Jun 2022 07:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220603144315.5adcddbf@canb.auug.org.au> <20220615150013.30c9d7ad@canb.auug.org.au>
 <20220621181551.5eb294f5@canb.auug.org.au> <CADnq5_OxNm9EwLDXishu+pMfT2mgOSTvkmgSm+cm98JiCsiJog@mail.gmail.com>
 <20220622080726.39cbeb14@canb.auug.org.au>
In-Reply-To: <20220622080726.39cbeb14@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 22 Jun 2022 10:48:50 -0400
Message-ID: <CADnq5_MZ1HqM3C49MNn=4+nufbWOQbQhDtVpAeqtKzKOC+e1ew@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
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

On Tue, Jun 21, 2022 at 6:07 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Alex,
>
> On Tue, 21 Jun 2022 11:02:30 -0400 Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 4:15 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Wed, 15 Jun 2022 15:00:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > On Fri, 3 Jun 2022 14:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > >
> > > > > After merging the amdgpu tree, today's linux-next build (powerpc
> > > > > allyesconfig) failed like this:
> > > > >
> > > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3835:1: error: the frame size of 2752 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > > > >  3835 | } // ModeSupportAndSystemConfigurationFull
> > > > >       | ^
> > > > > cc1: all warnings being treated as errors
> > > >
> > > > I am still getting the above failure.
> > >
> > > I am still getting the above failure ... it has now been 19 days :-(
> >
> > Is it still the same error or something else?  I thought this was
> > fixed in this patch:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6aa8424bcac64b2608452589c9a09984251c01c
>
> Here is the message I got yesterday:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3833:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  3833 | } // ModeSupportAndSystemConfigurationFull
>       | ^
>

Thanks.  I think I fixed it.  Patch sent out.

Alex

> --
> Cheers,
> Stephen Rothwell
