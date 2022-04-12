Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB544FE2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiDLNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiDLNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:35:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F610FC7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:33:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CAPB8G018415;
        Tue, 12 Apr 2022 13:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ktno/n5FxtHyNBU0GJ/TF0WAYal9RP4ZgDr5sfsCW5E=;
 b=OBvd8Km8Uw/sCwNVUHaopBwhD1pT9qpl7PFcFgWTL2a4FDhHFFpw+Qq4Y87bNEPr/YbS
 VR1lVn6kVj8s+pOLwjAqZwVATTTDFwfX7hnkydHEUmitSSvIH0/f6/P1OyGJ825bWp9W
 8hu1yOkoGjW8a/1ARaMQXbHizwMqJ4iGCeRlta+KAd4bgm43TFhU2dNIGy/GQEyqADfS
 1RIlRQ2fKF1mgX/aUQPnB8kLc+JsasxGoYhA52gpDNZdSJAU1hH1bO/zgTvyLCumwK5u
 n6p/jA0gm2Ikfy6FAdsOKBXvY8AAWlHTPPh4ux99aewtwDff89ExmaOM0WfYSIN9zt4k mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1ess8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 13:32:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CDGNr1022155;
        Tue, 12 Apr 2022 13:32:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck12qpur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 13:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJe+kFawO+/pE7OC6ybtCjUKJtN7JxhsztX7fAwSxdxSn7q8bcSrVnoI4Ew1zZVVIKXj1SSLNmry5t2zCbMs8ejWxH/IyfdfbdryGClGhH77c62UDKsEoQWb6jItY9dPmCxOf7Q6Ee3tto6R+qM3Ufj6yHsfw2AEgExRgq+yPubtsr4dv1CWhE7G1EBcRSZHmEa7+zIhBP94V2n1lFGYcyDXU/6VofO0u4FLCRjqpA+VaOMtbU1I7dKqpA7Ed4oi72UQW6qFibRcVucU+qO9D4c/nt5vXVdlNfe8EOxpTuMPKLUuFVQ4mLXBwoMEO7/d5pyHsh32B5CF+v6Zl0keow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktno/n5FxtHyNBU0GJ/TF0WAYal9RP4ZgDr5sfsCW5E=;
 b=Kag01zNd7/DIVFEyCzodGZRuw9X8zI21iZMYHAvnpxVxGbsFnV4XpDB365jb30IMRr7VdOE00CHajF9FLFVVil/nduv7Ul9GPOMGTQTTYktdvZAqsWTpqyANaOJrblm36BNRBpS6U04CTxyP4T06Jro/nFQYnRUcYrCAMPMk1sjuYyyUUMtImHNLhZ011rk1bTK9+bLLBsAd1Ulaf3E8k5abvrqsFBz5VxipVUGFHDrgaeYDpmLDrtd64AB8YgHSxGsuJAOgS+hgY8LSilO0V3ZxGEbpNbdNEdKX4mrPL4EhAaVK0t/W8U4UPcbdarpxD/Nkm+XjgbEg2DlutB990w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktno/n5FxtHyNBU0GJ/TF0WAYal9RP4ZgDr5sfsCW5E=;
 b=uzoa4luGM7r1i4H/w3dpXh764Y080XjLEpct2OvvDtdGpMH2M3mM73WLNsW8gxhSgJj1v9hdiYbTw+/jq6B3ZSvAPDpBU9vGLqR+m00qOmGGMSB2lCKW8aqL66VTd51pi5BdnsK/4qXZx/CDahveUqKqn1vsWiwT9IXXnVvvwHA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB4085.namprd10.prod.outlook.com
 (2603:10b6:a03:11f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:32:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 13:32:50 +0000
Date:   Tue, 12 Apr 2022 16:32:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 107/109] fs/nfs/file.c:679 nfs_file_write()
 error: uninitialized symbol 'written'.
