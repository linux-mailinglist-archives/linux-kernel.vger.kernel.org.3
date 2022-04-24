Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4D50D419
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiDXSN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiDXSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:13:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A53BA6C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:10:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23OGa83V022232;
        Sun, 24 Apr 2022 18:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nzMJntI2rKxWeSgLPQUl3FmXqyfq27Cgh/lYk/ng5Y8=;
 b=deUECF8Z/3EI4lb5akHHDoDu5hqfhwMdVDtF5B6YBg3ziDk/K2DgVZlZMlES00xSs9J5
 +WkDEAzu7xC74HWhGaYpam5w5i89lPHSZ++jmzL0dmr3yRgqeugG59H8LIz7q6cMxnaf
 KQsyO4gA0diFd/JdTtwC1qfEvcXcw/mwUY8ij5LfZQK2QJd91VhTCqf1Htpa8O0dI7x5
 rP3tai4XzS2dd3tky3dHyyVrJfbrm+h5sRm+CCBpBmv0FKu3e8heamzHyTdTZkt4tVbT
 bFtR4LGITwzBL8Ao+687TSQeB5rmlRyg+mhlaj7d0Nz1WeCfe1iSlAc+QpGkFXm3vePv GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw49re3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Apr 2022 18:08:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23OI0s1l004093;
        Sun, 24 Apr 2022 18:08:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1f0h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Apr 2022 18:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip+SE4F1s59zOyY2jyPVw0Rx78IxPnsaKF80baCnVmDjD4v75FYc7euk04vWHaGtr6Oz4cK4jwkX20IaeNXUmEtLkU0BjLqcq0ey5u5xag7VjrH/OyzOuJ1U62IRJRyp7uFwy9h37V0mMngf8tSIpfuNsbBexswM1dIDpGRz98I/puNjXskoyzJ6iqTfxTFRfWQmJDQFWirb1q00pgG8DoAeflfKNIdiShEUmV8QXPTew9SBxzi5c1daHpZbV1NxUJHiLMcEYSq3pWjD0BXeD5DEerYbVeh9JcW8VNE24OY4k/jZDin7NAShzRZPl9UtYpUP7yiVtRRotz1tLaNSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzMJntI2rKxWeSgLPQUl3FmXqyfq27Cgh/lYk/ng5Y8=;
 b=YuWE2kJ158yKTscZXnsMUgXhu4+4Q7mBUU5d+xDqLoKhk16mleeN2zpv1BCN2efKlC1e/jCiwI5VsObRhKLNCAGecoThkqfz/a+vythFNy0ztpP5fe0rBgNJNbewxY1pcOOZPKEEehbUHxA1bzGA50TDfzCY9P32TwAgOdBpV30lhCvyheaTZGwITdkkOVp+wBHY82GFW5A1c9i2BRk7GJyh6x2yNT/zvtL7LtmqqZkuUdjU3whkcCrvcDo2KRLrXbHVXVGDr+H5BeWunY/jpBsa+Gdkwa76aBn8khQY0gnbTn7W+qc+SIjQgFB/7swg+7JVCZ/3inau94OzlNBUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzMJntI2rKxWeSgLPQUl3FmXqyfq27Cgh/lYk/ng5Y8=;
 b=a3BH/j9npWLCHamQ2HuUmX1qurgfTeeRntsxcyC3OFPY+iRYPW3xbBNhEcjGOiKqeFACMlKqm9/wyAWkSOwcPTMlNn8E+lT5BIUmLnFN0ee4IqIrTbp8xeeX9PwtxQrjK63Eis+sZvk/zPJ2kQW0MCWsVq/ujB/f4vaSK3LMjzY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY4PR10MB1768.namprd10.prod.outlook.com (2603:10b6:910:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 24 Apr
 2022 18:08:38 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 18:08:38 +0000
Message-ID: <e63bfa2c-6edb-f224-1d2a-0c69330492ad@oracle.com>
Date:   Sun, 24 Apr 2022 14:08:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:208:35::33) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab6a1c3-1b05-45c8-c0c3-08da261d74fa
X-MS-TrafficTypeDiagnostic: CY4PR10MB1768:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17684AAE2C0ABC903BC74E818AF99@CY4PR10MB1768.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEE4haSESYbkA/ryPAJq5upUt3b3vzxNitMk2egsH9OOwk/K/1PVJ6LoaDspltr5BV+ChRAkWmihfjQQqKRyOkkg5vFJG3H84dKxj5KbJd/JcHVkBrpamIgXknXgIAfCNyIFizHoG9yBkoG20NLIvN7FC4Vfkv1caM2kKvCb8FL1CkhfD1zCAVRhTTN/pNoy8ImHCh5KIZWpuH4oXKh5+k9mfjurMZo+FqUGQwe6MzECKP4yb8W9xme53B3UXS7VmR/9/Sv3dy2GKCEYz4sMEwxo/q2j0vZ2cmqioR0pOHu2Nw6qx9kinLrFOGVmzLtUfQxI1BZdmEhzIjSet6loDH15eqOI3hqiUIO8pF09m9sIHWkZOtoQ6PgU9Zy0xUQJEtg7UOxTjM++3mYzNfImvSIey2KzWdKvSG0jQgEzz0lo4Uq+4Of9eLYK1um4/et8822C8TdF0yhI6VsUDfIbyYSSPWOsfQfcS7x2QUBesQseuv5bwh3CN88/AnIe6wQhxBsTO/2UoYY4p4YrmpabuFxSeYJgJqWf4PqfmbfueZgCxA/g05r5Z6UsRU1wt4iOFTTGMitLLZomX4Mfs29D3o2JWfMQFoZuxJqakEITR5gsX5rtxkOBP2xXJaOfnDFtYHH5GexEx+SWDAQGVF4cVsVi7gY1yUZuCEz6iBOPAl1tb5FmE/q/QX65A3ASVBCz127yYIsHTm8h5Vn5NsBmf6Tpva0pVFHHdvGCdUZVYKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(508600001)(6486002)(8936002)(316002)(38100700002)(26005)(8676002)(4326008)(86362001)(66946007)(54906003)(66556008)(66476007)(36756003)(110136005)(5660300002)(4744005)(6506007)(83380400001)(6512007)(7416002)(31686004)(53546011)(44832011)(2906002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJINEZNY3h4azViemtZTndhWkJEK3czUldGVXR1MzdMMmhIUnltWGtKdlRW?=
 =?utf-8?B?cmovWDBVSXRFbXZUOHNweFFZeFRtemsxMzlaRnFIQ3BsS09lSGJreDRDM0F2?=
 =?utf-8?B?aFEwYjYvZG8yQkRCL1kreEllcVdRR3VuME5GWDZXQjM2VzZ3UUQvY2t4eFh2?=
 =?utf-8?B?ZWUwaEpxQUJzT2E0QStnTTRLb1FlOFFYTHArMkJROG9RbWkxQmdVSTdVRGZU?=
 =?utf-8?B?VnBkL1NlN3p0SFpWNENXSEQyTXFRek40NnJhR1A2OTFPQVlzYTJCTlM5RDZH?=
 =?utf-8?B?Q2YweXMzbmRWZXFIdjNRUnhvck1yeVMyVHVvNUp3L1NlUHl2SzNqTzV3NDJD?=
 =?utf-8?B?MStHeElhT2g3bUx0dXNjeHpVRGRGY0YxQUpadFVxTlNEdEpOSU1pdzZVdG5M?=
 =?utf-8?B?Tzl6aWxiWW9ja1QrVnlOK2xuei9kQmZ1MHFabmZqY29SOUtKRlA0bTJYODI5?=
 =?utf-8?B?ckNDd1hMOCtkaG82eUVsSWJjaHFvQjFsWE55OWZVVFp4V1cvR1JzaEovWm85?=
 =?utf-8?B?S1pJYjFKM0hITE9rVUlhTVVLakpBUnFYdzdrN1VYaEdXNWV0V0N1M3RWUEx2?=
 =?utf-8?B?cXJJb2F3MXltY1hWZnl2dGhWT1VRaTBFT2diZGlqNTNZUWdBKytaeXl2Y0Yw?=
 =?utf-8?B?cHdiRzNia09tMlFSMGNucnZ3Z3VMUUNHaWUwWWNOTVQ5K0F0UzhEcjFKYzBq?=
 =?utf-8?B?RUEyMGhIbDBveFVoOXZFUUZKWXAzNlpsQzZ6WFRjZFNVaFRqdUxSbCtrWGEy?=
 =?utf-8?B?aGJMWTRwZzNsVjQxTTVmYTROdHZFMDF3bkVEbXNsQWxUb21DT2lxaUdLT2pZ?=
 =?utf-8?B?cUhQQk5vVFJ4R3Nwc2RhVzE1eHNrYlpuRmptdXQ5dkV1VXRQczRlbmp4QTNV?=
 =?utf-8?B?R09jTXpUekFiLzFxWjBHaVRSdVlxTlZHYjVHekNqcm5GSXh1T0pBK000Q0la?=
 =?utf-8?B?WU9UV2VQOFQwTUxuZXcza1M5ODcvVmhycUNxT3NYUks4M3FiaFV4M25qaEdo?=
 =?utf-8?B?TDlacEMrdTdIVmFpanIwNWlBZ1liY2tTcjRXbWtTdEl4Q1krdXZGMWtNVmEr?=
 =?utf-8?B?d1B3TUl0cDJSM0xWRU01VWVmOExPOUlTdWlpNEFXTGg0Vm9yRzBJaXhna2x4?=
 =?utf-8?B?OXhQZVorZE9BTTJNa0FPMm9MR1ZCWnQzVkg0NnhaL3p5M1ZHUGg2RmtkaWJn?=
 =?utf-8?B?SEx3SmxtTGxEM2Z2YjFyQkFzbk93Z01YQjJhNiszNjRhTTBWRTg3cnQxeUpk?=
 =?utf-8?B?WVBWUUhhQXRINUloRzNuMHFzc2R2SVNZaHpMaGJzc2J6VTlQTHVPTCt3ZHo2?=
 =?utf-8?B?L3QyUThZK01qUUhHdllqdU1Rcy9nS2RtREZ6RmtrYitHU0JvcTJJK2RUYWd6?=
 =?utf-8?B?UVZ2YkVhd3VlL1F4VVcyNytkanZhUC90eFdYNGhlOUxDWjNqbEdOaHk5ZTkr?=
 =?utf-8?B?eVlXSHBGTUg4amlZeGl2U0ZDQzFtRmZySW1KdGxVQU51Z0lySUkwcTBHMlVw?=
 =?utf-8?B?cDF2eWRCYzUwL2xOV2hMbGp3SW9ZSmhVTHkyRS9zUWRHSHlaTmRqNEh6L0tV?=
 =?utf-8?B?dGVhUnl1dVRmOHVDVjh6RlpqWkhzQnVxVDd5K2lkc3dpYkpHMDNmblJRd3Fn?=
 =?utf-8?B?RFpqMkFJYkd4RmhnVVMrZy9YVjRQV2ZNWEdObXFleHpFdU1NK1BHL2ovU0Qz?=
 =?utf-8?B?MzZ6c1h5RW15N0hwdDQyS0Y2Zm11TE9JOWJ0NzlLaksvL0p3clBscW94L2R2?=
 =?utf-8?B?TVV2d0hnajBHM1Q3NXg0Q0Z6OW9WamV6WnJhcDkvbEI4ckpIRUJuRU9ZVUtz?=
 =?utf-8?B?UjdEMDM4cVBKWCtNU0M5MjYwRGt0YXFCTWJNaTFTVFZJN3BNS1F2emJQcnZ0?=
 =?utf-8?B?RkhBd0Y3bEpQeElaK3hjU2swTXdhbVJNRzVPMlMzQUwvbWdWemZYQXJwS1gr?=
 =?utf-8?B?WVZDT3AyQ3VXeUxSUGo0WVpabGp4T1M0OWhOdUl5QmFiT29RZFI0Q3BEdDNo?=
 =?utf-8?B?THh1QWVoQVNjZCtqLzBlNCtER3Y0SzJtWHJqYmxLQXJqd0VkVVNEdUdzTEEw?=
 =?utf-8?B?UmgvUGxiZGpORmJjdUtudEtpaHl5bnRHazBkSEg4SFM3QWw2NURVb2ZnU0NY?=
 =?utf-8?B?RFVnQVJPRXVmKzhSYnd5ZzhXclRBS0NpczNFcHFXZStIeDhNTUhGYzNEMzJC?=
 =?utf-8?B?dzlJTS81OWMrL3ZjRGRlWC80VXVwVzZNbUlIUVFLL3NBMUQ3MG5PaGg3QnR4?=
 =?utf-8?B?TEIvTHhlYTBhWFMyeElxL1U0Qi96MFYySUlsdW8wOVZCS1BidnIvQ1pkM2VH?=
 =?utf-8?B?NXpsVHB5REszWFNLL0JpL0VzMHZMWFRXd0lFWmZrRXhNQ01kWXB0UXExbFNx?=
 =?utf-8?Q?uYfV9/g2wVuBECJo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab6a1c3-1b05-45c8-c0c3-08da261d74fa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 18:08:38.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQM0d4rfbeLvo+8nGoHahiT/aNqz792h7o+60Nzer0gY1Zy1hLHf3ubys8axZ++Yr27f0sPWHnOsrVPeMz6+ORZ7aw15bFaaZtXdvXpfjcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1768
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-23_01:2022-04-22,2022-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204240091
X-Proofpoint-GUID: Jnd0UO71IogSBYldUQVPbxjV4hl736C5
X-Proofpoint-ORIG-GUID: Jnd0UO71IogSBYldUQVPbxjV4hl736C5
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/22 12:53 PM, Oleksandr wrote:
>
> On 23.04.22 19:40, Christoph Hellwig wrote:
>
>
>
>
>>
>>> +
>>> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>> +int arch_has_restricted_virtio_memory_access(void)
>>> +{
>>> +    return (xen_has_restricted_virtio_memory_access() ||
>>> +            cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
>>> +}
>> So instead of hardcoding Xen here, this seems like a candidate for
>> another cc_platform_has flag.
>
>
> I have a limited knowledge of x86 and Xen on x86.
>
> Would the Xen specific bits fit into Confidential Computing Platform checks? I will let Juergen/Boris comment on this.
>

This is unrelated to confidential so I don't think we can add another CC_ flag.


Would arch/x86/kernel/cpu/hypervisor.c be a better home for this?


-boris

