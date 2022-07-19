Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2C57A8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiGSVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiGSVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:25:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2A2A73B;
        Tue, 19 Jul 2022 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658265914;
        bh=J4W5CYhORKvUWhSyK3n8Da//J5aS9kgajB3l7N7nwDc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g0NSc4iQR/VO9nwVt2gk1rBd4IapEh2MvFmEiN/363LLEVesJ5ZZDGYGssFwRF4De
         8qB45hhvcjA0LEqJFZVHbnWCBJfLeLHNWmJAkrPSeyuOKjzX6CltbpIgiDkfMBxyrJ
         SC0d3YxR5UWXB/OCbWzT3beuaa4JEMSJ2BpNylDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.145.26]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1nixbP0asD-00ms53; Tue, 19
 Jul 2022 23:25:14 +0200
Message-ID: <76e47f90-bcc2-caab-50c5-6bff7fdc5c1d@gmx.de>
Date:   Tue, 19 Jul 2022 23:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
        Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <20220717113634.1552-1-hdanton@sina.com>
 <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
 <7d53692b-6ac8-e1bd-4d0d-7e97aa01b18d@bell.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <7d53692b-6ac8-e1bd-4d0d-7e97aa01b18d@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:avP/uQxUBQyP0Ze8i5oHyZVmVG8IhuSwbI4Ioz7JCVRee8kTgNG
 cSf0vSi6Z/LjjfrOnhKVwk4JztSJWfpD94AiumYhn0UX+rTduoPane7Bi0x4FCU0H0riABE
 vGxBun+UxeG1uJEiH79S8Yqljo7QPeZ+CMnfbPhO+lOCS6GCeaclOBw+zFRlpcUjHabM/G9
 ivowpzUwpaLJN8/tJgdBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTW+Eor2riM=:/oeSclwayChwifCCHi9HPQ
 JzUDbDMs9xT1HHJbvAmA6YV5SineeKkLjNHCZyMOGL37IE/4BBx8/0nyoaIrx4UKKuTQ1AdyY
 UkZRP67U5XqUpXtXVJtetqzbkh6ExrD1VsTKrbefQTR7vGET8U/jL8Mfi7g1gIUB59Lc135mY
 uan222F6MlE4gR1HItikS0Fz54CEexClIbRZ2khnNImfzn3hDeYoSvzSvm5+CVqtXSn/G76wW
 HpRzwESSxZWAofUCAppxZlehzpQClffL8bQXpI7BziD/pkdu/55lUN5ZOGoGBTu1oHtmoiWPN
 j2vNwWyaJLsBgFF9cLcFfQhEN7lpIiWcPd6twNNrGBWQiNvPC5OmOXt5/cLV+0VCXrV18CMUI
 Rk7VL/ItZSFokU83S9yEPrsdKmWCFGLZqxIRMz29p3LoQyb3e87I6FRcv5tdoYDjcGsO9naJo
 vaRbsJPkjVldkFye1MWN/80FmtUw9wZasYG5k/ANn7RZVOBufes1WFalOM+RUTfXrUBWJja7o
 sL6dqPOiHa6r6nk6PUVZ2QzWV/g/ikGGdb9fsrpSwHEZXA7LTGwqou/Xa4UuxeP23L2D1tNVC
 azopGMOQjMGAbXgDB82ySutC6kS9zGF6xftYvYUhiHUdEAAHQxIS32IA82kxH6nC2+nLyLgh1
 PwKYlLQIfvAF8Xgg1mTwCLqJy0NHVW4iV3GpmoCykiHTTYO1ZImOwXnMjP8fRF6adjHDu0c6H
 jaMKyBVa1AulzKzOAd9oejcL4qidHf9i7DkigG6RQAyq63lJknp3SfpBTztDdOZHxOiWIQjZA
 G/R0Gh4h/9kSXh3KHl9P+bgPYtp1pDt9qzlf8t2XEuH407AFEsK9T1OmJuTsianrnWwX5WSNb
 QcWcnUUpGOLxOH2CHZo9wdZEdexU2ogAnbUTIBuaaK3v5g4ur3IWACzcAyWUqCt9Ox4uGQRqJ
 5a/05u62c18LkY5TWuDqsBdduoBUzZWU8MW1UM5FVhijMHToYEI7JN1JtmsM6ogJsx8y0yNu9
 FAGF0rjIkxGFgVFUwtxKZfnZ/qrzLbhZfWT08XCpS8QJo5uKimO5wukFTyQWB6O2NM48SYBus
 aNk3sUoNGdEcmutN2Fsfd0YjC+Uqa1yJObfjzPoHKeGIKFsKyYiO0A6Yg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 22:59, John David Anglin wrote:
> Hi Helge,
>
> I hit this warning with the patch below building ghc on mx3210:

As I wrote, I didn't faced it yet on my buildd server, but that could
just have been luck...
Hillf, should we try if this second hunk triggers?

=2D-- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -616,6 +618,7 @@ static void __dentry_kill(struct dentry
 		dentry->d_flags |=3D DCACHE_MAY_FREE;
 		can_free =3D false;
 	}
+	BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);

Helge


> mx3210 login: ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 32654 at fs/dcache.c:365 dentry_free+0xfc/0x108
> Modules linked in: binfmt_misc ext2 ext4 crc16 mbcache jbd2 ipmi_watchdo=
g sg ipmi_si ipmi_poweroff ipmi_devintf ipmi_msghandler fuse nfsd ip_table=
s x_tables ipv6 autofs4 xfs raid10 raid456 async_raid6_recov async_memcpy =
async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 ra=
id0 multipath linear md_mod sd_mod t10_pi ses enclosure scsi_transport_sas=
 crc64_rocksoft crc64 uas usb_storage sr_mod cdrom ohci_pci sym53c8xx pata=
