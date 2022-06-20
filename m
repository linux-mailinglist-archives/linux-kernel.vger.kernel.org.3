Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0193551FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiFTPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiFTPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:07:31 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583882CDF8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:47:01 -0700 (PDT)
X-ASG-Debug-ID: 1655735631-1cf43917f34590c0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id rNTjWzLE3XOW6cDI; Mon, 20 Jun 2022 10:33:51 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=NyOBabcM6HAlwTl1JjR0XgckKmX0BhrhtQCHxztObkw=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=DA8qGE40RlmQr6pbL9qx
        /yR4uAijBdwoP1qIlS2aZf0sbyXaMUs3AAdxt7lV7AXtPNmyGyl832BiLjrWRUzNxxDrGjc8l8lTq
        JbhEHCwwBAaiaT75R7BOcnblcJc9FlnsszJxK7nVf6nft+305g7KEhLjk6uBpgghugBTXmgvdU=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11936878; Mon, 20 Jun 2022 10:33:51 -0400
Message-ID: <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
Date:   Mon, 20 Jun 2022 10:33:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [REGRESSION] qla2xxx: tape drive not removed after unplug FC
 cable
Content-Language: en-US
X-ASG-Orig-Subj: Re: [REGRESSION] qla2xxx: tape drive not removed after unplug FC
 cable
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Arun Easi <aeasi@marvell.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1655735631
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 14121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 02:56, Thorsten Leemhuis wrote:
> Hi!
>
> On 28.05.22 02:27, Arun Easi wrote:
>> Hi Tony,
>>
>> Thanks for reporting the issue. We are trying to recreate this issue in 
>> house. I will reach out to you for logs, if we cannot repro. Typically, we 
>> get sufficient context to the issue when the problem is reproduced with 
>> module parameter "ql2xextended_error_logging=1".
>>
>> Anyway, I will let you know the status.
> What's the status here? Tony, did you provide the info Arun asked for=
> Or was some progress made somehow without it?
>
I was waiting for them to reproduce the problem, or ask for logs. 
Anyway, here are the logs they said they might want:

modprobe qla2xxx ql2xextended_error_logging=1

Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.07.400-k-debug.
Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 37 iobase 0x00000000875338f3.
Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00c6:6: MSI-X: Using 26 vectors
Jun 20 13:51:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-0075:6: ZIO mode 6 enabled; timer delay (200 us).
Jun 20 13:51:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-ffff:6: FC4 priority set to NVMe
Jun 20 13:51:48 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-507b:6: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
Jun 20 13:51:50 tony13 kern.info kernel: scsi host6: qla2xxx
Jun 20 13:51:50 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
Jun 20 13:51:51 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-400f:6: Loop resync scheduled.
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fb:6: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fc:6: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.0 hdma- host#=6 fw=8.07.12 (d0d5).
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 135 iobase 0x000000007cfbf1eb.
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00c6:7: MSI-X: Using 26 vectors
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-0075:7: ZIO mode 6 enabled; timer delay (200 us).
Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: FC4 priority set to NVMe
Jun 20 13:51:57 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-507b:7: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
Jun 20 13:51:58 tony13 kern.info kernel: scsi host7: qla2xxx
Jun 20 13:51:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 20 13:51:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 20 13:52:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fb:7: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
Jun 20 13:52:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fc:7: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.1 hdma- host#=7 fw=8.07.12 (d0d5).
Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-8038:6: Cable is unplugged...
Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-803a:6: fw_state=4 (7, 141, 0, 800 0) curr time=ffffc764.
Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-206c:6: qla2x00_loop_resync *** FAILED ***.
Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4010:6: Loop resync end.
Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8038:7: Cable is unplugged...
Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=4 (7, 141, 0, 800 0) curr time=ffffcaac.
Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206c:7: qla2x00_loop_resync *** FAILED ***.
Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.

