Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855654B2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiFNODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFNODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:03:50 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E73883;
        Tue, 14 Jun 2022 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1655215425;
        bh=b+j3hfI52SuPbVR8+0Rma0F6k2hM1BhO8T4wYrdBWG4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lYLuGiA/IGGLaucMp/fFwuc+HQhZKA4CDzpmNbwW1U+IQXVOrY4fc9W0YGzqq89hX
         6AXqJWSUHK2qdP6fI34EKr65dlNG7NV5IqNuhpWN7ptNw/d4a+bzRn2Itie6Dm7Pjo
         qeaTxWl3HWprgxBWh9aOhVWCCsfFgNnDiFcy948U=
Received: from [IPv6:240e:45a:409:26e3:89c6:2747:8c5d:8528] ([240e:45a:409:26e3:89c6:2747:8c5d:8528])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id E88A091; Tue, 14 Jun 2022 22:03:40 +0800
X-QQ-mid: xmsmtpt1655215420t2ny1izu9
Message-ID: <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy702s701Wg5VwT1mROVrNO7zSBbQM60JMaejeyA4EMHVrtEyQiEhp
         hZ3rBlbgVlHcdZhKhw0sUoAKKkJ24It+CGPJjV+RHFSdXwJbMRAD53jS2y/loZGOpaqD+kmO9YZB
         0Fz9pjlFGKg94ojqZnH0fcQGPLnyRpCUsH/4unfLDT/G7tC4fkw29JR39vx6Jyo6/rxQlYyGcm6K
         evyn/epSRAKDLd+0DPX6U31MTSblE3iffi8VetpwqZArZn0/POGUlQX56re3R7gejBVLOIPrrYhI
         FLi6ShBJQ6vCNllZKrP1XVNjGkcxcUz4hBAXfc389qOKnYryYgSw4ZjWFhmjjyQGr9bIEIW/FBIU
         ydn/mDSVT5Fw8y18rCWfGcYzERSVuGPrkOxMPYLVjlJMLpvvwFH1OWppJZ1wMx1gKtDjh0sXIz+i
         +XKRdNEItsfqs6FskkkZxYTKDxATaUoRE/S0hkFPeHctFFYfmhVsrK7AKZJJ6+CxpyEpEV+6ZwWu
         imObWSGnjIjulVj8drQc6gE/8DU4KJ2W69RIe0PGG5HflYKwV3jtzwEmlqivN5Gf1YXU1XhORBA+
         3MyJcWqeN8IiCdwrLU7kHCQMjezSPlTAOfJamiIZ4xfs4EcQS0egayXS4ANyPofDcrM1P0E8Ehnw
         5xFeIM8PfDl7DIKKCr0Mt/smMt99EppSrVPriF8tcd6/+wOcpbBGlGMoTF9zG1obxNeFq71xfGxD
         vCGfKxgIIvaEp+3E496PkhwoBdNHzUSMKtOQqrFwYl9nsZvAkZ+sTuMiFP5m67pozNvlekhbslFo
         jn2ezjuUWKbQtwg9wpRxjJub2pSjxNUBOYmmWigYastaeoa/vGzeZTqxpgXU7R7uIG9j3GRny+hW
         shfHZwnCjDPoJ1lqeuDlAu7ojShPQ6MDEN3E5em3oRH71o5kVEHWoGSZ/2dSwtPQybK+smJz6LJi
         XvL3E8r8oONCL3Rp/FhKJXC8uBOGUq1WcAaSPwn1o=
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
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <f3b9a33f-fcf0-676b-e526-a885a945c414@foxmail.com>
Date:   Tue, 14 Jun 2022 22:03:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
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



On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>
>>
>> 5.18-rc4 based               ~8sec
>>
>> 5.19-rc1                     ~2m43sec
>>
>> 5.19-rc1+fix1                 ~19sec
>>
>> 5.19-rc1-fix2                 ~19sec
>>
>
> If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 
> ; does it show any difference in boot time?
>
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
> srcu_struct *ssp, struct srcu_node *snp
>   */
>  static void srcu_gp_end(struct srcu_struct *ssp)
>  {
> -       unsigned long cbdelay;
> +       unsigned long cbdelay = 1;
>         bool cbs;
>         bool last_lvl;
>         int cpu;
> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>         spin_lock_irq_rcu_node(ssp);
>         idx = rcu_seq_state(ssp->srcu_gp_seq);
>         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
> -       cbdelay = !!srcu_get_delay(ssp);
> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), 
> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> +               cbdelay = 0;
> +
>         WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>
Test here:
qemu: https://github.com/qemu/qemu/tree/stable-6.1
kernel: 
https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test
(in case test patch not clear, push in git tree)

Hardware: aarch64

1. 5.18-rc6
real    0m8.402s
user    0m3.015s
sys     0m1.102s

2. 5.19-rc1
real    2m41.433s
user    0m3.097s
sys     0m1.177s

3. 5.19-rc1 + fix1 from Paul
real    2m43.404s
user    0m2.880s
sys     0m1.214s

4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
real    0m15.262s
user    0m3.003s
sys     0m1.033s

When build kernel in the meantime, load time become longer.

5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
real    0m15.215s
user    0m2.942s
sys    0m1.172s

6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
real    1m23.936s
user    0m2.969s
sys    0m1.181s

More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5

Thanks

