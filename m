Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CE575D39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGOISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiGOISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:18:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAF77E83C;
        Fri, 15 Jul 2022 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657873107;
        bh=O6N1tK3uEdBbSa80uZ56+ThhfCA4dW0HWRveuHspoMU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dWMkX+RxL/MyeATaZJT3QjVG8+0PwrqtKCjY2R1VRjPi1UTmEMTDUxzK6Jr4LJZZ3
         dILLKenP/5Ky+1jGNDbw0JFZ5HPHDl3wAFrx2nmQ7iq3l82ACLiYg4ccWE3Bg5jrSv
         eq9crUpPuKCW/0o6bmxi5vQRxFX5PcJSVg3FoQDE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.139.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1nMmL10ag8-00s8wB; Fri, 15
 Jul 2022 10:18:27 +0200
Message-ID: <431cb518-56e5-4624-09df-4135fcb0d9dd@gmx.de>
Date:   Fri, 15 Jul 2022 10:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>
References: <20220709090756.2384-1-hdanton@sina.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220709090756.2384-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J4Icq55D61lBgP3hrQG34ykX/JEaC4o/V9Sk6M80RaifUMqn9Be
 iuhxVvHgpDkJJUXGHoVLcd01uNgvw2ZWatXirL6MEhwYArxQFa+5H+77KUX/28jykGG9K7D
 DJBrLPKlUQUdlyrIChV8gPnJtCcEXBtxQtuXYIPj75V8PxQwJeBY2wp6wwGHOBkY9oDQ1xx
 wvUEBK3WhjTooIzblwK7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8LSiGlVmSk=:lx3zNeDmjaJvkAtfq9INk4
 YDk06m/LO+OIMXdD0/EhL74NKmE8RRz6aogGaX0KeyoqYyP6sbsyBzXb0zvtL5c5AIUIoBtYC
 1GieXvQVmh//0bRXBpZURVVQ0dwN+rJBR60Bm9X/Otio+CWf8AWPJhUVNCKY9KqEAGMyGkKC4
 oefUWR9jInNCLMaXJcubYE7iOIgp8FIdtIvyK+Xj7jUGaSrvEgzo1KBlajd2I+YqZj5AvmRqr
 p04N99BwDKm05WW50E+kdqAzprlZDfOIt+kRrQ7iUcURE6tx/qN2Oehv34Dusf0m678O/NfJ8
 jxnhePB06t3yrg0N17G8FKK4bYoCqRtjMY+TLESuvdOV4HTfxtBFObyOn6xFNoQMM8tv7LjRP
 /XXJk3n1pPU0JRVQON6KeifaI1leCMoBiNwwUm2lyCv0kncDuYxIXLG4U1XYKFUUQl2DC8nVD
 YzbUqYl7Z8z+sM1rVN9oa9q2qfEdQ3rSAOuGQ1Afv+n1NbpKNBC2iDfzoWQC5CVNg/Hi3491D
 TKfEVM3ETyhEuxi9A2cv3Zz6Oo+R0jh0w2F6lFNDVuBMAqARrOjvJyWlcYA21kv3nMdjEi+gW
 D6MSpQ5P8XHXwEivkp5+vb6d/dvgpiFgrzzPM0ZSblyanunMUOLOfEp+LTLtNNYJsIqN1dF2C
 0mup8+NzxfNfuwG+pc8WqLgqruEpeG/d4llYqVN5/e6f8QXLRUv7gURqQVQnd6LzBk3EQ5jqS
 yejDG2HrDw/Z27c2hA1cVn4ygvNf/BDC4MnYVEZT6iSObzFoAjOxF6ZwLTrisblPznd0qMnc7
 zmLaoa6dZX/EseRQoc2uvd/HLpTRrsYGditcRtdwOBw7h5WtDa+f4MOwaGNDm8yc/fCfSyqrp
 E7WrQMbWGHfv1u7QgB9PV4zzR5x6la72/Fy0b3lLMkexBERDbpsqV/V81JpG8P4/1Gmj3bCzO
 k6aViSP7g+CglNlo3IvEU1p+M7WUa8KkapaP1weEVr6FUV7LSFHvkE+XMwRVSgqYEbcQN7k7+
 TW3lH2jyP+RFDsH394ZuOaZR2Png4N+d/tgEma5NLWZ66ElAKJMKSB4xP7jfa+5WpVbzVKOM9
 BVFKi3e+UkDyotb69TClif3OZ2p8F9z7dFVeHxsHlJu7WYi07RgqNVngQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 11:07, Hillf Danton wrote:
> On Sat, 9 Jul 2022 07:33:51 +0200 Helge Deller <deller@gmx.de> wrote:
>> On the debian buildd servers for the parisc architecture I'm facing
>> the following warning, after which it gets stuck so that I need to
>> reboot the server.
>> This happens rarely, but I can reproduce it after some time.
>> Filesystem is tmpfs.
>>
>> I'm happy to add debug code if necessary...
>
> Spin with the diff below applied if it makes two-cent sense to you.
>[...]
> +++ b/fs/namei.c
> @@ -3349,8 +3349,8 @@ static const char *open_last_lookups(str
>  	struct dentry *dir =3D nd->path.dentry;
>  	int open_flag =3D op->open_flag;
>  	bool got_write =3D false;
> -	unsigned seq;
> -	struct inode *inode;
> +	unsigned seq =3D 0;
> +	struct inode *inode =3D NULL;
>  	struct dentry *dentry;
>  	const char *res;

That patch didn't helped.

I've faced another crash a few days back (see below), but right now I can'=
t
trigger it any longer. I'll added some more debug info and switched to v5.=
18.11,
so when it happens again I can probably provide more input...

[71492.491336] ------------[ cut here ]------------
[71492.544917] WARNING: CPU: 1 PID: 16312 at fs/dcache.c:365 dentry_free+0=
x100/0x128
[71492.632868] Modules linked in: ipt_REJECT(E) nf_reject_ipv4(E) xt_multi=
port(E) nft_compat(E) nf_tables(E) nfnetlink(E) dm_mod(E) sunrpc(E) ipmi_s=
i(E) ipmi_devintf(E) ipmi_msghandler(E) sg(E) fuse(E) configfs(E) ip_table=
s(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) b=
lake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) libcrc32c(E) crc32c_=
generic(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) cr=
ct10dif_generic(E) crct10dif_common(E) ata_generic(E) ohci_pci(E) sata_sil=
(E) mptspi(E) mptscsih(E) ohci_hcd(E) pata_sil680(E) ehci_pci(E) mptbase(E=
) ehci_hcd(E) scsi_transport_spi(E) libata(E) e1000(E) scsi_mod(E) usbcore=
(E) usb_common(E) scsi_common(E)
[71493.366569] CPU: 1 PID: 16312 Comm: rm Tainted: G            E     5.18=
.10+ #28
[71493.454274] Hardware name: 9000/785/C8000
[71493.500913]
[71493.516909]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[71493.572891] PSW: 00001000000001001111111100001111 Tainted: G           =
 E
[71493.662405] r00-03  000000ff0804ff0f 000000005b2c0490 000000004073bea0 =
000000005b2c0530
[71493.758449] r04-07  00000000410e1a00 00000003050366c0 000000016b97b718 =
0000000305036718
[71493.854493] r08-11  000000005b2c0460 0000000305036718 00000000410dae60 =
0000000000000001
[71493.950539] r12-15  0000000000800000 0000000041147200 0000000000000001 =
0000000000000000
[71494.046582] r16-19  0000000041146200 0000000000000000 0000000041146200 =
0000000002c55000
[71494.142628] r20-23  000000000800000f 000000004f9ca578 000000000800000f =
000000016b97b760
[71494.238670] r24-27  0000000305036750 0000000305036750 00000003050366c0 =
00000000410e1a00
[71494.334714] r28-31  00000000416bf380 000000005b2c0500 000000005b2c05b0 =
fffffffffffff89e
[71494.430759] sr00-03  0000000001df3800 0000000000000000 0000000000000000=
 0000000001df3800
[71494.527845] sr04-07  0000000000000000 0000000000000000 0000000000000000=
 0000000000000000
