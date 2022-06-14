Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CE54B400
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiFNO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbiFNO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:57:19 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6D3E0E7;
        Tue, 14 Jun 2022 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1655218630;
        bh=0nMDlZXludiskWCOiMWtnzWVfpu4/zibgioslu+JbyY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YNBwxdHzuzdTX/OIUg4HV+18F9zmLPzXaDTfO1cjPeEhtvUz/wuMKMRtrZ2qFHGCR
         DfMYaQN9m+dVrn+YuYgceL1bqVfn+k4ZRLs8lUezEdMbVyMymD/6lt3ko1tYvzkeN3
         BQAyhdUmq63yYGmaqBUY9oBuRY8BJ+7n0FqmeZYU=
Received: from [IPv6:240e:45a:409:26e3:89c6:2747:8c5d:8528] ([240e:45a:409:26e3:89c6:2747:8c5d:8528])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id E450B89D; Tue, 14 Jun 2022 22:57:05 +0800
X-QQ-mid: xmsmtpt1655218625tl6pwbbf4
Message-ID: <tencent_0783451107DBB16AC54D4269800D941D0708@qq.com>
X-QQ-XMAILINFO: OUMxvQDaATieMiUh2n1Avjefg+SQ93TNwb1l/F2hnTg4Ml5WECC3al920hN2AY
         6lCMLqVBow5EJUY6IUb+bc6X00dQTkH/N4h9VJtup0lic3QrY9Al2BsezpW08U7MjNGm3sq90D4G
         FzoJ7c02+Q9qP59HNR8v3devgfoPCBKh7PmUnfl5aYugxR8bdZhpGWe5gS7eaKJiDFd/zD5l81p8
         kyXmuJTyDJ1OALHi+pxiw9qzQeG3DH2D3DJDsDNHOzkLVyNrudebe3odKmb5yYKLywxx8hhaq6Sy
         A6vJDPKXbmv7EgBajLU5FGBWBEoWQdia+ISEEYWQ0GAZr0/P3XPZZjAQyK1W28cBHDJVt2MlFzgq
         36tEyjJ3IgyIfQ3u3Tpmb1py/jNFSnrVwsJgwTw9BmK8YOep5ne7ld93R9jwi6JRX5vtK/tu1edL
         FV/yb+WhEDndnefb7SE3jQUqrjZRbW5zQLT8OEaPr+dbTkHhYoTlqtjMFgB9icjUFN4YeBeS8Qbh
         RggQTze26wmqfRhoShejpVmU1RP1ERZa+23Bfx3pKH9Cm2z8m6XB4cndw6WH2YsZlspoA1mYV1Ae
         +QrtHE7O2jqEnsQvrUQLBAbmUUcQg5+dqNRVTtjnbnBd3TkARE+kRZyfUdWIknJUpm9UQr3/AQLM
         ZnjelpOEBmN9rcfAv9dLmNhhF1/aUAjhmCO0Am7BP9X1cqj2mx2Hs7V3WVxLFBxWbT0znOzcwbLa
         Q27vBRWR+eQ/Xo2CcgxBGJHBDGrEm3Iq2yX9g0jEjulE1Ohs3l5z3WJwMXpeY6uNzGB4FV+mUT/V
         gbheBy61kBJw83FsvS9qTrSmJU6HCCz3dqwtpoteKA7IuXTGdDLKa+HTVWWZGOKNvB3ljBbBw2x6
         f2JXU3cBGQEa0dWrjKBxWpy+shp9wEMWw97UVPHFhBRBEpPXwG4tyHD83FPSxxCypNFgO4d/P+rI
         g9NtCk3Vu7pIHoJjsim6COyE1ZWhpkQdA5//LP9DKzZNXkFQ1tHMhXMCMTBStlOiz7gpMPjRM=
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
 <88780123-32a3-ab34-cd3d-01e4a3421f03@quicinc.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <b94fb96c-7965-e50d-5c71-ca83d0368233@foxmail.com>
Date:   Tue, 14 Jun 2022 22:57:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88780123-32a3-ab34-cd3d-01e4a3421f03@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 下午10:14, Neeraj Upadhyay wrote:
>
>
> On 6/14/2022 7:33 PM, zhangfei.gao@foxmail.com wrote:
>>
>>
>> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>>
>>>>
>>>> 5.18-rc4 based               ~8sec
>>>>
>>>> 5.19-rc1                     ~2m43sec
>>>>
>>>> 5.19-rc1+fix1                 ~19sec
>>>>
>>>> 5.19-rc1-fix2                 ~19sec
>>>>
>>>
>>> If you try below diff on top of either 5.19-rc1+fix1 or 
>>> 5.19-rc1-fix2 ; does it show any difference in boot time?
>>>
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
>>> srcu_struct *ssp, struct srcu_node *snp
>>>   */
>>>  static void srcu_gp_end(struct srcu_struct *ssp)
>>>  {
>>> -       unsigned long cbdelay;
>>> +       unsigned long cbdelay = 1;
>>>         bool cbs;
>>>         bool last_lvl;
>>>         int cpu;
>>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>>         spin_lock_irq_rcu_node(ssp);
>>>         idx = rcu_seq_state(ssp->srcu_gp_seq);
>>>         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>>> -       cbdelay = !!srcu_get_delay(ssp);
>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), 
>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>> +               cbdelay = 0;
>>> +
>>>         WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>>>
>> Test here:
>> qemu: https://github.com/qemu/qemu/tree/stable-6.1
>> kernel: 
>> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test
>> (in case test patch not clear, push in git tree)
>>
>> Hardware: aarch64
>>
>> 1. 5.18-rc6
>> real    0m8.402s
>> user    0m3.015s
>> sys     0m1.102s
>>
>> 2. 5.19-rc1
>> real    2m41.433s
>> user    0m3.097s
>> sys     0m1.177s
>>
>> 3. 5.19-rc1 + fix1 from Paul
>> real    2m43.404s
>> user    0m2.880s
>> sys     0m1.214s
>>
>> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
>> real    0m15.262s
>> user    0m3.003s
>> sys     0m1.033s
>>
>> When build kernel in the meantime, load time become longer.
>>
>> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
>> real    0m15.215s
>> user    0m2.942s
>> sys    0m1.172s
>>
>> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
>> real    1m23.936s
>> user    0m2.969s
>> sys    0m1.181s
>>
>
7. 5.19-rc1 + fix5: fix4 + Remove "if (!jbase)" block

real 0m11.418s

user 0m3.031s

sys 0m1.067s



8. 5.19-rc1 + fix 6: fix4 + SRCU_MAX_NODELAY_PHASE 1000000

real 0m11.154s ~12s

user 0m2.919s

sys 0m1.064s


Thanks

> Thanks for this data. Can you please share below test combo also?
>
> 7. 5.19-rc1 + fix5: fix2 + Neeraj's change of srcu_gp_end
>
>
> 8. 5.19-rc1 + fix6: fix3 + Neeraj's change of srcu_gp_end
>
>
> Thanks
> Neeraj
>
>> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5
>>
>> Thanks
>>

