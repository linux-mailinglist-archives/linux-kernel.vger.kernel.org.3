Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBB4B7F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbiBPELx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:11:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiBPELw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:11:52 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050847571;
        Tue, 15 Feb 2022 20:11:39 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E3FF5807DA;
        Tue, 15 Feb 2022 23:11:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 15 Feb 2022 23:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=kolEHV+tRbVvR2
        OMljSjc5aBPQCjdffrRjdupqvTrgQ=; b=FnBuJp0FCRF6IpswJC5A/vXEBYt8bE
        EQJ+yCiMfww0kMnzl/cCTC1FnqGAIhuMg73KnBhZSdJ8gEOINTM1S46qQIvElj8q
        BKsgkze3/wX5XLNvozzV1FlK3yykIikm+IVOt0mqEmAIqHEJjuznnFhyMiGb/u6A
        smdisjm/Mp5bpY1sQmH6xmhy71maf3kIE2+Y41EUTRpgIboGvRa1suQ/Vlrd+4tE
        cA66Bk7sfEJybgsgJdsYAR/dP6Yov57lryV4IHfPmWiMIBgEFB3AemCHOd5sZKm0
        YixpPjSki6awJJ38qhbBVKvU7HkJTUQY8LgIvLBVhuaMP2RBnOE8rX+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=kolEHV+tRbVvR2OMljSjc5aBPQCjdffrRjdupqvTr
        gQ=; b=SC+3oCoJeZWdvETkiLaSGrpmuMdfGQ6msIw5VPWkd8XSdwvOtrVWAd0t0
        ioX/tDltsNtFFGKmF9hdbA6AWzql+ur+Lq/ZOsXCzs7Dk9VeKN534NCvA5J2vwCV
        NpLAvq+N55t7+uzB1oWROeHBWoa2BlBMftoDVfSM/BgC8HYNmtATUGtd+Jmj7GM+
        exqivPzLD2i832cr3sIosKWC4zeD1N+n8TSv557gUo9DF7KQHEz/eGhibLvg9HEU
        uiUeNP1v0TBV38tYAeV2w2iilvDrDcSHP4sVBOKQr6HdAT4u8okSNgDWjaPe32k0
        HIL7c53mH2m5ErPmh4ANn/Xz6HnxQ==
X-ME-Sender: <xms:eXkMYp7IY3a8ZLi9ydrp5FW8KsIVtpP6iGAQ7KovK8EBwrCtGjy-Yw>
    <xme:eXkMYm57WEy7MPasSMNk5k6fSqlOIYbXHRqX6nyYlGFTCeKqNEUEnkAu1dMBM3f9h
    kcEwG-MP5zTWo7Bxw>
X-ME-Received: <xmr:eXkMYge6WSXwdFFunsEyquvymItfFP1R9r_1BEnSJOJJFkNDts_nxO6-itzEb3l5lgmsH3_VjSEsOoSohc4NACO6x7hY-QMXwZKsxRm5VEcUBtLCKhZB_9DS1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefhkeduvedvteetgeffueegjeeuueeljeeghfekvdefkeeiueffjeei
    jeeukeeitdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:eXkMYiLrrVmS1dXVo3Lu_z2bTn3-VW-M5YPnObIj0Jr6DtPKjhxduw>
    <xmx:eXkMYtJt6evYtpGxlZGuzXo1LS8dl6TOMaZWLlF4O6sJ2P3VvE-ddw>
    <xmx:eXkMYrwKjQUitgx0iggWnfJtF5XGEtqv_G7Isfhi5L0UpCqKAnDsKg>
    <xmx:enkMYmUYfInpjvoIv1DcQPb4rC8mCMoJT-aVMNzkAO63-UxGy3FymQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Feb 2022 23:11:37 -0500 (EST)
Subject: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Klein <michael@fossekall.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
 <20220215002732.GA3215504@roeck-us.net> <4714494.31r3eYUQgx@kista>
 <23df0d53-d530-2363-09c9-5be2b2306a81@roeck-us.net>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <35ca9258-3129-240c-7a0a-cacfa0a13253@sholland.org>
