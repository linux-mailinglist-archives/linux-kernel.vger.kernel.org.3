Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776FC591654
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiHLUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:31:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7998580
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:31:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so1684643pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=VQTwmgbULdrb/KYHoxgQ4q38dOU+h7WsozErL3JrEuw=;
        b=X703rBkC0IpOWzSdmX19HRJnHxncorPjeyOlJcX7XiqrCAwAqMqLdQ+LGcEvvDEXXP
         LRGN86VIyhtMLGcrESY4Ct+LGaKzvaqTRZluZaKAuphqLii+4WFeTB5vsTvBsMvpGAkY
         QXHRTY1//Qu2UnWttyUX2mcOW0RGCWNYXEv7eHTgDXtyhh9F5pa8asIAktebOlHYkpug
         h6ZBgJMH1SlEkz93X8zs6oqaZHCB4qn3sZ1V9rIFijM0SyZpDB4SwUTaSBZlEKP6xc2J
         k/jcyc59NdVQJw9iJshUbK5sbozNGe1EpA0PizlXesUeLKGXnVbGMgfGFLisbTf31+BZ
         YweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=VQTwmgbULdrb/KYHoxgQ4q38dOU+h7WsozErL3JrEuw=;
        b=vllcOIriorMsjgtSOLDiZUjRHCyrid5vawxkLgO6EN42KeKHwaAITFzPxhcc5PmC4C
         4b2QAhhUl7LQ3VEWySf08I0/wfMyA8DsDgveIbdplP3e8BdDneMYC7Ge9ubqTttLEiZ3
         8GhKR0Rls0lPRshU/nXjmzgNNFagSEBr1S6oHv0hKw35rt+D+Ju4gHyMv+4LxKM8VUqD
         pFAnAwEqnXkS9K42X5bv5531rmaJaXlkZe08lsBLsNrUO9+Quf68k7O13IFHx9haZyic
         1ClkTZHYUS9orO7pCRleG4mQtD35nbSWXlIoRUpzHYWxO3z2AvQ6E2Pv9+7QkJo0oJV9
         XKng==
X-Gm-Message-State: ACgBeo1AvxNX3vMMXKfS1oAvzwWCWR50XR9Xi4Lt+SDoOPgTSkd1SRRZ
        hKT98N6eZpfUJ3gqMlRqPvsuM7sIDuY=
X-Google-Smtp-Source: AA6agR6qCqB6ar2BvdhYE1UpaOUZa1ZEXPztDmeiWKjfV6e0r8jXmpLjHrMIjHHDJhTwIj3RMy0UCg==
X-Received: by 2002:a05:6a00:23c1:b0:52e:28f5:4e13 with SMTP id g1-20020a056a0023c100b0052e28f54e13mr5492191pfc.20.1660336261014;
        Fri, 12 Aug 2022 13:31:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:aae])
        by smtp.gmail.com with ESMTPSA id z127-20020a623385000000b0052d432b4cc0sm2031289pfz.33.2022.08.12.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:31:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 12 Aug 2022 10:30:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Selecting CPUs for queuing work on
Message-ID: <Yva4g3V2jAP0NKcY@slm.duckdns.org>
References: <82233e68-106f-39e9-b20d-7794eb7a8933@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82233e68-106f-39e9-b20d-7794eb7a8933@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 04:26:47PM -0400, Felix Kuehling wrote:
> Hi workqueue maintainers,
> 
> In the KFD (amdgpu) driver we found a need to schedule bottom half interrupt
> handlers on CPU cores different from the one where the top-half interrupt
> handler runs to avoid the interrupt handler stalling the bottom half in
> extreme scenarios. See my latest patch that tries to use a different
> hyperthread on the same CPU core, or falls back to a different core in the
> same NUMA node if that fails:
> https://lore.kernel.org/all/20220811190433.1213179-1-Felix.Kuehling@amd.com/
> 
> Dave pointed out that the driver may not be the best place to implement such
> logic and suggested that we should have an abstraction, maybe in the
> workqueue code. Do you feel this is something that could or should be
> provided by the core workqueue code? Or maybe some other place?

I'm not necessarily against it. I guess it can be a flag on an unbound wq.
Do the interrupts move across different CPUs tho? ie. why does this need to
be a dynamic decision?

Thanks.

-- 
tejun
