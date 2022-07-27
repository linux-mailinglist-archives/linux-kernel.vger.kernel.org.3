Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9FB581D42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiG0BjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiG0BjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:39:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E743AE6E;
        Tue, 26 Jul 2022 18:39:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKnRXb009195;
        Wed, 27 Jul 2022 01:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=RoJkG8eQlIyn4UeC6DMLDCVrKZ7KdagzPEoSCgHXyU4=;
 b=J2RMsaTmylvylgITR35R+oq0pNTNsKrRUNVFjjgwbDzLEOvbvwitIeCL0mI5fzhFQYox
 ndwjaKg9uHPi1IZoHsEM+HExRoQWQuZkhZZl7NktXSADZQNLGA9o+pLaRVXExg4GU/yt
 GTnQ1r2tffcaAbQmBSObkx00XBh2qNT+nCozq7EufNBaYZde9ivJ6E2M66eVvqZGYnzp
 kZ18ylZmtDFA62QX2fichQjv3iqmP7PwP6gMIx31/bK7HJRm+3FVTvRSgI73Be7oui/Z
 3Cumtc6ZAodSrzLmDwSlCRs33IGsuq2qnOLMW0+LZNrjqOR2RLxKVbKdX88PNv+8aOFr zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anyq13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 01:38:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QNhMBT031683;
        Wed, 27 Jul 2022 01:38:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64sk248-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 01:38:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKuNh/lM21rprsJ+bSBML2hiV3DXgRXV5z9RwvxxIW79KTdJjZFLuh8+vPWrpFKy+7kikQuDVqZo0w3pyUiQVykGve/vmeSoSnvQ1s5OWiMH/DVdxR41g4AQqpGbXS/wNUZj6+7yc3QLCPXGwgbitP1JppSKVbJL7WW+fbCTwf2qZJCObP+NbRTleDb2Vz96vPfOZcGOk7tE4hzXEd2LhGiUzUJmtAXjvthde3QA+EnJZaYN5xqFUTH51m3YbKIHWadTtcBIp+yiSstAjNcDwERF+0kVCy41rtp2bOKAIRQZTGZDuFsbFCsVtLgFiRoudY4VPJTgdiw/QwL7MGiNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoJkG8eQlIyn4UeC6DMLDCVrKZ7KdagzPEoSCgHXyU4=;
 b=JCD5aBstI60kwyOHnf6nfFqzx26FYdaK9indHIwlNAVLsvsLYql8ODdzjQ/BB/2JC+Gxk2vtANgj8q1HjSM3IMTJRApNrbBC340IDnQpe/EzaS4JhG3SCTgyW00vhrYiJdm+FMH/Obx4sqySauZ0mqR/pcHDkdKQ61sBqb3cyWzOERwAP1DAJXfrG1rv7CA0JGUZmy9Rrav1Z80Ca5VPW2eNN0kSJNrF/gpbcQos29C+QVmYFcPI/yVHCZjpD8spPt5qdiyxRC+GadQanlfkr5uMvkrVnqaKjfbaFo/7IWMegqKz/mfcy8irLR2zhEpX6GXKmVfuHQ9eDeksodgj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoJkG8eQlIyn4UeC6DMLDCVrKZ7KdagzPEoSCgHXyU4=;
 b=q2sAVT3e8e/OIh4INfWe9uCLY3zY+4nEpkDwC5sXUTj3dJWu9gZWJZDh7TDJKq2kfXlAbFiYceezTOLOgiBjm77WaYAOzB1n00lyqlRA+lq/1qctTc+o28vBi6VUsGfIfwCOdPxzgJJwtVZIaYdyn0G5vlXZnfz8y9+DFcZ8N0U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MWHPR1001MB2350.namprd10.prod.outlook.com (2603:10b6:301:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 01:38:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 01:38:54 +0000
To:     "Alim Akhtar" <alim.akhtar@samsung.com>
Cc:     "'Johan Hovold'" <johan+linaro@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: qcom,ufs: add SC8280XP binding
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yjje3np.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220711101520epcas5p421bdaef157484ed146577e5deea04e09@epcas5p4.samsung.com>
        <20220711101441.4896-1-johan+linaro@kernel.org>
        <000001d8a0a3$913c2120$b3b46360$@samsung.com>
Date:   Tue, 26 Jul 2022 21:38:48 -0400
In-Reply-To: <000001d8a0a3$913c2120$b3b46360$@samsung.com> (Alim Akhtar's
        message of "Tue, 26 Jul 2022 09:25:35 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e8af4d-540c-42bf-c8b0-08da6f70c41b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqt48b53wr2X2VGl8hq8rFAa0TwZoTQPeK79VLLAoep7/T8fqmqrl5hBn9UbrD971jsCe6JHBG4r5/wg+TdBZlVarRMqjU36nvvtqAGllJp7CXQm/eqLFEFUEgOZn3YNy3VhnFiEIY/bmRE6RrNyGXj2PqdUdE7BU3G3m+/D4qxGzA7AS4G8pql7Z4Fo0NjM7Deb8NBP4c+YmChdWa3q4IvQw15M8ZQi3TRbFuqv2mqgfVoDcjTaGwm/K9Y5Vmv6fV0oj7SZmMHopls8f+h70IiNend5FXqE3hq+m2Kgxoje7YPfHAFT88CUUF8biftFnhA5smvjplCic2DsySJKXDbL0Ahhf8ZWzuEHCgYLtxzeuY3uG/nBA6KHkQw41IpUarqIlZ5dV81srPIwklftyL1mXwd2XPhRMBw/AQvksmUTlzGtbueRORkchkpp4uMTgsQvabi8AUDpQ/mhZydoLZMY1vi3YLDbms3VY1OvdynK2eAPIeUTCyuJ+19ZexjJnqqiHrkQK+zdgDrWG2tU6yb9zLVkFiNG6XHStmg67mJOJuQu5mqQBxbEMMeSzhnw518A47AYswplCv+HLa2koJ0y0iQXuzOjA0uRKo5OELSRIcFFZudTZ9nVcfWk8Uz5yityoTNu9/6o+GrauxlPStMj3/+c9XMizKKgE38WQpXu4PfPrKylAb/yjjBu6WbY9u9YMCCF+r66MnzRmHnB/YphNvZ0gisXprX7AG2V+VVRr/waGlafPUhQqA91U+IHK61TrPQ7RG+n5gpsHUeZ+7kd1Y4TylLXmsmw2wSUQuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(39860400002)(366004)(346002)(7416002)(186003)(6506007)(478600001)(26005)(4326008)(86362001)(66556008)(41300700001)(6512007)(66476007)(6666004)(558084003)(5660300002)(8676002)(316002)(8936002)(38350700002)(66946007)(6486002)(6916009)(36916002)(54906003)(2906002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TvxD68eO+2EDU1mO+uDVZ6p+vgVThWIF6YU5sImMX5C7tBrLGDtc90EBoGW7?=
 =?us-ascii?Q?b6y2u0BK9DLncjdLPh9M7QXQj/uqJ9eo3r1Jx5MkEXTCtuQB7wKQqYG5j1Op?=
 =?us-ascii?Q?DUVMun7oPtyN1wRNrSYUNwsjdHHDNSWc6EVJ7wocJZ/752Dd92nI1vbAgayf?=
 =?us-ascii?Q?O2STrT8JQXxx5CQA6TkOc3Q78X/9IHAlF3W3ny2G82Ud0RtUn+5alVgb6y0f?=
 =?us-ascii?Q?ri3HDDppK/0cPcjSjTVLy4kQ7aNHED3BHJb5hKquRm5Ml85NGhd44yYuJNmi?=
 =?us-ascii?Q?sYPqoHbOSzJ9JJB5gTWrM3HsaMshvEJPyIQGAIQYSbzXgq9mMvtSW7qp6E2H?=
 =?us-ascii?Q?558weMMYXDKuIv4gpeNLAz31oe8oMUPbtUA3rT/rhrKctH6OiGFMW/Xko+ST?=
 =?us-ascii?Q?nODn6uHuwXQasglFqqSC/IWyyarDHKFFx74sAIFLnQicLuT+5Hfl3hRDReFw?=
 =?us-ascii?Q?v8ykZgu5SDgmCPqh6MwNd9lIlH/CVM6LR4EEkXopv+lk8cUC7nj3IBxhGSYp?=
 =?us-ascii?Q?k8ULg8xUX2PxPxRHtnGvtfmqTuI2nYXOiwx8qs9B6Z7cUpOwhfJr4GsSQVHw?=
 =?us-ascii?Q?4BV8JINvK+xlbMp61bPms2/kYXU9pcjx6Rk6neVwdQuFcjdSQIixYN+BL/3X?=
 =?us-ascii?Q?j2G738oA5PeRETqAYazI7EcUmLGGPKHn5ot9xnq0VafFIOKeybUfIOG85Iwy?=
 =?us-ascii?Q?JAl7L6AxOdaI3NvCdW1/PG+trJfKwqyGmZ41f2poe8SvzujSUoKQqBDH6AQj?=
 =?us-ascii?Q?Wx/Zn/EXRrpd0ktaCCqfm3yAIiX68PebPfi5bXtELYR9HIDAkHC1A8skgaQk?=
 =?us-ascii?Q?3FS+XPgq6jRRXD9+BYtU+hP+65ePglRnr20Z7dZlB5tObJj/T/JkU0Yv547V?=
 =?us-ascii?Q?6UzCDZegTUvqPjZkV8IwnSRWHFUfK+tux0XvhIoPEs2U+qZTU78YwYC0DX19?=
 =?us-ascii?Q?+WtLHidE9Cmzekq1BNkYGEZJZxrM4TuZscapEZiUwcvnoLs8T5lOHZqxLOyX?=
 =?us-ascii?Q?QFRD4xO1RL4CeL4dSeq7TM2erGXt5qirA3wv1WxvbY++rlf3lK1139K0VBWv?=
 =?us-ascii?Q?oivRdjKdlh7OYE71504nxa6jLsjKg84xT4v9JHt4/nlLOYFiGPTkuXVFGadX?=
 =?us-ascii?Q?RLyXiiD6deRWh+0soIGiNhasQz4x/KPDU32q1He68NQxIMEknq7LjDOPmcUX?=
 =?us-ascii?Q?LMLKQfeCErtFO76en70sorgjEnoWDQHV2R0AeepBgF3PM9E6i96usJ65Rp9l?=
 =?us-ascii?Q?oY1wVC/hyZecz0RZim9B7rLBxPQzVqrQ/AhBLOO2gv+Fqu5gHehZswSJVexX?=
 =?us-ascii?Q?V7T4NztzuzqNma5VS+SbYvudYAnfoOwHOZdwv7HuaAZxpDhqz9cP9yzAp/Hf?=
 =?us-ascii?Q?JPAacNP9qIBwWRLv33zWSEa0JWbCeOgkeXT4ac95MkHjIZzLZpHHr+DlV19z?=
 =?us-ascii?Q?bUinSfL0TZZLyIqP2JRufUIqZNnti51HY0xD7fvC6h+MHSF3UTkREz040Gwz?=
 =?us-ascii?Q?tJ2jW9Nnsb0V8xtY3cEcVgCB86nJVQ04uoqXb6PKz7p8elLivCHBDpp4Knuc?=
 =?us-ascii?Q?0GzVSumXPvGd6vcMk+Y7/W9WXVFNvXIdrj5w2gzcJx3Gl0+Vm38OHZCaqtoG?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8af4d-540c-42bf-c8b0-08da6f70c41b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 01:38:54.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PmlPIYGbcxGd0nW+NeZQ96wjgzmw2XnniJUcUDpp+LA5gnhVm3vhX9bmgrHPCLmQIlHSX9y7o3t/rFq1KZNlQoomdkGH45BAL5ILEmx6oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=733 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270002
X-Proofpoint-ORIG-GUID: u7RAdII2osWsWGfaYY6mCdk2iwvOC0sn
X-Proofpoint-GUID: u7RAdII2osWsWGfaYY6mCdk2iwvOC0sn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> @ Martin, 
> Is this something you can take via your tree?

Sure! Applied to 5.20/scsi-staging.

-- 
Martin K. Petersen	Oracle Linux Engineering
