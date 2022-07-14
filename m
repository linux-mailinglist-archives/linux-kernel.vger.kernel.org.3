Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B295741C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGNDL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGNDLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:11:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E4252B2;
        Wed, 13 Jul 2022 20:11:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNeLCH023348;
        Thu, 14 Jul 2022 03:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zA4ufhGepa/1qekP72fd6hVkqNeT8T7j0RNuBhVGWe4=;
 b=u6zIzXDTLoB6u+w8o73hEVHCED4lFmtBm+VQdH/7/npGdY9zbWDQm3XlLm/BUqAz0YfM
 1Ebn1s5e7M/iOdAuCjVQbtGlH5TsMTlKxYXtfN87UakncDO7JOq76qRYLHz3GKAqql2V
 3yS44fNY82v0vsA5qC6L9zxq/qU27LJPOJWfDSDWPywBGJ4wv0U/vLBOv1ZrY7YYNA9/
 XvdrQGDO+2PWN7h/NSIXh8OfDlfSDPS6VxpJ3w+bOGUwT+VSx0eJ4PYwHoEuMKJA+WAD
 h8Nce7wOoNgCWSKPhLfCx1XJp9SGxbnnRg6lm/2thadfogROyPzWeZx+RJuBt5vu1mOa pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scbyqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:10:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E31dYQ022171;
        Thu, 14 Jul 2022 03:10:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045rxue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNnyS5ZJrmBRm+F92GNADjsf64Y5ELdvGzsxjC5UmfAh6vIwdnSRLykTnpaupA9hNhTjK8bbTLjHgsi48cVrkdMsfiCLmNAZb1QSnXA0VdnfbEGifGdgmR0yGzli4hdiqyf/wuu0s3fZlQBQ8xgGLxJ1Uelf96+nO7WMARCiiYkpUVwU1jgy9aG1X2Vn+3yZmUXYjbEeUQcSWRrrUvYGHNx1nvpTKLT/y7sbIIxguSyWDAQltgswQZUtR41r/EHVjJO1QxzeLShFYJoDIFenzwtgB/O/GiT5y0EWbA6zd/hQ5K4X4Dm4nTc4g0fy0sdbwpiDa4rK+AQ3cthIqg2/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA4ufhGepa/1qekP72fd6hVkqNeT8T7j0RNuBhVGWe4=;
 b=mLbZFBaiGe3XzPq6OxXY72UmPGVLT0Uf7GlJ92l+5KQsCYVgnqnqg27iOsSvSnPYP7W2ottIGjIq+qO7aWwWUg+orITR+W//G600HQ2GPyibO30JrFuAFdyTCjIXy2DDYlvxuVtSZ2Fj3+8TguecA6aAHXzs39jfr9KIXx+8cKlPQlZ22mWi8fM8B1fnqqQlTzY4YaXTQW68NTDMwCTILLzScvHAlhSLgA9ZDbHATTJmXiXRYa4CkxK0GE8mKlPi2k87SOulHi0unmVl8cVdGzo6grgq5NEONJ/NC7oCdZFFh8WHWdmHR2MuJqR/71k3eXaCG5Ks1Iv3raa3GM+fNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA4ufhGepa/1qekP72fd6hVkqNeT8T7j0RNuBhVGWe4=;
 b=TamZdlpXiEZ594vr4LCUHljAOGDvlpgdhDU2/u+F6Wx9mpGAy66f5bRG37giU3eN/RUH9tst0u+GEuwY7YOiTChMPZyl6bjcrGgSRwTG6A4YU9bBOp8cayqxlKGZBbsk2SunCph+QtW4dFKq95KrYbehEzabx8bgh8LM/SCwVW8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1732.namprd10.prod.outlook.com (2603:10b6:405:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 03:10:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 03:10:45 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135f4xul0.fsf@ca-mkp.ca.oracle.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
        <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
        <20220706134447.GA23753@lst.de> <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
        <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
Date:   Wed, 13 Jul 2022 23:10:40 -0400
In-Reply-To: <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com> (John Garry's
        message of "Fri, 8 Jul 2022 17:17:06 +0100")
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2af17dde-19b6-4269-530b-08da654671a2
X-MS-TrafficTypeDiagnostic: BN6PR10MB1732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+aem3NpglZK1V/CAHxFSNLhEYFHSWtyEj3t4YTMK+FPaXC35bZnqNlL4d5PepCwrO1gTOtvzK86ZV8HyWahqeF9o8jiBiAOpYP9yDmcAsEh0OAcujaTLcjyovF8TGgVXupsrP2AdYrJgaQfvRTQXt+1whn/MpUpEPacDHhjHdGCuStAHLXIYLI1q+7csSN4AyBnYzu6qMfdV5bOUxKEpSQs6AaVzirc/p0F6BeH5YxrUx3auUmL7VBZMY5buaNCTrIBbltW8QxCCj6EQ1pJp7RgsiPoDNdaHLLTKjfNKdlk2Uu50+qbBV3JGGZGxuuQTkEtKbcwaHRkmuTcWr6a4/GKSnOnkpAkX/CIMIPT7f5ooZ2EMSZCWUNKbmsKbt3JQjty+lr0/yuBQIe8B1oldhxjIXKZzTimqPVM8ayvtTUrWtDmnmjTAeElWRGjnyCFFbxgo18Niu7aeNgXlxEEnieBqEEgX4C15+IesYSb15NXiaEcpkRiYd3y56VCjMDztuQTodKEDRqk759Opc7nQrfIt7Xwoj+BeHVaSDb1SXMOxwO5kMdq6AtgdWG4yAvFF+ARthD8x4crVFmZuWbkW4mAWYy8XCloWaTY3rjzGh5t7bNok1kgxDtO3A1aTefNMeG68keAtaqq/Coc/wfqbmMtkl5BCpxtvcGL+fnoP4hkCpc8D20m1/SLLCoAyI3JlUJDa8B3vKDOghutJMZmp0ft9Z4IHsFOuPiM4NJIakCxCjGMH8BWTwzlRBxR6i2l6eEIRni0+L2RWoimZCa/t6KF+XdWyNd/icKgFSVSYpcJPA+I6EgztEEUu3EX58V3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(396003)(136003)(39860400002)(6666004)(66476007)(36916002)(66946007)(6916009)(6506007)(6512007)(52116002)(86362001)(41300700001)(5660300002)(26005)(6486002)(478600001)(66556008)(54906003)(316002)(38350700002)(38100700002)(7416002)(83380400001)(8676002)(8936002)(2906002)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1qQlVhc1kvUlV0ZTd5Q0o5YjBwNXA4SmU5eEh3UjhtZi9vUXBsR0ovOTUz?=
 =?utf-8?B?M2NSU3pacXZQeHg0V1Q2bjRpc3hlL09SQ1NmSThuWG40ZDFVK1BnZk5NVWo5?=
 =?utf-8?B?R3ZhY3ZuNU9ZK1dYVFlVQ29EcG5vYzB2SmxNalRGcjhVajhpQ1ZWSG11SGJE?=
 =?utf-8?B?VTlvN2JkRWJTYlMzSWdvcC8yQitBMzg4c3FSL1J3WTRjSFFjbjNzYUw2VUFr?=
 =?utf-8?B?WlhHdWx4Y1FFUktXdmhKMmpvWkxiVjFQNmI1YWQrTEFpU3hPSkwwY0U2ZmNR?=
 =?utf-8?B?VTB1REZFYmxWZk9TWkR0a3R0SmpXWGxOdTJQbGRha014bmllRDdaUHNsUmE4?=
 =?utf-8?B?S25MOXNUMXVDR3MrSzVIeUp0ZllMY3VDSnR2RzVKYmZjd2k3TTFVUnhFRWNU?=
 =?utf-8?B?a2FnUnN4Q2w0Y2dnT1VaWGJnL0dXcW1OWGQxc2l0UTY3bHNxVEJPUldZVWlw?=
 =?utf-8?B?QzRRTERNdkpORjRGbTBYd1RuNit0TW1NSmhUdHFaZ3VKWklJblFteEtETzZF?=
 =?utf-8?B?TjRxbElJYThNR1M3RUtHOEw3NU5nMEhQU210bU1IT2p4dTZXeW9LQkZFQUJS?=
 =?utf-8?B?WmtvVmF5eHVET2grK2U5c2EzSXNzSVErUDZFNWw3ZHNXdXVLRVVmRVphTGlP?=
 =?utf-8?B?OGE3ZXpxZTY0U3ozRS85Z09lQ1Y1OFVneEMyNEczejJBWmUyU3dnMXpvMjZD?=
 =?utf-8?B?c3hmL3FLT3VIYlF6VmZGYlJLRnJBdGdZbVFwdiszRFRVaFlZQVVKb04wZmRB?=
 =?utf-8?B?aWdMajBMV1F3T0pIc1IvUnVGWTVrcElYdmRJWTZUYnMzcXFlU2ZVZCs0ZVF0?=
 =?utf-8?B?OEgrNGVucWxmaDlZdWN0eENLR1ByWVVDTXV4eVI4MTFBUzYwcnVCRjRPeFV2?=
 =?utf-8?B?aFhjTGtpbFJ1S3V6SmxvZElKWGlGb0lVWHpnczRIWnEzRksycm9lb1J3Um80?=
 =?utf-8?B?YzJXMi9DVDBuZXpGT0p5K3ZFNHB0UmpjM0RiMlN1WjQ0SVhNd0N3ZFFRaGJY?=
 =?utf-8?B?RFdCdmlsSXpsWTk4enpzZkowVUorQzYyY1UzNFExbC9QdVZERTI1TzAyTzAx?=
 =?utf-8?B?Q011K1k0Nld3VHVoOXZsUHUyaUkvRGR1WW1wdWk4U3NSaE1NeFZLUm5RWU1h?=
 =?utf-8?B?MkEza2EydzU0M1p0MEI1dmh6S2VkVEtLMjJFY1FWaGJhdFhHQ1B6aTZPNWNE?=
 =?utf-8?B?U0ZRdzVJWmZ5VnBiNS9DRmNkTFFNbTk4RE1HVlhvbis4OEhDZjFhTG9zUlIv?=
 =?utf-8?B?V0pZK1M5MHh1Q004UnhkcVR4Q3NRb3hyS0k0b0hoQXFrbTJlMmh6bWRFSy83?=
 =?utf-8?B?dStoQmFVSVNHd1RzN0dnYzF1YVFoc1NicE8wYU15OExnaVRVN3pKVUlOTXFr?=
 =?utf-8?B?NUIyK1NUdS82dk9PeXJpMjh0Y1libGFXY2doZlZNY3h3K3dsUjh1YTJSS25X?=
 =?utf-8?B?UElTZmkrcU1qaFdCOTFUd3N5S2tnTW8rQjMyUHI1WlZKWWhVaGE5aFkyR2Ur?=
 =?utf-8?B?UGF5cEJYR25GNHMrL24zZXdsQmIvdzZBZGNuejhTcy9KeUNHdHNzTTVEcVV6?=
 =?utf-8?B?eWExcHR2dXdBZ3dPL3A5R08yNjYreHh4MTZTMHhQdTJIKzZYQk1kWUJIb2xH?=
 =?utf-8?B?YUZQUnlQaTNjVzZMa1p1YzVVbnJ3bkNtNndrZllHaTdDckx2VFJML0FtQ2I0?=
 =?utf-8?B?QmxNcGxhRExhbGFOWHA5RW4zVlUwZ015WGhMUGNxRDdWL2NkYUxabUhzMXVM?=
 =?utf-8?B?UDB0YU03RU0wbjh1dCtRZk9DMmVzWlNHbDkyeDdGajRLNm8vWUFOejVYbmVE?=
 =?utf-8?B?SGxUQUMraVRvSGJEU3kvZXR4cGxvUC9BNllzK1lnYitzMFc1dCtKWTBObUtF?=
 =?utf-8?B?M1lVSUszaXdKVk8wbEZJRVRQc0RNZ01wQXRKTEtnSTUxZERMdGNKam5MV2tX?=
 =?utf-8?B?NklpcGhHemk4VGNsY3RPOGc3UmFGbERWZi84cW5zWTUya1FnbmVkYlFLNWdr?=
 =?utf-8?B?bWVzdEs2aExSRmtqZWVYUlRlMTlCUjFUblFJTkVlRWVQYzM2KzZzTFJ5bEJm?=
 =?utf-8?B?MEV1R0hOV1VBZlROSU5CNGFZYkJEdzBOdHk5aHZ6Wk1VYmpEVUV0NGZGeFBi?=
 =?utf-8?B?a0hNRDFlQmtITFJSSVh5cmlXc1ZBRkVWeUJKY2JxZS96VWYzeGxaN0VhRXYr?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af17dde-19b6-4269-530b-08da654671a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 03:10:45.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rvhETq0c3aHCYqRbJ05Nm6NrNP1H4DmDZvVtx6XkYL8JpJzhwwF0nmPxli4s5lMVd+/IQiav3onqSeOsxjtVuratDQD6jHuXqrfPjpeyuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1732
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_02:2022-07-13,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140012
X-Proofpoint-GUID: E3ZMkklUokEeXkAJHM3NhJUyp_XUH9F0
X-Proofpoint-ORIG-GUID: E3ZMkklUokEeXkAJHM3NhJUyp_XUH9F0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> So I set max hw sectors at this =E2=80=98opt=E2=80=99 mapping size to ens=
ure that we
> get no mappings which exceed this size. Indeed, I think max sectors is
> 128Kb today for my host, which would be same as dma_opt_mapping_size()
> value with an IOMMU enabled. And I find that only a small % of request
> size may exceed this 128kb size, but it still has a big performance
> impact.

The purpose of the soft limit is to pick the appropriate I/O size
(i.e. for best performance). The purpose of the hard limit is to ensure
we don't submit something the hardware can't handle or describe.

IOW, the hard limit is not about performance at all. The hard limit is
mainly relevant for things that are way bigger than anything we'd issue
as regular filesystem I/O such as multi-megabyte firmware images, etc.

It's perfectly fine for firmware download performance to be
"suboptimal". What is typically more important in that scenario is that
the firmware image makes it inside a single I/O.

--=20
Martin K. Petersen	Oracle Linux Engineering
