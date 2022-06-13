Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A71549F99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiFMUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiFMUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:39:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BADEF7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:32:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s135so6419654pgs.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQcoIbY+k5u/47x4DTLCPrPlYj59eP/DTtY4Ztx/xXg=;
        b=A5bzrEVcQjAh2IkY9mih2H3zovmG9LwqSLp7yMagSi3STXs7bejz80SmKisAvgS2Cv
         Ki+N/pknAwhIt1aa1r3eH1zp7lX7ceSp3jWvNDege0n2AZ3xgxflVXVe6EpTEwIQ+F3C
         JEYgGsIX6dBRFXkMrZoLBdJtGfawm1YoIgj74BweX/+YXB6ZCbqDF8cq4XBXNVG0H0ZL
         alCCfYyoOuDQ2CsMWqB1wRQQxUizRds0e9Tm/6x/K/tPo+rJqFM+xImKT5G440g50/Io
         61zgaQPcowi43QW4k1dc/Z3LvEPwd+f+X6+hO0QhJQF4ROtniVfULZzFsrjb2RxnJyJp
         nfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQcoIbY+k5u/47x4DTLCPrPlYj59eP/DTtY4Ztx/xXg=;
        b=YWY0ugIjpaQPvDWrt/1x8RpYgn0gs2koaUBtmqNpjqvJVHEATdlhF7jiWhux6IHHR8
         UNu/58rZEieMHQYqr7fn0Zjd6aKbTNo3+R57spvdojqfQ9/3VcbrAQPvHXCwqJpXD0D6
         jAdbL9KmCj3p85PrIj6GN10MqSBEgKmbiIPfYBzhxEVgZxCqVOsX2sb8y1UkZC05zAhK
         G5dLs0oDiewds7r+RL/knhu/wCEDiO5NHnWVgrCMOK7AASB+8VtqW0rH2zC2R3OC8eVQ
         xbipNP4030JjtIeSjYSDYJ85Z0UUCdKP2ntwldwaPhWXWMvCh8g3xjn1SOqC3OqEexbl
         jq6A==
X-Gm-Message-State: AOAM531mty7Y9berRUP4wgZdpedDCF0r75BrYqWg8NTxSuO6qXd546PF
        3FpACvIYWWGO83F22HtIQkrQww==
X-Google-Smtp-Source: ABdhPJzFIbd90FydWyiB2L/AazuxBpWyBSjyk5m+JnqapOQSbBlo6DITwJJwiXtiH4AUBAHZLPT9ng==
X-Received: by 2002:a05:6a00:218c:b0:51c:c64:3f6a with SMTP id h12-20020a056a00218c00b0051c0c643f6amr527443pfi.50.1655148747928;
        Mon, 13 Jun 2022 12:32:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q138-20020a632a90000000b003c6a71b2ab7sm5935469pgq.46.2022.06.13.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:32:27 -0700 (PDT)
Date:   Mon, 13 Jun 2022 19:32:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: selftests: Add a missing apostrophe in comment
 to show ownership
Message-ID: <YqeQx2fbdVVnRcxS@google.com>
References: <20220613161942.1586791-1-seanjc@google.com>
 <20220613161942.1586791-2-seanjc@google.com>
 <CALMp9eRBNqPrBMi_XDMMK8HpdoYRUfoe_jSVZAW80wSxWbDJVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRBNqPrBMi_XDMMK8HpdoYRUfoe_jSVZAW80wSxWbDJVA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022, Jim Mattson wrote:
> On Mon, Jun 13, 2022 at 12:01 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Add an apostrophe in a comment about it being the caller's, not callers,
> > responsibility to free an object.
> >
> > Reported-by: Andrew Jones <drjones@redhat.com>
> > Fixes: 768e9a61856b ("KVM: selftests: Purge vm+vcpu_id == vcpu silliness")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 39f2f5f1338f..0c550fb0dab2 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1434,7 +1434,7 @@ void vcpu_run_complete_io(struct kvm_vcpu *vcpu)
> >  /*
> >   * Get the list of guest registers which are supported for
> >   * KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.  Returns a kvm_reg_list pointer,
> > - * it is the callers responsibility to free the list.
> > + * it is the caller's responsibility to free the list.
> >   */
> Shouldn't that be callers'? Or are you assuming there is only ever
> going to be one caller?

No?  Regardless of the number of users of the function, for any given invocation
and allocation, there is exactly one caller.
