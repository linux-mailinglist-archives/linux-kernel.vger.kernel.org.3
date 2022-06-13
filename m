Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F6549F05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiFMU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbiFMU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:27:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353821AD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:13:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10113b4c2b5so7992499fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59iOTb9C5iIFD3pY81jPzaOjRkQpRQo7Lt/w0TkxO48=;
        b=FpxUBD51CiHAKOeGqpklOh5Ow5SvTmTMO8jd405lg8yOJe0EiDFsWNiuthzA3Oa/g3
         sluWIdAdyPqnVga4RvARmofmhsCPBBbcak4wLapAsF5zUM84QuiIJmh5vUOldqtkfs1m
         8V21hczpuTdOAH78l+s6Kh0q3WeoDHkyRMUS6MxTx6g96jzhgpdrVc+peSnx0x0JgaZi
         nF7L1rfk2y9YL3I+9aVIaYD9yXpxsWPY+paqOzcqZw+/l8leT8puUnBnzB0KJSK4PydZ
         YBzFF8wwKWT++DE9TUAC+e1wAJpInCghas4GLkd54Oc7vKgQh3OYuuRqGxdhWi29pZaW
         /GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59iOTb9C5iIFD3pY81jPzaOjRkQpRQo7Lt/w0TkxO48=;
        b=OMjyFQhh3RAvpbQk+lN0wWlFZKp1N2pdbrmvBx6K4QgaBWCnFJTM29fP3bTvUqr+o8
         8RaTJuwMppQf7RzYgUU3rEFnfyoNUwE/6j+k7zYakKPopc26ve6yWfjE4u8ucm4lWImA
         wRqUops2gkn3TuHve7GLO1mw/Bh+MqiwEH7cuEQcRrr5t9PxBGSjN60eSFtPOHJtwJJj
         km0LDc84z+NKOMe4cCRlM6VJ11U50ZrAP7JrmWIO8p2ZEHE3y7SDX4eP3l0Hx1JrSzpp
         hxV9xyYTtVcrsh9hKkeqyN5cSygAKHtqLFjuLuqeDlbln0Z3MgaK8ei+YpGe5P8H7wJ+
         dVMA==
X-Gm-Message-State: AJIora/io/citTlrv5eb+dt0miBuKJeWmeNSLGQAahTZrSX/PUBwChge
        fhEZqm7wZcgFE/qyez4GlG+t2yKRi+cawIx3CunQoVLCCGk=
X-Google-Smtp-Source: AGRyM1s73puJCrtGkUEy5OiKImTYc1ObXO22srAmr077PbyB8Ony740NrQdyXuYC3vrSPHVxdOG1vqVIvms5OkogJ3A=
X-Received: by 2002:a05:6870:d60d:b0:f3:2e4f:4907 with SMTP id
 a13-20020a056870d60d00b000f32e4f4907mr158765oaq.13.1655147594719; Mon, 13 Jun
 2022 12:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613161942.1586791-1-seanjc@google.com> <20220613161942.1586791-2-seanjc@google.com>
In-Reply-To: <20220613161942.1586791-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 13 Jun 2022 12:13:03 -0700
Message-ID: <CALMp9eRBNqPrBMi_XDMMK8HpdoYRUfoe_jSVZAW80wSxWbDJVA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: selftests: Add a missing apostrophe in comment
 to show ownership
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 13, 2022 at 12:01 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Add an apostrophe in a comment about it being the caller's, not callers,
> responsibility to free an object.
>
> Reported-by: Andrew Jones <drjones@redhat.com>
> Fixes: 768e9a61856b ("KVM: selftests: Purge vm+vcpu_id == vcpu silliness")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 39f2f5f1338f..0c550fb0dab2 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1434,7 +1434,7 @@ void vcpu_run_complete_io(struct kvm_vcpu *vcpu)
>  /*
>   * Get the list of guest registers which are supported for
>   * KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.  Returns a kvm_reg_list pointer,
> - * it is the callers responsibility to free the list.
> + * it is the caller's responsibility to free the list.
>   */
Shouldn't that be callers'? Or are you assuming there is only ever
going to be one caller?
