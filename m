Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8A476F50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhLPK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:59:34 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58942 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbhLPK7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:59:33 -0500
Received: from [10.180.13.92] (unknown [10.180.13.92])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7NwAHLthrWkBAA--.5917S2;
        Thu, 16 Dec 2021 18:59:13 +0800 (CST)
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
 <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
 <654e90fb-2f04-1f87-f56c-792757e140a0@suse.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Cc:     rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinbo@loongson.cn
Message-ID: <8ed3dbee-c51c-db54-37b7-182d5a75fff8@loongson.cn>
Date:   Thu, 16 Dec 2021 18:59:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <654e90fb-2f04-1f87-f56c-792757e140a0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx7NwAHLthrWkBAA--.5917S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWDXr1rXFykAFykWw13XFb_yoW8CF1rpw
        40yw109r1DZryrKrZFkwn7Jw1Yyr4vyanxCF95ArykJ3y7Aa409rs0qrZ8uanrZrs3Cr4Y
        q3y2g348u3WqyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/14 下午10:21, Oliver Neukum 写道:
> 
> On 10.12.21 10:50, zhuyinbo wrote:
> Hi,
>> system ask that must it must be accped a acpi lid open event then
>> system will always into resume state for laptop, otherwise, eventhough
>> that system be wakeuped by other event then system will continue into
>> suspend.
> Lid events are necesarily for the whole system.
>>
>> and for laptop usb wakeup that as general ask bios to enable usb
>> wakeup then if need do more things to enable usb wakeup I think this
>> usb wakeup function isn't friendly and inconveient, so enable it by
>> default.
>> after add this patch, if want to use usb wakeup function it only need
>> enable bios configure it think it is appropriate.
>>
> No. If you wish your laptop to be resumed by USB events, that is one thing.
> You can alter the system settings. That must work. But it is a different
> issue
Hi Oliver,

if you only talk about wakeup source you can think that usb-wakeup 
source and acpi-lid wakeup source was different things. but if you talk 
about laptop and distinguish lid and other event and you shoud know the 
cannotation why system still continue sleep when lid closed then system 
by other event wakeup. if you need test usb-wakeup for laptop and that 
lid shouldn't be closed.
> 
> from the default.
> 
> In general any HID device must have wakeup capability to be usable for
> selective suspend. You cannot draw conclusions from that.
you still can has wakeup capability, but it should be keep enabled by 
default. because the hid device should be convenient for human, if you 
don't think so and I think HID definition is ridiculous.

In addition, I had said that laptop usb wakeup was disabled in system 
bios by default and if user want enable usb wakeup that was only by 
configure bios and doesn't need enable wakeup node if my patch was applied
> 
>      Regards
>          Oliver
> 

