Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F073553E49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354860AbiFUWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354158AbiFUWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:05:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0E2EA0C;
        Tue, 21 Jun 2022 15:05:37 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LLW0MX024435;
        Tue, 21 Jun 2022 15:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=2bknUX5O7965J6L2q5e6pSLs4WQggrL4P2+DDTObS3U=;
 b=ZNsEK5V9aLLkByMnCo75C81RXJWVxY0jGHF09ZfIHCpmluYFLYX/mz2VjE86GGKE8eLY
 Nja6Jrbn8vL1THMIuUPrimq9QLUj2Rj+VMKTeL1tzKjJfbV38LG9csBtX3ujiOmn64zr
 GeFUpUVeqO5NStViY6K3si4VGdnYNArB4kmM3O2k2tf9xtkAf5cLVz6C7/3r+btYkDZc
 D/Un4fDQw+JmbM84Vq3k3cNp2kF3Pxsv80uM7g5+2XqEq3h/X156GFA+OmGz8wqLb9Ie
 T8A+yNBiJWQEgIvhwnMHxZpXvAbyH3QLnEwbcRmt3ZK1aVvsLiOvfZKJjIPdL8dT22KM 9A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gse7np37f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 15:05:24 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jun
 2022 15:05:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Jun 2022 15:05:22 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id BFF3A3F7066;
        Tue, 21 Jun 2022 15:05:22 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 25LM5Kls014586;
        Tue, 21 Jun 2022 15:05:21 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 21 Jun 2022 15:05:20 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     Tony Battersby <tonyb@cybernetics.com>
CC:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
In-Reply-To: <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
Message-ID: <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
 <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-1695936884-1655849122=:4730"
X-Proofpoint-GUID: FizcLzr81MGexsAvP8-eymxfFXPYcrGH
X-Proofpoint-ORIG-GUID: FizcLzr81MGexsAvP8-eymxfFXPYcrGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_09,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-1695936884-1655849122=:4730
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

Hi Tony,

Apologies for the delay. This was not forgotten, there were repro attempts 
and discussions happening internally.

See further comments inline..

On Mon, 20 Jun 2022, 7:33am, Tony Battersby wrote:

