Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF74E5CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347129AbiCXBRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiCXBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:17:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C992332
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:15:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h63so3803055iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3eskjEc/QTrEtiTQAsNWMH7sh9g2uOi0boElmWN8Nw=;
        b=rkAfy1Vo/25ZZL9cLvSrPTrqVh7oMaToZ2hi6TEAY1kq98EDsuWajVObyirTn5bzTw
         5P2yWOKzm7dUWBfx4ZrG2iUDJsYazG4tbNdL4EuanrPllwCjJK4EpzVT2ha7b8yQ4lrc
         vi+f85MkwKtnicJOU4CyarwDSDnfeGIbvla7t6N+FKHFyWAjg0wgntd9lNVl59zdkI5c
         1gy7Qzd5G0RkS+tPcb2Eco7NmOvUy3TepIc+uGQO84YzyjgjLh4QO8Uq5C5c2a3hMPCc
         EY7XObU9MYvWh3o37Hag62nE7eGzfW7WG0hJpYkJuPUtCHQ0T+iUjSoZLoU+vbI/MBCR
         vk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3eskjEc/QTrEtiTQAsNWMH7sh9g2uOi0boElmWN8Nw=;
        b=hAqiLrzRy93oJk8LKMyVFy76G1VeK52qqyPXo1W3A70h9TUX3iMf1a6APXy8H6tiVk
         DTyFdGVJLUox0ktdv2tpvY4Q0nFHjFUpNdtMhyaWrxY7iXUBB/r1r0tQXGHgp5Ml9me7
         8JL/nGTJTeszEdUX0hQTbzZqme/FaFzXyXZnKNlF/41UtzuA+QLNlYjT3v57mfhLrs2m
         mkG3k/4K0RltxZLmeqxmqb8cqxNlNMkrhy3E4cOzjv9i6652VYktMIUy8hz2Mmwuw8HQ
         jiM6dHNIH30EHP9OEjAiEgdB0LEIdFUSYU0ZEBjMaw0k9SZeAKREc5if0gbWcSiX9JPb
         p0vQ==
X-Gm-Message-State: AOAM5311CiCrEG9f7UNkmv26eqIBLererwSan0opZ75uPnUd6dGhtdbM
        vQBlYVmdyAgmatTGSRDWX8y4P2RxnwSWNw==
X-Google-Smtp-Source: ABdhPJxa6RFFGKKY16VYQtazOWfGWpWQr6Y/g04mS57LUFavYz5qZREvFeqEZZ81c//KyV+QEIu+zQ==
X-Received: by 2002:a05:6638:2217:b0:31a:1fa6:cc97 with SMTP id l23-20020a056638221700b0031a1fa6cc97mr1529147jas.294.1648084543170;
        Wed, 23 Mar 2022 18:15:43 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm785969iog.15.2022.03.23.18.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 18:15:42 -0700 (PDT)
Date:   Thu, 24 Mar 2022 01:15:39 +0000
From:   Oliver Upton <oupton@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, jmattson@google.com
Subject: Re: [PATCH 3/3] Documentation: KVM: add API issues section
Message-ID: <YjvGO0Q8DEeR52i4@google.com>
References: <20220322110712.222449-1-pbonzini@redhat.com>
 <20220322110712.222449-4-pbonzini@redhat.com>
 <Yjtj8qESPWIL221r@google.com>
 <a35f9408-9d54-654c-6639-64192f03ba3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35f9408-9d54-654c-6639-64192f03ba3b@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:32:50PM +0100, Paolo Bonzini wrote:
> On 3/23/22 19:16, Oliver Upton wrote:
> > Do you think we should vent about our mistakes inline with the
> > descriptions of the corresponding UAPI? One example that comes to mind
> > is ARM's CNTV_CVAL_EL0/CNTVCT_EL0 mixup, which is mentioned in 4.68
> > 'KVM_SET_ONE_REG'. That, of course, doesn't cover the
> > previously-undocumented bits of UAPI that are problematic:)
> 
> It depends.  My intention was to use this document more for hidden
> interdependencies, in this case between KVM_GET_SUPPORTED_CPUID and
> KVM_CREATE_IRQCHIP, KVM_ENABLE_CAP(KVM_CAP_IRQCHIP_SPLIT),
> KVM_CAP_TSC_DEADLINE_TIMER.

Ah good point. I agree bad cross interactions need to be called out
separately.

Thanks!

--
Oliver
