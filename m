Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2442522BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiEKFbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiEKFan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:30:43 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC98244F2E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:30:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i186so869217vsc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB2dR56A5q3bFoAJ53SBSeAtmH77H5/ybtaBTyeQV0w=;
        b=ikgkCUlCGPbFI/KIA/yJ6gB9/0MYb3JI9K0o5JCBRKlQgGkWsZpC7uLQl+rANxK3/k
         wMsEGVKDlEtSnZ6REsRJfwKIl8itOVEpgP7LSl4X+Zy3TNN/upnfQ1mY4aV44W1J0Vln
         MNPHCRa3i8mMagY9xHbVKc9TxTbbY6cggRTJ2xaXLgUf/KIF76ve3joDWJ1RtXoCKIJl
         PheSx8lbtuBBY3/b5YJ/CgPTE2b/Eb6H1NWgnK9R9cEpip9NRytEd4tlpadx9wmsB3cM
         NNulML+cFkkpwhIz38h+4zSMVmf2y7Ca0CObNcuoQTmrQ+lDHAQQlltdstcx837Px5wY
         sqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB2dR56A5q3bFoAJ53SBSeAtmH77H5/ybtaBTyeQV0w=;
        b=RivDpAqS0ctoSvG1TuiZYSXNlpRLzPF8fRqq5rUE4SBXUm/9AN0FaobSKX8VNlQbiE
         mukBy0KXqsebdYYIzzXoTIPM1qKchNa/HGcsfDnGPnFmfC8yIybzcd7NB/iWs7/NiTjY
         8RN5FdGzo7Aepxk4+ZIYNSxeCLs3kndM8FYI/gNz43yHoPt0F4wmTnGoFnjkKAUCNy4c
         5mxbxw7hsRg5Q68wBS75MKggZq99AIhgAHajwp35LBn3d9XPWRdjABz00Ziq2yCwQRuo
         ODRb11xK87zvR+28u6RIMhw9zMTSXtxW3fD2w+A//J87c0c/yhQSwPYeD+oC1nK1K6lD
         BURQ==
X-Gm-Message-State: AOAM533/WJugiRpyEZSIv8ujlOaEPV6VBN6QOqF6pdexzSMt02P8tSH+
        RFu0Ksc+o2Iy9tGawfsdo3K7eqcNDDztBbxIZ3Vg2g==
X-Google-Smtp-Source: ABdhPJzzixIezT5gEqBLEgY1fCr7L5PsmPNpQOqsuUutiXHgiLkjXSrPgB0gKdqJMWjIOVxUbUhYgLgbIQEu2o/mAk0=
X-Received: by 2002:a67:ed88:0:b0:328:27d9:1381 with SMTP id
 d8-20020a67ed88000000b0032827d91381mr13054653vsp.12.1652247014975; Tue, 10
 May 2022 22:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal> <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
 <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
In-Reply-To: <87fslhhb2l.fsf@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 10 May 2022 22:30:03 -0700
Message-ID: <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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

On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Alistair Popple <apopple@nvidia.com> writes:
>
> > Wei Xu <weixugc@google.com> writes:
> >
> >> On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
> >>>
> >>> Wei Xu <weixugc@google.com> writes:
> >>>
> >>> [...]
> >>>
> >>> >> >
> >>> >> >
> >>> >> > Tiering Hierarchy Initialization
> >>> >> > `=============================='
> >>> >> >
> >>> >> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> >>> >> >
> >>> >> > A device driver can remove its memory nodes from the top tier, e.g.
> >>> >> > a dax driver can remove PMEM nodes from the top tier.
> >>> >>
> >>> >> With the topology built by firmware we should not need this.
> >>>
> >>> I agree that in an ideal world the hierarchy should be built by firmware based
> >>> on something like the HMAT. But I also think being able to override this will be
> >>> useful in getting there. Therefore a way of overriding the generated hierarchy
> >>> would be good, either via sysfs or kernel boot parameter if we don't want to
> >>> commit to a particular user interface now.
> >>>
> >>> However I'm less sure letting device-drivers override this is a good idea. How
> >>> for example would a GPU driver make sure it's node is in the top tier? By moving
> >>> every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> >>> could get messy if say there were two drivers both of which wanted their node to
> >>> be in the top tier.
> >>
> >> The suggestion is to allow a device driver to opt out its memory
> >> devices from the top-tier, not the other way around.
> >
> > So how would demotion work in the case of accelerators then? In that
> > case we would want GPU memory to demote to DRAM, but that won't happen
> > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> > only override available with this proposal would move GPU memory into a
> > lower tier, which is the opposite of what's needed there.
>
> How about we do 3 tiers now. dax kmem devices can be registered to
> tier 3. By default all numa nodes can be registered at tier 2 and HBM or
> GPU can be enabled to register at tier 1. ?

This makes sense.  I will send an updated RFC based on the discussions so far.

> -aneesh
