Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1025F4E6CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358188AbiCYDma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiCYDmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:42:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 869B98FE44;
        Thu, 24 Mar 2022 20:40:50 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCs21OT1iv24PAA--.26195S3;
        Fri, 25 Mar 2022 11:40:37 +0800 (CST)
Subject: Re: [kbuild-all] Re: undefined reference to `node_data'
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz> <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
 <20220324090443.GA5375@alpha.franken.de> <YjxmrTKxRpTFeHnE@dhcp22.suse.cz>
 <06178ca0-66ad-c7fc-a79c-0ea1873408bd@intel.com>
Cc:     linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, chenfeiyang@loongson.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a80b2c1f-cbb9-b320-3e97-0152109d261f@loongson.cn>
Date:   Fri, 25 Mar 2022 11:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <06178ca0-66ad-c7fc-a79c-0ea1873408bd@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxCs21OT1iv24PAA--.26195S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrXw15ZF1xXw1ktF1UZFb_yoW8Zr4kpF
        WUGa45tF4DJr4fKr92yFWUXryavr17tr40gFy0qr4xZ3s09r1Sqr1jgr4rWFy5tr1kJw10
        yr4UX34aqr9rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUEfO7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/25/2022 09:16 AM, Chen, Rong A wrote:
>
>
> On 3/24/2022 8:40 PM, Michal Hocko wrote:
>> On Thu 24-03-22 10:04:43, Thomas Bogendoerfer wrote:
>>> On Wed, Mar 23, 2022 at 05:46:59PM +0100, Michal Hocko wrote:
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>):
>>>>>>
>>>>>>     mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
>>>>>>>> (.init.text+0x1680): undefined reference to `node_data'
>>>>>>     mips64-linux-ld: (.init.text+0x1690): undefined reference to
>>>>>> `node_data'
>>>>>
>>>>> OK, I can see what is going here. The page allocator normally
>>>>> uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
>>>>> This is a problem with
>>>>> arch/mips/include/asm/mach-loongson64/mmzone.h:
>>>>> extern struct pglist_data *__node_data[];
>>>>>
>>>>> #define NODE_DATA(n)            (__node_data[n])
>>>>>
>>>>> Unfortunately we cannot use NODE_DATA there because of header
>>>>> inclusion
>>>>> ordering. I will think about a solution.
>>>>
>>>> Is there any reason why (some?) MIPS arches use __node_data rather than
>>>> node_data as most other architectures? Would it be acceptable to do the
>>>> renaming? It would help to cover the above compilation problem because
>>>> arch_refresh_nodedata could keep using node_data directly.
>>>
>>> I've just checked history and I don't see a reason for __node_data.
>>> So I'm fine with changing it to node_data.
>>
>> Thanks a lot for double checking Thomas! This is a dump&simple sed over
>> mips file. 0-day guys, could you give it a try please?
>
>
> Hi Michal,
>
> It returns another error:

Hi,

I think the following patch should fix the build error
"undefined reference to `node_data'":

https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=f8f9f21c7848

Thanks,
Tiezhu

