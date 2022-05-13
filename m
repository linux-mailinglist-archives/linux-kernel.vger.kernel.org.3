Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC88525C60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377803AbiEMHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiEMHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:31:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E031354BF1;
        Fri, 13 May 2022 00:31:36 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L00gJ69DszhZ4v;
        Fri, 13 May 2022 15:30:52 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 15:31:34 +0800
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemm600018.china.huawei.com (7.193.23.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 15:31:33 +0800
Message-ID: <e3dbc9ef-001b-dda1-c34f-5383b714d8b3@huawei.com>
Date:   Fri, 13 May 2022 15:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] docs/zh_CN: Add dev-tools/gdb-kernel-debugging.rst
 Chinese translation
To:     yanteng si <siyanteng01@gmail.com>
CC:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Wu XiangCheng" <bobwxc@email.cn>, Hu Haowen <src.res@email.cn>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220513061035.605-1-gaochao49@huawei.com>
 <CAEensMwCejpv8yt4cU7BQj8tVX51-HiFmFTAi9yUO6SCCd+fkQ@mail.gmail.com>
From:   "gaochao (L)" <gaochao49@huawei.com>
In-Reply-To: <CAEensMwCejpv8yt4cU7BQj8tVX51-HiFmFTAi9yUO6SCCd+fkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanteng,

Thank you for the review.
I will fix this and add your reviewed-by tag in the second version.


