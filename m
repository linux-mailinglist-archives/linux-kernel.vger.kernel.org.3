Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99251B994
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbiEEIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiEEIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:06:02 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC131521
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:02:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f186so2641413qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKLUQCHfVgMEJnTrRslfbeGXik3U/rOoNt4N6SZRfTU=;
        b=KavWwnzrf/Bkj6cOK4VQyb8WREwBkDnrhyUesJtEtcKMQEQnFkSxUXkShoWbl+Ph5S
         DGogpFH2S0Xbb9/p5jU1jHxyy15s81gy3LfzSq337RxR4ZVOn8yQE9VKAboqdTMtoQs7
         +XhHrCUFAzn47sZc5M4uggW4JYCw3wgSaMPf/4GzEW8DaN2WGJCZrduQ04VF4sA6LPcH
         tqDV8+oahOca0w3O3qp79rRYVMDAbRMWZvhrMvEfwwVsHqUt1LEimXA4Z9a/nb75EyRV
         0XYVZaOOeSEcdNeCXleUTwAfvri0qjqPcgoaOYo3azwc2T8JrsuMZCE1hMg3BNteleF7
         0cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKLUQCHfVgMEJnTrRslfbeGXik3U/rOoNt4N6SZRfTU=;
        b=TSwjH7KjE8DZqbxJ2ENf5ZVEhcRjo0Wc1yrsFs41S85S3Jl0e2LyWLWMLvZ25Lx5ms
         qJvoddko3wCFfJ52zm0jovrHXGWDAsUg1U3GawAln4CHb2YsFHq0pTDDRcgOLdZstXER
         EGVK/axUgwu5IHHvyNOQrrmEom+Taf03SiA1iPlAtNTnzNrl48SqeimkOaHWKykMrYOv
         GadJ0V6doDEvISBliq73uyGMhVYSxGF/3+8ckiETzmCT5mv7YQQs9pC5iff3rGLofkgq
         UITKe/rpAUSt4BzzTXOpsp2R8vBy6YyoAO3g93oMsHLJ4YLq3TYHaoQUy/X6mXDRHsjt
         n2xg==
X-Gm-Message-State: AOAM533nlT9Ojg3YEkWaKW1vBmZzzjAdOUyguTgp+WPbCBbQDYu7fz6F
        zd95oQgiHUy9RJg5zVKZyDHqz9X4mIlkeiqLg0a6VO17aTwev05zlYE=
X-Google-Smtp-Source: ABdhPJzV2fjGYRTFHgnPzgAXf7qjLmyXAgonvKvk1zHJEUnMlRsDVCcgldKjTzIcsqbeRk7Pj8DmCWXtuKo2HRfR+qk=
X-Received: by 2002:a05:620a:4105:b0:6a0:462:6b05 with SMTP id
 j5-20020a05620a410500b006a004626b05mr7811566qko.663.1651737743034; Thu, 05
 May 2022 01:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 5 May 2022 13:02:12 +0500
Message-ID: <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux@leemhuis.info,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, luto@kernel.org
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

On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> I think you did misinterpret the results. The max latency just says which power
> state is the deepest it will request APST, and your controller's reported
> values will allow the deepest low power state your controller supports, which
> is known to cause problems with some platform/controller combinations.
>
> The troubleshooting steps for your observation is to:
>
>   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
>   2. Turn off APSM (pcie_aspm=off)
>   3. Turn off both
>
> Typically one of those resolves the issue.

Thanks.
To make it easier for everyone to diagnose such problems, it would be
great if every switching between power save modes would be written to
the kernel log (when console_loglevel is KERN_DEBUG)
If APST is culprit, we would have seen the change in the power state
in the kernel logs before the message "nvme nvme0: controller is
down;".

-- 
Best Regards,
Mike Gavrilov.
