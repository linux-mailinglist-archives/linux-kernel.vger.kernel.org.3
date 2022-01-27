Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899049E249
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiA0MXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:23:10 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:51248 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiA0MXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:23:07 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 20RCMYHE013237; Thu, 27 Jan 2022 21:22:34 +0900
X-Iguazu-Qid: 2wGrVsu7KfUduQM9LP
X-Iguazu-QSIG: v=2; s=0; t=1643286153; q=2wGrVsu7KfUduQM9LP; m=fopQoZOB4RR+7GxNd2KPhSIopbwQ/GZx7RuWAarFPzU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 20RCMVwj014423
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jan 2022 21:22:32 +0900
X-SA-MID: 32405228
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 0/1] net: stmmac: dwmac-visconti: Avoid updating hardware register for unexpected speed requst
Date:   Thu, 27 Jan 2022 21:17:13 +0900
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220127121714.22915-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function visconti_eth_fix_mac_speed() should not change a register when an unexpected speed value is passed.

Yuji Ishikawa (1):
  net: stmmac: dwmac-visconti: No change to ETHER_CLOCK_SEL for
    unexpected speed request.

 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1


