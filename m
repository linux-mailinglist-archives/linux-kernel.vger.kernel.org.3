Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5924BB6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiBRKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiBRKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:39 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D12AF3D3;
        Fri, 18 Feb 2022 02:16:23 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a12-20020a05683012cc00b005acf7c91097so1623564otq.10;
        Fri, 18 Feb 2022 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2NUwjlP/vOuIBV1np9NiJ3HRb/wklk2YI9wob6stFns=;
        b=homC/eRQJMsRMmXyrAPjGInfnbZQD9EX04WzWGdutnjhIOt9SnqRsvqzHNgL5SOqaU
         g9YQOytY9SRRGbgGijzgUot4R0+VAAEhYu151SIewSwj6KwD9c8IjZTOBM0tTr2Gid3P
         5ywlkMam0o7fAty02Se9WbQI1EM+ZVX4pe2h2aUUkrIu3YA/BZ+vb7o5AHiOxQSXE55I
         260Z4QLQyx7NpLODLhTJgeEShtTych73O10QrU1wqTAHksMfF/5lTZGCcUnGFCIqmdMN
         UVmK2j6Jc+0Nw8q44oeeeTs7YU0KXzw2CE27SMh2Dr9TP2xcnO/HWbF4yVJwuONt8BU8
         B0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2NUwjlP/vOuIBV1np9NiJ3HRb/wklk2YI9wob6stFns=;
        b=2/0mRkVyZyLsGDJnFYJ+EFjs7Yne11iFE/ciw2tLkatNiCh4H8Z80jkZ/BoHmcFx7v
         +S5mb1VSUSA59kVmJeQtS1JQs9XNzqp2QtgdKQLCz9pCuHALwJCcLLtzFfVzdJztsUIe
         ZN1Z2dqFTBrkfhe0cGiWon4mejLRWP0PAO4OLja8cj6CS+DS/GRSvgvFX5CCMFda3tDL
         74MoQ+qUAjDY5LDwHg1gCWB0k3Q42lFcs6uswarvx6dK4IODWA3zBFtBqc15J3PQpbgM
         m/VIy20yAGBVwMz6GYnuZ25+4gBSDvBH7Urzz+qEM+11zZ6yvDp9f2a6KpHwJx/Ee7vG
         u4Cg==
X-Gm-Message-State: AOAM531a+bus39k9zH3B96egEQXrrtKNrROF5YqWOs4PS3YBrbeaTOM2
        3J7xj7q6UqMWQPNPTJKZKJuvuM8Wwsa9ODuvxJw8rxDQyZfht3ME87Q=
X-Google-Smtp-Source: ABdhPJzKvLoIqaAD1pjU/Y2GIdqxyPc1AmXHCETzPtV8646Pvii6g1eF/y7/BKZCV9VB5g7KOAbhoImt527Fphqlz38=
X-Received: by 2002:a9d:715c:0:b0:5ad:3858:4d54 with SMTP id
 y28-20020a9d715c000000b005ad38584d54mr251368otj.214.1645179382348; Fri, 18
 Feb 2022 02:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20220217090440.4468-1-qiang.yu@amd.com> <5d3fdd2c-e74a-49f4-2b28-32c06483236f@amd.com>
 <CAKGbVbtLTBJPF5eTu4rABUTBa8eqjQvqjo1AEUrzgPgYgCREuA@mail.gmail.com>
 <dac70c05-e712-d2e3-2267-278380895f1e@amd.com> <CAKGbVbvtLbDiKrX80-dMnipdLkTE+FP=g_mx37e12fuMtA1Y4Q@mail.gmail.com>
 <ca27a9c6-f390-a938-dd66-ac23f3b44dc4@amd.com> <CAKGbVbv4UFCybS_OFj5UkDgevbrB5qe3pv+0nHv9WdefYhy6Ww@mail.gmail.com>
 <6711073b-8771-5750-33f7-b72333b411c6@amd.com> <CAKGbVbvR+msXjrsXmDM8QTmsCP03hL5-q5CTJBYu4mm=NQd01A@mail.gmail.com>
 <a11b7073-6597-8e87-b724-33acab32e791@gmail.com> <CAKGbVbuJ-QdeoMTg=_O=1x5A5tbqZftsjt8aCCoVkAekci0USA@mail.gmail.com>
 <d830bb82-63ea-2de6-6d10-3a401ac0dcf0@amd.com>
