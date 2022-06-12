Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71403547939
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiFLH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiFLH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 03:56:36 -0400
X-Greylist: delayed 738 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 00:56:34 PDT
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FCE5253C;
        Sun, 12 Jun 2022 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1655020591;
        bh=QMhylbueyCo/7BPY8vCWZuNj9P15lJcnsMLwPrTxgIo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UZd2FHE1F+IinUYlsYdKm92mXcMCl5bn+9p9eHr98waT1agvQeg/66A32yDFXDJtN
         6VsMXqCi67ELsLFgMe3zMb1u2/dAQTW4kGi4vjRQS3/zccqAKLC8ZynJnwFZfFu3hi
         4QbRRH/KFYaDTFS8uqyGcTnGEp+gBiXjw1xW7XLE=
Received: from [192.168.0.110] ([36.57.146.189])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id A1EA6858; Sun, 12 Jun 2022 15:40:30 +0800
X-QQ-mid: xmsmtpt1655019630tq8cebg5n
Message-ID: <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy706VL0L+2q/xRHRjEt+LTLGSrq12X/X6I6GuvNVXzfGrhtrmt2m3
         NXBHBI+clMBVKXf9ug2O8EyuEztg5R5mYXpiPtjjB0fdk7CGLyl6uDfOgtRdiIWW7uDSjmUQ2GR1
         +1Z+GSeHzveSIHt03d429k/Ca+6wK/1Z1oCCNCba0D9z0p++MMH8NZL2GYrIJjDbmt+fafsysRij
         ZKb1WKAFf45VnVDcLbWTP/D2nCoXum0sy17e9jAnkX3HuQQm/KFdWFE0X7Dey3QTeVK4Py6sWUeF
         MvGKMmgETJ4VEXId+cVT+lYuck1kTkOt2M9lnK1sMMtNY3skgf91IVRhB1aochvVBXTNQk8N9RHL
         petbVIIAJ7FApQjxXhPI9XHotUbxs1ASzBkl/+7BXQO+7CnNkTV7BIwn/rqpBkXczNnIVb9cbpqd
         6X6gaa3JBL+MVo94f3CcwM6TXDd+VFc+bCMbY7UUEdra0pyFXEQjQUb69bl8kAiEQqFrIMMwTe1y
         ZfADUDs5eDBkMZeEfPnaEg6XW+ykdMiEFrrgkKkns9UY1MI0DkW/FGg5mc52jJ2sfF/ft06JsPTP
         oUu7goW/+kalTQLowr00kUFEM8J/3o3X/ZigV2K7KLD5mm3iVSNHp/EIrSTWBEJTp3iDTdv1+l7Y
         I5XIyR8vbM7XHoQQNYHOdmhotZwx9msgkR64NoEGRvxBCXQLximHslX5b0xmRojvlp/szii5Yj1i
         LPUvTs/j9ZJbNOwhK9hYP5tliD5SRmqRq3rpPMXJZd8qbKo9CVYsADhROoMXX0RiNoaNEAQ27kWP
         tvKlL4RreK/gKHHchVV1IaiB+7Yu99RsNWSDXi0wsN0gB0BCcP1ZO1BXRfrgdeXQy74rREUqva53
         t8bm8UoyJSQu8UVsD4oOhdcRxxLCTNv852MYj+Q32FJMsh9H5VS+wLneJCu2+tWYxmaKbU8MGjEe
         D1Pe2aLuQeCBlh92xYqw==
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
To:     paulmck@kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <c7b12b7c-43fc-2d3c-f563-bdc182eca756@foxmail.com>
Date:   Sun, 12 Jun 2022 15:40:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul

On 2022/6/12 上午12:59, Paul E. McKenney wrote:
> On Sun, Jun 12, 2022 at 12:32:59AM +0800, Zhangfei Gao wrote:
>> Hi, Paul
>>
>> When verifying qemu with acpi rmr feature on v5.19-rc1, the guest kernel
>> stuck for several minutes.
> Stuck for several minutes but then continues normally?  Or stuck for
> several minutes before you kill qemu?
qemu boot stuck for several minutes, then guest can bootup normally, 
just slower.
>
> And I have to ask...  What happened without the ACPI RMR feature?
If no ACPI, qemu boot quickly without stuck.
build/aarch64-softmmu/qemu-system-aarch64 -machine 
virt,gic-version=3,iommu=smmuv3 \
-enable-kvm -cpu host -m 1024 \
-kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
"rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off"

Adding acpi=force & -bios QEMU_EFI.fd, qemu boot stuck for several minutes.


By the way, my hardware platform is aarch64.

Only change this can solve the stuck issue.

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -524,6 +524,10 @@ static unsigned long srcu_get_delay(struct 
srcu_struct *ssp)
  {
         unsigned long jbase = SRCU_INTERVAL;

+       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), 
READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+               return 0;
+       return SRCU_INTERVAL;
+

>
>> And on 5.18, there is no such problem.
>>
>> After revert this patch, the issue solved.
>> Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers from
>> consuming CPU)
>>
>>
>> qemu cmd:
>> build/aarch64-softmmu/qemu-system-aarch64 -machine
>> virt,gic-version=3,iommu=smmuv3 \
>> -enable-kvm -cpu host -m 1024 \
>> -kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
>> "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
>> -bios QEMU_EFI.fd
>>
>> log:
>> InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
>> add-symbol-file /home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll
>> 0x75459000
>> Loading driver at 0x00075458000 EntryPoint=0x00075459058 IScsiDxe.efi
>> InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 7AA4DE98
>> ProtectUefiImageCommon - 0x7AA4D040
>>    - 0x0000000075458000 - 0x000000000003F000
>> SetUefiImageMemoryAttributes - 0x0000000075458000 - 0x0000000000001000
>> (0x0000000000004008)
>> SetUefiImageMemoryAttributes - 0x0000000075459000 - 0x000000000003B000
>> (0x0000000000020008)
>> SetUefiImageMemoryAttributes - 0x0000000075494000 - 0x0000000000003000
>> (0x0000000000004008)
>> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952C8
>> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
>> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
>> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952F8
>> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
>> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
>> InstallProtocolInterface: 59324945-EC44-4C0D-B1CD-9DB139DF070C 75495348
>> InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 754953E8
>> InstallProtocolInterface: 330D4706-F2A0-4E4F-A369-B66FA8D54385 7AA4D728
>>
>>
>> Not sure it is either reported or solved.
> This is the first I have heard of it, so thank you for reporting it.
>
> Do you have a way of collecting something sysrq-t output?
Do you mean "echo t > /proc/sysrq-trigger",
There are too much output and kernel dump can not stop.

Thanks
