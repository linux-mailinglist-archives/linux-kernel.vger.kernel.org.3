Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79857576C02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGPF1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:27:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CF402D7;
        Fri, 15 Jul 2022 22:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657949255;
        bh=JM0fs0ArBW9ABHshHeBSWLdfOFndQuBWNuafh1L4FYU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YcKGH4QKXWzZukbXqn60em1+i+QqVInljFW3ftRooGrXI/7M6u9uwJu86TVINLoDF
         6nnO65f91vi+YA95lH9Rd0O6fwg1B4ziKQjfJ3vCpjinPEMuJpNC7tp9Z/NFXAOx9y
         22GjdVhdPIKJ1IXjQdcbDDNf3EsZRaQOlCm4iGkU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.138.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1naEqo3MQ8-00equl; Sat, 16
 Jul 2022 07:27:34 +0200
Message-ID: <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
Date:   Sat, 16 Jul 2022 07:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220715133300.1297-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kUadN7hBN2S5f1qebYkEovo6k3/1MyR8JJYW1tkWZOM7kgQbl/Q
 +KUTAqlDZZeg5kirvI/S4BECR9OTQQn0BVVQ7ZmRVwEvA+IrC11Sc+7IbXkjb1ug8Uu0czX
 1MjDD3OdG4tbgAX+v1SY1qp7Y5ggk9bGJNsOLBiL7+R0UGyEL5NCo0KH7Gft+jHSVKaCquo
 wyUdATcfGLbda8Wgx7geQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Om0SASPncWE=:I/JAgc9vsvQnoGbPtP8I2h
 2FkMUlAKCUGCr0cY26y4KO61lVs6kpRWGYG9GPfz8zRxyU3dVqLBDBn2e1abNHub+lde4Coro
 tu4HKeQy+ePmQwh3gZmOFdZCN2rJrs1CzoCN3TkOF0MBuoBHMbfmwn66yE9/5YxEXeHxN0oH5
 f8bdODcbm5DuZNI9g9vmaVNpT7jyoviQla7gphzkbBuc/ERgnh4/E5hUomrXXX6a48UMbs32A
 6OE3ElE21b23h+W/mrjyHxKoIAcfSczUMHuppNYbmvGirdg6HcQzLDT/9GcqCCcDXNMYI9OU1
 e2FcbuFEHxVI54dRlJix/PibG2RT6oLkpHc6jM1YVIZbkqt1fVx2ipuN8LSYNi42+8vW6LAsI
 Q/2ag1hla/gKLtYADBg2uUnlMDryb4uZdsL8i3QC0AZsJGKw6rbwCrKw/sqoc8Qoy7EwbeZJm
 OBSMBVgTjDVX0XEj2UuI9RBx2iObo80j53uh2+tDodWHeeHBEkw/4Z4NNHlX6SxvAVa35sD7Y
 BDHjfuXJa1Shnq4ys3ZUZ/pPQAjky/73R0WiSUYCEeW703ucuFsTm+2mlI5BNOWY3W5UX2ZNU
 2nuJ5MDScLaD2d+jsr1VPz5BHXk6c5jb0taTHFzhcCAzRuUs1Tk5B6BaR4F2jorGqeOjdA3oP
 UlYqU6KV2fYI4u1v9QaITvCTb18EdWxHDBGkokmEuTdNuK3AFo20vIEJ8QpN5ZoGT36zH0amb
 Stc6pO5Z9dJ4UERnPScfRjDm691w4BYlYFy94MIyMBPQKCWR2N91qb76F+M9dO0MtqpJMc+Q3
 ogIAjUPAdCMOZNvtjRNMa+cgzgtOget6n3iwG304PYKfBQIqLXfnokMVfLeLZhHlH9LjXkeWI
 bOQHIM4p+hXJgI56a4sZXTDK6jJFZZ7NJXhg2kTF/Yn9TKxakoT9RDm15dWfikYyuD22PWf6V
 0KzsGl8EX6VOkctZPhq3SH2+hnZrxgEOKCfjTgc+GtyYWNnZGxI/lLTRUPTO9tHi4fLEjX1yF
 z1xs993oAiNokcLH1D4BEn+wD/El8BFDrAMeNHSgIh/YJENwuCx0nQairvMkMvXDdLtbeXeXg
 Hzih33tnXnzwxKaNkAawAStBbwks1+eaid8puoiJ1cw6A3+yuQekRWBnw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 15:33, Hillf Danton wrote:
