Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CEC484DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiAEFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:35:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44588 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234116AbiAEFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:35:02 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204NiKOp008809;
        Wed, 5 Jan 2022 05:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JDnkR77hIKdt17x3vpPxZQgUyqZU45buyEgu0Zmy1CQ=;
 b=OjE3zHjH9V2lRuvvOQv2ztRG+mYPhG7VHfKPpmSOxEVU/rvsjJofPupUuSD7MhfsJlNY
 kIyPPJuiqDsFP7TsAMU32ajeDqhFyLtR4lPM16O5VGrLqsHmg4j1mhg4VEPSVVr00fUZ
 O76WyeI1yGgGsZIase/ZPocOsO25cH1eP+5S9yo/SQ4yxgjYWm1YweqbuEig50v6FpY4
 nccqi/CZtnoIoqjyjgBiL2Fz0hbmAYriZ7hVPuUlnB3E1YnPuOZ45rl2TyLyCvStEW99
 KxBFaGzNqTWsIozXTbLrrbNXp0Ks2k49Lps5Mqh797ZXSA+oPJYLBN8ll5vw407mzLC4 ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4kyaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:34:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2055VHBU168404;
        Wed, 5 Jan 2022 05:34:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3020.oracle.com with ESMTP id 3dagdpsxt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N20R76/oH/aHrIfq63cA/S24q0/3/ExuNOWFIymO2055bAwvSJZ0DgRTmzjts+Pdl7flEnUg3eJTHdo+OAtnj+asyd1vEFTymxBeWeC3XAfw9IN3LVAoNCic+fIYYu5Qhieg1+JIXmP8qTnNYfKSPzdjc4X4/FHnbNYtWiQ38mps7hAa/zKd2exwP782mKYdIqpuNi+BQvzIOUJa1wCdD1Bs+UgfYO4LH0cbD7b1Jp6NXSX3K1JJk/tnMYz9olmmOcd1K33r5qSzk+OzDNVpGcZ3rfBMhJhFfnDzksEIdz2DmMHsM5mgjermjeKMfoA8TVrk4QtTaXc/GEzt8UDjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDnkR77hIKdt17x3vpPxZQgUyqZU45buyEgu0Zmy1CQ=;
 b=Mir8x/L/dI48xahCJWCzeRyoLN3zC2XvYB80LtrqouUoSlneHX8/A3pta8sUrugfEddB58nSVDCJxhcQSmtuXiRGjGGLluHkQZLKrKHrFaNzZOjOLQY2Oeomrc1ZTNljZgdENAO2ZZk/FbNA6D1bByv3F2lfegGwN87GK06TgfMOJnidEIlz/vAyWfufZZOBnSNc8YDRNGeKs7evTHcsjiJcF21KOQzho0c2DtCo/hotWSkACdd6e9M4NFAGxSr+HoIz39coV1Oh/gFZtme8CBhO1niqdZGqmfyoHCHSqFs9PFG05BulqIT0YXcF8dNfui1PTgZNHRP/Ew81wrMW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDnkR77hIKdt17x3vpPxZQgUyqZU45buyEgu0Zmy1CQ=;
 b=b+WfPY939r4L5yuHzAo+Th3W9mxr/ny8MKsDYo+He7D6lNfjchVPgLaOfh27Tp8qgMLxILOshJ+QvoxawydV2kNR12Wvd9AcmDcO6eH6GdmwqHvrGLecImNIwd6MRsX3wp4unVLjW4/v0dLWlbbKs+rST5rrEUmaYiV+zP6iWFM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 05:34:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 05:34:54 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     martin.petersen@oracle.com, sathya.prakash@broadcom.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        sreekanth.reddy@broadcom.com, jejb@linux.ibm.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: mpi3mr: Fix formatting problems in some
 kernel-doc comments
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rvuzqx7.fsf@ca-mkp.ca.oracle.com>
References: <20211231082350.19315-1-yang.lee@linux.alibaba.com>
Date:   Wed, 05 Jan 2022 00:34:52 -0500
In-Reply-To: <20211231082350.19315-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Fri, 31 Dec 2021 16:23:50 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86efca5f-9936-4b87-64d3-08d9d00d1a1f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4791:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB479119B24D1373F6DA6EDB168E4B9@PH0PR10MB4791.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMfWiuuqybjCEI85zpzPP7Rg01vzngm46rbkZPn1I3DWgM02UVI+dc+Yc4+1+tVgVI2JULgmO3QjRdt7UCOZaisXAWPe1Hmmj8tnlmQTTbWBTVjMvb22LqGMm7Yp+NF3Edh7rT3ZeVAhjgE39sVBKdSNBz4YYDAxo+5IMnAi/Q/gdGsgYq7oxB5fCa7awZB/mDQ94s/1TqzfyARMORjlH5D0xrdJJGPrmcY5Egy8ZmLlZvDEVYPT3pLF8pOkOrmuiHElto0wcmHDAisue8mgfKi/oqo3snlv24pRAYu8ZgJC2sd5bNjXxa8u9QkwDsnNn9UqL+XaEAcZ9qSeN7j3MCvOn+DDoCAJqWsHo66MNlDfwfmjseqIZgdjArMgHt4RXnxqV5n884kWQg09H3n8Q6sog7JhydZXsJlVWFPOvpu8QwNd8vYV9jLF9RUQeYsuNhznh0fcmuMSLp/oxJNTWObgaJUpfyiMnRlqaTt2078EroEG11H6EmmUzxYFW1q8vzdcRSngLcvgQsr6uzVjH1qcgzbUpj5S24JKHTp9GfBb+98ecEyEP2nPWY3Z+GuDExmyrmnl7jlv3pg9X8rYNjKa8Kp6Pvg7xNm/jUxDHg2Us2n0nUNwxeMzUdH7wspM4l47NO377rp94ZbtJi02bEq25Y6mk0zpD+i3ovWWuDWZjIE9JYYp/d5y1+D6JmxgqrtwrsYtz6IESqOt0AhuZvSeofPCJafTEJ4z7uaJA/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(26005)(4744005)(186003)(66556008)(66946007)(38100700002)(38350700002)(83380400001)(316002)(5660300002)(52116002)(86362001)(4326008)(2906002)(6486002)(6512007)(6506007)(36916002)(6916009)(8936002)(8676002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRhG5Zjs5aiVJqLwO1vBlujPAosQd9C7Fwcrr7EUOp8bVhTU5/soBXgRMM67?=
 =?us-ascii?Q?NzuI5LoKb0PcEDyZC0Ku6Kn5YvJw5zb0VFhYI0ekoEUlalQTG21xnFFi6gsD?=
 =?us-ascii?Q?pYjWxWR+sDiQCM0QQ6LNeLy6aGZkRzbdJy4k7prptHtPbI7w8fd1fgpK9tuz?=
 =?us-ascii?Q?U4N150W4CTvTMMHs3jYdwf0xrbwutzHHjkbNc5a70BLTGST0wLTjKaYYxfj5?=
 =?us-ascii?Q?JeBCr6fhRdlrPmZw9ajXiU2fQ6nN6z7VMmJWDPBZPIN8JjDBrjS4A8gE39py?=
 =?us-ascii?Q?Afx29pVmRlyYiJrskO++/Zq0PNMuOGQjo+nw76cs3XGnX+Q4M3pAXOChzEs0?=
 =?us-ascii?Q?BUAVOzWCFfaYXU9sDIPRfXsVzfG/Uhyi08PKgPjg3+fB28yUJUjgq7uNeUM4?=
 =?us-ascii?Q?+PqNkpf+qDXT3P++Zp1wAoO1rndUkpUHfd+FyNGyxdRlOpe22uAIikAsP9bd?=
 =?us-ascii?Q?kYvAwDeno/T/4QtJHcX7og+weW9jw5mR5xl7VLtyMqThu3rMemN72XoIBYkU?=
 =?us-ascii?Q?qPO5elm7CoGg1zmrHd41pHXzM6mLUlUBcGGtF41o28789ZeCjB1MHQZvGx/K?=
 =?us-ascii?Q?fO1Yd6d/KKQXoKvcf9AJkizvylv4kI/qitZUc1c9rIWEj5XasVcGD4482zeY?=
 =?us-ascii?Q?xsn9lBwRdoh/n1Z//GbTeWDVC1Fo9831jiOq7Lth1z54OSzRTGVzIO3hiTfK?=
 =?us-ascii?Q?qPsudMr5XheJP4BGW8sX5SiSTV3qpXkGc62gctmgeBnXDt6oFRB6wvSUwuDt?=
 =?us-ascii?Q?4w1vySwiuLccn4W9fF3xab4qpjT+xrJ0DkGIR35l69uIyjqv/OMctabSJRrx?=
 =?us-ascii?Q?uwG5+rk+ZgaQ46ZFakhRLZ5vsnWcDeTyl0mtTPEVv8s9MCIHaeZE9jDnsh0s?=
 =?us-ascii?Q?fT7wLVS76TLm8OXetUgGSiedSOOkuBFvDN0gQpi0hXIBR3g0t3ZLWZd8CZqS?=
 =?us-ascii?Q?ylIrycyXvXsjCd+8A7KbSkCrkQFmF6O/8go5X9M3yH9o2ggxFK0caae3uBDi?=
 =?us-ascii?Q?eEFfKZYKqRAYd5zHvLKVWUBIoIOR7uKBhs5F6xdFSWlI0eNMlAzHrVF5Orqf?=
 =?us-ascii?Q?4fBS2Yulnha68mwtzmo4RdkvsvtYL+phTiMkC5qLZJtMxMOgpx7FQo7XXaUw?=
 =?us-ascii?Q?Lw1JjK12H9eDVNfymHRrLeO+8n9u6zQZJgFr6VJ+YzU+79ps8oBx6ywEbfga?=
 =?us-ascii?Q?2aoFet+J2qeNQGTpwkVhEYkWpXRsgW5Ntjqq4R0MWZbMWOmg297tub5YjG4w?=
 =?us-ascii?Q?+M+UaPGUf9SDUxUd3tb4CtbKi8l00IV9mo3R1ZKxnz/gqTq+LG24mkL8YW7x?=
 =?us-ascii?Q?iRZpxkmx4YRXtAnslza2umkQ70NzgYtU0orAw4P6w8LcmYVFvhA9/2zg354B?=
 =?us-ascii?Q?wc9OF7qRszEd+rDnUB45pqF+Zhcf9C8/TME/su1Y4zayxSLPmNqbMlrt2doq?=
 =?us-ascii?Q?9t0mNBpej0egjWTLWiFIKkWB+MutxpZ/853VkGOZcHqOatG89QfsQWAE6lBA?=
 =?us-ascii?Q?5uyRD1SknLA/K0joTKbN4nPmMJKl1CvFzE12FqWqv/9TzZ6RcAbwW1ZhJZYD?=
 =?us-ascii?Q?mWCG7S5Gy0G56ReVCe/zv84ARUxNEMatS2Wxhbd8KD6vr3UKVMinINg67Nhj?=
 =?us-ascii?Q?D7uZYbv7nv+e2+SnVgh0PsOiSkhaQFpoiR/iGQuFxnp7n27DjHW7eqib4I55?=
 =?us-ascii?Q?EMzLLA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86efca5f-9936-4b87-64d3-08d9d00d1a1f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 05:34:54.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBgLz7hf0irIWymMG8IzUoeoNjh8uV2DpZlDUpBOh5RGQfvSywDCRiHKLtSHiZ+aJYE6HQr8kg0AHKVKeBLtnthfczk+qaI0Q6d4VdnD2ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050036
X-Proofpoint-GUID: EGpPDXlLbyAXTavPbGM_pK0S4H5iFdcZ
X-Proofpoint-ORIG-GUID: EGpPDXlLbyAXTavPbGM_pK0S4H5iFdcZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> drivers/scsi/mpi3mr/mpi3mr_fw.c:2188: warning: Function parameter or
> member 'reason_code' not described in 'mpi3mr_check_rh_fault_ioc'
> drivers/scsi/mpi3mr/mpi3mr_fw.c:3650: warning: Excess function parameter
> 'init_type' description in 'mpi3mr_init_ioc'
> drivers/scsi/mpi3mr/mpi3mr_fw.c:4177: warning: bad line

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
