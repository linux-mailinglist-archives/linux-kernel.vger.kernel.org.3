Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD759CFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbiHWDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiHWDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:45:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA55A2CE;
        Mon, 22 Aug 2022 20:45:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNxMrC012486;
        Tue, 23 Aug 2022 03:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=1aKRsHzO12cP6L+DISyRRVuH3xG2KBqodtzrhuxUyfE=;
 b=dsMBSn7R17tiuJtUYPCRwoveZjRrkc/XOd42FyUxJKeSrrVMrI69TXzr9mGCmXAmsq+h
 gOyh6qyxTMljrH14hJF2uO5JqHuQ5kjGkI15cOF4T3N+daB6BZhShKFIE9V28bQ0MkCM
 V/FQMASA79xYnCU5wByMMGgbajF+E2M2WfJt+Sge3pdKdd/Xrdkh1tw/WP73l2+be6RP
 haP++HOsAJoWfpeyK6xpOCJGgCctqXctPvYABQ6FlOagygOJMBSkArRgkZ+81t9EK9m0
 CEsHzErg+W4mpPAR9HQWHjLhLTZObsPG7XQXufBz6lrn4GOre9bp4yab1+biFASFbyzX 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8cs0es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:45:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N0GEjP005102;
        Tue, 23 Aug 2022 03:45:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn4dgf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEWiwTVsL9CHR6qIyJXLfsR+/9dr7cX2BBItinYKzLYozOi8gV6Onf4uS0yV4uzBAR/S9AlA1+ccdLcA/pdm1mw5gp1x4DwFU7TB0QPb8J0QuLtqCmALh+QDz3hSp+sVqZGza4u0V9gtBuexgRE3iGl+6ktqNYTeovuSfrPyEhR/aH4n1Md38N3+xdSGo/DJJVX2ipdIx3Flv4UOC7tqUqstYwbyn5jd8u4LqZqSTQ4N6OazLwAVaErOm5bOg7eHQumKnbw+JsgJxHzP77T9LuuIu7ROvDC8zaP4OgBFwnjamhEMYDCooHFLL2ClooKXex2qG9ox1fsMywbSYe4Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aKRsHzO12cP6L+DISyRRVuH3xG2KBqodtzrhuxUyfE=;
 b=Y/MoNSl/Jo3QO3wEp906H0wAGM2UnSviPrUODysBO5AcTCv/PiA1t/uUpatzaTYfE5YqXNztVMN7CmSULfFpMt/swwLTCihwX5BRwNiVlMmz0SeGZkFyOOAWegM3e0wtHHmdRs/FkAJOfkCdkes4e6Z0kjU6fcNmMNv9WFW9gxHF97fTou5TKGeakZ4GDp5NNfBXrZV9hj93X4kNdhM75w7t9ESA1Gl5yYxRttTa5/XvDzCw4pEwTtuQMhv+aGYq/WT4DNRFMuuVW+uSdaBuHin4txHWmsK96EMeMREWznnjZcuMTxVuAOCFv1js2abRHjTjMxhLXc9weLhYkZ8Wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aKRsHzO12cP6L+DISyRRVuH3xG2KBqodtzrhuxUyfE=;
 b=nwIv59xV71a+nVh0eprKyMyaCrqMlENBPsQa+Ztv7yWIQcyZfgUdQC6iMrYq7g0EnDJ4Y/vQnDLCLqEgNliSN3RmsI26q9sGhwHlzpe6jqJdOF1VZca3vD6Tn7OaSt9WvpKdNKAGK3NLVsJ2C47htvetUT+xHvakslagYi2pF40=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 03:44:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:44:59 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kai =?utf-8?Q?M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: st: remove redundant variable pointer stp
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qt7aaj2.fsf@ca-mkp.ca.oracle.com>
References: <20220805115652.2340991-1-colin.i.king@gmail.com>
Date:   Mon, 22 Aug 2022 23:44:57 -0400
In-Reply-To: <20220805115652.2340991-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 5 Aug 2022 12:56:52 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:806:6f::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d51638-25a9-4c2b-e813-08da84b9da8e
X-MS-TrafficTypeDiagnostic: PH7PR10MB6130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yy9nqwSo0VAHzPewDgZ+bZOYMd3ZEy+TpFBjHARFXpEOi7/2XagvEs0UwWfRlk5vRCyNZH8YFR7UeCdq8pwEmxTIFgy86pCgjrE8T1NTtUvRyP9O+9NqzPsqCwOigJPsUq6HIZ5sLnynnfG8pUJe/uJ2hfbejAU/9qoHzskpShVUk/n1bgVPInR6UVEF/QzADczfkV9IhIda61Fy6vt0EDl+drCwIsM7vRAoe4PE428NUhWRNwiQ/jrK/SLPyFkLcgt3j3sYEvPrycaNjq8DgXuEeykm8drdEPhNdwh+IdIXBQUreq+AIfZq9WCi5fFkC+/GA1UxByMSbFHMIVDRvkJmaMX+623A7IAKu9dAA0qDyHYSfU3cGN9A1hy8+axDgTjWE1A5KOWIKPH/Ow1iTPpgPXaxov3CbQt2FKvzISlLlrKSQ0Pd25iK+qejhzuHe53WB5F10jbd/mn0GuR11t5zLKmfiLudyloPrODrRMRIrX/dw5X99nvud/QSpVUvdS+ZNWLXnjYNFJXWxZ7NFUUQ1CgGFqf2UuBOTFygenKAQxTEe16/AsXVJ0Bo4lkxdQXxCdk3QiOX1+Nng5LX+mOEIyinoAbGxo+07Yk85x2DbJnr3KuEudDBoV4XtbX7V2C4jmNMW5Wr4WPTXFxYA+CF/Md9zU/bkzZDHmbA8XB+SOLppdJfhp+o8WdrC6ri7ZgzIfniHqA17Txs5I9kd64I4Fz9OFfdMVN40FmOT40oAgXXSmMGnkMvmT5tNa2QDZbhvCSi8VHMymn2FA4FeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(54906003)(2906002)(478600001)(316002)(558084003)(6486002)(41300700001)(6916009)(52116002)(26005)(38100700002)(86362001)(66946007)(6512007)(186003)(36916002)(6506007)(5660300002)(4326008)(38350700002)(66556008)(66476007)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/UOIT0S8oz74Y0pEj85/uPB+80u5XnCQICXDi2r6IylsoxbGNZO0BohcT1q?=
 =?us-ascii?Q?lfXX+Wf2e6A1oJUOnsisofkjhrBLk6GGTR42SIHq9DUTG9uFG5PpRcaQL21P?=
 =?us-ascii?Q?JERBdV2kLCl39bSuvrwjeGM0X56TVJ/vn9AB4p2sXhw1zf9FzdzU3b9Vf+wR?=
 =?us-ascii?Q?glbdpNmJWV4pDeWEChgSbMgsUAQIT+x5SMfZC45OVNzsbdhIIRfREHpNMlTV?=
 =?us-ascii?Q?edooDhtyO5hHry8qOYjo/UNxGL1YXzI6QDEIKiUSBO878pnaiFL7qIk08uw4?=
 =?us-ascii?Q?93WdBnF03/EaI+PTSUFcpcotGNRSNWBR5ItILJRLA8noBbtC3b6OGc1wW0TI?=
 =?us-ascii?Q?+lf8Zc+qMhsHO3EjlRCr68lhdlVmI0JaR8s4q6ydEzDqXTGvfb8lIw7DSy09?=
 =?us-ascii?Q?EnODfbgtLxkr9+tfAMAq46jGgDr5+USK5vdX7qfypWdHcRqob4ZpRXwtpEMw?=
 =?us-ascii?Q?n0p5nDQ563zmLMALoOTMBkiTThnq1Vapx3MesBN6Je61wILevNlAvVqzhCUM?=
 =?us-ascii?Q?4E9vEYiuBid9qAkVIox6t1J7d7CoSJIhDwaMZV2jpQAuk0p5DDZaFlz0qSh1?=
 =?us-ascii?Q?ibmZejsGB1VBxANpuujor4sSKAjfnd8SxwYzXDINNt1LuU7WWBoJBQwznoPj?=
 =?us-ascii?Q?NFVGLo+/g7BMdlJE8inPx6oNimTLkSiKGthhQIL9+e5RJ8X2n4NdHCQklYDq?=
 =?us-ascii?Q?pUehScQhqwk/iqo6TdN1ZMjHFECavcMTwegxP9KMOMIrUWTlaU28vCcS5mie?=
 =?us-ascii?Q?BLuJ0FgAfXY8nGK7cwkshn4cpw2iB6aa9fvofzgA0Kviu3kAMaL8IeqkLMHh?=
 =?us-ascii?Q?XZGUZBEKDDxvr3egba2cw6jvZyAaVBebXtw3JtmwLFOwE5SIuChBQmrga9xG?=
 =?us-ascii?Q?Xw2s4ohF0tvBAc12D5lGo/kxj9mKmWwY60/LvdsgbpszelVa3eUNNWynCRx5?=
 =?us-ascii?Q?QqKAHnIwu4kYi+wTtziWl9P2+4bPuzfDttZC3PipOdoUElGGpqhlsgp3bYeB?=
 =?us-ascii?Q?o3WYSwkkc5PA1LnjVoUH0shLDH2p3b5I/F5cnR7BM5F4ervGylraHusXRG5w?=
 =?us-ascii?Q?DX+iPxeP7zdtDC29BJZxxKWKHOccq9arM3xclokbaicn1RRgU3wx+sqKPeIe?=
 =?us-ascii?Q?bEQPKL62zrFkXRzj+slQpIL2yuO/UM4ztHRKSU4If2xU5dyVEy7mNIGJFHfN?=
 =?us-ascii?Q?ASRDNYIhoTDXkuBALOgRdTOrChON6gvefElhbqIoMd861VS5yxpX3AHT4X2q?=
 =?us-ascii?Q?tGqXWDuWGuaJ2no7Cf2VsAORvOxPL+FxJeOEXWVO94EHhEf9csnuOSMgtikt?=
 =?us-ascii?Q?WWLecDxDTyJ8PTK5NaO06HCt3iy3Q3JPWqm6LwnaO22OEhsgFMRZpTIS03O9?=
 =?us-ascii?Q?aZrMhDG5p2ux5tVIb0coJ9wq5MzLLDrGclD4eOQhBQ00mN32Q69eO7iZxV94?=
 =?us-ascii?Q?+0TQebDl0DNIynrw12ieJBspP5AsPmicSMQxt9aLongsg6LuLeFQi2nGh0zv?=
 =?us-ascii?Q?sOXJM6LOlYYJhDP/agaIxlViHZmNhtXrSgzCUl7wArGvvsr42JS9FcEwncqW?=
 =?us-ascii?Q?iV0ltsdedqLj2jxZSKJOCOHTl1o9jbKcohfgiqnbVFVmm7ljsz78s+a2gJlf?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d51638-25a9-4c2b-e813-08da84b9da8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:44:59.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgJmiIxpVtL9Ldt+H9QAhPr3YUj6xxmqctPwGxlNk7hCad3uOrUc+7GdRGtL0HEWfUEZ027rD8Wi7jnByMLc6IfZY63ZwDU2/wjNSxXM76g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230013
X-Proofpoint-GUID: dwAAn-uHPwB6x1GP6clkkMMcsKTi7jQX
X-Proofpoint-ORIG-GUID: dwAAn-uHPwB6x1GP6clkkMMcsKTi7jQX
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

> Variable stp is assigned a value that is never read, the assignment
> and the variable stp are redundant and can be removed.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
