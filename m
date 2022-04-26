Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5A50FE48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350611AbiDZNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350644AbiDZNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:09:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17CA60E2;
        Tue, 26 Apr 2022 06:06:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCnYlM025368;
        Tue, 26 Apr 2022 13:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZOr0ykmKZJ8h3fQ/M+NOLcIAeWkdaiLWzASxyt8v23s=;
 b=dFFZDTZctC+X8YTmoMJm6wCZTXE2Ere8jumphqNRatBZ5edA+9b9mW6ywT86YIxNZtgE
 /QKqjkgRoBrCmB4Wjzu+7sCnzJd+pW5xuU4XHvz7GFqWE2wMD/83obikXYXhECliVUIt
 0tmvzQbIqFmVJKqWAqjpZ957zWVzDZDqZqDAmC4VKhIlzVkK5A8q5v9MFDrkH9SJhm1B
 uijGzKW8u0o9xxwHY5Ojq2CcI+mZ4vT9RFUDlqiNSyk1krvj/JRQJG80lM/VHiVamilc
 lITCdz5J7qRw8YYYQT3a9e40UmXUxZflvh6PpV/UXEfuBjbFVnlFSCyY1hrDRDocfGXE hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mp0h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:06:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QD5Gx7028994;
        Tue, 26 Apr 2022 13:06:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3bue9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+iaJTRoM7fgvtDUbO0T30mWHe16TWowojjGb8PjlTp5uIa/HVLTJklDiwdt7KkjlwJDW+4wVhDH3zsfXeb5zvLNXRvqiFAGf1RjbQ+sVvX4aH7eFJhGPOvIcmfgqhhW4lTfMbA3ZkUZ5YRGDiKirEXx//kvBs04hkALbaH+kp71kgKHcudsJbAA5DqFDpjUuxn8OzkpCxcxxrNm7Qt9SoD6HENhgQgaak7r/3GGyf24A4aMv+UWXz1foq/6q0F7DTyOnQV9iCiTE4jZXHaeH3vEJ2bbNJ8Q35Ovc9HzgFcFNx65gfjWc4KjUwal8b/cx3nCzCWgzDuJUpiy4QTk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOr0ykmKZJ8h3fQ/M+NOLcIAeWkdaiLWzASxyt8v23s=;
 b=WEd9x77UW8SpbskDukUV67Mnjaly1cfJc5vJbjvsOlCg6qllnxE5c3tny1fiEcFT5aSkMe5clmrpitPv7KzlvCTmjyeWJGacNZtoDCFcrxON/YL1ReinNSkBN3y9vjdS0Lknhp7VvWiRHR9oFllhFPhWvC0+NEfe5VsHURIEUy4idt1Gp+8NufI4HrR0wZobh3zR/tmm4lr67k9XOlmU1moxfwbH6sSCZBGD04jKTlgnYaaHlIFC+zDeNCI/GCJZgiCsGTRekY4K26TxCvVv58O8yUVy3/sgtK5GQihHT497rDPgFQrITWz+Y8T0Hqloe2iedisvk93jCuKElEVBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOr0ykmKZJ8h3fQ/M+NOLcIAeWkdaiLWzASxyt8v23s=;
 b=WjwT4BiGOvwiJytQmPktcV+ooWTzaDs9SAZJjZ4fwjRBHmNDvCxVUnIWHRF7Wm5vNu9hjV8wO8XAji8AebThfacb31ny+yVPesMQggXuLck5GHJR76T4W8oVFSxQ4M2JzFry6xIKjZEGwPsnIMGbPyZ7M6aRKS14VYgLk0w+aJU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5000.namprd10.prod.outlook.com (2603:10b6:408:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 13:06:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:06:23 +0000
To:     cgel.zte@gmail.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] scsi: lpfc: fix error check return value of
 debugfs_create_file()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8uwro3h.fsf@ca-mkp.ca.oracle.com>