[71494.624929]
[71494.642842] IASQ: 0000000000000000 0000000000000000 IAOQ: 000000004073b=
3e4 000000004073b3e8
[71494.743059]  IIR: 03ffe01f    ISR: 0000000010340000  IOR: 0000006cb02c0=
538
[71494.825560]  CPU:        1   CR30: 00000000584d0ce0 CR31: fffffffffffff=
fff
[71494.908063]  ORIG_R28: 0000000042e5e388
[71494.954102]  IAOQ[0]: dentry_free+0x100/0x128
[71495.006400]  IAOQ[1]: dentry_free+0x104/0x128
[71495.058695]  RP(r2): __dentry_kill+0x284/0x2e8
[71495.112026] Backtrace:
[71495.140360]  [<000000004073bea0>] __dentry_kill+0x284/0x2e8
[71495.207240]  [<000000004073ec50>] shrink_dentry_list+0xe4/0x1e8
[71495.278284]  [<000000004073f044>] shrink_dcache_parent+0x1a0/0x250
[71495.352452]  [<000000004072489c>] vfs_rmdir+0x268/0x468
[71495.412868]  [<000000004072ce08>] do_rmdir+0x39c/0x418
[71495.476826]  [<000000004072d644>] sys_unlinkat+0xd0/0x110
[71495.540869]  [<0000000040303e30>] syscall_exit+0x0/0x10
[71495.604330]
[71495.622248] ---[ end trace 0000000000000000 ]---
[71583.296513] Backtrace:
[71583.300330]  [<0000000040834460>] proc_fill_cache+0x194/0x2b8
[71583.300330]  [<000000004083d678>] proc_readfd_common+0x16c/0x3c0
[71583.300330]  [<000000004083d904>] proc_readfd+0x38/0x68
[71583.300330]  [<0000000040733cf0>] iterate_dir+0xec/0x2f0
[71583.300330]  [<0000000040734ae4>] sys_getdents64+0xd8/0x1e0
[71583.300330]  [<0000000040303e30>] syscall_exit+0x0/0x10
[71583.300330]
[71583.300330]
[71583.300330] Page fault: bad address: Code=3D15 (Data TLB miss fault) at=
 addr 800002e76660997f
[71583.300330] CPU: 1 PID: 16466 Comm: ssh Tainted: G        W   E     5.1=
8.10+ #28
[71583.300330] Hardware name: 9000/785/C8000
[71583.300330]
[71583.300330]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[71583.300330] PSW: 00001000000001101111111100001111 Tainted: G        W  =
 E
[71583.300330] r00-03  000000ff0806ff0f 0000000041146a00 000000004073fd50 =
0000000057d7c490
[71583.300330] r04-07  00000000410e1a00 8d00dae766609a0b 000000005f0ea600 =
0000000057d7c3b0
[71583.300330] r08-11  0000000000000001 0000000057d7c5e0 0000000000000002 =
00000000416bf380
[71583.300330] r12-15  0000000057d7c4c0 0000000000000000 0000000000000000 =
0000000041412ad0
[71583.300330] r16-19  000000005f0ea900 00000000a0c15ff4 00000000416483e0 =
000000000800000f
[71583.300330] r20-23  000000005f0eaa50 000000000800000f 0000000055555556 =
000000005f0ea9a0
[71583.300330] r24-27  0000000057d7c4c0 0000000057d7c3b0 000000005f0ea900 =
00000000410e1a00
[71583.300330] r28-31  0000000000000000 0000000057d7c5e0 0000000057d7c610 =
0000000305036771
[71583.300330] sr00-03  0000000001e35000 0000000000000000 0000000000000000=
 0000000001e35000
[71583.300330] sr04-07  0000000000000000 0000000000000000 0000000000000000=
 0000000000000000
[71583.300330]
[71583.300330] IASQ: 0000000000000000 0000000000000000 IAOQ: 000000004073f=
dec 000000004073fdf0
[71583.300330]  IIR: 48bc3ee9    ISR: 000000000d00d800  IOR: 800002e766609=
97f
[71583.300330]  CPU:        1   CR30: 000000007fed0ce0 CR31: fffffffffffff=
fff
[71583.300330]  ORIG_R28: 0000000000000cc0
[71583.300330]  IAOQ[0]: d_alloc_parallel+0x220/0x748
[71583.300330]  IAOQ[1]: d_alloc_parallel+0x224/0x748
[71583.300330]  RP(r2): d_alloc_parallel+0x184/0x748
[71583.300330] Backtrace:
[71585.616335]  [<0000000040834460>] proc_fill_cache+0x194/0x2b8
[71585.616335]  [<000000004083d678>] proc_readfd_common+0x16c/0x3c0
[71585.616335]  [<000000004083d904>] proc_readfd+0x38/0x68
[71585.616335]  [<0000000040733cf0>] iterate_dir+0xec/0x2f0
[71585.616335]  [<0000000040734ae4>] sys_getdents64+0xd8/0x1e0
[71585.616335]  [<0000000040303e30>] syscall_exit+0x0/0x10
[71585.616335]
<Cpu1> 0300109101e00000  0000000000000000  CC_PROCS_ENTRY_OUT
[71586.384319] Kernel panic - not syncing: Page fault: bad address