> 
> ----------------------------------------------------------------------
> On 6/20/22 02:56, Thorsten Leemhuis wrote:
> > Hi!
> >
> > On 28.05.22 02:27, Arun Easi wrote:
> >> Hi Tony,
> >>
> >> Thanks for reporting the issue. We are trying to recreate this issue in 
> >> house. I will reach out to you for logs, if we cannot repro. Typically, we 
> >> get sufficient context to the issue when the problem is reproduced with 
> >> module parameter "ql2xextended_error_logging=1".
> >>
> >> Anyway, I will let you know the status.
> > What's the status here? Tony, did you provide the info Arun asked for=
> > Or was some progress made somehow without it?
> >
> I was waiting for them to reproduce the problem, or ask for logs. 
> Anyway, here are the logs they said they might want:
> 
> modprobe qla2xxx ql2xextended_error_logging=1
> 
> Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.07.400-k-debug.
> Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
> Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 37 iobase 0x00000000875338f3.
> Jun 20 13:51:46 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00c6:6: MSI-X: Using 26 vectors
> Jun 20 13:51:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-0075:6: ZIO mode 6 enabled; timer delay (200 us).
> Jun 20 13:51:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-ffff:6: FC4 priority set to NVMe
> Jun 20 13:51:48 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-507b:6: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
> Jun 20 13:51:50 tony13 kern.info kernel: scsi host6: qla2xxx
> Jun 20 13:51:50 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
> Jun 20 13:51:51 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-400f:6: Loop resync scheduled.
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fb:6: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fc:6: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.0 hdma- host#=6 fw=8.07.12 (d0d5).
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 135 iobase 0x000000007cfbf1eb.
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00c6:7: MSI-X: Using 26 vectors
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-0075:7: ZIO mode 6 enabled; timer delay (200 us).
> Jun 20 13:51:55 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: FC4 priority set to NVMe
> Jun 20 13:51:57 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-507b:7: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
> Jun 20 13:51:58 tony13 kern.info kernel: scsi host7: qla2xxx
> Jun 20 13:51:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
> Jun 20 13:51:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
> Jun 20 13:52:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fb:7: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
> Jun 20 13:52:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fc:7: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.1 hdma- host#=7 fw=8.07.12 (d0d5).
> Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-8038:6: Cable is unplugged...
> Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-803a:6: fw_state=4 (7, 141, 0, 800 0) curr time=ffffc764.
> Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-206c:6: qla2x00_loop_resync *** FAILED ***.
> Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4010:6: Loop resync end.
> Jun 20 13:52:11 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
> Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8038:7: Cable is unplugged...
> Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=4 (7, 141, 0, 800 0) curr time=ffffcaac.
> Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206c:7: qla2x00_loop_resync *** FAILED ***.
> Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
> Jun 20 13:52:20 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
> 
> Plug in cable
> 
> Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5009:7: LIP occurred (0).
> Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b7:7: Format 0 : Number of VPs setup 254, number of VPs acquired 1.
> Jun 20 13:52:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b8:7: Primary port id 0000ef.
> Jun 20 13:52:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
> Jun 20 13:52:58 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5012:7: Port database changed ffff 0006 0000.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8037:7: F/W Ready - OK.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=3 (7, 141, 0, 800 0) curr time=ffffd9e8.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-200b:7: HBA in NL topology.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2014:7: Configure loop -- dpc flags = 0x112e0.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2011:7: Entries in ID list (1).
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d8:7: qla24xx_fcport_handle_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 P 0 fl 0 confl 0000000000000000 rscn 0|0 login 0 lid 0 scan 2 fc4type 0
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-307b:7: qla_chk_n2n_b4_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 lid 0 retries=30
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20bf:7: qla_chk_n2n_b4_login 1628 50:00:e1:11:c5:27:f0:70 post login
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2069:7: LOOP READY.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206b:7: qla2x00_configure_loop: exiting normally. local port wwpn 2100000e1e2227a1 id 0000ef)
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: DELETED to LOGIN_PEND - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2072:7: Async-login - 50:00:e1:11:c5:27:f0:70 hdl=2, loopid=0 portid=000026 retries=29 .
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5036:7: Async-login complete: handle=2 pid=000026 wwpn=50:00:e1:11:c5:27:f0:70 iop0=312
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dd:7: qla2x00_async_login_sp_done 50:00:e1:11:c5:27:f0:70 res 0 
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: qla24xx_handle_plogi_done_event 50:00:e1:11:c5:27:f0:70 DS 3 LS 7 rc 0 login 0|0 rscn 0|0 data 4000|0 iop 0|0
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ea:7: qla24xx_handle_plogi_done_event 2232 50:00:e1:11:c5:27:f0:70 LoopID 0x0 in use with 000026. post gpdb
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: LOGIN_PEND to GPDB - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dc:7: Async-gpdb 50:00:e1:11:c5:27:f0:70 hndl 0 opt 0
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20db:7: Async done-gpdb res 0, WWPN 50:00:e1:11:c5:27:f0:70 mb[1]=0 mb[2]=ffdd 
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d2:7: qla24xx_handle_gpdb_event 50:00:e1:11:c5:27:f0:70 DS 5 LS 6 fc4_type 0 rc 0
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2062:7: 50:00:e1:11:c5:27:f0:70 SVC Param w3 0312
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: GPDB to UPD_FCPORT - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ef:7: qla2x00_update_fcport 50:00:e1:11:c5:27:f0:70
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to UPD_FCPORT - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from UNCONFIGURED to ONLINE - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ee:7: qla2x00_reg_remote_port: 5000e111c527f070. rport 7:0:0 (00000000bd175424) is tgt mode
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to LOGIN_COMPLETE - portid=000026.
> Jun 20 13:52:59 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-911e:7: qla_register_fcport_fn rscn gen 0/0 next DS 0
> Jun 20 13:52:59 tony13 kern.notice kernel: scsi 7:0:0:0: Sequential-Access IBM      ULTRIUM-HH8      K4K1 PQ: 0 ANSI: 6
> Jun 20 13:52:59 tony13 kern.notice kernel: scsi 7:0:0:0: Attached scsi generic sg1 type 1
> Jun 20 13:52:59 tony13 kern.info kernel: st: Version 20160209, fixed bufsize 32768, s/g segs 256
> Jun 20 13:52:59 tony13 kern.notice kernel: st 7:0:0:0: Attached scsi tape st0
> Jun 20 13:52:59 tony13 kern.info kernel: st 7:0:0:0: st0: try direct i/o: yes (alignment 8 B)
> 
> Unplug cable
> 
> Jun 20 13:54:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
> Jun 20 13:54:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost
> 
> sleep 180
> 
> cat /proc/scsi/scsi 
> Attached devices:
> Host: scsi7 Channel: 00 Id: 00 Lun: 00
>   Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
>   Type:   Sequential-Access                ANSI  SCSI revision: 06

