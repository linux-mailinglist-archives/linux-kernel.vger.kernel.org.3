Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D3559D69
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiFXPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiFXPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:32:16 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ED49CBA;
        Fri, 24 Jun 2022 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1656084730;
        bh=ZP5BL4Jng6xuWoIRMawtSdlyPdyFXwUVPHgJ41CpfMY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=n7iKAs2xTENfQQUA2ayJsyZdYvdT8b5wVAIvwjhKliojMqorMmuCrkDD12Z0D2lEl
         9XdlMXdZsao+3f1J52VAMa7mmzKqOwilQDiUbeIyeBLddy4/gFN44piP7IZZSy1B3t
         fKeE90b63jN1wNroDARimZc9vcjNAPtApaWIxgRs=
Received: from [IPv6:240e:459:408:85f0:fd4f:c5b8:254f:b27d] ([240e:459:408:85f0:fd4f:c5b8:254f:b27d])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 7AB168EB; Fri, 24 Jun 2022 23:30:43 +0800
X-QQ-mid: xmsmtpt1656084643thc8mxkyc
Message-ID: <tencent_5C6A354D8C69190DB41D0E83D51195DBC108@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmFwRZuvAepI9jVCwitNz2QZLfHk0dZVu0gS7kMugdpERHeOGKvVC
         C3C9dRLh3tpOH4R7bjvLSG/3jcNsxYrXElD7rGTDFr9KHKWpSVCWjAqNHmspwerkB5ppIS7L3S6Q
         /LJRLWlweRFhyqPrdaC+LFsL55Pde1OLwdAmb6uPAJNxFvp3Ot48XHxzhoepCz3OJRATmQPDtofT
         ktlvx+tmSPWEkcP4G1k7lLzDqEcAej9xo/pcOBVXEyFtxLkpmlhsZONMv+uSM0cKvBfECGXiRqeS
         MFy68mUWALCoXMTM74qvla/ZEugsu0D4Kq2TxS7WBji+MoNRsX66sPMS0cBy2Nh1YAoDNm7TkoM3
         UXBBPC6rGL13hE2985p5Evc6sxIiNFdwEIywq7hrQMzriGYJTGP85EJPnELnDeu4WDqLmQzC3fB6
         nQ0gRcuMb9uMEsjzgt+Pu4lrn/EMyGDK0Sg+FzZZfU+Ry2ly0hOg6IDCUWEiMATxE1EALe+rdoEz
         QSmHrTQ6GiME9X+oCa6jLXGok1UFV0A+Cjh0SeBzTn/QBWW6dykvHitiBIPdP1zaenBYSSeVYY76
         VXPR2KEB0NDVdx//TR6DlK9QgJ6Dqj/su+5/6ZEfmkHNZ1NlIOZbSOeJG/htLUy7u/wAKHT4qmQw
         ySnu8DPoyGNfXaMOKPttvf+STcKHHOY6xFLIk5uoDJo5hkYcS+8EFAc3Z+3cIR72HTmxgFFdYKxV
         1AYl/QreOun2poxfp7C0p1HTdXdFssJAwz4VcuWzEgBr9dPdmFlu5l2lLeXUmE7egN7qYKuMyHUl
         1J8IKsR+k26+7VuFgU+ZeW2tP2l19nuCvMzz2SUEmyhc9LfY9qMEdua42j/EkGeN7H4AXvD3eLXB
         hvGN1nH9RfVLMAv7R9oXGGT5lhQIyTHiCZiRxgcNUkqMdjYXWlD6dkFxtbIZuS2Sp/MJ+n3ktOYJ
         paDz25XQ4+X+JQFr/Tog==
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
 <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
 <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
 <tencent_B1290D581DF1837711F4DB176ACB4D4F6908@qq.com>
 <3cf9b2de-39f6-34f1-b9de-19e5da8ddf8d@quicinc.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <2a77273e-1cf9-b67f-a898-a14612829abe@foxmail.com>
