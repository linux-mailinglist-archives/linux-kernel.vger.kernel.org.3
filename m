Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7625536482
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352931AbiE0PKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiE0PKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:10:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC126D854
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:10:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RE41Mr013206;
        Fri, 27 May 2022 15:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=uF2XWeXZm07JrqawwXKfJvtB7jOjZURqk8VFkk6bWQg=;
 b=n8z0iYyTJKeN+qinmKihAGw31i/4H39bkdoO7w2sdEPm4dZF4PrLFCDNUL/cDHWS0shh
 oxFqG9A/zWEXQ5lJUZAXRBetBMWQ5ZvXR28cqwXeU3VhAFLjs+ALOagRECOrqyPwHPT4
 IKNPRZyYdtMigGgovVEzZRbmQzF8cvKsL9LgqdYbkih3ON5Z15iYXqMyRuN5c2IQcaHt
 hvrBdjM4dOjRsodQpVYMh3u/oWVsM577yscuAE643h/TFBhTJNSUJgPVINpiCcXYrCVV
 2aRWBV6TC5X/C5c4TvYcSncsW1fPLK+kAE71kvA6b1S6tdUx3wwKDwf56ujCDIEqPk7l Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdycks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:10:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RF6HWL022486;
        Fri, 27 May 2022 15:10:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wyf2hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsUgw5JD7lR1MhKMCSF7IT+T2w6mdeC23Tb3ssr8pm4sq7lBIJ6VCR9aBvch2ljUKD+/f8Dx8w7wr1P7McQ605vmte49/UkN5sBnwLC7flpNzn+5jZMdj4fa7e2ZCQAayArjBlGBgxqm0ZGs39vG/sAuNsrczmrKbYLRpChhdocoFzFs/xHm2ZA2blTkmYpm0/ObWEYe3Q0S4rI7MXNFu+CeTDOtcS76DVOIAOY3tHjFceGiNCVdDEvU1g2LiEZnIDqz9Rk5mjpXSa+Lanoqjs6xC/1rYUhLWMOnuNyBHfdXHo6QoiOQfR/KqkvbAyhS2s8PuXToTCl1Zzh9NhpodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF2XWeXZm07JrqawwXKfJvtB7jOjZURqk8VFkk6bWQg=;
 b=Me3coulrROcp38FZKmO9FkSRI6vGUVxanTMdAg9unzYUgVF7IOOyC1Y37UNtMJBh68V6bkLV9eTuziGOD5g45avj3UMU50yqla/RYZ0RqAvYNr/Rs973dZQjXDlQNe5B1b99B5hjiPRVF4r/rHyZWFP43F46Xp00s/Je6Pvz7JSDEn2ZPN7KRs2GS+fp/ZN97GzSVcIXhj/Q9txaEY1609Jgq385SHOBykTpxXBbN4Gp3PSnRMlQpfwre8aR6TE4wLe/tLedTfCg4khehoWan/r7mr36MAsyisPIYr4DC+I4b4K+Pk6uMOqqbThp/vr33Hq5MXq9/AEMoeRDHK8s8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF2XWeXZm07JrqawwXKfJvtB7jOjZURqk8VFkk6bWQg=;
 b=r/wwI+qzxhGKNJAgJK5ZoNmi99zPVFDbUPQCzbc9eU5VcNP8HQgxe3hM8juV17x/W9t2TEx+JuyChApBvwmae9wghGJHw58bUoEjD7wKtXNTCIlQ+iPv5o5z0PPeU0BTXYr6PmMwoJthqkTy76mH7j4+je8nS3c1n/FvXjt5IaY=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM5PR10MB1786.namprd10.prod.outlook.com (2603:10b6:4:e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 27 May 2022 15:10:38 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e5db:f76e:1c67:6af3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e5db:f76e:1c67:6af3%4]) with mapi id 15.20.5273.022; Fri, 27 May 2022
 15:10:38 +0000
Message-ID: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
Date:   Fri, 27 May 2022 10:10:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for v5.19
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0011.namprd08.prod.outlook.com
 (2603:10b6:803:29::21) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e578cfef-f8fe-4fda-f1a1-08da3ff30ee6
