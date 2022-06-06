Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9260753EF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiFFUYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiFFUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:24:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAB9FCE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:23:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256ImF4D000558;
        Mon, 6 Jun 2022 20:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lp2dzY/VXAJs8EFvr/YdAmtokQDANwDu4TkRYsXKCvQ=;
 b=E4A6msW7NGvsVCRANuMVoUVdYSg0FCokpuN7Vhpu73VGSLCHzt37X60VzaXikFzhsj5e
 r1zXQZ6XXQO8Khi25JIXRc1IQaRizE0zjKUJEA7L3at4bT53YDTIxamakezCSiCrDWWw
 9Eu/+DzN/gUGw+B2PXOvF2LQ4hcLtXD1ywN0kb23sU8fM5bLDHpCkMDRvhswxRjvFoyB
 zJA8iFTOA+XKk6JqxCEfTqyQK/hN8xMSHL1fQz7W3Yj/ZZ8cREOmfj45kQSaJBt06IQe
 mkdhJ9l+0y40nLVdWCIbXLtp/cGEy4VLZm5zWg/f5EQzeBjQNtksjPsQhqjuZm3tdttt Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekc0sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFlVm016001;
        Mon, 6 Jun 2022 20:21:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu800bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVTya8cUhgVeAxV4Lkvwft1sR/Xz8YzjmLQWtpKdJqPg4rYPmEyCLzUpdEvLF2oklWrAFt0ThxdXv17XFbMagRhIORoLVWgRjhi3/My692DI6sW8xsmZXhNmh78MGioTIhjjTU6EHOXEf/X2SMLcslBYOFbdIuOulHJeXaSeXXUy6V3/TAgR9dcB1hJDfptNDiYk0oiIrXmuhwBpl2s4nfGVqGExQx/Rq/kz23UO1FNNXwPwpxKVx/BbNYDVo3u+YwkDm7N0ncZ1URoTWYtIPacrtSv+t4a+Q9Fn7Ja0j887r2hOy7JhUtEhFlil/fWgVMJhPydqS83M9NvrikimNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2dzY/VXAJs8EFvr/YdAmtokQDANwDu4TkRYsXKCvQ=;
 b=iDn3TJK2Y5+uDaaY7oFwARjeC0i5xiu20ecjcSR/UI6AqhqM6x16s44h6rDEDdt9uYEpY2l9VW9EoYfC8CCPaXmnJPf3lbJ5092nFLe8d0vsDqv3FH40z80Uv1dLvIuhdQP6QWxo44fws53ObLpnfQizlgxhmiUsaE1s+PmnVQ9rquTGNRz3OXAoWGi6i+yRR0JwhM5JZfsRbTZCHqoKYb2zXSydO8G6VsiOUO7zdU59euOIIKFYP+zrzEVC3A+lRU173QCFYD0Bfxlg9qBwallEh/XKtI32Sqagecu2kpnx1JvTYnP83y6FFhzqGnjJS0P+0YkXi0t+tMG7+uFSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2dzY/VXAJs8EFvr/YdAmtokQDANwDu4TkRYsXKCvQ=;
 b=LRAS7q7nqR7AU9pGiqZKurXgUHjQ++53KqEV4QeLK2H7RcaSdsreyQ+J4RXlt9vUubub/Ul+V7J4xAyOxpLs2RCipUvJBHD7VscKMCaKNUOlEYTUSP4cSGeiiPiVt3odEN8Tj3vkz+8SByjf1iGOSup//8xyxwiKjXT2kmEn7xM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CY4PR10MB1608.namprd10.prod.outlook.com (2603:10b6:910:9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.17; Mon, 6 Jun 2022 20:21:26 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:21:26 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 00/21] huge page clearing optimizations
