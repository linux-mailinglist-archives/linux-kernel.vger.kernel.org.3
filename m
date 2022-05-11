Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687BB52292C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiEKBso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiEKBsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:48:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CF6C579;
        Tue, 10 May 2022 18:48:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AL7wDM027467;
        Wed, 11 May 2022 01:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PFlxxLXye/oBjGpzojyP6jN0b17ybzVUPYZ4X2yyvC8=;
 b=0/uMYm+UGXnqsQTTRrTdV3YMRoA7Jd+LzARyaXhdidTEcFfumtWfGuqf1emAiD6Vm1LP
 aQyb429BM4dieCBVf6t/q99xhpfDQJuBu8ssD+Rc/nmszTojTG1UW0IhrJJXdrIZoO8v
 +IVuWqwcn9zLwtyhL86QY7lxKF9/Oz0dE4/hBLJ4ZqRaBy1nO0uswovxrYqgzSdQSBba
 ydZL2G3mU5hoFWMo7wXdQdhLvAhWsNt0AJXk8MU20KP1u2uurphkCv6LjlwSvlGOKzlO
 bJJETNXoWQvfidBLo9FthIYpJun/9lrJ2gmxmXuwDjhcgk44iokrw+Xmr3fsndFxAcye qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2gdne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 01:48:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B1jdig025081;
        Wed, 11 May 2022 01:48:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73rh5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 01:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3QTrmZR+6GqPXGGnObUWj0XkejNyYssCoUVM/C31eKzvuuBp4+NpttFQ4AXjMKfj0FThRAu95bHaUjZcVE08wLqYGY2EaxcyCQ6iPuEdUHqYwLXR17YGCCxfoIRWdLhU4iB1Gd9IDZ60M/y3/K6qR0EiDc8RFuSgha9ydhStAKfFHLJEg+qBTzgZqLpA4L9PsxSiLFp1FB51YlMtltpwarl8f8ZGWiK+eTJR3Z84+EOp9Fl9rHchO8BUz35fCumyap/8P1+plrY5lwkRYKQRvkpNQkzsB9UqimYNE060yEUUfiyt1Neb9MsM4AgZJQCXUzQ3gC/d+rALalHk17CxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFlxxLXye/oBjGpzojyP6jN0b17ybzVUPYZ4X2yyvC8=;
 b=IYvNcCWCB8YPLGhZpRlSS4ccjKdwn13HInrzpPieIPQSlyg0AG5jvvK3vVLS758lrrtMrSrHVoSW0ZiQDsk6TJ1u3xWiGFSlBdLde5LpdYpS37Qqw/wuOm1HNibxDicvV/4mupenGTdsmo1e+7NVP/7fz4VwZL9Id4AqtIkROS5xUVRSxe0KGPC//Y5/F9Kq85r11noqDxcIR403MvhKHfjZUch0V7FQob+i62CIz9ZGo9Vy6pM+LVnDCnna1GyWEdOrN0g2Pias+yWu7pmQ2DJykk+cAUDM+K5GbGNDHpP1fRcHaKXjkK/5XVK0PEfvpiux25K0q7qxReQ2qj15cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFlxxLXye/oBjGpzojyP6jN0b17ybzVUPYZ4X2yyvC8=;
 b=aoQ0Da3jxJB9VfnvX+Vav4RLXk+OrKFzybyZjL1EIuPS1e/JLJvzNBxQJewNRMfq9JFCpqeSu+VQ0anMCWDZIB37q64vgq8K4cdIgN3l8lSGS2J1pHxmbY6OIEWC+VhelIs5vXM3TCSh+Y83fkwNTpMkEW+esQKL7fZr7TwkO2w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3733.namprd10.prod.outlook.com (2603:10b6:a03:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 01:48:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 01:48:20 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] scsi: hisi_sas: Undo RPM resume for failed notify phy
 event for v3 HW
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czgk2620.fsf@ca-mkp.ca.oracle.com>
References: <1651839939-101188-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 10 May 2022 21:48:17 -0400
In-Reply-To: <1651839939-101188-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 6 May 2022 20:25:39 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f95ecad-e2af-472b-565d-08da32f0531d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3733:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37334AC93056A749BB9D0CAF8EC89@BYAPR10MB3733.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tll8idekiANGQFWnqNWlTNOpAHAruv1WfYUGKZWYsTwQYESpKt/XCzeAHTAGWbZdS/ZdhAxKHzHOnh3I3H1wltgEVNbzPkwFJxytVr36U3t2Kx4p0qUriAXf09nto/aIrJVxcuTEGKw/WrJccT4siOASt13heaMrKJqJR3cMp2p3V7c1oq7TcnSlXxjUpvZ0qq1kZTnx9WcQa4GYlD+f+StJQ1A0MpatKJLtbFVH23WBape926rdJLvG2B3DwFCVAoku24JuUKNLkLHGqjbSH7aBSLsM4oCXbs/TJOqrC1SkyyvzmZ0pJMhc/2jgAtA5SMG3vZb9t7hTmwV5XUlpeQzRncu2rDuuZ+19XIPmkmBYuLMaWwy6GJoRKwv6KKUrT50ZpK+TwMNqjnW2sEqvRx6xBlxj3MCVFFwfbw3wg1Du6DqLeQCsG6X9kQ+JZ4VS9dE1mrfSeZDEZ8OM2B5GyuHGGPkSf9if00Jw5D7L+ZzhUYrMCchBVEaDNWwETeYZTpcr8V537BhC1pFjwgR2BPAEynCPNVs2DNqMpqokXrXU2YdDfN8lzpT0+GoNqa/3w4sEZ6qqGeu10nm2Ucis4wdjfeH0K1RD1KUkT+wAqVFeuIgRGxpkGHKnohSHyt1HiNnQ9we/SO48I7r8FnRdmVesD2HDMReZggfemTquyRMII1TRI8PSxMmAdvD165DjU8PtG3OLaOY9funh3x74jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(5660300002)(186003)(38100700002)(66476007)(66946007)(66556008)(316002)(6916009)(86362001)(26005)(6512007)(38350700002)(558084003)(4326008)(8676002)(8936002)(6666004)(6486002)(508600001)(6506007)(36916002)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYCN8eKYacwY9pVCGEXAnINWCbqEK1USQ5hPBpFQIYnimNj4nLB/gkah959a?=
 =?us-ascii?Q?gQvFBwKlZqSL31XAC0Q7oAT3K0Bom1j2Wt/kaN/EhR19BI2x45q+h63/t18C?=
 =?us-ascii?Q?+qQ+GjCJ3iyucIQFStoCCdORp6M7Yd3qXdisN47cQTI0liIlCulyz/hJLGHM?=
 =?us-ascii?Q?AFeld6PSlhnJdbX0EcvicA+yr5iKU80JgpgVNve9wtjJGmMrIFoaiQiYwPsf?=
 =?us-ascii?Q?U7oxL8tCVD6xVJilWoDWCT4suVym78W45Yxut5UJhc9Um4hvPRThgooSkLK6?=
 =?us-ascii?Q?Om/mClDFd0VPVGemE3Mm+i34OGI7im6lnQPDpOoNm6au09YmLwyw5KAgGq0R?=
 =?us-ascii?Q?e/irOWvM3Z0ktLHIvpwEv6ZHXFxNW9FFZTdEV6HD6yDLYV9A/FcSpKC7ceG0?=
 =?us-ascii?Q?jGAiGG9eMdlYbF9I6BucmHZa1+NUKM9TuMO611OredhrSasWLlcEzkiSsH/d?=
 =?us-ascii?Q?GrNeiLtat7nBQfcTvVyhCGRR5Tn9sKOtuMvBb0pSSP2AmxNS1DAI4+Or8SGW?=
 =?us-ascii?Q?Pkqu4LXJdMMy3YWCYKHT7kLQtFNrp7o6LPV75P5wLg6M2+PNJn4Afbkd1Xdc?=
 =?us-ascii?Q?Oj0bELWYq0mzw5aBsclRqsFsd+XOHXHOYHDq/Lx2jEQddgcwEbUGTABcfODO?=
 =?us-ascii?Q?9YiBhD6NsrH97ry/zEXPeiHaeJIPXcNEIQsluctO1RQED0Fma5jM2J+jd4wq?=
 =?us-ascii?Q?5ok5hpXO1vNuBvjV2JA9sWNEMEs+lcu+QhQxQ0JtO2M9F5FU9JrLEqTgN4l0?=
 =?us-ascii?Q?QF90NSkyhtGBQtXPPfByTVevNvstwskN8uPO6kj6h2Cb48PdabJBf9JcOEoy?=
 =?us-ascii?Q?0+42POdzqU7JgzpxkQ3rse5hPqhgq6WNc42UAuDB+zb85pneH3kVMCx8nxDu?=
 =?us-ascii?Q?GZQDW8xn1iVDb/7JCbfDlgBOxe2pvXa6x7sk06B5UhnppgrXcFZdd/Zrhu3N?=
 =?us-ascii?Q?VzbnQDFGqIJ7J09+fm0TxZGPZsNP2fNp5vyslviV0MWQ5P9ukJapdlctKHHx?=
 =?us-ascii?Q?XMAhnH1D5j7+Dl20XdO2udrgMCagt8WlzO/7k6YyyXzzbGpCHnqXqDH5p8qb?=
 =?us-ascii?Q?/phDTZiiGOUDGPHnlnXZbQ0XFhsX+mGoIRy/I3OkWYf+ueb6hhVsBPg9wEhQ?=
 =?us-ascii?Q?giOJfaYTVTA/5M6gTTaPjvW0vxJsEjOblaMQlOfm7rJ3mm3fMQute9zJrNby?=
 =?us-ascii?Q?KsGsf0+s4aNXD4cU7DsJ7XFu7XayWujTNrN41zEMlPdp2Q7L6cTWFZXf0M0f?=
 =?us-ascii?Q?TLkQRNT7BHW6t2/EJ7ChHs31JYc5XvHyJcGem95n6mpamfqlf2nf5q6cT+E6?=
 =?us-ascii?Q?VYR/XSpAAmTXlZxGRlv9kTUeSo5oj9IlAhg7Y3CDXIQlA0SInDsSRohIkG1E?=
 =?us-ascii?Q?jMprFnzU+QIRnXxOHmw1AXaDcDtOBfs+4V5jasdEyXoRIsS6FXizFV6yXkik?=
 =?us-ascii?Q?+eVra0gzFn12aCRnj6QxYQvT8SWMOaASu0//lf0JsW2IGkLFWLKhiKLN/aAN?=
 =?us-ascii?Q?iNgPufAM05R9xhiUr5+Mv8kdADPuOtyXVK1pAmFmGca86b09IPErrb0p2Grz?=
 =?us-ascii?Q?XAtGFs0EqazdnzMNmMIYsugiNBMmA2l6UylEQU4Fj7sn5hZyYe9hFCW/jzjT?=
 =?us-ascii?Q?7NoZzdfyGTToCTqRbD1pD4Op3HsUK3gMuWKCoiTGqCVZxcUSM7MDb1IrXxuq?=
 =?us-ascii?Q?N/eGHMSTnpYxHitwdhi9bc/alP998ZM4q7oJetln/b3HdGrDkob3rR2bclBs?=
 =?us-ascii?Q?VwF+Z3rj2ymHmMSv0PVRYeCuqxqjyM4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95ecad-e2af-472b-565d-08da32f0531d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 01:48:19.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ennd8Lqhdi877NaspK6hQoq4YWctuR7yOG4xcQXIGu2Hp+bq6O22VQPla1Fx8UmmXwNSnZOOUdSKTyXCKbqLznqpLw0dNCoR7gULLvP3e94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3733
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=583 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110006
X-Proofpoint-ORIG-GUID: mF5sZNf4fGAsOs51FkYOdbnkgVtKwpFS
X-Proofpoint-GUID: mF5sZNf4fGAsOs51FkYOdbnkgVtKwpFS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> If we fail to notify the phy up event then undo the RPM resume, as the
> phy up notify event handling pairs with that RPM resume.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
