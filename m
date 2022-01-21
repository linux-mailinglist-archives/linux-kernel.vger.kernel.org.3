Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF204959CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378634AbiAUGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:18:04 -0500
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:12089
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348500AbiAUGSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:18:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJKUEhik7564+pW2hMqVcHZCuA2vvtHh63UXKZ+qrzferQ6uco3fQ8rK+CPaBlfOQUu9WPOYuIMJffbqCrgjoGliwKs6lQgcwGVPMuM0cgAvfICWEk0uuGu+EHp+l8ee7TdVwW9wS4tCWFWP+c+DsdxzsNEJJgmaVvMUGprJYF416BkTf7aQQLC/3RUlZC0dhywvwGTBqd/Kf+L2fdB4Ok61ab5wRuZWkyL8Y+vUe7qgopOvpuQacAGNclwVtriFnPTs+5ZYnsQnFj08ZAPe4MkRIqIuLJVv1U1DPrC64TX94LuUS03705k4MqcjigQIVVcZU3yxC8b+s5175uxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKeBNmtO8pJHODVpCuHc6i54BgagGoaSpreXxpJw2Zk=;
 b=hZgUsTiCUROPoNuKRj7f1UpmEpUs2/Glmq2+JmqeyX6bn1mdAGYw2K7CHIDDt+1D9swhsozY/PQ6ROl5dLR52sH4E76JJ8QzDPluIHxntUmtp+q0mMp1xozfDc9I/bPDueC35tMkZYycykLlwbya3yhyMFSUjf8ZhnQ5tYZDRWwVf+kIU4L37F+g+WGZ1eW+yCiisJG9ZMm35Q+f3W9MpMSi9UfIIydYTRJ8DhTeh8SmQ+PrvtlchCsrFOdxu+MffbwMaxFYJ5U4lChSBeVyyK6pjUYPHzYOXFhWq5Goj3Uk4dUvTp8nAgSQXjgTJ5Yx1SwtUJmg6nyDGcA71gNFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKeBNmtO8pJHODVpCuHc6i54BgagGoaSpreXxpJw2Zk=;
 b=2bzHPkLpntmPbJaT5lgzxIjDax+6B+gaJ3LDwOgR1hVwltssvamdcc7eWjh2MB7NENfQSFD65tMU9Jwpj+dp83zN5psRuviN16eKgigA7lHaeESAfTYlJnB9ttFSTry0hxWQme5KsAfD9omg8wM8TklBDHVycvdX6RWj4HYuTIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BL0PR04MB6579.namprd04.prod.outlook.com (2603:10b6:208:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 06:18:00 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 06:18:00 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Linux 5.16
Date:   Fri, 21 Jan 2022 14:17:26 +0800
Message-Id: <20220121061728.2038851-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a0b6cf1-d4d6-47d3-aa8a-08d9dca5c62d
X-MS-TrafficTypeDiagnostic: BL0PR04MB6579:EE_
X-Microsoft-Antispam-PRVS: <BL0PR04MB6579AB34D6E15D801E59651EC75B9@BL0PR04MB6579.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +O3XdAyYIf6JI07pyJJR9ymBrvcTAsIK6LpTmlwbYdaLp8VovtwZLEIAa4k+Ktn6L8vJVJkO0UHWu/PLZT32dSZdH1u3MGeH0WUKVYgOzcF5vKrBeV3FsG+5kXj54gP91x0G8Mr+QPYQIQNTgwcIHW/qs8xTGs/OqU1LbcJeLUv5R+d7e6lb3FianosJ8D6Y0QzTn+d12GV3PalGJrdnZNXrwMZqj5lM5TeWSL8n5l2GWfk5aXVioqgAs0uKnwRKCnS5pT08SLGYB62vVOLAh9xv0mey14Git5VmzHVhYO7HBPg3hPdCwKy+76AeOpMlXbrHv0d7F4FDqoL2INKveqWnjh+x6mQfUI21ueh+0aYi3WBtJeALB9/U3FrzDvJKAAfYEb5Dp/vdQcB7mD7St5r7INfgJlS5t1aLNO2aBKbK7t7hunMPUqa+5B1S/vrvlzuYHPccs+hfHXjfBoOUJ4be+8OfZiLQRJbOUW2Blf2qgbc2NkwYaEGeIMgn0/wfyfwIQTafmN/hpsLOLMS2zv/c7/akvaHuxXMonQRcBrRiay3b+u+8Qlhjmv2Rt07RZcNeLMdn4kZbcJqRVcqhg63/gEW9ee/kxbt8SS9vCYzVkx2yiry8dCIa4WWJIkAxRNbIDpd3WKArZI7y/Jh0q6TdLi2yDlmQdBg8qbIXu/o8uMER6mqQgDl1Etu9dAJx1TFrx+Vimob+JGFOLWW2qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(38350700002)(38100700002)(66556008)(66476007)(36756003)(508600001)(86362001)(66946007)(52116002)(83380400001)(1076003)(55236004)(6506007)(6512007)(186003)(26005)(4744005)(110136005)(8936002)(316002)(6486002)(5660300002)(8676002)(2906002)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrpKxuLGPVJTJ6p0/k/6/J+hKPDRHo+69WkU6rXaQqmt2qH8VLz9qo0/uvWh?=
 =?us-ascii?Q?xizqz7YYqFZIBHuFI1QmCmWrYYOhw8XFRipfffpLiNHV+fCpyWUlw8XO+02k?=
 =?us-ascii?Q?xn7MvNzmNeIiyNuSCCEor7oo06U+877XQNSfZGbGJ2ZBZIr/FywOVjiUF65z?=
 =?us-ascii?Q?NjPZAn2txyKNo3jXwtukMKK4igG6BQbrCYU3Khu8MPGcayui7OdlZP8hxdV+?=
 =?us-ascii?Q?lPDsnHOvNTfAKlijb1W+bVcnfnoNer5xd6EY3x6kGTwGdye6Vs73Y9qnKn1v?=
 =?us-ascii?Q?nRYT9U6r96Y1FEQGvicfgg+ZpWNGuEuTjvgK5G4nPe+keJnFDCewANqfexEE?=
 =?us-ascii?Q?ohEXSKDv+z0t0r9LFt0N3MIONNQO/IC8d/843qz3EkoYfC2pPBnXNpNA35yO?=
 =?us-ascii?Q?N4aMmJMcjvgQ3EaxYrrCN/Lqwmo2dLvQzf0GGMAbCuBLpwwXx4b1zH3mduZ5?=
 =?us-ascii?Q?bRuPrGMsRBCIgXrkd7KVyMeBPZQeYY4OVTeNwxxDqrtWlDHyfoVYVE9LrOUp?=
 =?us-ascii?Q?FeNVrPbylWCRoG9tK0xXr6OJgWWlabxSe4VnwFHWRiSUK9dMiu1aKDFeRTuX?=
 =?us-ascii?Q?2S515Lu9AFABLmbzh4jH8Ab2Nm9TIPwJgFqLTmVnHmNnpjlRfIne+IPRMyg/?=
 =?us-ascii?Q?GERuKZaJAsV12XVdD9Mw5d6it0Sv6u92JqhRKNWIZne2d6E9LbrmJaB2QHlD?=
 =?us-ascii?Q?LBb4XDEKi/ffzQ7q/8rTrTDMvSMK+bHi8NvxCwKciGwdyLxPsZKPjtjd26ur?=
 =?us-ascii?Q?MwEQMBlvYp7L9hVfqDOfHiWqQjoIRqJT+QR+KYJB2K369yzn1diIRkQZy/Z4?=
 =?us-ascii?Q?AhiV3t/xhYk4SUs8skJ0d0UV7V154TXpyHP4lHGtr+KcQg3LXQ78Bw//kQ95?=
 =?us-ascii?Q?V7HW/lFGC7Il/7RZCAaupDmNnWafHIP1TLQS7LzDgNdJVo3mXgziPXz4A89f?=
 =?us-ascii?Q?0c1OZ7U7X1PUoIq63K2m9zki3q6h9fbaJXQ5mAjqZ+/lK+0Xk9bgZZ74wRDb?=
 =?us-ascii?Q?RzviFmRFhXK8Vn1eCedesPW6F5zzk8HBq2JEX2O3Ag2uHWMZtR9J8R9dKjGk?=
 =?us-ascii?Q?La/jOy1s5ySovwQ8chjYIpWrpTmVQpLqFt06CuEp/jEcQwvZDkl9wWef6vFz?=
 =?us-ascii?Q?kDQr+pm10GhGP1Ssd1Mjoez0mQF0w5LYzBvr9NrgJbOBBAYSdRlTPLaS0spZ?=
 =?us-ascii?Q?uCpwNsuyE6txeSHAWs4pGkMpaaK1wu87a+5kCa9RmO7yLvnmA/zmuGry+yva?=
 =?us-ascii?Q?wcxNeTV+ltmhd0A+IQLwxBThn0RF/o4yKVMqdOP3O+WmgsBZWFSWQjeKkxqD?=
 =?us-ascii?Q?+hrkpEWch3NmdXTk/4ZhhVysZv5ORaNHi/Ry6IoYAh0foB2hm1LZpTuzgNDO?=
 =?us-ascii?Q?8V6wLdAwAb+gXdM2Wwl+AKDASAeGmCWigOYmlnxUtjzHc59ScmUIwPeND6h5?=
 =?us-ascii?Q?Mw9qYng/GgeIZpOWjGtcO3w/3BWyou6Tepsnda5Wo62rpUtyC5fgOu728Sbg?=
 =?us-ascii?Q?f0GdiBDXXlTbtZcaIKdirM7oNlpJ//NnJNSCYjJxwLnP+qGxVuevpSU+zEcw?=
 =?us-ascii?Q?IT9ff5YgvZ2yzJ56lbMRMijbbzrRCy35cR8X+2pfet6eVWeAhRVSM+TvIxen?=
 =?us-ascii?Q?MISRpYriaDOyiTKF6EZglw4=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b6cf1-d4d6-47d3-aa8a-08d9dca5c62d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:18:00.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rQbKGCm5DdaUHj2mnHPCm5knHjCKFMdVorORPrddPWkYdKQ46zmiKOoZ4IDYwnFOnc7t27u+y1ZPQkrFjC5fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 16d7f83ac368..08510230b42f 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 5
 PATCHLEVEL = 16
 SUBLEVEL = 0
-EXTRAVERSION = -rc8
+EXTRAVERSION =
 NAME = Gobble Gobble
 
 # *DOCUMENTATION*
-- 
2.25.1

