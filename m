Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6853E78D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiFFN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiFFN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:56:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37B10567
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:56:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256DP26f016256;
        Mon, 6 Jun 2022 13:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Gy9i1CcLunJY68nRIZTRSHrPD0RIz/uOdhuv8HXLqzA=;
 b=AV9H9EJ8TdM/ojFKMuU+Rz3gGL9pWpQQD3g4AE4DiKHnRESRr/fMF9nRFFWUQxJuLOQ2
 Do6rij59CKPamSOFH0d+nNwuVmBX9JsHmxGybBz/hI3hAuBp5B3lj8RT/Vfw2js9vvUV
 Jou2ewf6Gj8W4F2z2KDpJ/Kd/qqLnMa8W23Qr9NTji+qQJylV6zNEAAFNqA7f4PuCldZ
 shbLhwC0TIK3pE5Xlv1Zjpo12Sk7LR902ea/YoiWw5ODVMIJ8Ek8FEXB+BsAuL6SP0A9
 uFj/W3iyk/HNk76Vpq3BehTZdI+jRLVxD2UE5Mg8Dgct1W2G//6eMlXw1gahDb+yJITb jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekb4ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 13:56:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256DuEPP029316;
        Mon, 6 Jun 2022 13:56:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu229v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 13:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty48xKEaWbTuFwEWXF0adWyxdpPH0SLWSFXOlfS+IsOK7OGPQ2AaDgwkr8Y2+MGlWos54nD+sRgdKtWbzPPUv7yDjgEvZR6JihLkRDz5AZVICCWOXSpBD6AAe/Lh67aCLC+JjGne+svYQPNKH6FLRxvu2sM5TYKpLK9Y3lPDy8mVVoqnR4jtonqNBD9plfsY62I+ALed3QPeDOL5jWGslCRYQTu9k2FsDMJ7ZNVuHLlUQvJ/R+FLRWbxk2dXP+rKQLNbev0lR0gzmY8QdmA3oMzKjB9Jgmge6DWM1nZr68rMcKARhbQwSFatl6v5Sg2KvLwDO/sGCtzaecLLdvbjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy9i1CcLunJY68nRIZTRSHrPD0RIz/uOdhuv8HXLqzA=;
 b=PajLYdbgxXbh3KdYHNmhNYvdDVD32lry0Q3w2qmM6FQBiEuGYeD/H7Ch7WOr6PbNhUyOoWy5Lrmvk+DRozy6hlOEzJvOkDJ+JxBfVDTj2Xlqm2EUxZoImDlA/606f0RgNyju13lDToBmaxQ1Bu4fZIbTzBNxMBdsQ59CcxD/sySJ3YU7rRG7a4cE772a6ki2WVM6OFVD657/J0cw1Kpgn4Mfb7YZHaA37Aryd90vvPcDduLj5Wc5mPUQPb7cy8hvWDve+Gm13J+Z8v1UBdxIj4NGZLYOTbpbXr9zkCwSqLJTQHsQt9jBfO4rBMj+666JdkKWMu/LiAMi1hWHHgmDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy9i1CcLunJY68nRIZTRSHrPD0RIz/uOdhuv8HXLqzA=;
 b=ltNcKMQmkLp/2OW5HHbzSQT2lPdvrBNzv8WnZvnk1j5EdNvLCAPLP2GU0j5uWRcUROI8shL/TF5Ri+ie8qPAAySn3C/LaFc5BQ7KkZPfo4IvjvubGuh2TqdI+YLX6nS2W7VXIt9mhnbobtZR+lc5X+8xXMT8xslxCbUc2LhQ9p0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2156.namprd10.prod.outlook.com
 (2603:10b6:4:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 13:56:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 13:56:32 +0000
Date:   Mon, 6 Jun 2022 16:56:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: [xiang:erofs/initrd-fsdax 2/3] drivers/block/brd.c:466 brd_alloc()
 warn: missing error code 'err'
Message-ID: <202206062100.MJhGyCcE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb29f67-a89d-47f6-194c-08da47c45ce3
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2156:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21565C40C7DD93045A79C67C8EA29@DM5PR1001MB2156.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5WBZ2xwxCF4yocgqyqotFO4bMkosiaO8SwgIVij54VMpnXQb0SjUkGaLLS3/IpoQUAVqULsunURYauu74UbxrtguAkibt/QU2b8NjF0wywWgixuUMXSRUZgT913o0l+M5qFVlKf0TzgCOeUXON3pL3ZRJ8Mk8q1JskAIFwqe+RwtUwzTbK6R3vFosD4ZlxpbRnOIzmT+4PT4cPWW9d9p0jEYvZ7YFqtJDxTCgnwnZRhFHel4qpymHHy20sejjBHWNg107TLzYeQ2j69UaJvEwzBydI2XJTGJZPeYiN4W7LoD/5N0Li+RUeP9Siw/2YsCrs1AQtcbaCQmFAl/MBFszHwk8ZU9u+MQW159cV+PNNn/gz77VOiVhyvInH/rYdLx38F1zXvOu77LLneQ1RebEzfsypAEjbyb8kWBEnLVIJHOFXcCe8/Qmk9t7rP3LgXGY/u/DtJivDgK7R7KAzbPmHsAHkRFnHiRhGvs5Y/4kEUX0jwdXoHuCaR1EigAoVGVxD0RNka3t+CkAyHzH5wqxZAq17k5GtBfouSuZP3tApECNPownEFXgiim5u9LZNKbnzY7T75WyjAan7LGegi0LKNomUrOtK6doWzKSdicS90pYUE7AYDCYTzChN1v+fvgxdxhYogviKm5VQY3nnCaGfX+XQaf3Bg4UknT/ePScLvJUv0PsgDPgRkz2I8gRMWPdG+PT7cPu+Nb8hUrNiczHEJgQZnSXhB4SV8va1lJTdNhWnGEGhJsdAZo+C3MyPv3mMmQZ6pdjHTf2sj/q2IOXbdccvaFlhDBMC3OCWLOWuSsfF3qfmmzTgtrlBXz3nArrX5h7sxpiStD9aDXLyyjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(52116002)(1076003)(38350700002)(38100700002)(508600001)(8936002)(316002)(5660300002)(86362001)(6486002)(966005)(6512007)(6506007)(44832011)(9686003)(26005)(6666004)(36756003)(2906002)(4001150100001)(66556008)(66476007)(8676002)(4326008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jL95SgBAOPVW/gzI/hU+uLpeg36FCW0HtZBt3RwpP6i/snSkcq5eFcXkGEy4?=
 =?us-ascii?Q?11lLgJtearIBpjo3w39bpX+zk/G9644SmX6sfWN7BDOM1i//RgKGbF6/2Iz5?=
 =?us-ascii?Q?+WrCKJmbie6j2zOqq3gTelJeQSrXDM8n+ud0sSxvjhq89zTCQgdB4dzwa4M8?=
 =?us-ascii?Q?uurzfADSXPu5evldUg9Jq0Rk8JAwG90BnVI19kPvvwL+y2q7Evrwa6w4iL1J?=
 =?us-ascii?Q?PLQD/rsbLwB1BdboAgmUizoKwDvSyDQMzG/1Da1N2jyAJeTXVflZ6qOnm48k?=
 =?us-ascii?Q?v/vvIS+4CUMlIi8xHvx7DLUY48YmHKDBzGCX+cAlKgYwaEwVVGqgU21odhiB?=
 =?us-ascii?Q?gLndSnMGLiiXDtwfW+bURXublx0UB84dwiQ7lBcvn2iNVei7JH49HpjEUs46?=
 =?us-ascii?Q?QgL1LUsk5JLvH1L3bjGzQPCxPaXTm46wgp4ga0mk9GuS/PZeM0gGM6b+u/hk?=
 =?us-ascii?Q?6SshOAPxdE4zuyjBgy0i+CWB1Ga2kX9XEt+fgGVQWrg6jpQw4lmejrDzjjkl?=
 =?us-ascii?Q?9CTHaIS57omUdGALZ3vr/JykCK4koYCjbS1FgWlbIXOXrlLYidT91/mqHmgg?=
 =?us-ascii?Q?tOveHYkZbAJqVuoP+FfMOJuxKW4JRwVP34VNDnNJBrnOqra2euL5oxCqTNE2?=
 =?us-ascii?Q?DRjc+x1gsudVu1LnatoISKkkWqmL0pVKGnxGHfbOFhxp4wF+9Vn2UoQ1JPPP?=
 =?us-ascii?Q?dm9QJ1dYG6K1wMW/lyRcXs7S4tezfnxrBU15kARIxoBKNHG5B4zmquR5j2cy?=
 =?us-ascii?Q?QY44nKvi23I8dIjXOPQd1QCvAkUH3Ja4P7ut88FMwsGNQPzi1WXE+qDs2kii?=
 =?us-ascii?Q?5Zu80Sqn2CMlPmyaja2YgZwx45VVeWNT0cbfEE1w6030eckyudcX7WH1GUsx?=
 =?us-ascii?Q?bfgngVMZUOv/ySBebi5lDti5NNIkG8XX8pvcxNDNGoiKU+XzHAtfaP9QkM25?=
 =?us-ascii?Q?wxBa737drE9WuWcobTRvsNpDR0Crqpubqq4WImY4+MWIeGYl28DrM7oiCjj7?=
 =?us-ascii?Q?i1ELF+Fu/tz1DRhh4RQnOYSldGCCVcWCPHogEwMmDqxhMoFxs9zha88Dx8ly?=
 =?us-ascii?Q?9LnWylK0LAdtDocLivFxTwG/+ZTGX0GUcA36ETwzpOHuQ9GeE3YZu35rmTOm?=
 =?us-ascii?Q?W9lEZRFj3jEJeSeE5RRhydzqTEb3CCsy+DD3pp62nX+W8tSlWnkalY2q2bMi?=
 =?us-ascii?Q?nT1YJ5v9xh1xpS6UYhKXC1kELCfflFptIe3RcqIKu2DzpG06UJzpOu1Tnuch?=
 =?us-ascii?Q?dqMaVNN7NlH8LwRw283zqFCrKMMeT0yh039jvHJZzLkfHGr8FPteIn3HzmIv?=
 =?us-ascii?Q?AfhrmUQ8ogOqkgBX3Qnu96ShwCeAiptDJooQJhtQpxIEAqsmYtcAH06zG2L6?=
 =?us-ascii?Q?ZuL6CU4CiGun/RwMeOnJcwPWbg+34pFaqdrY503uNs9poIvltZqid5ghGV+z?=
 =?us-ascii?Q?hwtG69WawedNXgLXkaQyr20h4fKrncdAGqxbr17AZN3+BbLKFpmV9kmeIFPU?=
 =?us-ascii?Q?MKmc6LYHEOmfpBF1UvG9aoRIwbjiYmsq9xME6ErkvMB8HkNMhiJbUuFVs/P7?=
 =?us-ascii?Q?D+KOD74XMw4vwt21v7UKjxc6tw7meQ9z5GFUkIxiSN+TTKXio88Eic/4NHtC?=
 =?us-ascii?Q?U/Z/Jl3u1KsLNe0aa+m2PwMYRwlpuapQfMK+1jOcRNTG/qr4RMT7jZBjib4o?=
 =?us-ascii?Q?qfXgPPHMiSVpPGpOepXAgLL9JhUOln43X6Ya2Z44jY+IYQTfOKGzuHxYwUP5?=
 =?us-ascii?Q?Ih0xcrByM9jkTliGUe/pBt/6IgSRF70=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb29f67-a89d-47f6-194c-08da47c45ce3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 13:56:32.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuWVGOZuZnBp2faGjjAjy3kvvd4T29hOiTtA2V/Hx5KERA20lNbnN5M6rttXiXnKMm4MU8uz32imXi1FP3O1XDqc3ey/WGOoQYDWE4m0KKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060064
X-Proofpoint-GUID: hXQvq3Ow6SiKBaGkTVYoR7RDoZrYKlAe
X-Proofpoint-ORIG-GUID: hXQvq3Ow6SiKBaGkTVYoR7RDoZrYKlAe
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/initrd-fsdax
head:   e04a723ce39c31ea57edfbfd70c867a2025910e3
commit: a610c807a6b52cbce515911dba9b9cc316a6c117 [2/3] brd: support FSDAX
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220606/202206062100.MJhGyCcE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/block/brd.c:466 brd_alloc() warn: missing error code 'err'

vim +/err +466 drivers/block/brd.c

7f9b348cb5e942 Christoph Hellwig 2021-05-21  407  static int brd_alloc(int i)
9db5579be4bb53 Nicholas Piggin   2008-02-08  408  {
9db5579be4bb53 Nicholas Piggin   2008-02-08  409  	struct brd_device *brd;
9db5579be4bb53 Nicholas Piggin   2008-02-08  410  	struct gendisk *disk;
f4be591f1436af Calvin Owens      2021-04-16  411  	char buf[DISK_NAME_LEN];
e1528830bd4ebf Luis Chamberlain  2021-10-15  412  	int err = -ENOMEM;
9db5579be4bb53 Nicholas Piggin   2008-02-08  413  
00358933f66c44 Tetsuo Handa      2022-01-06  414  	list_for_each_entry(brd, &brd_devices, brd_list)
00358933f66c44 Tetsuo Handa      2022-01-06  415  		if (brd->brd_number == i)
f7bf35862477d6 Tetsuo Handa      2021-09-07  416  			return -EEXIST;
9db5579be4bb53 Nicholas Piggin   2008-02-08  417  	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
00358933f66c44 Tetsuo Handa      2022-01-06  418  	if (!brd)
7f9b348cb5e942 Christoph Hellwig 2021-05-21  419  		return -ENOMEM;
9db5579be4bb53 Nicholas Piggin   2008-02-08  420  	brd->brd_number		= i;
f7bf35862477d6 Tetsuo Handa      2021-09-07  421  	list_add_tail(&brd->brd_list, &brd_devices);
f7bf35862477d6 Tetsuo Handa      2021-09-07  422  
9db5579be4bb53 Nicholas Piggin   2008-02-08  423  	spin_lock_init(&brd->brd_lock);
9db5579be4bb53 Nicholas Piggin   2008-02-08  424  	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
9db5579be4bb53 Nicholas Piggin   2008-02-08  425  
f4be591f1436af Calvin Owens      2021-04-16  426  	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
f4be591f1436af Calvin Owens      2021-04-16  427  	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
f4be591f1436af Calvin Owens      2021-04-16  428  		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
f4be591f1436af Calvin Owens      2021-04-16  429  				&brd->brd_nr_pages);
f4be591f1436af Calvin Owens      2021-04-16  430  
7f9b348cb5e942 Christoph Hellwig 2021-05-21  431  	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
9db5579be4bb53 Nicholas Piggin   2008-02-08  432  	if (!disk)
7f9b348cb5e942 Christoph Hellwig 2021-05-21  433  		goto out_free_dev;
7f9b348cb5e942 Christoph Hellwig 2021-05-21  434  
9db5579be4bb53 Nicholas Piggin   2008-02-08  435  	disk->major		= RAMDISK_MAJOR;
937af5ecd0591e Boaz Harrosh      2015-01-07  436  	disk->first_minor	= i * max_part;
7f9b348cb5e942 Christoph Hellwig 2021-05-21  437  	disk->minors		= max_part;
9db5579be4bb53 Nicholas Piggin   2008-02-08  438  	disk->fops		= &brd_fops;
9db5579be4bb53 Nicholas Piggin   2008-02-08  439  	disk->private_data	= brd;
f4be591f1436af Calvin Owens      2021-04-16  440  	strlcpy(disk->disk_name, buf, DISK_NAME_LEN);
9db5579be4bb53 Nicholas Piggin   2008-02-08  441  	set_capacity(disk, rd_size * 2);
9db5579be4bb53 Nicholas Piggin   2008-02-08  442  	
7f9b348cb5e942 Christoph Hellwig 2021-05-21  443  	/*
7f9b348cb5e942 Christoph Hellwig 2021-05-21  444  	 * This is so fdisk will align partitions on 4k, because of
7f9b348cb5e942 Christoph Hellwig 2021-05-21  445  	 * direct_access API needing 4k alignment, returning a PFN
7f9b348cb5e942 Christoph Hellwig 2021-05-21  446  	 * (This is only a problem on very small devices <= 4M,
7f9b348cb5e942 Christoph Hellwig 2021-05-21  447  	 *  otherwise fdisk will align on 1M. Regardless this call
7f9b348cb5e942 Christoph Hellwig 2021-05-21  448  	 *  is harmless)
7f9b348cb5e942 Christoph Hellwig 2021-05-21  449  	 */
7f9b348cb5e942 Christoph Hellwig 2021-05-21  450  	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
7f9b348cb5e942 Christoph Hellwig 2021-05-21  451  
316ba5736c9caa SeongJae Park     2018-05-03  452  	/* Tell the block layer that this is not a rotational device */
7f9b348cb5e942 Christoph Hellwig 2021-05-21  453  	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
7f9b348cb5e942 Christoph Hellwig 2021-05-21  454  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
a610c807a6b52c Gao Xiang         2022-06-05  455  
a610c807a6b52c Gao Xiang         2022-06-05  456  	if (enable_fsdax)
a610c807a6b52c Gao Xiang         2022-06-05  457  		blk_queue_flag_set(QUEUE_FLAG_DAX, disk->queue);
e1528830bd4ebf Luis Chamberlain  2021-10-15  458  	err = add_disk(disk);
e1528830bd4ebf Luis Chamberlain  2021-10-15  459  	if (err)
e1528830bd4ebf Luis Chamberlain  2021-10-15  460  		goto out_cleanup_disk;
316ba5736c9caa SeongJae Park     2018-05-03  461  
a610c807a6b52c Gao Xiang         2022-06-05  462  	if (enable_fsdax) {
a610c807a6b52c Gao Xiang         2022-06-05  463  		brd->dax_dev = alloc_dax(brd, &brd_dax_ops);
a610c807a6b52c Gao Xiang         2022-06-05  464  		if (IS_ERR(brd->dax_dev)) {

err = PTR_ERR(brd->dax_dev)

a610c807a6b52c Gao Xiang         2022-06-05  465  			brd->dax_dev = NULL;
a610c807a6b52c Gao Xiang         2022-06-05 @466  			goto out_del_gendisk;
a610c807a6b52c Gao Xiang         2022-06-05  467  		}
a610c807a6b52c Gao Xiang         2022-06-05  468  		set_dax_nocache(brd->dax_dev);
a610c807a6b52c Gao Xiang         2022-06-05  469  		set_dax_nomc(brd->dax_dev);
a610c807a6b52c Gao Xiang         2022-06-05  470  		run_dax(brd->dax_dev);
a610c807a6b52c Gao Xiang         2022-06-05  471  		if (dax_add_host(brd->dax_dev, disk))
a610c807a6b52c Gao Xiang         2022-06-05  472  			goto out_del_gendisk;


err = dax_add_host(brd->dax_dev, disk);
if (err)
	goto out_del_gendisk;

a610c807a6b52c Gao Xiang         2022-06-05  473  	}
7f9b348cb5e942 Christoph Hellwig 2021-05-21  474  	return 0;
9db5579be4bb53 Nicholas Piggin   2008-02-08  475  
a610c807a6b52c Gao Xiang         2022-06-05  476  out_del_gendisk:
a610c807a6b52c Gao Xiang         2022-06-05  477  	del_gendisk(disk);
e1528830bd4ebf Luis Chamberlain  2021-10-15  478  out_cleanup_disk:
e1528830bd4ebf Luis Chamberlain  2021-10-15  479  	blk_cleanup_disk(disk);
9db5579be4bb53 Nicholas Piggin   2008-02-08  480  out_free_dev:
f7bf35862477d6 Tetsuo Handa      2021-09-07  481  	list_del(&brd->brd_list);
9db5579be4bb53 Nicholas Piggin   2008-02-08  482  	kfree(brd);
e1528830bd4ebf Luis Chamberlain  2021-10-15  483  	return err;
9db5579be4bb53 Nicholas Piggin   2008-02-08  484  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

