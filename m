Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9508646FE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhLJJ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:58:22 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48058 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239671AbhLJJ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:58:21 -0500
Received: from [10.180.13.84] (unknown [10.180.13.84])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH8vaI7Nh4tIFAA--.12801S2;
        Fri, 10 Dec 2021 17:54:35 +0800 (CST)
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinbo@loongson.cn,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <YbCdTaGSKak1cdSh@kroah.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <cc535d3d-6dcd-e69c-24e7-df54ce63c381@loongson.cn>
Date:   Fri, 10 Dec 2021 17:54:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YbCdTaGSKak1cdSh@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxH8vaI7Nh4tIFAA--.12801S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy3Xr1kZFWfXFWUZr15XFb_yoW3GrbE9w
        4vqa1kWr1xZrnayan3Ka1FqFWDG3W2qrWUta1UZw1Fv34av3y7Ww4kC3savw15Kw13AF9I
        vrn5tFZ7ury2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbT8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/12/8 ÏÂÎç7:55, Greg Kroah-Hartman Ð´µÀ:
> On Wed, Dec 08, 2021 at 05:39:50PM +0800, Yinbo Zhu wrote:
>> The remote wake-up function is a regular function on usb hid device
>> and I think keeping it enabled by default will make usb application
>> more convenient. This patch is to enable remote wakeup function for
>> usb hid device.
> 
> How many devices did you test this on?
> 
> As Oliver said, this will cause problems, there's a reason no operating
> system does this :(
> 
> sorry,
> 
> greg k-h
Hi greg,

About that oliver said that I had expained, and I add this change was 
according that usb device whether support remote wakeup and if it 
support wakeup then to enabled it so I think it should be okay for all 
hid device.

BRs,
Yinbo.
> 

