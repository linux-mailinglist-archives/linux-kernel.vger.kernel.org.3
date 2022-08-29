Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB15A4C08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiH2MhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiH2Mgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:36:55 -0400
Received: from sonic302-24.consmr.mail.ne1.yahoo.com (sonic302-24.consmr.mail.ne1.yahoo.com [66.163.186.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F917436F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1661775621; bh=FzJ4m4M3w53N7NQdJusfo1VfYGPaC+jsrMKVyE2Cxow=; h=Date:From:Subject:To:Cc:In-Reply-To:References:From:Subject:Reply-To; b=k6ixTCTgmcH5kzoQx4PHGgJ8Dgx4buwrfpX/oKmtFFDdjg28Woux0NgRx2NTKf0Bw/D7s3P9w+rXvt2cM8oK4+dqHzRb2I4lLZXiBVQRDvbStp/aViB94wRvsByRUBdAyL7Z6Ozz85tRFqWQtrNJ16bZdbaOco+AoHYPKYhIWI0=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661775621; bh=zCVcVuhE/UyhuZQsAwCHlxvG1zZP3IrA1z2QKCElrxm=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ZtLbG7vRU5yqhDYWObUcNHXQ+Zzf+VViUnD/KuoYfy89hCGZ2G4Hyhi/CEEVfmO8/KLMbsZMsgDzmkD1ecri2rq5I04E97gdGS5B+rOVDsc0ZgFS44l3UNUqUIeT7+/QTLdyXE1HIHoQXe1z+oMeJqiXYvXusqYbW2FmydU9wTDHuM7OumMNwhPpVPEFXVYwOjOMS4pBofetGTpzdzL4lxs4U1QISizQE3Sl2au521ml5uwFs6sOhUZz7Wshs6CwlqwUiOO5DnCr29Kp+uywVZIvC55CYTtDaK/m2pn84KBVjmf4kEsO4UkzuOwRxEXeBg/bcFPu1VVOOE2Yb7EPYg==
X-YMail-OSG: aVtxlbYVM1kSbDRjwKQ66EINaVQP3gdReZ9OGxwhKVSU1vZAnXflQQZwXbi.E7f
 KFWOuBxxOmtgmTPe8Hhza1OnqfADnW.0xmVftJCuuSRYHVLXssK7ayfN6qMYwoRW6j4Dq1g2F.An
 IOBKL1.YqLL6l7VN_ppPDE63jGqCMpUnQJbh04qNuFfWMRENdIheqYgYYwBP5dT3WCUJ78VGI7vq
 cfFfWYb54bNuXXQ5Dmb3PEB4XctbuUJvn255bd_2lRRxzYyvuO7zvXIwgMIRCIUFIL0o_RCUtkgI
 xwpzaU53t1CBx1LnpGpQ.4stjq6CMrcwJ.n..B9SWs4PCYlx725rHx11ppVAtBNIgxF0r6Yvxqoz
 0SQj0e0abTIALJolemp0Pquv3.BIF4PKMptkvynnVjHUJzqUCIDVMBpM4p0.PY.jtlvlF2YO8BW7
 WUFIWwN8t9LEIka_BN6ymQTZnv_DFM0QAWmSKf3ZMORXa3ghF3VqkV0RmBUCI3C_LTc5h72xH8PO
 DaBTMHsbcKL1nIfxrWjCWRYHwYKnh3fFkCsk3QPjk48ckXUj3qdh2wU0aj46zJMuBfsqY0gIcAEK
 .QAlzt3f18KhDaNthulQ_b2QqAE4ZyO48jYFYjaWPyRnk1mFsRRxand2s0V_..Ra8.MNzJ6LAoxZ
 Jk55cn_hpn9PK5ogdYQyGIPxNDemOeHCRWzYFESECeAoYyI.FVtZM_xCh02KYz.lVuPHC8mD4lxw
 LiSyUZqgJU.43N19xzfUHucDGcqseN62zWElrtod1d7LWwQKy5SEXUtvjFd0y7njxu.EmFHy8IlF
 cWg4PXKbaQUJOUq1zHpguK6e8YTUnZfNz.H3t1HZllhxWyd.aW1205xQLOtrt7zUy0sVizzDGntL
 JPVCxb2VF9TWW5KMudMcGjwTSuT6V0q0BIUpJs26ZUvZjmevb_9YRQL41fNjOYt2eF2MdSvRMOur
 IBq3H.rfPCC6rymqwwWEHMhiFeFkpNtEcZ3vM_GI5kj2P.MntkubXQTB29mmWeH6bbw8pGtDy7I5
 2Nnree0ZN0PXNu6QGN_anrMRnCoWsk.QOhFaVywoaGSZ8GCV2d4DxQtPuStA5DIP.QhjWbeNbxFe
 7IbxDYRLZAt2Payv87bG.0ShNNhF2QgVPfAFX_4u6GFLTTkf4snDTpV4_liOMOUE14ISemQBn7m1
 JMOAEfM9FQ5zq1iYWAvXRyaAfgOa1_7F_jfTgfFDMsq2zJtWwb4GSicpzW5yEA41BNOrm1aLZfhW
 qIfol7REB4Bkjar4ffMBBZsnbyaRrrWE_cFrAYyM0WCxZEjqi11viCl5OqlQ4.b8huHKtvMaOv.V
 Xlq1dy_ANTRaARrrwbbVJd8WWvCoWI9xGO.wnTxR.OWhP6goPaW6wzWGQJ4dUp7zLatOyrAL.GRc
 3RQjtljGu5vODNnt8y8WKKRo1aPlh0ksYwKlhhbfXJ30cYX.Pijki7qSNL7NNPTNRAxO6CiO1agd
 CePzDebDCY3GFsvLharcj92S4vHabrnurb0iX_RXLo8zfk2kXCRk6kwChEqfAWFx2S307Siwqk5m
 aScp6FuD5rWzHUajjl5dJUBWYfhNOEn_cm.aaMLMJPei.FnNQLkBp5fMgF680tWnSiGWJa9B69Bm
 GO._jLOghuVf_Adjy2CEeGd4vvBuQSPd_hKokmW_oUCqWfjXyiRdxvHMgu2vEeMcj2WRlx7G7_nM
 3_4lKL8WNi2QTs4VZs6QsTdt.JBIw53sZvAmIVCknnlpspxwrb6qM5sZXfEVeHHCXZCZ7UvGVHEg
 6ahaimhUqngNutXt5YSXfNpQ3XwhcoTpfNUZUQE8P6_hgA__6CUIR9HQORNZIBztDZpoxyk8cMvY
 JsN4sczyYYDU1usfyknF1VEcZS.zpKcJ58MCVjt7FK4lx.KbmJ1M1yns1inH227ePLxDcoiGJ4bX
 tv6V7.ple9Nr2rjqKeMrVo6uiz8ftWbsILM6bc.yMULWtexQo9ny1d5hRf0vNVyffM6JOYYM24tS
 GAVgA3Wf47Zz.g2UNk6HWflJr6sk1U6i1JoxTK8Qsox4QAXKprS.hUGSUdPbdGZkXUHgcXpxmert
 HqA2oC14TfPfdRjYDy.VWrNm_uYc9kpyeHV9Y6Yx20aEpnuyj4uJv01YlTf6ESgROW31rNEpsm2Y
 14ckgHFk.mxLuZkjv6fWSPXb.mkNoK9hVt6DMXfWnbG33VnsYv86wJer4g5ZEcZvhCpjVmskkEim
 fjDTuOO33WCHHgPodw07WyNW2
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Aug 2022 12:20:21 +0000
Received: by hermes--production-gq1-686964ccb6-z2kdz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b31fffa8eb0473f83fde84cab2d06af;
          Mon, 29 Aug 2022 12:20:17 +0000 (UTC)
Date:   Mon, 29 Aug 2022 08:20:09 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: Re: thermal driver patch
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <L9MDHR.JVBXTJ2L6TPP2@att.net>
In-Reply-To: <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
        <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 29, 2022 at 05:47, Randy Dunlap <rdunlap@infradead.org> 
wrote:
> a. the exact message(s) [copy-paste]
> c. what kernel version is causing the problem

[    0.000000] Linux version 5.18.12-051812-generic (kernel@sita) (gcc 
(Ubuntu 11.3.0-4ubuntu1) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 
2.38.50.20220629) #202207150942 SMP PREEMPT_DYNAMIC Fri Jul 15 10:10:55 
UTC 2022
[    5.244369] thermal thermal_zone0: failed to read out thermal zone 
(-61)

[    0.000000] Linux version 5.4.204-0504204-generic (kernel@kathleen) 
(gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)) #202207071639 SMP 
Thu Jul 7 16:59:09 UTC 2022
[    5.207243] thermal thermal_zone0: failed to read out thermal zone 
(-61)

as to reproduce, can only think of saying: boot up kernel without 
patched?

additional info that may? help:
I did not trace what calls 'update_temperature', just saw any call to it
will cause message due to it's call to 'thermal_zone_get_temp', which 
states
no thermal_zone_device should provide or be requesting an update.
It may be that if 'thermal_zone_get_temp' where removed was actual 
function's
intent, and all instances in this file and other function's use was a 
case of designer debugging or signaling a deprecated API? That was my 
intent on saying
'for you to do and review', because it looked like a lot of functions 
could be
updated to take into account that no device should call functions that 
start off
by calling 'thermal_zone_get_temp'.
  It is more probable that my patch suggestion is wrong and calls to
'update_temperature' are suppose to fail with return -ENODEV always 
allowing
other calls to 'update_temperature' to fail also. With proposed code, 
I've not
seen adverse side effects. It just removed dmesg error, but was hoping 
I would
get lucky and it was the reason for CPUTIN -62C without actually hard 
work of
finding real reason.

additional dmesg info:
only other 'thermal' are 'thermal_sys' loading governors
smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 
0x17, model: 0x11, stepping: 0x0)
from lspci:
Kernel driver in use: k10temp
from lsmod:
nct6775
hwmon_vid
these 2 removed in personal configs, but used in the two ubuntu kernel 
builds:
wmi
wmi_bmof

Steve


