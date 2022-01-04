Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40E483E32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiADIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:34:30 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31136 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiADIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:34:22 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JSm7548mdz8wDN;
        Tue,  4 Jan 2022 16:31:45 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:34:19 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 16:34:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v2 1/4] Documentation: use the tabs on all acc documentation
Date:   Tue, 4 Jan 2022 16:29:16 +0800
Message-ID: <20220104082919.45742-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220104082919.45742-1-yekai13@huawei.com>
References: <20220104082919.45742-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tabs on all Hisilicon Accelerator documentation. including
hpre, sec, zip.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre | 168 ++++++++++----------
 Documentation/ABI/testing/debugfs-hisi-sec  | 136 ++++++++--------
 Documentation/ABI/testing/debugfs-hisi-zip  | 136 ++++++++--------
 3 files changed, 220 insertions(+), 220 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index b4be5f1db4b7..68d4dcb1538d 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -1,140 +1,140 @@
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/cluster[0-3]/regs
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump debug registers from the HPRE cluster.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/cluster[0-3]/regs
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump debug registers from the HPRE cluster.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/cluster[0-3]/cluster_ctrl
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Write the HPRE core selection in the cluster into this file,
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/cluster[0-3]/cluster_ctrl
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Write the HPRE core selection in the cluster into this file,
 		and then we can read the debug information of the core.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/rdclr_en
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    HPRE cores debug registers read clear control. 1 means enable
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/rdclr_en
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	HPRE cores debug registers read clear control. 1 means enable
 		register read clear, otherwise 0. Writing to this file has no
 		functional effect, only enable or disable counters clear after
 		reading of these registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/current_qm
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    One HPRE controller has one PF and multiple VFs, each function
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/current_qm
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	One HPRE controller has one PF and multiple VFs, each function
 		has a QM. Select the QM which below qm refers to.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/regs
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump debug registers from the HPRE.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/regs
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump debug registers from the HPRE.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/regs
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump debug registers from the QM.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/regs
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump debug registers from the QM.
 		Available for PF and VF in host. VF in guest currently only
 		has one debug register.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/current_q
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    One QM may contain multiple queues. Select specific queue to
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/current_q
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	One QM may contain multiple queues. Select specific queue to
 		show its debug registers in above regs.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/clear_enable
-Date:           Sep 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    QM debug registers(regs) read clear control. 1 means enable
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/clear_enable
+Date:		Sep 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	QM debug registers(regs) read clear control. 1 means enable
 		register read clear, otherwise 0.
 		Writing to this file has no functional effect, only enable or
 		disable counters clear after reading of these registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/err_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of invalid interrupts for
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/err_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of invalid interrupts for
 		QM task completion.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/aeq_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of QM async event queue interrupts.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/aeq_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of QM async event queue interrupts.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/abnormal_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of interrupts for QM abnormal event.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/abnormal_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of interrupts for QM abnormal event.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/create_qp_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of queue allocation errors.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/create_qp_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of queue allocation errors.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/mb_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of failed QM mailbox commands.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/mb_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of failed QM mailbox commands.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/qm/status
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the status of the QM.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/status
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the status of the QM.
 		Four states: initiated, started, stopped and closed.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of sent requests.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of sent requests.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/recv_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of received requests.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/recv_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of received requests.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_busy_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of requests sent
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_busy_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of requests sent
 		with returning busy.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_fail_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of completed but error requests.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_fail_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of completed but error requests.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/invalid_req_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of invalid requests being received.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/invalid_req_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of invalid requests being received.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/overtime_thrhld
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Set the threshold time for counting the request which is
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/overtime_thrhld
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Set the threshold time for counting the request which is
 		processed longer than the threshold.
 		0: disable(default), 1: 1 microsecond.
 		Available for both PF and VF, and take no other effect on HPRE.
 
-What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/over_thrhld_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of time out requests.
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/over_thrhld_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of time out requests.
 		Available for both PF and VF, and take no other effect on HPRE.
diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
index 85feb4408e0f..58cfa354534c 100644
--- a/Documentation/ABI/testing/debugfs-hisi-sec
+++ b/Documentation/ABI/testing/debugfs-hisi-sec
@@ -1,113 +1,113 @@
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/clear_enable
-Date:           Oct 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Enabling/disabling of clear action after reading
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/clear_enable
+Date:		Oct 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Enabling/disabling of clear action after reading
 		the SEC debug registers.
 		0: disable, 1: enable.
 		Only available for PF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/current_qm
-Date:           Oct 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    One SEC controller has one PF and multiple VFs, each function
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/current_qm
+Date:		Oct 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	One SEC controller has one PF and multiple VFs, each function
 		has a QM. This file can be used to select the QM which below
 		qm refers to.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/qm_regs
-Date:           Oct 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump of QM related debug registers.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/qm_regs
+Date:		Oct 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump of QM related debug registers.
 		Available for PF and VF in host. VF in guest currently only
 		has one debug register.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/current_q