Thanks for the info. Just to reiterate, you've reported two issues (though 
this log was showing only 1 of them).

Issue 1 - Tape device never disappears when removed
Issue 2 - When a direct connected tape 1 was replaced with tape 2, tape 2 
          was not discovered.

For Issue-2, please try the attached patch. This may not be the final fix, 
but wanted to check if that would fix the issue for you.

For Issue-1, the behavior was intentional, though that behavior needs 
refinement. These tape drives support something called FC sequence level 
error recovery (added in FCP-2), which can make tape I/Os survive even 
across a short cable pull. This is not a simple retry of the I/O, rather a 
retry done at the FC sequence level that gives the IO a better chance of
revival. In other words, the said patch that caused regression, while 
introduces an incorrect reporting of the state of the device, makes backup 
more resilient.

Now, onto the behavior when device state is reported immediately. What we 
have observed, at least with one tape drive from a major vendor, is that, 
across a device loss and device back case with both the events reported to 
upper layers, the backup operation was getting failed. This is due to a 
REPORT LUNS command being issued during device reappearance reporting 
(fc_remote_port_add -> SCSI scan), which the tape drive was not expecting 
and caused the backup to fail.

I know that some tape drives do not support multiple commands to it at the 
same time, but not sure if that is still the norm these days.

So, perhaps one way to make the behavior better, is to either report the 
disappearing device a bit delayed or have intelligence added in SCSI scan 
to detect ongoing tape IO operations and delay/avoid the REPORT LUNs. 
Former is a more contained (in the LLD) fix.

Regards,
-Arun

> 
> rmmod qla2xxx
> 
> Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
> Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-b079:7: Removing driver
> Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00af:7: Performing ISP error recovery - ha=00000000c584070c.
> Jun 20 14:00:18 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4011:7: DPC handler exiting.
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from ONLINE to DEAD - portid=000026.
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-b079:6: Removing driver
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00af:6: Performing ISP error recovery - ha=000000008a8560d1.
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-20f1:6: Mark all dev lost
> Jun 20 14:00:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4011:6: DPC handler exiting.
> 
--1879738122-1695936884-1655849122=:4730
Content-Type: text/plain; charset="US-ASCII";
	name="0001-qla2xxx-Fix-discovery-issues-in-FC-AL-topology.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.21.9999.2206211505200.4730@mvluser05.qlc.com>
Content-Description: 
Content-Disposition: attachment;
	filename="0001-qla2xxx-Fix-discovery-issues-in-FC-AL-topology.patch"

