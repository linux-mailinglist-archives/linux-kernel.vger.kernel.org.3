Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E485953CCA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiFCPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiFCPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:55 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC2515B3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:43 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l9-20020a056830268900b006054381dd35so5811855otu.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9WBFLi2GZ/Ui4GpH9tULtj9LEgcGT39WehBSO1WgzQ=;
        b=HEUAXsna5ZmSt0hJfuqV4f5D85h+f7wPyDldmxerUEzbCUP/OG/paIqlzAoySvKeaX
         SIwilD6gZCvRVOBgAiv6GINcQ62p8PX5DuVPoOn35OEQFCmsntOS/RP6/DSiP6HzKvnz
         KQDYVwTmYWC0hcQmTYfskxUHLjDVhbLbi7rq7Z5JERaKRgMVEsWkU5tQYsCZFktp0Hq4
         Pv2dl+wx1j4nKLHpq/SBK+Q442HyVo3wK/Jx3mzQtCQj7MVzAGN7mM5NyvQCgjeLK8rv
         fhTbFgNwg9K1WmzDDQFjZhZLtR8NU+r+NSaFPMBUoGP/zMX6DKKXnj/oCXnhFXHdD4BJ
         0J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9WBFLi2GZ/Ui4GpH9tULtj9LEgcGT39WehBSO1WgzQ=;
        b=woqZj6kb1wOyEYXl5kAAv/8qWLmheVXKHql1aX+PDKqgUQzgvPAUDFqeLVALzBG9AJ
         EEsPs1T8xNfe0rsI289Ig/d61w5tp3ZMFSw9Ok/JKjwL1iJJOXiEx/pbACjcnjCcRx5A
         NkLpYRa07hrbZGsGGQEeA0b3DOO9LHWvzjI3r1bdvngPH5Lt83zeme2hcRtLE0Icc8Fa
         38bgRmlYiP6T0mHXH3YKPZjWvtzqbG+FRYgbyM8+MhuwMPkRRX/7C1CZcFl8Oi6AeHKP
         nCoVK0no8Saan30wlR1QusYI9C9gkuv4GzroqJXPNuC9lzHJPW1gJFjG5FnSKLwWHkXW
         pL0A==
X-Gm-Message-State: AOAM531R2Exk3o++/c3Kue6YCk7+jRuLDkys6+W9aXfDW79j/4igPMrd
        WwKpHBhXEeVhj+Av1WZn3GRYCKPDXs7gsRH326RS5wlZbwM=
X-Google-Smtp-Source: ABdhPJxTFtSaEphADyaZrC3fHSPoD2jCLj9MJgYqmbfqzpp1ApK9lENRCw5aqbmmwF8PM1IEsWByk+YB87sXDhurQl4=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr4445740otq.357.1654271382892; Fri, 03
 Jun 2022 08:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz> <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
 <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
In-Reply-To: <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 3 Jun 2022 11:49:31 -0400
Message-ID: <CADnq5_MiQKX4JA-3xbxGYXKHpJqD0Px1NYSiL6yPeTwseoNVGg@mail.gmail.com>
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "Yang, Philip" <Philip.Yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

On Thu, Jun 2, 2022 at 10:22 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Thu, Jun 02, 2022 at 09:58:22AM -0400, Alex Deucher wrote:
> > On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> > > On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> > > > Hello,
> > > >
> > > > while testing 5.19 merge window snapshots (commits babf0bb978e3 and
> > > > 7e284070abe5), I keep getting errors like below. I have not seen them
> > > > with 5.18 final or older.
> > > >
> > > > ------------------------------------------------------------------------
> > > > [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> > > > [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> > > > [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
> > > > [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
> > > > [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
> > > [...]
> > > > [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
> > > > [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> > > > [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
> > > [...]
> > > > ------------------------------------------------------------------------
> > > >
> > > > There does not seem to be any apparent immediate problem with graphics
> > > > but when running commit babf0bb978e3, there seemed to be a noticeable
> > > > lag in some operations, e.g. when moving a window or repainting large
> > > > part of the terminal window in konsole (no idea if it's related).
> > > >
> > > > My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
> > > > I collect to help debugging the issue?
> > >
> > > Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
> > > There seem to be later commits depending on it so I did not test
> > > a revert on top of current mainline.
> > >
> > > I should also mention that most commits tested as "bad" during the
> > > bisect did behave much worse than current mainline (errors starting as
> > > early as with sddm, visibly damaged screen content, sometimes even
> > > crashes). But all of them issued messages similar to those above into
> > > kernel log.
> >
> > Can you verify that the kernel you tested has this patch:
> > https://cgit.freedesktop.org/drm/drm/commit/?id=5be323562c6a699d38430bc068a3fd192be8ed0d
>
> Yes, both of them:
>
> mike@lion:~/work/git/kernel-upstream> git merge-base --is-ancestor 5be323562c6a babf0bb978e3 && echo yes
> yes
>
> (7e284070abe5 is a later mainline snapshot so it also contains
> 5be323562c6a)
>
> But it's likely that commit 5be323562c6a fixed most of the problem and
> only some corner case was left as most bisect steps had many more error
> messages and some even crashed before I was able to even log into KDE.
> Compared to that, the mainline snapshots show much fewer errors, no
> distorted picture and no crash; on the other hand, applications like
> firefox or stellarium seem to trigger the errors quite consistently.

This patch should help:
https://patchwork.freedesktop.org/patch/488258/

Alex

>
> Michal
