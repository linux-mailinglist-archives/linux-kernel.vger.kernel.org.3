Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB5577595
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGQJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:43:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997215FC4;
        Sun, 17 Jul 2022 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658050972;
        bh=vhwv/cE+/iUvXmdeeOxc1S09IIZs//noF3qbXj0s4ug=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ldFgD2eaZD1pVw5asOs0QWKCUYx+HxS5sOeDtjxI9Z83CYvqkjU+pxDljX6RY5cbE
         N+w4iuHbcEPCJldOAGZUFnHu7674HOYkkjLQdxtg17oJeSfHHIvqx72u8DYSD334R/
         S9hAljR+zLCnayaeS4qTxyzYIsF9oyeXtSFDmj8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.157.253]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1oL1QN1Nml-009f7X; Sun, 17
 Jul 2022 11:42:52 +0200
Message-ID: <7bc6b466-9b9a-b857-8f72-2dce99b18939@gmx.de>
Date:   Sun, 17 Jul 2022 11:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
In-Reply-To: <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQ+ywuZzB3aULnrtb/vHM3ak6A5Ja+/LBhNDG6rPrOsDe9ifuT2
 c3NsARU749IitoGoiNBXKM3kGQ3hEH/MaVw9Eb+uCyt8O6TvbzclhzmYyZBGtDqT/j+vojE
 sxqNvAhOAkl+iK57yPFsinxOXoi7QbRS/mL8f4lJ3/nUuv0S06xnjQuHSIH6HY/zDNGJzdF
 +PI2JC7kfoxm4XhRYUbLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NpoQklh7Dzg=:SfpiFBo5DhNLMAvsJuxww9
 txhzeR5dzZAIep6I4yByRa0d6wCCE//R31VHnFSqwqKk5/O3kzi466Hdb5AczxJaBZqstLLt1
 OTwGYkFs1NTvS7UdfSwO6+NMTcTkqipK9FQXnfHxN6cOEPWCnf3M3kVCpAkDeOnfknJstluJN
 6b0jzLewcN1LG1iVHeVpzIRSofTgK5grF8Ei4GNNW4HFKQzGQt2zMIF2nsfwMBYKl3J1SsO7J
 R7v2gH90diDIrAyjHwE5q9gJUdsoPXuhovIZoE2Qjr8x37p+NO87ntUUG2CqAUsm62+XddPj7
 CWj9QEey32y0BZL7Mm9P2ZaJ5+rlfNIvrenu8Nt+RSdzDstWr5To0wjkZJJ689oNmU+3to5Nm
 6rAnzpxPf4h3HfmZ70qTp2yhYEZMx5suiCVr86e5I6OytTlNast2880SP60mbxo8GltvcIAMD
 D/xjxTu4iVfPlYO6viVwZMfVgd0lk1Mla8ecjIsqr0lLf9nfgUw98y0Nnn8zUcns9DDw76nyb
 8+Ujq33+lxFepwIAmJnu73Gfg4yNtruWpz0kGShoM/x0q8bYdBlnIlyGMZDIEgKE6aZ/F5IoP
 Amz553zWtU/fEyeavNS+a2jeVCjWNyvYNDl/3VqUAtd/aiCtj4+uebTjHYqmomo5WGw6zBrou
 0Fe+f+VkDPxDXaQtV+NgEzmFTysTXlKVPVb6Boh1UcimPA85t+KM64ZbCqkvxh9W+QpnFxl5p
 B6b5X4951TC+StAE1hREhuf5fkfwb4nNN5QkKlRBMq0jB9/uUPfOyQJMSCztTLRu9BE7gRUQf
 VBUXRtCw3AaR98f2rdbPApxtoSggY4eQGEOp1TB23cVuF3DAMDLs4gbVFjFw4XdZVSNOLsQSs
 cegW8+XMeL2iRyssmCn65O2kTJFj8MwuGhEOa/i6eVWYYbfIWKIbnYB9hMocAroJfy1t6kYF+
 s9Co3cC45fzbyR4XSOEEM2Cg1/Si8MJ5qsjI3bmhQs6UKyhChlu1+m+VWjk6PF6ECYOCEYRoQ
 jrnTPTFic8PTBkPH4Gr1YN/FoE2hbjLYlhdSuQ23EdDzxAEgAG/5vpoZDdiNcRQbFP7yE4pbl
 7L3wH7y1sPD6syYEDFwy/E6jfdE4fHSZvzqavvtIEhWCfqv/8++5J1neg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 7/16/22 07:27, Helge Deller wrote:
