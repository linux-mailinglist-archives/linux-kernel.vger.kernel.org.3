Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3E536967
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiE1A1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbiE1A1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:27:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75723101FE;
        Fri, 27 May 2022 17:27:42 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RJPT3O013619;
        Fri, 27 May 2022 17:27:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type : content-id; s=pfpt0220;
 bh=Vb1GuDgqYbAUPSENMyVLcjQ2bVoYMKH0ZvazQCEsd5I=;
 b=lHiA0zpE4yK3ng0SPXGyNqiu77Yjxyz7p9ke4GAwbMyJVYTqG1xZXRr49v+xQLcAWtZ8
 yZ9cWzGepwBWiqv5FF//R0aY2h8G/NgGejvl3JiU50a08B5ER41ghRxR/TJthg0oTFc/
 EExG/NjMiqu2xB7mzZSLERy2+5ckN4ULhfq5WnfsSf3OAqlV4sq7mstKQNdNBwmz12Td
 S9RGGNBeHrwCMvoat7BrEnlpBD6x2Y6xdYYGtkOXFY14S03dVXccPFiqvsr3eKIl6VVm
 p7+08mIf/nWcWyJKaZ5B5tXpVwGxv5Tg+WrsxmbNYT/7d5z9c8Y9qqOnuxxT/ywjUPaq Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gaf2rwhrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 17:27:31 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 27 May
 2022 17:27:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 27 May 2022 17:27:29 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 9B3655B6936;
        Fri, 27 May 2022 17:27:29 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 24S0RRxv008651;
        Fri, 27 May 2022 17:27:29 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Fri, 27 May 2022 17:27:27 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     Tony Battersby <tonyb@cybernetics.com>
CC:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] qla2xxx: tape drive not removed after unplug FC
 cable
In-Reply-To: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
Message-ID: <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-1443816806-1653693424=:4730"
Content-ID: <alpine.LRH.2.21.9999.2205271720570.4730@mvluser05.qlc.com>
X-Proofpoint-ORIG-GUID: NKPAGJdVIFsyfuMHkYbCs7mr2U1irP6P
X-Proofpoint-GUID: NKPAGJdVIFsyfuMHkYbCs7mr2U1irP6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_07,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-1443816806-1653693424=:4730
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.9999.2205271720571.4730@mvluser05.qlc.com>

Hi Tony,

Thanks for reporting the issue. We are trying to recreate this issue in 
house. I will reach out to you for logs, if we cannot repro. Typically, we 
get sufficient context to the issue when the problem is reproduced with 
module parameter "ql2xextended_error_logging=1".

Anyway, I will let you know the status.

Regards,
-Arun

On Wed, 25 May 2022, 3:03pm, Tony Battersby wrote:

> #regzbot introduced: 44c57f205876
> 
> I have several different QLogic FC HBAs (8, 16, 32 Gbps) and several
> different FC LTO tape drives (IBM Ultrium 8 & 9).  When I plug in the FC
> cable, the tape drive shows up as a SCSI device as expected.  With older
> kernels, when I unplug the FC cable, the tape drive SCSI device would
> disappear after about 30 seconds.  But with newer kernels (including
> 5.18), when I unplug the FC cable, the tape drive SCSI device never
> disappears.  I have bisected the change in behavior to the following
> commit in kernel 5.15:
> 
> 44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
> 
> This commit has been backported to various -stable kernels, so they are
> also affected.
> 
> When testing with two different tape drives:
> 1) Plug FC cable into tape drive A.  Tape drive A shows up as a SCSI device.
> 2) Unplug FC cable; wait 60 seconds.  Tape drive A does not disappear.
> 3) Plug FC cable into tape drive B.  Tape drive A disappears 30 seconds
> later, but tape drive B does not show up.
> 4) Unplug FC cable and plug it back into tape drive B.  Tape drive B
> shows up as a SCSI device.
> 
> So I can actually make a tape drive disappear by plugging the cable into
> a different tape drive, but then I have to reseat the cable again to
> make the new tape drive show up.
> 
> lspci -n
> 83:00.0 0c04: 1077:2031 (rev 02)
> 83:00.1 0c04: 1077:2031 (rev 02)
> 
> When plugging in cable:
> qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
> 
> When unplugging cable with old kernel:
> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
> rport-7:0-2: blocked FC remote port time out: removing target and saving binding
> 
> When unplugging cable with new kernel:
> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
> 
> /sys/class/fc_remote_ports/rport-*/
> dev_loss_tmo: 30
> supported_classes: Class 3
> port_state: Online
> (port_state remains Online even when FC cable unplugged)
> 
> /proc/scsi/scsi
> Host: scsi7 Channel: 00 Id: 01 Lun: 00
>   Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
>   Type:   Sequential-Access                ANSI  SCSI revision: 06
> 
> Tony Battersby
> Cybernetics
> 
> 
--1879738122-1443816806-1653693424=:4730--
