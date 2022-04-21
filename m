Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42550A784
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390998AbiDUR7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiDUR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:59:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FD457B7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:56:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md4so5619512pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgOfrre7vqAxibEQxn++SN6iXxVBlafEhiSkZJUYSpM=;
        b=DokQqtOJ13RRDXr0maxYSYo4wjLoMLdNUodDAsTv4HwLWTyYYdR34XaKL/oT/yHynl
         /Za2hF0AVd2ot1uCO8/eeGZFvMtCU941AncdHbwWWZVLehEqYMWjaZlWmOkT+mebmAyD
         zBqOGAyB1ryPqMo6l88KJCUVppORIDgNsx6ofFJ9u3a3f+OtycWXCJlQMbrZrCS1eucD
         irWW3GP8t3+6TbXcTrHi6uOOVPot5aJILi3D3XXCY4Qrhl/sg2vXJFcyu/LnWc0y1bp5
         Oq3lH7aCiJ+9qNP2J+jmUPT8lx+TnyKyPxwWMFulSodZ3s7o9DpqD4kDvpL9dCGNMgFj
         fwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgOfrre7vqAxibEQxn++SN6iXxVBlafEhiSkZJUYSpM=;
        b=W98ALt7t0Wg7tmMUxv/veUeZue4gsXMQOUY/wpWY8OMGZ4evu9E6ruPMkqZWfdXgtt
         VjFjGeNeb6nzL9e0cg4KpCqaf9+H3ixi85pbXpvzbFpHQhgKL8BVz4FWoR0qiJpAu8eY
         beKtPWor0qsARHkWrfTG4bZy4CZrXyuMo6Vs26afQzhfRxjDR+sHiE5UiSFQ1cwPc0wB
         BlO8mraSQ7gIod7fl0yMVO7CiSMCbxOaFmTcK9ii37frNHjTzpYwr8WbC4yoLweTu6QG
         e1hujJCEeH21Y+LBNgNjtCMmMV7Qxv+xamLh0GfcjVSBrAcc4Cvs2Sqph5pU4aTFP8b/
         XUog==
X-Gm-Message-State: AOAM531AExt0h2Q4a/rsIAbcTInjFIoeI+dCcIuSZ7AsddANwe8TfX8R
        qQIlLCJL455elv7HVvezgNIxuFK5OMHLi1xcvEk=
X-Google-Smtp-Source: ABdhPJwI6wbvIWmUO/8pAl1o38Y6u+/+LpoeuUdrdYl/sajjStC23GKUwU1rqu1O9tGoXI1dUeIHmsj3NCMNDizafNM=
X-Received: by 2002:a17:902:eb82:b0:158:8feb:86d6 with SMTP id
 q2-20020a170902eb8200b001588feb86d6mr624798plg.26.1650563802589; Thu, 21 Apr
 2022 10:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
 <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com> <CAAPL-u9=-OHuUk=ZkNRDf3Dm_+3cBd2APL5MQpQr3_sVk_voJg@mail.gmail.com>
