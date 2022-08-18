Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3B598F64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiHRVYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346875AbiHRVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057FE992F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so2545154plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=7oIe7UPglhSMlfQFr1TuN0Ln/s1ah6Fw09rZLyKnfrQ=;
        b=ungHvqmzyqGDAu/fP+qJLsFe+D3rJ3m/3zy0Rh3o0MRNuWupqyMOrkA+PYarA052+7
         7dTwrvjrvy6RHLuRqB7SbLWRgUUlkcxvev7/eRPXFIt+CwvkRpvyL3AawVEk4XKrtbKW
         gRzM8f0ELaJzv+pMnSUoK32ypwoveWAoYb2kMOm9rNiNHJdjTvxdDdvTUvhqPfLGFo5O
         DqRDgAQXLAOylGrPo4kyVRFwbILOcx32ECSyH5M9f1WTbJvk4gjJaTpJKgcuveMzj+vK
         o1aoyEnuA9EHaJWfG7gEKvUKXKId1G9CvDW7hIfs2t0sBmas/RRu0C/IR7cip2KSX+t1
         lmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=7oIe7UPglhSMlfQFr1TuN0Ln/s1ah6Fw09rZLyKnfrQ=;
        b=lzKimjTayv70mPpAfEnc8FljV70eGX6JFN0taMYFh604Q1k8OACQBFJyRkkAHNQMhd
         /rvysFLBDU0jC8wlfgRV7VsGLRzJkW96QyLoG/MCLQEhkWHBGjU617UFoUPhFQb5+cqE
         /4mJuaayQ0uNOYEWGdmwziMgg8ZA6Jlz9EYFnaJNHOjkZ0UI4LiaAbgk2PZKrU8+ONAO
         AJrwemvgJ49qsHNBeWTioG0eESqJ9sq9r5H2B9a7w85wZy5OvUHx/I5KXOMKZrdbnoY4
         R2lKb6AxJCEK4w2Dq2vbmuQE1GAFnOYHAQq436ckpscyAknw9nm2BsjTV77AVTdRO5vD
         tViw==
X-Gm-Message-State: ACgBeo39njvTwU9NUosuENz6g1mVH/fyj0F7YwxrniXjHQPiL5MKhRxO
        2ssgdhLlGghwHNNYnScgG/AgGQ==
X-Google-Smtp-Source: AA6agR439SG/RMOn6SpIyP/60Ikavt0l/7rw5mA3CHrjuHRMKlMRmkLZqHOLnA02psRCFa+63TC2MA==
X-Received: by 2002:a17:902:cf43:b0:172:86f3:586a with SMTP id e3-20020a170902cf4300b0017286f3586amr4453826plg.71.1660857355746;
        Thu, 18 Aug 2022 14:15:55 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79591000000b0052aaff953aesm2113454pfj.115.2022.08.18.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:15:55 -0700 (PDT)
Date:   Thu, 18 Aug 2022 14:15:55 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Aug 2022 14:15:53 PDT (-0700)
Subject:     Re: [GIT PULL] Fix RISC-V's arch-topology reporting
In-Reply-To: <994ad6ea-5d3f-b3d1-e0e5-883530ebaf2a@microchip.com>
CC:     sudeep.holla@arm.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        linux-arm-kernel@lists.infradead.org, atishp@atishpatra.org,
        Brice.Goglin@inria.fr, Greg KH <gregkh@linuxfoundation.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-a7823b28-ca11-43bc-9564-2eb7d607d288@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 14:10:54 PDT (-0700), Conor.Dooley@microchip.com wrote:
> 
> 
> On 18/08/2022 22:03, Palmer Dabbelt wrote:
>> On Mon, 15 Aug 2022 15:14:55 PDT (-0700), Conor.Dooley@microchip.com wrote:
>>> Hey Will/Palmer/Sudeep,
>>>
>>> Catalin suggested [0] dropping the CC: stable for the arm64 patch and
>>> instead making it a specific prereq of the RISC-V patch & making a PR,
>>> so here we are.. I was still up when -rc1 came out so pushed it last
>>> night to get the test coverage, but LKP seems to not have reported a
>>> build success since early on the 13th so not holding my horses! I built
>>> it again for both ARMs and RISC-V myself.
>>>
>>> I tagged it tonight, so it's on conor/linux.git as riscv-topo-on-6.0-rc1
>>> with the prereq specified.
>>>
>>> Not sure if you want to merge this too Sudeep or if that's up to Greg?
>> 
>> It's a little bit vague what you're asking for here, so I'm just
>> going to kind of guessing here but this on riscv/for-next.  I'm not
>> sure if you were looking for me to just merge the arch/riscv bits or
>> if this should be on fixes (just looking at the patch makes it look
>> like it should be), but I don't want to send up some arm64 code to
>> fixes without it being pretty explicit that I should do so
> 
> Ahh sorry, I completely forgot to mention that Will said "for 5.21" in
> his response to my original patchset. for-next sounds fine to me - all
> in-tree devicetrees had the optional properties added to them that solve
> the issue - and they were AUTOSEL'ed too from what I can see.

OK, sounds like we're good then.

> 
> Thanks & sorry!
> Conor.
> 
>> 
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # arch/riscv bits, for 6.0-rc
>> 
>> in case someone else wants to send it up before I get back to this,
>> I'm fine either way.
>> 
>> Thanks!
>> 
>>>
>>> Thanks,
>>> Conor.
>>>
>>> 0 - https://lore.kernel.org/linux-riscv/Ytac7G1zlq6WW4jt@arm.com/
>>>
>>> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
>>>
>>>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ tags/riscv-topo-on-6.0-rc1
>>>
>>> for you to fetch changes up to fbd92809997a391f28075f1c8b5ee314c225557c:
>>>
>>>   riscv: topology: fix default topology reporting (2022-08-15 22:07:34 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Fix RISC-V's topology reporting
>>>
>>> The goal here is the fix the incorrectly reported arch topology on
>>> RISC-V which seems to have been broken since it was added.
>>> cpu, package and thread IDs are all currently reported as -1, so tools
>>> like lstopo think systems have multiple threads on the same core when
>>> this is not true:
>>> https://github.com/open-mpi/hwloc/issues/536
>>>
>>> arm64's topology code basically applies to RISC-V too, so it has been
>>> made generic along with the removal of MPIDR related code, which
>>> appears to be redudant code since '3102bc0e6ac7 ("arm64: topology: Stop
>>> using MPIDR for topology information")' replaced the code that actually
>>> interacted with MPIDR with default values.
>>>
>>> ----------------------------------------------------------------
>>> Conor Dooley (2):
>>>       arm64: topology: move store_cpu_topology() to shared code
>>>       riscv: topology: fix default topology reporting
>>>
>>>  arch/arm64/kernel/topology.c | 40 ----------------------------------------
>>>  arch/riscv/Kconfig           |  2 +-
>>>  arch/riscv/kernel/smpboot.c  |  3 ++-
>>>  drivers/base/arch_topology.c | 19 +++++++++++++++++++
>>>  4 files changed, 22 insertions(+), 42 deletions(-)
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
