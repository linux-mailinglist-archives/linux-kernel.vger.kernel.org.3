Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F457D748
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiGUXO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:14:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D582F98
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:14:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LNEKuq016176;
        Thu, 21 Jul 2022 23:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=1aN1UV6zboeRqCPR7ZFzdRL7xMyFFu9Ldz3J+OSKqi0=;
 b=DxXPc5Id7vw4K2bA7MDmDx8F5+IhbSdc8ZuBETFiGpz/CokdEFHuhJdsYgKuN0zylFoq
 pCLBENNzqs4RDbfmQhWrPuCokTevZpOatXY11PbmSL4qkL4rGTY/US78mTmgZkWComzE
 35EoVVC+1ErlHJyKLc8aKGKdZI+7mgLV4rD1GDFusxCKRWzUkvB4QAXpYQHIooMhVo6v
 dNdGRwtaKhuCLe7ZPX5rYeFvHtEiq6SXGGE1vvPqYZnuf8/2JDOAcDTgUP2Y0ZwMaa1h
 2OkW0ctgHgz+aiv2q1cwMDwcPjuURln4euM6bOamnnVHXKKeR3ZhZHNzaEBjp6MqD7jZ 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrcdkq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:14:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LL8aTJ039236;
        Thu, 21 Jul 2022 23:14:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k7aj7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqQy44aiMiV2ck215uFaUMxVKj7ie/WHbqdCVchoquSyWbNHxyX5jjVRkQmfP9UfKgJ/fU4Z55LLbMduysy3q8O5JVUuwsI7rx5P8H12g9yjOsin9Rp05s0KMU2l6wcX3gzfCEtrhYSmlSSvaHWIpyAayME0sKTtpEN1yFbJoYT4ObSv+szIOwkzgR0rCvgQmKeGJfDFphoxv8eYWKTpUYB+64gme7ZxW8vkLm8zFfuPcqYEQUUhJ6F0hGtjULwNVB/to07/y/ajiZtUK6V86TthRfGnNmajHBOorVcGUiU1mGhx5cmoQAwyIK/ai+eLWRG+/K39C9xpu4IGhLIF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aN1UV6zboeRqCPR7ZFzdRL7xMyFFu9Ldz3J+OSKqi0=;
 b=DlZf1O4kmmI5htab5uEAb4ugftfvdEOCM39wPnhA+pzixBQ/bydjPe1ZotOkJpdhc2X4f6UhYwMjcTGQ4vxOWG8VNy8RLReChMNxtXO7QkXUpHLGJW7O10rclsbURAyhhdlCPvme1IAXKfFIQM+i/rFBVBwJDDLKhyPrkIBQ2/X7UcAx3haEH4CLVeUXDgmtvE9iZbYpHbKG8JQjG1mhji/554kke3ByVXKNbijO7369twGuAhTuEwTKO2wjAfBP4YF+dVpZTz3Jz41g/QOz/AjpNzd9yRYwcaiFGe57qQs+9ICeE0tW3w4p1A9XoXlBe/SoOTQCnfPLxGNA6Gos9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aN1UV6zboeRqCPR7ZFzdRL7xMyFFu9Ldz3J+OSKqi0=;
 b=i+w+aGMcYXp+rbVvM88z18bimTSzIBpl0HvVG5tdc6kuGaqM2FOKjZD6hxnlBICHKElpD44H7qP2QcAe9BRATSq4779BDaRr0Ppv2fHCZwkH3LqSBQjWxDwjrKSrXtCMhtJvJNnH52H4mZuSbG3n99svCh1UfykYEf30OwNb8NE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 23:14:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 23:14:46 +0000
Date:   Thu, 21 Jul 2022 16:14:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hugetlbfs: remove unneeded hugetlbfs_ops forward
 declaration