-Date:           Oct 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    One QM of SEC may contain multiple queues. Select specific
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/current_q
+Date:		Oct 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	One QM of SEC may contain multiple queues. Select specific
 		queue to show its debug registers in above 'regs'.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/clear_enable
-Date:           Oct 2019
-Contact:        linux-crypto@vger.kernel.org
-Description:    Enabling/disabling of clear action after reading
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/clear_enable
+Date:		Oct 2019
+Contact:	linux-crypto@vger.kernel.org
+Description:	Enabling/disabling of clear action after reading
 		the SEC's QM debug registers.
 		0: disable, 1: enable.
 		Only available for PF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/err_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of invalid interrupts for
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/err_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of invalid interrupts for
 		QM task completion.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/aeq_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of QM async event queue interrupts.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/aeq_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of QM async event queue interrupts.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/abnormal_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of interrupts for QM abnormal event.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/abnormal_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of interrupts for QM abnormal event.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/create_qp_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of queue allocation errors.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/create_qp_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of queue allocation errors.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/mb_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of failed QM mailbox commands.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/mb_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of failed QM mailbox commands.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/qm/status
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the status of the QM.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/status
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the status of the QM.
 		Four states: initiated, started, stopped and closed.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/send_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of sent requests.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/send_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of sent requests.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/recv_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of received requests.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/recv_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of received requests.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/send_busy_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of requests sent with returning busy.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/send_busy_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of requests sent with returning busy.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/err_bd_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of BD type error requests
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/err_bd_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of BD type error requests
 		to be received.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/invalid_req_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of invalid requests being received.
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/invalid_req_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of invalid requests being received.
 		Available for both PF and VF, and take no other effect on SEC.
 
-What:           /sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/done_flag_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of completed but marked error requests
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/done_flag_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of completed but marked error requests
 		to be received.
 		Available for both PF and VF, and take no other effect on SEC.
diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
index 3034a2bf99ca..765e29203ef3 100644
--- a/Documentation/ABI/testing/debugfs-hisi-zip
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -1,114 +1,114 @@
-What:           /sys/kernel/debug/hisi_zip/<bdf>/comp_core[01]/regs
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump of compression cores related debug registers.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/comp_core[01]/regs
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump of compression cores related debug registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/decomp_core[0-5]/regs
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump of decompression cores related debug registers.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/decomp_core[0-5]/regs
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump of decompression cores related debug registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/clear_enable
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    Compression/decompression core debug registers read clear
+What:		/sys/kernel/debug/hisi_zip/<bdf>/clear_enable
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	Compression/decompression core debug registers read clear
 		control. 1 means enable register read clear, otherwise 0.
 		Writing to this file has no functional effect, only enable or
 		disable counters clear after reading of these registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/current_qm
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    One ZIP controller has one PF and multiple VFs, each function
+What:		/sys/kernel/debug/hisi_zip/<bdf>/current_qm
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	One ZIP controller has one PF and multiple VFs, each function
 		has a QM. Select the QM which below qm refers to.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/regs
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump of QM related debug registers.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/regs
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump of QM related debug registers.
 		Available for PF and VF in host. VF in guest currently only
 		has one debug register.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/current_q
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    One QM may contain multiple queues. Select specific queue to
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/current_q
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	One QM may contain multiple queues. Select specific queue to
 		show its debug registers in above regs.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/clear_enable
-Date:           Nov 2018
-Contact:        linux-crypto@vger.kernel.org
-Description:    QM debug registers(regs) read clear control. 1 means enable
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/clear_enable
+Date:		Nov 2018
+Contact:	linux-crypto@vger.kernel.org
+Description:	QM debug registers(regs) read clear control. 1 means enable
 		register read clear, otherwise 0.
 		Writing to this file has no functional effect, only enable or
 		disable counters clear after reading of these registers.
 		Only available for PF.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/err_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of invalid interrupts for
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/err_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of invalid interrupts for
 		QM task completion.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/aeq_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of QM async event queue interrupts.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/aeq_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of QM async event queue interrupts.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/abnormal_irq
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of interrupts for QM abnormal event.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/abnormal_irq
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of interrupts for QM abnormal event.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/create_qp_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of queue allocation errors.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/create_qp_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of queue allocation errors.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/mb_err
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the number of failed QM mailbox commands.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/mb_err
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the number of failed QM mailbox commands.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/status
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the status of the QM.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/status
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the status of the QM.
 		Four states: initiated, started, stopped and closed.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of sent requests.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of sent requests.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/recv_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of received requests.
+What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/recv_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of received requests.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_busy_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of requests received
+What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_busy_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of requests received
 		with returning busy.
 		Available for both PF and VF, and take no other effect on ZIP.
 
-What:           /sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/err_bd_cnt
-Date:           Apr 2020
-Contact:        linux-crypto@vger.kernel.org
-Description:    Dump the total number of BD type error requests
+What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/err_bd_cnt
+Date:		Apr 2020
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the total number of BD type error requests
 		to be received.
 		Available for both PF and VF, and take no other effect on ZIP.
-- 
2.33.0

