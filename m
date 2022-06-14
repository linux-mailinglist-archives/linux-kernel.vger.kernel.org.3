Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C248C54A3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348926AbiFNBuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiFNBuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:50:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B0B2C108
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:50:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0fHxE027238;
        Tue, 14 Jun 2022 01:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5pp9juLRB/AIdlSYl3DSoikGhoDrZK3lv3bkiS9FQtw=;
 b=j4eGrDn2yHc2vot25eI0NuVUL0jQ0FsiaXsEurvPymw740cl7t82Ib4RFXvc0Q4LG6m9
 ruQI4HGhgQhzG1pfYLloHW4WLmKZaoUFiMMn6LIEeUQzgw+xyG1RZnUyTr/lr3RxGQsn
 z7a628rUZuEDz0sMOl1uR0Uflx6ukYvQVTw6xj05UmCKPci3DBSIdayh9fB5UZd9UGwz
 hdIDi6v9Ps3BlxtPmet/5r7ThjOKGxYJqtqKda6LrT+XTVW7VngKcxou5R2yxgqiS+kC
 jEVcvb+VKpQDbNgfhjF3kp4fd1JAxJGtHY/I/yHRkIobJKg8TrX/TdG6dut4Ax4FeldJ kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4hj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:49:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E1kiH3040126;
        Tue, 14 Jun 2022 01:49:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgyer13t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjtf+nT+vHIfCr4/id8MCw0cXKURI71dXk4NdmJCxBkXbCsi7H7C/7SnskQ63uPlcDsltPZ/Qk5a7A7uTdzx1o7VBWe+NCl/OzYRj+EUM3avP6gZYrqYX4i3epDa5WszwQTzbZ8u7sGF4vImSPMM5gU/hGy9E04zSu9tjaokTG+Zei0bScCZrqqxx/YfZyC8z0tDv1n8uO61ehE26auY2p6jtVj/nDCiYSsNQ9Yx4wTkgkysTCt7Ws6/pCohBR/PyUzvaC0qmCRDNINJOPH6EOTABOJYzW7G9QuHUnMX2C7BNrCrj08qVk92TLqtgOd2L9nZG5zt0uAvfj4VVG+pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pp9juLRB/AIdlSYl3DSoikGhoDrZK3lv3bkiS9FQtw=;
 b=DuiEHeWBbtqezT5F0NSkmY+vpts8/am5TF3PZ228tmJCK1zu0K4RUPT/Iio/HMcLaF6gc0J0wzQ7QTSlN10vVN5oFL0L25ZzLqWcwYS1N7icgsJ5JR16B6pqZnp3rhqcYSrf6Q9W2+1c1yraJAP+NopnW16aD1eCeGNwy1VIdznpRtURI413AzKFh48b6K/OGvZm21MckLPQq2ngz0MnJW3oEZGmX371gH6Yqx8lGszEDnnKrSnekNp/ziy4Lky8IS7KpKK97U8CpVkVZWp/zubOsP+fPIe/OhN7hcawG64M7432b4BClmVspBfdeBd3ajZ9tiR0PQKIp1WVhQtPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pp9juLRB/AIdlSYl3DSoikGhoDrZK3lv3bkiS9FQtw=;
 b=Ka0rkzDLETp4ZV0RMlyU1F16VDg7yX5xrBDI1sLYLeB86BrOW5PMFGUhBdc+y5lGLgerAvZ6Z4ERKSGmgUn6fSk7rOiENyjw07QafCbpwbGK2j5HOZBBW8Ah0/wRB6odEF51VbBayaPd4vVTvNPNyKsMVdUsr+NS6GqjZaLyefk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3933.namprd10.prod.outlook.com (2603:10b6:208:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 01:49:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 01:49:54 +0000
To:     "Alim Akhtar" <alim.akhtar@samsung.com>
Cc:     "'kernel test robot'" <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
Subject: Re: [mkp-scsi:for-next 31/41]
 drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs'
 does not refer to any field in type 'const struct
 samsung_ufs_phy_drvdata'; did you mean 'cfg'?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h74ot3sm.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220611233355epcas5p1970bae9647eae17e20d330775b584695@epcas5p1.samsung.com>
        <202206120755.03gKC0ne-lkp@intel.com>
        <000001d87e12$c6962770$53c27650$@samsung.com>
        <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com>
Date:   Mon, 13 Jun 2022 21:49:52 -0400
In-Reply-To: <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
        message of "Mon, 13 Jun 2022 21:45:22 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a6f0ffa-c347-46b0-ed30-08da4da82dbe
X-MS-TrafficTypeDiagnostic: MN2PR10MB3933:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3933F1A010B2F17DE99BE2D58EAA9@MN2PR10MB3933.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clWgi9XPeaZcRfaNQBjegmWzdx13GwWIJzuevS8NRHN2e0Sau7amUtAY2hGp5RvPRIpM0wkOVJT0eOe5J3mth8JK5zCq9DeianyD3TCRG5oU0DlrRJXza/uVYIq3+n8RgtGldRtJ8JyrsUbJeLRmTPGkvlrF/V6MEojIqxV6R+F5gGZcBQmPwW7HnRJrOMZfbClzRVqFVL6u0le7MEkP1XfOtcePc8bLRMtswNFXvjomQXKQ2XiemLPjNTw6m0n6QuOZ8crXzl0ZzKuEvvEtAsXXngkR+I+wqGP8l2vB0V1ydHAcUn9vECZJKmgWE3mS31XddTKnJ3b7m69jK09cp5EG6hBYOUlWkhuYDlcRa70c/+vZEOrJoKWRy8dfy3VC76lLzWTVzvq4kgKFTSBPpEFc1h0HrDD41nXZA9fyy4XhtuUrkZr9V98pZEq5CcXayVRk0fFPWxBY9ZMMs6PWmVyvpnQEdVk4xWdBK53jfxaQAByRyrQrQE29PrvuD7AVP/+OCAqrQscmfgDqEbNYQuYzVEj/VdcY7fVnNv8lMdrlKeVWdqrH06uLzowrWlbf1OA5ElrKtTOsFEflzLQgcplaVF92+jaHS1QcLi6qGq+NfRpiRonJrlTpPjaMeeX57sESGXTuD/yoVcrkRk5rIDmO/Kej0fWhIWCIR6oPDBUWgoNvV1h611P3YPctA9y6MU5+HHDtnJnvw8s7M4UxJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(4326008)(86362001)(558084003)(38350700002)(5660300002)(66556008)(66476007)(66946007)(6486002)(316002)(2906002)(8936002)(6916009)(186003)(508600001)(54906003)(52116002)(6506007)(36916002)(6512007)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqoXiDBewCD6YU1+S0Dk+6fGpUHlgcJ2vg4xAoF78ffGL1FqT9k+B527a42C?=
 =?us-ascii?Q?Ko1un15/hHTKPf4pUK82niLufPNoT9kvkSm3nLKgjBhAJ+FDX6fPhKfZr/d3?=
 =?us-ascii?Q?R+QIyxXc126B1Rvdo9Eb4/UvrhmEmBMQdcXCaD7bO6W3gHXCdpw4Rqvyi7J5?=
 =?us-ascii?Q?S4IEb4tVDDYNbw+gLjgHTKvtpMDEyHGMODBF3z9veiz/wrD5y6cabEnOROvS?=
 =?us-ascii?Q?1VCVyCJSMzdBGeBHe88TSErjUKRV6GyffQGGQjwlYzbht5TQH7M88hfpK9Hs?=
 =?us-ascii?Q?ia7NogrhXQ6f4sh56wkth5etG+cyTEt3J24EevsPzi+Kue4qcWSRiL1/iOH5?=
 =?us-ascii?Q?kWKaLPfdjfyMMOlSB7NDZqqrDD5GXWknANxpbgxZWRqdhpAjk8KD4Jt0EsW0?=
 =?us-ascii?Q?iAdzX0BpXBsu92TyAX5k3I1M88QYvP0qmCIQ2Te8XzLWQWCyXQmWmoHS9T8c?=
 =?us-ascii?Q?HEu5jt5mH2c+wQ2f/Izjxiik1uJmuUg1m+BWbfGYSdatToCt63TeVpU5OMR/?=
 =?us-ascii?Q?wxQMAyhdnW5i6pkKye0WtIuPCgbme1BVE3HmGAD9ymqUoS5Fk478oPgYGVV3?=
 =?us-ascii?Q?NMTqt0rEUKZoomwsI2VwD1PEkVlHtfh0/96vHu/1yDBNV30UZ6zFtvgi3WnA?=
 =?us-ascii?Q?X9A0iupbOplRG6rVTvlWXjkBETF/cPJ0OXIYHDoeJb5X4/K+HsBnhGlVweeW?=
 =?us-ascii?Q?8i5Ls8PYdH9GXgR6qmolecUoGI/d3G7dbOEO84eWT/jYMRdSGhain8H6ZdXa?=
 =?us-ascii?Q?dQoK45Hbk2K0GwerWxSdf403AMF+QbiklcINZSs+ujUofLVEay2C9lXryY8Z?=
 =?us-ascii?Q?uihW54upDcZHt33ECO7l05KdPVfn9zAvID+wD7YGueIakW43/0zMGuuq4ud5?=
 =?us-ascii?Q?d5W3/phsbfP3n5JyWBQZja2OKWnbCzyGYfFqSM51FnldCQSAe/Qa3vWpMz4f?=
 =?us-ascii?Q?3SSpyGcl72ckWIxIwJVaM0UUfv1k1oBywAgAnLtSbUa3FrUjXW2fi1H7ojsT?=
 =?us-ascii?Q?pRf85U6dFWpfJK1mBH79EZNK/xYAhWpRWE/ia7C9T7d78134aN2e30Qjy3dX?=
 =?us-ascii?Q?hG+Tv2deuvx1umVk2hIr0Tk6dftPicMHRVfziEcQp0EFRygX5caRAqF8KQN6?=
 =?us-ascii?Q?4wccudT2JtYKCVbTw7I70puWtVtZ5/GeIP7CiVE0s5/h5+06lAW9ywStcS//?=
 =?us-ascii?Q?qjPvPkADHXWtw/oGvcuX5hDP90JvQqYi3+/arLgr6E3y8s4NOkLdKVyMZ20q?=
 =?us-ascii?Q?DwicMdoxA3SC/5TyDQbke0KWsuAPRGp8YdaC9AOPKz0HEkznJN5/s0rg2ixl?=
 =?us-ascii?Q?gwm2fi1kuRQvk4E/ZxWxqz9vKr/Zjz0P+Dc/UJZCM+mgpRlXJXOg5KtGnBWH?=
 =?us-ascii?Q?uX5Evvmrs3SZcZ8l2khCz2yCsYsq93qxM7o+/MGdzF1+N3qkb5yh4pI4FnQZ?=
 =?us-ascii?Q?csofnQVMEW9IkwPC/b4BNAXAhTTD51qvy0UDlo7LWnqex6XaBL7GI/dfel/B?=
 =?us-ascii?Q?dtQi3vbq6v3gNEC9clf7Uj5r+7BP/9ab/Ra2MPyhoHEnOgAfSfNIpOxpKDTY?=
 =?us-ascii?Q?Oa6MFwW6tk9FVcTdKWZcAEyUSibWNzm26YdxacHlXJqCtnG6QA64+4BFp2eq?=
 =?us-ascii?Q?XQhF0mfdF55r5BUwckfVai0a7wvw/1aRsAUbsl8ONvVEFdC0tVW+wAHcnP6a?=
 =?us-ascii?Q?E7mMCtmEJG+ZADzvelHV7Lw8c+F4tDVH3QabCsg9jFNAt6NLfkQlYgzIw2of?=
 =?us-ascii?Q?eaDQLwzsXAJyYiYCaBwJYNCpJdMYlSQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6f0ffa-c347-46b0-ed30-08da4da82dbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 01:49:54.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kAIuAhOAVok6dI5eh8gWS5jJKgK06Mh/WUgEYKbiLJ5p8i6v94WLHapyprjlQwmx6QHe6sG0dWFwLWFduWkV8jIfSdH1e3+ST3do8Ahc7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3933
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=672 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140005
X-Proofpoint-GUID: xXOqsXfYEdPcGP7LxM11rTEQaqupcTyB
X-Proofpoint-ORIG-GUID: xXOqsXfYEdPcGP7LxM11rTEQaqupcTyB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Doesn't matter to me,

What I meant to say was that it is fine with me if you prefer to take
the whole series through the phy tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