In-Reply-To: <d830bb82-63ea-2de6-6d10-3a401ac0dcf0@amd.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Fri, 18 Feb 2022 18:16:08 +0800
Message-ID: <CAKGbVbtorRius+Sq1_3SPUF3JzA00U747noSGhx7eP8Vn1rSDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check vm bo eviction valuable at last
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, Qiang Yu <qiang.yu@amd.com>,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 5:27 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.02.22 um 09:58 schrieb Qiang Yu:
> > On Fri, Feb 18, 2022 at 3:46 PM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 18.02.22 um 04:08 schrieb Qiang Yu:
> >>> On Thu, Feb 17, 2022 at 8:22 PM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> Am 17.02.22 um 11:58 schrieb Qiang Yu:
> >>>>> On Thu, Feb 17, 2022 at 6:39 PM Christian K=C3=B6nig
> >>>>> <christian.koenig@amd.com> wrote:
> >>>>>> Am 17.02.22 um 11:13 schrieb Qiang Yu:
> >>>>>>> On Thu, Feb 17, 2022 at 5:46 PM Christian K=C3=B6nig
> >>>>>>> <christian.koenig@amd.com> wrote:
> >>>>>>>> Am 17.02.22 um 10:40 schrieb Qiang Yu:
> >>>>>>>>> On Thu, Feb 17, 2022 at 5:15 PM Christian K=C3=B6nig
> >>>>>>>>> <christian.koenig@amd.com> wrote:
> >>>>>>>>>> Am 17.02.22 um 10:04 schrieb Qiang Yu:
> >>>>>>>>>>> Workstation application ANSA/META get this error dmesg:
> >>>>>>>>>>> [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO=
_VA (-16)
> >>>>>>>>>>>
> >>>>>>>>>>> This is caused by:
> >>>>>>>>>>> 1. create a 256MB buffer in invisible VRAM
> >>>>>>>>>>> 2. CPU map the buffer and access it causes vm_fault and try t=
o move
> >>>>>>>>>>>          it to visible VRAM
> >>>>>>>>>>> 3. force visible VRAM space and traverse all VRAM bos to chec=
k if
> >>>>>>>>>>>          evicting this bo is valuable
> >>>>>>>>>>> 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evict=
able()
> >>>>>>>>>>>          will set amdgpu_vm->evicting, but latter due to not =
in visible
> >>>>>>>>>>>          VRAM, won't really evict it so not add it to amdgpu_=
vm->evicted
> >>>>>>>>>>> 5. before next CS to clear the amdgpu_vm->evicting, user VM o=
ps
> >>>>>>>>>>>          ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->=
evicted)
> >>>>>>>>>>>          but fail in amdgpu_vm_bo_update_mapping() (check
> >>>>>>>>>>>          amdgpu_vm->evicting) and get this error log
> >>>>>>>>>>>
> >>>>>>>>>>> This error won't affect functionality as next CS will finish =
the
> >>>>>>>>>>> waiting VM ops. But we'd better make the amdgpu_vm->evicting
> >>>>>>>>>>> correctly reflact the vm status and clear the error log.
> >>>>>>>>>> Well NAK, that is intentional behavior.
> >>>>>>>>>>
> >>>>>>>>>> The VM page tables where considered for eviction, so setting t=
he flag is
> >>>>>>>>>> correct even when the page tables later on are not actually ev=
icted.
> >>>>>>>>>>
> >>>>>>>>> But this will unnecessarily stop latter user VM ops in ioctl be=
fore CS
> >>>>>>>>> even when the VM bos are not evicted.
> >>>>>>>>> Won't this have any negative effect when could do better?
> >>>>>>>> No, this will have a positive effect. See the VM was already con=
sidered
> >>>>>>>> for eviction because it is idle.
> >>>>>>>>
> >>>>>>>> Updating it immediately doesn't necessarily make sense, we shoul=
d wait
> >>>>>>>> with that until its next usage.
> >>>>>>>>
> >>>>>>>> Additional to that this patch doesn't really fix the problem, it=
 just
