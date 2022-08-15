Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8686592A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiHOHYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiHOHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:24:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD313D75
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:24:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F5B5XI004868;
        Mon, 15 Aug 2022 07:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=YnDGLmez9Lc3bOSmRyPl8mbbgqBiXfZqxrzzsXHe2Sw=;
 b=VzPF/oXTJj6bFPSy2SlUicfF+Vt+4yEPv/iuUdkUuUzel7IQLKWVkNys6OKZNNz+qmZ2
 6Gn0tw8KDjuSYEdECz3SVPCrnTO9zvxkfo451TxPODSzRAurXip0ZJFW97E8d9RAG3nD
 YNfD+9VkFujjhoVKX0O16Z44QrVR+8V5AsO8JtDEMtb20EC2WqM2LldnNbrpm+smGH/L
 BmAcGzbA2gOj9f7UjMCCp6NyIfKtHD8knmgI0PJ4vmdnEERjlP6s7U/IYxo2rll9oQnf
 w0e/aKnXAY+hqfLfn77vMmpm2xXLidxvTFfG54rtodrKykrmjRzKN957+5vTI56hvwnA 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3js2bc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 07:23:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F46c39031757;
        Mon, 15 Aug 2022 07:23:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d165rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 07:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atakgvidNc21De9rJuAannUFP/28TsheuvOzq6tGjNVRtWJtPwARNhYHkti0V9UH3q5ploJsHjgy3kCFxWynzPthCW2qrnxTNaPtDK8D3d9R+JbRLKQxK+sQHANgyF73T3PZd8g7O+pHkRcabBCkEUn10t4tiYEnKGyqDCPBtPu+EGcZcQFUDGHxgSU+izrZQ6Z3uGAXdW4vpxswuc08rYmKKclkfFvIEs5TbnwR2X0Z8EQOOt+cFwiOapD3A1PP3yNSKqScf1UlG0kZI3MD0VTlS9ImCNyADN1zL9v9XfL12NSINhmQJ3a2Vjz8hhFBLBmRStSV1ab2NDYaLujdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnDGLmez9Lc3bOSmRyPl8mbbgqBiXfZqxrzzsXHe2Sw=;
 b=MjT3kIVaiw0WGRnDph2c3y6YGh1xFcyb/66e+jf56g0gKDXpx3sPFQWbrO2Z+qYnhJiNVNWK7spvvYoTQelqYsGJeMci1eqA1W8gkgElALtAE7ve++KDK7Uw/dTwGBz6tITDS5SgysKb9EwmHRESAu3TiudjHXeIlVBeaMWHtTSFAnU3lSIeEExBbSW1hw1HmTMXR2qMzayDe2sVbbd0Wen3BC/c1jlrjzXZp2ho6ZTyK1wQy7ws/cAxq5zhHJJ7uodVTGoz0nQYBLQQTJo06Q/ckYV7yd1EXgP3/oCtYnH6U0PVOipmU36qgLKyzh7tpKOdlKjHQ70dsTbkGrBfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnDGLmez9Lc3bOSmRyPl8mbbgqBiXfZqxrzzsXHe2Sw=;
 b=aANqkAb1zvWl+9MKZGPdG83Gwa2w5xkWp6NhkJmC258UKXxKlkF4eYFLHvtUVjC2Uz9h/sy0//G1bIkgv0bVYfzyEokduBzpgnp5wuOGFi3BWvDjseFZQy9Yt56DzVMJUyF66q554S/NiTHHGGQENIjwqYsIsDBDmTx/7wKGJfE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1754.namprd10.prod.outlook.com
 (2603:10b6:4:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 07:23:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 07:23:39 +0000
Date:   Mon, 15 Aug 2022 10:23:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error:
 uninitialized symbol 'prot'.
Message-ID: <202208140141.4uzWszG4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5d15ff-2745-435c-e5b5-08da7e8f1310
X-MS-TrafficTypeDiagnostic: DM5PR10MB1754:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WytLuL2QCjEJWEgifhtqlG0rstvBMYE2uLmMOr+WR1MFhaaqONOKvLLR9tpJcajU4IpKJrU5DXm/qZsJcCvxCAEbKBKM8o7n6idc9I3LdEH4mk3U/lDJHgXDaDOgoRiKIMvkV1Y4181DWEgYx6hJRYN59B3ikJ5tQLlmfiOppICtT70kBH77XaKlMLP2tXfvCMjRRyVu/4MWNZTlvsCKs4VodEHIjcJ4nBrsITs63GfrZktGsHA6boKQwM/08tK4QS5xfbyLR2SOQ6r9fo7Q9Ir81QQQ4ZwXL3/JT2WUY3xwaDw0ix8S42W4f/x1jjYvKZMbgJrjsrjwRjJnGOyEepM9zHh0Ylk/XFuwNWCARWtFwGqntQDNlcBFNZTO0BCVS6SoBds88ghYH8oYvbk7he/C6yXnGImcknjbzu4A4ut9SHX8rrHuoV8egDYgGDaxMkdj+yr5hf0Py+gzdLRdgf7AbNUqR6gA3ijKCNQ9meXgrwh6pFiUzgBxHm4skT+AohrBYsIkT4REV+Z2q06be7ogT/wezsA2P8+okPbHQY9K+gJ3KUGKK53fj3EbHYNJrKTJskkp85pNsE+5YXlEnoZFoMvLeAQ9WqBZhKRUtBzLn3sEH05hCmHmJjP7w8yvyaUiS9a3cDGJ8mW1CKCRUsnvG7A7WlV9i3OphkUQc5TonIVpHFY7wWHjC5dqdxPRQyZkHXww3alzAMjcv65JCcaBNVvKvm0W7UxmCgZNjfoX5+5H6PNl0vFZPFfISBMKxdlhL7LL1vuIicncFlvAeaF6CqkX2vZMOKUYzXYjnNwg9enMIQFrDBVP+bFttUru6TQ6/aGgZz6TI/xQ+PpNHhIeRmQDT6N+ri1FSZ+EEWmQxf/Hf2fiWaZ/ey6XlPZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(38350700002)(86362001)(36756003)(52116002)(83380400001)(186003)(9686003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(54906003)(41300700001)(6916009)(478600001)(316002)(8936002)(44832011)(966005)(8676002)(66946007)(38100700002)(4001150100001)(5660300002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoFg53631G2Ly3MoP+B71cnozTdfYU1/ZMM30HB5LWAGgXm5WuXbPtNcDpPJ?=
 =?us-ascii?Q?86OThyVaxkVUUA7R4qIwgIQut5oFyPKqTwnUtJouyAdPhFpjBUqwO+QQbHZR?=
 =?us-ascii?Q?PMD/PBGitxYXyxa02VUhMAB8dBSdGl9QJroiOPL5QcJ+qCcddvy5sKQ4X5iv?=
 =?us-ascii?Q?Q+G582cyZ4tSVQnHxf2o3LUw8IRsfT0IbZZyPgA978QjsC3nCA7rip15rkC7?=
 =?us-ascii?Q?qPggKcJXKEOcqqu7UDqqQKeY7fjtSX4A68eGFjPkff0X9AnEhDicjB+oJVVX?=
 =?us-ascii?Q?ud3YBpjFr9MWlHnPmJHKQVXDLKBvz6kOxX8ZUKKhGKHqtHkSeQFHP5upHFTq?=
 =?us-ascii?Q?irMfhJFpHBXpzEeEcZ11QYPE2h+RuXw6gH5/iy/FE8ZzHeuOEkMpfRch4VCe?=
 =?us-ascii?Q?JYM/clqPekSfnIroak33T17rintBJ0fwlRLWqS36gGJ9gyvU6xMATXONaPVz?=
 =?us-ascii?Q?LibjKv59jJdEaZMQb/VGuX0lsPYZVpG1+2F0EZoE5LhKsI2Ovn/PLOHwv9Ft?=
 =?us-ascii?Q?f/9ULl7cOEXW94AYwqHeoIfIXJ/iR3JaBs9HHBLh12BL8RpXnU0iTLLIQhn5?=
 =?us-ascii?Q?pk8EkDr6pNATdRCxfKtLm/v9+xrsMHs+AoJSbj6MQsmdqq5EVf5lStM8lagv?=
 =?us-ascii?Q?ENDL7h6ry0/YQV468x3MQylIZwyA/kS99SBHPYMMsO88hdDe3QTzZALj8EPv?=
 =?us-ascii?Q?jbMaDdw6LMPWdxM40vH72wRhUsmWyZd/Vo1jfBoG0g68TjuMndoCUFx+sKy+?=
 =?us-ascii?Q?isotSO1tYPUHvg0QoRxfYUWTCiNyfBMj3kBWRghzAEYsNA0mlSs39RNDQ2ks?=
 =?us-ascii?Q?XOu82krO7Vn2TksD76Ue9wzpSRKdMwvrW49oJJemGga/ZRZCmnjhcFvrKGjS?=
 =?us-ascii?Q?Av8uZHXZ2aPjIcmumDlCKcH7IDOavZbC3xu7gCxnNmM0QLRPV1NQdUpOJJ7z?=
 =?us-ascii?Q?57ACxpq9Irg2yOzf4M017tX5yjfBgJE95ciKWc0FtwLPBwUVuSzPR3gT2rYf?=
 =?us-ascii?Q?m3u47W5DrR1Qi00cETB4/3N11Qcj3iSbDeNq5HGceoQrpuaqewbZzCyBFptd?=
 =?us-ascii?Q?mbdepmODDg2lcAJrMg+FSVo3ui4B7H2iQgM98n8TyUAuP4DCj66Vnb3cRgao?=
 =?us-ascii?Q?U4IpH9uLzT6vPzA9FPrvIuAhpNfnBgJ+RrqTuplFoxeQsXMOXql+J0cR93CN?=
 =?us-ascii?Q?1k53tcKNniUVINwbg8Xpfxe0KDSMsY9BT9TkX2IwSx1k/dnCvSFdXaxrEkd8?=
 =?us-ascii?Q?dZVXchKtwlwcMJpXZo4t4x8shAV/7p+JI2Ojmav0f45lloSxaO9K8y930GRq?=
 =?us-ascii?Q?thSeOqJYWjwi/QSrsKozpW/ztsN7CqPU4oQX3ITSNMF3TuEJH+BCQlh2tBVE?=
 =?us-ascii?Q?bF4fAMt/9One5CfzD5YHLVUzwYc2XKePYhS0fWnU1SOfU1ZwfBsNOYSPqYgg?=
 =?us-ascii?Q?mMIkhWSfQVbzv5wjUMeL5opRXaKePFWfQv6mG29ist+s+5cZtxdRO0MKVr+9?=
 =?us-ascii?Q?+tILuTgh/LHelZS8YElfcJcggm5Ja4cficm3EuOq3uSHzglkdrq7Xx6d+0va?=
 =?us-ascii?Q?3SFx2wJii9brwr/NhNrxjkO+typ+3imTKnx3OK429Y3YKP4nmPnceUQPL8vA?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5zTG8rTUF2QA6FnVOyHNYom5urPmbEEU9G853Al636GspgWobp+unD/bzTJ8?=
 =?us-ascii?Q?05UMwjMkhzA/dKcx+1ZiNDL+I7yBW7ZgQb8KLTDS61aUjwSTzkHvFCa6TaPi?=
 =?us-ascii?Q?zs+2OCjJ/HqtiHDU/d2p/FSHwtvGOEgQtnATE4LiHlIQO7yT28xoiVwhDj8h?=
 =?us-ascii?Q?7B/h/c1a4Lm3n5q3wK7wsQNFlyI2NCTbgZ8ORq2bficecZVGMNGxf9m+9VZS?=
 =?us-ascii?Q?+6bCHawXk3n5Ee1AjE/P5xIXw8qXWtR8Dh2e/199w76i0Eu079x4rhHFonn3?=
 =?us-ascii?Q?r1B/Uz1KNEkuY+CG/U+OfMPYPWOrcrQdHD4RfIfPuZt8ObB6pFfjxygvAXdo?=
 =?us-ascii?Q?gojz41cK0eqa7O5layl9M1r126KnYOlhOAZjDQpXne26Ep6272ZRciSktzcO?=
 =?us-ascii?Q?CXlf/x5SXoE3ZnTXNwpBDmOPvvlQ7nknx2Iy6GhYOioKltBtw3zM1tpHKNQh?=
 =?us-ascii?Q?3IZRx3CFJVXbc3HRxTmJre7KdefH07EIvK0JCcUMXyd5vJpFP9kN3i+lzCkU?=
 =?us-ascii?Q?+/5sOgdRF1pUvdBuCKjeoB+SyR/DiubTAJiznHPQoEZm9GjJ9MaublxDHjPr?=
 =?us-ascii?Q?Xg8vrje4UXoMgzjaDmA4x2JhWNbuGuA1yHchb4uTs44dxzmAuxHN8LPCah2/?=
 =?us-ascii?Q?AM+WsPnRH+xsE5YuQdLLrKuqbdMmEGptKGdSEWrMQly0xKCWPa8/OhnmEiAS?=
 =?us-ascii?Q?Oa9R88zOzbAcOcMvFTCsaiuXY0KrgzQRwt5t5IAEVO3zNZ+GXL5o+TytejST?=
 =?us-ascii?Q?VIlrBkZItvgOPyWi5wXULRVUmCJc1Im+WU0tBXxzf8aBIYaYquaT5E049+hi?=
 =?us-ascii?Q?ElzilVwByTpCZaMUwXim1Jm2ZTF7UMOwdZKJvVPDdAnNqhIjm4iRtlp6tAH1?=
 =?us-ascii?Q?9ghh2XwmKLOOif/tVbv+/pXH5U3hpfOxzqGpSKvDLyHK7CYM7UbzNxYotdUD?=
 =?us-ascii?Q?eVrc9sjL2lsi+Ms/HYCW6JB96PF3nWZ1Zj/7CBOGyC1LL3EGIHNaCCK4Xb82?=
 =?us-ascii?Q?negRyejco4vewBV0AtyDEBT7q7iTQy/1Nq9eLM+ekbqfxxM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d15ff-2745-435c-e5b5-08da7e8f1310
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 07:23:39.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwytAtOhF6jqEXrudYi7SQ3WhdikPrDo39Ua+b6s1pJlGZbWE15ZgL7f12BhBsRzychrlPflGDe8ZH3GEZ3Il4o5mUJBcre4ajNbKTGJkIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150025
X-Proofpoint-GUID: Nz7LAUaqcWle_zzEZTqAuLLrFjTo-87B
X-Proofpoint-ORIG-GUID: Nz7LAUaqcWle_zzEZTqAuLLrFjTo-87B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: 7faa543df19bf62d4583a64d3902705747f2ad29 KVM: s390: gaccess: Refactor access address range check
config: s390-randconfig-m031-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140141.4uzWszG4-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error: uninitialized symbol 'prot'.

vim +/prot +859 arch/s390/kvm/gaccess.c

7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  831  static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  832  			       unsigned long *gpas, unsigned long len,
92c9632119b67f David Hildenbrand        2015-11-16  833  			       const union asce asce, enum gacc_mode mode)
2293897805c2fe Heiko Carstens           2014-01-01  834  {
2293897805c2fe Heiko Carstens           2014-01-01  835  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  836  	unsigned int offset = offset_in_page(ga);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  837  	unsigned int fragment_len;
cde0dcfb5df1db David Hildenbrand        2016-05-31  838  	int lap_enabled, rc = 0;
6ae1574c2a24ee Christian Borntraeger    2017-06-07  839  	enum prot_type prot;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  840  	unsigned long gpa;
2293897805c2fe Heiko Carstens           2014-01-01  841  
75a1812230ad7a Alexander Yarygin        2015-01-22  842  	lap_enabled = low_address_protection_enabled(vcpu, asce);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  843  	while (min(PAGE_SIZE - offset, len) > 0) {
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  844  		fragment_len = min(PAGE_SIZE - offset, len);
2293897805c2fe Heiko Carstens           2014-01-01  845  		ga = kvm_s390_logical_to_effective(vcpu, ga);
cde0dcfb5df1db David Hildenbrand        2016-05-31  846  		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
cde0dcfb5df1db David Hildenbrand        2016-05-31  847  			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
cde0dcfb5df1db David Hildenbrand        2016-05-31  848  					 PROT_TYPE_LA);
a752598254016d Heiko Carstens           2017-06-03  849  		if (psw_bits(*psw).dat) {
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  850  			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
2293897805c2fe Heiko Carstens           2014-01-01  851  			if (rc < 0)
2293897805c2fe Heiko Carstens           2014-01-01  852  				return rc;
2293897805c2fe Heiko Carstens           2014-01-01  853  		} else {
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  854  			gpa = kvm_s390_real_to_abs(vcpu, ga);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  855  			if (kvm_is_error_gpa(vcpu->kvm, gpa))
cde0dcfb5df1db David Hildenbrand        2016-05-31  856  				rc = PGM_ADDRESSING;
                                                                                        ^^^^^^^^^^^^^^^^^^^^

"rc" set but "prot" not initialized.

2293897805c2fe Heiko Carstens           2014-01-01  857  		}
cde0dcfb5df1db David Hildenbrand        2016-05-31  858  		if (rc)
6ae1574c2a24ee Christian Borntraeger    2017-06-07 @859  			return trans_exc(vcpu, rc, ga, ar, mode, prot);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  860  		if (gpas)
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  861  			*gpas++ = gpa;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  862  		offset = 0;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  863  		ga += fragment_len;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  864  		len -= fragment_len;
2293897805c2fe Heiko Carstens           2014-01-01  865  	}
2293897805c2fe Heiko Carstens           2014-01-01  866  	return 0;
2293897805c2fe Heiko Carstens           2014-01-01  867  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

