Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABB55FC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiF2J3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiF2J3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:29:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2539158
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:29:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so21291581edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/qP5VS2/NgqMqeMrxhq05tHUxUfi9oaN9njnjyipZ0=;
        b=3nK/vgsJG7pSe56dwjn6/TTj+WrWPKlRifa6aHQCoF0IuiKiAOXDKGXwGqCg69M28T
         L983TR0sKAD/klCuNBZOPjN6DyLdzukM5BFpinp/HrDtpz7WqbNPzQjSN8WUmljnuHTH
         RByar0huFgSJ7wVUiST9KLw9blBtOlsi3o0rX75DUz30EWhyOw2E9tuf9jGzycPLsVQK
         Pt/OuuaS0NA/+g3H6wrUscacs2qYNrKuu+QLNI8VfjpAeV0EFdYx44fFrgcXsDbfV9xn
         4mwnio63SId/q5sOtVm9uuDzwNuI84bbw2RNs1TWWbw2SbpD0bVB3Ca0ydqDqOUILPVs
         DG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/qP5VS2/NgqMqeMrxhq05tHUxUfi9oaN9njnjyipZ0=;
        b=KfBREUUJPxj0dXeiac0ebZj9eOFlVUc+qWUolC8xtrOU9k57gzGvzHGWYalFGcg6+G
         PuFCNOIeAaAz9WzBqS0HOCPCTjZSe0jOROkmslG7yD2cjzs/flrqPy1zMdz3vIdellgt
         m9UEfG44nKV6k9kcRie5hifeNnjrgItSiXZG5qFF/OrzRAc6ftuZ0aR9Sd9XmF2vNLA2
         59eKuAXK/UD0R4Mc8A7iEbbH6zwj0BeBMHQhCw+MkhFXBMdHWy4GIMSo8qDgMKfVtpZc
         AhSqe4W8te5p3CBey6AsE3Y8um4Tnbi5vjpkup0P50nILBN72AVIPPT4Cvb29heY4c0m
         o5pg==
X-Gm-Message-State: AJIora9uw3Y2Sc9z2fHsL5OM92azut3kNjmByPfxQC24Nhky8V1Chw+3
        igLXEdV3ZWqnC3ceRmyj/TIlQi3fPpk8vY8RxGYK
X-Google-Smtp-Source: AGRyM1sS12JVNqIJoizAX444CBbg5tqjy6FdigCkOcz+AdW5ySG8VJO0ejggmCP2QgNUtnTubpIHHfUwscO889cS7Gg=
X-Received: by 2002:a05:6402:d6b:b0:435:7170:cf15 with SMTP id
 ec43-20020a0564020d6b00b004357170cf15mr2877724edb.314.1656494945421; Wed, 29
 Jun 2022 02:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629082541.118-1-xieyongji@bytedance.com> <20220629082541.118-7-xieyongji@bytedance.com>
 <20220629042856-mutt-send-email-mst@kernel.org> <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
 <20220629052130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629052130-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 29 Jun 2022 17:28:55 +0800
Message-ID: <CACycT3vg=_crxQQfkmUYyG1tCWTVidiBssQn+xxMYe_7vAM-KA@mail.gmail.com>
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 5:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 05:02:40PM +0800, Yongji Xie wrote:
> > On Wed, Jun 29, 2022 at 4:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> > > > Let's update api version to 1 since we introduced
> > > > some new ioctls to support registering userspace
> > > > memory for IOTLB.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > >
> > > Adding new ioctls does not justify things like this.
> > >
> >
> > What I want to do here is make userspace know whether this feature is
> > supported or not in the kernel. So do you think we need to add
> > something like CHECK_EXTENSION ioctl here?
>
> Why bother? unsupported ioctls just return an error code.
>

Oh, yes. I forgot the error code of the ioctls.

Thanks,
Yongji
