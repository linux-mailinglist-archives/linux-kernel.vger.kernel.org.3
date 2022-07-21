Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC357C723
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiGUJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGUJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:13:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEF631E;
        Thu, 21 Jul 2022 02:13:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u19so1854952lfs.0;
        Thu, 21 Jul 2022 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5kCbqo9/asc8TbRc8IHSA6ZNE2YRX8o+JKYyuYSinQ=;
        b=DntXjVtUYnVIKEPy1TCCQF4GIthlJOw7GtutqrEKaMUNYh44lfJ3TClCDvap2gPDxe
         tpXP8+Ax8wBEfcn07I49vE9yVZrd3sduEMkWyGQcxBMq1t9UZIjRGtelRK+9lT9T/TTH
         pvh6+VzjRm4j7WvG1eNxf36x8+gqwMOGtlY4VWgGrDsd64qoYgcEOfprUQdEWuqeYEW3
         ZUebiKsjY/bKvF9BDNHUtU3ZojS3idQnK5WnhLGywMIw9pyUlOL0AyfaBwpPhgY0iU5j
         bHTEecXjrc0t46pJ3IdxXE7jTFZehXY9jJqMYhxbuPFAL+Wd1KAhylnBYRTj81dqkNfa
         YxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5kCbqo9/asc8TbRc8IHSA6ZNE2YRX8o+JKYyuYSinQ=;
        b=oZT31LHQDGa+We+AHjFvoS1Tth1tnBoE7Fb9/iuOQqAt9IEjjCxeq4yqQfd14jYeT6
         zh86dc3BylFxdH5DmoAurBuFiLyCYsUt5+BFmlf+rPw12vlnm6kLzSTrv/3Akum4akSs
         TJaVRTPl3jYxkZaIwcShT3Xt1+hudZJY5jBVoNg7wBCMhjs2AsTwLjhR1ALmOllifgVz
         X/4Gxa+NoVrRsC0mY8ZTVt0d8+bS8a0jPKwAXqobbmgfjW06xCJ/iWxKE4a7syuHtHfk
         S7+milmwhnKHJDwWZ3JdbLfuz0Iedjy66nLN01Af8CtRvXeV36yLx8Pt8cn8tkziE6Sl
         tJ3w==
X-Gm-Message-State: AJIora+spJewmKl7lfYV+KK/DUPPwZO83Ke9vgnpTewOmn+RtTNDnZpl
        vATSRz2O0uYe5ZB2lzpRsV7zCQfcMJfF4cNlohY=
X-Google-Smtp-Source: AGRyM1vzBf29h8mR+F6wsS3JnS1vNFzhOdx3vbqYsXP/a7UYWAkfJRfSOfwgdv/MMLTjGgwHRxMPRUGo5zvHG2vRsY8=
X-Received: by 2002:a05:6512:2290:b0:489:d433:605d with SMTP id
 f16-20020a056512229000b00489d433605dmr20865514lfu.629.1658394835137; Thu, 21
 Jul 2022 02:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220714055142.214728-1-alexs@kernel.org> <874jzbo4x5.fsf@meer.lwn.net>
 <20220720144044.0cd2757be75fe00d198394f1@linux-foundation.org> <87zgh3mlbc.fsf@meer.lwn.net>
In-Reply-To: <87zgh3mlbc.fsf@meer.lwn.net>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 21 Jul 2022 17:13:18 +0800
Message-ID: <CAJy-Amm56MzMQcNS7ZR2Vzrngf_+evQCSG1YMtQPQpdekXOV8g@mail.gmail.com>
Subject: Re: [PATCH] doc/vm: move overcommit-accounting doc to admin-guide
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Jul 21, 2022 at 7:11 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> > Don't forget that Documentation/vm was moved to Documentation/mm in
> > mm-stable and linux-next.
>
> True, that's only going to make things messier.  I've dropped this one
> for now; I can either reapply it after the move hits mainline or it can
> go through -mm now, whatever's easiest.
>

Thanks for reminding. I updated it to -next tree.
https://lore.kernel.org/linux-doc/20220721090834.17130-1-alexs@kernel.org/T/#u

Thanks
Alex
