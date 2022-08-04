Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65997589D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiHDOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiHDOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:34:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A4C33E35;
        Thu,  4 Aug 2022 07:34:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274EWsl1022319;
        Thu, 4 Aug 2022 14:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=VrJr8NG+Kuj1IyHXHH3CIZMTiOa8czBFpj6vO558K3M=;
 b=omUg/WMSic/uuIMBsXIP74fMCf0+LgUgSfsYX7Cs6KQlm3ejdZB3/zziajI13KtdapNp
 uj/Uisk9ir+yQNdFP9c/Qd4jSNwF5o7Fefe07NwigWQmHjt8otL17NhAuFYiLbafJIzJ
 OI3qsDym+pG/BypIkII6bBcGLiaUfXQLyS+pETYBJbZ1Dg2vusIjvpwcBAc0J1gjXse+
 8w71/wdlyEYWBVjFR0dqJE2RoFdhchulWllTLvC3vf8gDH8nfADcbcYmzxmckLGeJl7F
 aydH01oT1+SsUr5Gu4a/AZgBOLoUm9b26Q/nRxrrjPNKZj9hKTF6aG5amMv77Kl66FhB Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tn2xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:34:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274D2xFA000991;
        Thu, 4 Aug 2022 14:34:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57t774b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiUmun2oQRUCXoZMoZrbs5yuZHwap5hID/jAKwSZaDpOy+mCwNkyW6nQYyBoWTcnHrWstpKepvkSnFFOr/rxnqjbs5SoNkIRPgfELU1K8nci6WuZSuNMy1cpyOXc8AEFdcUyYGUYCAl6i7DCmPBCzsMiFYw0TQgB3aV1AtO+w7fTBsnGk3p1zIqc5ul54d+4fWizM6dL8QEqYs/v2jFHXFGvtUeunkcmAjAkMR5SQW/VvG7adahc6xfHZJ+ys1ttKCYinjst4sNRYO0FlD2bw5F2NO4j317skjwLrHrTiFT/LSTHcQd3eOipSef1pQCl2erCVO36hDnk1WO6YsfNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrJr8NG+Kuj1IyHXHH3CIZMTiOa8czBFpj6vO558K3M=;
 b=E8J6I9v4fN8i3eA4taC8wSDM7lS9vHXMeHLyetGQFqb8TQQ3aXio9aNJAxsPNRd9THRroAsboWrfuRK5hXlaJoVVGrlqzIRDxAIRPpHsK8Xl03VdXMoH2MmsJk5HN22QE1wHRs5LYpIm4j/gHZHoadXlr33+TnxmLNAlAnh2lEaHh7g/gd1vQxCZmwPy/ruWYUQfp7IH6k7XCmb23LmXBahGHZxstf4ycrI4gWV7gpqIHmMC7cfEpajao69HcvydmKWCGdHMEtl1S3fPdzoB0tIc87kx/IE5kVQqTbsrjLNiVfgfOT+jRRrgbXiWk4WXfKVWC2yqA+ybygqHIShVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrJr8NG+Kuj1IyHXHH3CIZMTiOa8czBFpj6vO558K3M=;
 b=wyogEQLBaIu1u3ovuavoOfQeeM+1jM2jOGEIeJPOcrOfHHxDLjI5AOBReXEQpsjI/S+R9q8AM+qfjmphrWDUVaHxvSsx7bIFgHF57nAKa/uy74MIGVNY2vsA3rbmiTFG5HvzpzuxHW13LAz0F4t3VOsNj7dJw2OzpauwmlRyahM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4374.namprd10.prod.outlook.com
 (2603:10b6:610:af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 14:34:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 14:33:59 +0000
Date:   Thu, 4 Aug 2022 17:33:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rv: Unlock on error path in rv_unregister_reactor()
Message-ID: <YuvYzNfGMgV+PIhd@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c449ecb0-26e9-49c8-0ea7-08da76265e60
X-MS-TrafficTypeDiagnostic: CH2PR10MB4374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cS/936Ktmz2ERBn8lHDgnIfcgK6wO0S2533dko/IjBrQ5E4UwHBkpYDUMUiwGzeWmlf2q46BjpRAQBoaiZn3sJETAWFALiYbx+pNQhXH3iV/vMz6BqQSNlPwNKew7rt7vv5e1gUh377mhPnm1h1gie+5XhQ65Y75jg2jwHZx6EC44nTJ3yL6Q2yaNoVcJhy8tXWgT9WRFkw5PQRShSFYcpDE1cvMC6WOAvivxqzxhA2G8dE/hglE9JMpHbtN0Cd1ON8IF0JTzVFnkA4h4pgrGhAXXVCNjR7iaTquWl8/SZp+Bw0l2btIBgi/FM0TunoD2PbKVM1H7X+j1WSrVtNj6qjFEvlN89V9LknctuCWC4QQx07VA6CLMIlTGaYd6vWr8i0SSIFqmQELPyImFAc5iJJYwPvvo5O8GOgODurz4qsmFYkaptEyjHIVV2oweTeNFFW0ZfmxkOT6X1VBOP5EtUCAEK3AUMgTo+oXaUZC53FBgHxPe9pyw/FsS83FF9XTys2xoodP83K1kR3fToBLv/WOANAqU8Zil9RGan+e68S28AEtJuLYtXQCsn1vMomDuO5N5pOTPE6de4HSfbppI6BbZjcSODWbNRbNNeNgNeF4I2TVarjd6yoVnCf40c0qs9LbROxKPEFkvDQP/e8I0k0BAIJ2Nz4dpuQETCyLe3S7umYZ2PfXBeCM01GXo6bZULizxtzCIPJY/a9TIyWuUNIqlHOSYJH65ItBv2YTp+EuwGGdiTnobJp6h5V2/3GY/fTKsGEZ7UZ6ovRq9dJWzRZw//aqkRUg00AdN1PSO1JGD/vdocZh2iWXPYvrvdzRWCdQh1NX63nYox+gO+WwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(8676002)(66476007)(66556008)(66946007)(5660300002)(33716001)(4744005)(44832011)(2906002)(6512007)(6666004)(478600001)(41300700001)(6486002)(9686003)(26005)(6506007)(52116002)(110136005)(316002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PceKOXCnRxBDCY0Nw/PyFUhVtMRQc7gEA4aSv9RkC5oNlzJiL0lLhmVGv2+y?=
 =?us-ascii?Q?ZD1KSHgYuiYBagih8iPDvCpEqsiKJ6YY+mCDikIum/nNhPQTMEGtMrkopA6M?=
 =?us-ascii?Q?StGk1B8yqwtdhtgpZmrRdIf8leKTmIq9MOxdmDmBVQ6CxR0NHT44q309496y?=
 =?us-ascii?Q?VmllZG28SfaOKZAqk+LRLxlLGXnJz3xUQ2LHwwNH4haKPxyZQe4NH7PRrBJe?=
 =?us-ascii?Q?ejRHD5jLWFq84SOfy8kHogooW3at+5jqG48vbWp3oN0MYPkEW58wAyVYAfgM?=
 =?us-ascii?Q?IJa3JCBAY+9bybUwDvdSwfyzMcWGFJpxWkS8mknx4FJ454VRXdn5Es+Z4ip0?=
 =?us-ascii?Q?MhxOg1DDfLcsak4GqlTuGqHwIHF3tuSI7rMj3IaN09LavSMadZ/fDtUhzWkr?=
 =?us-ascii?Q?X2tIGsaIcrCiMEfIo1KSbiSBzVBmfazG1iflwurq5un/lF+qgDZGsS1xss7V?=
 =?us-ascii?Q?dICAbak+3NBgdDv8WXd5Hv5X7Kgzh/Z9KNdxWkdQosHprbOpokZq8R+tMdem?=
 =?us-ascii?Q?ZQJrCaFMcq5UbdpMkHvBd2ojJGd+MgPaRToQV9ua7k5dvq5LRA9QGuYhyKGj?=
 =?us-ascii?Q?gbSS41a9y7KSBfAgmBilJwfPD6nxggmUjXid7mlx0iCWixr4Uox7je6AW5Zb?=
 =?us-ascii?Q?A35igTXV8U3zfQoHePjj4brJscPrvLq7+uB0FVdftbFtGg3iwAr9C//nzN/+?=
 =?us-ascii?Q?A4CZQFlttXSq3vF1rr8Q5sIUcRUcIfx8GFUIZU/Hhcyd8kadT9/s+CAT0yq9?=
 =?us-ascii?Q?vtkFgpW/pL5yQvXCPNusiJoISlpzQ18LWgMjktX5PkBbRu54nMyqkpfkhz+r?=
 =?us-ascii?Q?KW0j4S+8XPV7V7uhl6GyCdrqtS/JkdO1Uk8lVM8u/zd8Vry98rae2gkMZgk5?=
 =?us-ascii?Q?F09y51BksC0+vGXGbg6vQ8MeZNmZkDD9MukyEvjL+S/6FwCAZhM/d1vLF1kl?=
 =?us-ascii?Q?fuGDPvYB3a92hIWy88eSqsUlWxoF/L+f2CxvKkj8WrhKXvbg/sOMMoYlkloz?=
 =?us-ascii?Q?0R0AogmirdYrfrhhAsCFMn2ebi7PXavzAgPrYGmxzeRWRbEvpY3vuAtt6SIP?=
 =?us-ascii?Q?YU06AJ46LYFTXQEBc48h7Rp0pWqSdMHtHVa3K1puT0XBbeZPupiwxAuAwXMc?=
 =?us-ascii?Q?dmlgLukVujetAv7l0LDWrMAGcKxYOEkkQiEw6dQ9DOEzh+bOFE/T7e8L5h78?=
 =?us-ascii?Q?Ac164fftegNuGLzmO8SKQzR9/m/CWgDvDvew+8lS0zgoHwwLBmgH9Tv9YdjY?=
 =?us-ascii?Q?SAiDeeBWkPP5J+zJn2DQkt1sIPvhXcxGaglfZ7jQNFkZPhqJZ9nhmb8FPFJL?=
 =?us-ascii?Q?wxU6Jkyh76gAijVeTJLfx6mz6e+FLnNzbqs62Y/BSoCqax/oQs6+8CZtBCgS?=
 =?us-ascii?Q?N9ZbPilB+N2NQuAVd7LWf1u5VLTMBYHUIM3XzYFAOCpSgiU2ikO2IXE6cT2f?=
 =?us-ascii?Q?XIwqPSptWNjmgUZjaeqVsArktOE4UewZDxWxhqRRmbBjfQobVIYG022rvfWQ?=
 =?us-ascii?Q?2OhOZnSg5ABlzUsJn+tHaZQxdlWt/3OS5AZqJHpN3tSnJlSCWfKm6UIzscOo?=
 =?us-ascii?Q?xKZrsIersB05h7BIyFAns09pTfxofU0LcIDvsn5xVui8ljTHp4j1yPsV4fFA?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c449ecb0-26e9-49c8-0ea7-08da76265e60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 14:33:59.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hjBBtSVS9cshdrC/kXLsl0ApqjzM+yQqMFVSaCv7/GNLvWAEU2O455meK9MdpQ+Q2gvEQGDdBqlxoSaD9phV2MfFJlWGG+5IjmqqeW9NKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040064
X-Proofpoint-GUID: Jm98b7M_Q2zAdMRr8it0c77UNWk8Yu24
X-Proofpoint-ORIG-GUID: Jm98b7M_Q2zAdMRr8it0c77UNWk8Yu24
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlock the "rv_interface_lock" mutex before returning.

Fixes: 04acadcb4453 ("rv: Add runtime reactors interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/rv/rv_reactors.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index a6522c196382..6aae106695b6 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -329,6 +329,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
 	struct rv_reactor_def *ptr, *next;
+	int ret = 0;
 
 	mutex_lock(&rv_interface_lock);
 
@@ -343,13 +344,14 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
 				       ptr->reactor->name, ptr->counter);
 				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
 				       ptr->reactor->name);
-				return -EBUSY;
+				ret = -EBUSY;
+				break;
 			}
 		}
 	}
 
 	mutex_unlock(&rv_interface_lock);
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.35.1

