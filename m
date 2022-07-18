Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D263578377
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiGRNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiGRNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:17:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD627B0E;
        Mon, 18 Jul 2022 06:17:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4SFZ018834;
        Mon, 18 Jul 2022 13:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=QbduH7IvcIhtWH+EsZ3o1SeNINjm2WdWbVycNnnI+Pg=;
 b=itJmrIOSgMqPPA17iKcokEVBpocstF9ByxnxVMGX6PhZBimxiVOLVZYU/lCrdbpVw9lK
 MiD9RO46QjCsrQCAm7t+ojUEiRpFsyBgC2fjCqIDQLXVHqyIygxUUxIq9atJxhTqnKLr
 QKOLAFGZnOwSbdwKpvmDJUSGPT5GRS23qkCnpMfvZ8l1vP5IPvaZf8M22V/YB1/A/GzC
 EFXUbEa8+jTLznLxP8I32qLORDQUPL+4XDeHGVqP/vNIpd+kZKJ8M+QdPv7NueiLC64L
 tb2qKiHZi/x8ksA9icytK2hGnRsmDrN7Fda8difsT5Fepr23Nk+a0fnnMP1UUaDOvcCI bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a379y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:17:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICInP5006501;
        Mon, 18 Jul 2022 13:17:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gfjjex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwAhnVPnASYCEzYYza7rY2df0xfN8WFKTQdZOEinQaRVNMHYe8ne3cVUSkkvEVP3vVMlMGtfLCwz+fwHPWj846ZFiWOsvQ0ABJSvy7tStvbKWcj8xy4gDJjUcubfP/aY0Vhb+ipg+AyXZjVVEbyiB/0pyFFZIjA/L0p+8Z2I+IAVjPaUxGc5I7wY/oyyWU/6y1kyXUS7jpNUqrzLNuF3vUW+MjZAcYHlQKz5GPYKyyu6ATs4wzZSNAttKQCXSqI7DjHpDzOG5iqqjoxVKavbe1Hqp51yK2e4lmXA5kUlE8WRuBmFbhBQP4CqmrQelVsn9DHfqqzFnEcZ1TtHnew4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbduH7IvcIhtWH+EsZ3o1SeNINjm2WdWbVycNnnI+Pg=;
 b=OODuv8oyjqEQ0HEszNwKYmwwnSjgp89QidGhOsX9J55qHoKvhN2V83HLxpuQnfOhs3QYSAhOA1ulNuzXX1rbdeHGBqpa/7wvR+mtyeNVaTJVbZpPrpJXT2jP48FlY+dTUCJN39udwR8Dg7zr9p5iLeQV+hU7fXWlyjc9fzelyiqw16NRM8J8a/4F2DA9vJ7Ug3yWP+NT2i8jR2jQYLgsDJMdbYwWVGjIxLmiCZLi1J0CYwqsacSi1UB2M7xc+2+ZsGO2mdUm/QUxmmnESZHgctvjIFHr26qpQIRLvN+OXlu1cbGvvT2hbbMk6mOlk2JLOdy1GeRSpwhMcPp7GkX8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbduH7IvcIhtWH+EsZ3o1SeNINjm2WdWbVycNnnI+Pg=;
 b=teSWf3FHFelJcBcsWN75azflF+uffFAtmFt2omubZEmDLpL+h4DHmBOdKKnIOHuX82zHWVctaXivy4Pq5yPv0scPup1dBZ+sEwsWXkd+TQ8XRL3iWq6i6D5e7c6BFUX4ceyk7q90J2Mh0IBgOaR0YikS2dCdEg9Z+5S8mbuWAEY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2201.namprd10.prod.outlook.com
 (2603:10b6:4:31::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 13:17:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:17:28 +0000
Date:   Mon, 18 Jul 2022 16:17:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tools/power/x86/intel-speed-select: Fix off by one check
Message-ID: <YtVdXen0K8KH0kwu@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0111.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6958f62e-843a-47b7-e18b-08da68bfdccd
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tnv9PjhfCuFnJlA4RKUw2EQ0JTLn6Xo2r3seBuzZ1OEGkJLNSDhdUzam6QqLOOhtzrbQWZ9O6v4G4kxDh7pFAbshnfNOdbXfYLYCinsqT5vzmAa81Ft+B9/FH1PYwrtoW13bZ80wGKjSMs92ibeL4kkVIyoRWoJjdBhbZvZqLqtNK07D3YNVA6Nu73jQzwWETECTKcCBT83/uE4QllJN+YgnNNiG0lTqiI55J79k3SyjFFl0b1wCVbdprqhH3e3gR2PBBGM+EHqlfwjv5/fJExkaDsiYFf52IXqWS3xVIYI6y0T6WiLV6cxfU3kMNbQspG9ozLiy485nhruu584UkbA2nlOqPjjZ04yOVHi04VNBIT5cVcxBpLjjZnLUnV1x7mg9yqItwZR6zNlRKLsmf05bpPVRq70EzUQWbtVZk8WNEW28g2VSRWE9wlWYqO5yyikxAIrdNsNKjdMD5Sc4SFD+umI4CpAVLIqmZ3LV8N8qjXm3ZbYOxZO+KGMee5QXr79UOwUbv6UaEMRP9uOZYheVTG7BFhKk86VlGipC+/ysU53jpnlSLxXOxtkQpsYWUqY2xtC4hqrukNjW7dTy9EtyMuJfwS+oxQeRuAS3nee6E8vRFG8sPMXVh6FPfDFfTPu8ilh2+2Ny0A4IyKgsHlun9fPrUj7mGaDU9sprSl+myrT91AHa76Xh7TMic40ZcDN9YFEhBswktknJY+uksQ/ynNA/3pVm4x1xFENjspDqDxuDD3sooxsNeed/MQ01T5m+d66BEswr9o26/mT45nG2aN9GeMpihXT8jKmCTdrv2XZl1bx9mwuQpjseJLyG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(83380400001)(9686003)(26005)(6512007)(6506007)(38100700002)(38350700002)(5660300002)(44832011)(186003)(4744005)(8936002)(33716001)(2906002)(52116002)(41300700001)(6486002)(6666004)(66476007)(478600001)(8676002)(316002)(66946007)(4326008)(86362001)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bc2SM6kWSzSiv1i+YsR0Gak0w2hWhsF9OwuvA0dpOVTBmk9hxXrwBg2sYR12?=
 =?us-ascii?Q?GQkGodjRAkqKPNWjXHMjUrtmRhrUS34Ish3AdyrInV35CsVmbFDF5wmSoJIA?=
 =?us-ascii?Q?aFWlloP5m5ONtHmyF85CANTinJbDWcSJFCriscBRbB0mPRHF5BotXJEfH8l+?=
 =?us-ascii?Q?s7juwqIgJRjJCEnJm+7SRcIDJZGECBCRae8gs/DOBivn4X+5kh34hxRObaZ5?=
 =?us-ascii?Q?H6qoNS5n6thIGAgHx/fhMM90toXJ7OGiDfZflRdK02ZSHr+YoCBqJUFldNxd?=
 =?us-ascii?Q?hcVtkQJSX+sPwIb5hxbOCTORjH+Kj9ijpFYcGncd1+Wjsy+wEs03HE2cra/L?=
 =?us-ascii?Q?yjBmuUkY+66X52ESYSx8dUHzYimzFYz0MDFdKomLnLTcgHxYomDLj/xwdT9S?=
 =?us-ascii?Q?YY8Yx8HxWmsKCyLFJ6GJOLg7yHdY9xIzL0pjgTWKhs7qQup+F9CJ7Il7Pe2A?=
 =?us-ascii?Q?/maTJ68/ZzCU5E28Imc4WlX7Dl6jCHYjnAqlkPD7JcHLSsE3BiIDxQ4tDl9g?=
 =?us-ascii?Q?Tr0BhA+aTk1qGIi+QwlifuzxMQQSrIJvkNU77eion5fnrZFqTdefQfUWmM5L?=
 =?us-ascii?Q?zCPOuO7Zm1KScj3aZZpGEHpLIDJP+uWQnSfyDp2XQwlkCTGL377KGNblB1My?=
 =?us-ascii?Q?zHRovO40e5jqYIKOWIvlcqlyhxl8R7RZT3kUB+cI4HzEMoHkkV7QLR0oblos?=
 =?us-ascii?Q?rBJbyR3rBIPg2V2ZpFnGMcT5QnQTWTAJ/THKcy0cTPSsaIvCIAOwty2LcKTd?=
 =?us-ascii?Q?Ko65DRVgBXa8r9rTggqSLcATGNjRCuIO1y9U05ezcZvWs8E/pTlOKV6zOnKm?=
 =?us-ascii?Q?QXGv7pfAYyLX2ay1YuHUViJh8NPxiDQRNzI0/kS0QuBtJnzsWt6qrOOtOaFh?=
 =?us-ascii?Q?yqndtTYBv8IXXjqMedlGFaABGRyzu+YJC06pAsnyyPIQfBYgm1xf7PDIyM8V?=
 =?us-ascii?Q?8Ac/cHYZiHo9cA9MvThXHHyF6++RA3PsV/9/kerzyQ8gmmBCYIMbpeAw6Gnn?=
 =?us-ascii?Q?dE46HPP2cBIUAdh1ftObVsILp4yZsbo5xigdSmA2mh8bE/Z53O6VYFKdIF5n?=
 =?us-ascii?Q?D/RMMk5UxTeBC+Yw/fueYPK1qzgonnDPUjgN+8x3v7cUiWDjoAizTMUH2v3K?=
 =?us-ascii?Q?TavLlSDI8DuzJk0a3qhSIibgYEZa2bi01bEge/RXt8ASUHBYhfX69bIo+wcS?=
 =?us-ascii?Q?4S/fElixo5lZ+rubg6Gd/N1pWzMk7zLlIqpDYFtU7CSG39IMErL2g/kNqWiZ?=
 =?us-ascii?Q?6tB7olyfR5lGb1DVgwiXAQz+mfK1xhg4uA8yN/37Ip+dhn/tyk+Zr71xDi2S?=
 =?us-ascii?Q?/0xSRuVH13uAGrd1H8mizApJrdkIhQSA6VKUWGNhWA5fjSn5te/AyP2poj0w?=
 =?us-ascii?Q?XgzSSyItKYiydDhn5StwyTw3YeXecnCLqxnoBJWPu1aWH2cP9Af3Sp3sCnKq?=
 =?us-ascii?Q?NjkAumaCj2k82BJtnaZQX7D7LWU0vZWk86OZ4QJahoIvsPIz8J62On+rfqga?=
 =?us-ascii?Q?q9xtP+rLRevaviAUWDfh/mUaWZXg6nqZhf5gdswLtd5I2rm6cUJRpFxo1sHs?=
 =?us-ascii?Q?apbV3ejTBAZMJWYYAjkaeeIF6z5i/WoyOzNQzr+IzpkSQE1Ion5IjYfMHLNf?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6958f62e-843a-47b7-e18b-08da68bfdccd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:17:27.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjuSHKW/w96VF54aEapCl3Fh6Ol4Nxto3QufjD/zcajTVlf9jepaLz6y30BB6OBZ2ij3cLik0vF9+ZFWR//z1Bg3UfpQ9DfkjrcrnMC7Iww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
X-Proofpoint-ORIG-GUID: CV7kMtPwJGwxKti8k6EqFIISqy5uGYq4
X-Proofpoint-GUID: CV7kMtPwJGwxKti8k6EqFIISqy5uGYq4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change > MAX_DIE_PER_PACKAGE to >= MAX_DIE_PER_PACKAGE to prevent
accessing one element beyond the end of the array.

Fixes: 7fd786dfbd2c ("tools/power/x86/intel-speed-select: OOB daemon mode")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/power/x86/intel-speed-select/isst-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-daemon.c b/tools/power/x86/intel-speed-select/isst-daemon.c
index dd372924bc82..d0400c6684ba 100644
--- a/tools/power/x86/intel-speed-select/isst-daemon.c
+++ b/tools/power/x86/intel-speed-select/isst-daemon.c
@@ -41,7 +41,7 @@ void process_level_change(int cpu)
 	time_t tm;
 	int ret;
 
-	if (pkg_id >= MAX_PACKAGE_COUNT || die_id > MAX_DIE_PER_PACKAGE) {
+	if (pkg_id >= MAX_PACKAGE_COUNT || die_id >= MAX_DIE_PER_PACKAGE) {
 		debug_printf("Invalid package/die info for cpu:%d\n", cpu);
 		return;
 	}
-- 
2.35.1