Date:   Mon,  6 Jun 2022 20:20:48 +0000
Message-Id: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce10f4d5-2de1-4906-77f4-08da47fa21bc
X-MS-TrafficTypeDiagnostic: CY4PR10MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB16088DA5AAC8392C12052C89CEA29@CY4PR10MB1608.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWMYLbHLIWNX5upltMonm7kEWAgRU3GzMW2T1r7cgrwZicyUpQiq+1+1lCk8ce1v+gbCGiQgUty830mDStA9VmmGnfd8b9IDCGvGdRTinZCiromw0YD2lA6n8RFguS9FTfa8YPSilWLwvGx3TAzfKEsCA1sGbflfqU+k91Djqwvk8upi0Ra5cypqcpDnFgWjMylmAuTojGVqell2r94TbAyjy8Ngl/7cXmZcpBHIIJRu5Rs0RdstA8zxt0ZDzcvvig0GZOJo+ZNK7OKaTx2Oc/NL2otUraJHsRqhKl/mSjkt97shcz/9KgBygusKBLh6jMTqo3R8LRzXe7z/REp8Fgoe0khXSjUklOwc9Er8UHGv6D/anFlqFKLaLobhvLsByAOfyuJKCiAcN8XI46UWacPYTo/2fa+M6aJeo7naG8b1Q8caecDflbXnUC9x1n6YPXdyHD57gQEIZ7BlnJfFhqnwG1xheYhbb2sMto1hZ7LS6s2Bq+OMjtvOjmOCmxx6fJq1CgIF9Kdq/z/x0/Gc6jmkaggC8TPHtpT0Fm5BcqtowtCnnpK61wd0+ue1trMP1v6zm2TIbLmMGa8pvq6UjnmdgZBs/TeHxqfwYNYgxnEPsMJVVk5mjmlYmCxaqbi8cB5WwJZSqtvAlFBui0q94QuZBWbboY90K/azUoVvUM5tblXI2JXzncRWgPfNpXnB1sJ/7SAYaIgpPCjFe2NLJVWZ5NicXQiLL7NGW/D6SmR8NGcCWosclFCHlq3KvgSX0CKsZ6XvwiG2Z9ewHGLWXTvBMATQldbFqI1J911wBm+uYc+pKMTAwyjAex/tDEYM1Zommaz2zVPVlrS2czyg+aYMHz07Cbw4abBAWEzKZJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(66946007)(66556008)(7416002)(66476007)(36756003)(1076003)(8676002)(107886003)(4326008)(5660300002)(186003)(8936002)(2616005)(83380400001)(52116002)(6506007)(2906002)(6512007)(26005)(6666004)(84970400001)(6486002)(86362001)(966005)(316002)(38100700002)(508600001)(103116003)(38350700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4V4A3QWvKW00dnNiFVySqjQxqq57HlL3wekfdXNl0jQy2QB6StGa8S6n1Zu?=
 =?us-ascii?Q?taUpKj4KmQpsseK+m31FGvEYbcLKT7ZGAIh0h3yyB/2qu4eL91THUl7rCLQh?=
 =?us-ascii?Q?FMJQG60LMKi81Dwy+k7iocpVtD8jvTNjqgpq6BXjs9XqYBZmC7aPGLn4QZ9A?=
 =?us-ascii?Q?4S+9vRNLi7avBp+naVgpFRkwVXSVYKVYx8vB4d46+skXpJGHwMLakKQ5ep9V?=
 =?us-ascii?Q?5mdwdMugd5kVemjj8ba2Rw5IdTvq1d7tjWjw3cCv1gDqmq840d5YUrU86yxK?=
 =?us-ascii?Q?ylNjt8LYv4X25Dj4hwn6SfTHJzaYt01GTyRWb3USszZYsCHT8ptSVQIrv0Cb?=
 =?us-ascii?Q?vGJ3FbuXPWH9Wl96Mi4lrQ6cYE66o46GSV7DnlfVHgrtRJc/iplnzke05TwM?=
 =?us-ascii?Q?k+OEdnin9OxdhmFhu7Vz+Ro37uii6JeweQ13F4RIROoZYX2a7qnXd+8ivsW3?=
 =?us-ascii?Q?qbVQB/mUGE5B9pNneNMsohK+TdM6a0UOv4/Cb66H16ybit8Ztn3wIO9/X8Gj?=
 =?us-ascii?Q?4nxL8p4AjC0oRWO+dZJUxS6EBTh4sq53L8C7ICpuqtVU5OBpghskRgC0RTI0?=
 =?us-ascii?Q?Alz0Vr/PYA13WpeVcgX7pVin0Jt4nTwtT4BEU9dxHqufg1CMwR5SyR8U1KlW?=
 =?us-ascii?Q?Fmp57nmBAwpVqaArd4nHHruF1P6PjEEubCCHFASnDHQ2kj6qgtkPkEoQcwCl?=
 =?us-ascii?Q?8v55IsQLj+aV1JILfQbu7a+T2gHwSJc7VQDAF2DjX2dr7DKMglyM8/xOaEkO?=
 =?us-ascii?Q?qqRdx4CpXcx94+MHCzLYh0NpdPJTTm7lDJFmbe4HGqIWYhmUMikYUQNHdmDn?=
 =?us-ascii?Q?RCdYcUZHoD1E3QoT3/CnBtsJTYBwsvWJo3T/eTTHPMIWF0EwUfIMlc3MSMvl?=
 =?us-ascii?Q?OMZhqI5G/Fx1G3nnD4S4UEPmgEequsKAHJmToZR8+n+O8n77SkvwDgnGVnaz?=
 =?us-ascii?Q?FNH56SFiDYGy8TlkNUP1D3mKmGJkEIsboGP1vMxJG7uC2rxONJOvuvHhLRet?=
 =?us-ascii?Q?m+an7m3zSWIU93ImpbnZ/msppaBQQfOZBfgSYqdlpF4wqnfDlSmRTsyG8/qe?=
 =?us-ascii?Q?VAkyI9tukV5rl0dvK6We+Klnv1rV5VTydEKpuxuFLm8L8rWbs4MPOkomU4tn?=
 =?us-ascii?Q?3XrBooe0bn3AWypORBpnCvDYW/hVDDMDSNKnKUpjmlKWbgdsML7lhywayPpe?=
 =?us-ascii?Q?uK7MueM9crj2e4n3l0aU6Dxy8RmIExykZSXc7PD3aPQfrDOWNMWWRdMUsKqo?=
 =?us-ascii?Q?DUo9ulKFziJJ5F4AzSjwhmK5SQdN6Z/67/JkVkOOWQgplnGapCmNA5f7lx7S?=
 =?us-ascii?Q?xESdiK9WdyDrqZp/xgXk+FiG90i9kBb0i35sFNZ6uiHEFdrFqz0dPeAN2Rtl?=
 =?us-ascii?Q?ycW7ILlBVyGsdNuKrW7QzayL1jLy/jNUpipCNIAege65dwdOEhUxo3b75zpu?=
 =?us-ascii?Q?Xhtv7kuS23W7KtUMVRkceOuC6ea81OZ1U2p+ypDfEPRQOng0W8JMMEe1ByOl?=
 =?us-ascii?Q?nE3ov6SS04i8IOh9HQTybM5LVY4+ZOaWmHWk1EWByuDOLmA4vNfx06e4r5Ix?=
 =?us-ascii?Q?lmu2CINoypf9B59zpgmEjj+rUeW+9hKyDpkWw0Nhzp2xQvle0e1nvcIsLuri?=
 =?us-ascii?Q?7DYd7PDxxz4zJMivhdB5brwGc7MNWab5MDSKKyaWSqXguOYS7hTcDh7sUiIf?=
 =?us-ascii?Q?BFDpdaGjzJxS+Yf05sHTOhei3PhsGiNRaSTtPXCdWk0aVnauNys3K5c/axR9?=
 =?us-ascii?Q?p7vUCG897g3VJ5+T9Gc+p9+wkgDqRpU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce10f4d5-2de1-4906-77f4-08da47fa21bc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:21:26.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hk+E/xT+XXionsxsHru8Hd5hHjGxhcMF8MCm8W4SdC9quS8tbZhu4EYneI4VSJ5UIKeHgu0uRRnjn4kzAwEIKiLCs7rYOqfbxNVtAY58xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1608
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: CZSg37F4XgPhjWi-vpaGv2zLr2aUUya_
X-Proofpoint-ORIG-GUID: CZSg37F4XgPhjWi-vpaGv2zLr2aUUya_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces two optimizations in the huge page clearing path:

 1. extends the clear_page() machinery to also handle extents larger
    than a single page.
 2. support non-cached page clearing for huge and gigantic pages.

The first optimization is useful for hugepage fault handling, the
second for prefaulting, or for gigantic pages.

The immediate motivation is to speedup creation of large VMs backed
by huge pages.

Performance
==

VM creation (192GB VM with prealloc'd 2MB backing pages) sees significant
run-time improvements:

 Icelakex:
                          Time (s)        Delta (%)
 clear_page_erms()     22.37 ( +- 0.14s )            #  9.21 bytes/ns
 clear_pages_erms()    16.49 ( +- 0.06s )  -26.28%   # 12.50 bytes/ns
 clear_pages_movnt()    9.42 ( +- 0.20s )  -42.87%   # 21.88 bytes/ns

 Milan:
                          Time (s)        Delta (%)
 clear_page_erms()     16.49 ( +- 0.06s )            # 12.50 bytes/ns
 clear_pages_erms()    11.82 ( +- 0.06s )  -28.32%   # 17.44 bytes/ns
 clear_pages_clzero()   4.91 ( +- 0.27s )  -58.49%   # 41.98 bytes/ns

As a side-effect, non-polluting clearing by eliding zero filling of
caches also shows better LLC miss rates. For a kbuild+background
page-clearing job, this gives up as a small improvement (~2%) in
runtime.

Discussion
==


With the motivation out of the way, the following note describes
v3's handling of past review comments (and other sticking points for
series of this nature -- especially the non-cached part -- over the
years):

1. Non-cached clearing is unnecessary on x86: x86 already uses 'REP;STOS'
   which unlike a MOVNT loop, has semantically richer information available
   which can be used by current (and/or future) processors to make the
   same cache-elision optimization.

   All true, except a) current-gen uarchs often don't and, b) even when
   they do, the kernel by clearing at 4K granularity doesn't expose
   the extent information in a way that processors could easily
   optimize for.

   For a), I tested a bunch of REP-STOSB/MOVNTI/CLZERO loops with different
   chunk sizes (in user-space over a VA extent of 4GB, page-size=4K.)

   Intel Icelake (LLC=48MB, no_turbo=1):

     chunk-size    REP-STOSB       MOVNTI
                        MBps         MBps

             4K         9444        24510
            64K        11931        24508
             2M        12355        24524
             8M        12369        24525
            32M        12368        24523
           128M        12374        24522
            1GB        12372        24561

   Which is pretty flat across chunk-sizes.


   AMD Milan (LLC=32MB, boost=0):

     chunk-size    REP-STOSB       MOVNTI        CLZERO 
                        MBps         MBps          MBps 
                                                        
             4K        13034        17815         45579 
            64K        15196        18549         46038 
             2M        14821        18581         39064 
             8M        13964        18557         46045 
            32M        22525        18560         45969 
           128M        29311        18581         38924 
            1GB        35807        18574         45981 

    The scaling on Milan starts right around chunk=LLC-size. It
    asymptotically does seem to get close to CLZERO performance, but the
    scaling is linear and not a step function.

    For b), as I mention above, the kernel by zeroing at 4K granularity,
    doesn't send the right signal to the uarch (though the largest
    extent we can use for huge pages is 2MB (and lower for preemptible
    kernels), which from these numbers is not large enough.)
    Still using clear_page_extent() with larger extents would send the
    uarch a hint that it could capitalize on in the future.

    This is addressed in patches 1-6:
	"mm, huge-page: reorder arguments to process_huge_page()"
	"mm, huge-page: refactor process_subpage()"
	"clear_page: add generic clear_user_pages()"
	"mm, clear_huge_page: support clear_user_pages()"
	"mm/huge_page: generalize process_huge_page()"
	"x86/clear_page: add clear_pages()"

     with patch 5, "mm/huge_page: generalize process_huge_page()"
     containing the core logic.

