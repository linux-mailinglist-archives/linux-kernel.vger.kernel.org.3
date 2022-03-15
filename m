Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53264D956D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiCOHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbiCOHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:37:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9264B402
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:36:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5757b57caso35565407b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uj1acuBG5kcEqw59Y4tqrJax7+x9T6dt2CoxNkY2Fak=;
        b=moVlMSHF69zGnMI/0PjKcxJsN+D1KS9lGLTiZtmLi/MyLQssQUI+L/Qt+5gaUew6D1
         GVRFrWCk7PXO9aB7Od6Kr++gUz5iNM9Izij517YOstugCCL+YBngkx+2NprBdfVsEYN4
         gpVBiU1SV3+84iXltCUfVi33UElnavUetxwZGn5+bHSQ4jGXyUvRPjPqoo/r3H9mkXev
         BcvcIY9bymdJcMKSa/f788r3jfXwqvW69K8PSdwDAD9bNsI02vXSvm2OLj5WzCSTC4gh
         G8Wvjkamm3vPUK26yrbPqQ47QBmro1gcJQkOExaJJgnHM65tMSZmPLTpIPBPEBXXzNVV
         6H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uj1acuBG5kcEqw59Y4tqrJax7+x9T6dt2CoxNkY2Fak=;
        b=13xj47ALuVPFQCdkw7+Hgc7EKmO5IZesVJuzo2zRL5DngMuccxWbHhqUE12inyXgpG
         6yFsIqbrboVd+Wb10z6EtgoKEFrQCxhBUkQqD+ONiZdmIez6oO3YTC3nR1YiT8VF1pxT
         CwaPXBRW29YfYHepLF0THGc2y/o4uYPO7NsdWi4aEVG4WZey8vw2j9M6CRfsU2G4Z2Vr
         67s1GmGWTpMgUAOY1JKGaqURJub3X/qv47BE9yq+pgTYTsf77nXEosAv/iLpMZNRsey2
         ejrz+6T8vrPrNMQuh5RoCE4d9ZJA8piZRQzdOsR3P3lAs/AaFLlqb9LLv1e7dwQRgc8V
         CZvw==
X-Gm-Message-State: AOAM530MJ90eKWEOa/uMJbZIcEpjDvzPFv6fKuwzGk7NJFo6ms3YAOn2
        lexDGwYf4Vp4xQATAxUvWUJ3Rw/iDtDB/0vfhbA=
X-Google-Smtp-Source: ABdhPJx3agf+lbIQCwDprJVxQmcAULbOQQwJ9EuRfTkxPmEPSxjdgjiyIdpXD5CTrwSDJcO5awo000KYB5pdgyyTN3s=
X-Received: by 2002:a81:1601:0:b0:2dc:149d:b302 with SMTP id
 1-20020a811601000000b002dc149db302mr11928835yww.203.1647329780670; Tue, 15
 Mar 2022 00:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com> <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
 <Yics6JbQljlQXRED@kroah.com> <CAFcO6XNLfOTp2M3B876YTt+atNTveuqH7Q3ePk3N-T=KkJkiTQ@mail.gmail.com>
 <YjA24K4FVZU6fTMd@kroah.com>
In-Reply-To: <YjA24K4FVZU6fTMd@kroah.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 15 Mar 2022 15:36:11 +0800
Message-ID: <CAFcO6XNTSoDdQA-4U91VyZqXkjUL+zyoceN7VGwWQKn+HrbbBA@mail.gmail.com>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Li Fei1 <fei1.li@intel.com>, LKML <linux-kernel@vger.kernel.org>
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

Ok, thanks.  By the way, I want to explain, Firstly there is just some
parameter that should be freed before func returns the -EINVAL error
in the patch.
I think it was correct, no need to test it. And  secondly the commitor
Li Fei1 also reviewed the patch code. finally I am sorry that  no arcn
hso hardware to test it.

Regards,
  butt3rflyh4ck.

On Tue, Mar 15, 2022 at 2:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 15, 2022 at 10:44:09AM +0800, butt3rflyh4ck wrote:
> > Hi, Greg, could you tell me how to test (like this)?
>
> I have no context at all what "like this" is sorry.
>
> greg k-h



-- 
Active Defense Lab of Venustech
