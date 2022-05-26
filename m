Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7465349B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiEZEXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 00:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiEZEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 00:22:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D165A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 21:22:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q44Mbn012041;
        Thu, 26 May 2022 04:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JL6pnQWpiW+76B8Q8bw4+nNbska3kgEbWWaTUow/l04=;
 b=nmR5oz/m/AS6H1BNA97U7CSSLGZI18YCdXx6Rgn5IkjR0k6USUlgeybS+ypCUfHtY2Ot
 OjX4Nkkd7iFuR8JAgPXfEJn4bs3CCaLHs+WcSNE/Ju8osi4wdt0SFwQDzs3Oftus0sAj
 CyULofoVv30DSIj/WTmlRypUlomPUo0g89PqOeWS8lAsGXI9f0kPMqZPE2wLpVioOUGb
 MXZ7fku+s6RLO2nmhpFOewWieavvuptc36/QBCX9TID4flFFiepcN4pvB2vrCkgU5bAx
 yyT/rShZ2vgt0Xtzm58uP+9U7DE//ZTvjdSAtZMPK6HnDHqkahbyLPL76f2+Edec9bBB EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9ut60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 04:22:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24Q4GNMK013775;
        Thu, 26 May 2022 04:22:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x6c91r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 04:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAccR6cJnloJXGxiQ3YxaXjM8fmk1dSzybx/xmkQNCKSdRvAcEbbh3ofIzoW3eB6Xfid0YqoN3RWiOW0Yj9T/7Oh7/g63evtOrT0y6UYrFTn9VBbNWKz3KWsfQvbT50CkRpaJufvC/NfGZd4MatB/N2T7Q8YMmzafUdZGFp5l4ZmwysGUFNITv7fPRvOQEosMLlQqrmwizjYd5mvEPrKb8mVIc0dDEOlc16n0OxY1mjzas7xpJFndgE4Z8X5ZgWZuf8tNajFe7NibHBg8nJ2ZWEAUKZkZVnRq17YKmEC3mnRGChboX+bhrER7T+mgDRKuzy0Q0dd2/fRkbJkjN/LJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL6pnQWpiW+76B8Q8bw4+nNbska3kgEbWWaTUow/l04=;
 b=RukxYEjnYEvfc+D83pTtLqcWHAPefG4S8Hh4ctJvNXtB5/RtxYDD4zZP+m/oJbaLkEsD3dLpNoxM4rGv2e1FCde0Y3d4Pl+hV958MI61ckI+hT+lGms9NP1YXIRGpCsmW/Ff1sKc2B9MHcTMOeFgRzf24xAeIe5Qg/bNnMnfpnuhkBLufsn45YY2/Y1lSqfGuV+vKkHmPEH4CRgtySbuh5QabaafmJz0OrogNFhfbPyY0YVqcsMoglZd4MJV29d6JPBulhohEgO7AgQAisORbCfN5GBlVLVXHupFcP7bjfwUmi/TMnKwq0hh+F4a2+wTO+VNbNhqvXk4xB0wPlXMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL6pnQWpiW+76B8Q8bw4+nNbska3kgEbWWaTUow/l04=;
 b=bi3QFs1LmMwfR/NgIPo6zLbf/nfxZ5PnRcR0MpuRwGM63xKhH36seIaaktFOFXbWvtZ6i3hA2Q3e90Lrmh1dTG/r7nAuudRsSKMCUF3RleVtZA7xAvpr7VMnxLR0guj8ZAmz8FhNCopiPDM/9M9r56bWRee+XVBh3MgyTQFoZ2E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4454.namprd10.prod.outlook.com
 (2603:10b6:510:3a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 04:22:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 04:22:43 +0000
Date:   Thu, 26 May 2022 07:22:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Steve French <stfrench@microsoft.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [samba-ksmbd:for-next 28/28] fs/cifs/smb2ops.c:574
 parse_server_interfaces() warn: sleeping in atomic context
Message-ID: <202205260707.SqIvcdsE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: SXXQSVXUHUEI2SH2GD3NOWGA5TJJRAJR
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0179.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb84e07-5bf7-4449-7f47-08da3ecf6096
X-MS-TrafficTypeDiagnostic: PH0PR10MB4454:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44544CF1F2402CF3AF6461F88ED99@PH0PR10MB4454.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQZ0dvdaEoeajC/UXhOJ22ooenAbD2/J1OoczVexUVAknU/jeGnUoHphepcnr30I3iIC+yjQK0Jsne4hPEFU6OAcjT2+je06Is2vQRegg0sGhHpLI+s3FZr2yS94rtL6+ae9DvP3JJT3w/AEceGKplNpwU4KELUlY4MjrDkl/dqiuyzMN5ouRdUCrQdHL/I7GfhIzjJ0k8yFgC5AF6+B9Jd6dnPsYXgKB7DOyzK8Ou46P6fZRgU84nP065V3P/lALoizJILHJiM66unUMX+bkxjWUwppx7jWZrhF7lJwzabXlYvDhDZU//iWMzgntQ8ph1hOGjCcQP82hi38l7ErydCp1f5cS30XtkxE3Px77t5nBoUhF8pWrS20KGw7uQPsu6ruTkYOz2YRHtQXohkdWhXn3rFo6X5CASgank2bBL/o4b8+DVL5eitVN1HMkwdDv49nsUFQcVWrZGhyf338kmx4H9L9H7SgoIPExqU9SDFrBbdvypYYzTmXKpQ4KNLWA8sfo2oRrdr4N8XEsaR8PoK3DKsoWpkwAdn4oR5U7wIxATuhHgD5iaH5at2U1cseoYsGrNXnKmT0x5aCLQ2qI4bYFi2+Q+uV1Jfrw9nx0NmKBGmGTHZJtnlHVWfDPQOfD48N0+Z5V6SEoQqLyyMavASz6XZH7L3RhZAK58zxcYpI5xD+TXXy3cQLKiYrnEMe9mPPGTAZnTWwYbNkcdxc3rWBv1Buyg1IZ0ZNSSGDQB1f2BdUSnP3cbYBBLw52lwc3KnptNTq1gaPwMzCzXEauhz7F9kj2+YnCB6XjTqmYACFcR+nPFwJPVxs0v4qor+mVbfWSzv/V9uRzOW/NEZwuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(38350700002)(316002)(30864003)(6512007)(86362001)(9686003)(66556008)(66946007)(4326008)(36756003)(8936002)(8676002)(66476007)(44832011)(26005)(1076003)(52116002)(6666004)(966005)(83380400001)(6486002)(6506007)(2906002)(508600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbhOCX9u8GwS2DZd7d97w+8347jT+RHzkTAeZlM++ui4a/SKkADnRB+ZpwfZ?=
 =?us-ascii?Q?KfjB+UzHIWXuKHJYvZKJwrZLj+2USczTX4hOj4l/zvbZMsn7DiU8QhiU43mK?=
 =?us-ascii?Q?wXnKUZ2dHJyzfzWHuk6449fcZ+uaBW6TnDBrDtQ8SIHLUklUjo1OmpIp/v3I?=
 =?us-ascii?Q?RqrmqiB9aPFwHDBNk+LH8hg0TCm1hHbZA2jDPCFv3wZSL0cW7081FEYfUdoQ?=
 =?us-ascii?Q?oBdDsS2BGrxGelfdFXGRJyKxnB1UOj0AuoheMAjUl584WpZ7HYZVkkn16Dts?=
 =?us-ascii?Q?Dqi+SHQN4I+AO5ZKcVMhuS2drLyMy/HIRnQk+0L0/gfLQ0beHXcGpQ4Anye8?=
 =?us-ascii?Q?HoFE1Xhreys2wRZiMpuDAJVbkBFdn1D3PSPCncid3A4A385zjDdSzW6p3i3j?=
 =?us-ascii?Q?Cde/qEW/oLCQnS6iejeGYmrouSLnGcfgXdzSxXXXfzk3+C2OIEu6U7Z94CvL?=
 =?us-ascii?Q?3ah0B1xi4spsmyieKTquzvKMECYIkQjjvn17iWEORBkWJZnFxuujnTHagOvf?=
 =?us-ascii?Q?DgZSQE/krkJ59dJ86WLywD3mZzyz8tcNWmz7cUR6GoExtsh1tsrq68OIJXsV?=
 =?us-ascii?Q?wd1UVIDkK1Cp11XHFgB7e/Bs7HDiQnwfY1SR0lrTFA3yP+IsbY1QsUKyx6yX?=
 =?us-ascii?Q?6s1yB70SLT5wWgS1XhXEDuQHbcCeEWNSwNWuZjk2V8AeRP3U64qici9R7RAx?=
 =?us-ascii?Q?1ZeacbiQE3L8pMiZGtZBfFiSmd712TDWMExVfGKiikv29g605z7FhtQEcJgg?=
 =?us-ascii?Q?5eEcVSK1O/oYwAvQPnYLcJwfQj5kdV9eUi8VgAtp0XVSucTkm9+enS6lJqQa?=
 =?us-ascii?Q?EyDKJbcxq7zRUfUkkmuSlb4znPsNE/m5rjqz3K+TodsxL99wKpNdg7mc+iP/?=
 =?us-ascii?Q?DqZ+sHFPYwWHNad6W6Q3MhGWaP2/0VS/4UfhH9gWYtGy/3c3LZrwuPWA9Dg4?=
 =?us-ascii?Q?vaLAdH/x4xu22HfoLpee8iXkLwNGkzdpggi+HRtQA/LC1vZRAQ4+B+w1qjV/?=
 =?us-ascii?Q?ojrAl8MuETT0MxYkBfWQz+ZPg5LZhvPyQIUUz6aomghkxUvCJ2oJU/Q1bQi2?=
 =?us-ascii?Q?w7VNq61JJVYwlUIPhwypwewQtxT3uPJadhB3OJMvqUPN6Zo3cwifrzY+6798?=
 =?us-ascii?Q?GIUmViRyvcsEwIzQMAL1On6NDZmSwq3iAFiVSspWV3mMv8O0NHVLreEbzClc?=
 =?us-ascii?Q?Q0glHmncEmfTdRsHNHw9CdLm7g+FZ9dzIxeFVfRo3eUoDOQXnTGIWcls6oB1?=
 =?us-ascii?Q?r98YbocbeU6t5vKb935VOjlh6jt7MwV9e7a3ggvrwhczOhOWnPVnGK/33QSc?=
 =?us-ascii?Q?FagyxvTqECPUCX3UN+WmyiZ3vS+lmqiz/mR76N3IMrZQjUgeUx3TigUG5vHa?=
 =?us-ascii?Q?Qav7PythT/AdVAe5N9wHheycixFfTdDBM9fS7xM8kUoNilCwZExiM27DuSi3?=
 =?us-ascii?Q?Leo4/iTlBrRFOO7PNhKUTAdegIG0Fbdx8q4jKxCNl2ih3fyZkWIhJw4RXsqE?=
 =?us-ascii?Q?LDNVHlIdHpJMsQaQnu8r8/kzohx4qbAEeXaOVeWaDZeiA282P20rTvDaXKNp?=
 =?us-ascii?Q?4e+SU4QQCkNgsfrhVnPd6Vhf/3gxdKzjctXFcDhIu7Ck8lbElTHOKkoPR5Gk?=
 =?us-ascii?Q?SjGJQAKZEax8c9xLIVSrRRGA2OKMOiaPi96B8Uy3Vo0LHgtidRVHb3WLX6DO?=
 =?us-ascii?Q?zh0hGGc5jS0YoUnbr8aKaf++wJLwA4v0xvIWBIy2yFAqM1U84YLKIvElaHre?=
 =?us-ascii?Q?CjHfWqszTn9a5DyL55xyK4pK6+NjB0k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb84e07-5bf7-4449-7f47-08da3ecf6096
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 04:22:42.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTDHEwkqwA9W4SJf6cK+8tJV0YYOCqH68iA6EjE0taRrZL/cZBz5Z0wDKvdXwnDBBRV9O6K1NGG9rEJWmu6buXrT4ZF6Bxr9eGlzpeCnK5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_01:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260022
X-Proofpoint-ORIG-GUID: lfILq106PLt5F0fIH4VviSDuq9WF_s38
X-Proofpoint-GUID: lfILq106PLt5F0fIH4VviSDuq9WF_s38
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   57bf5227c68fc4b9f21eb6bf6ff7dd6e15568776
commit: 57bf5227c68fc4b9f21eb6bf6ff7dd6e15568776 [28/28] smb3: 2 multichannel patches
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220526/202205260707.SqIvcdsE-lkp@intel.com/config )
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/cifs/smb2ops.c:574 parse_server_interfaces() warn: sleeping in atomic context