2. Non-caching stores (via MOVNTI, CLZERO on x86) are weakly ordered with
   respect to the cache hierarchy and unless they are combined with an
   appropriate fence, are unsafe to use.

   This is true and is a problem. Patch 12, "sparse: add address_space
   __incoherent" adds a new sparse address_space which is used in
   the architectural interfaces to make sure that any user is cognizant
   of its use:

	void clear_user_pages_incoherent(__incoherent void *page, ...)
	void clear_pages_incoherent(__incoherent void *page, ...)

   One other place it is needed (and is missing) is in highmem:
       void clear_user_highpages_incoherent(struct page *page, ...).

   Given the natural highmem interface, I couldn't think of a good
   way to add the annotation here.

3. Non-caching stores are generally slower than cached for extents
   smaller than LLC-size, and faster for larger ones.

   This means that if you choose the non-caching path for too small an
   extent, you would see performance regressions. There is of course
   benefit in not filling the cache with zeroes but that is a somewhat
   nebulous advantage and AFAICT there is no representative tests that
   probe for it.
   (Note that this slowness isn't a consequence of the extra fence --
   that is expensive but stops being noticeable for chunk-size >=
   ~32K-128K depending on uarch.)

   This is handled by adding an arch specific threshold (with a
   default CLEAR_PAGE_NON_CACHING_THRESHOLD=8MB.) in patches 15 and 16,
   "mm/clear_page: add clear_page_non_caching_threshold()",
   "x86/clear_page: add arch_clear_page_non_caching_threshold()".

   Further, a single call to clear_huge_pages() or get_/pin_user_pages()
   might only see a small portion of an extent being cleared in each
   iteration. To make sure we choose non-caching stores when working with
   large extents, patch 18, "gup: add FOLL_HINT_BULK,
   FAULT_FLAG_NON_CACHING", adds a new flag that gup users can use for
   this purpose. This is used in patch 20, "vfio_iommu_type1: specify
   FOLL_HINT_BULK to pin_user_pages()" while pinning process memory
   while attaching passthrough PCIe devices.
  
   The get_user_pages() logic to handle these flags is in patch 19,
   "gup: hint non-caching if clearing large regions".

