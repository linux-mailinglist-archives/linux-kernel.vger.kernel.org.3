Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A227552898
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbiFUAWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFUAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:22:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF71BEAD;
        Mon, 20 Jun 2022 17:22:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cf14so7420047edb.8;
        Mon, 20 Jun 2022 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBQHNcIvWbzItzK5U7IJCL4dlLtPmVDS/r40+ZSQT4E=;
        b=qPrTvW2vvb4skIvM0DW9LtbBQcRIg5r8k2H2tS8uVNntWDdRyQz8gZugD8/94tFMjh
         qEZBKWlZ5XTyjX2DwVnllmp0KyXeH3M02/emNxZ06UDHNEqpf2hIPHoZnXWFtvybUkRu
         2xGiBNG0wSsz6pj9iHKoAoIrrtRc9wCktOtLXWB41iH3U6sgxEGWDI6zE8GWHpTohCIa
         4ZjQhxuOgIrk0pU3iOW+xa2Ha7RiCJf647TgqBEMU3EJnyPenlUUhJgfhQ58DayQK7+O
         8gdW+nkx0c/A2G3WCY2bSU3ZDxm4W89Dr3ZHIj5VMnfRiZxiqzZaX9mTy+C7bNNix+pH
         8v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBQHNcIvWbzItzK5U7IJCL4dlLtPmVDS/r40+ZSQT4E=;
        b=VlbYHSU4Zn8b0zRhBABwq0WnbKSQNI0ZT5gn0Ac6M3NAYN4QypTC8DbAWO0geQD0xI
         woOQ/2GAImgJ14lXuWHbdOaJkUYoRy7EBgBXKBrUdkXVoVzOR6gRTIeNku6sFwEbYazU
         AOajHYknmtIe2rCxl3N7rByl/D/9521gy1EYRr4K62DQ8k3MHhgebZoDuPEFJk95U6rJ
         u6uEtt1x9+WtU+VrvEwNKODbHGrEfDuA2Fy2OkD05BVt32exuEH8bZQqCXjBpLi7fvis
         iljNFR1JJN7uFoPo5zfqhJi06uTbRAf6d9bjEoRCMkDPm9PkTS20UJoyqAh5wZL28YgX
         hWhA==
X-Gm-Message-State: AJIora8VJc2zYWVLclEqAjshtsVZjI7MCc4sjSIln7u+hikIi+ztAg9s
        vJX7xsvmr184Rw9yYvq9GM+gw/PqjA2xGdW/pJ8=
X-Google-Smtp-Source: AGRyM1uLIBB4R9d3YPDmTtd+zLHrQy434vBVRaC8oNIqqMLrihq9bioYSc8jJWeSst9WeJyiiyE/COcgHd3TdGcPwck=
X-Received: by 2002:a05:6402:190d:b0:435:9683:bffa with SMTP id
 e13-20020a056402190d00b004359683bffamr617201edz.309.1655770947712; Mon, 20
 Jun 2022 17:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220615003733.16447-1-zhouzhouyi@gmail.com> <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wCos5xupRQ2LbJtaLVN1a7i0D5kwaVTq9DEov8C46Gkw@mail.gmail.com>
 <20220615135220.GI1790663@paulmck-ThinkPad-P17-Gen-1> <20220615190936.GA713726@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wstbe+Exa3NWWygOAF5S4BtHfgJcb_r78uz-jq2KtU9Q@mail.gmail.com>
In-Reply-To: <CAABZP2wstbe+Exa3NWWygOAF5S4BtHfgJcb_r78uz-jq2KtU9Q@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 21 Jun 2022 08:22:15 +0800
Message-ID: <CAABZP2yLfpoaX82Nwg_QPWmF+ATMhetykN+k1fo624PWSKaHtg@mail.gmail.com>
Subject: Re: [PATCH linux-next] RFC: torture: add pr_flush to flush the
 results to console
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     john.ogness@linutronix.de, pmladek@suse.com, dave@stgolabs.net,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add Masahiro to CC list]

