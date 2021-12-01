Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A546522A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350990AbhLAP6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350623AbhLAP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:58:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F289C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:54:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u3so64126949lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvTtuysyQCI1n/oqJGGYBcob/YefOLkNXx9pXmlLQOU=;
        b=gGZyz8AEbKWulwrqym0HTU3OkuaPPJtecaG0GD22vJz5yqjmk8O1rH6zvW9beeVKOS
         racMMC7dIuXCxv7ctrnhYX6h+lRWfi+zDnT1T+zc9pFunu9oVEZW2EvCIK8H4iOsdvDH
         Up+O5jipF4CbMTV17o6prZM33ewJ5Da0tMnb+1u21UqzmPOykb8Ek8rNtthP+ni6G4iT
         e40mET9MAfIhL79MFv6X40Z349akKQz9uBLx6qQuUZyPqhNtUd+xiGefq1ga3xBQ+Tuc
         w3v3imPwF9oiyOvx+pMTU33nL4lngBOouZ5j25Uotf9wGWyuosDB5MfY37NVezmODNGj
         ujXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvTtuysyQCI1n/oqJGGYBcob/YefOLkNXx9pXmlLQOU=;
        b=10JU0XN1fL8fChMJXmfcFYC+tjyMjhwbYq0JdawkMwq85YWd62g+/N+hg3B1EwMY0J
         u5nJWxmQNE9zLCvk7vzQGw2H/USZFJEg8FZq+fzn5kIq2PophfsXOOAlB4/Q90lEeEf/
         XHe4kHdbn0POBDEsqCHCkoTjAw5UdqmgCX0g2wbgVVHWTbB0PeISKmnWpcmOs8TDdElg
         y0Xaqfq03j0ydsyXn5G8poUjEbZcsXmGGfXzlLCD66HkcTpJ3Y058NjENiDsCvW+qBUG
         HoXaxOFSJ4U1n5jVnV4bPDJURb/p+yPiZydpUuSHEc3K2eJ+vfITDbVFq1a9IjgxqYyU
         RY0w==
X-Gm-Message-State: AOAM531rPSqCNLuM4K8yHSGaXdHTMeUqWx3eCXVvN+t7/83NFY6b9R3H
        Rphy8t8kQR/MR3T7oT/kuL+2DvCmID6R6k/TGXeVnw==
X-Google-Smtp-Source: ABdhPJy9YLJEVJOb1DOptKyECwI0us301AsNtFEhmcHCSxbXMpdayiHW+iyIukMr7Ch0XyJto2ma0t12zErJ9jQ32ps=
X-Received: by 2002:ac2:4ad9:: with SMTP id m25mr6757568lfp.193.1638374080289;
 Wed, 01 Dec 2021 07:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20211123005036.2954379-1-pbonzini@redhat.com> <20211123005036.2954379-3-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-3-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 1 Dec 2021 08:54:28 -0700
Message-ID: <CAMkAt6p_9YR05T3TQH4abzAKXX3y_H46R60JZ2Qb_9idV5m1qg@mail.gmail.com>
Subject: Re: [PATCH 02/12] selftests: sev_migrate_tests: free all VMs
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 5:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Ensure that the ASID are freed promptly, which becomes more important
> when more tests are added to this file.
>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