> On Fri, 15 Jul 2022 10:18:23 +0200 Helge Deller  wrote:
>>
>> I've faced another crash a few days back (see below), but right now I c=
an'=3D
>> t
>> trigger it any longer. I'll added some more debug info and switched to =
v5.=3D
>> 18.11,
>> so when it happens again I can probably provide more input...
>>
>> [71492.491336] ------------[ cut here ]------------
>> [71492.544917] WARNING: CPU: 1 PID: 16312 at fs/dcache.c:365 dentry_fre=
e+0=3D
>> x100/0x128
>> [71492.632868] Modules linked in: ipt_REJECT(E) nf_reject_ipv4(E) xt_mu=
lti=3D
>> port(E) nft_compat(E) nf_tables(E) nfnetlink(E) dm_mod(E) sunrpc(E) ipm=
i_s=3D
>> i(E) ipmi_devintf(E) ipmi_msghandler(E) sg(E) fuse(E) configfs(E) ip_ta=
ble=3D
>> s(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E=
) b=3D
>> lake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) libcrc32c(E) crc3=
2c_=3D
>> generic(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E)=
 cr=3D
>> ct10dif_generic(E) crct10dif_common(E) ata_generic(E) ohci_pci(E) sata_=
sil=3D
>> (E) mptspi(E) mptscsih(E) ohci_hcd(E) pata_sil680(E) ehci_pci(E) mptbas=
e(E=3D
>> ) ehci_hcd(E) scsi_transport_spi(E) libata(E) e1000(E) scsi_mod(E) usbc=
ore=3D
>> (E) usb_common(E) scsi_common(E)
>> [71493.366569] CPU: 1 PID: 16312 Comm: rm Tainted: G            E     5=
.18=3D
>> .10+ #28
>> [71493.454274] Hardware name: 9000/785/C8000
>> [71493.500913]
>> [71493.516909]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
>> [71493.572891] PSW: 00001000000001001111111100001111 Tainted: G        =
   =3D