Message-ID: <202204122125.n4b4u3oe-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1ebbbe-09d3-48a4-cc86-08da1c88f0a4
X-MS-TrafficTypeDiagnostic: BYAPR10MB4085:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB40854DE16F849AB969E6A34E8EED9@BYAPR10MB4085.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eMUFJoTQ8gWSlvE+74ECO0BXCguk0FJiFwnTKR7V637t4qMcsk8pWTuJfk1Y0gREnJzrEs2uGrME3rHRm5podJfA39dkRr1MVv3oJMLl7EE/66yRnwkYakuGnhB0uDCZ2C17FrunnJdBgKZD+if17SAgyt8YMNW1DI5u9lX3ba5gueb1eMsicNbaskd7xudT9jlVwhHPCZ8Ev+hb51wT9TmhwGTRXGdlYyXrisPV4iGvGhqg2ZWb0H7xczg1CByaAfM7hI0Wonbpi4c3w1FErjaLiCINxSv1/z3vfyJNCeHKenR0keDfH+WIbvs2Uc9KoIlmkEj3MY/L6tEvdP2avZRhzEdXwFCuuZ1FugO4AZ/BtSAbMFYxWYi5J2ysL9SHDsZEWzFzbEw+XiOh08KHVwy2V58nIRxcvjw5y7EhEs0nVHwoHHA3kfjUdSmjrKVVJWUEgm5VhKP3yYyPFg8uumsAfcxcGDTIPjkyO6KtYLeMcOa9FD9i8C18dw/5kTZCGCjfk77Z/adSHTopfbWlr22f1qHOjDAX0bdNWtYSm81BkSyuzZfpRIKONKke3p0NezKkZ2ps4/oZYhrAVPcsJfMP+2iEdngCK/uGOFmzKrQobHCtqsO33lJImdsCJDgpRSewOKPUHPwPtQO0EagB7nkbGZMG/Gixx89dvk0tOEc5yPeefkThLmijtzTbwwDSzs7C/ZVi/EovE3HiftqRPA8FT5cs+fpqiQbRXpiEGzzH0nXXxzEDvMaDElaswc3fHDSK45y/y+op/D6UZWVFj90d1JmUvUaR29YE5FnFHqwnS4wha6RONhXkA7AP4AQumO9rnUvGuhIVHhNBRF7+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(8936002)(6666004)(44832011)(86362001)(9686003)(1076003)(6506007)(38100700002)(2906002)(508600001)(38350700002)(6512007)(5660300002)(316002)(6916009)(26005)(83380400001)(186003)(52116002)(8676002)(4326008)(66946007)(66556008)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50dlLAk+3PdeaH1XXVbK+uE1JzHYI2+6b8FPY9SY/n+1cL8tRtECmteh6e+T?=
 =?us-ascii?Q?eE7zvRddqoKFaEcu1H1NQMpxMhz6T0vsCuOC1+2D+jBa1W4bhTAWTMS403eQ?=
 =?us-ascii?Q?XksQwQnImh58u5a7zlrmusgE5Yf8LJ3zi6fIXBoXLJ99WE3gwS4cwHRdF8Rq?=
 =?us-ascii?Q?dwlrnqNiK4qZzX/DfoA98n1aHmuJJA+Dxpig9LslqRxReeG4rh2BivFxVJDK?=
 =?us-ascii?Q?lrUT5Cs9W1irlpz9gATm6M96DKqHhab7WcCot2uf5gGLxQj4tQS/flY6ryj6?=
 =?us-ascii?Q?IaMacI2oyCYcPa84OeHckN8qYCILDSYHkR3i1ayCZ+cK5fiDcjCLkYH9wZa/?=
 =?us-ascii?Q?IxkQI6mXYahifr8y0wGhqkquNz+EI4kzkOHBRyNgOFELtce9OpXvHJmSAWqX?=
 =?us-ascii?Q?11GDn913y/4/rB4pGBWjvkbBpiX2pr7g/MXxNohfeLSjW1aVwxS6MRdxfFNH?=
 =?us-ascii?Q?AodkfAhRUSE0wNzXSowvzysUlgjOII9QwvRPJbacjLmraW9/BsWe6MgO2k0c?=
 =?us-ascii?Q?Y9k8vCyIYT/xYhxyJe/pexQxwjcheOT8Vg4PJIDOSFtcns3m9teTDNyPNLAl?=
 =?us-ascii?Q?+0gmiSaQe5/htKAwu8fuu+I0xiaFkbnmdcUjEKYV+Hd9eg7KfsNIXIgECP6z?=
 =?us-ascii?Q?JHzjtLFdTZvnZPniASEs3uupobpCgSR7BlutC/T7ZGv0tRXaM+otOih2Cfl9?=
 =?us-ascii?Q?voaJ2hg+fs4Iyc0/7BZ1V4lg5gCEa8TQGHnhJQvyjBmGQBHtTzoVlSpcMr3b?=
 =?us-ascii?Q?Zev4LMuc/BfCkVt3rQpZYpSt1nRSHgZKq3h6Jg9ehteshwRpDREOIyTiu9dC?=
 =?us-ascii?Q?t1xkgvS8jxrGmp5M6BNH4jQPVbD7OlPL+u0mtl5a/9ARCW9L4LKZ1uDT7t7W?=
 =?us-ascii?Q?ne5Yv86EY0qbr002FGuGQ1MHsPsWhoo1WyaIxEL8cxmdpLmtdV1RF1D9hrpq?=
 =?us-ascii?Q?wd2/3Gtug5jsAyx84VcyARLjd9XpPOkHeXwqplPpEOEMaySnXh52Vur0y29T?=
 =?us-ascii?Q?WOC1O1lkMByu6A1+lQ5ctbZO5hOWWI1OFfDmxCvZ0PbNWc3cuvhJX/3pQLAW?=
 =?us-ascii?Q?HOdq8N53+sqrmJlS3A08Qk/5Yz9yO043EbvdnxRrpbaPBpse4bADZDDej+uz?=
 =?us-ascii?Q?+WixdtClgKGy174IckeSG/EnFAkL7wGj3zGMKG6MK42QbRDlisD5RFjem1xI?=
 =?us-ascii?Q?Nh5cWEUGOi90ASQ9htnCWz6RzOuOqjdkV0HGujqlFE03RCBU5tBNC4t+Wcsu?=
 =?us-ascii?Q?EzcW/HYblS1+Ajr+fl/IQNtkVNgwXqPl5xiCjSNdgIy9hiuPyF47t36fMU/N?=
 =?us-ascii?Q?pVNnTo4E+wzKx9Kham3E6MH9faKvk7zWowvS+/yDx25Mcl8ijqZjX84WLX4B?=
 =?us-ascii?Q?3uhX6E89C9cFsL9Xs4nNgEpKPd1Sl9T6HP+AilAHVogakcxIPgcyHrngHe7c?=
 =?us-ascii?Q?KZKdB0ERsn2W6pUpo24MJI3qxzncVvMel7ycG2uYe5/zdPK8oIK6bvoMP2lN?=
 =?us-ascii?Q?luDDR+G43nqpetYlUV7jVelZJoiyQq4o3o6Zbbke1jEyVQmby9BO/I+6pssb?=
 =?us-ascii?Q?XIXKkatdq82G8qpXjXOSMVVrR358s+0cQJP2VpCxrH7gDCM2dRPQVwcO/3Ci?=
 =?us-ascii?Q?pxbeUB8XDsAe6kpbEYCffA/K0XpcG4/rojbz95NNSCvR0s1oE7dzDLRl3zk/?=
 =?us-ascii?Q?YFzh4oHQhKZeoXar+2Rr12Gg48h+SbFI5qsTGlwLFPLBuN55FhFLre4jCkGn?=
 =?us-ascii?Q?4dKGlUBNTUoY6DMBTOA9nNWVr/Ekfqg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1ebbbe-09d3-48a4-cc86-08da1c88f0a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:32:50.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzmp12yO0kqRG/4FWfvdmFA2uiNS40TLgfWfo5pL4+dwwLQRZjTHO1tovRkO2W/ZmX612s1agaJTRao34RSDN9PNUZCF7mBSveBiz3wBCAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_04:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120064
