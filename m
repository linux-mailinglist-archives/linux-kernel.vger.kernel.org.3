Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA549A872
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318832AbiAYDHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3416556AbiAYCES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:04:18 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BA4C067A79
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:56:19 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g81so56823635ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUSMwHpfIXP327oX5UsCB8xSQ0xCQbkTD62LxiomNN8=;
        b=IybJkGsDeCF6sRlhjGADTGlR29U+WCuv2VLT0Y7Ypt5R+2jPexhhhxmBpFrGzgcg1j
         pTu5oQfqlqcbG+B30fPZR6LjWdRhKpHquiuAhx30Zg4jHyj/AJJL2TTFuY8XSxUe88va
         lJXfpSSAUHSiwVFelfislmQ+tl2tpZZkfUxYHCdb+vBULoCXEFrdQhVNv1KVyNYsbpU4
         YiGZwVEAz94QfqdEEiuKKVLOANTNL7nK/qLNYerhcidLevGfYcGI4gZ/1VWbS6r3xYqy
         muI+QmJgzQjt8S6lIrkBR3EwtyIS4unjnFpbcY2WNBbI67KUm5JqU91RkjpmoSiyPKcU
         Up3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUSMwHpfIXP327oX5UsCB8xSQ0xCQbkTD62LxiomNN8=;
        b=zCaAfcSFX6PgtilABiSO+My75Uub6wu764L7AZma9dOOwRsrAH/uTPfIbgz01PWom3
         H/FTDf1w7Vff9FWToxgmTy03Uk9NfsZuSqt3l2sQ5k+mRXmxT6E0ndGZ0VgO/hfjQaxp
         WJfvAENY51tq7IlJ4eaddIf3B6A2Iw+O86JeMvxGY3E8JwVdJlDF+q3th1mgiQDLIsZL
         kxvbBdCuhjDXOlGNp7aCVCK+gDUgASc3p9O/cNrqBdH+lx3hZM4Y8wRDmI/vGl7JH8q7
         UZAzkmaBhfZjh2oEroyblPvcmDWk4IHKU71omdPRFDXEqlLSSmMYl7LYNmON8C0WlfCJ
         z9PA==
X-Gm-Message-State: AOAM531m6pe83D9Xqnxl0/zTLYPHlCDl1DZv4FveBfq44Cj2aMR3w8D4
        MNY6UxXdB2T/NHB/LGl6FyK6Yl8QgK9TJ8lKv3PB99fIEfT2ldgp
X-Google-Smtp-Source: ABdhPJy0GkjfgB3eDLM6IluHUPnhWC58iVSK51emno/k8FDZmqhaNvVCTR8rIbfaTVH4nEt6fsznaXISf/ZFA4Djpw4=
X-Received: by 2002:a25:c245:: with SMTP id s66mr28600574ybf.243.1643072179000;
 Mon, 24 Jan 2022 16:56:19 -0800 (PST)
MIME-Version: 1.0
References: <202201250818.178Aw4sD-lkp@intel.com>
In-Reply-To: <202201250818.178Aw4sD-lkp@intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 24 Jan 2022 16:56:08 -0800
Message-ID: <CAJuCfpHQaG_W4JRdBaV9CgYGxYTC5hGjFQyy3v8grW8OtGV+Yw@mail.gmail.com>
Subject: Re: kernel/sched/psi.c:1193:6: warning: no previous prototype for 'psi_trigger_destroy'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 4:27 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> commit: a06247c6804f1a7c86a2e5398a4c1f1db1471848 psi: Fix uaf issue when psi trigger is destroyed while being polled
> date:   7 days ago
> config: sh-randconfig-r012-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250818.178Aw4sD-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a06247c6804f1a7c86a2e5398a4c1f1db1471848
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a06247c6804f1a7c86a2e5398a4c1f1db1471848
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash kernel/sched/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    kernel/sched/psi.c:1123:21: warning: no previous prototype for 'psi_trigger_create' [-Wmissing-prototypes]
>     1123 | struct psi_trigger *psi_trigger_create(struct psi_group *group,
>          |                     ^~~~~~~~~~~~~~~~~~
> >> kernel/sched/psi.c:1193:6: warning: no previous prototype for 'psi_trigger_destroy' [-Wmissing-prototypes]
>     1193 | void psi_trigger_destroy(struct psi_trigger *t)
>          |      ^~~~~~~~~~~~~~~~~~~
>    kernel/sched/psi.c:1260:10: warning: no previous prototype for 'psi_trigger_poll' [-Wmissing-prototypes]
>     1260 | __poll_t psi_trigger_poll(void **trigger_ptr,
>          |          ^~~~~~~~~~~~~~~~
>

https://lore.kernel.org/all/YemFa5ouZXEnR%2FD+@cmpxchg.org fixes these warnings.

>
> vim +/psi_trigger_destroy +1193 kernel/sched/psi.c
>
>   1192
> > 1193  void psi_trigger_destroy(struct psi_trigger *t)
>   1194  {
>   1195          struct psi_group *group;
>   1196          struct task_struct *task_to_destroy = NULL;
>   1197
>   1198          /*
>   1199           * We do not check psi_disabled since it might have been disabled after
>   1200           * the trigger got created.
>   1201           */
>   1202          if (!t)
>   1203                  return;
>   1204
>   1205          group = t->group;
>   1206          /*
>   1207           * Wakeup waiters to stop polling. Can happen if cgroup is deleted
>   1208           * from under a polling process.
>   1209           */
>   1210          wake_up_interruptible(&t->event_wait);
>   1211
>   1212          mutex_lock(&group->trigger_lock);
>   1213
>   1214          if (!list_empty(&t->node)) {
>   1215                  struct psi_trigger *tmp;
>   1216                  u64 period = ULLONG_MAX;
>   1217
>   1218                  list_del(&t->node);
>   1219                  group->nr_triggers[t->state]--;
>   1220                  if (!group->nr_triggers[t->state])
>   1221                          group->poll_states &= ~(1 << t->state);
>   1222                  /* reset min update period for the remaining triggers */
>   1223                  list_for_each_entry(tmp, &group->triggers, node)
>   1224                          period = min(period, div_u64(tmp->win.size,
>   1225                                          UPDATES_PER_WINDOW));
>   1226                  group->poll_min_period = period;
>   1227                  /* Destroy poll_task when the last trigger is destroyed */
>   1228                  if (group->poll_states == 0) {
>   1229                          group->polling_until = 0;
>   1230                          task_to_destroy = rcu_dereference_protected(
>   1231                                          group->poll_task,
>   1232                                          lockdep_is_held(&group->trigger_lock));
>   1233                          rcu_assign_pointer(group->poll_task, NULL);
>   1234                          del_timer(&group->poll_timer);
>   1235                  }
>   1236          }
>   1237
>   1238          mutex_unlock(&group->trigger_lock);
>   1239
>   1240          /*
>   1241           * Wait for psi_schedule_poll_work RCU to complete its read-side
>   1242           * critical section before destroying the trigger and optionally the
>   1243           * poll_task.
>   1244           */
>   1245          synchronize_rcu();
>   1246          /*
>   1247           * Stop kthread 'psimon' after releasing trigger_lock to prevent a
>   1248           * deadlock while waiting for psi_poll_work to acquire trigger_lock
>   1249           */
>   1250          if (task_to_destroy) {
>   1251                  /*
>   1252                   * After the RCU grace period has expired, the worker
>   1253                   * can no longer be found through group->poll_task.
>   1254                   */
>   1255                  kthread_stop(task_to_destroy);
>   1256          }
>   1257          kfree(t);
>   1258  }
>   1259
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
