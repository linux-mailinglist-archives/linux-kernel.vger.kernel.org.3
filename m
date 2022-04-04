Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AB4F1632
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356306AbiDDNms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiDDNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:42:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E224F0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:40:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234AU23d001019;
        Mon, 4 Apr 2022 13:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hcSst6TzaLXa5SbFIfalrDBfhNoDwu8+oIeo01GX1Xc=;
 b=kCPaE6Yj897/rREK4tb6EMVjExOcBw7yDB5k24HeDGyw+POdXswR9KiXLKxCM4krrdX/
 SN7puNcfW1Dupki8JoHXWp37BQHRZOgCjnSrbiFLnzmaivM0/p7Q3zLOYqd58wIXYNNX
 ScdVBavQD5feY8/Ew0qdQAT9jZyMFCW/Pc6e9SHI/xWTS7HX3oy4AhH6u4X1fx8tyQY9
 UXDB0N0GTJ5ZjNkrcCbyNbXOBSkqlUhGAdWuBPXHLM0xX7LCmCZG8m1PlNdclL90bqpJ
 Hj3kNEZGLG1hrecNWcUgJoX5xeMaU14fdzfrDm1/4CS0KQR0ojvXeeA1qSnaMOtMZ8Fo UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sk66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:40:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234DVk3k039941;
        Mon, 4 Apr 2022 13:40:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2jeem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY4/G446QmHi0NqIWtoxbclfUhk6Z764P9N+03sMvQvCXcdVLrFMQf3yAanYKWtps/5WZLxUb9mVEfeG2gIFIl2Nh/SDAR7y3NjN8JDTarKebBRyb3lf6emzfIto8jkJe6lx5VADg69RRY6+PqP9S7UdNA1NPK99c6Je8uVwLarx/aN7ztpstQdnzlUJ+2JT65wRu/OLyZYYzyycihG1trCzctUj9FkOl0rbCsniXxSary0iEDXFxBxq3PsmoTypkFi6bGvRvSDMsa9R1FKWAEIuFWsxcyozAv/nGP8GISMxX6LbLaMoq6RbYnd+9yTgifHAbFOyw5ouPDI9Odg7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcSst6TzaLXa5SbFIfalrDBfhNoDwu8+oIeo01GX1Xc=;
 b=iJY2GvOXfyXxnXmRIdo+iHSiLp0hM7AsHogX9Y7N1NePfPdlZQg5Be1rBJ/WKkjZbByys9zjShbgYp6FYSJKVohf9m+X2+Pd7Zr3CeJX9TlJ/Kef9guR7yg0cBDUas78N8MSffNRtfjiC/lAyhz46HIIeFs+6Ao0LWPvsC4UGP0z7zOjhqWnBeZgubM3/jIRABtUCx1WiTwbdWJzneAz7j2jeTvxGdc+77mND0UQ7ATxrEwGPYanQa7EQcbJ0CFbBzEMJU+EVtDu3i37BoQxK649DDpaRfbRuiF/rvxTQkcjpopfWarUeEwoN3mDTWTlY/DgEBC90bz4kWMPO6PkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcSst6TzaLXa5SbFIfalrDBfhNoDwu8+oIeo01GX1Xc=;
 b=i3khw3/XDV+6DuOnuxigImxyAv6BOjE6RIsi6up4Z7ZNkcrp3xbFQxTxPcj8CWf4MJvOZ1vNoHsb4AL/d2JZmZe7OI7c61iCLho/uLebLZN3O8pmR/eJ5sbpwS6B9gZy+tLT3zzKc3kVDxDsPRxUWu+SK9/XSpBmeppBjrC3oVQ=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by MN2PR10MB3248.namprd10.prod.outlook.com
 (2603:10b6:208:129::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:40:39 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 13:40:39 +0000
Date:   Mon, 4 Apr 2022 16:40:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stefan Roesch <shr@fb.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [kdave-btrfs-devel:for-next-20220401 96/102] fs/btrfs/sysfs.c:830
 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'
Message-ID: <202204030841.qWK5rMDU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::14)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee94a200-c0b1-4f8a-dc4b-08da1640b482
X-MS-TrafficTypeDiagnostic: MN2PR10MB3248:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3248FA867573B9AE635DB20C8EE59@MN2PR10MB3248.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdYOf7cAiBGaMHUon7PekNQKSXzuZWTHwb2VDd6WOatH6lXGxxgAdh6evZ6ekDBaZwsFswbC1km7UVTr9k/l5VN+ocEkbUqe8jfv4xa/OKZQK2TtRm6KB4fSNVNsNwxks/4aUOxu+WWt5SXJuF9j6gtwKfX0Mkf3+IaTH2ZOaTIUXFb2qsNj886xPO0/qMNBK6rZVR6sCU5CiobmHyfGQX0l4meDJVW0h3gZrbFgATPeAm++R6UKsa9vKRNm9Zauj1ae6AWsUgUoElXVx8ruZVCQ6wP8roNtxbLybxxrcxJVWrJatL/9vBjoaDl/95e/3ocKgmt7B358Zz5/iMdIw3/srshZXdjry6MGDeU3ToQqi9V8g3UhFPC7l57Lp/bwN7tM55X5cB6gc8ii4ZkOLccVHrepnL1X02/p44Ylb9+qoQRxTiJgqFlwMCc1lxeNQ8psOMAq0qp+CT1TolWBXZCF/+CAKx2PXv/bDR2frLg69qmfUhBF1G/yQVw2HNxpxkJ35dxUj+JIA7ty4IGMx2qoRw1Att9Qb2a3PAakwpeNElq9JT9pGctgWPb7BZa6D6vQdH8ZAWwcg3BIhfoltfNPACjaoImHgcwClKl6ATKrRXuuPIGMHBrGUaJ5v+rCX8ZzpREsN3Fs4Vv1jivM7p/YF3ThPQXCPEBgsHhdEJLcomIcJRlKeytSGs5pWSqWMF87IHJH9XE4sOiaDTAu6ZdNecTqSfs8BaqLxLTzR6JoUJ83kk0+np2fPyzXl61ZIwP13JAzjSmPW4YmDwYWLSXqI8Ag5lh2/ONTxFjXf1q0C5I6khRJ3hevTejsgiEI9nllxK17L8qxHffcwGjskQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(36756003)(186003)(1076003)(44832011)(8936002)(5660300002)(2906002)(9686003)(38350700002)(52116002)(38100700002)(508600001)(6916009)(83380400001)(6666004)(6512007)(6506007)(66476007)(4326008)(966005)(316002)(66946007)(6486002)(8676002)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qenDqN2/qBpt/6c0LMoraHHMV3UxmfZxz91ksXVE8SpzNQPS1nd4jLMPcmrW?=
 =?us-ascii?Q?w7nTBtouW7fDlSNoQhR73t9An/L2yprc360NgqBA2aD5LksqG/D1W6/bljTL?=
 =?us-ascii?Q?3PY7Wf5/O2SD8ediNPIvmFPmSqHNKIyZ2CMWg9ov7qvQj465vWAixy+c4w4M?=
 =?us-ascii?Q?uGerXCXrw8O1zZxsMMYSEWLfYx4dVAr8LRzGUvZS1HEfoLrj8WKrlJgdnfUg?=
 =?us-ascii?Q?rr9muU2P0nAz+8dw/wphKuzcZqsiW3XYAekIJr13fk/fQaFtK731w1Dwbk+o?=
 =?us-ascii?Q?fEiOA6EXeYrXSyjTfSNuykCIUHS5VU0dj5Qr7o2gPmxBBOEpoto93RMGGi4O?=
 =?us-ascii?Q?I7EwDng1YPMXhyx0NsStJrFuFKVmpGJN+LCTBAmqC+DLyMwaVm3dxHg7kkh3?=
 =?us-ascii?Q?25hIlrDWDoraKCfUANuyyTkaynTXv13eO91gDVXwi12Tts7OD34/cvOZlCR3?=
 =?us-ascii?Q?1v8YSXOZ36yW2zZ3WfW/b5c39wYalIriuYBQ+fTAemm9kEt3RzANoU5l+b4+?=
 =?us-ascii?Q?bHAm96xsqSnxCMQQXYYuFR8bQw8A6wlEJzELUu4WyiAvBNZR7ebLYOdlnmcl?=
 =?us-ascii?Q?IEJlRuuyS9nrBGPe5cFKub/8nxr7OzlABUk4O67vsP/SMHDZ8gBKzz24uZvt?=
 =?us-ascii?Q?NLadFAnQd5svXLxG2kBRTt9u0gJSn0XqROecXdv2dYibEHEGl2ynol8SMZGt?=
 =?us-ascii?Q?/J1tsvD9CALvPFQVCQkWmCu+i56UhXnjdwnUF8mm6JJaEB6V/lQkWosoRmim?=
 =?us-ascii?Q?Bb/19pEt2jP95MRl8iR85rGKmAVvqRcS8bSvwb/9ixd37JuQv1gO3WH3T7Iw?=
 =?us-ascii?Q?kuxKfsiMxtuGxAkih9S024s/9Flzv3PVnGP3N7N6DTPUYe8k3u2Kxvr5u1y2?=
 =?us-ascii?Q?yTw/FE5V+f0P8TfD9ar4vIFe0WOBeFlUIJNnIXpb+yx7CpKdKrfMFtqaW/TU?=
 =?us-ascii?Q?Ar+ojVzNAXW2GTMLrKbtrEEiPatqpAEcGUHgc+tDvAVjtZ2X5RbVJJ9ZMIDO?=
 =?us-ascii?Q?MOqRtvSlLssgZ+NAh+GzYtClm3vgrczR31KpceVroZjgJqC2y1AR+7IbOXl3?=
 =?us-ascii?Q?8C3BqDrIglg7KzNDmEvIJ8wZuYGd0+qiqjEIDAhbokgt+3nAJsJXXXvwyINW?=
 =?us-ascii?Q?nc4EtHYSUkc+9gJIl8Mw1jdb9wBf/m16Lp9IU852TCI/fWLnH3egSBJwGBSr?=
 =?us-ascii?Q?U26T8PpWeU+hSMIKLq1BFoP9w3Us8qq9qvO6zGw67kiCMC/jpPqI0iTFuTwn?=
 =?us-ascii?Q?e8TIFN0VUUtmxSbMfLOlZ6ngCErb8TaZwX5oJ36ml6OZ0I8zN7y9o44ySEGq?=
 =?us-ascii?Q?UOwVWYT1shGvm+W7c8McRCgdAQHs6KqCEXY502IHkKLRkOTSNMd5PZNwx2yL?=
 =?us-ascii?Q?qkKCqWFo73yqw1rtWvQwpf7mSf/LRcCzwA1Sjj7qwxmfcI9IN/m0PCy0755Z?=
 =?us-ascii?Q?SCxx4Wa3o+0/8zEusYm/AhxYtqDBip5KBj+zeUoQigPu0Mm7/OXU8F8FOxXe?=
 =?us-ascii?Q?+RrPRvDCl+Yh3R/3ud1o32PZ31bsNdESNCFL1hL3SFxru6wxG78RKU087FQ6?=
 =?us-ascii?Q?7hHdlOhhwI8pbSRos/sO5gjISBg/rEoPB6wRV8BIebQoGn0VZq0wAUotJNIH?=
 =?us-ascii?Q?xNl/tfaAv94Jx+JG+XY/J6eRwIidEU1A3lJCPG7NcJdEUVueL6kwyMze584g?=
 =?us-ascii?Q?GwjzFDq5Z8qE4F/stVcyNfzPkFqZ2OLTrRp6JrmAsmUgZ2SB6HwR+M/tSS9R?=
 =?us-ascii?Q?xhuIjKzqqmJLpajJ+/YltZYubuCqq+I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee94a200-c0b1-4f8a-dc4b-08da1640b482
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:40:38.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1rEx0Mmr3RD0A0WZBJ6Iv16AU0yWFif2Ao3yd4dB2hEQP1WrvbIhTbp89IT8wNvqP8cCZBOMNai9/B1BM3D45uvU5UXWLHFKy3wqmhET/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3248
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040077
X-Proofpoint-ORIG-GUID: yvcnWne2G2-MNtBuz_guQFeiNujTK2O5
X-Proofpoint-GUID: yvcnWne2G2-MNtBuz_guQFeiNujTK2O5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git for-next-20220401
head:   0c593f04d2f520a720c5c618ba9fe0355d08bba8
commit: 6e115adef2b6a9b9a7cc25414e1b8f4414e02044 [96/102] btrfs: add force_chunk_alloc sysfs entry to force allocation
config: nios2-randconfig-m031-20220403 (https://download.01.org/0day-ci/archive/20220403/202204030841.qWK5rMDU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/sysfs.c:830 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +830 fs/btrfs/sysfs.c

6e115adef2b6a9 Stefan Roesch 2021-12-03  797  static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
6e115adef2b6a9 Stefan Roesch 2021-12-03  798  					     struct kobj_attribute *a,
6e115adef2b6a9 Stefan Roesch 2021-12-03  799  					     const char *buf, size_t len)
6e115adef2b6a9 Stefan Roesch 2021-12-03  800  {
6e115adef2b6a9 Stefan Roesch 2021-12-03  801  	struct btrfs_space_info *space_info = to_space_info(kobj);
6e115adef2b6a9 Stefan Roesch 2021-12-03  802  	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
6e115adef2b6a9 Stefan Roesch 2021-12-03  803  	struct btrfs_trans_handle *trans;
6e115adef2b6a9 Stefan Roesch 2021-12-03  804  	unsigned long val;
6e115adef2b6a9 Stefan Roesch 2021-12-03  805  	int ret;
6e115adef2b6a9 Stefan Roesch 2021-12-03  806  
6e115adef2b6a9 Stefan Roesch 2021-12-03  807  	if (!fs_info) {
6e115adef2b6a9 Stefan Roesch 2021-12-03  808  		pr_err("couldn't get fs_info\n");
6e115adef2b6a9 Stefan Roesch 2021-12-03  809  		return -EPERM;
6e115adef2b6a9 Stefan Roesch 2021-12-03  810  	}
6e115adef2b6a9 Stefan Roesch 2021-12-03  811  
6e115adef2b6a9 Stefan Roesch 2021-12-03  812  	if (!capable(CAP_SYS_ADMIN))
6e115adef2b6a9 Stefan Roesch 2021-12-03  813  		return -EPERM;
6e115adef2b6a9 Stefan Roesch 2021-12-03  814  
6e115adef2b6a9 Stefan Roesch 2021-12-03  815  	if (sb_rdonly(fs_info->sb))
6e115adef2b6a9 Stefan Roesch 2021-12-03  816  		return -EROFS;
6e115adef2b6a9 Stefan Roesch 2021-12-03  817  
6e115adef2b6a9 Stefan Roesch 2021-12-03  818  	ret = kstrtoul(buf, 10, &val);
6e115adef2b6a9 Stefan Roesch 2021-12-03  819  	if (ret)
6e115adef2b6a9 Stefan Roesch 2021-12-03  820  		return ret;
6e115adef2b6a9 Stefan Roesch 2021-12-03  821  
6e115adef2b6a9 Stefan Roesch 2021-12-03  822  	if (val == 0)
6e115adef2b6a9 Stefan Roesch 2021-12-03  823  		return -EINVAL;
6e115adef2b6a9 Stefan Roesch 2021-12-03  824  
6e115adef2b6a9 Stefan Roesch 2021-12-03  825  	/*
6e115adef2b6a9 Stefan Roesch 2021-12-03  826  	 * Allocate new chunk.
6e115adef2b6a9 Stefan Roesch 2021-12-03  827  	 */
6e115adef2b6a9 Stefan Roesch 2021-12-03  828  	trans = btrfs_start_transaction(fs_info->tree_root, 0);
6e115adef2b6a9 Stefan Roesch 2021-12-03  829  	if (!trans)
6e115adef2b6a9 Stefan Roesch 2021-12-03 @830  		return PTR_ERR(trans);

PTR(NULL) is success.

6e115adef2b6a9 Stefan Roesch 2021-12-03  831  	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
6e115adef2b6a9 Stefan Roesch 2021-12-03  832  	btrfs_end_transaction(trans);
6e115adef2b6a9 Stefan Roesch 2021-12-03  833  
6e115adef2b6a9 Stefan Roesch 2021-12-03  834  	if (ret == 1)
6e115adef2b6a9 Stefan Roesch 2021-12-03  835  		return len;
6e115adef2b6a9 Stefan Roesch 2021-12-03  836  
6e115adef2b6a9 Stefan Roesch 2021-12-03  837  	return -ENOSPC;
6e115adef2b6a9 Stefan Roesch 2021-12-03  838  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

