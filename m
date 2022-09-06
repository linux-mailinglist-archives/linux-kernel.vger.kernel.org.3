Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04CC5ADE0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIFDb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiIFDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:31:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2080.outbound.protection.outlook.com [40.92.53.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEE6D9DB;
        Mon,  5 Sep 2022 20:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaqknvIdzxk/X06pHDDPiCezE7H0a9VIBQXkB8VFqnvB4AGnRVe8gXBCfJxUl1k4QVypIP8Td1BOxgczwS/QF/qVgwCr7C9UDbxSONCaZyCjDLvu6FLiA9DShE1r7GTrnt7+rAWsmTBvRIJWGwAjzRwbuGf21ihZXp1RlDv1x6GSLeNK7g07y7gP2AjCqCKzdJP2AX+fxwSx1mpERMRHrPwGJ7VDRccnKo760nC7nu7D6gWALEzizsfOOu7URVgKhTTAqUbjMd65VcH/eH9dVuRrhSnttNuu1PagjKBLgoBqRbWCeUgic0JEfl8X+t05d4vdfC/5fh4FltUaXi9QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xEhP5E1RobLwBox+atnsbsjUcJHAxeZounkYWCdUfw=;
 b=i++1EDv4aZEVmR0BT7mOD/ejHYhtiGTgrZPOAhcAZhrZYCsBwk/tNiL9d2S5sxO61D64qKukwLAql3h3xeYaIIVPp4Hd252kFefy0IiHcTZn0a2HYOPjnAIdOMG8hPWDlhmpjBjsqK6xx/hv8vysdNKrkgOI4wn4ma9Qr/oZc3BM12Fuykmfp17Kf8tUas7gp2WlW68b2H608Gcf7fLypuyqE8GWkGZSSDI+e/zSODNp9sCRH1+yzUV/thSHX1m9Vc2Vh6P1g2w6+9bNv+uHZu1FV32y/Ef3I+aKbwcr72oNgPTfSHMoWPeFrOzSEBQgO+A2PB/V2HKiqqKzn5r4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xEhP5E1RobLwBox+atnsbsjUcJHAxeZounkYWCdUfw=;
 b=oynA7Bm+gbTerrNe3nEgV/X3rls9k4qg8rkC7G420/gPliyCcaQYcjps+ietBpcdimRRyAEqajT/HPzw+cE2ygRLcA2+Szc0zxJTlIm2QkgATNukHSi/RtTJM6oSTwpTEzCKagDD9ZZc7/LbtU90D+OMbgoACKesnm/sGqpd+ByHLd16AndvvILEaOImbVu5Vrg7/GDbhaLhDlxaZlEKjOg27Nf5g3W2/PaYeVqhes82Kc2OBN/iEp8UwNN/+K3CWuZ9Tgl1+tcm9CxNqQkAw/0Jt+L51iIYj5koIRrC3Jmkwp4yabDLrrYgfgvSVb+A7Tk/MlSsOlmlLdx2MtizwA==
Received: from SG2PR03MB6777.apcprd03.prod.outlook.com (2603:1096:4:1de::11)
 by TY0PR03MB6427.apcprd03.prod.outlook.com (2603:1096:400:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Tue, 6 Sep
 2022 03:30:30 +0000
Received: from SG2PR03MB6777.apcprd03.prod.outlook.com
 ([fe80::b514:e0eb:738d:f1ed]) by SG2PR03MB6777.apcprd03.prod.outlook.com
 ([fe80::b514:e0eb:738d:f1ed%4]) with mapi id 15.20.5612.008; Tue, 6 Sep 2022
 03:30:30 +0000
From:   hellojacky0226 <hellojacky0226@hotmail.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rory Liu <hellojacky0226@hotmail.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rory Liu <rory.liu@quanta.corp-partner.google.com>,
        Scott Chao <scott_chao@wistron.corp-partner.google.com>,
        Zhuohao Lee <zhuohao@chromium.org>, linux-media@vger.kernel.org
Subject: [PATCH] media: platform: cros-ec: Add Kuldax to the match table
Date:   Tue,  6 Sep 2022 11:30:16 +0800
Message-ID: <SG2PR03MB677773B78B639FE3D4523291D17E9@SG2PR03MB6777.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [od3aIaAvu0XAchRonBrTIcV7FR+d1pkO]
X-ClientProxiedBy: TYAPR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::33) To SG2PR03MB6777.apcprd03.prod.outlook.com
 (2603:1096:4:1de::11)
X-Microsoft-Original-Message-ID: <20220906112933.1.Ide0c5e862aef9c030f8ad717ad1110a917a2fb07@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6777:EE_|TY0PR03MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: dfba5999-cdc5-4b9d-a317-08da8fb82438
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwUOfv/FaQKFvuquEa1rDmxFyXF/mZ+WLPS0peelVA4/obsAOZP29h1vigTxrtSJ0WpvT3DsZ0RfOvXBAYxrV94mgpWENlFHVQqoSWiaNrJUyrGcvhxp/7+pFkAzLpv9+wfe9gl8Nmr4c+0BZ7jyV4DAKR5GqS94fJBL6tP3XSgeYdjJclq5367WfoKrh7c29fgqIc8n8XT6vfvVHtLaZX93Q4bpkp/9KvWqz7vmOZJu4OZqr+6hNW+BPMqQ9MRbF4EehnJJM/hBff9bSsRbg3jXYIQxQLa6KybwTGYkXwC16Fn30FdEAfJ5RiCYWvZNuGmCpdHYBuKdK5Uz5OIO43PTQyBVHSYRoam4NuBsySfdIGXV0G878yos9I3zU/GDH0RQNnBOrI9uCJhJgvLuAgGhx7bchBs7E03pCwb1siWZ4+DRWh+iUVnszEmWO2qS2UhDWoUBw30ure/NKIGtC8XghR99wuEsWm0m84dr/bD68pGfZmk76WkdUzHHO5n32QNSRfpjsqAUTdqCb2SVoaje8wNy/PIWK7XOjC/VexTaRV3WLIBwMs8+D9fDjj7Ik1Vs7VutbNLtIGRXm+JNF1cLe3GoN90Us/f68absHT8fc/3g6H/m/wJZOjzCHAvW2OJNSt2fQeD6kIZGTKJlmdSFL2DsYV0oK71fuhcyTYOilvpHK3pQ5tuRIzbI3kDWUW76NugSf14PBv+/+PiNKBBJdcupHsX+PH8vv1hP0eTbhlUPOKqZnzyCuic84+8pUVc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZ5PkM2pN8ovYlrCTJ3PiJN1o0vy04TpFR6irPuDR6oKiB8EQHVQ47zZCQL68NbF3/T+pXlVCNZZcUKL07I4FIWtp+5RK3Qi09Xos64a7Phvanx7IMNu3za4eMFDpQcdeuj2RMizUZABZPDlIynEYZViqfgIc1pV5g397DxsCTylToNNrOEiLS2+ZmfuJtlFJJELLfQ9h6cEFlmvJixh5Dfz28rZ8JNlvtNfdEf3mt/7Mj/u4lBSW1G2rK7TT2ern7C3WJUCr54dkVzmCYr5JDR6K1AKxL6fRDJzGbYNYsOb1hDv4EDbU7GFcBbj17ZXSIe5sCcODOnKKjTBNRcmJASEJ/czPyJ27eZrl90yIlirVz+N/e2mzrfBncsqLFu5DhjfPTi8nvEJD0PJotvwbPCzeXEX9A7avYzPhX6CGLuT4q2nWYNUl2J0WrRwLnSP4CwumsQBszdnmcJLG4+zwqTMNZOfs2u2dlT+1d6iXZGek22Fn8tVJ6Pr3kvx7mWbVeay1A6PC5QaaQECMSBstjSTR59nrNOoodI4T/KwchMuacUOlpSc5XMYaX4lM2r/FeewX6AJP/Lyr7Pp2x26Yqspgjj+2r4Zrw/Fr87Ml8qcRz8jZ6wHDEDBbIN9QGik6tTA51/eIsc/prCEGAOipA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBDV28ul+71HGtYcBk7I6lx1j7Of8pxH2qNtXyWb7wLzFFdM8fgbtjpnc8wx?=
 =?us-ascii?Q?fHpaJlW9J4odfDqy4wb9GcYVE60pb0PVcBQowCywGgFHjfYUO9tmfoi2YZ93?=
 =?us-ascii?Q?iN9jqDcDDdCfgrLr9KAPT3q7zeucp8zLi1Ltk1hdsjW/gFN3dE/6WC8IOUk9?=
 =?us-ascii?Q?69+TYqX6NMI+vF6Wk5RtcoybfBcNtljSahGibF/uhXHRAGEOc8e035sFmdhT?=
 =?us-ascii?Q?2K5kyBmIyKRB1hP0XIXnV5pMpYS029sPfgicrYFgS9tdjqNFGkUovaHbJlbR?=
 =?us-ascii?Q?qwOUjx9YT4j2TqDNOJ75gcNwaINxhNjtlb3Rk0s0V/VThIIszPDKhyHDB1iO?=
 =?us-ascii?Q?Z4gGjbQTVrldZJkasI31SiBp5a5DSFwKZyVYzfSNFLH1HcLw+a+52v2IsrH/?=
 =?us-ascii?Q?Qdmhu88Q+KQmm6XoqgVlK3Z3Su8mvErq1BUkAt/9PHbzzIeWmu02E9Os2spS?=
 =?us-ascii?Q?of8Zabp8Y69VWirGSjCTbxOQDzqR2JCUh8IXMYqgOPJPEWQUMJNHZlOviRPj?=
 =?us-ascii?Q?NC/OzOUnJRw7Nl5XkfjLtHDa6gBLMYuykbhi/ytOorHi17alKJVTivBWPEGr?=
 =?us-ascii?Q?8uqJGoBVAuo0ifBbR/487Fe0JcqP5/xfZ+a2itfjiGt3JceSKGlqmyXDs4PJ?=
 =?us-ascii?Q?a/E3Kyt8AbqPr3uie8wcArsl934f60Qm0qbnh3YHGjK+IFW/TiNr9yALutQF?=
 =?us-ascii?Q?1g4UUbg1PsbDuwNGUT9HDUWrhOTK7veLqvVEP+YauNvyRiOjuza6/k+bMLq7?=
 =?us-ascii?Q?/47UxvPxheO13qiXPFBidt/DfnJOwDw5ghr4ea9z9Jlx6qPdDLfBWf8DaXpD?=
 =?us-ascii?Q?SwIqYdHjdCWvbYtjGVRf8hRpkimcqJ+Mw4jVjcWj5OuA9SUDUflnsq5kGTCT?=
 =?us-ascii?Q?BiW9yv6elj41jG+7FYrtIGb2Y+77ZrsrxUBYkSAKVj4bufmq5D8racCa//d/?=
 =?us-ascii?Q?8XXgzcM3VGAZpRocRff0/+C+p+JnrvOVDhhgaSa1rV8xOs3oX+Zrz6bfAiUN?=
 =?us-ascii?Q?KKFp6ZUc7PFy/vn2RXWr0Fc7jE1Az4mKSQBMYxNBD6be0kZ7LJuv4PmceV5k?=
 =?us-ascii?Q?hdC7YkbvYkI+d6ttdleRSPQt0N+E8R4CM/rDuXGMog4Apwa+XnXeaYA0IZCw?=
 =?us-ascii?Q?RvdD/Fy0S0yRCY29zswAmgA+VogzlivOBOpQr0mqS/evEboV9PPk2hi4eSFh?=
 =?us-ascii?Q?rkJvGrDKhL3YtemRoSEEhL9CjNvQY/7tNp0oVUqAD1AcLUCGkRV1ECTXvX1b?=
 =?us-ascii?Q?/ocToSEtieFKdDyM80HjJYkgh0v7bsZ6NqzbRbgGcw=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6427
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rory Liu <hellojacky0226@hotmail.com>

The Google Kuldax device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Rory Liu <hellojacky0226@hotmail.com>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 3b583ed4da9d..3998e56616ce 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -221,6 +221,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Moli", "0000:00:02.0", "Port B" },
 	/* Google Kinox */
 	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
+	/* Google Kuldax */
+	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

