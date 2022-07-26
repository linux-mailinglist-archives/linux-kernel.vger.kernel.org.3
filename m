Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5F58145E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiGZNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGZNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:44:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42A1F2EA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:44:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so20206286wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQ8s3zPZY+TFJkH6m+UUXWT+JWabae4Qo2BwG+X/dtA=;
        b=EqK8sgogR79mEUl/YeNrDUb+Y+dW6RBsh5xIg9wH0CgvvZYyLVjTlNRJGmwxL4Qt4s
         oS/ENaOx+3r7jBOIFOAIfdQlx46fKBlSTCLJWU1bDpG4zIJKTORp/+HSufNT/Y/j8VK+
         ZH87Q+MvYZljijN8hSiGm1/CrfjsOK/IUfQf2t0+R4y7abiYDBwxd3tU2ZkaOwfV9uPq
         TrLBsqYaB/L+lwIl9+M5bZhtBbaD9xXN93M5ShyeuaQBlsh/IZsks6QQLQfkmkJIhKYx
         GXjFNpIbZ3kZO1B33eOJDV6XX543AKvZvW43VUR985vMQ5a2lOrgk0si1ciUtMw1IzQo
         Tbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQ8s3zPZY+TFJkH6m+UUXWT+JWabae4Qo2BwG+X/dtA=;
        b=YYuoqm3rZVdB2fhHDwFOULHeBbwaOawduDRm8P4C5TybOTBhP3jXdS9a15TzqKCKX6
         f1/T2UeYL/yEfR6PKZ9H5g5v27hQXGL2jQzEio3khvsvoexVpsugj5b2U65qhS5ppmCu
         1MzI7i77S6I5OR1c+vaHki33RlT/A2tGasy5IEqbjeh5hD3m9kfyEqMLwa0aBjvsePke
         CEs3pzsq+5XitQlh6ee4zING0pqPak9eNuhiAjFJSmz6GZd/gZeHUK7uSeyRFa/fEBwM
         BG9icOASGliGr7jjd0H97JDs8dz1jrXSBGDlMSdTv+y12QX6hQV5kbyYrgrn/aHj5E2z
         uRRg==
X-Gm-Message-State: AJIora9nO0JZKypBbNWAXdXF/uUfQrjdZgioLPa8BgD7LwxLOcwIkbhN
        mDPDda/9bvLPvoxGXOJfl2HGB3RJn33lDXDPD0ChYLkAoCc=
X-Google-Smtp-Source: AGRyM1sWnAdjWjvz1F29mMNoTK0f/PXmP4buefrfmWkMl0uYgx1rCpW/MGp5I+wz+UW9+gcrqT8oEK0KQ5TKu590ONA=
X-Received: by 2002:adf:ee4b:0:b0:21e:8e1a:8f3c with SMTP id
 w11-20020adfee4b000000b0021e8e1a8f3cmr5314211wro.346.1658843046640; Tue, 26
 Jul 2022 06:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220620115549.1529597-1-apatel@ventanamicro.com>
 <CAAhSdy0mHbxQ3QVP9j1==oTG75Z9_T2bDSif-UGKppG+-hoJng@mail.gmail.com> <659c6aa4-1100-0945-4965-3e106dfd490f@microchip.com>
In-Reply-To: <659c6aa4-1100-0945-4965-3e106dfd490f@microchip.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Jul 2022 19:13:52 +0530
Message-ID: <CAAhSdy0XwTsQ+dgYatqf6BvGmcGwz_bzmdV5fNeF8oY3rK6dDg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Conor.Dooley@microchip.com
Cc:     palmer@dabbelt.com, apatel@ventanamicro.com, arnd@arndb.de,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        heinrich.schuchardt@canonical.com, atishp@atishpatra.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 7:10 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey Anup,
>
> On 26/07/2022 12:57, Anup Patel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Hi Palmer,
> >
> > On Mon, Jun 20, 2022 at 5:26 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >>
> >> Identifying the underlying RISC-V implementation can be important
> >> for some of the user space applications. For example, the perf tool
> >> uses arch specific CPU implementation id (i.e. CPUID) to select a
> >> JSON file describing custom perf events on a CPU.
> >>
> >> Currently, there is no way to identify RISC-V implementation so we
> >> add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
> >>
> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > Can this patch be considered for 5.20 ?
>
> iirc I mentioned the consistency of using defined() for
> CONFIG_RISCV_SBI versus IS_ENABLED() elsewhere in arch/riscv/
> but I don't recall a response.

Sorry, I missed your comment. I will address and send v2 soon.

Regards,
Anup

>
> Thanks,
> Conor.