In-Reply-To: <CAAPL-u9=-OHuUk=ZkNRDf3Dm_+3cBd2APL5MQpQr3_sVk_voJg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 21 Apr 2022 10:56:30 -0700
Message-ID: <CAHbLzkqrxTpWT9q9xavGF+HZQNeNp13OATj248fb1rfCGKTu8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     Wei Xu <weixugc@google.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:41 PM Wei Xu <weixugc@google.com> wrote:
>
> On Wed, Apr 20, 2022 at 8:12 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > >
> > > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > > Current implementation to find the demotion targets works
> > > > based on node state N_MEMORY, however some systems may have
> > > > dram only memory numa node which are N_MEMORY but not the
> > > > right choices as demotion targets.
> > > >
> > > > This patch series introduces the new node state
> > > > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > > > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > > > is used to hold the list of nodes which can be used as demotion
> > > > targets, support is also added to set the demotion target
> > > > list from user space so that default behavior can be overridden.
> > >
> > > It appears that your proposed user space interface cannot solve all
> > > problems.  For example, for system as follows,
> > >
> > > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> > > node 0,
> > >
> > > available: 3 nodes (0-2)
> > > node 0 cpus: 0 1
> > > node 0 size: n MB
> > > node 0 free: n MB
> > > node 1 cpus:
> > > node 1 size: n MB
> > > node 1 free: n MB
> > > node 2 cpus: 2 3
> > > node 2 size: n MB
> > > node 2 free: n MB
> > > node distances:
> > > node   0   1   2
> > >   0:  10  40  20
> > >   1:  40  10  80
> > >   2:  20  80  10
> > >
> > > Demotion order 1:
> > >
> > > node    demotion_target
> > >  0              1
> > >  1              X
> > >  2              X
> > >
> > > Demotion order 2:
> > >
> > > node    demotion_target
> > >  0              1
> > >  1              X
> > >  2              1
> > >
> > > The demotion order 1 is preferred if we want to reduce cross-socket
> > > traffic.  While the demotion order 2 is preferred if we want to take
> > > full advantage of the slow memory node.  We can take any choice as
> > > automatic-generated order, while make the other choice possible via user
> > > space overridden.
> > >
> > > I don't know how to implement this via your proposed user space
> > > interface.  How about the following user space interface?
> > >
> > > 1. Add a file "demotion_order_override" in
> > >         /sys/devices/system/node/
> > >
> > > 2. When read, "1" is output if the demotion order of the system has been
> > > overridden; "0" is output if not.
> > >
> > > 3. When write "1", the demotion order of the system will become the
> > > overridden mode.  When write "0", the demotion order of the system will
> > > become the automatic mode and the demotion order will be re-generated.
> > >
> > > 4. Add a file "demotion_targets" for each node in
> > >         /sys/devices/system/node/nodeX/
> > >
> > > 5. When read, the demotion targets of nodeX will be output.
> > >
> > > 6. When write a node list to the file, the demotion targets of nodeX
> > > will be set to the written nodes.  And the demotion order of the system
> > > will become the overridden mode.
> >
> > TBH I don't think having override demotion targets in userspace is
> > quite useful in real life for now (it might become useful in the
> > future, I can't tell). Imagine you manage hundred thousands of
> > machines, which may come from different vendors, have different
> > generations of hardware, have different versions of firmware, it would
> > be a nightmare for the users to configure the demotion targets
> > properly. So it would be great to have the kernel properly configure
> > it *without* intervening from the users.
> >
> > So we should pick up a proper default policy and stick with that
> > policy unless it doesn't work well for the most workloads. I do
> > understand it is hard to make everyone happy. My proposal is having
> > every node in the fast tier has a demotion target (at least one) if
> > the slow tier exists sounds like a reasonable default policy. I think
> > this is also the current implementation.
> >
>
> This is reasonable.  I agree that with a decent default policy, the
> overriding of per-node demotion targets can be deferred.  The most
> important problem here is that we should allow the configurations
> where memory-only nodes are not used as demotion targets, which this
> patch set has already addressed.

Yes, I agree. Fixing the bug and allowing override by userspace are
totally two separate things.

>
> > >
> > > To reduce the complexity, the demotion order of the system is either in
> > > overridden mode or automatic mode.  When converting from the automatic
> > > mode to the overridden mode, the existing demotion targets of all nodes
> > > will be retained before being changed.  When converting from overridden
> > > mode to automatic mode, the demotion order of the system will be re-
> > > generated automatically.
> > >
> > > In overridden mode, the demotion targets of the hot-added and hot-
> > > removed node will be set to empty.  And the hot-removed node will be
> > > removed from the demotion targets of any node.
> > >
> > > This is an extention of the interface used in the following patch,
> > >
> > > https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/
> > >
> > > What do you think about this?
> > >
> > > > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > > > driver, certain type of memory which registers through dax kmem
> > > > (e.g. HBM) may not be the right choices for demotion so in future
> > > > they should be distinguished based on certain attributes and dax
> > > > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > > > however current implementation also doesn't distinguish any
> > > > such memory and it considers all N_MEMORY as demotion targets
> > > > so this patch series doesn't modify the current behavior.
> > > >
> > >
> > > Best Regards,
> > > Huang, Ying
> > >
> > > [snip]
> > >
