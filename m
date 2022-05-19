Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2752DC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiESSO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243753AbiESSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:14:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9DEBA97
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:14:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JHgjol005301;
        Thu, 19 May 2022 18:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fGIpbRBJIxo8ejq2LT0jFpWRo4EgkUMnXXEBdyXBC0w=;
 b=DBxhPQjh2yN66lc5zbd4XLetWhicZsDtrz4TygOElTKp/jAd5fe7RHD4M/xbu0doqNqz
 bbWyeP5fargnxypeYVynQv5rN4czgE7BGWK1VNJ4uysY8+m69Io5KihHF3chl6N02YHs
 x0YA6oAWs1GK4c14JHyoKyDRWPwNAzx1ylnVYBpem/ofCHi0TXcmZF1F6W6WTlcpTZVo
 tac08se8neCKtWVhazkpe3QWx5ZzJj/Kr5It5w4JaIKs7AVUzEdjze9RiHlh/dvyh0F6
 UuwGNkS8XyEUqAnJF4HH0BTTWK+NYmP03cpwqRG52pT35assdPYOvDNGPukgnUiZ5Mzq 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23725a2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 18:14:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JIBsNj004557;
        Thu, 19 May 2022 18:14:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5pxu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 18:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaIOFVTgKaXLfsDkJ/i+6XppZbFwhR9PF4rvq2uf/nCBgrWJZ23h/griV+vHE6LkTIJ2yKWwIBNkzH5SrDsXhhv+vKQQR/5ynV//GwUeMgNRtveY7RcWrikSmxz6tkkYHWYf4KyJg0Kie8XNJUoFEj6h+MDv1nfnoy5mss+jXG+46KLHw7DLtOX6T9xuKztZr+0wnmBnlzGDQ6MdhNJs1c4k7Yg5RxccQW+N99kl2xhllB7ZNo5JPcLySOgrY4gwsFBUGe/vUB/cgs+MiRT+HL2Br0UhKjfmJHFrM+wmTu6fAozxH1Fgvcj53Y8TtFGhFJFNHerjrFGdq2CA3iTlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGIpbRBJIxo8ejq2LT0jFpWRo4EgkUMnXXEBdyXBC0w=;
 b=eFqLwzFtVuro3Z1kiz3kTdBtp+g2ygGErM2JNGy3UWogb+4g7MUcH6Nr6jnI8U3RcBS9fa+xuOw8t/e+oPTgCEoKzNozJcJoDMoGln/rNd/OePzhTQABZ16ApUlBMZEs67izGLbX1B/dF8/XM2WiKvOSz/EILNiRsRkfS9Ntux70I0GKG9ysfG1ClhFcApUGF9285IMZYNn19HAHfClBcZc7y4gZr95ErvNP80vVfd/FFon+9zpLZ2Ct9lDA1BV4ph4ofQaXO9AtqpxkKMyGRjqqHfy9Su2/jiMdJH7YWVT+KGGLRoCMffvOf60mRXUYo/C21f6GI3UWy3BU5rZCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGIpbRBJIxo8ejq2LT0jFpWRo4EgkUMnXXEBdyXBC0w=;
 b=qWV8MWUGIqsiwEvD1mGomtELacARlrczq0t4Wg8+HF2m/FiApi/jRDUCEqFg6IugvHl+lLyZKNr0+s8r7amI5eynJyKH6xljJgahtswRwI3/hauE+f0oJmXqS7WtFcBlwKt14PbM+gnoQdmwY0d1ynHKwrKnrzxLrFzN5g6Itzk=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 18:14:13 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::6498:eaec:44e:5caa]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::6498:eaec:44e:5caa%3]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 18:14:13 +0000
Subject: Re: [PATCH v2 0/7] Add latency_nice priority
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        joshdon@google.com, len.brown@intel.com
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
 <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <9c0f9158-2d0c-dba9-1505-79ba4e642684@oracle.com>
