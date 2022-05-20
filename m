Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC02C52E12C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbiETA0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiETA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:26:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CF59949;
        Thu, 19 May 2022 17:26:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0J2eK017741;
        Fri, 20 May 2022 00:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uqn1tEAJmJUhTHPfxCuK6c8gu1Rw5h7coM4zseUIbUY=;
 b=YnnTf2dBAVe+xnxaZaWiFA3pvX69C0FRvOvFLDrD+8/OXCC9HSzC2WFAudf4vcu5b0ML
 W9mZKZxqp/X129VGP8ZvRFIU8iYtwe4KPq4k9IKXR9LFtM9Onxy7ZJQJdwGlBbNOBB2o
 K2z68rcbYJxbmzCex4lbjAhFBDY3mg7Uqg6SKcFcDXHBqrmUauvDiLpCsLu/mIk8h0il
 9UzgSArm1gwdukvI7aphnVfgRSVvbB8L63ZSscXyBadjz8aX6g0BSD5RJL8nhcy2OF90
 +Tr4IVrKSxefQpkqma0rpsnbOjmMBIxBo2+irYLU6MDnGh8H4yNmsWq7M2q0bjlgzOPA FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sdrrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 00:26:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K0Prr4026941;
        Fri, 20 May 2022 00:26:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5y6dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 00:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6pn4DlDeqcGvOd1pgVG+7hihCeilABV54sUJI1N62JnUpkDH5fmd8H56cBXuucX3vdluFGgwpnISXGTWRvCqePh+RIgDD/RehLaR1Z9/mnvG/oV4GmHb58OKyaRFPIPMEEghF6li9A9ChYjdV+zzHt5fy3Lu7kih0yF1lhgK9+G4cwHW7a3XA985V75uVVCdbVdwHEKvpnJqiONafErZbVuvSIRor7bBkPTJA7SMbyvUl2OZ1tXKyeQXktnjPY2Kvb2W4EK4TY8pDWKcnwVEvxAjf9hbQGSnIyKDEX9SfmJEwANLnDLHoherN0WmXtc3uUrsgHFatn1RWPwKR/GaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqn1tEAJmJUhTHPfxCuK6c8gu1Rw5h7coM4zseUIbUY=;
 b=SK4lqSySEFYW6xgI3ybGgL8IKzXkQXldkCIQSwgVE22ezUgfXw4iBPNUczQhvHiAL4AG5qAHLbSIWnG/MRFWpVoom55W3QNjW19xaupiF2endCdykSTJ5YtTcLj1AKR2uYUPaV4A4j7XqhqNxR0tBeXWKWxGGBmL9sPMfLtG+4LBrGENydniea3Qr5dtk2MaNVqRKWS920tpynASBC/TvDuI9hf8eMgkJjelOrQej5zredNnXrA/+6vXYhIbgZqaG5jXgW08PwyyQXpRvVKaNhe/Yu0JNP9qW5WRhVHTooqJsVhiKPOI2AhI5iXDg/6PYF9wMkzzs2wwZ8x/DKMuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqn1tEAJmJUhTHPfxCuK6c8gu1Rw5h7coM4zseUIbUY=;
 b=dvRLrcRFWuRKurXM/eDFXX6Q+f2dRV2QZYkBrqM2qP88xLJs+UYAm/J+Bjw8xKZNfWNnJEuuExHaf9Ih4/BMJNgh3TEtCLVSzcpO+0QKMVl9HxlSA4uZcZx3xiHyJeLZ+2ySduHUx+CShmq3liWxkvmFOzhPqS+5gm6hFh2rOkc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL0PR10MB2883.namprd10.prod.outlook.com (2603:10b6:208:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 00:26:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 00:26:37 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Michael Reed <mdr@sgi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla1280: remove redundant variable toke
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgjdkq1b.fsf@ca-mkp.ca.oracle.com>
References: <20220518102103.514701-1-colin.i.king@gmail.com>
Date:   Thu, 19 May 2022 20:26:34 -0400
In-Reply-To: <20220518102103.514701-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Wed, 18 May 2022 11:21:03 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:8:57::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73eb3e7-f8ae-4553-1e10-08da39f7665f
X-MS-TrafficTypeDiagnostic: BL0PR10MB2883:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2883D154CD0A82278CF2BE4F8ED39@BL0PR10MB2883.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8j5qpcqk/dPspTZTrLZ2M/IqpH0qJ4EcyIBo5ZOZc/aL2um6X/vw2l59AlkOu2oNL2E91PhSYUoWARkUnhAJ3Ao98n3kHK7M71kolvq9j7YldhxmtDttav1EmeS3QKQzClf9EkKO2ZuI5NEZwb5I7Gu0W/JTHgdgqAh3goGcGliAGB07QWPNIqeuppnyMpaeW2f2rE2m95YovX5dvplra3OKH05E0BEj6CRH2gjmASbKLAH4xiNFSdSLduOanK5/wM+GOM3RT/h26SyShDkPJFmfqx/chpx47NNlgysTjyJqq6I+3aBlenAVK4R4jQxnREoxeL07VWq/kKwee4uNMQXAkYajF/uNZBnsyxHCR85VWRt1MzlRzvLTqwNxrklQehM+GzHa9gMPVCm6AH3f/w26qF9lV+GnPm09uoR+zXHpm2tH1MVnWpFjB2tNfQcc4Vsts3CDqRPbxxOJ++Db6TIlirEKU+/Yku9XwZIhAP1qEyna5GHg727fs/7Gz5mCMiMCgMenDmX/HwcPeY62ZuL82kopz6iUhfi+uXdS6sIJIk5gzPR8TCJetslNNW/Bu7Gv7dSRGB46H8VwjyTH/WpdNHpSCEyur/oulZx9SKVucMQ55EzH1MNYs/9NoYG8wzXhLhpFS7Jv3tndP65f/RnO1IT6MqTh57n7au5JdDY7AL8TmBvRoNmN+mOJ9QlR/DQlx8deIRWwERMvXPQ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(4326008)(316002)(6512007)(52116002)(36916002)(8676002)(26005)(558084003)(6506007)(6916009)(66556008)(6486002)(508600001)(5660300002)(86362001)(186003)(38100700002)(2906002)(6666004)(66946007)(66476007)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RleX+dYgsARmVcTtt/jjTnLku3TPpolh17jTtYJ2Fp4fxs5mjrRvmPUKkdd/?=
 =?us-ascii?Q?gMjyGS3HpgFm0gTK+4760Xc6vWRwCXTh9dDjN7SUxcuCke54F2KkpBGkYRIp?=
 =?us-ascii?Q?9hEroMYh2BN1bX3mkYSdfvS24ubnzaLfN2lBRxrC7Jk5lwD8CNXUF+iQrvNi?=
 =?us-ascii?Q?6eJ3J47CQSLpm4ZFnYjxEGfFUaAT9sU0vOxljtIPG5oby5Jv+GW3WxHs02qR?=
 =?us-ascii?Q?8LgTf0k4CjNdphoJLcuWAeeVyVZplzbdXoTBTBirO1kamyxbkVoe4+0tHVOb?=
 =?us-ascii?Q?nZ4hMnFbaCqpKY99Dh5A4T+mt0aqf64vIO6IQQrftJ5bXMU+2xRzw6fpejqq?=
 =?us-ascii?Q?X3dctHVcEQt7N8X0zfzXqWKZyP1fmztUNJBasG/l9kBZbM2JZ8asJkrEM34N?=
 =?us-ascii?Q?jiNLmv9bXf4oAvRyNRuMtfR3sg7naifla5K87iqItiMSXPSkMs3dH1GBkISb?=
 =?us-ascii?Q?xs//MuikknzJonj89bU4im/47vcYlAEImb3uWFCpM7m5ubAngrvmTcRMAZ/l?=
 =?us-ascii?Q?CIBnwt0FnCJqFxPuPQ82HlobheBLq9aR2NGz54QQqRgumqbOdoDGNQwWZ/kQ?=
 =?us-ascii?Q?wQ/chstZmsvP01iJSEKUK1GwKtwBVED2bxeMEn44sNekaltltaZ0IdnzSuVZ?=
 =?us-ascii?Q?Tk1IXu2+XNaxD8Gpp62Gs5bvSYGdr4rGO7SYj/9PQ/uAwcRlEZSxNvu9RUqK?=
 =?us-ascii?Q?2V/MTFhPWu9bKFtU//bPdOrgRLi6E9c+k/4C/cjL6d40XXI3h0cPifxw75XM?=
 =?us-ascii?Q?7pIC8MsbkWgkAHWcbgYzhpx6rKJ+VM8wZzBaHZWntcGXZ2c1T3g2ZB3WX6kj?=
 =?us-ascii?Q?DGMNz5Gy+7p58NN/bCZLwAjvHUio6dknPKjftcbLm47QOzDkmW1iqYzyrLmn?=
 =?us-ascii?Q?fXFpa3PNe+f9yBoVxr8xYhaymFeulu3xtT5Jj8bM2jXsiFYVEQrN1tAJKLZ1?=
 =?us-ascii?Q?WpGyFqmPlHLXXlkMv/wAEureeoLxT0ihylrsY5r+Wj3WrRHsXUh9c+xlBAoX?=
 =?us-ascii?Q?C/jGK6+1/xaD7RXeu5whNI4fnH/fVQ+YQwBO4H1Qq8vxoCnhO9EjwGghkjrI?=
 =?us-ascii?Q?S2Yb1SF9RArs9H64Q3EFe0ji4uGcqtMVgKA08kcEPqnXuqRba02yfZIFLH5z?=
 =?us-ascii?Q?CxHU1tbRxx6jduwXDnTC5pUvaTJ3gHz3+N5d3Ubwd48T4TY5bbv0PqolL72S?=
 =?us-ascii?Q?46HZ5CQaE2B1jQWx1pNNZs/MB03nVbXWtFvUjMkCWO0M3Kp5rtiLb+naqL6f?=
 =?us-ascii?Q?aSnUjJ5xxLDmWZinz2/l+D+xwFpSkooa+g9FVDF45fkBucG1n+8Lydm1otsB?=
 =?us-ascii?Q?Vvq4zWBCQXrHTPgjPUZ+gOfiJ9usZIEBw+osiQi6EH1/TiA7EioXhbNQyIVI?=
 =?us-ascii?Q?0ywDz6CGa4GvGQGa+TdGFk6PWb0AusMFyRrm5dm/dRLzALTIMMak6MReSss2?=
 =?us-ascii?Q?ha6yxdGFUa+DXfCd7vs5PL9TyPlPWxkXfSZDOx3KlvsGWziI6TLsro7z0zYz?=
 =?us-ascii?Q?MhQwQOaX94grGasIq+EOTVZfugcY7x0Zq9jQruAwAkco58p/BG5RVTsKJoUG?=
 =?us-ascii?Q?3vmKGSBWpgW/oNJs4NVlBHX97Rotm5ajiJ+tnlPNvRhJNgrayNbcxfChtFP5?=
 =?us-ascii?Q?1ny2T/6dMwuZTrPSS6ZQR3C+H6LpIC+dUJQSDTPuWBSueNtwFP2ihGAfSuap?=
 =?us-ascii?Q?PePU4FQHWU4WpYTW+rsJLU7mS+YJl2VDR+O9aDj4j7NNrqE5N/ilKP2hpqnP?=
 =?us-ascii?Q?mlg2riVMuHgKDrjWNbQiGu2/TMY0Jw8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73eb3e7-f8ae-4553-1e10-08da39f7665f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 00:26:37.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63vLbxRg7vgkKSNA1fjYx5m5X7ORNLEeIHFXOlHsV91sZKiD0moZplPYZGNy4ie0gPpgUCB06ul3cQg/cp/MenUuX8u7LGr6mzNuz5XUlQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2883
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=743 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200001
X-Proofpoint-GUID: dO_RaQgb6WOyvV3O_gesHn0vDzYgPgGU
X-Proofpoint-ORIG-GUID: dO_RaQgb6WOyvV3O_gesHn0vDzYgPgGU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable toke is being assigned a value that is never read. The
> variable is redundant, remove it.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
