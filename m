Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5734E583D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiCWSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbiCWSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:17:52 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E188B35
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:16:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h63so2676894iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nMqxdIZgJ4df2glO3AXxvZM8Vb5idq1c8Jw7C91a7Vc=;
        b=p43R9GLwlW8RzbEXi8zCiRwYsoq1VH3VbGU7vQ8dDRiLQNTTwvSxVUgbRv97gty1nU
         gBWq8BpTOJl3argEvXZePHDxsmy1SR8wOHYa9Mc5QC84mXyij9bggiFnh6GG7MsGhONZ
         DWNUl/8mdwnRLkc+0BskLlHPtksxf9odD3frJghi5DKJtnnybDhNTpCAsjT7VOiEkeT6
         OSN407EU7F9qBwpdyBSK/G+TqEHrtUeM9w1btYhMRm4bDdhtf6x+t0PuNcoEwqZO8NmB
         0ND+M4SL+uaZW51ehTiehp0P+GScV8fbrdXwb5riFHisJTGltXQTF35BvRNfbvcmrGdc
         BcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMqxdIZgJ4df2glO3AXxvZM8Vb5idq1c8Jw7C91a7Vc=;
        b=VcDzGGoprqJw7V5T5UYXdDGyZUCZAMFrp2GH0cN3gQ++7dTv9TYR2WdflzEGYQQouW
         ut6YrRgTOsbs6axm4Si9H9x28MbKQ/hOvklY8r6xZf7WRk1nc6Eo1tokrV74BwdiiB8D
         wJbDUyM0cQ2HVFCrLC25O8lzf8QOnb3vKYaQG0hrGlPxtjn0RZyLKjy0rPLppvV2zWbA
         BfOof2Hx4BzmzBZxJQAR0oLOxI1jH6oSFAnwSseA4zAOHiLDGt/4/NMv5ougYsYOM8eL
         90+FWxEu0pe7BuZWNuOUh5IA9KqYVaFxahUV8lqplsxSJe6+Gmy3ekcUzF/w2KzL+NoQ
         jG/A==
X-Gm-Message-State: AOAM530aeHDJEXFL9nqjkit1jL62ztvR07vO9pGY+32HAjXhelIBwrvD
        2390EviKaK1pYnN5PbNYhS6N3g==
X-Google-Smtp-Source: ABdhPJz21mhhHYj2VEdsCwKHh095WxTo6GZp1tVD+4wVhwAzkpj23tCt6tZvUXBt2e4Xi/BR9V8V6A==
X-Received: by 2002:a05:6638:328f:b0:31a:12ca:b4d3 with SMTP id f15-20020a056638328f00b0031a12cab4d3mr610421jav.19.1648059382139;
        Wed, 23 Mar 2022 11:16:22 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id f9-20020a5ec709000000b00645ec64112asm279808iop.42.2022.03.23.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:16:21 -0700 (PDT)
Date:   Wed, 23 Mar 2022 18:16:18 +0000
From:   Oliver Upton <oupton@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, jmattson@google.com
Subject: Re: [PATCH 3/3] Documentation: KVM: add API issues section
Message-ID: <Yjtj8qESPWIL221r@google.com>
References: <20220322110712.222449-1-pbonzini@redhat.com>
 <20220322110712.222449-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322110712.222449-4-pbonzini@redhat.com>
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

Hi Paolo,

On Tue, Mar 22, 2022 at 12:07:12PM +0100, Paolo Bonzini wrote:
> Add a section to document all the different ways in which the KVM API sucks.
> 
> I am sure there are way more, give people a place to vent so that userspace
> authors are aware.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Do you think we should vent about our mistakes inline with the
descriptions of the corresponding UAPI? One example that comes to mind
is ARM's CNTV_CVAL_EL0/CNTVCT_EL0 mixup, which is mentioned in 4.68
'KVM_SET_ONE_REG'. That, of course, doesn't cover the
previously-undocumented bits of UAPI that are problematic :)

If we go that route we likely should have a good format for documenting
the ugliness.

--
Thanks,
Oliver
