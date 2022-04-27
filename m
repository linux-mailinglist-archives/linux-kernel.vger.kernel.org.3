Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A75123C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiD0UVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiD0UVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:21:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB6E8AE75
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:18:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y19so4146560ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXFnAVqWMpf/YDrR850VsivYujGHnkwJcitva2FzMCY=;
        b=AsMo9skrDD8q8UQN0XdxKlPDJ4+e3dYaIoN3KEWpWtFNuZL3YImkDoePDywipkcPXC
         7gr6gyPMz+HHZWqFwZJltblh2rRUK0qPATYMnQdpYW8mSeHz+n8OoHmU2qgnhDaWt3JR
         aDMqR97ZibWUX6nKkJF7K50tNMvPeK9aK2N+9BKoSWRgBVptUUiIWzetJUSZFezy2OtE
         W2Yktn/wIisc/6zuQSZK5FVi6MtnmNmF9xF1NM/i2TsZY5m0S+D9W63nVc3LBMKK2Wqa
         6VY4hv6eDQorANkiVZwst2udkY5trvoLSpwJUEsuIO24BkBH6h0iLXu6Jz6AwiVPZqqH
         UE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXFnAVqWMpf/YDrR850VsivYujGHnkwJcitva2FzMCY=;
        b=7KuOC8FMwoPYx9bo4fZdGY5KaEFQbLynX7JP4p2ABTRt2qwtREDXCjGPeSOy1o5pZJ
         WwWiXjb2zRUbkYBnC0Herudsy29/yXxrxJNCPNO88yDZx2F/WY6F7W4xTjJ9VAb3AlCp
         eyiKot4jWBYxmRoFk+kuAXdmqWmFbz3WPdrfNKCBpbWgbpILuE/4MXTJS1WL6tp1Je4p
         DBU747iGG9sJClAHU8sPvWLrgNjC8dJuLNGGppbylxQsGXzuY4jdat0SVdJOewZ2AU8j
         XvjlR1A1v+tL28m4naXlfP0ls2JTmSSX/OZtC60evJPRYmpmY+7Azv04XSfSS/k8dKlm
         QjLw==
X-Gm-Message-State: AOAM533XnEp40BjBHDJuO3qOL2wbiq0ktFZfMi+WFIluhLzh8KbveAgi
        U+D21ROYr3cMH1CO+CTbp6I1RZa2c+/UEFns70LarQ==
X-Google-Smtp-Source: ABdhPJzDDO/eY2GpC6TtuCyZdzeb0QOjebpOsfygIMaVPVBqnO7DcKZk5c4IubxxlVoCTLYkKGurPu6NtObI/0mLeZA=
X-Received: by 2002:a05:651c:1994:b0:24d:d4b9:516c with SMTP id
 bx20-20020a05651c199400b0024dd4b9516cmr18883821ljb.278.1651090700825; Wed, 27
 Apr 2022 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220407195908.633003-1-pgonda@google.com> <CAFNjLiXC0AdOw5f8Ovu47D==ex7F0=WN_Ocirymz4xL=mWvC5A@mail.gmail.com>
 <CAMkAt6r-Mc_YN-gVHuCpTj4E1EmcvyYpP9jhtHo5HRHnoNJAdA@mail.gmail.com>
 <CAMkAt6r+OMPWCbV_svUyGWa0qMzjj2UEG29G6P7jb6uH6yko2w@mail.gmail.com>
 <62e9ece1-5d71-f803-3f65-2755160cf1d1@redhat.com> <CAMkAt6q6YLBfo2RceduSXTafckEehawhD4K4hUEuB4ZNqe2kKg@mail.gmail.com>
 <4c0edc90-36a1-4f4c-1923-4b20e7bdbb4c@redhat.com>
In-Reply-To: <4c0edc90-36a1-4f4c-1923-4b20e7bdbb4c@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 27 Apr 2022 14:18:09 -0600
Message-ID: <CAMkAt6oL5qi7z-eh4z7z8WBhpc=Ow6WtcJA5bDi6-aGMnz135A@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: SEV: Mark nested locking of vcpu->lock
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     John Sperbeck <jsperbeck@google.com>,
        kvm list <kvm@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 4/26/22 21:06, Peter Gonda wrote:
> > On Thu, Apr 21, 2022 at 9:56 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 4/20/22 22:14, Peter Gonda wrote:
> >>>>>> svm_vm_migrate_from() uses sev_lock_vcpus_for_migration() to lock all
> >>>>>> source and target vcpu->locks. Mark the nested subclasses to avoid false
> >>>>>> positives from lockdep.
> >>>> Nope. Good catch, I didn't realize there was a limit 8 subclasses:
> >>> Does anyone have thoughts on how we can resolve this vCPU locking with
> >>> the 8 subclass max?
> >>
> >> The documentation does not have anything.  Maybe you can call
> >> mutex_release manually (and mutex_acquire before unlocking).
> >>
> >> Paolo
> >
> > Hmm this seems to be working thanks Paolo. To lock I have been using:
> >
> > ...
> >                    if (mutex_lock_killable_nested(
> >                                &vcpu->mutex, i * SEV_NR_MIGRATION_ROLES + role))
> >                            goto out_unlock;
> >                    mutex_release(&vcpu->mutex.dep_map, _THIS_IP_);
> > ...
> >
> > To unlock:
> > ...
> >                    mutex_acquire(&vcpu->mutex.dep_map, 0, 0, _THIS_IP_);
> >                    mutex_unlock(&vcpu->mutex);
> > ...
> >
> > If I understand correctly we are fully disabling lockdep by doing
> > this. If this is the case should I just remove all the '_nested' usage
> > so switch to mutex_lock_killable() and remove the per vCPU subclass?
>
> Yes, though you could also do:
>
>         bool acquired = false;
>         kvm_for_each_vcpu(...) {
>                 if (acquired)
>                         mutex_release(&vcpu->mutex.dep_map, _THIS_IP_);
>                 if (mutex_lock_killable_nested(&vcpu->mutex, role)
>                         goto out_unlock;
>                 acquired = true;
>                 ...
>
> and to unlock:
>
>         bool acquired = true;
>         kvm_for_each_vcpu(...) {
>                 if (!acquired)
>                         mutex_acquire(&vcpu->mutex.dep_map, 0, role, _THIS_IP_);
>                 mutex_unlock(&vcpu->mutex);
>                 acquired = false;
>         }
>
> where role is either 0 or SINGLE_DEPTH_NESTING and is passed to
> sev_{,un}lock_vcpus_for_migration.
>
> That coalesces all the mutexes for a vm in a single subclass, essentially.

Ah thats a great idea to allow for lockdep to work still. I'll try
that out, thanks again Paolo.

>
> Paolo
>