在 2022/5/13 15:11, yanteng si 写道:
> gaochao <gaochao49@huawei.com> 于2022年5月13日周五 14:10写道：
>>
>> Translate dev-tools/gdb-kernel-debugging.rst into Chinese.
>>
>> Signed-off-by: gaochao <gaochao49@huawei.com>
> Hi chao:
> 
> If you take my suggestion below in the second version, please pick my
> Reviewed-by tag. >_<
> 
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> 
>> ---
>>  .../zh_CN/dev-tools/gdb-kernel-debugging.rst  | 167 ++++++++++++++++++
>>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>>  2 files changed, 168 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
>> new file mode 100644
>> index 000000000000..e1293176614a
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
>> @@ -0,0 +1,167 @@
>> +.. highlight:: none
>> +
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/dev-tools/gdb-kernel-debugging.rst
>> +:Translator: 高超 gao chao <gaochao49@huawei.com>
>> +
>> +通过gdb调试内核和模块
>> +=====================
>> +
>> +Kgdb内核调试器、QEMU等虚拟机管理程序或基于JTAG的硬件接口，支持在运行时使用gdb
>> +调试Linux内核及其模块。Gdb提供了一个强大的python脚本接口，内核也提供了一套
>> +辅助脚本以简化典型的内核调试步骤。本文档为如何启用和使用这些脚本提供了一个简要的教程。
>> +此教程基于QEMU/KVM虚拟机，但文中示例也适用于其他gdb stub。
>> +
>> +
>> +环境配置要求
>> +------------
>> +
>> +- gdb 7.2+ (推荐版本: 7.4+) 、使能python (通常发行版上都已支持)
>> +
>> +设置
>> +----
>> +
>> +- 创建一个QEMU/KVM的linux虚拟机（详情请参考 www.linux-kvm.org 和 www.qemu.org ）。
>> +  对于交叉开发，https://landley.net/aboriginal/bin 提供了一些镜像和工具链，
>> +  可以帮助搭建交叉开发环境。
>> +
>> +- 编译内核时使能CONFIG_GDB_SCRIPTS，但关闭CONFIG_DEBUG_INFO_REDUCED。
>> +  如果架构支持CONFIG_FRAME_POINTER，请保持使能。
>> +
>> +- 在guest环境上安装该内核。如有必要，通过在内核command line中添加“nokaslr”来关闭KASLR。
>> +  此外，QEMU允许通过-kernel、-append、-initrd这些命令行选项直接启动内核。
>> +  但这通常仅在不依赖内核模块时才有效。有关此模式的更多详细信息，请参阅QEMU文档。
>> +  在这种情况下，如果架构支持KASLR，应该在禁用CONFIG_RANDOMIZE_BASE的情况下构建内核。
>> +
>> +- 启用QEMU/KVM的gdb stub，可以通过如下方式实现
>> +
>> +    - 在VM启动时，通过在QEMU命令行中添加“-s”参数
>> +
>> +  或
>> +
>> +    - 在运行时通过从QEMU监视控制台发送“gdbserver”
>> +
>> +- 切换到/path/to/linux-build(内核源码编译)目录
>> +
>> +- 启动gdb：gdb vmlinux
>> +
>> +  注意：某些发行版可能会将gdb脚本的自动加载限制在已知的安全目录中。
>> +  如果gdb报告拒绝加载vmlinux-gdb.py（相关命令找不到），请将：
> The original document here is two colons,
> so, Let's use :: .
>> +
>> +    add-auto-load-safe-path /path/to/linux-build
>> +
>> +  添加到~/.gdbinit。更多详细信息，请参阅gdb帮助信息。
>> +
>> +- 连接到已启动的guest环境：
> : -> ::
>> +
>> +    (gdb) target remote :1234
>> +
>> +
>> +使用Linux提供的gdb脚本的示例
>> +----------------------------
>> +
>> +- 加载模块（以及主内核）符号：
> : -> ::
>> +
>> +    (gdb) lx-symbols
>> +    loading vmlinux
>> +    scanning for modules in /home/user/linux/build
>> +    loading @0xffffffffa0020000: /home/user/linux/build/net/netfilter/xt_tcpudp.ko
>> +    loading @0xffffffffa0016000: /home/user/linux/build/net/netfilter/xt_pkttype.ko
>> +    loading @0xffffffffa0002000: /home/user/linux/build/net/netfilter/xt_limit.ko
>> +    loading @0xffffffffa00ca000: /home/user/linux/build/net/packet/af_packet.ko
>> +    loading @0xffffffffa003c000: /home/user/linux/build/fs/fuse/fuse.ko
>> +    ...
>> +    loading @0xffffffffa0000000: /home/user/linux/build/drivers/ata/ata_generic.ko
>> +
>> +- 对一些尚未加载的模块中的函数函数设置断点，例如：
> : -> ::
>> +    (gdb) b btrfs_init_sysfs
>> +    Function "btrfs_init_sysfs" not defined.
>> +    Make breakpoint pending on future shared library load? (y or [n]) y
>> +    Breakpoint 1 (btrfs_init_sysfs) pending.
>> +
>> +- 继续执行：
> : -> ::
>> +
>> +    (gdb) c
>> +
>> +- 加载模块并且能观察到正在加载的符号以及断点命中：
> : -> ::
>> +
>> +    loading @0xffffffffa0034000: /home/user/linux/build/lib/libcrc32c.ko
>> +    loading @0xffffffffa0050000: /home/user/linux/build/lib/lzo/lzo_compress.ko
>> +    loading @0xffffffffa006e000: /home/user/linux/build/lib/zlib_deflate/zlib_deflate.ko
>> +    loading @0xffffffffa01b1000: /home/user/linux/build/fs/btrfs/btrfs.ko
>> +
>> +    Breakpoint 1, btrfs_init_sysfs () at /home/user/linux/fs/btrfs/sysfs.c:36
>> +    36              btrfs_kset = kset_create_and_add("btrfs", NULL, fs_kobj);
>> +
>> +- 查看内核的日志缓冲区：
> : -> ::
>> +
>> +    (gdb) lx-dmesg
>> +    [     0.000000] Initializing cgroup subsys cpuset
>> +    [     0.000000] Initializing cgroup subsys cpu
>> +    [     0.000000] Linux version 3.8.0-rc4-dbg+ (...
>> +    [     0.000000] Command line: root=/dev/sda2 resume=/dev/sda1 vga=0x314
>> +    [     0.000000] e820: BIOS-provided physical RAM map:
>> +    [     0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
>> +    [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
>> +    ....
>> +
>> +- 查看当前task struct结构体的字段（仅x86和arm64支持）
> ::
>> +
>> +    (gdb) p $lx_current().pid
>> +    $1 = 4998
>> +    (gdb) p $lx_current().comm
>> +    $2 = "modprobe\000\000\000\000\000\000\000"
>> +
>> +- 对当前或指定的CPU使用per-cpu函数：
> : -> ::
>> +
>> +    (gdb) p $lx_per_cpu("runqueues").nr_running
>> +    $3 = 1
>> +    (gdb) p $lx_per_cpu("runqueues", 2).nr_running
>> +    $4 = 0
>> +
>> +- 使用container_of查看更多hrtimers信息：
> : -> ::
>> +
>> +    (gdb) set $next = $lx_per_cpu("hrtimer_bases").clock_base[0].active.next
>> +    (gdb) p *$container_of($next, "struct hrtimer", "node")
>> +    $5 = {
>> +      node = {
>> +        node = {
>> +          __rb_parent_color = 18446612133355256072,
>> +          rb_right = 0x0 <irq_stack_union>,
>> +          rb_left = 0x0 <irq_stack_union>
>> +        },
>> +        expires = {
>> +          tv64 = 1835268000000
>> +        }
>> +      },
>> +      _softexpires = {
>> +        tv64 = 1835268000000
>> +      },
>> +      function = 0xffffffff81078232 <tick_sched_timer>,
>> +      base = 0xffff88003fd0d6f0,
>> +      state = 1,
>> +      start_pid = 0,
>> +      start_site = 0xffffffff81055c1f <hrtimer_start_range_ns+20>,
>> +      start_comm = "swapper/2\000\000\000\000\000\000"
>> +    }
>> +
>> +
>> +命令和辅助调试功能列表
>> +----------------------
>> +
>> +命令和辅助调试功能可能会随着时间的推移而改进，此文显示的是初始版本的部分示例：
> : -> ::
> 
> 
> Thanks,
> Yanteng
>> +
>> + (gdb) apropos lx
>> + function lx_current -- Return current task
>> + function lx_module -- Find module by name and return the module variable
>> + function lx_per_cpu -- Return per-cpu variable
>> + function lx_task_by_pid -- Find Linux task by PID and return the task_struct variable
>> + function lx_thread_info -- Calculate Linux thread_info from task variable
>> + lx-dmesg -- Print Linux kernel log buffer
>> + lx-lsmod -- List currently loaded modules
>> + lx-symbols -- (Re-)load symbols of Linux kernel and currently loaded modules
>> +
>> +可以通过“help <command-name>”或“help function <function-name>”命令
>> +获取指定命令或指定调试功能的更多详细信息。
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index 77a8c44cdf49..02577c379007 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -25,6 +25,7 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>     sparse
>>     gcov
>>     kasan
>> +   gdb-kernel-debugging
>>
>>  Todolist:
>>
>> @@ -34,7 +35,6 @@ Todolist:
>>   - kmemleak
>>   - kcsan
>>   - kfence
>> - - gdb-kernel-debugging
>>   - kgdb
>>   - kselftest
>>   - kunit/index
>> --
>> 2.17.1
>>