vim +574 fs/cifs/smb2ops.c

fe856be475f7cf5 Aurelien Aptel 2018-06-14  512  static int
fe856be475f7cf5 Aurelien Aptel 2018-06-14  513  parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
fe856be475f7cf5 Aurelien Aptel 2018-06-14  514  			size_t buf_len,
57bf5227c68fc4b Steve French   2022-05-25  515  			struct cifs_ses *ses)
fe856be475f7cf5 Aurelien Aptel 2018-06-14  516  {
fe856be475f7cf5 Aurelien Aptel 2018-06-14  517  	struct network_interface_info_ioctl_rsp *p;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  518  	struct sockaddr_in *addr4;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  519  	struct sockaddr_in6 *addr6;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  520  	struct iface_info_ipv4 *p4;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  521  	struct iface_info_ipv6 *p6;
57bf5227c68fc4b Steve French   2022-05-25  522  	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
57bf5227c68fc4b Steve French   2022-05-25  523  	struct cifs_server_iface tmp_iface;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  524  	ssize_t bytes_left;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  525  	size_t next = 0;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  526  	int nb_iface = 0;
57bf5227c68fc4b Steve French   2022-05-25  527  	int rc = 0, ret = 0;
57bf5227c68fc4b Steve French   2022-05-25  528  	bool iface_found = false;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  529  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  530  	bytes_left = buf_len;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  531  	p = buf;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  532  
57bf5227c68fc4b Steve French   2022-05-25  533  	spin_lock(&ses->iface_lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Spin lock held

57bf5227c68fc4b Steve French   2022-05-25  534  	/*
57bf5227c68fc4b Steve French   2022-05-25  535  	 * Go through iface_list and do kref_put to remove
57bf5227c68fc4b Steve French   2022-05-25  536  	 * any unused ifaces. ifaces in use will be removed
57bf5227c68fc4b Steve French   2022-05-25  537  	 * when the last user calls a kref_put on it
57bf5227c68fc4b Steve French   2022-05-25  538  	 */
57bf5227c68fc4b Steve French   2022-05-25  539  	list_for_each_entry_safe(iface, niface, &ses->iface_list,
57bf5227c68fc4b Steve French   2022-05-25  540  				 iface_head) {
57bf5227c68fc4b Steve French   2022-05-25  541  		iface->is_active = 0;
57bf5227c68fc4b Steve French   2022-05-25  542  		kref_put(&iface->refcount, release_iface);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  543  	}
fe856be475f7cf5 Aurelien Aptel 2018-06-14  544  
57bf5227c68fc4b Steve French   2022-05-25  545  	while (bytes_left >= sizeof(*p)) {
57bf5227c68fc4b Steve French   2022-05-25  546  		memset(&tmp_iface, 0, sizeof(tmp_iface));
57bf5227c68fc4b Steve French   2022-05-25  547  		tmp_iface.speed = le64_to_cpu(p->LinkSpeed);
57bf5227c68fc4b Steve French   2022-05-25  548  		tmp_iface.rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
57bf5227c68fc4b Steve French   2022-05-25  549  		tmp_iface.rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  550  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  551  		/*
57bf5227c68fc4b Steve French   2022-05-25  552  		 * The iface_list is assumed to be sorted by speed.
57bf5227c68fc4b Steve French   2022-05-25  553  		 * Check if the new interface exists in that list.
57bf5227c68fc4b Steve French   2022-05-25  554  		 * NEVER change iface. it could be in use.
57bf5227c68fc4b Steve French   2022-05-25  555  		 * Add a new one instead
fe856be475f7cf5 Aurelien Aptel 2018-06-14  556  		 */
57bf5227c68fc4b Steve French   2022-05-25  557  		iface_found = false;
57bf5227c68fc4b Steve French   2022-05-25  558  		list_for_each_entry_safe(iface, niface, &ses->iface_list,
57bf5227c68fc4b Steve French   2022-05-25  559  					 iface_head) {
57bf5227c68fc4b Steve French   2022-05-25  560  			ret = iface_cmp(iface, &tmp_iface);
57bf5227c68fc4b Steve French   2022-05-25  561  			if (!ret) {
57bf5227c68fc4b Steve French   2022-05-25  562  				/* just get a ref so that it doesn't get picked/freed */
57bf5227c68fc4b Steve French   2022-05-25  563  				iface->is_active = 1;
57bf5227c68fc4b Steve French   2022-05-25  564  				kref_get(&iface->refcount);
57bf5227c68fc4b Steve French   2022-05-25  565  				goto next_iface;
57bf5227c68fc4b Steve French   2022-05-25  566  			} else if (ret > 0) {
57bf5227c68fc4b Steve French   2022-05-25  567  				/* all remaining ifaces are slower */
57bf5227c68fc4b Steve French   2022-05-25  568  				iface_found = true;
57bf5227c68fc4b Steve French   2022-05-25  569  				break;
57bf5227c68fc4b Steve French   2022-05-25  570  			}
57bf5227c68fc4b Steve French   2022-05-25  571  		}
fe856be475f7cf5 Aurelien Aptel 2018-06-14  572  
57bf5227c68fc4b Steve French   2022-05-25  573  		/* no match. insert the entry in the list */
57bf5227c68fc4b Steve French   2022-05-25 @574  		info = kmalloc(sizeof(struct cifs_server_iface),
57bf5227c68fc4b Steve French   2022-05-25  575  			       GFP_KERNEL);
                                                                               ^^^^^^^^^^
It has to be GFP_ATOMIC under spin lock.

57bf5227c68fc4b Steve French   2022-05-25  576  		if (!info) {
fe856be475f7cf5 Aurelien Aptel 2018-06-14  577  			rc = -ENOMEM;
57bf5227c68fc4b Steve French   2022-05-25  578  			spin_unlock(&ses->iface_lock);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  579  			goto out;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  580  		}
57bf5227c68fc4b Steve French   2022-05-25  581  		memcpy(info, &tmp_iface, sizeof(tmp_iface));
fe856be475f7cf5 Aurelien Aptel 2018-06-14  582  
57bf5227c68fc4b Steve French   2022-05-25  583  		/* add this new entry to the list */
57bf5227c68fc4b Steve French   2022-05-25  584  		kref_init(&info->refcount);
57bf5227c68fc4b Steve French   2022-05-25  585  		info->is_active = 1;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  586  
57bf5227c68fc4b Steve French   2022-05-25  587  		cifs_dbg(FYI, "%s: adding iface %zu\n", __func__, ses->iface_count);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  588  		cifs_dbg(FYI, "%s: speed %zu bps\n", __func__, info->speed);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  589  		cifs_dbg(FYI, "%s: capabilities 0x%08x\n", __func__,
fe856be475f7cf5 Aurelien Aptel 2018-06-14  590  			 le32_to_cpu(p->Capability));
fe856be475f7cf5 Aurelien Aptel 2018-06-14  591  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  592  		switch (p->Family) {
fe856be475f7cf5 Aurelien Aptel 2018-06-14  593  		/*
fe856be475f7cf5 Aurelien Aptel 2018-06-14  594  		 * The kernel and wire socket structures have the same
fe856be475f7cf5 Aurelien Aptel 2018-06-14  595  		 * layout and use network byte order but make the
fe856be475f7cf5 Aurelien Aptel 2018-06-14  596  		 * conversion explicit in case either one changes.
fe856be475f7cf5 Aurelien Aptel 2018-06-14  597  		 */
fe856be475f7cf5 Aurelien Aptel 2018-06-14  598  		case INTERNETWORK:
fe856be475f7cf5 Aurelien Aptel 2018-06-14  599  			addr4 = (struct sockaddr_in *)&info->sockaddr;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  600  			p4 = (struct iface_info_ipv4 *)p->Buffer;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  601  			addr4->sin_family = AF_INET;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  602  			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  603  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  604  			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
fe856be475f7cf5 Aurelien Aptel 2018-06-14  605  			addr4->sin_port = cpu_to_be16(CIFS_PORT);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  606  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  607  			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
fe856be475f7cf5 Aurelien Aptel 2018-06-14  608  				 &addr4->sin_addr);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  609  			break;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  610  		case INTERNETWORKV6:
fe856be475f7cf5 Aurelien Aptel 2018-06-14  611  			addr6 =	(struct sockaddr_in6 *)&info->sockaddr;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  612  			p6 = (struct iface_info_ipv6 *)p->Buffer;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  613  			addr6->sin6_family = AF_INET6;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  614  			memcpy(&addr6->sin6_addr, &p6->IPv6Address, 16);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  615  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  616  			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
fe856be475f7cf5 Aurelien Aptel 2018-06-14  617  			addr6->sin6_flowinfo = 0;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  618  			addr6->sin6_scope_id = 0;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  619  			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  620  
fe856be475f7cf5 Aurelien Aptel 2018-06-14  621  			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
fe856be475f7cf5 Aurelien Aptel 2018-06-14  622  				 &addr6->sin6_addr);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  623  			break;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  624  		default:
fe856be475f7cf5 Aurelien Aptel 2018-06-14  625  			cifs_dbg(VFS,
fe856be475f7cf5 Aurelien Aptel 2018-06-14  626  				 "%s: skipping unsupported socket family\n",
fe856be475f7cf5 Aurelien Aptel 2018-06-14  627  				 __func__);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  628  			goto next_iface;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  629  		}
fe856be475f7cf5 Aurelien Aptel 2018-06-14  630  
57bf5227c68fc4b Steve French   2022-05-25  631  		if (iface_found)
57bf5227c68fc4b Steve French   2022-05-25  632  			list_add_tail(&info->iface_head, &iface->iface_head);
57bf5227c68fc4b Steve French   2022-05-25  633  		else
57bf5227c68fc4b Steve French   2022-05-25  634  			list_add_tail(&info->iface_head, &ses->iface_list);
57bf5227c68fc4b Steve French   2022-05-25  635  
57bf5227c68fc4b Steve French   2022-05-25  636  		ses->iface_count++;
57bf5227c68fc4b Steve French   2022-05-25  637  		ses->iface_last_update = jiffies;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  638  next_iface:
57bf5227c68fc4b Steve French   2022-05-25  639  		nb_iface++;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  640  		next = le32_to_cpu(p->Next);
57bf5227c68fc4b Steve French   2022-05-25  641  		if (!next) {
57bf5227c68fc4b Steve French   2022-05-25  642  			bytes_left -= sizeof(*p);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  643  			break;
57bf5227c68fc4b Steve French   2022-05-25  644  		}
fe856be475f7cf5 Aurelien Aptel 2018-06-14  645  		p = (struct network_interface_info_ioctl_rsp *)((u8 *)p+next);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  646  		bytes_left -= next;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  647  	}
57bf5227c68fc4b Steve French   2022-05-25  648  	spin_unlock(&ses->iface_lock);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  649  
57bf5227c68fc4b Steve French   2022-05-25  650  	if (!nb_iface) {
57bf5227c68fc4b Steve French   2022-05-25  651  		cifs_dbg(VFS, "%s: malformed interface info\n", __func__);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  652  		rc = -EINVAL;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  653  		goto out;
fe856be475f7cf5 Aurelien Aptel 2018-06-14  654  	}
fe856be475f7cf5 Aurelien Aptel 2018-06-14  655  
57bf5227c68fc4b Steve French   2022-05-25  656  	/* Azure rounds the buffer size up 8, to a 16 byte boundary */
57bf5227c68fc4b Steve French   2022-05-25  657  	if ((bytes_left > 8) || p->Next)
57bf5227c68fc4b Steve French   2022-05-25  658  		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
fe856be475f7cf5 Aurelien Aptel 2018-06-14  659  
35adffed079fdcf Aurelien Aptel 2019-09-20  660  
57bf5227c68fc4b Steve French   2022-05-25  661  	if (!ses->iface_count) {
57bf5227c68fc4b Steve French   2022-05-25  662  		rc = -EINVAL;
57bf5227c68fc4b Steve French   2022-05-25  663  		goto out;
57bf5227c68fc4b Steve French   2022-05-25  664  	}
57bf5227c68fc4b Steve French   2022-05-25  665  
57bf5227c68fc4b Steve French   2022-05-25  666  out:
57bf5227c68fc4b Steve French   2022-05-25  667  	return rc;
35adffed079fdcf Aurelien Aptel 2019-09-20  668  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

