Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC414E5702
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbiCWRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiCWRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:01:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB175E5E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:00:08 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-dacc470e03so2296147fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV0oSDRHiJymPDNvAXTxfZzTo2VZe2I/axS41WuuY70=;
        b=my1cWR6Rh+0RcmMEq5FG5TrEo8BEnU6rdhNBXANAIK6yfOazwVLY6RVDsfMz/jEDR7
         dTE8pfntIyxgjNmfEyNQsw+BYPWGgvVSycJALr7Wn7ANAefOYSOEXK/Te+RfwLCRJSZY
         WQWNODMAPr2VcdpOsW6IlRLG3BNf2oCb1XvUbj2J0HelpY1uA0IaXigrVjBraUtzGm7s
         8TCb8JfCyChDlrCRsL+pAjfGYzCHZ8rHBrTIuaQ3h2holgRggK5dJeSQ8KQni9PZ6WAh
         hLMmL6ZNDVor0PzvNLvBtFeUXpCaB7UnN9TI+SkpvnYz2uJ8v5ciGRxdCvTdQYyGkQ/1
         5org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV0oSDRHiJymPDNvAXTxfZzTo2VZe2I/axS41WuuY70=;
        b=7W9Rl79ujYYbt5SwjL7IFnYHk9P8q/heDtHbzjUdMvoIwzSPDZh713rsZhTFUgbkut
         ldzEQfNdNNdqHC43dOeM3RRr+UtGqW0wGSDEFFP1HnzQ+ejfWM9ViEIFfIj4B0Hc+WFG
         DAqEyMTCKPf7kEzvqA1di+LosepSEEc9njzkHrgHBpMFWrqHESgwgZhjBee1W8nd6ZBE
         6PdlmIeFS8FVtadVgWMBU2VgadmExiGTw7fYKDdZH4SgtmlcGFrVaY1sRtupe1Iu3qcr
         FByqikkym0L1kE4RvElTn5sAxWqBiOCQI0V68vPpOdNDFaHn0+lybvWT4KogfGG54r+/
         /tog==
X-Gm-Message-State: AOAM532ccgaVCXlgd4Uj+y/fzJcY89/88wGNiWqefqgxN5Vj6yp2G8Hp
        wwoF+hPjPm1izpx9B0aI4EpChqz94PsR57QzfEiqiA==
X-Google-Smtp-Source: ABdhPJx6iz/VgCAnesCKx9zB4V3pMwqq+DIGns58a7UjyjhWqSQ+fo15VfZN9YVoFiwEcDe9r+ZQpZ3NO5bQ3inmHiA=
X-Received: by 2002:a05:6870:15c9:b0:dd:e6db:cfce with SMTP id
 k9-20020a05687015c900b000dde6dbcfcemr3824760oad.269.1648054806252; Wed, 23
 Mar 2022 10:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220322110712.222449-1-pbonzini@redhat.com> <20220322110712.222449-3-pbonzini@redhat.com>
In-Reply-To: <20220322110712.222449-3-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Mar 2022 09:59:55 -0700
Message-ID: <CALMp9eS0_BXC2J26umCOqQS6mbZn-QKQqYzFcON5rrEBbebbvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: KVM: add virtual CPU errata documentation
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 4:07 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add a file to document all the different ways in which the virtual CPU
> emulation is imperfect.  Include an example to show how to document
> such errata.
This is fantastic. Thank you. Along these lines, I wonder if we should
come up with a mechanism a la IA32_ARCH_CAPABILITIES (or AMD's OSVW
MSRs) for declaring fixed errata.

For example, today, KVM ignores the guest-only and host-only bits in
PerfEvtSel MSRs, but I can't imagine we're going to do that forever.

Reviewed-by: Jim Mattson <jmattson@google.com>
