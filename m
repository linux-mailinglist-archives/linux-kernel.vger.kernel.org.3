Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2017547194A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhLLIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 03:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLLIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:22:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD280C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:22:29 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id t34so12521694qtc.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGZm6oLGnHlXqEkpuqXY+nk6rx5wsHGt4WqK0qppTmI=;
        b=V6cup3NedoozAjudvZiQMedq9Utdpnu5iNawFsGKvDlpi/+eYPP3JRby5GgZsZ2hCA
         ahm8ErWq7m3KFdDBdeAjpMkDxTWlwfDDKcpvj5UV4H8iSHxC6lHXWzR3LTTafCa5c8eq
         rEPi8mSUNJVYCpQC+77nwxRm3VxwsCy+xHvJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGZm6oLGnHlXqEkpuqXY+nk6rx5wsHGt4WqK0qppTmI=;
        b=X/2RDz08xjtu7Ates9/wfizVT1xnAF4wWzVVq9mIDE4mn6WQ9hnossvSptN76BdIrP
         2+T21dK1MTlhz3kGLKUgOtBh/wtvjM8iwov3DzDW+kkOPzJBcTvam140bfwHs6hJ0Fbl
         A4JPVb30hg/Afp27lOxc5BhLmz8XyvNnftU4iVPjzRD3IrWqgbgCjNV6WgVC+26ETtmF
         svTxEGKwRMkDVAQFVs/QWrtgLdtk3VmP745xgVdBdy8UjKarZzQxna8LP2Ud+HRvy1lI
         5yF0tVBuhDQ1HQSKuJPUd7p9vKtn3ocEueCMK4F/lKJQbNh4tf4GKX0qFQRQ2I0wEy3B
         CJwA==
X-Gm-Message-State: AOAM5307FGO2v4urFxVIi0qBNo7FDVwuIvSzoOU85o8yRbBRwC1dPzBE
        jBTSqsIZ5RVMMVnl8kvPeeD1eC2WyQ0QFy7fxNsqnwjVASN+aLXx
X-Google-Smtp-Source: ABdhPJx6ygdJgpLm8HFi7GSD79ZRXs4ZAcEo0yegSLOCwIqHuUQhft7VG5JGN7bpYjyjqYXrqPK4xxM+c/V8lcTyyUM=
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr38613464qtd.469.1639297348468;
 Sun, 12 Dec 2021 00:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20211212033347.67921-1-wangborong@cdjrlc.com> <2b0b6412-7ab9-de8e-6f22-253eb039191d@gmail.com>
In-Reply-To: <2b0b6412-7ab9-de8e-6f22-253eb039191d@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Sun, 12 Dec 2021 00:22:17 -0800
Message-ID: <CAGt4E5uV+3p+9MGvtxEgWVRPJR-kPr4TOZWQvafx96RaoLPiXQ@mail.gmail.com>
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix typo in a comment
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 at 19:45, Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 12/11/2021 7:33 PM, Jason Wang wrote:
> > The double `to' in the comment in line 427 is repeated. Remove it
> > from the comment.
> >
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Markus Mayer <mmayer@broadcom.com>
