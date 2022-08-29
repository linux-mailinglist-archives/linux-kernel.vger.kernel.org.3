Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53DE5A4E92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiH2Nv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH2NvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:51:23 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10087.outbound.protection.outlook.com [40.107.1.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412C6C746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgOhqgu5iscm4gt7Ykx5OCIawifBg6DXsWxYKOuZruW8KBkZXx5ElX0Kf2SKPgOd2y6XwJsl/oNI4oWALZFSH38m+agFpsBRGTI6vwBzUsFJNFnN52qmzjTRE0R3Z9GyeGTfQAsnA1zwyDNBbvOpcZYO9wJNgY7vqbrkpNxn/xHzvPY7HSpcCJWK/GrHYhfyaB8FL5VF2PtuuMXp4s8fZc5JgtAZW4vTEMQ5u2N9RIHhAzQeEK5iMjT/ah5S5lPcvPL1knknQ/Jn7Ahklwj79BGVeKkVTW1xpQ+I/IywZg0RtBOxioGb0T3HY1cGsFN1pTwTUQ2b98/0zMbItBaWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRoJ+EFAMDCBldUWKxdrcmfifQ+iiixFqGQFd9ZCTrs=;
 b=keroc2lLEE1HsoJlGM02vKd+ptmaXtRsgVHsXsahsA3zhH7AWORnkuZCWVIjzWt2UeAUAmb7bgrXnqMXXe1S1SXywAf5IIM2MninO0cFVTHyqKtrOZGJ7fBpdyP/zCS5BCtW1lqvpZwagdb++H+qNkrX6simbh5xDt0uROtSh3EaapfoNTQayy2bqm6zop/xH5TT68CrOqZmBRYFtI4jRl5PwPDPl4BVr7j83GbabkcozHNXpSenfEPSf4uV5Q61j88uy+ch2I+8sJXwSkHmOblII2KrHWBFw0vMXAgBGDAySTEkqKWaq5uSQd837A9hQZCr/PDf92yANfj5ykIEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRoJ+EFAMDCBldUWKxdrcmfifQ+iiixFqGQFd9ZCTrs=;
 b=EczAL7bgFYiR6cZ9PVvvDe35Kbjs+Nuw1cYBVWeq1pND6jVNARtAeELr9R27BfPfb3c9znYs29qqhn67VGhr7KQeYbI2ggGfc03f+dqwUWfxaijE+ni+2WmnVl+UgSEgfOBfrCrWYxUJKfRS6nu4nq7rToqNZ20l/HFfPhWpNO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by DB9PR09MB6012.eurprd09.prod.outlook.com (2603:10a6:10:3db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 13:51:18 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::e1da:7a91:5add:b775]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::e1da:7a91:5add:b775%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 13:51:18 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@kococonnector.com, oliver.graute@gmail.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] linux: imx: imx-scu: increased scu message timeout