Message-ID: <Ytnd4/3xcwJ5dq1K@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721131637.6306-3-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bab2eae-dc27-4bab-ac1c-08da6b6ecd75
X-MS-TrafficTypeDiagnostic: MW5PR10MB5691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZVhhkMSZbuXyXkxlp0cdU5PYr4xtKJAZgQoDpprvrRqzXSSIWHO/0lyAvvCC2BCi52i+CZCdAfRmjverYBlXJmBqUvNzKgXq73g/5zX/6iQ0k/7kZ/uTy7+I+Se9WPajF3CJkvNbyNAQL3sr9NHeH3d7q8gncT1WqznjZgCqIW80XYFfajZ5nXqKp1NgkeurKzquBCTF48R1dDmLX6qO+/QQlqRgrj+EhOpG2BOwG7mFG+ZdRcyGyzNE5YLpzhKEGOj3tPsSUvuJBfQTvLUHMRkPZhNfs9QNYQhr5EV0oLG+J4IsBnvi83XKSF3tW7BP2awlSJZmyLosunaugkGUX2oCDERybMdDOZmFoWauPxOSgUud7wXPNy8EiOETyPnr277AF70DLqXAGGaXemm+GNZbxaldEZKHZvlaEO09ZZQ3ZW7vZ5qke2myOeIvjohwfFUXr/P8X4DhjTPpuYNDSAl4fkQURauhQaQgFRB2PaisPIM2Q5+1kV+Ale3ewM4Q2M01PdYkiTOto5paNfR5Y2NsAGisrWHD5khC5YHx/tpDlpzxnwPpmRi4VQjbOPexD0Qge+ZnKuMqUmu5uFQoMsuJ3SpbaA8cmIE4d2+3doIGxLuKoc/5FsFLUcZf9Io21KOde0+Z3Z/kUQ3Bz+VsN+FfkFACcnW+FXQ/EYyggvF0Z8UYmDVi3BNlcuPHM3hgfIATX7zlqnYofzPqN9hixF/MjKbT6vTXp3TxSkcHYZ4yeuMYVFM0cYS5uadwufV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(86362001)(26005)(8936002)(83380400001)(186003)(6512007)(38100700002)(9686003)(41300700001)(6916009)(6486002)(478600001)(6666004)(6506007)(53546011)(316002)(66556008)(66476007)(66946007)(44832011)(5660300002)(4326008)(4744005)(8676002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VN+4m3FTOqzwLRNafwpDn1QSKBvb2EMCQnPs1+0KQ/qiVPoe+cjWBK7zPRg7?=
 =?us-ascii?Q?dCNuoWrezjZLd+EtMLaVC0HLDABvRcmgKUpQ3gMMD1ykHxnibXirvAXJRQ8X?=
 =?us-ascii?Q?kRhmfDsWt/DvZY/M6i8FmDaNlHwWX15Zl8TtYJuWULzXblPjR2vbxC8EaEd8?=
 =?us-ascii?Q?kl+vzdxFQkCRIyRI0Z9ugwlomhwb01ZJnzEoL7WXl1Zba0/XRnFoNpFyGMUo?=
 =?us-ascii?Q?gPBHkdMQRjNtgkP3kHKyAdkiw8J4uo4Vt640BqUl2n109cs78/ggeS0O8Mbg?=
 =?us-ascii?Q?eT8EdeRkJR3zzYZwAEbQfI1sl6zFCJM5vaiJP1uW2vw4SGdMHsu1U0ymU26N?=
 =?us-ascii?Q?RtwEVE6Z4aV14SgOAOjTKUmXNknnjJ5LUUhb/Ye2uabmiRDXMCKtM38MDJrR?=
 =?us-ascii?Q?/nVMtqMwEtEDZLDV/aeGKUaXBIz74EikL2xQDHbPpg+4UuLs3PERMM6KLpbm?=
 =?us-ascii?Q?mNI/yKxMQxSJunHLWFaOyKj2Bts2vUmd7cxv9H9dyREokN0nvX3GNtHE4PJQ?=
 =?us-ascii?Q?5NZSRDqNzzpfnLbyReu/xt5rKfsXw+vyQnVUJzHfPpM7HfJcYdQs9X6+EzCX?=
 =?us-ascii?Q?7z1/LSfLyDVcapSZqd9XJZSgCszfD2QcGEyRJ5dgoejlTmQRoHiAOJzcJuUj?=
 =?us-ascii?Q?cBdvIKVgpr+tyn0+bUciOJqDjySxwpysA+LiYs3eJ0gH6MttCjmakIVdfQmP?=
 =?us-ascii?Q?EzpZkdVw8Qb6E31dPCOQuVXi6FHqPo7AJ+tvjX8CeLpjoDq8T8QLtg3FDRMB?=
 =?us-ascii?Q?pS0q8aQ7KYsx3ld9hz+8GdVp+Q8fK5oxC+M8pHOGVyMc1PAxf1REp97+AwU6?=
 =?us-ascii?Q?UaMcapVa2WvwSyz8gtMIbtzJW1IUHy+HhCaZ3dJ/eLHJiNvtbLx5i4ZOQRm2?=
 =?us-ascii?Q?CtozcnLmdaOmt9JXznkHlSHlHb8KpwsNyk61P12xKLRrcu3ph+9sLKNXExPD?=
 =?us-ascii?Q?ar4XrYdWjxccvAsJu0cEivkTZ936UeqCOwa0icITEJrInPVNmvUssoXwgJhs?=
 =?us-ascii?Q?9DwmXhhyl4Myb2jvohlcjyJWWxpO1KsbCF9NOwLvPOwxbdej5cHEPVb0B9Qv?=
 =?us-ascii?Q?iHdU0yP6lKJvtR3NJhGTQaKyyhLRhO6P7dtIY3QfwIq1neB4gxK8u36cWv5Z?=
 =?us-ascii?Q?NdCblUaYU5lXM2qPvyApqUqF938tuuRF4dJAcGxX2g+tzNkxFnjYbWtaOBXK?=
 =?us-ascii?Q?85m2JJhQm73EKXvY2KfNcKhgYKq8k3GexY59h22cHNxatAQFWHD2Cxap9Zkk?=
 =?us-ascii?Q?PtGg+ixIjV0IXAzNZrO96R07GQ0slK4kg1I3PDMmqlh42mJMIPGSp3+sEbLH?=
 =?us-ascii?Q?dQnj8v/oavUNsTmShIB/6CK3PfSQhbaiPrZBmzekO41qWpxeoYNZbV2qfIvZ?=
 =?us-ascii?Q?SMKCmm+0BkGXX/qFWq0jS6/kgT0oR1HzuvEVZGSPtzdN1XIm7QvKCSzzaWY+?=
 =?us-ascii?Q?fTe9s/IKm3G5PRFEqsPI+p5pv/MwapeGC1q5BmnM5svsmig2Q34UOrW8/9Oi?=
 =?us-ascii?Q?63D7cELqjlmmARVKLXnKFnHdZxm0MLQVPBZGQdIwdgjIC7DLsZvMYJKBmk1C?=
 =?us-ascii?Q?0117AslxoChoRAgBVM42OH15rXvUlJjoKdFVys84bCQwWXkKLw0k6JErVVKY?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bab2eae-dc27-4bab-ac1c-08da6b6ecd75
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 23:14:46.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6xHXcQk/c2TQ3jwDigz3SdTqihnk6ymu7OS/v+xJF3LOrPk6GHLqc330ZjOwJbBKfd+hpGp5F4+iE7pxOrHIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210096
X-Proofpoint-GUID: 0WTG6TXbc8d15r-mKPxHAxPkBJKU7ywu
X-Proofpoint-ORIG-GUID: 0WTG6TXbc8d15r-mKPxHAxPkBJKU7ywu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 21:16, Miaohe Lin wrote:
> The forward declaration for hugetlbfs_ops is unnecessary. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