Date:   Thu, 19 May 2022 14:14:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd9a35ad-85ed-4350-8216-08da39c36056
X-MS-TrafficTypeDiagnostic: CO1PR10MB4644:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46440595BEA79A8CDAEC64EC9BD09@CO1PR10MB4644.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zazVaqeueQ9hGv066fh28+1am3S2buW16HT8jSJ2PgWtYrZH+VEGo4kwZP16iWMjF1gjD5bE0bkgWx0V9HYU670WoAzNACWqJ5b/zRD5VQxYEvxXUopJLoULdx/Q5Fk+gRo4NHGAVTk8YA3ZZj9AGE1XVphje+OesI7tGl6rKjdx9+GjqvE/VSRMqUL36qY6unkolNPO0fE973lbRtqeMFfKntDxPStemc3HBVkKJXb9R+bdYVpkUn8y23XjbPYEC767XVj9/+Y5tHRGICFS0o3nsV+Y76jI5tvaQRdNN8sdKhfg2VeCITyOwBTHjKwkJQKkQ573nTHNPSPF2TrXP7gFxyIuh7oUeQKPqmPxR3DJNZv1BjDNu+2ZzMTb3JDOMSA+jDC6bXEVvhJ8KquqWKLDDkeEPsBLQjoDI+XpmSZ9fA45nFbpiVeaje1G2D79QA+QKN0CBQw3L7Se0E1zvG1EpxjGdwo0BYDc0IhHgAQXY1YkImMyN/dW1Fx+eMy6WG0voo4tRtLTEvBlrjCFt7sudNHVI1Svz+EXAVocdcIFhlRyRdJCAtmKmFebjn6R5ftjo6TH31ou+1nrwAbhRoz8JWI0qMTgOy24nevIwpKXxI2vgdPhnTJs+D3bxo0awpc/4R+peSSGxTpTy6r1N2md8wMINPzjpjYLn8/lpYTdlsWV5UYMBHYpqxGmyA7WEUby/4LIwxi3eBuDRUjEt6ViCl4Am8atrEcEJlyhMWsTvHB7wNR5fW35IFMw/hJirdtuCP6600LPJsASawH8MKG3dvnegz2mz007zow4CfHBR1WcaqRxwgCQcZ0APmCC2OxaBeBk0G7q8hP7RVh0001QFh1NN4c9Fq3LqvGNQn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(26005)(186003)(38100700002)(2906002)(83380400001)(8936002)(44832011)(86362001)(5660300002)(2616005)(31686004)(52116002)(53546011)(31696002)(6506007)(6512007)(36756003)(6666004)(6486002)(508600001)(66476007)(316002)(8676002)(966005)(38350700002)(4326008)(110136005)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJCOG1JdmQrU2VMbUUwN28weXZ0clJUOVA1SDdDemNwQ2JmZ1YrNE8yTWxq?=
 =?utf-8?B?OGM5NXdLL1ludWdIK1crZzBEOEtwSnE0ck1CczhnOWJ5QWM2Q29LT1VNbXRE?=
 =?utf-8?B?TU5BWmdvbklrYUs4cVgxQ0Nuc3h5T0xIbitaenlacnQyQ2JzRHJ5L2xObWZw?=
 =?utf-8?B?R054clYxbGp4bWRaVkN1L3VVdlIzaVYveU9DWmtwZDBYQTdTcHc4NllkNmlZ?=
 =?utf-8?B?Q2wwTWNsTjRVSUQ5Vnl4T3F2bkdkbHBnM1FaRWlDWGR6MFBtK0pqL2RRNHJp?=
 =?utf-8?B?SlI0K0VqY25BVVZiOENlVTN5NnVUejVKNkFKTFJha2R6NlBkYjlvb2lKOVNl?=
 =?utf-8?B?bHg3MmJKS3ZHL05PS1pzV29qQnY1OE4wTUhRVTZFUkJoRWNHanZGdWtuNlIw?=
 =?utf-8?B?dlhJaEVRNXZWdlQ1OW02bmFqWWR1dWFLS3A5c05oNS9RWGUwblFicHZQSlVv?=
 =?utf-8?B?VEhDZHkzRktWTkFnOTFlOE80QjNMYWlTQTZvdkVJVDlBRHpVZVRaN3loV296?=
 =?utf-8?B?eDc3aTVDajYwY1FqQ25VS3NqNFRWUWs4amJNVkFyTFNSakZUR2VXRDNnQkhn?=
 =?utf-8?B?eFFWUkQ0UDlpTW1IOG1iU3VINzJaNzljUVp3RTFTQjgyeDV6dm9yOXlaTFFX?=
 =?utf-8?B?TklSd2V5TkFYd1FIclU1b0Y0aU4wL1BnSTlLcTRYUWxUN21MY2pSSkRqb1Nu?=
 =?utf-8?B?Ymg3UldtSm9IMyswYXpaZnBDRW14aGIrZXpYOGl5THJndkdDN3ozSkVDcHJm?=
 =?utf-8?B?NU10VDZjWXd6SDZaVlI1Q2g2bnpObEtGZ0VRRjNkQmRyeUVCUHFiMDhFZnpK?=
 =?utf-8?B?azJnMFBpcXlmVkM3YVhkN0UwOWdiTExiQXd3dEtCWmk0ZGo4UHo4T3pZbkxa?=
 =?utf-8?B?RFJEK20yN0h0aTloUnc5OElMdUZ3SDZ3SGIrYjRzbXU5aEd2bEpYN0trYStO?=
 =?utf-8?B?VWQrbWxtSEQxb0M2Rm5CQit4V1lZSkErU2RsM3R5NWRLSlBGS29Sam5oQmxj?=
 =?utf-8?B?aWkvNFBKaWlJaEptOWNzcFlFb1F5SnBSd29TU2c3NE1SakR4NXRiVS80eVBO?=
 =?utf-8?B?dXRET0lkYWFCZU1jeURKQjZRNFE1VnAzTXpOL29YbWNod3B1ZU1WWUNEWUF4?=
 =?utf-8?B?VXovYmlqZ0xGdW5kTno5emp1UGhBTkNuSE1BR20yeUZUbkNrMnRKc2hDTXBW?=
 =?utf-8?B?NEpwdDl4VFMrMmNuRUhXb3ZqQUpldnhLN0VNeEpVYmM2UTBuSnllRlZjNGdH?=
 =?utf-8?B?SWJCd3lZTzhlcEJ5WHBXdDE3SXBqS1dOUHlFOHErNU5UUXpoS2Y1cmFBTFlp?=
 =?utf-8?B?Y2dWWnliT0thdjMyL0ovMVR4WDVESHAyQjVVNE5qNHgyTktmVXFuUDEvbnNv?=
 =?utf-8?B?ZklRdkNEMG03bmNzSGNhbkNmcE8rTy9QblJLZGJDMW1LRlN6K2JTSS9XQ0Yv?=
 =?utf-8?B?VkJFbzJXRG81ekYzTHJZdUpNdG1tVE5xTFl2WEJiV05VZkp6Z3d6RkpNRzNm?=
 =?utf-8?B?eGY0SS9HanBHQ2dVL1ZIeFI5OGVDblVhdVAzaThKcDRFbUkyUUNYQTZiWEhj?=
 =?utf-8?B?OHNKVm9nRi8vaUdUVlBhVThLNnp6UUUxRlZTdVVnZ3NheXQ3RzIwTzNCVmtx?=
 =?utf-8?B?dDFMc3VCWmQwcnFVOHFReE4yclJGUEJxT3lxTGY3bTVOZUNlY0NISVY5MGlB?=
 =?utf-8?B?YTNTc1ZuT3NVcW11eW90OXFzd1RKclBHNTN4Mm44aTBrbXoreUlqR1F0cUox?=
 =?utf-8?B?NEd6a0xDWm5ON1pXWkF2ZzR5RDdUdkdmVHlYelZhc3JyTXFiTlc0TEZWbkg3?=
 =?utf-8?B?dVQyUWRWNUhnWEdXTkxac3lVTEdxR1VUTFBQTkk5dlhJZnRWZVNGSUllelZa?=
 =?utf-8?B?M3crREhLVFM2cm5sTmcybisrWkIxK3NYbk5nMGFvMEdJeEZEYjI4SlRCOWtW?=
 =?utf-8?B?anU3MnIyd2xac1hraytHZG5UM1l4cWxMUGg5dThJaVBDLzB4a2xEZDVLMlpZ?=
 =?utf-8?B?YkE3UVkwSk50SUwzelhkbGR3aXJZdVhrcnZ4RHYxTGRBR2ZMcTh0cjdGMnVP?=
 =?utf-8?B?cGs4Qnc5bmpkVHNVOGptdExzQXF4T29hbVA4akV0OTRaSnpKdExRUkpmbk1T?=
 =?utf-8?B?NFBCNmFyWmh4N2hUc1UvTW5HbS9SRS9aM2owcDJ3b1hnQldlcS9CaUhzclpG?=
 =?utf-8?B?anhsSy8vY2o3R2lwQ0N5VWIxaGVlb2x2VzZQMXNzSTFSZ1cxTG5STlVsTkxM?=
 =?utf-8?B?WUYvamxHNkVINlFoLzl3TGxpam5ydmEwS09IMnBDbGEweTlFWXJTdWJhMXFx?=
 =?utf-8?B?dmh4UW8rUTZxM3E0Q2FwVTV5VVQ5dXVNc1lKOUVwS21BbjdQN0RsV2grSlV3?=
 =?utf-8?Q?sXCmXWDjfa1laBto=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9a35ad-85ed-4350-8216-08da39c36056
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:14:13.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8cApgTeX5hevgKdslxnvAXu5fQuUqMIvu3ItFmwwHIEi1ZMq8qj8zF1xt2NM+WeqzQqpl/u8Tz4SALNoSt9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_05:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190104
X-Proofpoint-GUID: JNl_Bu2jo20sQ6gma7kfT2XCypdop_R6
X-Proofpoint-ORIG-GUID: JNl_Bu2jo20sQ6gma7kfT2XCypdop_R6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 10:16 AM, Vincent Guittot wrote:
> On Fri, 13 May 2022 at 23:44, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>>
>> On Thu, 2022-05-12 at 18:35 +0200, Vincent Guittot wrote:
>>> This patchset restarts the work about adding a latency nice priority to
>>> describe the latency tolerance of cfs tasks.
>>>
>>> The patches [1-4] have been done by Parth:
>>> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
>>>
>>> I have just rebased and moved the set of latency priority outside the
>>> priority update. I have removed the reviewed tag because the patches
>>> are 2 years old.
>>>
>>
>> Vincent,
>>
>> Thanks for introducing the feature again, which is much needed.  I am trying
>> to look at the problem again from usage point of view. And wonder if
>> there are ways to make the latency_nice knob easier to use.
>>
>> The latency nice value here is relative.  A latency sensitive task
>> may not tell if setting the latency_nice to -5, or to -10 is good enough.
>> It depends on what other tasks are setting their latency_nice value to.
>> What a task does know is what it it doing and its characteristics.
>> For instance for client tasks, we may have categories such as
>>
>> Task Category                                   latency_nice_range
>> -------------                                   ------------------
>> urgent                                          -19 to -16
>> media playback                                  -15 to -11
>> interactive (e.g.pressing key)                  -10 to -6
>> normal                                          -5  to  9
>> background                                       10  to 15
>> opportunistic soaker task (sched_idle class)     16 to  20
>>
>> And we could allow a task to set attribute of which task category applies
>> to it and the OS can set a default latency nice value in its task category.
>> So a task can just declare itself what kind of task it is, and not worry about
>> actually setting a latency nice value which it may not know
>> what is appopriate.
>> If needed, a task could still adjust its latency nice value within the range to
>> differentiate itself in a task category. And we will prevent
>> a task from seeting inappropriate latency nice value out of the right range.
> 
> The description above make sense but I'm not sure this should be put
> as part of the interface but more in the documentation to describe how
> system can make use of nice_latency
>>
>> Knowing a task characteristics will also be helpful with other
>> scheduling decisions, like placing a task on a more high performing
>> core in hetero systems.
> 
> Ok so you would like a more general interface than an latency
> interface but a way to set some attributes to a task so we can make
> smarter decision

The original definition of latency nice was as a task attribute describing the latency sensitivity of the task. The fact 
that it was mapped to 'nice' values created too much granularity and made it look more like a tuning knob than a 
statement about the characteristics of the task as intended.

> 
>>
>> I think the missing piece here is a way for a task to declare
>> what kind of task it is.  I think that will make things easier.

A classification of tasks into categories would be useful, but perhaps one level up in a user space tool or a user's 
head (ie docs). For any of the categories you describe, there may be a number of per-task attributes beyond latency 
sensitivity needed to capture the task characteristics you mention and ideally would be set in specific ways. Say 'nice' 
values, oom kill, etc. And others may make sense in the future, like say NUMA sensitivity, etc.

Basically, a category can map to a bunch of desired default values for various scheduler visible task attributes.

Now you could also take the idea in the other direction where you set a "category value" for a task and have the kernel 
pick the other attribute defaults like 'nice' that would typically apply to tasks in the category, but I think letting 
user space figure stuff out and then set low level kernel task attributes primitives is cleaner.

-chrish
