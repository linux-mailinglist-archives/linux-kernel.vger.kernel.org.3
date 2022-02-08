Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EF94AE43D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386304AbiBHW1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386893AbiBHVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:44 -0500
Received: from sonic311-27.consmr.mail.ne1.yahoo.com (sonic311-27.consmr.mail.ne1.yahoo.com [66.163.188.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086CC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1644355063; bh=jfCMh7HeiHuFFlvX6qW05R7eta1QF42/tYrxrrE7auA=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=JIrFyOfbyxP9HIDUhzKVugF33FpML0sJap+bcAP5TT9AqnBP7T47aNZXoKHm47S2GL1mmmGLVnvjSgnZk31oB3Ny4E0/0d1WtIbeBGSYruwjqufkOWnoWKjzk5iUlRf0xJOWQwdL9aDBDTav5bg2JXUvSeQd3pgsfGjxc4RJWLg=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1644355063; bh=Cs/wAZNwlOPJigJzrBy82H8oAZD/GzDX5y8zezP0vTQ=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=e0KDCoW/7cvvppDQMkfLF0H2G/uCaFTxjI4VySwy31vzHNyQ8Fq1qG59oCz/gBxyCPAcegqPLWSEjhb2g0TqDEvMIGmkGOvR4y7MN5gF8tZzcOKfPunB7CZdc5sy2NfSTTT2/Qx20x0rPNcUFXOzim2v/zvtqDZ/lDB1dx3BliufkTK+CL16XtDYatskZ/SX06DVlnitgsxzqNkdjVKNSxL8TTv7yczMStN7r5vb51Pr6U0N0NjdTRdHv2uJ1sFggtAxbztkuCuiM7VM7xSuZXcY09Kw3K8blj5YiCOSjnI83RXKf2bLwB+gBGZg+DzWQiODRxdXbwV6LeDkGOTCTA==
X-YMail-OSG: lazw2LsVM1k2YChY7iZc6yT7Z8BhjYZZEkvgf_dRxy1gsO4wzmIAMGEbnhTqBys
 1Hvbza07CRn76qR2bF2cTlXtN7hi70fuKYOqGOIDibzv5kQHKN4qmSZM8b33OrLXgyfUkweq45hx
 duhHUOuHtz77vobQ3N04DDOh5ZpD_GnZQOlUn2Z.KgxOydq9F_XM39_PK8U55Uv2LkrFzXQj5r2t
 tIdKdl2rHC.6hyOfaCVm_HebS0phZhI4sJjuON5TlOPY2OdKbjuatOni7RXyk4Ykdop1k6RCCUUV
 3oDor7MxyaZcWpZ2L8NzsXMBn4USy_InVBrHZf0UWvb_dBfsq8pSRHHiq6n7kqYsWIPVgbKW7.jz
 84ndB0_dAoH60kBaa3pYs7oKFF3ffPdWf3qDJOhDRYT3Hh275txs38X54j9jrc_5jVSalBUEjcQy
 ApIifWa.MbpU37vQ_ZGjbDd4fGbJ6fazx2nwJHZyjPaTC.3QwMnUx9y1L6DVJDnLVpa73pRu5FoX
 r.SjIMcCQqs1Gt2C4K_lfxwdp9rLYzQEQWry9hY2.nTPgQY.tTw60RCBt_nWs2KCSZ2jNq7k64kx
 OLbigcuIekWR9WgNJhUAueUtiFHnJTTnCjfEl6Q.GbPMYYvxaa5Mk.ETYWf8sukF9RY1wZtuRWSk
 sLaGPDytB9F1uqF_iibZomiuBZOsY1Xf6lFgwMlfKb3svpYc9nL8dNEFfhMyrDsmJUWQlA1eSTVk
 SAptrtF345ULtDByi6r5wekMHaLx8d78f70luuo577Bdkv_YujdcoZThFdoV5ZGHibW9aP0thm1N
 unl8uVjbj0c3dNFpkoYBke_KLYEicdd4gMuq4k64DIDzxtGgwxbGKyDOaccJ8.j8nYLVLml0_nw5
 0YPu26Z.z8Hjjty48xJHEHH8z49pizZ9Pbg4LGvn3KnSUxfSJKlXX0sW8dIoHgn7ysWFfD2NdtG1
 8OcRd1uSZQzBZkpGkbcDEYGhismpmpF0dk.3E4xeV.jhfO6BeEI8roSAdIyGznmf6Rud_JIxoWzo
 yKoW1__SAjdihJIFZznWLnO0FFLNYAZfZO7fjk4YUF_AHkw.XmzlvV37gImtgF89izDppjzCmVjB
 9Zq8tSa6HGHhBRQayjd7dZGjkrwTE2TWjm.4Z9AyIMlro6YyvzCEPzBJku2wqNQunl4xirdKX8dp
 9ERncEOEgNueaX0420Xh10t5ZbfTTBktcV5u2jChj3bcWWRyLP7P5wcVUBP2xgTZ5AHVSv1ldg.I
 LzHf0r7gIA76x9AdB18pTn91NxKdnirKCN3ThJmOSoO2FyQAcoLQ9_aN7iUA0kabxK8fVfzOuhqq
 bLNM2Ic89fjbHnC8_XAu_eLm6vrQ.YY5AckYOFjblovRw5aDWRJuauFVwk0f1ZXwgRrdKwo3EU1u
 W4DwO3.5v_yoUEEymf0AGvfQhMifZ1aACO7.pk2z0p9.zuiw4zifoo86JmFIoz202jPlEJXChoAp
 z_hJ49Iw5PFy8D4aLWz3Jikk4aO4IcB.qGo6nO7gzgwbJwYyVo93bPICv2_cgqNKZ3Ve3ZRVVbjl
 UKTYqnsJ6sK1GwLp_MqJpshqLWtndu08S6WKWYBC8sZHOvYk5kJNq.KkPxfKoMOqk5xY8cwFpiF5
 l82Nq1S3jBzooU6uaXmfNRgQcXAEIs0caUxE24dRFpFg35qjVLP31gv_ATSKPXByYMkj.3eUgNcs
 xgJ4HZ0M5QGOu.5L1KoKYudnfTiMwrgc8j4d5.H4gV51iCQxDm4zbTn4e3HIHPfXM1TY2W2losAr
 ecamGtdTBLWtQsWAm8TNbx2xySyLpSveLvWDmSzAEnOGzAOiPYmdT.N3RKHQOD9XNj8B8KhOGbK9
 gStlGaNdCbmC555EQLb94pZ4fGKfXAsqN7UqMFSUjm8zd1dBnLviKznwgGh68g3lxfblKoyyLCI7
 nKd6gPPx8.W72W1KKzZ4iBzkgcKeSN_OZoNu9DQhIaDHS7grd8wp4lgxFesTBniO1HD.GbH07p4u
 poa6lUrWqVorFph2MR5b17nMfp4mAfcAff9KRuBbefo_64R5ro8shaqDMV.A.vdOvCAlPAkyLux2
 7KCxHCqqZ_Jb_ERiFV0lhzJWzGKYuqlOZI13ZfcVXziY4N0MOdg4CLyywAxi06rebF4oMqSwTXeI
 tgZEJqzKvyb5xEEbFX5HEExdPxzDUSN6KG0X4q9d46XEMm_2Z9BTZgtDMInXtr4lHBL2WR9kXCdA
 cIcZX
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Feb 2022 21:17:43 +0000
Received: by kubenode527.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8a22ca70b6a728a6946f0ea8611dddc4;
          Tue, 08 Feb 2022 21:17:40 +0000 (UTC)
Date:   Tue, 08 Feb 2022 16:17:38 -0500
From:   Steven J Abner <pheonix.sja@att.net>
Subject: amd apu crashes
To:     linux-kernel@vger.kernel.org
Message-Id: <1644355058.23272.0@smtp.mail.att.net>
X-Mailer: pantheon-mail/1.0.8
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <1644355058.23272.0.ref@smtp.mail.att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
  I've been trying out kernel 5.16. Lots of amdgpu upgrades? However it 
seems to be
getting worse :(
  On AMD Ryzen 5 2400G, elementary OS 5.1.7, Ubuntu 18.04.6 LTS, Linux 
5.15.5-051505-generic, GTK 3.22.30. Background: Was using 5.16.6 when 
it started it's triple threat, so went back to 5.15 in panic. 
Previously, back in November, my first triple threat, I was on system 
with btrfs which destroyed my hard drive.
Rebuilt with ext4 and still trying to recreate the losses. Cant use 
higher Ubuntu due to still need afp to connect with mac for transfer, 
and elementary went even heavier with gtk, so crawls. I did find better 
workaround to afp, but not happy with Ubuntu's treatment of bug.
  The triple threat is when monitor flashes 3 times before total 
lockup. The last may have been but I was ready, hit reboot before third 
flash, so no test on it killing my hard drive.
  Guessing, it's not a true kernel problem, but gtk exploiting a 
weakness. Probably uninitialized pointer. But with new kernels, the 
crashes seem to be more frequent.
Here are the last few:
$ journalctl -o short-precise -f -k -b -3
-- Logs begin at Mon 2022-01-03 17:21:50 EST. --
Feb 05 08:37:32.229754 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:32.230639 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:32.273370 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:32.668947 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:32.794231 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:32.919503 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:33.044753 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:33.169986 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:33.295263 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out
Feb 05 08:37:33.420514 steven-ryzen kernel: AMD-Vi: Completion-Wait 
loop timed out

$ journalctl -o short-precise -f -k -b -2
-- Logs begin at Mon 2022-01-03 17:21:50 EST. --
Feb 07 06:11:47.495092 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: RW: 0x0
Feb 07 06:11:47.495199 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: [mmhub0] retry page fault (src_id:0 ring:0 vmid:7 pasid:32782, 
for process WebKitWebProces pid 5037 thread WebKitWebP:cs0 pid 5101)
Feb 07 06:11:47.495304 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: in page starting at address 0x000080010e24d000 from IH client 
0x12 (VMC)
Feb 07 06:11:47.495413 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
Feb 07 06:11:47.495520 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
Feb 07 06:11:47.495631 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: MORE_FAULTS: 0x0
Feb 07 06:11:47.495766 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: WALKER_ERROR: 0x0
Feb 07 06:11:47.495875 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: PERMISSION_FAULTS: 0x0
Feb 07 06:11:47.495987 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: MAPPING_ERROR: 0x0
Feb 07 06:11:47.496108 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: RW: 0x0

$ journalctl -o short-precise -f -k -b -1
-- Logs begin at Mon 2022-01-03 17:21:50 EST. --
Feb 07 16:49:00.229782 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: RW: 0x0
Feb 07 16:49:00.229898 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: [mmhub0] retry page fault (src_id:0 ring:0 vmid:3 pasid:32769, 
for process Xorg pid 2061 thread Xorg:cs0 pid 2062)
Feb 07 16:49:00.230010 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: in page starting at address 0x0000800101955000 from IH client 
0x12 (VMC)
Feb 07 16:49:00.230114 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
Feb 07 16:49:00.230220 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
Feb 07 16:49:00.230425 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: MORE_FAULTS: 0x0
Feb 07 16:49:00.230535 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: WALKER_ERROR: 0x0
Feb 07 16:49:00.230646 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: PERMISSION_FAULTS: 0x0
Feb 07 16:49:00.230771 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: MAPPING_ERROR: 0x0
Feb 07 16:49:00.230910 steven-ryzen kernel: amdgpu 0000:38:00.0: 
amdgpu: RW: 0x0

I haven't dealt with kernel debug for years, so please if more info 
needed, I probably don't remember how to get it.
If this is a bother, sorry I troubled you.
Per 'Do I have to be subscribed to post to the list?':
I wish to be personally CC'ed the answers/comments posted to the list 
in response to your posting, please.
Thanks Steve

