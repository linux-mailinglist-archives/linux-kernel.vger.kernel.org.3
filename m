Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8E528D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbiEPS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbiEPS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:58:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A9C3EBAE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:58:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GHVvd6017443;
        Mon, 16 May 2022 18:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4olkkxipV5iBgWH0NsT2vT3vMCEIkKfDcstu9Ms0s38=;
 b=tM4iSyOmfXcX6pUQVZg3+aau3IV8Wvfp0UYUpqq4HV1oqM09BHbyB4IbSstXW64X5BKj
 Gc06OQHkFHssAVEWnAMNaSfwgzBS04yZPyYrC3eJl5cg3ydoC99ubslXWD8yUUefHwHT
 VTz4km6PtTyd9m+Yy6O4sabG+a43Hy2rsAo4pyzqQ/oU281OAI01UnJ0xqMhBzODrkxO
 mBy9t/IeUIn8aKUd+7oj2kUtZlDTEMTFVYHPUR6dCJ8EkWal4kD1Ui8wKom4tuqSAkPu
 lZIG+EqeHXszkszqf8BcogzOHRjftLPDKMETUXLzVYk6xvXdsB279nF4UlbzI5zPDlti Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aac69w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 18:58:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GIpugt005200;
        Mon, 16 May 2022 18:58:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7rh83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 18:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9HGbFi1yJdlYpDw0w/tX3MCuN9Co/v2HQ5KeK11Gk5h1nEJK4qfrvgXWhZTO0CtRYN8QPnRmG5vKLLF9N/O0MAbe0FEWfPwLy1NyhD49euKPUNuSM9mS6dgpfhCz01xksSMg+gtpBEWIIuJtWyYBTRmn5jliszJvbu7n3EwpvTS9PRdvX0Bj6wF5l4xoZG92Ewch7pJXkd5/8e8lKBC55z7EOEAEzySdR4LadgMhrroSxZBpEtwLTdv74/PPSdCa4sFUtPTSFvKEFXS+y/l7lYB7LqnVSjucH3BG7KaOcwwPzfnqt+nlA8hoQCaRhxqWaiHkvVMOhLCro7HNU8aWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4olkkxipV5iBgWH0NsT2vT3vMCEIkKfDcstu9Ms0s38=;
 b=Qx/qfb5FvD5QZ5rENDsfGmylPwMIo4Se54qSHXZS9ZJrJtBc7HkkpoRN0muMwxMKiTw++hOZnlsgKOOV6lY+XOves7ID0wNUtCkh8tL87oZL8sg1vADLkST6yXpET4ZERLACFPUNhPsP71rVfV8v+cIHlGfR2OwZ5vDhacJrpGwpUAGB1eE/eyiyK8p0htjgkrgK7SzrTnlGBJbg7j6sqcRZku/jZHPipzCpwi4orLs1O+C8dEualHMu2b2whmPytP6nnGqmX5LSdwi/WKGI21KO05GL15oQ5y1Ak5bO1qZJL6TWQM93a71zq4Dx82mzDB9/j/aZygh+dY3ROPhofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4olkkxipV5iBgWH0NsT2vT3vMCEIkKfDcstu9Ms0s38=;
 b=y7qgOSgBL2SayOkSSlptZQfkNhqVExcPzNDvuxcXoDkjiYzHOh/2G/w6moVfnI0BayUSOje8tQiO9YHB69EFdgIq82+fugMO6KDBeus67JImtaAIwkEjXo3XLrLPyjwuYX7S4MtrtY5EXUPFp1HC4eTA/yIX8OTb52qSaJBf86A=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY5PR10MB6168.namprd10.prod.outlook.com (2603:10b6:930:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 18:58:00 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:58:00 +0000
Message-ID: <a453916f-40f0-7a25-2d16-fe8df425d83f@oracle.com>
Date:   Mon, 16 May 2022 14:57:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
 <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
 <e04fd32d-b379-d515-2080-781e555303f1@suse.com>
 <80286144-cca4-ef07-3aca-2c2374881738@oracle.com>
 <b2d22549-cdde-1e52-18fd-0ff923b86a5d@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <b2d22549-cdde-1e52-18fd-0ff923b86a5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52f6e2c9-3ca4-423d-ce56-08da376dff90
X-MS-TrafficTypeDiagnostic: CY5PR10MB6168:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB6168B90AF082529D6E55BD398ACF9@CY5PR10MB6168.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKQVf2RN/HilF7pYNTYsfG7F+Yrh64+NHbBZ2sBPhbbPwRSR5fLU7tmgtTT6DFGLViKCxGGhFAH57r2NwQU3kzwhYPUvUz4JG6JEiZHJ53sYO9n/J80K2s9VSVL54cI0ptOs8cBNnJtzE9M6EyxvYUYemLlIy4qQCryIqW0q1NXQS0doqV7BVatyPM/ulCJAyOT2+qRTTy1Ve0rXiq2bgYWXsm0ZEzaI4q41Y+HLFLpdfebXMk0WOeQOyAPi7EU3tgPiazYbEAx1E+MSriS9vz5IGPxrrtmHBGPmjiUukylbk5RuarXqqEa2EQy5AtM01/jdwWGUzvToygrdkc9synEBIGwf5OzjHKyJrETsOiVzJFFWEY8xGu7F7jkUy133VtN/jYDs9nkCEn17+J3IQqg/qKOeYwlUfA2VHUA/iS5ykEtQsfCzijypo0BcwyFpqqQ4WGtqYl26guSZSgqHBGOFcFi6S4ZZqqzYyd68R2IwMzSofLgPJXlIKWozcHNDymSXiX683VuB3rC/dKOfqXE0/LK2Wkz40eRZ+PT2BNK2iah77/6Bp1ShNmH7swI2m3qEr8le74HFg9p8KCS1IOL4ZqKmv1IntPSVzp0RWhLx6VE2n1EaAMUNno3U/4NE3hBGt5CcRHfsEi5TRLu+Cn+kjQ1NX1VO1NEYjaMx4gAT3TRWM/CJhTfEj6YsD5RuPv5hYyVrL/YGIS5T81uJa1cNvpebI5w812xT3Suvt6ZYwc1G+DppkiiJ/FqvQ7yaF7OcL4CEmu6eOYNIDrhot6a7sis0zk43qPJRhtBaVZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(53546011)(8676002)(66556008)(6506007)(66476007)(8936002)(508600001)(44832011)(2616005)(5660300002)(83380400001)(6666004)(2906002)(316002)(6486002)(36756003)(6512007)(26005)(54906003)(31696002)(6916009)(7416002)(66946007)(31686004)(4326008)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNCTmJMYm1kN3UvNVVwWk1wQ0JSVm1PNDVNazJWY3V0Z0xMeVE0VFdsbk9p?=
 =?utf-8?B?QmxWM0c1QUlMV0FUSU5CaGNNQUhhblZTSjBiWmYyWVZKbW00WURqTTBPYVBN?=
 =?utf-8?B?STZjQnU3TEJMMFl4VVpxVlgwZCtyTjlHSjlDcWo5cEJ2Q3BKTk04eU9hUTRi?=
 =?utf-8?B?dnpoNDVReTZQS1MzMVMydXJxaXRVTXdXVW9uLzZ3QS81cWZmcHVac28zZDRB?=
 =?utf-8?B?MGw3VUowK0dzVVJ5UncycnZhbmlzWng2ekRBeklpN3psVDlXRjZRVkJFYkYv?=
 =?utf-8?B?QmtMQnNOSHhkazV3K3dnVHJBSWd1Zk04b2wwZkJBdVpJc1ZhdElQYlRUUXFi?=
 =?utf-8?B?YzRsamp2cWJsM0wrT1Q2czdVR0ExN0NvUHZqK3RjUFdsbXJTZTYzOWRveUsv?=
 =?utf-8?B?YSs0OVVoSUZmSWJZVUNsdGFEOUVBVFFWSGdyUmdieFRuR2tSN0VPdDhoQytY?=
 =?utf-8?B?WTMwcTNpMzAzQjdTNEd3cWNBWTBjZTZia09OS2EyaG5BUktmb0JYbitFWlpp?=
 =?utf-8?B?SzdObm84Y3AwdWQ1eThrTjZsUjRuaUxWc2g4YktnTGUwaCtxQkhzWmtwSllt?=
 =?utf-8?B?UDlLS0RiRTRTWE5LaDNQdFJQK3gxY3VFRHd6VU9uRExaZU5iZ0FscXJRSDV3?=
 =?utf-8?B?WUtERzZCZHVTTWpyUUdDNXBGK05tbzZGTkpPRVh6WTZFOExoWXhMSkxkdDIr?=
 =?utf-8?B?YWZmelVQYmQ4REVta0t2YlVYSksyb2ZqRk0xT05wcGd4TGs3T08xekJyY3Va?=
 =?utf-8?B?SkVabDV3TWcwNUhVREVtN3MrMXhwVWsremJTWEtpRzhkeSt1dDM2RTBCMmdO?=
 =?utf-8?B?ZnF2c3RPYmpkZ05MNXVUajFYdXhOblRQQVNKSVFNMHh6S1RBNTlDMGJLTVlt?=
 =?utf-8?B?NmZZOEdxQjBEN0duSVgzQ0k3dlA4eldzaFZGZUpBaEo3Wm1Vd09VMURiYW82?=
 =?utf-8?B?NHN1SGxSTTl6UHZmM1VySnYyOEd0dGhLTUEvQ0JPM1EwblMrUWMxVmRDU0NK?=
 =?utf-8?B?N0gxTlZISlVMZ0dHdEtCWWNjWWdwbzRXTEswbUZ1UmR3dnBUK2FNZFRHNjJk?=
 =?utf-8?B?SnhxdjVnWUNUVVhxSTNXMldjWEVoVlMwVExIKzhXMDRGNHpueDMwd2J4Nnhn?=
 =?utf-8?B?MUlmNXFBUUZUT3pvSzl5bWUvZ1VjT2x1VWZLUkczb0phYlBKbmZ4VlhBRmZE?=
 =?utf-8?B?dmhjUkhvZmhEMnVzUlluZzVrTU1STFJpd0J5WHAzdHA3Zm05cVR4SDJ1MEJ6?=
 =?utf-8?B?QitTNDFNaTE0YkFKb2p4ZWRnMFVWUXVsdXVSV1ROU3JKTXNTS3NrK0JjYTBQ?=
 =?utf-8?B?UGN0a0Exb2RrSHlRc21WSUtCTDlNN0o0bERvanNrN2M2aHVyU2J0aHNDWWlq?=
 =?utf-8?B?NndZSGFEdTdvU2dVUjcvZE4vdWFLVWlDVVdXaU9OL0x0Znc5cGVRRVVDdXFt?=
 =?utf-8?B?S1JONDdxK0g5OERsYWxjdWIwbVZkZEkzUEYwM0ZKSDVPc2RZQTQzejVhU3VD?=
 =?utf-8?B?UnFqL0dBbXNXVm9sUGFDeVlRUTNOUy8xTWkremEzVHRwTFV4dmZGUnJONzVv?=
 =?utf-8?B?YmVJWjdudmsxblBNYUplQmVnN2p5NllVYXVPVHAwc00rY0lsTDlTV09uTHBJ?=
 =?utf-8?B?OGhnMkpqMW5XTVF3RGZ2b1crdTkyRTZEOUxQejA1am1BS3MwblBhcWczRnVO?=
 =?utf-8?B?NkpWTEF1Q0RjMExQZndJNVJwR2Y5QzZ6eDFadm1neWlTeWprR0l5Yzk4MEFE?=
 =?utf-8?B?UXBNREhNVnZMV1Q5Nkd6aXZJZmVFQWE1QVNuWW1lM1NkdlBvd3l1S2VZOXhy?=
 =?utf-8?B?M2crVHpGa2RzZHRMOTg5NGJYZmNvUmdYSWR3Zm95T2JETG5GRjRoNDk2TEdq?=
 =?utf-8?B?MUpHa3lxL3V0UzZqdzlYbVRkY1NkZG5aZy80ZCtpYTdkUWw0b0pUSlk2c2tL?=
 =?utf-8?B?d3VOOCtBbDlvelAzdkhKRHF3bEYrNGNNbkppRGFOK2ZTelBlbnZVVlQrOStN?=
 =?utf-8?B?ZytjdS9mdWpHSXRxWHJSQXptNmRjUlBCc05yeGxzWXk2bmtCZ2JyNzlKV2Nk?=
 =?utf-8?B?QTBHL2F4TFVQUDNGajRtOXRVQTdmVk9SNU51cTVIZWFUUUhDZ3NvNDZMdXJw?=
 =?utf-8?B?NkdtN1BtN3IzakM4cVJlSGlOeXJtdU5pbkdUZG53MUZ6bzVzYmJoTllVN3M1?=
 =?utf-8?B?NWkvQk00TE91QzVPTTlEMWZ3azdFT05YZkVBNEdaZVAzTElBajFMYUVCU1Ex?=
 =?utf-8?B?eUU5NkhndG1JUWJEaHRpRDUxamhjN2pFOUtGcGY4eG1ucjVHd1lOdXhMaEwv?=
 =?utf-8?B?S2ZHOFI1Y3FEbnkwVGlEeUZLZnM1dTFCb05XbjY0U0pOLytlQzI0Zjd4QVE1?=
 =?utf-8?Q?rshZmBN0oLqZD1fU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f6e2c9-3ca4-423d-ce56-08da376dff90
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:58:00.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dw+h4EABxt/ZbbQEwR8jBqR9RNbnvQHWSXvqwT/y/UvJkIqTQBLhRgil9QQkZ3vb6YMITTA4Uy9PW0nKpAXt63OrV+LhTsBxfMYEiKunJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_15:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160103
X-Proofpoint-ORIG-GUID: Kl333BW_d_mlEtLHU0944bhEAHihCsug
X-Proofpoint-GUID: Kl333BW_d_mlEtLHU0944bhEAHihCsug
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/22 2:30 PM, Oleksandr wrote:
>
> On 16.05.22 19:00, Boris Ostrovsky wrote:
>
>
>>
>>
>> With the error handling in gnttab_init() fixed
>
> yes, this is a diff that I am going to apply for the next version:
>
>
> [snip]
>
> @@ -1596,19 +1601,20 @@ static int gnttab_expand(unsigned int req_entries)
>  int gnttab_init(void)
>  {
>         int i;
> -       unsigned long max_nr_grant_frames;
> +       unsigned long max_nr_grant_frames, max_nr_grefs;
>         unsigned int max_nr_glist_frames, nr_glist_frames;
>         int ret;
>
>         gnttab_request_version();
>         max_nr_grant_frames = gnttab_max_grant_frames();
> +       max_nr_grefs = max_nr_grant_frames *
> + gnttab_interface->grefs_per_grant_frame;
>         nr_grant_frames = 1;
>
>         /* Determine the maximum number of frames required for the
>          * grant reference free list on the current hypervisor.
>          */
> -       max_nr_glist_frames = (max_nr_grant_frames *
> - gnttab_interface->grefs_per_grant_frame / RPP);
> +       max_nr_glist_frames = max_nr_grefs / RPP;
>
>         gnttab_list = kmalloc_array(max_nr_glist_frames,
>                                     sizeof(grant_ref_t *),
> @@ -1625,8 +1631,7 @@ int gnttab_init(void)
>                 }
>         }
>
> -       i = gnttab_interface->grefs_per_grant_frame * max_nr_grant_frames;
> -       gnttab_free_bitmap = bitmap_zalloc(i, GFP_KERNEL);
> +       gnttab_free_bitmap = bitmap_zalloc(max_nr_grefs, GFP_KERNEL);
>         if (!gnttab_free_bitmap) {
>                 ret = -ENOMEM;
>                 goto ini_nomem;
>


Looks good, thanks.


-boris

