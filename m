Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0C571793
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGLKvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:51:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C10A2EDE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:51:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C9sjC3001849;
        Tue, 12 Jul 2022 10:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SjkDQOBECnhUvimT9KwhIIKilnm038sqfBSHqKTBb/I=;
 b=tpCJM5mTSas3qnv7AJiBa4nnt976KtN44IcU4yZh7Boi/0peoLyZ38VobjZ3uPt0Ak5E
 RymBTxaUJUYzMw4kWu4Tb3bcHvnoOlMRL7C2e3gPfSivERKKwNCfgJwwrQkIcFnXnZII
 yi6kg4DEFKfxgtt6O5qPXaWw0zsEePcykx6n7Kx+PJM7mA0t9U5s+BJDFhmRVDaykivG
 spiSx77ifUL2fp6CjlzZuBrmW90m1n7RZcgKFNSp4MI7BYHudjii+4RMT1xP6V0K44Fs
 8FaeZlM692opuAw6c47PLm8iyiJ+vq/Vu3a0fpBrmFntg3WtXuaP+p8nyOogrDo+SrQO YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrecxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:50:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CAod40027494;
        Tue, 12 Jul 2022 10:50:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042sv4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6T8K9Xq/xO15pynTrEx8bDVMque84snBQzt6ytSnHNcdQWSXlRcaOQp+Gma2sJ+zIcaOkBfMzBjN1/QW2a+wFvOgTwQ+Nqbhc0pNmFgTH7BA0G+QOO2B9jK1mZ2i/vtmb9oKbWPEZqSEHWN/Fo5V5mlGToPVg74W+pg7hjAX8otuwExLjgARXTlOwf9tXn/PvIKTONatQiK7cqKM29Pf6Q2sZ8pxlKOylrE3UMdM68tNCLMRkPVKav23G7AqY5yekK0+3/QisgjRld2hruby7b+/Tr539VLa1LMLemt92IOUZ5BFlzK31qlezY+Z1K4m8nrENUYbQHg+Plxb+F/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjkDQOBECnhUvimT9KwhIIKilnm038sqfBSHqKTBb/I=;
 b=E416ZoaiWcKuQS/hgo5maR7k8ekO8Hf2hHWtVka0GV8DtH684+EnSDqrtE7JeAzO9DdCwqugwLDn0c4J8Eews9khCo5a8jPuZxDfSj4WAhkJ+83fYkn9V3NEBdj2ICf6MG2lH9PfhNVEmek6kmy1U1EVAOzWgUywkxmTAHnqeAX9YS+n3E7ZBvmFkYi1zGnE+87bWD2E0lWVyDH2CFa5iUZfHlkXnQnFSEKBKo1R8v21N5iDWjpLgUm19aJ4u6wthHYU/F54h6GDJoD1jL9Y4vBneExxvUlKgaPPIHTyjyO1bvI5e/DO3Eif8+7B8wvQtD6I4bBlHuKPHfkOauFT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjkDQOBECnhUvimT9KwhIIKilnm038sqfBSHqKTBb/I=;
 b=oRthrTVKV13L1DYGN8oPoXQvfWJbfEfhH8/RCW1KAnCWbGyScIOUwKtm37FV39jxWsz87l11K0hwFjZ1PKo+EnylLavpH29qT2sTzui/dGD2oekvPaTXxObfTKaEkJzmqgUKtZHUyKK2f/DnwhJjNyR/yR/ZZxR1ZRVDy+RWFb0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4283.namprd10.prod.outlook.com
 (2603:10b6:5:219::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 10:50:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 10:50:54 +0000
Date:   Tue, 12 Jul 2022 13:50:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stefan Roesch <shr@fb.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [fdmanana:dio_fixes 3/42] fs/btrfs/sysfs.c:811
 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'
Message-ID: <202207091909.wE5ZdB1d-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 912c161d-6c9b-494a-9d35-08da63f46525
X-MS-TrafficTypeDiagnostic: DM6PR10MB4283:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaGq45tSl/5yj/97r+V2rUcmn4V6C3t5NA0Cmj5U2aSeVD+8ksUNBte+e6gkneAhVSDFv/RL5u7/T4aIYPx77Q5QvpFUcmk1sNmWf88GM1yaIW7oiWNvcC7q4P6ObQ/XNwypAW2NVbt8KuAxJOgpfNRaqLSjDFSfZcHd8HSiLOIgv/QcRZdd6iY3mcfGzAYURi2cjfKQzl6y8DKZF9oNjjKBVP8+4IkM2Soo1t5YLMIFD3lhoUIwHnb+ZKN+tEWeg7QZpQUC3i9GIKjd14YMRFb9UN+ymdJWxXtsNVrN0T8NCDCUxThFpAEYOly0DnRDRY7QyWvjUOaewqKXvlcYXGQSicLwU3ivJtrt8QXsxO30xAdNfsQalqOAN0Kq/G7I6yN4fSi3TWTwofu6dUCDyCvz2Y6Oe6aI/bOrAckrUBE1JbBHtgcm3ladyKs4gm6t9djJr8a97mITH7i3c46XHNiUOf5LZEyx7qNvOCw9PERTlxFxea9Spppektd9wk+XIEwsRxq2qvPnVVXnz7bLyvUkyhyRuT6xaQXMpD5LazaA8eyC9M67idh3556ltMyj5y7HdFrzeOTtl22qGcAQIYrcehiXMRpHoVL7XPGVa+o4cCEIrke0qQdV8lid0mWYhFrpxyPrxA9/cdh2mMOT/Oawjy2jyBqF3hs2oMdg+1zKS1MhsQOjek5bVoaY/SesAJDQPoGBOXG3VjVahaaF1pt3bsFQiBcTsATkCHYVrEvIwWwL0GlAP/mR/h4HeElOwPK3aYt42V+iNncjK7cHMt7/KZy5lMqsT7/nSdA4BfSWgnxRWp6m/s2XjJDcUwfcobuGEFirFvTbHm9RKnyNUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(376002)(346002)(54906003)(8676002)(6506007)(36756003)(6916009)(2906002)(44832011)(1076003)(26005)(6666004)(52116002)(4326008)(9686003)(6512007)(316002)(478600001)(186003)(66476007)(66946007)(41300700001)(66556008)(5660300002)(86362001)(83380400001)(6486002)(38100700002)(38350700002)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0fk9kfeLARtef9z4/c/t5YWO3NOLIdv2/iT+apfl/OEXRCbFGkYiVo5T7Ai?=
 =?us-ascii?Q?boJmOEHWcoJDH5ZguJ3cH0FJGZ9aljQ80oH3eV0z/+WfpVYWBYAt4kHrX+OJ?=
 =?us-ascii?Q?hZf33zZElzmjsTDzgOTmhzqa188lFHlzIa8elBMrehBaoWjMaI0FsjHebPT6?=
 =?us-ascii?Q?veTDpu7lcUtX9H3pLsuz1tSf1KtK3EZI8VQ6ggcd43jLwkoMWblSgiERoIXX?=
 =?us-ascii?Q?bUAe60VEWeidEwvwjyLU07SLWoN/lW5yUeLj4Qy721d83mqYWji5Y5xqK0QI?=
 =?us-ascii?Q?XDBeaNvPI5NTwNwaimV2B9JHFoc3ApB0WxaGRV5cUTWMboql1mvjh9WO6aa6?=
 =?us-ascii?Q?7e88oFh8GqLpjQHnKe4VGwUem1fDY4YCJZLrAwMp0hAOuqi8R0TTVXCWkpOV?=
 =?us-ascii?Q?o6stKxAqzP5CyCau/jako6ouodoWsjO3AqbmPUdcBF64xRJ2Jj3zd0IqlGcG?=
 =?us-ascii?Q?m5nHXBnWEIvAgnvogAi/BMNgIRQiLXtvLiZSZX/98jEHSZNNPk6zrsZZPbBs?=
 =?us-ascii?Q?aTBEAs5S2baIdH/2VRoWZFGtIY+mmVj1JpH9thZ7hoI5Kfxisy0EzTHZAGzv?=
 =?us-ascii?Q?jguddqhZx7wV6Q48Mt7Q0VrmUbvw3Cd/6ag2sNxzRpcuSeumIAa30stegaS9?=
 =?us-ascii?Q?T7wwuMqWAnyk5/4QadOk8Gj+eVtRkgc8/P/VEq8/5VGi7uDzazmf7ZBHG7vB?=
 =?us-ascii?Q?6MeoqY/rMVWou7krtYZo8LOqaylm3jYBEjT18+QyUvBqKywS4+jsU2C4nuZG?=
 =?us-ascii?Q?C15JC0xCwj+We+fr9DWKVNnot5+vDa7j5KExg1+OrDfV7lzvNCvvr7rDxlkE?=
 =?us-ascii?Q?M7K8whLp34P1PKoxmEyHFBPnV5aGECOrbkIrmzPc0snr8BKfnnfstgp98ub9?=
 =?us-ascii?Q?ThBQ3SKv5ywYEly3XNMJvWG8jBfTSuZy3pxAX/Iwqcn5VYCzH/FaQDks+emv?=
 =?us-ascii?Q?txDkNpYDoqYE1QBf0HEnfWvIQypCDGOBWBHDDQdPE4pLfk8dITBSew3alBSr?=
 =?us-ascii?Q?sRopHk7OIwzVk86rp4Ip7qaP4xupIu413PZXPoTdk/mq5FQ2syFXYO0YlmpO?=
 =?us-ascii?Q?8b6Uc1vPaBAkLCGP0Fayz33YGgS4FxPCM1gV1ITEiEEOMfNf5UWo2lkU1Rs/?=
 =?us-ascii?Q?/1CnRw1831tqVwyAIaMCBd+rJPIPaZOrchg5+Lmi5Jm7xJGwgpWL2pkOSvuY?=
 =?us-ascii?Q?zYQKrZSS9+pBt0Eko6rvFhlZZYNjYqfdtACGWhHWgwcmO6DN+Br9B7Dn1pKj?=
 =?us-ascii?Q?lZ1+/Fs0Y/9ZMuUtkU4B5bpSuwqsATi0ynMMXb5ZKDL6SIQj0/rV1JNNm0t/?=
 =?us-ascii?Q?ynAi4XfQAAFzRbqjc7GF9AUkdTz+FpDhb9K5ngJPg8KEtkuF7HEXyhgtk6/F?=
 =?us-ascii?Q?i/3hALwvXQW3TNsUYOADs7sM4KHge4937jC/EtTDcF/mO9xCvNeBHN6pBMPY?=
 =?us-ascii?Q?rTcjjyjKJ2DIr6wcZs7z6Pu17a2t6nlIOFd9uhQqnmRmcCXVx/9GpUJT0ltM?=
 =?us-ascii?Q?2TKL81V7yYMMloTWDFo3MNk2SY12AvtYC+60B4mh9P1Y/0MPu/EKZJIR6tLi?=
 =?us-ascii?Q?xh6Rw57eOz18Zm5YqmHLopnREhQ1Q4jr/GY+M2E/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912c161d-6c9b-494a-9d35-08da63f46525
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 10:50:54.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0sCK9L7S6cVQCvnmA3FL7Eu1fR/eQh2OP0IK7IPxgpgbGl9laFpn2pzuolRkIX6mGxkCx0fRtw7uW7F/SiKxD/RXtDPW5TgQ0lTqqMiT48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120041
X-Proofpoint-GUID: XEXbQIjZXEXOHKh7pmjKwesFUFuqLBsO
X-Proofpoint-ORIG-GUID: XEXbQIjZXEXOHKh7pmjKwesFUFuqLBsO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git dio_fixes
head:   f01450d13f24e9a01436b60f5f2596ef650c790f
commit: fce393f3e59414984ba87693911080747b08ed09 [3/42] btrfs: sysfs: add force_chunk_alloc trigger to force allocation
config: riscv-randconfig-m031-20220709
compiler: riscv32-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/btrfs/sysfs.c:811 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +811 fs/btrfs/sysfs.c

fce393f3e59414 Stefan Roesch 2022-02-08  782  static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
fce393f3e59414 Stefan Roesch 2022-02-08  783  					     struct kobj_attribute *a,
fce393f3e59414 Stefan Roesch 2022-02-08  784  					     const char *buf, size_t len)
fce393f3e59414 Stefan Roesch 2022-02-08  785  {
fce393f3e59414 Stefan Roesch 2022-02-08  786  	struct btrfs_space_info *space_info = to_space_info(kobj);
fce393f3e59414 Stefan Roesch 2022-02-08  787  	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
fce393f3e59414 Stefan Roesch 2022-02-08  788  	struct btrfs_trans_handle *trans;
fce393f3e59414 Stefan Roesch 2022-02-08  789  	bool val;
fce393f3e59414 Stefan Roesch 2022-02-08  790  	int ret;
fce393f3e59414 Stefan Roesch 2022-02-08  791  
fce393f3e59414 Stefan Roesch 2022-02-08  792  	if (!capable(CAP_SYS_ADMIN))
fce393f3e59414 Stefan Roesch 2022-02-08  793  		return -EPERM;
fce393f3e59414 Stefan Roesch 2022-02-08  794  
fce393f3e59414 Stefan Roesch 2022-02-08  795  	if (sb_rdonly(fs_info->sb))
fce393f3e59414 Stefan Roesch 2022-02-08  796  		return -EROFS;
fce393f3e59414 Stefan Roesch 2022-02-08  797  
fce393f3e59414 Stefan Roesch 2022-02-08  798  	ret = kstrtobool(buf, &val);
fce393f3e59414 Stefan Roesch 2022-02-08  799  	if (ret)
fce393f3e59414 Stefan Roesch 2022-02-08  800  		return ret;
fce393f3e59414 Stefan Roesch 2022-02-08  801  
fce393f3e59414 Stefan Roesch 2022-02-08  802  	if (!val)
fce393f3e59414 Stefan Roesch 2022-02-08  803  		return -EINVAL;
fce393f3e59414 Stefan Roesch 2022-02-08  804  
fce393f3e59414 Stefan Roesch 2022-02-08  805  	/*
fce393f3e59414 Stefan Roesch 2022-02-08  806  	 * This is unsafe to be called from sysfs context and may cause
fce393f3e59414 Stefan Roesch 2022-02-08  807  	 * unexpected problems.
fce393f3e59414 Stefan Roesch 2022-02-08  808  	 */
fce393f3e59414 Stefan Roesch 2022-02-08  809  	trans = btrfs_start_transaction(fs_info->tree_root, 0);
fce393f3e59414 Stefan Roesch 2022-02-08  810  	if (!trans)
fce393f3e59414 Stefan Roesch 2022-02-08 @811  		return PTR_ERR(trans);

This bug is already fixed upstread.  Need to pull the NULL -> IS_ERR()
patch.

fce393f3e59414 Stefan Roesch 2022-02-08  812  	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
fce393f3e59414 Stefan Roesch 2022-02-08  813  	btrfs_end_transaction(trans);
fce393f3e59414 Stefan Roesch 2022-02-08  814  
fce393f3e59414 Stefan Roesch 2022-02-08  815  	if (ret == 1)
fce393f3e59414 Stefan Roesch 2022-02-08  816  		return len;
fce393f3e59414 Stefan Roesch 2022-02-08  817  
fce393f3e59414 Stefan Roesch 2022-02-08  818  	return -ENOSPC;
fce393f3e59414 Stefan Roesch 2022-02-08  819  }
