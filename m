Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D05586AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiHAMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiHAMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:31:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB3481C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:12:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Ancx9026725;
        Mon, 1 Aug 2022 12:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=tDkZdG59zo5749HMdVX4BsAcmPFH7PlpCTKKhlYNx/A=;
 b=vVwvj7YbmcnwQ7J7Iz563NQqVudDJEMq5Hkbu5CRdkm/aHAO3XbH81/J1AnuoAcWrfWr
 30WQXNm03SP+SCuRyUrC8tsI0hZdhDM58XAxnn3ErXQtyqPy+PxGpOPsVjJGdRW4cA+T
 rFzsYHOVS1DteHIiopl31E6JE1ZacoM0+vjH/BbC5QrUETwv3dPVRwya0N/AdpLDq+ZL
 JRue5YRgDcQrgA/VMgmzJOwcWkClx5MgoTvyk0u6NTRBF/1j7U/lD+3GNdPF8q+WmUHi
 8DNfRceF2im7P1BRpoT5T0UrNr/0hF8Xdrf/AKODzsWDMLgsrBwb/f/4DLUEkaoC6+dm rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9kckg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 12:10:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719UiCA001458;
        Mon, 1 Aug 2022 12:10:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57q42sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 12:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9kn8shb1Dg27u/uFgTvvXNyzz6CXoM7ebTLDqvKZGFOx/5/774AoEfynJvTErY/g8zj2CELwoZWfu7LbFsOoU4+7aZQTgyP8lYO74S075qlYZhAAenBUuopeMn5Se+5DvaRZ2HSuDYyV8hrQKxh7drDsulgzAtcac6+eEw4tM9XjftLvoH1UFUzPN0YGrOGw39UC9vVD0n9PapZLT1fJKxjT6FRhJ6Var4EFtCApoKl5C/cDGJBlh6HBJ3eCIeDUmvf1p6uBJOPoLQZrprILX4qQpcIVZGTHA8RkhVDPlm21JBZnenhuDSp5mnYe9NhXck7QupeQIMUq5/nK+zuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDkZdG59zo5749HMdVX4BsAcmPFH7PlpCTKKhlYNx/A=;
 b=YeqAQ1cHVBiX+HW2u3IwJFcAnNVyKuSTq2zntWkPWlZElnDuY8Tx6gLtoDiCp3jXrB6hKUSdLHJewmi4nbiTLqbXDDMXYc24bxPetMSEqMMkct0DJiUJmEbA5yr63vQ6DVgXKfXF8zLiFLVVtKYMWjTaD0KhQ9uzD5Q8gGFBT12Q4N47BQOkqdxzUGWi1LvYmTYUvmAkAafITHkJYpoyIbym294xmJ0zC3kJAohGUx340/w0VfREDtwzb4HMAJ5iIN3+JCfpub72ep5+TnqGPAfehAZxYkRJzmbkedZl6ZpiGXRvqdiIN4Vd5OmPLsnFkWNEgLuW4r41m/LtG7RY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDkZdG59zo5749HMdVX4BsAcmPFH7PlpCTKKhlYNx/A=;
 b=m4tM/nJOKokohdKutoCI4+vrPrTwGL/xV4aHmdYQotpbaKha4wX8oYi2aR7uf3CoOAsl8cN5bKldI/wZh728X+P+1jytn3niXSNQsHiaNGTk6MRM2QQTqvi2TkERNpvY/gCmWMDmfokS463lxo2okWdQD/FQOjnfkzxjRxBKZ9Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5925.namprd10.prod.outlook.com
 (2603:10b6:8:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 12:10:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 12:10:54 +0000
Date:   Mon, 1 Aug 2022 15:10:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Namjae Jeon <linkinjeon@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>
Subject: [samba-ksmbd:ksmbd-for-next-next 12/12] fs/ksmbd/smbacl.c:1213
 smb_check_perm_dacl() warn: variable dereferenced before check 'pntsd' (see
 line 1212)
Message-ID: <202208010716.Io52CJih-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94644cd3-a70e-4464-9617-08da73b6e21f
X-MS-TrafficTypeDiagnostic: DS7PR10MB5925:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj77bLigL5xWwy9LEmaX665gS173odXYG9Mogali+UWq1VfxlbAQQv8y1BtrCp5aHqTDK/Pj4GKMjFhTGAIT+DA3lVCrSj0tdiBy5Z1lm51mIYrZoAfOg241qRXp+1gte25kIJ8tRAZM6zlJbhLWLOlrsyORQOUfWd6hHr9dFNErw/pllcCHZvY/nv2WeTVtubzuIoxqkK4xGczqF5qNOBLVk37PtrySqjGo+PC2pfZpTpraYhPY9apYMk8JQfVasVPBxbLT/Gu+anAYQX1J3PyX8jKDOAD+2jJ19LT9rIYif1xYwa/s/b3Hf3B6eiZtwP439RwhatK97VCTWT4JEAuZbSW/AFeIPo4/lxKWi/OeYliP/NJgnpvVqD7BlD50JgVEKQB28dKFi/gF7KwopQIPXhfyKJdYWSPoITs2GO2fVlomxcZsXl6H6pvtTyaJRGFo72u1r0TVwjkXzpjRxAIQmMQtiScJyztD/kcBHXARUTAFCPZkxUUHTgp3FTx9TTWWm7ud/dN0Dl4oa7O34XDi0D9UQtU4stv7tYg9gUHpJaQyyv5XZqJ9IPgsT/y0tXdvlGMNGmgFRF96e7b6+mJ8K5warwavacflGcM4eQ12MI+HcbRZpMYplWNxG9s1jYUFvye1uDNzsgpktWxE3wvw3N2ovjzJVC5Kic+AlpKZO3gMZYtttMpHxAGZqsp2GkFWGN7SdolNY6J8SECAfVFMVadUIb9NFyMocZRJ2CrkxDgCKUTxiBKd9oyGWx0MICuRxAwKpZfgILPlR2NagptNjfYCVYQpqWN3zePmUme+Lv8/ygLQTSNePPwcel41xarjslC1e/Uy2u16ARfkzJ0Ja3+t10p9HESCQYpKsotbpeY2g0kRJKPJjh5a90CF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(39860400002)(346002)(1076003)(186003)(86362001)(6506007)(52116002)(2906002)(6666004)(41300700001)(6512007)(9686003)(38350700002)(38100700002)(83380400001)(36756003)(6916009)(26005)(8936002)(5660300002)(66946007)(4326008)(6486002)(966005)(8676002)(478600001)(66476007)(316002)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79FPLzj6JUeAanK5THLMSC8JSFqc8pNi7izcTwTIYmlvDnNmL7c+wu3lvOGJ?=
 =?us-ascii?Q?SCGHzNBdK36aDULflSKnxL7KLPAev8yBpSDYjUFYP3XwhYJ5pxl++wDLhdom?=
 =?us-ascii?Q?JbTkze1/Vqh6hvKxoGAnOXhC2GFCR3U125Khqc5QTJX8KBC1HvysZo5mUo0v?=
 =?us-ascii?Q?fnu/y/m/lsgmmzlSlv4QI6PIuWDv0iTlf8vCoKffPj/GpoUSRb0OgMJg7BwA?=
 =?us-ascii?Q?MaPyVKUV980LI7as2NzOpafNhUQOMcGVQZYXPGpBzCma1ax6NKWdFFhGbCg/?=
 =?us-ascii?Q?cQ4UedE/Q8tHGFcr0t1mHHqq1WpDf30MNDeNVjPUDEQ0FADATd+5PlAMEdt1?=
 =?us-ascii?Q?WyFaohJHnwZfeHMklPrxMBV87XtUBS4MrSxMiI4+zmzE5PLgj1D7KXAgFNV7?=
 =?us-ascii?Q?kpVddH4MKyjjas0G2DCAJumvVt9wglvgvIEcrwn5MD5aiQdIP2e7V4GZkkVT?=
 =?us-ascii?Q?3Mf0pjQ8NjEf8+lOJhzv9sVQJ9nlzPuzFJsfiuz7i+51MP0CElNo2CHhTyh2?=
 =?us-ascii?Q?IKjvmnnqK1jfY0FGbqdkcpGXEonXOLURLuw9p9YKR+ZxuwdKE4VlcfqXSsXU?=
 =?us-ascii?Q?9Cd+/CsUPxMflbvbnps+mYguLRVPqODwVQfe3FL6ImBiV3UW/v5DnBFBa8Rv?=
 =?us-ascii?Q?nGFrM3AELoZvWXUsp4VB1Hd1orGpecmergTt6a6TVbxSpzWxXE3SwPccT7zn?=
 =?us-ascii?Q?nCVPDdga4QMw/rVmcWa5G3GPBu+wf2re20N2izO+imdWhIQbEIX3u/LGLJh0?=
 =?us-ascii?Q?EGVuwngZ0XOnRHjYzRUeeybE/YTYohetag3vldI6nrJDnwD4cXRAsE18hm93?=
 =?us-ascii?Q?ll8Yn1IjvkwJF8Julju0zNJW4nI/kZ6b5L+uh71eifM82aGhpFlZPEwXPrxh?=
 =?us-ascii?Q?LUNryLczmBqd6BLL2rbh4uEUPebmGL0+ZgjCH8oPfzSdQXGVZS3dYsGGRZ6V?=
 =?us-ascii?Q?p6LBvursYKbv5NfRpFjfq0rhYW8XipdicHByw9/aZy74awzDl5GgUwr+sye8?=
 =?us-ascii?Q?iwyRsaTcGJB8t/v+YQ8oW8hPf6Akkdfcewo3RZX3PbaS4EOdBP2nwbBFIYNP?=
 =?us-ascii?Q?j0DFkZmYwmLSwSyEU6dBD3OVuA+dJTqSwaAVcO7xkR10kbmArVPc+XmJ40ME?=
 =?us-ascii?Q?Y+DChAe5w8/zjTFlPInQkCF5EHr7avMxZu/XQ/1WKWoJsTFJd5XBo/egeWg5?=
 =?us-ascii?Q?kltw4oonrs/Eo4FbXQDUTI481d7plqpoqApOosJfdVCvq6E19HUD3R4Of+so?=
 =?us-ascii?Q?F+FxoYN3muvhJkRvHKanL6rJxsreVzJF457nLP8aIhglJ7XnvcVEAg5XNhHx?=
 =?us-ascii?Q?nAhb8caADC5XXTRrDc3IVxtgUSpi3Im7IJYjDx4kaz6A698OHAE3B9N32zC/?=
 =?us-ascii?Q?QcgaV9vbjOhiQAi85RSDPLiPcEZlrd5BaPnQYtEgbflO/nBYdiRvn12q0A9n?=
 =?us-ascii?Q?EII/VjsnlbNGDBgjYSn8gYA/9Ysrf7pFKsRANeNgy0FtLSxAg3NVc3JWISAN?=
 =?us-ascii?Q?hqdn+t4UZ5v5E2wtGtMuaggvkIdFBnw6H5DE9r2IMt3xn8KgVLgCyN5Xe4KU?=
 =?us-ascii?Q?t4LQYrK6jEvy6Fly86Z4lFTBHelQvwuEBusqfJjndG60YjC6nzYKBbzU+OBM?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94644cd3-a70e-4464-9617-08da73b6e21f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 12:10:54.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4TUkS6MsOMHSbdAkKi4a3idF3ODp5B4SVvCZ4yg63aEm04bdPfhLZpopz+hYLUvitKq2rBSYIwHx2b7ztoBFSDeSN2AIQ5xIGFfPe2GlvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010060
X-Proofpoint-ORIG-GUID: Tb9Te9hcOiDNEl_wDNLiUSwAYGL11K_l
X-Proofpoint-GUID: Tb9Te9hcOiDNEl_wDNLiUSwAYGL11K_l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git ksmbd-for-next-next
head:   d0b73d20ca9100c7b969b65d8a1ff49cdd1fa9c9
commit: d0b73d20ca9100c7b969b65d8a1ff49cdd1fa9c9 [12/12] ksmbd: fix heap-based overflow in set_ntacl_dacl()
config: arc-randconfig-m041-20220731 (https://download.01.org/0day-ci/archive/20220801/202208010716.Io52CJih-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/ksmbd/smbacl.c:1213 smb_check_perm_dacl() warn: variable dereferenced before check 'pntsd' (see line 1212)
fs/ksmbd/smb2pdu.c:5182 smb2_get_info_sec() error: uninitialized symbol 'secdesclen'.

Old smatch warnings:
fs/ksmbd/smb2pdu.c:549 smb2_allocate_rsp_buf() warn: Please consider using kvzalloc instead of kvmalloc
fs/ksmbd/smb2pdu.c:6123 smb2_read_pipe() warn: Please consider using kvzalloc instead of kvmalloc
fs/ksmbd/smb2pdu.c:6275 smb2_read() warn: Please consider using kvzalloc instead of kvmalloc
fs/ksmbd/smb2pdu.c:6424 smb2_write_rdma_channel() warn: Please consider using kvzalloc instead of kvmalloc

vim +/pntsd +1213 fs/ksmbd/smbacl.c

ef24c962d0f290 fs/ksmbd/smbacl.c Hyunchul Lee      2021-06-30  1188  int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1189  			__le32 *pdaccess, int uid)
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1190  {
465d720485eff1 fs/ksmbd/smbacl.c Hyunchul Lee      2021-07-03  1191  	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1192  	struct smb_ntsd *pntsd = NULL;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1193  	struct smb_acl *pdacl;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1194  	struct posix_acl *posix_acls;
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1195  	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size, dacl_offset;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1196  	struct smb_sid sid;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1197  	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1198  	struct smb_ace *ace;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1199  	int i, found = 0;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1200  	unsigned int access_bits = 0;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1201  	struct smb_ace *others_ace = NULL;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1202  	struct posix_acl_entry *pa_entry;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1203  	unsigned int sid_type = SIDOWNER;
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1204  	unsigned short ace_size;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1205  
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1206  	ksmbd_debug(SMB, "check permission using windows acl\n");
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1207  	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
af34983e831587 fs/ksmbd/smbacl.c Hyunchul Lee      2021-06-30  1208  					    path->dentry, &pntsd);
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1209  	if (pntsd_size <= 0)
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1210  		goto err_out;
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1211  
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28 @1212  	dacl_offset = le32_to_cpu(pntsd->dacloffset);
                                                                                                  ^^^^^^^^^^^^^^^^^
Dereference

d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28 @1213  	if (!pntsd || !pntsd->dacloffset ||
                                                                             ^^^^^
Checked too late

d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1214  	    (dacl_offset + sizeof(struct smb_acl) > pntsd_size))
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1215  		goto err_out;
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1216  
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1217  	pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1218  	acl_size = pntsd_size - dacl_offset;
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1219  	pdacl_size = le16_to_cpu(pdacl->size);
50355b0b20103a fs/cifsd/smbacl.c Namjae Jeon       2021-03-19  1220  
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1221  	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1222  		goto err_out;
50355b0b20103a fs/cifsd/smbacl.c Namjae Jeon       2021-03-19  1223  
e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1224  	if (!pdacl->num_aces) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

