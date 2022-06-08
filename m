Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808D654263F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbiFHCrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447306AbiFHClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:41:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6601915FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:21:13 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH09N659i388mAA--.57253S3;
        Wed, 08 Jun 2022 08:20:29 +0800 (CST)
Subject: Re: [PATCH] samples: Use KSYM_NAME_LEN for fprobe and kprobes
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <1654594536-2915-1-git-send-email-yangtiezhu@loongson.cn>
 <20220608011739.4331f96f3354e05f23c26dde@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <491cda3a-2e2e-fde7-1b4d-2261b95651fe@loongson.cn>
Date:   Wed, 8 Jun 2022 08:20:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220608011739.4331f96f3354e05f23c26dde@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxH09N659i388mAA--.57253S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF48WF15WFW7tw45Gry8Zrb_yoW3trb_Ca
        4fGryrCw4DWw4Sq3WUK3y5XFWDt39xWw4DJw1UW342y3sYq343Wa18GrnY9w40qFsrtFnr
        Wr1v9345ZF1UXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6w1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUU_cTDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2022 12:17 AM, Masami Hiramatsu (Google) wrote:
> On Tue,  7 Jun 2022 17:35:36 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> It is better and enough to use KSYM_NAME_LEN for fprobe and kprobes
>> in samples, no need to define and use the other values.
>>
>
> This is good for kprobe and kretprobe examples because it will get
> a single symbol name, but not good for the fprobe. It can take
> several comma separated symbols.
>
> -----
> static int __init fprobe_init(void)
> {
> ...
>         /* Comma separated symbols */
>         symbuf = kstrdup(symbol, GFP_KERNEL);
>         if (!symbuf)
>                 return -ENOMEM;
>         p = symbuf;
>         count = 1;
>         while ((p = strchr(++p, ',')) != NULL)
>                 count++;
>
>         pr_info("%d symbols found\n", count);
> -----
>
> Can you drop the fprobe_example.c part?
>

OK, I will send v2 later, thank you.

Thanks,
Tiezhu

