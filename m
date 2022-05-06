Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47CA51D519
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390769AbiEFKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358846AbiEFKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:04:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB05A2D5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:00:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2468mC4f026110;
        Fri, 6 May 2022 10:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LaqT4OBSKub/dpQFpdjs5YaQwQz4X3+rGF3DmVL0Cbo=;
 b=XT5qc+PJWSG7/t6jmKPU5dqwB3B5dVr/ZGrfXYOYH4gAGlQCgfH5cPz9AQ9ZdNSbOokY
 2toRUk1lxupvheNdK1784f84+5O9jNvHH+eoIA2qsuybgbix55rl3V+IJvrC3Snzfyao
 P753eewBFz0byGIPdZ8AUgMSPrQl3+BcL1YjXK/2mRi0XgHx0RQsY9YMOTybVA4NNJYP
 UYbQmPGWNb39LRx5xDEB5rPND9K7HH7dZnZHvM04OvFkrkCLPwhxhhTHHQVumF7wlmQP
 UtSml+KbziDm9wbMcU+mfUYnMtJgjUFcvv7b5g6mPpGgwCkBq3LX7LZy6c2lIRMtBdcR cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcddss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 10:00:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2469usNQ024067;
        Fri, 6 May 2022 10:00:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus9051n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 10:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFvsAzJFTvWtM16JxBnn76776whqV3wZSfyNuEcUQo+fMBFvKsS5aFHnpGGMWcoivOR4FJP6UkZy/rFc9wN92aEvLq5PA7yjK9QROwEPcD6lgi3JQ+ilVKk1nzZ/g4pKwqvW7Blz5HpYBaZpTjJPdiL2EGa6Q6dZPn9fKJtR9SKUJjLMyShN/m+n3QbTpxn7tGFTq5m32t9rDbXi9DDMOc8X8BPON+a4E4HUiMqSsBjwO0Z1wruGY+Qcdvm0G2NiU/3jiXKfe+rmfFdRDdt0JvKyqUlzSmaUS0+pnu3kJExbR5g3rRvt4SATzxC+4v5KFCNKOhmVYAlaLWKcd33RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaqT4OBSKub/dpQFpdjs5YaQwQz4X3+rGF3DmVL0Cbo=;
 b=VHbDt5H7LpENt++67T1sbx0ZMhua3bXhl+B9/uzz5fPkvBXvpfC5TErMSEZarRca7YFa+NPtw4p90ZnSzOi2vYzzQ4zGwuFZnpCZMDsOcER06owMlt3Rlq5MKBmsHs/VFYMr+ME7raFwru23rwtpNZdojQ9eEUxxgCumk6Rn64nP4UPyWyFzLV5p7kVeMzTiZw9HIHqz5R3VMuFX7zjvkOeL0Hjn8qwvz6OLTtAvgxgMsSyF/G/sEuxjecGqmHezvizl4qhUO/VlUSn5WIfVkZ/6GO6oIeuDOZc13E3HpZiUUmjC4a+JN0s9ozHSSPXx3LzuYP+5YMdshIrJOon0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaqT4OBSKub/dpQFpdjs5YaQwQz4X3+rGF3DmVL0Cbo=;
 b=H0Ah05nCVcDAVQ0Bn3X7n5h7vD5BEKtebSwy0eadq1Y56kXRpv1qSqpdmmHFJcubkYwOd4Z4nQRJhvTipqlCqk2tRX65kccpkhmJRtQv69QwA+kp/Tm5SynkLUuYFUYXUils3SB5Ce/IbG5tuBq2D7q2G52VETYhJ1yz+38hOZA=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by BLAPR10MB4995.namprd10.prod.outlook.com (2603:10b6:208:333::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 10:00:37 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::7d41:aa0f:80cf:ea15]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::7d41:aa0f:80cf:ea15%6]) with mapi id 15.20.5206.026; Fri, 6 May 2022
 10:00:37 +0000
