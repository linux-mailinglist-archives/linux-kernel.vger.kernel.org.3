Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3D5AE906
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiIFNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiIFNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:04:55 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510E1E3C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:04:53 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1274ec87ad5so13047750fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7Haewm4pcI6ughQ1h8d6eCH0y+Fa4YzQ3XWrFfPFHdM=;
        b=gZ1NSeFPE+0lZGlav/wzFNn/dSqU/yNEuwpQNNs0Nt55bsLZoMeJWS1/CQjYcGUbFE
         dzhWj5EOasmyF5MoUzSG632ZX9kIvuof3pTMMq4CLyF1LDCoXZBjA71zLJimTWpyuA6o
         jSAp+m3l7226UqJgAF7kldOPfXx4JiMwHq2LDJTG2yyIWo5dcyE7mhodkTF9uPaFdFlv
         hC7ZSYWwVVpoMhesTgy2Ta/E54WY8/BeewR+QOBuVx/WvmUZjzSY1Pcx54TyG84y8pm+
         82fr1EpeW8VcejHmBrvL0EaXNX24lwevhxeVvUtRk5Cl2Y7C9WSOLgX+S41ZUYeuZ5dW
         F72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7Haewm4pcI6ughQ1h8d6eCH0y+Fa4YzQ3XWrFfPFHdM=;
        b=n3a7uHx6xtfBxrRHwpDSMR6WA5z7k4xmnluwo+i0Hm0N6J1zW72fwzgb+KpDOpkJb4
         mkzf4969/3HwSKIiMGINS9lgp3M7ugvBjFsaOQG6u1vrcNStRcmLStC5cq7+OvB3eYlk
         Ydl0DsH9pNO1oZR/GgkiWFpOJPv/24VtkqLaOr55e88waNC9VlaNPdc4BBdzpKP7EGlA
         Nh275YLgS9oaDFA5xtQmuXzOXR0vxp2nltTd2sVyooNCIXqcXazjGn6lNdbCS8HLmqV/
         IB45CwBfBGZRHTrvBHwVOprGm4CYsfDEV9OfWmbQTIBkRPm8G3HEYMRTh/iNtmh8CTcn
         ucsg==
X-Gm-Message-State: ACgBeo2UR1p2pCFrxU1jVHfHOhkwTsptr66b0cQIeJDeor6NzDtq7qQ3
        zkJw7+Z/rY27vJijmR1YHH5Q1RpCiUlq52iObGQyJw==
X-Google-Smtp-Source: AA6agR6B6YeRaWAlddT2IpJ3b2YefZvlzZju/DNCIjrQ3U9qB9vM+iWjlJiKiS/BIaTrwzI8b92Tgus8vmDxx/umhEQ=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr10039724oil.7.1662469492642; Tue, 06
 Sep 2022 06:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
 <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com> <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 6 Sep 2022 15:04:16 +0200
Message-ID: <CAKv63utCSXVgOP4JkEBQSzDWF_s443a-ZbCd8V4tP9=z461McA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 14:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 6, 2022 at 1:52 PM Crt Mori <cmo@melexis.com> wrote:
> > On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >
> > > Very good and documented code, thanks!
> > > I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> > > (due to pm_ptr() usage).
> > > Otherwise, with some nitpicks that wouldn't prevent a green light,
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > I checked DEFINE_.*_PM_OPS usage around drivers and you either have
> > SIMPLE (where you define suspend/resume) or you have RUNTIME (for
> > runtime suspend/resume), but never are those two together. So I am a
> > bit puzzled how to get this working.
>
> The one which suits here is called _DEFINE_DEV_PM_OPS(). But it's
> basically the same what you put here with the possible unused case.
>
I thought underscore prefixed macros are the ones not to be used
directly by drivers. I also found no occurrence in current drivers, so
it was not something that was done so far?