Date:   Mon, 29 Aug 2022 15:58:04 +0200
Message-Id: <20220829135804.12632-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b7643e-e664-4fb9-0b52-08da89c58c8e
X-MS-TrafficTypeDiagnostic: DB9PR09MB6012:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sS7nzgICvrrgTAJkWgM4YziPckoszWWPtXSzIX2S9beUL6QQfj3N5r4maqZBWD38rfiT2nMDH0vguOi6swe8WmP4PTZLzzIfbeXb2y6Za41rmrx58Y8V6fjDa7omkfo3k3eql7Wxwh3XJd6Wa25GDN1wpZoLRAs6+ZlkG1IgI9y8dvDvQuovTBHqQsT8eV/68tvls08p3DLQliBsDRL8lus+BaXmhPZSDA3cn5B0t5zMBbtUD4lFulA1Q0m956oSASSuZirO5H8dKs5V67TSBuNA7N8Nbj5/eODnak8SNu0xkX583PEkbOOvfivUgGM3Czk4A+7zfRcNBa15S2/RBBLQLuM2PNaZvrQqkIgihNZUhzyri9eO8YEAh10mULlyge0NCrAK++TyPd8hYejX6psKrYVJsqtSceL78eBCDyGGvYIMbingULcB9DwsC0TM4mP8uud6hkdTZi/E4X+WYkiXp3CBiweYuhzBiinkDNNWQOgWDbNECBjPRryFzGWPH60ulTELU1f3CTja4qhyBO7WVUvyVmOghj7bS63rJYpR+30921UYvjONTAfdSRTzZk4xe88F+2UCP8b7uFeF+pqDkhikSPHn1cWtfCTsVKlybVA1S7pvAVRDs65UWu2UeNiXfG5mc6tjEKTm1PK9bVg6+HbxD6mM950VqtVQg3mt4E/skHTsSdTNf7ATB2Zcmqbm/ImB8bio3kC+YToF8ofymneS7VFEgEnieeZ+d7zwmjOC4LooZXTDyyNEBVCd8ox3vi4WA28q5L91+TlasgEC9Kbpys5QtCVVwLn8eGioiD8qlpyiJqypKxMl8HiN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39830400003)(366004)(136003)(346002)(6512007)(86362001)(26005)(52116002)(478600001)(6486002)(6666004)(6506007)(41300700001)(186003)(38100700002)(83380400001)(38350700002)(66476007)(1076003)(2616005)(54906003)(7416002)(15650500001)(66946007)(5660300002)(66556008)(8676002)(8936002)(4326008)(316002)(2906002)(36756003)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bNqGtOedD11XMz2M1xlKjjBJah/sAdO9azTJ9Es2k/P/nddv0uWRAb9JRJ2?=
 =?us-ascii?Q?PTLogeSmpqPnLo+jT2EQ6Hj6KmIEjTxIe6PDOkuC+OVPRYl6TcdAXNxwnQVA?=
 =?us-ascii?Q?mmC3FPq4cvX2v3A3bSJWc3CQ8vxa7mO0l9+GmVmc7FqH43zJm0OkWeowlowI?=
 =?us-ascii?Q?wDlIjKC5sT2NZVNOkoudwXRAU0tJ20P6EjCuadsN/hfE2pHwIFr8gcl+CeQj?=
 =?us-ascii?Q?4H/fg4OEa2dR32UP9itL8zqekmJEwa8F9/zc+Q+w6yEEk/9yc/rqsP5nm8AS?=
 =?us-ascii?Q?aiFGhAeJ+GPMVOmLrjy36x9LVZSCr0iJ80P4InU2XLZ2KlyPE4jzhq0oRHxz?=
 =?us-ascii?Q?gbcONfb5xA5kBItS9OZrG328D1Lz+PHXsRM9g7ldI8KPqujfwQadkiYe0eim?=
 =?us-ascii?Q?RBZ76KmsEYwu1iLYIM2VmMysCwiHtqllDByZ6LyKLiGfGcJI0IxfwSCBKvaI?=
 =?us-ascii?Q?WUPMwgSoNKUy2XlGqbhBHe2z48Xeg1a7cfhFrzittdFYIWFq8S7dlTD9DErY?=
 =?us-ascii?Q?LCz8xIBD6oX8P0qx95Og7fLN820nZ5MMrNLlZIlFGFNYLBxRA2M3jYH0Efrj?=
 =?us-ascii?Q?MEI/nAcQdT+L1MPs8VlggyI/247KyxpwrBeFol0SyfCOELVgiMKRcDPGVP1p?=
 =?us-ascii?Q?KQF2p3JODF36NiEGRGwXLeXJcO3wNq9CbdvGx6HQrFOhWW+3vf5Kn9/hiQ6H?=
 =?us-ascii?Q?xhFAZmighHlBIMZpJBVMU0Su0/eTJKAwZ76xFGrLyPm54ruK2L4xOncqKLQq?=
 =?us-ascii?Q?3P4AmcvGozC6UETGJdQIrYl3mYdW4Oq7lFznts8a4EtxjclnQRxVcY5N0eQL?=
 =?us-ascii?Q?0cbboPY3bpeTB+fpRoXjS3zJzoQqZYMX8mB4ml7FwciX5byXf/0X8YmwiuEi?=
 =?us-ascii?Q?B0viA/p0qPatFfIJ750PYN+ylP/gqSwBDBvmdbS5xeez94ez7e1A5JX3WD+o?=
 =?us-ascii?Q?qw6c8uscXmbCUESVmfecsiOyToE4jC9iCEnQshVdUwgot4Qyv2RDdEIQ3B3d?=
 =?us-ascii?Q?vxsiG4K6HHZnC/gB6lIgiYXWlGU0oSk5kuWDVyq43BF0gLIIwwZ14E4Kc4O7?=
 =?us-ascii?Q?70R/lhktvnjAVGwc2X7AUXHDj3iZPouy4lehWEx0EzhVOa5m+2lKJZ8QuBS9?=
 =?us-ascii?Q?VUWp3/j/xeTtY0dkoc7uRfBRqKu/BtE0nOILyNuWVsLzuUzrDemCFD1C0VFQ?=
 =?us-ascii?Q?fhv0XTYV8KGaofIFz1+ETY/X0R1HnAiqwQCbzu4nLH1p4Yb/UGHNsvFVnd83?=
 =?us-ascii?Q?fGG+EqgoEdXB4P9uJWE/F3WvhJq0oVTfEHq8N3sPtgqCGAtDyJjuNFoeSWBw?=
 =?us-ascii?Q?YAxxW5b9nQrIyYHBOjkgeCX/8gOWnSsUR/MraZ8t2lCMiZTb+WG+MNZ/MsNV?=
 =?us-ascii?Q?INBrUwiFcZXLnBlQZqMS1JukqDCofmsiTFlx5ml/32pAtgCm9tj1RHYP8g+e?=
 =?us-ascii?Q?+HCCa/zrwIfy7qveqynUtcipY5YswcsOR2aRAbWm/T4q7xSoPjwsOEx0/CTs?=
 =?us-ascii?Q?0k3ijDT+EiKzDMrb02Rg6TgHeyALJ3r6IksGdHNA8mNgA8IbmiP+lXDNn8Et?=
 =?us-ascii?Q?WPnrfIEmen2rIq0fflqjdo7VKHgn5n6+uniCFHcdJ5JryJWDpi8VK7x+AtIq?=
 =?us-ascii?Q?BDQg8WZ5BmAL+snAZMNv2P4=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b7643e-e664-4fb9-0b52-08da89c58c8e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:51:18.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxBieBvREMYUdtCE9XIkaA4tV/4KO3ZXRzpHabSxBrgHSed/ts0FA3mtfjcJVIkmYYtxW/NcxlDJPnP+dgrUTo/tvSdUxxDJwrvoVst9QyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6012
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MAX_RX_TIMEOUT = 30 ms we observed some wired behavior of
communication to scfw. After increasing the scu message timeout to
arbitrarily MAX_RX_TIMEOUT = 1s these problemes are gone.

a35_clk: failed to get clock rate -22
gpt0_clk: failed to attached the power domain -2
imx-scu scu: RPC send msg timeout
gpt2: failed to power up resource 209 ret -110
imx-scu-clk: probe of gpt2_clk failed with error -110
imx-scu scu: RPC send msg timeout
lpspi0: failed to power off resource 53 ret -110
imx-scu scu: RPC send msg timeout
enet1: failed to power up resource 252 ret -110
imx-scu-clk: probe of enet1_clk failed with error -110
mipi_csi0_core_clk: failed to attached the power domain -2
mipi_csi0_esc_clk: failed to attached the power domain -2
mipi_csi0_i2c0_clk: failed to attached the power domain -2
mipi_csi0_pwm0_clk: failed to attached the power domain -2
lvds0_i2c0_clk: failed to attached the power domain -2
lvds0_i2c1_clk: failed to attached the power domain -2
lvds0_i2c1_clk: failed to get clock rate -22
lvds1_i2c1_clk: failed to attached the power domain -2
lvds1_i2c1_clk: failed to get clock rate -22

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 drivers/firmware/imx/imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79caccd01..cef2bcea61e7 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 
 #define SCU_MU_CHAN_NUM		8
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(1000))
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
-- 
2.26.0