Plug in cable

Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5009:7: LIP occurred (0).
Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b7:7: Format 0 : Number of VPs setup 254, number of VPs acquired 1.
Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b8:7: Primary port id 0000ef.
Jun 20 13:52:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
Jun 20 13:52:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5012:7: Port database changed ffff 0006 0000.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8037:7: F/W Ready - OK.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=3 (7, 141, 0, 800 0) curr time=ffffd9e8.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-200b:7: HBA in NL topology.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2014:7: Configure loop -- dpc flags = 0x112e0.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2011:7: Entries in ID list (1).
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d8:7: qla24xx_fcport_handle_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 P 0 fl 0 confl 0000000000000000 rscn 0|0 login 0 lid 0 scan 2 fc4type 0
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-307b:7: qla_chk_n2n_b4_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 lid 0 retries=30
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20bf:7: qla_chk_n2n_b4_login 1628 50:00:e1:11:c5:27:f0:70 post login
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2069:7: LOOP READY.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206b:7: qla2x00_configure_loop: exiting normally. local port wwpn 2100000e1e2227a1 id 0000ef)
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: DELETED to LOGIN_PEND - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2072:7: Async-login - 50:00:e1:11:c5:27:f0:70 hdl=2, loopid=0 portid=000026 retries=29 .
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5036:7: Async-login complete: handle=2 pid=000026 wwpn=50:00:e1:11:c5:27:f0:70 iop0=312
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dd:7: qla2x00_async_login_sp_done 50:00:e1:11:c5:27:f0:70 res 0 
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: qla24xx_handle_plogi_done_event 50:00:e1:11:c5:27:f0:70 DS 3 LS 7 rc 0 login 0|0 rscn 0|0 data 4000|0 iop 0|0
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ea:7: qla24xx_handle_plogi_done_event 2232 50:00:e1:11:c5:27:f0:70 LoopID 0x0 in use with 000026. post gpdb
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: LOGIN_PEND to GPDB - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dc:7: Async-gpdb 50:00:e1:11:c5:27:f0:70 hndl 0 opt 0
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20db:7: Async done-gpdb res 0, WWPN 50:00:e1:11:c5:27:f0:70 mb[1]=0 mb[2]=ffdd 
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d2:7: qla24xx_handle_gpdb_event 50:00:e1:11:c5:27:f0:70 DS 5 LS 6 fc4_type 0 rc 0
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2062:7: 50:00:e1:11:c5:27:f0:70 SVC Param w3 0312
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: GPDB to UPD_FCPORT - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ef:7: qla2x00_update_fcport 50:00:e1:11:c5:27:f0:70
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to UPD_FCPORT - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from UNCONFIGURED to ONLINE - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ee:7: qla2x00_reg_remote_port: 5000e111c527f070. rport 7:0:0 (00000000bd175424) is tgt mode
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to LOGIN_COMPLETE - portid=000026.
Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-911e:7: qla_register_fcport_fn rscn gen 0/0 next DS 0
Jun 20 13:52:59 tony13 kern.notice kernel: scsi 7:0:0:0: Sequential-Access IBM      ULTRIUM-HH8      K4K1 PQ: 0 ANSI: 6
Jun 20 13:52:59 tony13 kern.notice kernel: scsi 7:0:0:0: Attached scsi generic sg1 type 1
Jun 20 13:52:59 tony13 kern.info kernel: st: Version 20160209, fixed bufsize 32768, s/g segs 256
Jun 20 13:52:59 tony13 kern.notice kernel: st 7:0:0:0: Attached scsi tape st0
Jun 20 13:52:59 tony13 kern.info kernel: st 7:0:0:0: st0: try direct i/o: yes (alignment 8 B)

Unplug cable

Jun 20 13:54:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
Jun 20 13:54:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost

sleep 180

cat /proc/scsi/scsi 
Attached devices:
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
  Type:   Sequential-Access                ANSI  SCSI revision: 06

rmmod qla2xxx

Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-b079:7: Removing driver
Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00af:7: Performing ISP error recovery - ha=00000000c584070c.
Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4011:7: DPC handler exiting.
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from ONLINE to DEAD - portid=000026.
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-b079:6: Removing driver
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00af:6: Performing ISP error recovery - ha=000000008a8560d1.
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-20f1:6: Mark all dev lost
Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4011:6: DPC handler exiting.

Tony Battersby
Cybernetics

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
>> On Wed, 25 May 2022, 3:03pm, Tony Battersby wrote:
>>
>>> #regzbot introduced: 44c57f205876
>>>
>>> I have several different QLogic FC HBAs (8, 16, 32 Gbps) and several
>>> different FC LTO tape drives (IBM Ultrium 8 & 9).  When I plug in the FC
>>> cable, the tape drive shows up as a SCSI device as expected.  With older
>>> kernels, when I unplug the FC cable, the tape drive SCSI device would
>>> disappear after about 30 seconds.  But with newer kernels (including
>>> 5.18), when I unplug the FC cable, the tape drive SCSI device never
>>> disappears.  I have bisected the change in behavior to the following
>>> commit in kernel 5.15:
>>>
>>> 44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
>>>
>>> This commit has been backported to various -stable kernels, so they are
>>> also affected.
>>>
>>> When testing with two different tape drives:
>>> 1) Plug FC cable into tape drive A.  Tape drive A shows up as a SCSI device.
>>> 2) Unplug FC cable; wait 60 seconds.  Tape drive A does not disappear.
>>> 3) Plug FC cable into tape drive B.  Tape drive A disappears 30 seconds
>>> later, but tape drive B does not show up.
>>> 4) Unplug FC cable and plug it back into tape drive B.  Tape drive B
>>> shows up as a SCSI device.
>>>
>>> So I can actually make a tape drive disappear by plugging the cable into
>>> a different tape drive, but then I have to reseat the cable again to
>>> make the new tape drive show up.
>>>
>>> lspci -n
>>> 83:00.0 0c04: 1077:2031 (rev 02)
>>> 83:00.1 0c04: 1077:2031 (rev 02)
>>>
>>> When plugging in cable:
>>> qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
>>>
>>> When unplugging cable with old kernel:
>>> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
>>> rport-7:0-2: blocked FC remote port time out: removing target and saving binding
>>>
>>> When unplugging cable with new kernel:
>>> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
>>>
>>> /sys/class/fc_remote_ports/rport-*/
>>> dev_loss_tmo: 30
>>> supported_classes: Class 3
>>> port_state: Online
>>> (port_state remains Online even when FC cable unplugged)
>>>
>>> /proc/scsi/scsi
>>> Host: scsi7 Channel: 00 Id: 01 Lun: 00
>>>   Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
>>>   Type:   Sequential-Access                ANSI  SCSI revision: 06
>>>
>>> Tony Battersby
>>> Cybernetics
>>>

