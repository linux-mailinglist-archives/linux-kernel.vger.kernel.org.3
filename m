Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D64FC414
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbiDKS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiDKS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:29:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE5DF5E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:27:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BHV0og018804;
        Mon, 11 Apr 2022 18:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U8q+N6tnqPGDmYMi99qBhen9pUTbn+p8VAWi7AKRrtY=;
 b=df59AWHvXfujoPLIUlKnhPkIxZMkTq6IP0ipFF7GxABXj37rciRi8uAUqFeYJNMcwfQ6
 cGhcW0daS8Kn/u8Y34IZL7BdCc3QYQ5RRXdrUwtAUDtGgLC2gt8oUpR1ZtahcWFFt8S5
 G26utA7d7vfFUZL/VwFEbztXwqWKufR3/oi/Gp7HpYcNsr/FcLp6tP6LYPmY9EEIWOQr
 h4lAMv6RLyhhFq+Slpo7MTR4GXN1KvqdpjrVMwVILyVswGTeg9KC6vlY7ggeNAYYntbm
 z5mc5aeSd+Avn7bf8c6LUcFh7YRYWitxO35KPg7ZpAiB4MLyfvMxMam+7YhFT+uTK/wk XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1cmgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 18:26:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BIGMmC017501;
        Mon, 11 Apr 2022 18:26:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck11w20j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 18:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb6TR/TpgeTnhNjZBsbnPeVaRq20tAn7iWvMiTS2U0n0Izd5B9qEHDrRefjJjfNoSx2r9xHCqu3tB9ovcuSx1LjINp/JQ6M5oeavNKIOj8O4IvJt0w1UQcu2BKAbaBu69UT8pg9ypopDVHSn643oe1SdgG9aJHENBV+Qywzrn+L2HWEBy+Jgxj8PfFf5AxXji3q4fh/eXZdppiEKVRnA/E+6GLlSEqcsIy9p7aeDA3UIAQYu+Kpnxp6wslhEJ6pfbXrBG41VMmrnBZkGcJAiOyaHpiruXNuSgwFv+rPm5eONHmDBKrr4OWT1DkJ+eNnjQ3VckmqqjNXyZuK7Q8YmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8q+N6tnqPGDmYMi99qBhen9pUTbn+p8VAWi7AKRrtY=;
 b=LABXGRVBFpvXZ2uBxq3XXY6VppSX217S4FPznDJ1BxrYoUO3LlyhdVyRKVagnbSJtQe8KVbJLomiaK9SjLCVsab/SmqWBnFcK1Oelf1yKI62kGugcQQq2UfbWXhV8ea1HFdtGh3eyZZjbhIZ1q41UOPc+IRF+fnJNV0kNSuHekXN5rLtMiTE7rHnffqOiWM7PvwKl4/F3DwUttnqWZN5ub6ToUqulvF1QzRa/IqVwHfJ9xWE0WLt/+J08+XKOKWV01V0KOb92UtMLlZGAIz+cEHrPJu4xOetiQZVI6NJlVHa0yxFvH0WL5kpKj6RhECujiwlUDpj/j+hlh7UwN2Agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8q+N6tnqPGDmYMi99qBhen9pUTbn+p8VAWi7AKRrtY=;
 b=hMGc0CvHhEO/A7VW0NPMrTl1xp42xSUOBNOyDtkGuipzL80AyBewAM2guhUhoP6eautrm01rMRlAtqyLBFw11HvU9Of1w+WuIJiVleEfj0fxheEAkYwCMAPe/ssglBIlGNiaUwLpx4/BRIJ43eKZafLWIfg5/ldiTW5UQNIJ/WU=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BN6PR1001MB2145.namprd10.prod.outlook.com (2603:10b6:405:2d::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 18:26:31 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 18:26:31 +0000
Message-ID: <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
Date:   Mon, 11 Apr 2022 13:26:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     chenguanyou <chenguanyou9338@gmail.com>, longman@redhat.com,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220214154741.12399-1-chenguanyou@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64217f09-fd1d-4443-d14e-08da1be8cd06
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2145:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB21455296C4F760F646AFB138C7EA9@BN6PR1001MB2145.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cbRUhnDc9dw255LOPUlFuf3/Y5CF0AkJhqPXtPS8PHQM3eHi0gUiQ/NSmKkZLOND11bN8f6OClBBZCa7jOimvr0u9XdRRYl2sTdtKCglefewzzBCMDM3hD8zGy6CYLn/+4w2N2cY76MuK/VUHYsDvMquxiLbeU9yOe3sd7X+izK/e+O8BFjfgdhnfg04fls9qIIJMIQEG34/UcCWF+ZnOOzM3rkuYTstTHiLwV8tRNYwFx34b7L3igNG4DtdTfQSFkKLb2Lkxbq51KtdtuuH72j0zlDsukWKOiQlT7rir5PiiUhIgwETl8dcUfdFUBDgaU3gtRbV7Z86CgzodaSl8T1Rx2jxqFXqFrTLbtVIsmBBzSm/ax9SOYRZ4BFq+Wpp7FeQlXvaaAKTSMdHsceil737oJR+gze8Ym/RP75H8j4RBT6H56QhSeVx3f3qDvnJq0QV/XbmAMd/k2mhnjBoG2OImTNEtXw0+li7ErGpDwu95rNUvwJxXYOh12x4jCQvHQ/gsHONtHzC7hkAoLlkHgwmIehWF/zejN/wepRIVv44AegElqK+t8a8jBWiGuZRg7t7/+E3JTxIG+WWYS7OS4EIgKFddVD1pAUTGePwo7JwHeWYOEj16F3sY6Z75gLUnD3XG0EJllTx+ZtjgU/TCtL9FetJfy3Epd/JysetrvFO5XScEnri+Ey1qgNurzd5c1F+23SfrFvjHj1OkfJpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(31686004)(5660300002)(7416002)(2906002)(508600001)(83380400001)(66556008)(66476007)(36756003)(66946007)(4326008)(31696002)(86362001)(8676002)(38100700002)(6666004)(54906003)(316002)(53546011)(6486002)(9686003)(26005)(186003)(6512007)(6506007)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhXdTZobEZHbjlSQU9mRmN5TnFmUGozYzFXNUJOWU1vcWtNVHNweWlhR3Rz?=
 =?utf-8?B?TnJzZ3AxVFVlU294NzIrUzVHeUx4eXIrV0t1VmE5RVZQMVZySExwcjZ0SEp4?=
 =?utf-8?B?Z3BmOFcycDVDOVN4VVNMSDhnNkd6SVBFMXJwVkFvc1JPTVhRNlM5OW1peHlT?=
 =?utf-8?B?VVYyKy96K1RUTVNFOWpqWERhankxUkxqSTBWMUdjcG93VlF1eWlhZlJOV3RN?=
 =?utf-8?B?K1JucmtPQ0hHd1JWYzU4a0paZ2M2SXR4KysxbmdGa1FHRFlYd1hncTlMbWxy?=
 =?utf-8?B?d2hESTJCWXdBZFJjbFIrWjB1TytLYVdIVmpud1NlTXdmMnRWMytqblhkOXZT?=
 =?utf-8?B?SjNTVTJEMVJBTVcrdlJvZTNHenAzNnMyQWRUOGxtbGlGaklxTTJOdkNRd1pk?=
 =?utf-8?B?dEpJKzZDd3ZhMi9CMGFzMFdJNEdBb1pyYTk2SFNJSEwwQ092Tys2UnFlS1M0?=
 =?utf-8?B?Q2V3RzJyYkdScmtWR1NZcXVPV0w0YUJqT08yZXQzbzdJbVM0RDlvRFBJRm8r?=
 =?utf-8?B?TUcxNUpaUWNhQlRQSllQNjU1cFNua0JTeUlHYnFHbVYzeXY3cVF3elc1V3B2?=
 =?utf-8?B?aGFnQmxZdDFOS08xTFVDazc0clRNNEJ5ZHd6VnRiWmdGcHppRnNsVVlrN1ZL?=
 =?utf-8?B?ZzlJMVdGWkl0VzdwMVRwaWFKRHA4MUk4R3dmaFdEMW1mSEc4UmJ0cWpTd2VY?=
 =?utf-8?B?WEljSWJRZmNyR2RmWmFSc0pQZGUrbTBZcDVXWG9UdXl0ZUpZYVZxUUczK3dj?=
 =?utf-8?B?aEhnM0xqVmpVdjViMHo3WXBxZDBaZ0NvRVNIWndkZ05mYWZlRlRkaXpxNWNm?=
 =?utf-8?B?OGpUN0FKak1vODBrMzA5bkMxQXkrZlljUkpmcW0zR0YxVUFlK3IydTRQMjNt?=
 =?utf-8?B?d2dwT1NUYVZ4RTRkd1JOTTZCdklZay9xWGdad256VC9WL0I1MXBHOTQ3ZllC?=
 =?utf-8?B?VldWTHVsZXNWK1dQVDVlZ1NFSzloaEYwZFFDTG81WDRtOUMyOXpka0lKaVpr?=
 =?utf-8?B?L0JYT3RuekhMSEhuT1BjNkY0RS9HamdnMmdhd29qVzltU1FSOTlLZkNmVjdZ?=
 =?utf-8?B?eENJYmplUFFPWTdPTElhend5RG8zdXhNdG82amJwaEkzUEZFcXk0cGJ0NG9W?=
 =?utf-8?B?VVNEcEZLQm9vMTJqeTc0UkNTdks0YS9CZkZJbm9TRjVTbDE5RDcxV0FPU2li?=
 =?utf-8?B?RVZERVlqR3V5a2JxclF1RWRZazlQUzZCb0RsVSs3OEtXZ21MOXJUS2o2QlBp?=
 =?utf-8?B?UG1WNUNpWDIvdzM4UkMrZGxWbmlZMmgyc2svdjRwSS9WbW5TcUVzSTQwWnZl?=
 =?utf-8?B?amRWZFo1NHl3TEdVeXBhaStmOU1tbkpLSjMxbENPZWsrYWxJbUJJTTZuQkZU?=
 =?utf-8?B?RHVNMUFXSm9ndEFGNmpCeFZtTFdZcEs3cDAyYUlMQjlsVGdoS2dxcmZGa3dZ?=
 =?utf-8?B?dFFKaGRPdFV6YlFsOHJVdDdEdmRmenFvc3FCVXFrOHdJS1loVTZnaU1rR2Zo?=
 =?utf-8?B?VmxoTWdwY2JyZzkreDBUSmd6TjZNa0hJWnp2Zmo0OFVHRkFZY0M1ODhCK0tM?=
 =?utf-8?B?TUh1Mm9saFY3SDRIK0xDeDI4NWk1MzhjeGNtRks4d28wQVdKei9zem9SZm1y?=
 =?utf-8?B?WVUvTkI4ZXVzMURQVS9ib0F2MFE0bTlGYWNHV0dXbTVNT050YWNuQUk3QTFS?=
 =?utf-8?B?QnpGS1VXK2VycUpldDhsVGJra0xISmkrdDNYclQxU1JWeXlRa1FkVzdwTytU?=
 =?utf-8?B?d1pIUUVSUXFySXZjVENLaE9zYUk5N3hSMTlRdTBvc1MwdWRNMWhFeDB5aE42?=
 =?utf-8?B?czhRcHlNUXgrd1ZQcjUrZDdLTTZDWUZSZGR6enUzUEVJNklvMTQxOXRBSzNz?=
 =?utf-8?B?T0RwUHNvcWpsTnY3ZFZPdG42K1BFWU9tR0xabmJIeElIZ3FmZFozcVRxYmpw?=
 =?utf-8?B?Y2FIN1FEOUZyeU5iN2p3ZFZFQkY2VkVKWTJNclV4N2J2cjhtWmh6N28xRDdJ?=
 =?utf-8?B?QmVrV05ZdGtVVXhmWTdiZGVOa2lnZzZLc3ZEWlA1WmNyL1pLQU5KMVQvSm9j?=
 =?utf-8?B?U0I4dmVUcDJmQVBQclZaYzBjVWNHaFFEMWhFb2VvMEdTVk5STHNVK3ZwTlN3?=
 =?utf-8?B?NVFMV2g1QUtRVEZNQWJReGxzVTRpLzJFdHoxZUFlcDdpK1Rnc1FGczVDNkxy?=
 =?utf-8?B?N0NpWktKalo0dC9QRGRpbjhKMmpGWG1Wdi8xMWNwY2FuTm1mcjBsSkVjTXRo?=
 =?utf-8?B?cUlGOWs2SEhQcmhXZFhYYTA4RThzRG8wZm1rcmRMWXpNTEZ5RHdFbDV5OWMy?=
 =?utf-8?B?Y0kwR1M2UmFDNTF2M3o5dktiK3dDZi9ubHZmR21UNTlJS1RyeFlBcnluRHB3?=
 =?utf-8?Q?r1Er83uUkzkIbtUk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64217f09-fd1d-4443-d14e-08da1be8cd06
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:26:31.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEE9lgxizM4FTomJzdlVRVOoQIA32Iiyi8i+MlIrlYQVfDSNc7a8TjvOdLyGQ6bNrZ442sHRvXaG/VGP5Hlrq8UDoogRHcfNOnRpgi4uULM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2145
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_07:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110102
X-Proofpoint-GUID: C62m2TLrgeiY9mVI2USkb1JPYWMyh3k8
X-Proofpoint-ORIG-GUID: C62m2TLrgeiY9mVI2USkb1JPYWMyh3k8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 9:47 AM, chenguanyou wrote:
> Hi Waiman, Greg,
> This patch has been merged in branch linux-5.16.y.
> Can we take it to the linux-5.10.y LTS version?
> 
> thanks,

Hi,

As a FYI:

We have observed that following lockup with this commit added to 5.15.LTS:

d257cc8cb8d5 - locking/rwsem: Make handoff bit handling more consistent 
(4 months ago) <Waiman Long>

The "fio" test suit fails with LVM devices composed of four NVME devices 
with these observed lockup, panic.



ext4:

PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
  #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
  #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
  #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
  #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
  #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
     [exception RIP: _raw_spin_lock_irq+23]
     RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
     RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
     RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
     R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
     <NMI exception stack> ---
  #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
  #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
  #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
  #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
ffffffffc11ad9e0 [ext4]
  #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]

xfs:

PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
  #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
  #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
  #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
  #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
  #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
     [exception RIP: _raw_spin_lock_irq+23]
     RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
     RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
     RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
     R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
     <NMI exception stack> ---
  #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
  #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
  #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
  #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15
[xfs]
  #9 [ffffbb7ec9637dd0] xfs_dio_write_end_io at ffffffffc072db62 [xfs]


I have reached out to Waiman and he suggested this for our next test pass:


1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock path

-- 

Thank you.