Date:   Fri, 24 Jun 2022 23:30:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3cf9b2de-39f6-34f1-b9de-19e5da8ddf8d@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/20 下午3:50, Neeraj Upadhyay wrote:
> Hi,
>
>
> On 6/18/2022 8:37 AM, zhangfei.gao@foxmail.com wrote:
>>
>>
>> On 2022/6/15 下午6:40, Neeraj Upadhyay wrote:
>>> Hi,
>>>
>>> On 6/15/2022 2:33 PM, zhangfei.gao@foxmail.com wrote:
>>>>
>>>>
>>>> On 2022/6/14 下午10:17, Paul E. McKenney wrote:
>>>>> On Tue, Jun 14, 2022 at 10:03:35PM +0800, zhangfei.gao@foxmail.com 
>>>>> wrote:
>>>>>>
>>>>>> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>>>>>>> 5.18-rc4 based ~8sec
>>>>>>>>
>>>>>>>> 5.19-rc1                     ~2m43sec
>>>>>>>>
>>>>>>>> 5.19-rc1+fix1                 ~19sec
>>>>>>>>
>>>>>>>> 5.19-rc1-fix2                 ~19sec
>>>>>>>>
>>>>>>> If you try below diff on top of either 5.19-rc1+fix1 or 
>>>>>>> 5.19-rc1-fix2 ;
>>>>>>> does it show any difference in boot time?
>>>>>>>
>>>>>>> --- a/kernel/rcu/srcutree.c
>>>>>>> +++ b/kernel/rcu/srcutree.c
>>>>>>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
>>>>>>> srcu_struct
>>>>>>> *ssp, struct srcu_node *snp
>>>>>>>    */
>>>>>>>   static void srcu_gp_end(struct srcu_struct *ssp)
>>>>>>>   {
>>>>>>> -       unsigned long cbdelay;
>>>>>>> +       unsigned long cbdelay = 1;
>>>>>>>          bool cbs;
>>>>>>>          bool last_lvl;
>>>>>>>          int cpu;
>>>>>>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct 
>>>>>>> *ssp)
>>>>>>>          spin_lock_irq_rcu_node(ssp);
>>>>>>>          idx = rcu_seq_state(ssp->srcu_gp_seq);
>>>>>>>          WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>>>>>>> -       cbdelay = !!srcu_get_delay(ssp);
>>>>>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>>>>>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>>>>>> +               cbdelay = 0;
>>>>>>> +
>>>>>>>          WRITE_ONCE(ssp->srcu_last_gp_end, 
>>>>>>> ktime_get_mono_fast_ns());
>>>>> Thank you both for the testing and the proposed fix!
>>>>>
>>>>>> Test here:
>>>>>> qemu: https://github.com/qemu/qemu/tree/stable-6.1
>>>>>> kernel:
>>>>>> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test 
>>>>>>
>>>>>> (in case test patch not clear, push in git tree)
>>>>>>
>>>>>> Hardware: aarch64
>>>>>>
>>>>>> 1. 5.18-rc6
>>>>>> real    0m8.402s
>>>>>> user    0m3.015s
>>>>>> sys     0m1.102s
>>>>>>
>>>>>> 2. 5.19-rc1
>>>>>> real    2m41.433s
>>>>>> user    0m3.097s
>>>>>> sys     0m1.177s
>>>>>>
>>>>>> 3. 5.19-rc1 + fix1 from Paul
>>>>>> real    2m43.404s
>>>>>> user    0m2.880s
>>>>>> sys     0m1.214s
>>>>>>
>>>>>> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
>>>>>> real    0m15.262s
>>>>>> user    0m3.003s
>>>>>> sys     0m1.033s
>>>>>>
>>>>>> When build kernel in the meantime, load time become longer.
>>>>>>
>>>>>> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
>>>>>> real    0m15.215s
>>>>>> user    0m2.942s
>>>>>> sys    0m1.172s
>>>>>>
>>>>>> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
>>>>>> real    1m23.936s
>>>>>> user    0m2.969s
>>>>>> sys    0m1.181s
>>>>> And thank you for the testing!
>>>>>
>>>>> Could you please try fix3 + Neeraj's change of srcu_gp_end?
>>>>>
>>>>> That is, fix1 + SRCU_MAX_NODELAY_PHASE 1000000 + Neeraj's change of
>>>>> srcu_gp_end.
>>>>>
>>>>> Also, at what value of SRCU_MAX_NODELAY_PHASE do the boot
>>>>> times start rising?  This is probably best done by starting with
>>>>> SRCU_MAX_NODELAY_PHASE=100000 and dividing by (say) ten on each run
>>>>> until boot time becomes slow, followed by a binary search between the
>>>>> last two values.  (The idea is to bias the search so that fast boot
>>>>> times are the common case.)
>>>>
>>>> SRCU_MAX_NODELAY_PHASE 100 becomes slower.
>>>>
>>>>
>>>> 8. 5.19-rc1 + fix6: fix4 + SRCU_MAX_NODELAY_PHASE 1000000
>>>>
>>>> real 0m11.154s ~12s
>>>>
>>>> user 0m2.919s
>>>>
>>>> sys 0m1.064s
>>>>
>>>>
>>>>
>>>> 9. 5.19-rc1 + fix7: fix4 + SRCU_MAX_NODELAY_PHASE 10000
>>>>
>>>> real 0m11.258s
>>>>
>>>> user 0m3.113s
>>>>
>>>> sys 0m1.073s
>>>>
>>>>
>>>>
>>>> 10. 5.19-rc1 + fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100
>>>>
>>>> real 0m30.053s ~ 32s
>>>>
>>>> user 0m2.827s
>>>>
>>>> sys 0m1.161s
>>>>
>>>>
>>>>
>>>> By the way, if build kernel on the board in the meantime (using 
>>>> memory), time become much longer.
>>>>
>>>> real 1m2.763s
>>>>
>>>>
>>>>
>>>> 11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000
>>>>
>>>> real 0m11.443s
>>>>
>>>> user 0m3.022s
>>>>
>>>> sys 0m1.052s
>>>>
>>>>
>>>
>>> This is useful data, thanks! Did you get chance to check between 100 
>>> and 1000, to narrow down further, from which point (does need to be 
>>> exact value) between 100 and 1000,  you start seeing degradation at, 
>>> for ex. 250, 500 , ...?
>>>
>>> Is it also possible to try experiment 10 and 11 with below diff.
>>> What I have done in below diff is, call srcu_get_delay() only once
>>> in try_check_zero() (and not for every loop iteration); also
>>> retry with a different delay for the extra iteration which is done
>>> when srcu_get_delay(ssp) returns 0.
>>>
>>> Once we have this data, can you also try by changing 
>>> SRCU_RETRY_CHECK_LONG_DELAY   to 100, on top of below diff.
>>>
>>> #define SRCU_RETRY_CHECK_LONG_DELAY  100
>>>
>>> ------------------------------------------------------------------------- 
>>>
>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>> index 6a354368ac1d..3aff2f3e99ab 100644
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -620,6 +620,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>>>   * we repeatedly block for 1-millisecond time periods.
>>>   */
>>>  #define SRCU_RETRY_CHECK_DELAY         5
>>> +#define SRCU_RETRY_CHECK_LONG_DELAY            5
>>>
>>>  /*
>>>   * Start an SRCU grace period.
>>> @@ -927,12 +928,17 @@ static void srcu_funnel_gp_start(struct 
>>> srcu_struct *ssp, struct srcu_data *sdp,
>>>   */
>>>  static bool try_check_zero(struct srcu_struct *ssp, int idx, int 
>>> trycount)
>>>  {
>>> +       unsigned long curdelay;
>>> +       curdelay = !srcu_get_delay(ssp);
>>>         for (;;) {
>>>                 if (srcu_readers_active_idx_check(ssp, idx))
>>>                         return true;
>>> -               if (--trycount + !srcu_get_delay(ssp) <= 0)
>>> +               if (--trycount + curdelay <= 0)
>>>                         return false;
>>> -               udelay(SRCU_RETRY_CHECK_DELAY);
>>> +               if (trycount)
>>> +                       udelay(SRCU_RETRY_CHECK_DELAY);
>>> +               else
>>> +                       udelay(SRCU_RETRY_CHECK_LONG_DELAY);
>>>         }
>>>  }
>>>
>>
>> 11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000
>>   real    0m11.443
>> s user    0m3.022
>> s sys    0m1.052s
>>
>> fix10: fix4 + SRCU_MAX_NODELAY_PHASE 500
>>
>> real    0m11.401s
>> user    0m2.798s
>> sys     0m1.328s
>>
>>
>> fix11: fix4 + SRCU_MAX_NODELAY_PHASE 250
>>
>>      real    0m15.748s
>>      user    0m2.781s
>>      sys     0m1.294s
>>
>>
>> fix12: fix4 + SRCU_MAX_NODELAY_PHASE 200
>>
>>      real    0m20.704s  21
>>      user    0m2.954s
>>      sys     0m1.226s
>>
>> fix13: fix4 + SRCU_MAX_NODELAY_PHASE 150
>>
>>      real    0m25.151s
>>      user    0m2.980s
>>      sys     0m1.256s
>>
>>
>> fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100
>> real    0m30.053s ~ 32s
>>   user    0m2.827s
>>   sys    0m1.161s
>>
>>
>> fix14: fix4 + SRCU_MAX_NODELAY_PHASE 100 + SRCU_RETRY_CHECK_LONG_DELAY 5
>>
>>      real    0m19.263s
>>      user    0m3.018s
>>      sys     0m1.211s
>>
>>
>>
>>      fix15: fix4 + SRCU_MAX_NODELAY_PHASE 100 + 
>> SRCU_RETRY_CHECK_LONG_DELAY 100
>>
>>      real    0m9.347s
>>      user    0m3.132s
>>      sys     0m1.041s
>>
>>
>
> Thanks. From the data and experiments done, looks to me that we get
> comparable (to 5.18-rc4 ) timings, when we retry without sleep for 
> time duration close to 4-5 ms, which could be closer to the configured 
> HZ (as it is 250)? Is it possible to try below configuration on top 
> of  fix15?
> If possible can you try with both HZ_1000 and HZ_250?
> As multiple fixes are getting combined in experiments, for clarity, 
> please also share the diff of srcutree.c (on top of baseline) for all 
> experiments.
>
> 16. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
> (long delay scaled to 1 jiffy)
>
>
> #define SRCU_MAX_NODELAY_TRY_CHECK_PHASE       10
> #define SRCU_MAX_NODELAY_PHASE (SRCU_MAX_NODELAY_TRY_CHECK_PHASE * 2)
> #define SRCU_RETRY_CHECK_LONG_DELAY           \
>   (USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE)
>
>
> 17. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
> (long delay scaled to 2 jiffy)
>
> #define SRCU_RETRY_CHECK_LONG_DELAY        \
>      (2 * USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE)
>
> 18. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
> (long delay scaled to 1/2 jiffy)
>
> #define SRCU_RETRY_CHECK_LONG_DELAY      \
>        (USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE / 2)

     fix16: fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() 
calls) + (long delay scaled to 1 jiffy)

     real    0m10.120s
     user    0m3.885s
     sys     0m1.040s


     fix17: fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() 
calls) + (long delay scaled to 2 jiffy)

     real    0m9.851s
     user    0m3.886s
     sys     0m1.011s


     fix18: fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() 
calls) + (long delay scaled to 1/2 jiffy)

     real    0m9.741s
     user    0m3.837s
     sys     0m1.060s

code push to
https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test


