Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E879348E436
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiANGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiANGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:24:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7666C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:24:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hv15so12544333pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efD7MXnSTwwB5xVjXzKnpMf87tT71yAx/cljfnEhNas=;
        b=VGerjJAK8GzUatgIVU0a+8oCQmLsZwZaA+xK/n8dg9nnhsCwi/cLvyukvffHwbq4lD
         KUfhzEQDfHJ3FYQFDjf3LmONir9tuCFjuR8y8YaMKZaXGG7AkFWUIkVcXQmn/4eRmCng
         jm6TqwihJHpnT5w4Rtz9yeYnmgsj/596lDOnlOI5WxnBOLAY+Dn/CUdUt//Oqn89O9xX
         5K5aNFzbE9ndV89wLtwYSCJIyuPEKzB5JZcATTObSRZ0LF2ryCXr9GwRsphLbHwK1Dz5
         mFl0gV7bAhaYxQp4RtohXeS+M/y0JGauajd/X3ewewRMHVIMEvFdPOX5lWBO5GSl2h6k
         3+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efD7MXnSTwwB5xVjXzKnpMf87tT71yAx/cljfnEhNas=;
        b=xw7hi+ZgasRtgpx0rC7gmvv3OEmrZ8UY11u2EcANLP763VZVUwaPR1aVP3C2yEy6fO
         Ji+VWtDatqrvVOHbAmnjxj/4ODGNNXVRIXEjxAlUpoP4CR8qMQoLQY6L7D6GoBnYkaDN
         8qiTrUwOXjtxMdB9E+DfQR60FZFkTCX1jkpGel3e7L3FrhhsMPNasGipmRIxjkn1WlwM
         dnmEgu7vzyMopuN/l9p6XNom9LJta3xqg4Wr5qAPO+8DqtXGifpUzI9xoOUoYqoegB6i
         Vkt/9PG037ir/K+86M2FXPIvvoLgOc//Q9hpXMVJE1Y4J+S2YKhW6+DEEOw6sF+BmP3d
         z4gA==
X-Gm-Message-State: AOAM532y1Dq8EYP1QLK1AOohZcK1gO/tA8QpdZ1p4VLEPGnfThusNC0r
        4EgQEDmn+R6q7mXZbtRdF5bq0qcCNv+IvFGCAsv9jw==
X-Google-Smtp-Source: ABdhPJyOGEzTN5ie9agHxl4cS61ylB6xO8eTkZnYeEg8FGn5HzoowBJbQV+Ws9vld5pFq3VE38zPZoChvTtPXqEREvE=
X-Received: by 2002:a17:90b:4a09:: with SMTP id kk9mr18400389pjb.230.1642141445152;
 Thu, 13 Jan 2022 22:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com> <20220104194918.373612-5-rananta@google.com>
 <CAAeT=FztkibSajKjnpRfObx+D1r8H1s_8-5MmqjemJTfmb2mpg@mail.gmail.com>
 <CAJHc60ywYgAPfG11Ljkj3qzLoUn9mZPKnPH0P-HYS-pfs+A__g@mail.gmail.com>
 <CAAeT=FwA9X9eXrF+Q31Wzah=UkM-B8bMJObjJ=oCV0rjLfX6=g@mail.gmail.com> <CAJHc60y6b-scY8zcPuLnjGtr6HzSBnmhi2mCnmkNm4nTxgMTUQ@mail.gmail.com>
In-Reply-To: <CAJHc60y6b-scY8zcPuLnjGtr6HzSBnmhi2mCnmkNm4nTxgMTUQ@mail.gmail.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 13 Jan 2022 22:23:49 -0800
Message-ID: <CAAeT=FyER7GWZqSHyRA4-YRwef_KmGEw+tUoxBc7GXC4-6hFhw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] KVM: arm64: Setup a framework for hypercall
 bitmap firmware registers
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > +static void
> > > > > +kvm_arm_get_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 fw_reg_bmap, u64 *val)
> > > > > +{
> > > > > +       struct kvm *kvm = vcpu->kvm;
> > > > > +
> > > > > +       mutex_lock(&kvm->lock);
> > > > > +       *val = fw_reg_bmap;
> > > > > +       mutex_unlock(&kvm->lock);
> > > >

I have another comment for kvm_arm_get_fw_reg_bmap.

I just noticed that @fw_reg_bmap is a value of the bitmap register
(not a pointer).  I believe what you meant was a pointer to
hvc_desc->hvc_*_bmap.  Also, you can remove @val and return the register
value instead (change the type of the return value from void to u64).
I'm not sure if you will keep this function in the next version though.

Thanks,
Reiji