References: <20220506080341.GF23061@xsang-OptiPlex-9020> <YnTcP86M0NV6lkfB@rh>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  83a21c1844: xfstests.xfs.533.fail
In-reply-to: <YnTcP86M0NV6lkfB@rh>
Message-ID: <87tua3ou9u.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Fri, 06 May 2022 15:30:29 +0530
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cdf39db-5534-4329-4d1a-08da2f474529
X-MS-TrafficTypeDiagnostic: BLAPR10MB4995:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB499522CBD0BF690C9B014492F6C59@BLAPR10MB4995.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUUKJ1qeglqI+nhsxsLNWzHM29RYDbYDOWgbLMzpN6IUuigIr/BZ7leqHtP4T393KpGRRgzyTDn8y+wLNPwnWjp9qmrRtzUxamUEbyLK1dr9LqTFMievyH2iuwRRAcncp4qzdsezHeov5j1kwCVvDzJj7//Gt+m2yTBRMy0Dbkv736epr3/eXdnzhx4g+Wi6yTqjungeWoII5qRl/H13np4jcNhTm5gsryMRKF6kQQ0lwurHE6A1VO74Czxnuk98S9HQZE8vp3FbUm4GJRRu75HuZvNDNCK0fqzK1DY0XBuCgeztncRuQg/Usu8qjTNcKeliV4ZZPyDQIriRCSgp1Ed7bJlxPko2iwsr1N3UVn25MjJhTIoK3bGS2tXePPx4iYYh/R5Y9LF5QoH+d6zPIlyUFqjgvcQUTq98KY3C9y/mhuOsIt/GmGO0tB1B8i9YUGXCdGwPfR5G3yi/TJryztME1ZV3AFx554UqflpCFua+VxPGjSByJCkT/4q8qjNdMRMY5q2QMNeBGCQ3E1b5ObS7K0r8lHLdSlTaFnH/Sry+IfLkD2mdSP1jUWRPEyVaKDHS9rnQrjh5CIzdExbFL5vMOL6SV8UTK82AIPtDtz37ojGSskkmA8PsShTC1az7VUf/H1yqcGAS9NvdBU5RG7d+jgU1aq//elJhygmkCTim5qFminuCr80wEUQAImEDdZJRc+8s6VWRdSjddTZaAcrdFaSbdJkvMZuo49ItaF/ZiKrcROzze1JrIGbRiSGwKl9VNDbTOnf+SncIdcDpjLZjWhlzFjZZ4ogLYIQSKjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(83380400001)(66946007)(66556008)(66476007)(8936002)(86362001)(53546011)(8676002)(4326008)(6486002)(966005)(5660300002)(508600001)(38100700002)(38350700002)(6666004)(2906002)(52116002)(33716001)(54906003)(316002)(6916009)(186003)(9686003)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8g/zCmQcFX1cBy1S47aZa1twNWVGN7ZYmcNXtWkAs5QtQSoN4vZBGQcPNbCE?=
 =?us-ascii?Q?W7VX3+8M6+zKox4phZJXXwVPQVch5NOWvL8xdTxQqE1Wi+sVqInk+stqxUKY?=
 =?us-ascii?Q?Rg9zRDPTAa8ltMjYFMg2CpPJJhNesFYdI8Rk2ZqeMVIsL0SXY254QvH8mJxG?=
 =?us-ascii?Q?WxlEHIuh3J0Ui/nd6MvgUEhLIkkNvtMVsRfkUxJWkm7iYD5bttd8ezG/G4hN?=
 =?us-ascii?Q?R6BBzJHDn5eks+QDHp0P+x0wi85vEUFk2g1NK7HiHeDwMpKr7DEOkhDqw6L2?=
 =?us-ascii?Q?Oz/Vjh2ZE/97XsV0n0YzcfDxTQAmapUO7t0LFm07vBCRA7L3k3VrIsp965ia?=
 =?us-ascii?Q?vDo2xhuvujajXJQRDxIXCtaKjxxz3ZV6t8Dukq5RgO5/hnaVPnriecZbhd/c?=
 =?us-ascii?Q?QCmhic2PKB8WDgzM1winBCF0KISozmyecW2jd/C9U/XFCZBgQqC/2fY3UJ+2?=
 =?us-ascii?Q?oVENQTOkvXjfmgeJipkTwZtCxoPelIVJEwUyyH1QzCknuvCZ81V3aOq3cTzY?=
 =?us-ascii?Q?1A3eUTT0OdJIINkMa/Qy221US4Hv5l/WOUorFSkQ+Q0PAmuEUzvbNd8U54Rp?=
 =?us-ascii?Q?fWQfZ1+mO8My+zfsUFeAh7IOkW209cx6WAFXnrxSOmP+YW30AbnDxlR3/qyq?=
 =?us-ascii?Q?PYdFsRWsL0BPU8ZSA9iWo7y/tRvvNTXWVfOcL7A75GOozHP3bt4J4SZeaY/J?=
 =?us-ascii?Q?u3GJjEicxbf/ICv/+QFnYDyliGss1IBL/B2xGbPvpAF+dmHmoqFiVHGoseOZ?=
 =?us-ascii?Q?crqdnVlsWOrVT0A5wS9cQM/4wuYH50WetQEWfOKRRinHGTwRZAX+LXV+Kp2N?=
 =?us-ascii?Q?zd0BUHjlrh1+yonOwt9RBrDkJT0bKmiTwlHhLXTqacEbCGS84uIHdH1/AcY8?=
 =?us-ascii?Q?KDElUtZ3qRG8RBzYcEWU37Te/HHB2/Swy7d1EvnWFY5mUMFAD8bzk6EnpD6L?=
 =?us-ascii?Q?FZrj4HEGImqosfoZrxRZ7am9/1ear9Rae+DZzWkRAstclu2rQM6e8XjL3qxo?=
 =?us-ascii?Q?20IiuIcRE8kvrotaWlMB7VXfy98WDVX/8vgNvJQQivjdnnv+myHV+5ZiPSO9?=
 =?us-ascii?Q?AQWzxd3hEu2xCoJ+dp/6hJ8Bq+oAcE66G0N4vHHVZjA0GzMW/YUhNIkx5FLg?=
 =?us-ascii?Q?VnOUOg6AkBy+EKIqFrRfvuGiqHgdctjcniBlsVIj4EirV+5NcMS3Pn4FGZFt?=
 =?us-ascii?Q?F30u9t8dVVvyPrNlcS6aHNd9rshW9oZIz+GhveiU03oBVPntMkkRCwZg4EJI?=
 =?us-ascii?Q?fZ/ogT7kgZ8ETHuaBU7MSRplVThaO+V0ncCIUGDIlqUgpLkYcxWCNvO0TBUA?=
 =?us-ascii?Q?z2++N+EgtUSjxW3OZXKwrlFOEcIZwGBD5mu5v/JyKE6KsuCF+n4Tnos3CnmO?=
 =?us-ascii?Q?iGtpUOAXSZelEQ7aKrjr3dhz0JYOrPFNhdj7dNzQRSRCRB6It2ytxZHTtx58?=
 =?us-ascii?Q?yint/4lazO+FyyiKXmQlu7jc4ux85Bnq3hT7KPqqXR0HyxwsMXj7UZlJxxea?=
 =?us-ascii?Q?OoCy387GfZFQdHhZkX1UdqnC2+1yXwlL5g2867IlPFgdr4xjk4p6wtwOEUW/?=
 =?us-ascii?Q?CLe7gue2ZlpP8kK2Ov+VqtspBUtMHL+G+KUlUurT5JlRqurwyI/A8JySw9Xb?=
 =?us-ascii?Q?aDfHmcTQ+Q48+5znNUgG4M9mDeGa0ldSfNeB+roCqncULEpUKpsL6FSz9cvP?=
 =?us-ascii?Q?1xlgsYX0WpyVM1Dock1emq7LJGir7loBUlereXaDxe5sW0bVQ3pGR3ZK1tAY?=
 =?us-ascii?Q?F+54TgmEeAo8lJmtDVyeyoHa/YvS2x4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdf39db-5534-4329-4d1a-08da2f474529
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 10:00:37.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cceo1x3d2+gryDz7DnvV1IEUy3JktHW0yCq/7d2osqXFmdP2gmr7+lgA8pRHyWTEuoZjXElVpEcrMZRuZzmsTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4995
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_03:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060055
X-Proofpoint-GUID: rpZfzcAfqnSrPl1Z-LZoWPsOsyosyZUu
X-Proofpoint-ORIG-GUID: rpZfzcAfqnSrPl1Z-LZoWPsOsyosyZUu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 May 2022 at 13:58, Dave Chinner wrote:
> On Fri, May 06, 2022 at 04:03:41PM +0800, kernel test robot wrote:
>> 
>> 
>> Greeting,
>> 
>> FYI, we noticed the following commit (built with gcc-11):
>> 
>> commit: 83a21c18441f75aec64548692b52d34582b98a6a ("xfs: Directory's data fork extent counter can never overflow")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> 
>> in testcase: xfstests
>> version: xfstests-x86_64-46e1b83-1_20220414
>> with following parameters:
>> 
>> 	disk: 4HDD
>> 	fs: xfs
>> 	test: xfs-group-53
>> 	ucode: 0x21
>> 
>> test-description: xfstests is a regression test suite for xfs and other files ystems.
>> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>> 
>> 
>> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
>> 
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>> 
>> 
>> 
>> 
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> 
>> 
>> xfs/533	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/533.out.bad)
>>     --- tests/xfs/533.out	2022-04-14 12:51:49.000000000 +0000
>>     +++ /lkp/benchmarks/xfstests/results//xfs/533.out.bad	2022-05-03 06:24:37.310381846 +0000
>>     @@ -6,12 +6,4 @@
>>      Inject bmap_alloc_minlen_extent error tag
>>      * Create directory entries
>>      Verify directory's extent count
>>     -* Rename: Populate destination directory
>>     -Populate $dstdir by moving new directory entries
>>     -Verify $dstdir's extent count
>>     -* Create multiple hard links to a single file
>>     ...
>>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/533.out /lkp/benchmarks/xfstests/results//xfs/533.out.bad'  to see the entire diff)
>
> Not a regression. This is testing directory data fork extent count
> overflow using error injection, but you might notice that the title
> of the commit is "Directory's data fork extent counter can never
> overflow".
>
> IOWs, we changed fine grained directory extent count overflow
> from a runtime check (on every dir op) to an inode verifier
> check that is only run when the directory inode is read from or
> written to disk.
>
> The test probably should be removed. Chandan?
>

Yes, I have just sent a patch to fstests mailing list to remove xfs/533 test.

-- 
chandan