References: <20220419014526.2561899-1-lv.ruyi@zte.com.cn>
Date:   Tue, 26 Apr 2022 09:06:21 -0400
In-Reply-To: <20220419014526.2561899-1-lv.ruyi@zte.com.cn> (cgel zte's message
        of "Tue, 19 Apr 2022 01:45:26 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bceac44b-c737-43ac-b3a4-08da2785907b
X-MS-TrafficTypeDiagnostic: BN0PR10MB5000:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5000FF60EFD346A8F87860F08EFB9@BN0PR10MB5000.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I06xUT8k0nDO51sz3A/LbNWuUnRB7UTIfyLDuURNdk6Xaro0uggGI5m2LuwQv3dWhDuTb9ch2uYe2LtOD9hgWbJeG4OZjgWHEZTR+CZPN5+LOZO9ESu/N8oRajI3EjwrdbDvFrWQ4uwHWwcA2rP04WK7fp3XVzDpVxnYkbA+zOUG4CG8AlT7WPoZYbGF8t3Yww4jgLyDDSm0XayCjG2/cBBliTa/ibQWMPTd4OFEt6aUCZvWI77x1O2rxrAkogfEIo97sgT84yevNjTEM92mN4vodvDBQ6hrYM4NO8G47fVBi5O/mAzgeG7bBHyCkgf4pr7LB8LqABSwbe6UaJw6l6MxS63v3JQfNwsp/r7QO/sc2Z/bzzu9vGarWQl5uVWkPXY8UDZibv6dmGpCtYBUDKnrlAw/wsOjxf4PN74uRTqoK++WqEQ6l0gW4sbRnm5pqDUiolXqPAHlUjBgg1K+uidyEBCPVF5AMdKypDKXue+WFPhOA8PlZF44Net+tp1jHvMYYxfkXjaMPNLyOrJkZyUDq8KBYRGEsO4HSpk0hXDoY8fTPL29a+A1dAnm3pu4ECZZrydSb7XS3DaPdsXdkOJPti6FM7BjevKK4ROibZcvG6JywM64OhUShDlg8KKWmMQZliD9nDviRMbsWxuXsJZ5pVCD2O8fc2NgLUFKMVuNc40VsNUkiH37+3RTO9QySRGtaYRf7TRwrGTI53FpvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6486002)(54906003)(186003)(508600001)(8676002)(66556008)(4326008)(558084003)(66946007)(86362001)(66476007)(8936002)(2906002)(26005)(38100700002)(5660300002)(6512007)(36916002)(52116002)(316002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OmtQS/BWrMCIJW6CHPf/uvEOE80ui5l0i1LwPNxcwREwTAjfBls0VbxeY2AK?=
 =?us-ascii?Q?ta+7dJX/FkVu5sF1JO6pVXWglGVrBxgpWUQWxdTrtveEmAmGQ1BA9+2mgl7e?=
 =?us-ascii?Q?0aJz/FviHOPMs6LXsmhOYFfPYjCHTYtizg8eIZVDVdqO7vkDCYWX6Argodkl?=
 =?us-ascii?Q?Rzquc0QBk1H1l5ozd4GtlWjABX7NnXeGN6vaym3iH7lGy89dfZVWV879fDpJ?=
 =?us-ascii?Q?rxaeMST+NuZjlLBOHHMjJ+AufDdm2Zujt5kQJ3Oxpllu0ZyguJmGwSafD2Qp?=
 =?us-ascii?Q?UJwdzgi4nvB5nRYV2MHAYm7smb1D1vGtk32UQrKg7KVXEiE3H0AX1yzxxRPb?=
 =?us-ascii?Q?HxgO17p3QdB0Lq9HVJfskcKjx0fpE2A9DsBa1/ni12x1tPaVWp1wLKEO+3Vb?=
 =?us-ascii?Q?sHxyywZP4e3o9vD/UMJa6Vx3Ar2mwg0HFY8BMd+tjqQdd/HYYZQ3D8Rnjx/U?=
 =?us-ascii?Q?oti9QTMJfGEz3JjdbNQhJw/i+LlO0RcgdqPYyL47s9gnHJ4gDlvjetwMpVbK?=
 =?us-ascii?Q?2r1ktL6fWyK8vlZyZ0d+by/8ICO/o/bT9Y1kuv1dvveZtpbuJodBFx6aEaEp?=
 =?us-ascii?Q?E40+JXI8AmL4VxoSn2PKcMDVyM2t9raddIJmtJxO+LsStaJ7tmgFMwtPML89?=
 =?us-ascii?Q?AcU9//qlupXhIf3zef4QDF13uBJ5kuJay2wKtovMSt8ZVRhfltW+WFlJmA7T?=
 =?us-ascii?Q?GS3fDsBns3swVNvY2nW8xt9g2NGK40LfYuXObnUB7n0GSo+reVJac/tFEC3g?=
 =?us-ascii?Q?55N5xEu4XcM6NlReYYd0gZ8cPY9vCj3MCGwhi2usJ3XI3O0TilYPvD6LsYTE?=
 =?us-ascii?Q?LsaMytoyQSpejgjrV0ebbUShlh68yuoOASuNbn8jUrCXpZIKYFxElZ686P4p?=
 =?us-ascii?Q?Wgq4nsk/4YjZE3AlKG0Kx9gk+QWyvfFbIJPqEiieyZVxGr1YPXS+G32HgYW5?=
 =?us-ascii?Q?U7wftTKuDeO2WAGOINVZom8oX+X6Ue8tCbI24zQGgnG7AtPxNalIV1u4iWlM?=
 =?us-ascii?Q?D5bZgo9ERl29sLxGKUdTy9Xqm98oJEuSja7vqqVFre84xEmstYNKcJCo6e3b?=
 =?us-ascii?Q?SFcXiuI3ULdKakivF+jQD0DPO0ttlGZ6fNZJB1R/Q9UZHz/yWkQIBNBFPPMY?=
 =?us-ascii?Q?Pxp8CSTfEuN4mnwkamMR7f0tWx69G+8YJ6l0N1vyYuw/iuN1rzFAjKnw6nK8?=
 =?us-ascii?Q?IbYCaSl4XhjO1wt0JZekviYutjNPjriucMJOZUbeeE4oCEgimKaDFrXd+wz6?=
 =?us-ascii?Q?K9Q63F0aScHlqpzot5kdvbTGuMd0g7yzLgTisZ1WVvdPYsv8qgoYuK/27jgK?=
 =?us-ascii?Q?c3sURY5J+Z71cPPkl+nYvijZJ7ywkKoDI9sB3OImAWlFkmgH67D9vRNWvzXv?=
 =?us-ascii?Q?TAikQyQuWq7o8SRyL6woAaBFCwMCNpYfEfae7VReiIxbrAyXNN7eTjkzmd9p?=
 =?us-ascii?Q?d5x1BXz+sVmkGzZk/fz6q93NyvjROnFxncLkiYm54vem4sQiNvHksY1K1JU1?=
 =?us-ascii?Q?NchldezbgkP7q85MniK1KEX114FFyOw5XwxsewlFNOENctt28u/q5U3CHE0C?=
 =?us-ascii?Q?AngOs6HkeWUbXmtpQ2fhGKhWIgJsRPGt7k8BNYtb+PIWAtU2UC1bX360NT4f?=
 =?us-ascii?Q?oqKK/QL0T6pGMO9LDGKzY8i8g+55hq4CQZXLoOgMMyoW/ePJ6UvjBitGUlRI?=
 =?us-ascii?Q?7vXo8Bmc0uHoq+1iSHeUN7BSkMLb5szQSoDYUcO8ZCBW+5OYuZhEFAzhINE5?=
 =?us-ascii?Q?zH89lyaLWESCkONsj8M9WTR9U9zKmyI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bceac44b-c737-43ac-b3a4-08da2785907b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:06:23.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScTFzLAEXZF8t0wSRFdHFdemm+SS/BfvQ0jReh3kajsgoI5RHFyncBVp7Nl+UVyKJ0Ks6dMDrhuiW1fTceAumXf2NeikytOS+KlBOALxb9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5000
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=694
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260083
X-Proofpoint-GUID: d0AOTVaHoyysmEo-q2zeVqH0JOjHDt-u
X-Proofpoint-ORIG-GUID: d0AOTVaHoyysmEo-q2zeVqH0JOjHDt-u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If an error occurs, debugfs_create_file() will return ERR_PTR(-ERROR),
> so use IS_ERR() to check it.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
