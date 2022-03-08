Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7B4D12F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbiCHI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345327AbiCHI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:58:10 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBE4093C;
        Tue,  8 Mar 2022 00:57:14 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d07ae0b1c0so193571617b3.2;
        Tue, 08 Mar 2022 00:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK29sHNSiDUpGi6NWpneouzbiYPMMI/lcw38UTicG30=;
        b=k9tULQZVjJRu6m8Gq5Ll9kgRhd8tERcdkiY612ekSjVykJ1pir1nn+EkUXAQf2yo/8
         SuFgQYE1KohABiZ5lm9kL22aNtiVl79y86inkIezPvhyujxA1/kJ5Ml+IBxFhquQOcE+
         qY/EDnbwXFiU5oFoyMZmfxd8O/22DXcdE0DdbkcjNbzfqwtlJXzQ15z2kBdBisYGtJSA
         sWwRcN6dFrIqVYHA0sjtAQIMUAEdim0/hfYa1JOE7luM1DcuSRG5+wbl/h6gBYCYemvu
         dDl8ohN9z29uR4PsZTb6F+8Hw9k4Hl+W6ad3uAXlu3gBOlG4CvwthoNxHdD2e6deFWDN
         eo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK29sHNSiDUpGi6NWpneouzbiYPMMI/lcw38UTicG30=;
        b=0wp1YnKjCU3YerV9bUQOYxxBTMpJ8OGSOpeSL0IGUs9WushGwgcnKfraUZIhPEYPtG
         HSxx/Wf+GwMATGEJYtJiPI8l3HOrDuFCX/P6CcIZAJuK5hxxEKIa/hm+fi9igs6b6iOJ
         HOxTySCiV9k+JeeZ2z/oc//8mR5e9IImi4w6MJu9GH6r8q/DExOJY6j9fPCpNGBcDOG/
         Cbju4fUOtrUKBln7sBwGzlddTa4qDwDi+YPp2sMQJ0zwB7Ea8SYHWLjpDj8r1SGLetol
         P+aX6NMpIiYgKFq92RS41amuZrwqveLR40K34T4vIBuVGt7o4nRex8yc9zL3QCl23vHd
         0n3A==
X-Gm-Message-State: AOAM532+2Knh79JFhA7BsSKde4DqTooPW+c4J00L0j163mHef4T4gMZg
        GSrLJADW/m/wZf6R/9MtaIYgdLfNap5xe9hhMtDmH3fTcMU=
X-Google-Smtp-Source: ABdhPJyWO2/gLPPcr09DmRWU8ykPBE0ODoApZfJgeOf03CWqKT9miB+CKa+SGJTe84HgvDk0NMJ6ffq87Ur5CQ2UZjE=
X-Received: by 2002:a81:1887:0:b0:2dc:2425:4dc5 with SMTP id
 129-20020a811887000000b002dc24254dc5mr12059687ywy.335.1646729833187; Tue, 08
 Mar 2022 00:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20220308071827.9453-1-lukas.bulwahn@gmail.com> <87o82gsvqf.fsf@kernel.org>
In-Reply-To: <87o82gsvqf.fsf@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 8 Mar 2022 09:57:02 +0100
Message-ID: <CAKXUXMwhMuUCzATH15GD7was8SkHqcYz-8swTMdE+wuE0yvknQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for QUALCOMM ATHEROS ATH11K
 WIRELESS DRIVER
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
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

On Tue, Mar 8, 2022 at 9:18 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> + linux-wireless
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>
> > Commit dae0978d4174 ("dt: bindings: net: add qcom,ath11k.yaml") obviously
> > adds qcom,ath11k.yaml, but the file entry in MAINTAINERS, added with
> > commit fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and
> > ath11k") then refers to qcom,ath11k.txt.
> >
> > Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> > broken reference.
> >
> > Repair this file reference in QUALCOMM ATHEROS ATH11K WIRELESS DRIVER, and
> > put it in alphabetic order while at it.
> >
> > Fixes: fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and ath11k")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Kalle, please pick this minor non-urgent clean-up patch.
>
> Can you resubmit as v2 and also CC linux-wireless, please? This way I
> can pick this up directly from patchwork.
>

Sure, I just did so, see:

https://lore.kernel.org/linux-wireless/20220308085503.537-1-lukas.bulwahn@gmail.com/

Lukas