> On 7/15/22 15:33, Hillf Danton wrote:
>> On Fri, 15 Jul 2022 10:18:23 +0200 Helge Deller  wrote:
> and this was the output:
>
> [108563.953441]  IAOQ[1]: dentry_free+0xc4/0x338
> [108564.005441]  RP(r2): __dentry_kill+0x284/0x2e8
> [108564.057443] Backtrace:
> [108564.089454]  [<000000004073bab0>] __dentry_kill+0x284/0x2e8
> [108564.157445]  [<000000004073d2f8>] dput+0x334/0x5a8
> [108564.213444]  [<00000000407267a4>] step_into+0x790/0xa88
> [108564.277444]  [<0000000040727084>] walk_component+0xa8/0x330
> [108564.345443]  [<00000000407275f8>] link_path_walk.part.0.constprop.0+=
0x2ec/0x4d0
> [108564.437443]  [<0000000040728254>] path_openat+0x150/0x1ba8
> [108564.501441]  [<000000004072ba28>] do_filp_open+0x9c/0x198
> [108564.569441]  [<0000000040701d20>] do_sys_openat2+0x14c/0x2a8
> [108564.637441]  [<0000000040702654>] compat_sys_openat+0x58/0xb8
> [108564.705440]  [<0000000040303e30>] syscall_exit+0x0/0x10
> [108564.769444]
> [108564.789435] ---[ end trace 0000000000000000 ]---
> [108564.845444] dentry =3D 000000031624e6c0
> [108564.889437] spin_is_locked(&dentry->d_lock) =3D 0
> [108564.945436] dname_external(dentry) =3D 0
> [108564.993436] dentry->d_flags & DCACHE_NORCU =3D 0
> [108565.045446] dentry->d_name.len =3D 3
> [108565.089435] dentry->d_name.hash =3D 89116695
> [108565.137435] dentry->d_lockref.count =3D -128
> [108565.189434] dentry->d_flags =3D 32776
> [108565.233435] dentry->d_inode =3D 0000000000000000
> [108565.285429] dentry->d_parent =3D 000000022ef756c0
> [108565.341434] dentry->d_u.d_rcu =3D 0x416be770
>
>> Add debug info to the diff below. Cut the first BUG_ON off if it>> trig=
gers and see if the second one can be hit.

I used WARN_ON() instead of BUG_ON().
With that, both triggered, first the first one, then the second one.
Full log is here:
http://dellerweb.de/testcases/minicom.dcache.crash.6-warn

Helge

>> +++ y/fs/dcache.>> @@ -605,8 +605,10 @@ static void __dentry_kill(struc=
t dentry
>>  		spin_unlock(&parent->d_lock);
>>  	if (dentry->d_inode)
>>  		dentry_unlink_inode(dentry);
>> -	else
>> +	else {
>> +		BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>>  		spin_unlock(&dentry->d_lock);
>> +	}
>>  	this_cpu_dec(nr_dentry);
>>  	if (dentry->d_op && dentry->d_op->d_release)
>>  		dentry->d_op->d_release(dentry);
>> @@ -616,6 +618,7 @@ static void __dentry_kill(struct dentry
>>  		dentry->d_flags |=3D DCACHE_MAY_FREE;
>>  		can_free =3D false;
>>  	}
>> +	BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>>  	spin_unlock(&dentry->d_lock);
>>  	if (likely(can_free))
>>  		dentry_free(dentry);