1. Abstract:
During the test of  0ba7324b44282870af740a5a121add62c7f5f730 ("printk:
Wait for the global console lock when the system is going down"), I
found
0ba7324b44282870af740a5a121add62c7f5f730 itself is OK. But I guess
31cb50b5590fe911077b8463ad01144fac8fa4f3 ("kbuild: check static
EXPORT_SYMBOL* by script instead of modpost")
lead to build systems failing in a random way.

2. Introduction:
To test 0ba7324b44282870af740a5a121add62c7f5f730 ("printk: Wait for
the global console lock when the system is going down"), I do
following both on
my Dell PowerEdge R720 server (128G memory, 16 core Intel(R) Xeon(R)
CPU E5-2660) and my Thinkpad T14 amd laptop (40G memory, 8 core AMD
Ryzen 7 PRO 4750U)
#git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
#cd linux-rcu
#git checkout remotes/origin/pmladek.2022.06.15a
#./tools/testing/selftests/rcutorture/bin/torture.sh

3. The Testing
3.1
On Dell PowerEdge R720 server, I performed torture.sh for 6 rounds
(each cost 12 hours to finish)
five of them report build failure, for example:
root@42d29c5cef4b:/mnt/linux-rcu/tools/testing/selftests/rcutorture/res#
find . -name Make.out|xargs grep Error
./2022.06.19-09.29.42-torture/results-rcutorture/TREE07/Make.out:make[2]:
*** [scripts/Makefile.build:249: security/selinux/ss/services.o] Error
255
./2022.06.19-09.29.42-torture/results-rcutorture/TREE07/Make.out:make[1]:
*** [scripts/Makefile.build:466: security/selinux] Error 2
./2022.06.19-09.29.42-torture/results-rcutorture/TREE07/Make.out:make:
*** [Makefile:1839: security] Error 2
one of them passed all the tests:
Started at Mon Jun 20 06:09:33 CST 2022, ended at Mon Jun 20 18:34:30
CST 2022, duration 12:24:57.
Summary: Successes: 49 Failures: 0.
Size before compressing 60 files: 66G Mon Jun 20 18:34:30 CST 2022
Waiting for batch 1 of 32 compressions Mon Jun 20 18:34:30 CST 2022
Waiting for final batch 2 of 28 compressions Mon Jun 20 19:12:03 CST 2022
Size after compressing 60 files: 15G Mon Jun 20 19:46:42 CST 2022
3.2
On Thinkpad T14 amd laptop, I performed torture.sh for 2 rounds (each
cost 13 hours to finish)
one of them report build failure:
zzy@zzy-ThinkPad-T14-Gen-1:~/Program/linux-rcu/tools/testing/selftests/rcutorture/res$
find . -name Make.out|xargs grep Error
./2022.06.17-22.45.37-torture/results-refscale-refcnt-kasan/NOPREEMPT/Make.out:make[1]:
*** [scripts/Makefile.build:249: arch/x86/boot/pm.o] Error 255
./2022.06.17-22.45.37-torture/results-refscale-refcnt-kasan/NOPREEMPT/Make.out:make:
*** [arch/x86/Makefile:265: bzImage] Error 2
another passed all the tests:

4. Guess what caused the build error
On Dell PowerEdge R720:
root@42d29c5cef4b:/mnt/linux-rcu/tools/testing/selftests/rcutorture/res#
find . -name Make.out|xargs grep Error
./2022.06.19-09.29.42-torture/results-rcutorture/TREE07/Make.out:make[2]:
*** [scripts/Makefile.build:249: security/selinux/ss/services.o] Error
255
root@42d29c5cef4b:/mnt/linux-rcu/tools/testing/selftests/rcutorture/res#
emacs ./2022.06.19-09.29.42-torture/results-rcutorture/TREE07/Make.out
I search services.o in my emacs editor, the only clue is:
./scripts/check-local-export security/selinux/ss/services.o
make[2]: *** [scripts/Makefile.build:249:
security/selinux/ss/services.o] Error 255
make[2]: *** Deleting file 'security/selinux/ss/services.o'
make[2]: *** Waiting for unfinished jobs....

5. Try to trace
I have tried to trace the root cause of the problem, by modifying
scripts/check-local-export:
diff --git a/scripts/check-local-export b/scripts/check-local-export
index da745e2743b7..a66ff333f22b 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -12,7 +12,7 @@ declare -A symbol_types
 declare -a export_symbols

 exit_code=0
-
+cp ${1} /mnt/tmp/
 while read value type name
 do
        # Skip the line if the number of fields is less than 3.
@@ -48,7 +48,7 @@ do
        #
        # Then, the following line will be really simple:
        #   done < <(${NM} --quiet ${1})
-done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
+done < <(${NM} ${1}  || { echo "${0}: ${NM} failed"
>>/mnt/tmp/log-check ; false; } )

 # Catch error in the process substitution
 wait $!
@@ -57,7 +57,7 @@ for name in "${export_symbols[@]}"
 do
        # nm(3) says "If lowercase, the symbol is usually local"
        if [[ ${symbol_types[$name]} =~ [a-z] ]]; then
-               echo "$@: error: local symbol '${name}' was exported" >&2
+               echo "$@: error: local symbol '${name}' was exported"
>> /mnt/tmp/log-check
                exit_code=1
        fi
 done

Then I invoke torture.sh again, but after two rounds of test, the bug
did not appear, so I can't trace anything.

6. Conclusion
Sorry to bring you so much trouble, I am very interested in this.
Could you please tell me what to do next?

Thanks
Zhouyi

On Thu, Jun 16, 2022 at 4:28 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Thank Paul and Petr for your efforts!
>
> On Thu, Jun 16, 2022 at 3:09 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jun 15, 2022 at 06:52:20AM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 15, 2022 at 08:36:54PM +0800, Zhouyi Zhou wrote:
> > > > On Wed, Jun 15, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 15, 2022 at 08:37:33AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > >
> > > > > > currently tools/testing/selftests/rcutorture/bin/torture.sh reports
> > > > > > false positve because of kthread printing.
> > > > > >
> > > > > > Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
> > > > > > have added functions to prefer direct printing activated for the primary
> > > > > > import messages.
> > > > > >
> > > > > > Meanwhile adding printk_prefer_direct_enter/exit to
> > > > > > torture_cleanup_begin/end still can't eliminate the false positives
> > > > > > for a hundred percent.
> > > > > >
> > > > > > This patch add pr_flush to torture_cleanup_end because the latter
> > > > > > is sleepable.
> > > > > >
> > > > > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > >
> > > > > Just the one Signed-off-by suffices.  ;-)
> > > > Thank Paul for your guidance ;-)
> > > > >
> > > > > > ---
> > > > > >  kernel/torture.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > > > > index 789aeb0e1159..b51e42463a67 100644
> > > > > > --- a/kernel/torture.c
> > > > > > +++ b/kernel/torture.c
> > > > > > @@ -878,6 +878,7 @@ void torture_cleanup_end(void)
> > > > > >       mutex_lock(&fullstop_mutex);
> > > > > >       torture_type = NULL;
> > > > > >       mutex_unlock(&fullstop_mutex);
> > > > > > +     pr_flush(1000, true);
> > > > >
> > > > > But in this case, the kernel keeps on running, correct?  So won't the
> > > > > output appear over time?  All of printk()'s kthreads are still running
> > > > > after all.
> > > > I am doing research on linux-next following your guidance on my Dell
> > > > PowerEdge R720 server:
> > > > #git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git/
> > > > #cd linux-next
> > > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > > after about 14 hours, the test result show that there have been about
> > > > 17 failures, I examine the corresponding console.log, and find the
> > > > failures are caused by following reason:
> > > > before the message output by
> > > > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > > > SUCCESS") has reached serial console, torture_shutdown invoked
> > > > kernel_power_off(),
> > >
> > > Ah, got it!  And good show tracking this down, by the way.
> > >
> > > Does this workaround commit on -rcu do the trick for you?
> > >
> > > 704ae8dcda84 ("torture: Flush printk() buffers before powering off")
> > >
> > > The printk() guys are looking at fixes within the printk() system
> > > as well:
> > >
> > > https://lore.kernel.org/all/87tu8pgcj0.fsf@jogness.linutronix.de/
> > > https://lore.kernel.org/all/YqdSw%2FfJvnkRbjvc@alley/
> >
> > And Petr has posted a more official fix, which I have queued on -rcu
> > for testing at branch pmladek.2022.06.15a.
> I am very happy to see the official fix, and start test it on my Dell
> server by invoking
> ./tools/testing/selftests/rcutorture/bin/torture.sh
>
> It will take 12 hours for the above script to finish if the other guy
> who shares the server with me doesn't use it heavily ;-)
>
> Thanks
> Sincerely yours
> Zhouyi
> >
> >                                                         Thanx, Paul
> >
> > > > so the message "End of test: SUCCESS" has not chance of reaching
> > > > console.log of host machine.
> > > >
> > > > Then I add printk_prefer_direct_enter/exit to
> > > > torture_cleanup_begin/end, again I invoke
> > > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > > after about 14 hours, the test result show that there have been about
> > > > 5 failures,
> > > >
> > > > Then I add a debug statement after
> > > > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > > > SUCCESS") which sends the debug string ("hello world") to
> > > > uart_console_write directly, again I invoke
> > > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > > There is "hello world" in console.log but no "End of test" strings.
> > > >
> > > > So I guess even with printk_prefer_direct_enter/exit to
> > > > torture_cleanup_begin/end,  our main shutdown thread has failed in
> > > > competition for console lock (printk.c):
> > > > 2401 if (console_trylock_spinning())
> > > > 2402     console_unlock();
> > > >
> > > > Then I add pr_flush to torture_cleanup_end
> > > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > > after 14 hours
> > > > all 49 tests are success
> > > > >
> > > > > Or do you have a use case that requires that the output appear sooner
> > > > > than it does?  If so, please let me know what that is.
> > > > Thank Paul for your patience,
> > > > ./tools/testing/selftests/rcutorture/bin/torture.sh is the only tool
> > > > that I use.
> > > >
> > > > I am very interested in this topic, and very glad to do further
> > > > experiments under your guidance ;-)
> > >
> > > Or are you already running with that commit or one of those patches?
> > > They are working reliably for me (so far, anyway), but maybe more is
> > > needed in some cases.
> > >
> > >                                                       Thanx, Paul
> > >
> > > > Sincerely yours
> > > > Thanks
> > > > Zhouyi
> > > > >
> > > > >                                                         Thanx, Paul
> > > > >
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(torture_cleanup_end);
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
