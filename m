Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545A516150
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 05:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiEADYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 23:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbiEADXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 23:23:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD51003
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 20:20:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so20206724lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=26AjXuKhsyxez2vJWlnycIeCtCiS4HU5agQ4TY4nZfU=;
        b=HLnC2ZbG2wbvUPxcAPC4EQUQgeuGNkkk3cIC9RAX/HnRrmX6y019DWok45LTKf3BbC
         fekC9TNFAcEBDbK29ngvERLNX3hc25u5lp3y38eLJA3NYne1/OrLvXkzqcLpQREloLFG
         z8XI8NdSIeLdXE73FKjOpVHXJm2DSDjTLN4Dmhw3w4jvVc/vS/6rrF44YbWFLwnermi+
         PGKRLiaoh7Q6I0X9+rY84we95vPdzAPUAM6vVNUL/0Wsb4cxWo65FjoHIravLLBTTeWO
         HCXFzgDgpSvEAj3OXijpOPKygNnpALTiBBGneDxItsDlLC8oie2xZJTVut0cPgn0VuHS
         Ukkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=26AjXuKhsyxez2vJWlnycIeCtCiS4HU5agQ4TY4nZfU=;
        b=bnKDzHNVueXGCxkv0DqewWcdEkkSbrLPpoFbSOJanDYD/sfUTtu5nwGZ43Z4jkq5j/
         C1J7sHZF1vRch0mNZzFbng0nBVlTBvuw/oPpWkV3/fyuasrb9oLyxRcd/GH2GzyRpErK
         rLiZifo9/1SE4EQWiYYxJ5rdwRfniWbAEMF9BF4Iu7bIVbLP4ggfkLyiLMV4uXodLRDR
         6toybbUGT2j9SJf6uRcqQ5TIHkxiq5Z6I+9hr5Qa2tkW/ZqG9U1aF6LL91uapTEPTU2g
         4F35rQCYmqf0NW+8TCIIWOHrnyKNMQCnZv9onwUCZuR8bglVXo0wJNkTKb8T2jV48GQt
         oijQ==
X-Gm-Message-State: AOAM53216A2E7JF9tmDpy5wzqkCqJX1iKwq/bF3b8Ppl9bm9PPB0bLXc
        L+qKa4/+rxU6i1IKaP2rR1lf6yoCw1ln6MeTOXk=
X-Google-Smtp-Source: ABdhPJzwX5MlknBOQPVxBMb+cYIUUZXjqmJGEMH9qQ9NJeX02cmIHKFimJoRCRdQiUdevkIHB3TwQUHfqD5QW88z7Ds=
X-Received: by 2002:a05:6512:10cc:b0:472:44ba:1a2d with SMTP id
 k12-20020a05651210cc00b0047244ba1a2dmr4821661lfg.641.1651375211850; Sat, 30
 Apr 2022 20:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu> <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu> <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu>
In-Reply-To: <20220427105844.otru4yohja4s23ye@wubuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sun, 1 May 2022 11:20:00 +0800
Message-ID: <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais
Thanks for the patient explanation.:)
And I have some other concerns.

On Wed, Apr 27, 2022 at 6:58 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/27/22 09:38, Xuewen Yan wrote:
> > > > > The best (simplest) way forward IMHO is to introduce a new functi=
on
> > > > >
> > > > >         bool cpu_in_capacity_inversion(int cpu);

Maybe the implementation of this function, I have not thought of a
good solution.
(1)how to define the inversion, if the cpu has two
cluster(little/big)=EF=BC=8Cit is easy, but still need mark which is the bi=
g
cpu...
(2)because the mainline kernel should be common, if the cpu has three
or more clusters, maybe the mid cpus also would be inversion;
(3)what time update the cpu inversion state, if we judge the cpu
inversion whenever the thermal pressure changed, could we receive the
complexity? because may we should traverse all possible cpu.

Thanks!

---
xuewen.yan