4. Subpoint of 3) above (non-caching stores are faster for extents
   larger than LLC-sized) is generally true, with a side of Brownian
   motion thrown in. For instance, MOVNTI (for > LLC-size) performs well
   on Broadwell and Ice Lake, but on Skylake/Cascade-lake -- sandwiched
   in between the two, it does not.

   To deal with this, use Ingo's suggestion of "trust but verify",
   (https://lore.kernel.org/lkml/20201014153127.GB1424414@gmail.com/)
   where we enable MOVNT by default and only disable it on slow
   uarchs.
   If the non-caching path ends up being a part of the kernel, uarchs
   that regress would hopefully show up early enough in chip testing.

   Patch 11, "x86/cpuid: add X86_FEATURE_MOVNT_SLOW" adds this logic
   and patch 21, "x86/cpu/intel: set X86_FEATURE_MOVNT_SLOW for
   Skylake" disables the non-caching path for Skylake.

Performance numbers are in patches 6 and 19, "x86/clear_page: add
clear_pages()", "gup: hint non-caching if clearing large regions".

Also at:
  github.com/terminus/linux clear-page-non-caching.upstream-v3

Comments appreciated!

Changelog
==

v2: https://lore.kernel.org/lkml/20211020170305.376118-1-ankur.a.arora@oracle.com/
  - Add multi-page clearing: this addresses comments from Ingo
    (from v1), and from an offlist discussion with Linus.
  - Rename clear_pages_uncached() to make the lack of safety
    more obvious: this addresses comments from Andy Lutomorski.
  - Simplify the clear_huge_page() changes.
  - Usual cleanups etc.
  - Rebased to v5.18.


v1: https://lore.kernel.org/lkml/20201014083300.19077-1-ankur.a.arora@oracle.com/
  - Make the unsafe nature of clear_page_uncached() more obvious.
  - Invert X86_FEATURE_NT_GOOD to X86_FEATURE_MOVNT_SLOW, so we don't
    have to explicitly enable it for every new model: suggestion from
    Ingo Molnar.
  - Add GUP path (and appropriate threshold) to allow the uncached path
    to be used for huge pages.
  - Make the code more generic so it's tied to fewer x86 specific assumptions.

Thanks
Ankur

Ankur Arora (21):
  mm, huge-page: reorder arguments to process_huge_page()
  mm, huge-page: refactor process_subpage()
  clear_page: add generic clear_user_pages()
  mm, clear_huge_page: support clear_user_pages()
  mm/huge_page: generalize process_huge_page()
  x86/clear_page: add clear_pages()
  x86/asm: add memset_movnti()
  perf bench: add memset_movnti()
  x86/asm: add clear_pages_movnt()
  x86/asm: add clear_pages_clzero()
  x86/cpuid: add X86_FEATURE_MOVNT_SLOW
  sparse: add address_space __incoherent
  clear_page: add generic clear_user_pages_incoherent()
  x86/clear_page: add clear_pages_incoherent()
  mm/clear_page: add clear_page_non_caching_threshold()
  x86/clear_page: add arch_clear_page_non_caching_threshold()
  clear_huge_page: use non-cached clearing
  gup: add FOLL_HINT_BULK, FAULT_FLAG_NON_CACHING
  gup: hint non-caching if clearing large regions
  vfio_iommu_type1: specify FOLL_HINT_BULK to pin_user_pages()
  x86/cpu/intel: set X86_FEATURE_MOVNT_SLOW for Skylake

 arch/alpha/include/asm/page.h                |   1 +
 arch/arc/include/asm/page.h                  |   1 +
 arch/arm/include/asm/page.h                  |   1 +
 arch/arm64/include/asm/page.h                |   1 +
 arch/csky/include/asm/page.h                 |   1 +
 arch/hexagon/include/asm/page.h              |   1 +
 arch/ia64/include/asm/page.h                 |   1 +
 arch/m68k/include/asm/page.h                 |   1 +
 arch/microblaze/include/asm/page.h           |   1 +
 arch/mips/include/asm/page.h                 |   1 +
 arch/nios2/include/asm/page.h                |   2 +
 arch/openrisc/include/asm/page.h             |   1 +
 arch/parisc/include/asm/page.h               |   1 +
 arch/powerpc/include/asm/page.h              |   1 +
 arch/riscv/include/asm/page.h                |   1 +
 arch/s390/include/asm/page.h                 |   1 +
 arch/sh/include/asm/page.h                   |   1 +
 arch/sparc/include/asm/page_32.h             |   1 +
 arch/sparc/include/asm/page_64.h             |   1 +
 arch/um/include/asm/page.h                   |   1 +
 arch/x86/include/asm/cacheinfo.h             |   1 +
 arch/x86/include/asm/cpufeatures.h           |   1 +
 arch/x86/include/asm/page.h                  |  26 ++
 arch/x86/include/asm/page_64.h               |  64 ++++-
 arch/x86/kernel/cpu/amd.c                    |   2 +
 arch/x86/kernel/cpu/bugs.c                   |  30 +++
 arch/x86/kernel/cpu/cacheinfo.c              |  13 +
 arch/x86/kernel/cpu/cpu.h                    |   2 +
 arch/x86/kernel/cpu/intel.c                  |   2 +
 arch/x86/kernel/setup.c                      |   6 +
 arch/x86/lib/clear_page_64.S                 |  78 ++++--
 arch/x86/lib/memset_64.S                     |  68 ++---
 arch/xtensa/include/asm/page.h               |   1 +
 drivers/vfio/vfio_iommu_type1.c              |   3 +
 fs/hugetlbfs/inode.c                         |   7 +-
 include/asm-generic/clear_page.h             |  69 +++++
 include/asm-generic/page.h                   |   1 +
 include/linux/compiler_types.h               |   2 +
 include/linux/highmem.h                      |  46 ++++
 include/linux/mm.h                           |  10 +-
 include/linux/mm_types.h                     |   2 +
 mm/gup.c                                     |  18 ++
 mm/huge_memory.c                             |   3 +-
 mm/hugetlb.c                                 |  10 +-
 mm/memory.c                                  | 264 +++++++++++++++----
 tools/arch/x86/lib/memset_64.S               |  68 ++---
 tools/perf/bench/mem-memset-x86-64-asm-def.h |   6 +-
 47 files changed, 680 insertions(+), 144 deletions(-)
 create mode 100644 include/asm-generic/clear_page.h

-- 
2.31.1