X-MS-TrafficTypeDiagnostic: DM5PR10MB1786:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB178627495FF74C5EE1E61FD087D89@DM5PR10MB1786.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAVOKTHItmyqmhRGetaO9YJG+TB8vWOnKVH7si702odVjGjGNljxMKiD1sjZkR2fZNNQ/2YC5YoLSWvhZ+mx7smvfVGD3Vjv75gK0dJi4p+cO6W5QmXuPtU5GdL4bkxHRC/ruhhY2mnLBjjUHaAqRfRwNKoWL9BivZ9aRR57D6KJ2LqNSO7oVK68fPkXWe/l13S21NWJBRjxDUGxelINgp+MOqqpCw+2F5O1YMp1K5wHIq4FthqwPnu/7mzVm/yhcRZGstYCx2NpEVqV8yT5eUNu8t6qrvYxiyr3i5IeGyK73NvBAVWf7iRHn/T1zx5SWJwmTQ3jkm2GX7UqW3xowIbH4sCgm4wlx9HrQlDKY0KPoKHj+mUkeODrqSV6GyQ8b06PUaQPzaO7oQPZgMGUuxQBOoGBHyOzNSanngrTD9Cj2SUIp4bw0k0eJQX4QHUrjeloq5+i+o7vBC/co0zulI7YeOvOK/zxmvB2kvjcirFplmkyXqfXQ1AQHSDipz5nl0OeP9pHzlVISJiAmID+oOpdfdCtsrNiRQDeCk2aL1ELOQr8eUQaEMEr7b4j7wzCC/wf0qVOxJLubkTr79LYO9TuC7HyixeyBk1RJZmp2QZnOEv9XsBWfGolkxYkofIThkIltmVY+AgQRAs0cxDjPp+x2olZXwTrMQc3T73+JtyZrgDoy9itO9nyeLwGTQXkT8KaM3DHOvpzc8twvjLKr/JCRKYEwQF3+QOE5sXzXak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(5660300002)(44832011)(508600001)(2906002)(8936002)(8676002)(36756003)(31686004)(186003)(2616005)(66556008)(26005)(66946007)(6512007)(6506007)(66476007)(4326008)(31696002)(86362001)(83380400001)(316002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9sa3FMbXRrRnM2anJHZXFQdzFMZUVhWGplTWN2QzlNODNzTndiRHR5VXNZ?=
 =?utf-8?B?dzRmV09XTjVFdWNYRDgxeDRpRHVTRHBabGNlSDc5ckg5SndTQ29DM1UrOXNM?=
 =?utf-8?B?eHJmbmtKa2tHMzBNcEpPZ04zTHZKVXREN2ZWZEpFYS9IUWs2NVlEQVdRS2cr?=
 =?utf-8?B?a3JETytiUEFoZ2pZYlJNZTRvZGRXV3JodzRHaWxLVzdnRGZwaXpIbkU4WE9v?=
 =?utf-8?B?b2x2WUtTYWJRa0dYazJwQ1FhWTZ0LzdLazQ4QUc1cTZhSUx1TkRuWWpWR1d0?=
 =?utf-8?B?NE8wL3BJMzBLaENqajdQdHVnQXU4TlFvMTUrZndjUkFuSktYa0JsZWpZZmdG?=
 =?utf-8?B?aDdIcUQ0bmhzK2NDODgzNjRuWGd4c2M0SllwU0VYSlU1OFg0Ym90Y0lxckFB?=
 =?utf-8?B?bUljOEFjUiszNGl2aWk2VXBucGFrcWVmelp6Mys1UnNnTzMwTWFNc2ZaUmxu?=
 =?utf-8?B?OVdJdFpoaTdiUkl6Q3JTNnluWGZGMHJvbFJ0R1FabVN6MTl1RkZockszZ2Ir?=
 =?utf-8?B?cGhNMEkxN29RTkZLVzFNanlXS3hSRnRFVjdDYTBNcnZWNWNGUkpwaXI2cHhG?=
 =?utf-8?B?azlycFFlMzgrZFdRUWZ6NVBIcmlRRVhJcWFOdmJRSWpVOHh1aU85TzNsOFZQ?=
 =?utf-8?B?eTNFZTJ3aVBlVFF0QmtSaXBVMytkaStFY0R1dzR2STFuYUtnaHpVZzVyck5K?=
 =?utf-8?B?Q3kxQTZNRmpQMHFPTkVwOHp6K05DQVRUTitOMEdKVjBIRHVGV3pWWTFYSndC?=
 =?utf-8?B?bFUzLzBoNHVScllmaVpxT0d2WkhFakM3VFRlRnJ4WVZSZGJLQUh6aVJoaVJ0?=
 =?utf-8?B?YkRmdXRQK3J1ejhxSEtJQWptUDJjZnE1T0RlZzNLWDgzNDVxSEVtZ2VqNHV5?=
 =?utf-8?B?QWU0cHNmMTlTWWR0eDJ3RHJJckxmb0Z6Z1pwRjNGL1Y1d3pzcEZ1QkYxREhO?=
 =?utf-8?B?bDk5YWtyL21UaXBXZythdm9QeEpMNnhDalZYU3VMV1pJUWREREJScGtmQzJr?=
 =?utf-8?B?U3B5MkRlejJTaEdCemV3NlNWdzd1NUM0NXVHQmlxWkNUc1dRV1I3WFpHNlNR?=
 =?utf-8?B?VDRzUFBGaUMra2l2dk1jMnVSV0NTWDRtTUVyZTZ5VzEvUHVlZVRwMVBzRFFS?=
 =?utf-8?B?WnJ5VnRZS0lrRy9LVnZQaTY1cmlDdVo2OHg4d211ZUM3WXczVUdqeCthSE1Q?=
 =?utf-8?B?OE9PeGNpbkxwUEJtb0RJdDFMWW0xQXlhMy96YzEyaGdjL3RBWFZTVWE2eW5F?=
 =?utf-8?B?TjI3Zms3S3puN09pdHpnS0tZckgvSzR6Y09qK25ETHJhWkg5OEptWFdhalRS?=
 =?utf-8?B?U3E5UHM4WDd2bllKaGk2d0xNU1NWc1ZPeTEwcGpJK0l3bHJrWEtOci8xS0lB?=
 =?utf-8?B?MGhCTGhVRWlPVkNwNmthVnkrbFh1Y2cyWWhrMTd3VDVBcEgxRys4Tm1OSUFV?=
 =?utf-8?B?WGtXVDB0YXptenMrUlZkOHlvd1hYeEdEVGM3aE5mbWNBYkdKaWlDclJRaTRj?=
 =?utf-8?B?azR1Q0FnVTJQdHFQNkwrS0s5bmlOaWhncWlBdURiSksxUnVuTGlvUllISW91?=
 =?utf-8?B?V2U2TlJ5aDFDK2tOenJzMVRGRkUzd1Axc3Y2aWE2UE1xN09tNDdCWmxHY1Ro?=
 =?utf-8?B?d0svaDNaTm1Wd1prOVU1LzRKSWJ0Z0hHNWtWL1VFQytLTHpub2FURXh0SVh0?=
 =?utf-8?B?WmJka0w2em1TaDJ6RmJSd1JwaXNDeUlqdjlIUm44SGh4bVJsbUZMamZQNVMr?=
 =?utf-8?B?MHlkdnVSV3ZxTXpRRkRvVGJYb0E5MVg0SEtwNlp6UUEyTEVrcW9IT1A2aXRI?=
 =?utf-8?B?bW9XSGhVUldsdnNScEJweTg4S0lKOEcxTmxna3drUHY1OU9xTitlelFoNHlF?=
 =?utf-8?B?RlgwQ3FZZC8vSStHMmsvVEtRVmNiLzgyZXI3SnhsT0NGeGZDL0dJUVl5RXk5?=
 =?utf-8?B?Z0FLYW1yR29ucVZ0WTJqV2llYjRKYXMyMFBsUzdjQ1FPNzBYaXJhaUhGT0sv?=
 =?utf-8?B?ekpIclRJWDdNNU5zNjJVZXluZDFMNHhERWFSMkpUK0RCOEk1UWl5dm8vb3Fx?=
 =?utf-8?B?NjBKODJ3YkpoOHU1NGxSWnY2NFJOVXFhYVNYMTAwdWRia1VOSlQ1b1NaTXFO?=
 =?utf-8?B?Z0YwYVZlQlV4NklwdWpVak5kcHRJQ2FZZ1h2N1dXWVBaMVFNaitWS2JSa2hL?=
 =?utf-8?B?YURuOWxtVlE0Y2Z4dEQyTlRySHR3SEZ2dU9CcldCZHprY3BzdFdpN3pWbEVI?=
 =?utf-8?B?UjFDelAyVlk5NHV2WHBGZ3ErelYwN0tqd2JPbTkwZCs1TEJFNFE2Qis4VVF5?=
 =?utf-8?B?MUtlNjFFcytkUytiM2JNNVRWZnNldUFGZnp4NGJPK3dzUXdzd2lqeVdVY3Nq?=
 =?utf-8?Q?XauKPIwfWoQTMmpE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e578cfef-f8fe-4fda-f1a1-08da3ff30ee6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:10:38.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RA+VUzyUdeZuK8Nv6T1Grd79ryEnjMtWOiD61C4z3w6S/u9lAGbcy3Phri+bshakKYPmszutiWVmaniUZbKoPTb7UWDItisjhweWauir6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_04:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=902 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270073
X-Proofpoint-GUID: sblNIVuyj77x-f67q5IouVlpA-f2lgdI
X-Proofpoint-ORIG-GUID: sblNIVuyj77x-f67q5IouVlpA-f2lgdI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

   Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.19

for you to fetch changes up to e471e5942c006532a013eefde239ce1e783ac2d9:

   fs/jfs: Remove dead code (2022-04-25 14:00:33 -0500)

----------------------------------------------------------------
JFS: One bug fix and some code cleanup

----------------------------------------------------------------
Dave Kleikamp (1):
       fs/jfs: Remove dead code

Zixuan Fu (1):
       fs: jfs: fix possible NULL pointer dereference in dbFree()

  fs/jfs/Makefile     |   2 -
  fs/jfs/inode.c      |  18 -
  fs/jfs/jfs_dmap.c   |  71 +---
  fs/jfs/jfs_dtree.c  | 298 ----------------
  fs/jfs/jfs_extent.c | 255 --------------
  fs/jfs/jfs_logmgr.c |   8 -
  fs/jfs/jfs_mount.c  |   4 +-
  fs/jfs/jfs_txnmgr.c |  34 --
  fs/jfs/jfs_xtree.c  | 961 ----------------------------------------------------
  fs/jfs/jfs_xtree.h  |   4 -
  10 files changed, 3 insertions(+), 1652 deletions(-)