Date:   Tue, 15 Feb 2022 22:11:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <23df0d53-d530-2363-09c9-5be2b2306a81@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 4:20 PM, Guenter Roeck wrote:
> On 2/15/22 12:34, Jernej Škrabec wrote:
>> Hi!
>>
>> Dne torek, 15. februar 2022 ob 01:27:32 CET je Guenter Roeck napisal(a):
>>> Hi,
>>>
>>> On Mon, Nov 29, 2021 at 05:55:10PM +0100, Jernej Skrabec wrote:
>>>> Several H3 and one H2+ board have power key nodes, which are slightly
>>>> off. Some are missing wakeup-source property and some have BTN_0 code
>>>> assigned instead of KEY_POWER.
>>>>
>>>> Adjust them, so they can function as intended by designer.
>>>>
>>>> Co-developed-by: Michael Klein <michael@fossekall.de>
>>>> Signed-off-by: Michael Klein <michael@fossekall.de>
>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>
>>> This patch results in the following traceback when rebooting an
>>> orangepi-pc qemu emulation.
>>>
>>> [   30.899594]
>>> [   30.899685] ============================================
>>> [   30.899757] WARNING: possible recursive locking detected
>>> [   30.899938] 5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
>>> [   30.900055] --------------------------------------------
>>> [   30.900124] init/307 is trying to acquire lock:
>>> [   30.900246] c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at:
>> __irq_get_desc_lock+0x58/0xa0
>>> [   30.900900]
>>> [   30.900900] but task is already holding lock:
>>> [   30.900974] c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at:
>> __irq_get_desc_lock+0x58/0xa0
>>> [   30.901101]
>>> [   30.901101] other info that might help us debug this:
>>> [   30.901188]  Possible unsafe locking scenario:
>>> [   30.901188]
>>> [   30.901262]        CPU0
>>> [   30.901301]        ----
>>> [   30.901339]   lock(&irq_desc_lock_class);
>>> [   30.901411]   lock(&irq_desc_lock_class);
>>> [   30.901480]
>>> [   30.901480]  *** DEADLOCK ***
>>> [   30.901480]
>>> [   30.901554]  May be due to missing lock nesting notation
>>> [   30.901554]
>>> [   30.901657] 4 locks held by init/307:
>>> [   30.901724]  #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at:
>> __do_sys_reboot+0x90/0x23c
>>> [   30.901889]  #1: c20f7760 (&dev->mutex){....}-{3:3}, at:
>> device_shutdown+0xf4/0x224
>>> [   30.902016]  #2: c2e804d8 (&dev->mutex){....}-{3:3}, at:
>> device_shutdown+0x104/0x224
>>> [   30.902138]  #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at:
>> __irq_get_desc_lock+0x58/0xa0
>>> [   30.902281]
>>> [   30.902281] stack backtrace:
>>> [   30.902462] CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-
>> gc849047c2473 #1
>>> [   30.902572] Hardware name: Allwinner sun8i Family
>>> [   30.902781]  unwind_backtrace from show_stack+0x10/0x14
>>> [   30.902895]  show_stack from dump_stack_lvl+0x68/0x90
>>> [   30.902970]  dump_stack_lvl from __lock_acquire+0x1680/0x31a0
>>> [   30.903047]  __lock_acquire from lock_acquire+0x148/0x3dc
>>> [   30.903118]  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>>> [   30.903197]  _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
>>> [   30.903282]  __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
>>> [   30.903366]  irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
>>> [   30.903442]  irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
>>> [   30.903523]  gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
>>> [   30.903603]  gpio_keys_shutdown from device_shutdown+0x180/0x224
>>> [   30.903685]  device_shutdown from __do_sys_reboot+0x134/0x23c
>>> [   30.903764]  __do_sys_reboot from ret_fast_syscall+0x0/0x1c
>>> [   30.903894] Exception stack(0xc584ffa8 to 0xc584fff0)
>>> [   30.904013] ffa0:                   01234567 000c623f fee1dead 28121969
>> 01234567 00000000
>>> [   30.904117] ffc0: 01234567 000c623f 00000001 00000058 000d85c0 00000000
>> 00000000 00000000
>>> [   30.904213] ffe0: 000d8298 be84ddf4 000918bc b6eb0edc
>>> [   30.905189] reboot: Restarting system
>>>
>>> The warning is no longer seen after reverting this patch.
>>>
>>> The problem exists but is not seen in v5.17-rc4 because a bug in commit
>>> 8df89a7cbc63 ("pinctrl-sunxi: don't call pinctrl_gpio_direction()")
>>> hides it. That problem is fixed with commit 3c5412cdec9f ("pinctrl-sunxi:
>>> sunxi_pinctrl_gpio_direction_in/output: use correct offset") in linux-next,
>>> and the traceback is seen there.
>>
>> Hm... These DT changes were tested with many users on older kernels for some
>> time now and new properties conform to bindings. Should we revert pinctrl
>> changes?
>>
> 
> I don't think those changes were tested with orangepi-pc on real hardware.
> Maybe I didn't explain it clearly enough: Commit 8df89a7cbc63 does _not_
> introduce the problem. It hides the problem. Reverting commit 8df89a7cbc63
> won't help but result in exactly the same backtrace (I tried).
> 
> Some more details: This commit introduces "wakeup-source;" to various
> orangepi-pc nodes. This triggers in a call to sunxi_pinctrl_irq_set_wake(),
> which did not happen before and which may result in the traceback.

I don't think there is any real issue here. The two irq_desc's being locked are
always different, so there is no deadlock. This recursive irq_set_irq_wake seems
to be a reasonably common pattern in GPIO drivers, and several of them contain
code to silence lockdep. I've sent a patch adding a copy of that to the sunxi
driver:

https://lore.kernel.org/lkml/20220216040037.22730-1-samuel@sholland.org/

Please see if it works for you.

Regards,
Samuel