> >>>>>>>> mitigates it.
> >>>>>>>>
> >>>>>>>> Eviction can fail later on for a couple of reasons and we absolu=
tely
> >>>>>>>> need to check the flag instead of the list in amdgpu_vm_ready().
> >>>>>>> The flag only for both flag and list? Looks like should be both a=
s
> >>>>>>> the list indicate some vm page table need to be updated and could
> >>>>>>> delay the user update with the same logic as you described above.
> >>>>>> I think checking the flag should be enough. The issue is that the =
list
> >>>>>> was there initially, but to avoid race conditions we added the fla=
g with
> >>>>>> separate lock protection later on.
> >>>>>>
> >>>>> But list and flag does not align always, there are cases like
> >>>>> list-empty/flag-set (this problem) and list-non-empty/flag-unset (n=
on-vm bo
> >>>>> eviction). If only check flag list-non-empty/flag-unset change beha=
vior.
> >>>> Yeah, but I think that the flag unset list-non-empty case would be
> >>>> correctly handled if we only test the flag.
> >>>>
> >>>> In other words we can update the page tables as long as they are not
> >>>> partially or fully evicted and that's not the case when non-vm BOs a=
re
> >>>> evicted.
> >>>>
> >>> This sounds like two standard for the same thing, because this proble=
m
> >>> does not evict page tables too. But I see your point is:
> >>> There's a difference that this problem's case can make sure vm is idl=
e,
> >>> and we prefer to delay vm updates when vm is idle.
> >>>
> >>> If so, why not just stop user vm update by checking vm busy in
> >>> amdgpu_gem_va_ioctl() to skip amdgpu_gem_va_update_vm()?
> >> That's exactly what amdgpu_gem_va_update_vm() is doing by calling
> >> amdgpu_vm_ready(). The problem is that amdgpu_vm_ready() looks at the
> >> wrong thing.
> >>
> > If amdgpu_vm_ready() use evicting flag, it's still not equivalent to ch=
eck
> > vm idle: true -> vm idle, false -> vm may be idle or busy.
>
> Yeah, but why should that be relevant?
>
> The amdgpu_vm_ready() return if we can do page table updates or not. If
> the VM is idle or not is only relevant for eviction.
>
> In other words any CS or page table update makes the VM busy, but that
> only affects if the VM can be evicted or not.
>
My point is: we can't use amdgpu_vm_ready() to replace vm_is_busy(), so
currently we update vm even when vm is busy. So why not use:
if (!amdgpu_vm_ready() || vm_is_busy()) return;
in amdgpu_gem_va_update_vm(), as you mentioned we prefer to not
update vm when it's idle.

> >>> Then we can keep the evicting flag accurate (after solving your
> >>> concern for this patch that eviction may fail latter by further delay
> >>> the flag update after eviction success).
> >> That won't work. See we need to mark the VM as evicted before we
> >> actually evict them because otherwise somebody could use the VM in
> >> parallel and add another fence to it.
> >>
> > I see, make this too accurate should cost too much like holding the
> > eviction_lock when eviction. But just delay it in
> > amdgpu_ttm_bo_eviction_valuable()
> > could avoid most false positive case.
>
> Partially correct. Another fundamental problem is that we can't hold the
> eviction lock because that would result in lock inversion and potential
> deadlock.
>
> We could set the flag later on, but as I said before that when we set
> the evicted flag when the VM is already idle is a desired effect.
>
As above, this confuse me as we can explicitly check vm idle when
user update vm, why bother to embed it in evicting flag implicitly?

Check vm idle need to hold resv lock. Read your patch for adding
evicting flag is to update vm without resv lock. But user vm ops in
amdgpu_gem_va_update_vm() do hold the resv lock, so the difference
happens when calling amdgpu_vm_bo_update_mapping() from
svm_range_(un)map_to_gpu(). So embed vm idle in evicting flag
is for svm_range_(un)map_to_gpu() also do nothing when vm idle?

