Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46E51035B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353011AbiDZQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiDZQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:35:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561E162F22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:32:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so30696720plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/NlyrwMxtolMXHV1jKHCNolBa6c0JPcJUiJC0fHHwyo=;
        b=oRTgRqNLQLdGmC/vIsJUtfcsLymzJ+vCHOZE2gJfczFDxYv6cOV60k6Eb280jWs5qf
         ARtFaHaYjqz0AEgxzRW/3Sobx9OgVKwYJUjOp1etHEKP/4mHz8dujJGhADpF3IiH0uv/
         Hy+2iCf+WGUerpS3agjXKbidEtcGmJlyhRImbn4ie3wdtPEh/kLSj/26Rn6jA92A+irc
         fOj/W9dc2mRdyVRo973xChyewkHid53l4gY0pl0MdwWMWvJetKTQrmCNKSbJb/GlLUjO
         NfoJC3pGBnbnn7h0K1t2zl21l1RHX12KxsETA9Gg3FIkcHek+RGoxA9E5J1BHFzF+r8V
         BVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/NlyrwMxtolMXHV1jKHCNolBa6c0JPcJUiJC0fHHwyo=;
        b=66jbGjCYRrd2p+LdfMuxQqqYiEWtuShhTYjo8CU28g3oqYof6shIK1ttTYR2YZsCgT
         aU4M39jMW+EbU/gAMUFazCtKG04vIJpGAzlr+YDXOErByy2ynKI6rt66QdPWm2qqgLH4
         rJLd8odyzwg8Dm4b6eTiBtEsDuRrSwj44pOcSQagLiAcshS+HTJpZ8Ena/byi468vNAy
         dzefM3rdfM3tNL1ykdyOEhMUMbJ5vICIpydkCMwtia3X/bk3JF+JIrPRDAS286p5SsPa
         JI4uNn7OQ4xzJv4Ig/I4/bwOOg2YVKujLi0D5LrS42TbUQZCpUhYUPMwIlnhjHJvzzv1
         wp4Q==
X-Gm-Message-State: AOAM531kMg5VcEF961/0ImmiuzZPYeASxOOYap37+yDoqL+ilQt+wMKS
        aMo2ZSQ0Uc9ZKvZg2z9p+aHl49fozUgrUEocMk7Thd6F5nw=
X-Google-Smtp-Source: ABdhPJwSgW6gKNkX957XGHoDPtgjefZ/jUmgZRfD5egWhIWssKZoy3ELfffLYm2MaRfwNaTalzKDWgXTxUfDKGjSbRQ=
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id
 lx1-20020a17090b4b0100b001d2abf5c83fmr27420103pjb.93.1650990755372; Tue, 26
 Apr 2022 09:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220426123839.GF163591@kunlun.suse.cz> <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
 <20220426161435.GH163591@kunlun.suse.cz>
In-Reply-To: <20220426161435.GH163591@kunlun.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 09:32:24 -0700
Message-ID: <CAPcyv4iG4L3rA3eX-H=6nVkwhO2FGqDCbQHB2Lv_gLb+jy3+bw@mail.gmail.com>
Subject: Re: ndctl tests usable?
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:15 AM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> On Tue, Apr 26, 2022 at 08:51:25AM -0700, Dan Williams wrote:
> > On Tue, Apr 26, 2022 at 5:39 AM Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > >
> > > Hello,
> > >
> > > there is some testsuite included with ndctl, and when following the
> > > instructions to build it most tests fail or are skipped:
> > >
> > > [   95s] Ok:                 3
> > > [   95s] Expected Fail:      0
> > > [   95s] Fail:               5
> > > [   95s] Unexpected Pass:    0
> > > [   95s] Skipped:            15
> > > [   95s] Timeout:            0
> > >
> > > Is this the expected outcome or is this a problem with the ndctl buil=
d?
> > >
> > > Attaching test run log.
> >
> > I see a few missing prerequisites:
> >
> > [   78s] /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh: line
> > 64: mkfs.ext4: command not found
> > [   95s] /usr/src/packages/BUILD/ndctl-73/test/security.sh: line 25:
> > jq: command not found
>
> Indeed, with those installed I get much more tests passing:
>
> [  148s] Ok:                 13
> [  148s] Expected Fail:      0
> [  148s] Fail:               4
> [  148s] Unexpected Pass:    0
> [  148s] Skipped:            6
> [  148s] Timeout:            0
>
> >
> > This report:
> >
> > [   51s]  1/23 ndctl:ndctl / libndctl               SKIP
> > 0.02s   exit status 77
> >
> > ...seems to indicate that the nfit_test modules did not appear to load
> > correctly. I never expected that the nfit_test modules would be
> > redistributable, so I was surprised to see them being installed by an
> > actual package "nfit_test-kmp-default-0_k5.17.4_1-6.1". The reason
> > they are not redistributable is because they require replacing the
> > production build of the kernel provided modules libnvdimm.ko,
> > nd_pmem.ko, etc... What I expect is happening is that the production
> > version of libnvdimm.ko is already loaded (or is the only one on the
>
> AFAICT neither is the case, that's why I dump the module information in
> the log.

The modinfo just tells you what modules are available, but it does not
necessarily indicate which modules are actively loaded in the system
which is what ndctl_test_init() validates.