_cmd64x ehci_pci ohci_hcd libata scsi_transport_spi ehci_hcd tg3 scsi_mod =
usbcore scsi_common usb_common
> CPU: 2 PID: 32654 Comm: cc1 Not tainted 5.18.12+ #2
> Hardware name: 9000/800/rp3440
>
> =C2=A0=C2=A0=C2=A0=C2=A0 YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> PSW: 00001000000001000110100000001111 Not tainted
> r00-03=C2=A0 000000000804680f 00000040ce7fc880 00000000404f2b74 00000040=
ce7fc920
> r04-07=C2=A0 0000000040be4940 000000410f6cd630 00000001413e4068 00000041=
0f6cd688
> r08-11=C2=A0 0000000040fd2e60 0000000040bc5020 0000000040c2c940 00000000=
000800e0
> r12-15=C2=A0 0000000040c2c940 0000000000000001 0000000040c2c940 00000041=
0f6cd688
> r16-19=C2=A0 00000001f9fe105d 00000040ce7fc1f8 000000000000002f 00000000=
0a0c1000
> r20-23=C2=A0 000000000800000f 000000000800000f 000000410f6cd639 00000000=
0800000f
> r24-27=C2=A0 0000000000000000 0000000000000385 000000410f6cd630 00000000=
40be4940
> r28-31=C2=A0 0000000041104530 00000040ce7fc8f0 00000040ce7fc9a0 00000000=
00000000
> sr00-03=C2=A0 0000000000a03800 0000000000000000 0000000000000000 0000000=
000a03800
> sr04-07=C2=A0 0000000000000000 0000000000000000 0000000000000000 0000000=
000000000
>
> IASQ: 0000000000000000 0000000000000000 IAOQ: 00000000404f18bc 000000004=
04f18c0
> =C2=A0IIR: 03ffe01f=C2=A0=C2=A0=C2=A0 ISR: 0000000010350000=C2=A0 IOR: 0=
0000239ff3fc928
> =C2=A0CPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0 CR30:=
 00000040cadd1380 CR31: ffffffffffffffff
> =C2=A0ORIG_R28: 00000040ce7fcb70
> =C2=A0IAOQ[0]: dentry_free+0xfc/0x108
> =C2=A0IAOQ[1]: dentry_free+0x100/0x108
> =C2=A0RP(r2): __dentry_kill+0x2bc/0x338
> Backtrace:
> =C2=A0[<00000000404f2b74>] __dentry_kill+0x2bc/0x338
> =C2=A0[<00000000404f37b8>] dentry_kill+0xb0/0x318
> =C2=A0[<00000000404f3d08>] dput+0x2e8/0x328
> =C2=A0[<00000000404dd7dc>] step_into+0x344/0x390
> =C2=A0[<00000000404dda4c>] walk_component+0xa4/0x310
> =C2=A0[<00000000404df234>] link_path_walk.part.0+0x2ec/0x4b0
> =C2=A0[<00000000404e0000>] path_openat+0xe8/0x348
> =C2=A0[<00000000404e2c58>] do_filp_open+0x98/0x178
> =C2=A0[<00000000404babe8>] do_sys_openat2+0x148/0x288
> =C2=A0[<00000000404bb41c>] compat_sys_openat+0x54/0x98
> =C2=A0[<0000000040203e30>] syscall_exit+0x0/0x10
>
> ---[ end trace 0000000000000000 ]---
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [cc1:32657]
>
> Regards,
> Dave
>
> On 2022-07-19 12:32 p.m., Helge Deller wrote:
>> Hello Hillf,
>>
>> On 7/17/22 13:36, Hillf Danton wrote:
>>> On Sun, 17 Jul 2022 11:42:48 +0200
>>>> I used WARN_ON() instead of BUG_ON().
>>>> With that, both triggered, first the first one, then the second one.
>>>> Full log is here:
>>>> http://dellerweb.de/testcases/minicom.dcache.crash.6-warn
>>> Given the first BUG_ON triggered, and dentry at the moment is supposed=
 to
>>> not be alias, see if it is still in lookup with d_lock held. That is t=
he
>>> step before de-unioning d_alias with d_in_lookup_hash.
>>>
>>> On the other hand if only the second one triggered, we should track
>>> DCACHE_DENTRY_KILLED instead in assumption that killed dentry was
>>> used again after releasing d_lock surrounding the firt one.
>> The machine has now been up for 2 days without any issues, while it had=
 pretty
>> much the same load as when it was crashing earlier.
>> So, in summary I'd assume that your patch below fixes the issue.
>>
>> I'm now rebooting the machine with a new kernel, where I just changed
>> =C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(d_in_lookup(dentry)))
>> to
>> =C2=A0=C2=A0=C2=A0=C2=A0if (WARN_ON_ONCE(d_in_lookup(dentry)))
>> in order to see if this really triggered.
>>
>> Anyway, I think your patch is good so far.
>> Would that be the final patch, or should I test some others?
>>
>> Thanks!
>> Helge
>>
>>> --- a/fs/dcache.c
>>> +++ b/fs/dcache.c
>>> @@ -605,8 +605,12 @@ static void __dentry_kill(struct dentry
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&pa=
rent->d_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dentry->d_inode)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dentry_unlink_i=
node(dentry);
>>> -=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0 else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(d_in_lookup(d=
entry))) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __=
d_lookup_done(dentry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&de=
ntry->d_lock);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu_dec(nr_dentry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dentry->d_op && dentry->d_op->d_rel=
ease)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dentry->d_op->d=
_release(dentry);
>
>