Regards,
Qiang

> Regards,
> Christian.
>
> >
> > Regards,
> > Qiang
> >
> >> Regards,
> >> Christian.
> >>
> >>> Regards,
> >>> Qiang
> >>>
> >>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> Regards,
> >>>>> Qiang
> >>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>>>
> >>>>>>> Regards,
> >>>>>>> Qiang
> >>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Christian.
> >>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Qiang
> >>>>>>>>>
> >>>>>>>>>> What we should rather do is to fix amdgpu_vm_ready() to take a=
 look at
> >>>>>>>>>> the flag instead of the linked list.
> >>>>>>>>>>
> >>>>>>>>>> Regards,
> >>>>>>>>>> Christian.
> >>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 85 +++++++++=
+++++-----------
> >>>>>>>>>>>        1 file changed, 47 insertions(+), 38 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>>>>>>>> index 5a32ee66d8c8..88a27911054f 100644
> >>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>>>>>>>> @@ -1306,45 +1306,11 @@ uint64_t amdgpu_ttm_tt_pte_flags(stru=
ct amdgpu_device *adev, struct ttm_tt *ttm,
> >>>>>>>>>>>            return flags;
> >>>>>>>>>>>        }
> >>>>>>>>>>>
> >>>>>>>>>>> -/*
> >>>>>>>>>>> - * amdgpu_ttm_bo_eviction_valuable - Check to see if we can =
evict a buffer
> >>>>>>>>>>> - * object.
> >>>>>>>>>>> - *
> >>>>>>>>>>> - * Return true if eviction is sensible. Called by ttm_mem_ev=
ict_first() on
> >>>>>>>>>>> - * behalf of ttm_bo_mem_force_space() which tries to evict b=
uffer objects until
> >>>>>>>>>>> - * it can find space for a new object and by ttm_bo_force_li=
st_clean() which is
> >>>>>>>>>>> - * used to clean out a memory space.
> >>>>>>>>>>> - */
> >>>>>>>>>>> -static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffe=
r_object *bo,
> >>>>>>>>>>> -                                         const struct ttm_pl=
ace *place)
> >>>>>>>>>>> +static bool amdgpu_ttm_mem_eviction_valuable(struct ttm_buff=
er_object *bo,
> >>>>>>>>>>> +                                          const struct ttm_p=
lace *place)
> >>>>>>>>>>>        {
> >>>>>>>>>>>            unsigned long num_pages =3D bo->resource->num_page=
s;
> >>>>>>>>>>>            struct amdgpu_res_cursor cursor;
> >>>>>>>>>>> -     struct dma_resv_list *flist;
> >>>>>>>>>>> -     struct dma_fence *f;
> >>>>>>>>>>> -     int i;
> >>>>>>>>>>> -
> >>>>>>>>>>> -     /* Swapout? */
> >>>>>>>>>>> -     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> >>>>>>>>>>> -             return true;
> >>>>>>>>>>> -
> >>>>>>>>>>> -     if (bo->type =3D=3D ttm_bo_type_kernel &&
> >>>>>>>>>>> -         !amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)))
> >>>>>>>>>>> -             return false;
> >>>>>>>>>>> -
> >>>>>>>>>>> -     /* If bo is a KFD BO, check if the bo belongs to the cu=
rrent process.
> >>>>>>>>>>> -      * If true, then return false as any KFD process needs =
all its BOs to
> >>>>>>>>>>> -      * be resident to run successfully
> >>>>>>>>>>> -      */
> >>>>>>>>>>> -     flist =3D dma_resv_shared_list(bo->base.resv);
> >>>>>>>>>>> -     if (flist) {
> >>>>>>>>>>> -             for (i =3D 0; i < flist->shared_count; ++i) {
> >>>>>>>>>>> -                     f =3D rcu_dereference_protected(flist->=
shared[i],
> >>>>>>>>>>> -                             dma_resv_held(bo->base.resv));
> >>>>>>>>>>> -                     if (amdkfd_fence_check_mm(f, current->m=
m))
> >>>>>>>>>>> -                             return false;
> >>>>>>>>>>> -             }
> >>>>>>>>>>> -     }
> >>>>>>>>>>>
> >>>>>>>>>>>            switch (bo->resource->mem_type) {
> >>>>>>>>>>>            case AMDGPU_PL_PREEMPT:
> >>>>>>>>>>> @@ -1377,10 +1343,53 @@ static bool amdgpu_ttm_bo_eviction_va=
luable(struct ttm_buffer_object *bo,
> >>>>>>>>>>>                    return false;
> >>>>>>>>>>>
> >>>>>>>>>>>            default:
> >>>>>>>>>>> -             break;
> >>>>>>>>>>> +             return ttm_bo_eviction_valuable(bo, place);
> >>>>>>>>>>>            }
> >>>>>>>>>>> +}
> >>>>>>>>>>>
> >>>>>>>>>>> -     return ttm_bo_eviction_valuable(bo, place);
> >>>>>>>>>>> +/*
> >>>>>>>>>>> + * amdgpu_ttm_bo_eviction_valuable - Check to see if we can =
evict a buffer
> >>>>>>>>>>> + * object.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + * Return true if eviction is sensible. Called by ttm_mem_ev=
ict_first() on
> >>>>>>>>>>> + * behalf of ttm_bo_mem_force_space() which tries to evict b=
uffer objects until
> >>>>>>>>>>> + * it can find space for a new object and by ttm_bo_force_li=
st_clean() which is
> >>>>>>>>>>> + * used to clean out a memory space.
> >>>>>>>>>>> + */
> >>>>>>>>>>> +static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffe=
r_object *bo,
> >>>>>>>>>>> +                                         const struct ttm_pl=
ace *place)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +     struct dma_resv_list *flist;
> >>>>>>>>>>> +     struct dma_fence *f;
> >>>>>>>>>>> +     int i;
> >>>>>>>>>>> +
> >>>>>>>>>>> +     /* Swapout? */
> >>>>>>>>>>> +     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> >>>>>>>>>>> +             return true;
> >>>>>>>>>>> +
> >>>>>>>>>>> +     /* If bo is a KFD BO, check if the bo belongs to the cu=
rrent process.
> >>>>>>>>>>> +      * If true, then return false as any KFD process needs =
all its BOs to
> >>>>>>>>>>> +      * be resident to run successfully
> >>>>>>>>>>> +      */
> >>>>>>>>>>> +     flist =3D dma_resv_shared_list(bo->base.resv);
> >>>>>>>>>>> +     if (flist) {
> >>>>>>>>>>> +             for (i =3D 0; i < flist->shared_count; ++i) {
> >>>>>>>>>>> +                     f =3D rcu_dereference_protected(flist->=
shared[i],
> >>>>>>>>>>> +                             dma_resv_held(bo->base.resv));
> >>>>>>>>>>> +                     if (amdkfd_fence_check_mm(f, current->m=
m))
> >>>>>>>>>>> +                             return false;
> >>>>>>>>>>> +             }
> >>>>>>>>>>> +     }
> >>>>>>>>>>> +
> >>>>>>>>>>> +     /* Check by different mem type. */
> >>>>>>>>>>> +     if (!amdgpu_ttm_mem_eviction_valuable(bo, place))
> >>>>>>>>>>> +             return false;
> >>>>>>>>>>> +
> >>>>>>>>>>> +     /* VM bo should be checked at last because it will mark=
 VM evicting. */
> >>>>>>>>>>> +     if (bo->type =3D=3D ttm_bo_type_kernel)
> >>>>>>>>>>> +             return amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)=
);
> >>>>>>>>>>> +
> >>>>>>>>>>> +     return true;
> >>>>>>>>>>>        }
> >>>>>>>>>>>
> >>>>>>>>>>>        static void amdgpu_ttm_vram_mm_access(struct amdgpu_de=
vice *adev, loff_t pos,
>