RnJvbSBhZjU4MzczYzZhNjFmNzRiM2IxOTBlMTczMzNiM2IxZTRkMTUxOTE5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQXJ1biBFYXNpIDxh
ZWFzaUBtYXJ2ZWxsLmNvbT4NCkRhdGU6IFRodSwgMTYgSnVuIDIwMjIgMTc6
MzE6NDMgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0gcWxhMnh4eDogRml4IGRp
c2NvdmVyeSBpc3N1ZXMgaW4gRkMtQUwgdG9wb2xvZ3kNCg0KVG9wb2xvZ3k6
IEFyYml0cmF0ZWQgbG9vcA0KRGV2aWNlOiBUYXBlIChGQ1AtMiBkZXZpY2Up
DQpJc3N1ZToNCiAgMS4gQ29ubmVjdCBUYXBlLUEgZGlyZWN0bHkgdG8gdGhl
IEhCQSBwb3J0DQogIDIuIERpc2Nvbm5lY3QgaXQgYW5kIGNvbm5lY3QgVGFw
ZS1CDQogIDMuIFRhcGUtQiBpcyBub3QgZGlzY292ZXJlZCBieSB0aGUgSEJB
IGRyaXZlcg0KICA0LiBXaGVuIFRhcGUtQiBpcyBkaXNjb25uZWN0ZWQgYW5k
IGNvbm5lY3RlZCBiYWNrLCBpdCBzaG93cyB1cA0KDQpUbyBmaXggdGhpcywg
d2hlbiBHZXQgSUQgTGlzdCByZXBvcnRzIG5vIGRldmljZXMgYW5kIGxvb3Ag
bWFwDQpyZXBvcnRzIHRoZXJlIGFyZSBkZXZpY2VzLCBpc3N1ZSBhIHJlLWlu
aXQgc28gdGhhdCBkZXZpY2UgbG9naW4NCmNvdWxkIGJlIHBlcmZvcm1lZCBk
dXJpbmcgbmV4dCBsaW5rIGluaXRpYWxpemF0aW9uLg0KDQpSZXBvcnRlZC1i
eTogVG9ueSBCYXR0ZXJzYnkgPHRvbnliQGN5YmVybmV0aWNzLmNvbT4NClNp
Z25lZC1vZmYtYnk6IEFydW4gRWFzaSA8YWVhc2lAbWFydmVsbC5jb20+DQot
LS0NCiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfZ2JsLmggIHwgIDMgKyst
DQogZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2luaXQuYyB8IDI5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9zY3NpL3FsYTJ4
eHgvcWxhX21ieC5jICB8ICA1ICsrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAz
NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2dibC5oIGIvZHJpdmVycy9z
Y3NpL3FsYTJ4eHgvcWxhX2dibC5oDQppbmRleCBkYWMyN2I1Li5iOWYxMDZh
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2dibC5o
DQorKysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfZ2JsLmgNCkBAIC00
MzMsNyArNDMzLDggQEAgZXh0ZXJuIGludA0KIHFsYTJ4MDBfZ2V0X3Jlc291
cmNlX2NudHMoc2NzaV9xbGFfaG9zdF90ICopOw0KIA0KIGV4dGVybiBpbnQN
Ci1xbGEyeDAwX2dldF9mY2FsX3Bvc2l0aW9uX21hcChzY3NpX3FsYV9ob3N0
X3QgKmhhLCBjaGFyICpwb3NfbWFwKTsNCitxbGEyeDAwX2dldF9mY2FsX3Bv
c2l0aW9uX21hcChzY3NpX3FsYV9ob3N0X3QgKmhhLCBjaGFyICpwb3NfbWFw
LA0KKwkJdTggKm51bV9lbnRyaWVzKTsNCiANCiBleHRlcm4gaW50DQogcWxh
MngwMF9nZXRfbGlua19zdGF0dXMoc2NzaV9xbGFfaG9zdF90ICosIHVpbnQx
Nl90LCBzdHJ1Y3QgbGlua19zdGF0aXN0aWNzICosDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2luaXQuYyBiL2RyaXZlcnMvc2Nz
aS9xbGEyeHh4L3FsYV9pbml0LmMNCmluZGV4IDNmMzQxN2EuLjNkZWZiZWEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW5pdC5j
DQorKysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW5pdC5jDQpAQCAt
NTQ4OCw2ICs1NDg4LDIyIEBAIHN0YXRpYyBpbnQgcWxhMngwMF9jb25maWd1
cmVfbjJuX2xvb3Aoc2NzaV9xbGFfaG9zdF90ICp2aGEpDQogCXJldHVybiBR
TEFfRlVOQ1RJT05fRkFJTEVEOw0KIH0NCiANCitzdGF0aWMgdm9pZA0KK3Fs
YV9yZWluaXRpYWxpemVfbGluayhzY3NpX3FsYV9ob3N0X3QgKnZoYSkNCit7
DQorCWludCBydmFsOw0KKw0KKwlhdG9taWNfc2V0KCZ2aGEtPmxvb3Bfc3Rh
dGUsIExPT1BfRE9XTik7DQorCWF0b21pY19zZXQoJnZoYS0+bG9vcF9kb3du
X3RpbWVyLCBMT09QX0RPV05fVElNRSk7DQorCXJ2YWwgPSBxbGEyeDAwX2Z1
bGxfbG9naW5fbGlwKHZoYSk7DQorCWlmIChydmFsID09IFFMQV9TVUNDRVNT
KSB7DQorCQlxbF9kYmcocWxfZGJnX2Rpc2MsIHZoYSwgMHhkMDUwLCAiTGlu
ayByZWluaXRpYWxpemVkXG4iKTsNCisJfSBlbHNlIHsNCisJCXFsX2RiZyhx
bF9kYmdfZGlzYywgdmhhLCAweGQwNTEsDQorCQkJIkxpbmsgcmVpbml0aWFs
aXphdGlvbiBmYWlsZWQgKCVkKVxuIiwgcnZhbCk7DQorCX0NCit9DQorDQog
LyoNCiAgKiBxbGEyeDAwX2NvbmZpZ3VyZV9sb2NhbF9sb29wDQogICoJVXBk
YXRlcyBGaWJyZSBDaGFubmVsIERldmljZSBEYXRhYmFzZSB3aXRoIGxvY2Fs
IGxvb3AgZGV2aWNlcy4NCkBAIC01NTM5LDYgKzU1NTUsMTkgQEAgcWxhMngw
MF9jb25maWd1cmVfbG9jYWxfbG9vcChzY3NpX3FsYV9ob3N0X3QgKnZoYSkN
CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZoYS0+d29ya19sb2NrLCBm
bGFncyk7DQogDQogCQlpZiAodmhhLT5zY2FuLnNjYW5fcmV0cnkgPCBNQVhf
U0NBTl9SRVRSSUVTKSB7DQorCQkJdTggbG9vcF9tYXBfZW50cmllcyA9IDA7
DQorCQkJaW50IHJjOw0KKw0KKwkJCXJjID0gcWxhMngwMF9nZXRfZmNhbF9w
b3NpdGlvbl9tYXAodmhhLCBOVUxMLA0KKwkJCQkJCSZsb29wX21hcF9lbnRy
aWVzKTsNCisJCQlpZiAocmMgPT0gUUxBX1NVQ0NFU1MgJiYgbG9vcF9tYXBf
ZW50cmllcyA+IDEpIHsNCisJCQkJLyoNCisJCQkJICogVGhlcmUgYXJlIGRl
dmljZXMgdGhhdCBhcmUgc3RpbGwgbm90IGxvZ2dlZA0KKwkJCQkgKiBpbi4g
UmVpbml0aWFsaXplIHRvIGdpdmUgdGhlbSBhIGNoYW5jZS4NCisJCQkJICov
DQorCQkJCXFsYV9yZWluaXRpYWxpemVfbGluayh2aGEpOw0KKwkJCQlyZXR1
cm4gUUxBX0ZVTkNUSU9OX0ZBSUxFRDsNCisJCQl9DQogCQkJc2V0X2JpdChM
T0NBTF9MT09QX1VQREFURSwgJnZoYS0+ZHBjX2ZsYWdzKTsNCiAJCQlzZXRf
Yml0KExPT1BfUkVTWU5DX05FRURFRCwgJnZoYS0+ZHBjX2ZsYWdzKTsNCiAJ
CX0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbWJ4
LmMgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbWJ4LmMNCmluZGV4IDg5
MmNhZjIuLjRhMzM4NzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvcWxh
Mnh4eC9xbGFfbWJ4LmMNCisrKyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9tYnguYw0KQEAgLTMwNjYsNyArMzA2Niw4IEBAIHFsYTJ4MDBfZ2V0X3Jl
c291cmNlX2NudHMoc2NzaV9xbGFfaG9zdF90ICp2aGEpDQogICoJS2VybmVs
IGNvbnRleHQuDQogICovDQogaW50DQotcWxhMngwMF9nZXRfZmNhbF9wb3Np
dGlvbl9tYXAoc2NzaV9xbGFfaG9zdF90ICp2aGEsIGNoYXIgKnBvc19tYXAp
DQorcWxhMngwMF9nZXRfZmNhbF9wb3NpdGlvbl9tYXAoc2NzaV9xbGFfaG9z
dF90ICp2aGEsIGNoYXIgKnBvc19tYXAsDQorCQl1OCAqbnVtX2VudHJpZXMp
DQogew0KIAlpbnQgcnZhbDsNCiAJbWJ4X2NtZF90IG1jOw0KQEAgLTMxMDYs
NiArMzEwNyw4IEBAIHFsYTJ4MDBfZ2V0X2ZjYWxfcG9zaXRpb25fbWFwKHNj
c2lfcWxhX2hvc3RfdCAqdmhhLCBjaGFyICpwb3NfbWFwKQ0KIA0KIAkJaWYg
KHBvc19tYXApDQogCQkJbWVtY3B5KHBvc19tYXAsIHBtYXAsIEZDQUxfTUFQ
X1NJWkUpOw0KKwkJaWYgKG51bV9lbnRyaWVzKQ0KKwkJCSpudW1fZW50cmll
cyA9IHBtYXBbMF07DQogCX0NCiAJZG1hX3Bvb2xfZnJlZShoYS0+c19kbWFf
cG9vbCwgcG1hcCwgcG1hcF9kbWEpOw0KIA0KLS0gDQoyLjkuNQ0KDQo=

--1879738122-1695936884-1655849122=:4730--