X-Proofpoint-GUID: 5zVm0u1qlU65VE8IIH6_QyY6F9lMo837
X-Proofpoint-ORIG-GUID: 5zVm0u1qlU65VE8IIH6_QyY6F9lMo837
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   b9d284d92b8b0f614c96193391741893d3680c89
commit: bf5e5c86c50f9dbbda976beb6d59bfac31302f5e [107/109] NFS: Don't report ENOSPC write errors twice
config: i386-randconfig-m021-20220411 (https://download.01.org/0day-ci/archive/20220412/202204122125.n4b4u3oe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/nfs/file.c:679 nfs_file_write() error: uninitialized symbol 'written'.

vim +/written +679 fs/nfs/file.c

edaf43694898c5 Al Viro            2014-04-03  601  ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
^1da177e4c3f41 Linus Torvalds     2005-04-16  602  {
6de1472f1a4a3b Al Viro            2013-09-16  603  	struct file *file = iocb->ki_filp;
6de1472f1a4a3b Al Viro            2013-09-16  604  	struct inode *inode = file_inode(file);
ed7bcdb374d20f Trond Myklebust    2021-02-12  605  	unsigned int mntflags = NFS_SERVER(inode)->flags;
ed7bcdb374d20f Trond Myklebust    2021-02-12  606  	ssize_t result, written;
ce368536dd6144 Scott Mayhew       2020-08-01  607  	errseq_t since;
ce368536dd6144 Scott Mayhew       2020-08-01  608  	int error;
^1da177e4c3f41 Linus Torvalds     2005-04-16  609  
6de1472f1a4a3b Al Viro            2013-09-16  610  	result = nfs_key_timeout_notify(file, inode);
dc24826bfca8d7 Andy Adamson       2013-08-14  611  	if (result)
dc24826bfca8d7 Andy Adamson       2013-08-14  612  		return result;
dc24826bfca8d7 Andy Adamson       2013-08-14  613  
89698b24d24f9c Trond Myklebust    2016-06-23  614  	if (iocb->ki_flags & IOCB_DIRECT)
64158668ac8b31 NeilBrown          2022-03-07  615  		return nfs_file_direct_write(iocb, from, false);
^1da177e4c3f41 Linus Torvalds     2005-04-16  616  
619d30b4b8c488 Al Viro            2014-03-04  617  	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
18290650b1c865 Trond Myklebust    2016-06-23  618  		file, iov_iter_count(from), (long long) iocb->ki_pos);
^1da177e4c3f41 Linus Torvalds     2005-04-16  619  
^1da177e4c3f41 Linus Torvalds     2005-04-16  620  	if (IS_SWAPFILE(inode))
^1da177e4c3f41 Linus Torvalds     2005-04-16  621  		goto out_swapfile;
7d52e86274e09f Trond Myklebust    2005-06-22  622  	/*
7d52e86274e09f Trond Myklebust    2005-06-22  623  	 * O_APPEND implies that we must revalidate the file length.
7d52e86274e09f Trond Myklebust    2005-06-22  624  	 */
fc9dc401899ab2 Trond Myklebust    2021-02-08  625  	if (iocb->ki_flags & IOCB_APPEND || iocb->ki_pos > i_size_read(inode)) {
6de1472f1a4a3b Al Viro            2013-09-16  626  		result = nfs_revalidate_file_size(inode, file);
^1da177e4c3f41 Linus Torvalds     2005-04-16  627  		if (result)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  628  			return result;
fe51beecc55d0b Trond Myklebust    2005-06-22  629  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  630  
28aa2f9e73e762 Trond Myklebust    2021-02-08  631  	nfs_clear_invalid_mapping(file->f_mapping);
28aa2f9e73e762 Trond Myklebust    2021-02-08  632  
ce368536dd6144 Scott Mayhew       2020-08-01  633  	since = filemap_sample_wb_err(file->f_mapping);
a5864c999de670 Trond Myklebust    2016-06-03  634  	nfs_start_io_write(inode);
18290650b1c865 Trond Myklebust    2016-06-23  635  	result = generic_write_checks(iocb, from);
18290650b1c865 Trond Myklebust    2016-06-23  636  	if (result > 0) {
18290650b1c865 Trond Myklebust    2016-06-23  637  		current->backing_dev_info = inode_to_bdi(inode);
18290650b1c865 Trond Myklebust    2016-06-23  638  		result = generic_perform_write(file, from, iocb->ki_pos);
18290650b1c865 Trond Myklebust    2016-06-23  639  		current->backing_dev_info = NULL;
18290650b1c865 Trond Myklebust    2016-06-23  640  	}
a5864c999de670 Trond Myklebust    2016-06-03  641  	nfs_end_io_write(inode);
18290650b1c865 Trond Myklebust    2016-06-23  642  	if (result <= 0)
^1da177e4c3f41 Linus Torvalds     2005-04-16  643  		goto out;
                                                                ^^^^^^^^^

^1da177e4c3f41 Linus Torvalds     2005-04-16  644  
c49edecd513693 Trond Myklebust    2016-09-03  645  	written = result;
18290650b1c865 Trond Myklebust    2016-06-23  646  	iocb->ki_pos += written;
ed7bcdb374d20f Trond Myklebust    2021-02-12  647  
ed7bcdb374d20f Trond Myklebust    2021-02-12  648  	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
ed7bcdb374d20f Trond Myklebust    2021-02-12  649  		result = filemap_fdatawrite_range(file->f_mapping,
ed7bcdb374d20f Trond Myklebust    2021-02-12  650  						  iocb->ki_pos - written,
ed7bcdb374d20f Trond Myklebust    2021-02-12  651  						  iocb->ki_pos - 1);
ed7bcdb374d20f Trond Myklebust    2021-02-12  652  		if (result < 0)
ed7bcdb374d20f Trond Myklebust    2021-02-12  653  			goto out;
ed7bcdb374d20f Trond Myklebust    2021-02-12  654  	}
ed7bcdb374d20f Trond Myklebust    2021-02-12  655  	if (mntflags & NFS_MOUNT_WRITE_WAIT) {
ed7bcdb374d20f Trond Myklebust    2021-02-12  656  		result = filemap_fdatawait_range(file->f_mapping,
ed7bcdb374d20f Trond Myklebust    2021-02-12  657  						 iocb->ki_pos - written,
ed7bcdb374d20f Trond Myklebust    2021-02-12  658  						 iocb->ki_pos - 1);
ed7bcdb374d20f Trond Myklebust    2021-02-12  659  		if (result < 0)
ed7bcdb374d20f Trond Myklebust    2021-02-12  660  			goto out;
ed7bcdb374d20f Trond Myklebust    2021-02-12  661  	}
e973b1a5999e57 tarangg@amazon.com 2017-09-07  662  	result = generic_write_sync(iocb, written);
e973b1a5999e57 tarangg@amazon.com 2017-09-07  663  	if (result < 0)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  664  		return result;
bf5e5c86c50f9d Trond Myklebust    2022-04-09  665  out:

Looks like the out label moved?

7e94d6c4ab6956 Trond Myklebust    2015-08-17  666  	/* Return error values */
ce368536dd6144 Scott Mayhew       2020-08-01  667  	error = filemap_check_wb_err(file->f_mapping, since);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  668  	switch (error) {
bf5e5c86c50f9d Trond Myklebust    2022-04-09  669  	default:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  670  		break;
bf5e5c86c50f9d Trond Myklebust    2022-04-09  671  	case -EDQUOT:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  672  	case -EFBIG:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  673  	case -ENOSPC:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  674  		nfs_wb_all(inode);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  675  		error = file_check_and_advance_wb_err(file);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  676  		if (error < 0)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  677  			result = error;
200baa2112012d Trond Myklebust    2006-12-05  678  	}
7e381172cf6e02 Chuck Lever        2010-02-01 @679  	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
                                                                                                        ^^^^^^^

^1da177e4c3f41 Linus Torvalds     2005-04-16  680  	return result;
^1da177e4c3f41 Linus Torvalds     2005-04-16  681  
^1da177e4c3f41 Linus Torvalds     2005-04-16  682  out_swapfile:
^1da177e4c3f41 Linus Torvalds     2005-04-16  683  	printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
89658c4d04c766 Anna Schumaker     2019-11-08  684  	return -ETXTBSY;
^1da177e4c3f41 Linus Torvalds     2005-04-16  685  }
-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