>>  E
>> [71493.662405] r00-03  000000ff0804ff0f 000000005b2c0490 000000004073be=
a0 =3D
>> 000000005b2c0530
>> [71493.758449] r04-07  00000000410e1a00 00000003050366c0 000000016b97b7=
18 =3D
>> 0000000305036718
>> [71493.854493] r08-11  000000005b2c0460 0000000305036718 00000000410dae=
60 =3D
>> 0000000000000001
>> [71493.950539] r12-15  0000000000800000 0000000041147200 00000000000000=
01 =3D
>> 0000000000000000
>> [71494.046582] r16-19  0000000041146200 0000000000000000 00000000411462=
00 =3D
>> 0000000002c55000
>> [71494.142628] r20-23  000000000800000f 000000004f9ca578 00000000080000=
0f =3D
>> 000000016b97b760
>> [71494.238670] r24-27  0000000305036750 0000000305036750 00000003050366=
c0 =3D
>> 00000000410e1a00
>> [71494.334714] r28-31  00000000416bf380 000000005b2c0500 000000005b2c05=
b0 =3D
>> fffffffffffff89e
>> [71494.430759] sr00-03  0000000001df3800 0000000000000000 0000000000000=
000=3D
>>  0000000001df3800
>> [71494.527845] sr04-07  0000000000000000 0000000000000000 0000000000000=
000=3D
>>  0000000000000000
>> [71494.624929]
>> [71494.642842] IASQ: 0000000000000000 0000000000000000 IAOQ: 0000000040=
73b=3D
>> 3e4 000000004073b3e8
>> [71494.743059]  IIR: 03ffe01f    ISR: 0000000010340000  IOR: 0000006cb0=
2c0=3D
>> 538
>> [71494.825560]  CPU:        1   CR30: 00000000584d0ce0 CR31: ffffffffff=
fff=3D
>> fff
>> [71494.908063]  ORIG_R28: 0000000042e5e388
>> [71494.954102]  IAOQ[0]: dentry_free+0x100/0x128
>> [71495.006400]  IAOQ[1]: dentry_free+0x104/0x128
>> [71495.058695]  RP(r2): __dentry_kill+0x284/0x2e8
>> [71495.112026] Backtrace:
>> [71495.140360]  [<000000004073bea0>] __dentry_kill+0x284/0x2e8
>> [71495.207240]  [<000000004073ec50>] shrink_dentry_list+0xe4/0x1e8
>> [71495.278284]  [<000000004073f044>] shrink_dcache_parent+0x1a0/0x250
>> [71495.352452]  [<000000004072489c>] vfs_rmdir+0x268/0x468
>> [71495.412868]  [<000000004072ce08>] do_rmdir+0x39c/0x418
>> [71495.476826]  [<000000004072d644>] sys_unlinkat+0xd0/0x110
>> [71495.540869]  [<0000000040303e30>] syscall_exit+0x0/0x10
>> [71495.604330]
>> [71495.622248] ---[ end trace 0000000000000000 ]---
>> [71583.296513] Backtrace:
>> [71583.300330]  [<0000000040834460>] proc_fill_cache+0x194/0x2b8
>> [71583.300330]  [<000000004083d678>] proc_readfd_common+0x16c/0x3c0
>> [71583.300330]  [<000000004083d904>] proc_readfd+0x38/0x68
>> [71583.300330]  [<0000000040733cf0>] iterate_dir+0xec/0x2f0
>> [71583.300330]  [<0000000040734ae4>] sys_getdents64+0xd8/0x1e0
>> [71583.300330]  [<0000000040303e30>] syscall_exit+0x0/0x10
>> [71583.300330]
>> [71583.300330]
>> [71583.300330] Page fault: bad address: Code=3D3D15 (Data TLB miss faul=
t) at=3D
>>  addr 800002e76660997f
>> [71583.300330] CPU: 1 PID: 16466 Comm: ssh Tainted: G        W   E     =
5.1=3D
>> 8.10+ #28
>> [71583.300330] Hardware name: 9000/785/C8000
>> [71583.300330]
>> [71583.300330]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
>> [71583.300330] PSW: 00001000000001101111111100001111 Tainted: G        =
W  =3D
>>  E
>> [71583.300330] r00-03  000000ff0806ff0f 0000000041146a00 000000004073fd=
50 =3D
>> 0000000057d7c490
>> [71583.300330] r04-07  00000000410e1a00 8d00dae766609a0b 000000005f0ea6=
00 =3D
>> 0000000057d7c3b0
>> [71583.300330] r08-11  0000000000000001 0000000057d7c5e0 00000000000000=
02 =3D
>> 00000000416bf380
>> [71583.300330] r12-15  0000000057d7c4c0 0000000000000000 00000000000000=
00 =3D
>> 0000000041412ad0
>> [71583.300330] r16-19  000000005f0ea900 00000000a0c15ff4 00000000416483=
e0 =3D
>> 000000000800000f
>> [71583.300330] r20-23  000000005f0eaa50 000000000800000f 00000000555555=
56 =3D
>> 000000005f0ea9a0
>> [71583.300330] r24-27  0000000057d7c4c0 0000000057d7c3b0 000000005f0ea9=
00 =3D
>> 00000000410e1a00
>> [71583.300330] r28-31  0000000000000000 0000000057d7c5e0 0000000057d7c6=
10 =3D
>> 0000000305036771
>> [71583.300330] sr00-03  0000000001e35000 0000000000000000 0000000000000=
000=3D
>>  0000000001e35000
>> [71583.300330] sr04-07  0000000000000000 0000000000000000 0000000000000=
000=3D
>>  0000000000000000
>> [71583.300330]
>> [71583.300330] IASQ: 0000000000000000 0000000000000000 IAOQ: 0000000040=
73f=3D
>> dec 000000004073fdf0
>> [71583.300330]  IIR: 48bc3ee9    ISR: 000000000d00d800  IOR: 800002e766=
609=3D
>> 97f
>> [71583.300330]  CPU:        1   CR30: 000000007fed0ce0 CR31: ffffffffff=
fff=3D
>> fff
>> [71583.300330]  ORIG_R28: 0000000000000cc0
>> [71583.300330]  IAOQ[0]: d_alloc_parallel+0x220/0x748
>> [71583.300330]  IAOQ[1]: d_alloc_parallel+0x224/0x748
>> [71583.300330]  RP(r2): d_alloc_parallel+0x184/0x748
>> [71583.300330] Backtrace:
>> [71585.616335]  [<0000000040834460>] proc_fill_cache+0x194/0x2b8
>> [71585.616335]  [<000000004083d678>] proc_readfd_common+0x16c/0x3c0
>> [71585.616335]  [<000000004083d904>] proc_readfd+0x38/0x68
>> [71585.616335]  [<0000000040733cf0>] iterate_dir+0xec/0x2f0
>> [71585.616335]  [<0000000040734ae4>] sys_getdents64+0xd8/0x1e0
>> [71585.616335]  [<0000000040303e30>] syscall_exit+0x0/0x10
>> [71585.616335]
>> <Cpu1> 0300109101e00000  0000000000000000  CC_PROCS_ENTRY_OUT
>> [71586.384319] Kernel panic - not syncing: Page fault: bad address
>
> Looks like the same issue.

