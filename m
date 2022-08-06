Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80DB58B547
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiHFL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiHFL6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:58:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCA13FB0;
        Sat,  6 Aug 2022 04:58:13 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d139so3640829iof.4;
        Sat, 06 Aug 2022 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUfbb3VHymyxnMR94FjI2mkzesHqJLKSWp1RL/4sb4c=;
        b=Y3qOPv56DTeB7tJ2XtMJpFGR93nZ+K/pi/poz2ZHSDlZeglmnHE6f/1x/JTbT2Ikp/
         oU13pjqcwy/MQM/20pfyY7OuppLSV9phlD5rULnCMdChOKzCyWr+cHGEqOU/mveHfD3s
         C3cXXUE3nMd2WIYiGWTokuUzSlT2uRTHE3AkloXdVAMt9jHp2HFpdDfQLxSvufJsXt0B
         bR2Y4eRdh0z35mnviqT1SGtVFTCQia2rlxVE+oDEDGKZSn8Issi8tFBVvZHQZ3Uuz0xI
         6RDRlEsWor1c7IAnVHPXvXge3HgFJdP7+gp247h8pRThr/D/J2HdWp+ZxNCgquQMl08G
         A4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUfbb3VHymyxnMR94FjI2mkzesHqJLKSWp1RL/4sb4c=;
        b=FI0lk3QZMMN/nc7+0BCh6XH9tRFH07WLElzDxYv64ezMc0TcAqVu9WqAjvWAE+fLMG
         MgKyIPNl/ihx9zM3P0qn4wXvx8J+q7eczO9Co3L66BnkjdJUnnjsv1QCOtkEI7lQ7Tp4
         4ptWtNdqlJ9db9AkTvjyaXm3wArKXL1mNgYYpIP7w78XVA+r7hyzwNMl2wMjDtsTXin0
         8rbVAwAzxBIpPb+TMNiVHn4P+Yh01kLZ3F2syNfQtRJnkvfIfcqeAwGoSuRGMWiyewDr
         Q2xVTHceB2jEdO+moHbNdPid9lwF3+vADL0SnfqMInBkDq3Mc22wRmPPapfwgtjq0Ku8
         +VIA==
X-Gm-Message-State: ACgBeo3jK6Z15lBQhnCvTEX5lU6Fwelgr7lMXoEl6mjlCs1IoR+rcFn4
        2XyGNdyqd2fKsUrSS72VA7Ut+vMqTrF4g+7kMsU=
X-Google-Smtp-Source: AA6agR5aI215Ei9SZ/4y1a3HZxN881CoGJtKo6kLP9/0RFkvORY0NNgMAes2xh5t/q/g6cHbT6ERaroTVUQuKHphxzI=
X-Received: by 2002:a05:6638:25cb:b0:341:6546:1534 with SMTP id
 u11-20020a05663825cb00b0034165461534mr4729711jat.308.1659787093414; Sat, 06
 Aug 2022 04:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-29-ojeda@kernel.org> <YukvvPOOu8uZl7+n@yadro.com>
 <CANiq72m30zTwgSgV3+CDiMqdt2LH7TvkcnkMSw3B2do_gLn=Ng@mail.gmail.com> <Yu0BlTVYG2/OKw0f@yadro.com>
In-Reply-To: <Yu0BlTVYG2/OKw0f@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Aug 2022 13:58:02 +0200
Message-ID: <CANiq72n9wbE-YU2WOT8V20eiie3w5EqzjP8WQXpYDQNfUzcN_A@mail.gmail.com>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Fri, Aug 5, 2022 at 1:40 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> Cool, thanks. I suggest it for the next patchset iteration, since it's
> already has a GH issue.

Gary implemented a subset of string literals to cover this without
having to vendor extra external code in
https://github.com/Rust-for-Linux/linux/pull/858:

    module! {
        type: RustNetfilter,
        name: "rust_netfilter",
        author: "Rust for Linux Contributors",
        description: "Rust netfilter sample",
        license: "GPL",
    }

It will be there in v10.

Cheers,
Miguel