It crashed again, this time I had following patch applied:

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..a3c8dba97e85 100644
=2D-- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -362,9 +362,25 @@ static inline void __d_clear_type_and_inode(struct de=
ntry *dentry)

 static void dentry_free(struct dentry *dentry)
 {
-       WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+       int unhashed =3D hlist_unhashed(&dentry->d_u.d_alias);
+       if (WARN_ON(!unhashed)) {
+               pr_err("dentry =3D %px\n", dentry);
+               pr_err("spin_is_locked(&dentry->d_lock) =3D %d\n", spin_is=
_locked(&dentry->d_lock));
+               pr_err("dname_external(dentry) =3D %d\n", dname_external(d=
entry));
+               pr_err("dentry->d_flags & DCACHE_NORCU =3D %d\n", dentry->=
d_flags & DCACHE_NORCU);
+               // pr_err("ERROR on file %pd\n", &dentry); HANGS
+               pr_err("dentry->d_name.len =3D %d\n", dentry->d_name.len);
+               pr_err("dentry->d_name.hash =3D %x\n", dentry->d_name.hash=
);
+               pr_err("dentry->d_lockref.count =3D %d\n", dentry->d_lockr=
ef.count);
+               pr_err("dentry->d_flags =3D %d\n", dentry->d_flags);
+               pr_err("dentry->d_inode =3D %px\n", dentry->d_inode);
+               pr_err("dentry->d_parent =3D %px\n", dentry->d_parent);
+               pr_err("dentry->d_u.d_rcu =3D %pS\n", dentry->d_u.d_rcu.fu=
nc);
+       }
        if (unlikely(dname_external(dentry))) {
                struct external_name *p =3D external_name(dentry);
+               if (!unhashed)
+                       pr_err("value of &p->u.count =3D %d\n", p->u.count=
.counter);
                if (likely(atomic_dec_and_test(&p->u.count))) {
                        call_rcu(&dentry->d_u.d_rcu, __d_free_external);
                        return;

and this was the output:

[108563.953441]  IAOQ[1]: dentry_free+0xc4/0x338
[108564.005441]  RP(r2): __dentry_kill+0x284/0x2e8
[108564.057443] Backtrace:
[108564.089454]  [<000000004073bab0>] __dentry_kill+0x284/0x2e8
[108564.157445]  [<000000004073d2f8>] dput+0x334/0x5a8
[108564.213444]  [<00000000407267a4>] step_into+0x790/0xa88
[108564.277444]  [<0000000040727084>] walk_component+0xa8/0x330
[108564.345443]  [<00000000407275f8>] link_path_walk.part.0.constprop.0+0x=
2ec/0x4d0
[108564.437443]  [<0000000040728254>] path_openat+0x150/0x1ba8
[108564.501441]  [<000000004072ba28>] do_filp_open+0x9c/0x198
[108564.569441]  [<0000000040701d20>] do_sys_openat2+0x14c/0x2a8
[108564.637441]  [<0000000040702654>] compat_sys_openat+0x58/0xb8
[108564.705440]  [<0000000040303e30>] syscall_exit+0x0/0x10
[108564.769444]
[108564.789435] ---[ end trace 0000000000000000 ]---
[108564.845444] dentry =3D 000000031624e6c0
[108564.889437] spin_is_locked(&dentry->d_lock) =3D 0
[108564.945436] dname_external(dentry) =3D 0
[108564.993436] dentry->d_flags & DCACHE_NORCU =3D 0
[108565.045446] dentry->d_name.len =3D 3
[108565.089435] dentry->d_name.hash =3D 89116695
[108565.137435] dentry->d_lockref.count =3D -128
[108565.189434] dentry->d_flags =3D 32776
[108565.233435] dentry->d_inode =3D 0000000000000000
[108565.285429] dentry->d_parent =3D 000000022ef756c0
[108565.341434] dentry->d_u.d_rcu =3D 0x416be770


and

[108568.877430]  IAOQ[0]: dentry_free+0xc0/0x338
[108568.929412]  IAOQ[1]: dentry_free+0xc4/0x338
[108568.981411]  RP(r2): __dentry_kill+0x284/0x2e8
[108569.037428] Backtrace:
[108569.065421]  [<000000004073bab0>] __dentry_kill+0x284/0x2e8
[108569.133416]  [<000000004073d2f8>] dput+0x334/0x5a8
[108569.193435]  [<00000000407267a4>] step_into+0x790/0xa88
[108569.257414]  [<0000000040727084>] walk_component+0xa8/0x330
[108569.325432]  [<0000000040727ee8>] path_lookupat+0xdc/0x2f8
[108569.389412]  [<000000004072b100>] filename_lookup+0xb4/0x238
[108569.461434]  [<000000004072b4d0>] user_path_at_empty+0x8c/0xf0
[108569.529412]  [<0000000040712af0>] do_readlinkat+0xdc/0x280
[108569.597430]  [<00000000407140a4>] sys_readlink+0x40/0x70
[108569.661409]  [<0000000040303e30>] syscall_exit+0x0/0x10
[108569.725428]
[108569.745405] ---[ end trace 0000000000000000 ]---
[108569.801407] dentry =3D 000000016d7d0000
[108569.845407] spin_is_locked(&dentry->d_lock) =3D 0
[108569.901422] dname_external(dentry) =3D 0
[108569.949405] dentry->d_flags & DCACHE_NORCU =3D 0
[108570.001405] dentry->d_name.len =3D 10
[108570.045421] dentry->d_name.hash =3D e6582e53
[108570.093476] dentry->d_lockref.count =3D -128
[108570.145404] dentry->d_flags =3D 32776
[108570.189420] dentry->d_inode =3D 0000000000000000
[108570.241404] dentry->d_parent =3D 00000002332c2780
[108570.297403] dentry->d_u.d_rcu =3D 0x416be770


> Add debug info to the diff below. Cut the first BUG_ON off if it
> triggers and see if the second one can be hit.

I will add that code now and try.
Helge


> +++ y/fs/dcache.c
> @@ -605,8 +605,10 @@ static void __dentry_kill(struct dentry
>  		spin_unlock(&parent->d_lock);
>  	if (dentry->d_inode)
>  		dentry_unlink_inode(dentry);
> -	else
> +	else {
> +		BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>  		spin_unlock(&dentry->d_lock);
> +	}
>  	this_cpu_dec(nr_dentry);
>  	if (dentry->d_op && dentry->d_op->d_release)
>  		dentry->d_op->d_release(dentry);
> @@ -616,6 +618,7 @@ static void __dentry_kill(struct dentry
>  		dentry->d_flags |=3D DCACHE_MAY_FREE;
>  		can_free =3D false;
>  	}
> +	BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>  	spin_unlock(&dentry->d_lock);
>  	if (likely(can_free))
>  		dentry_free(dentry);

