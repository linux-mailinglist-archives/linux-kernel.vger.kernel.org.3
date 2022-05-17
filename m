Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00152984F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiEQDh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiEQDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:37:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46594131E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:37:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H3D6oP019520;
        Tue, 17 May 2022 03:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YtY8pTU56ajafEXOk2oRJOjSoIlAdnznVQop3x9vSIU=;
 b=uWqh5Pm2xB+2Bvse1hUuuGqwAI5+9kV8E59sRuJOAyhP3US1fEQyWnVJuwQSxxoqWz86
 zcgv5a7szQZou9nuYp8uMvlt34qKRjmrLnsDaysjP6eHVeGwnpFNWwUioGTiDj5N9jYp
 c951ji5QytEsFVFqD+UggUmEl68LOibFiE2hL8z2dD/tnVoWD4qG9g49dQQa9RkGetZZ
 0QVkvO6q9+BRSc+IQZYwNXTJi35iw0eDpjDexfoF2izu2FfcjSuYEbl/BdVM5GkgaufP
 VwVdfCU30SXRmTGhdOsqhC3oQW1ZTvZkbxL7HtWHkGUeLHnNGOXNQ1RPfNI2dKP1fI4q 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s4ywc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 03:37:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H3Veuh037346;
        Tue, 17 May 2022 03:37:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cp45tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 03:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhcP5FedaXltPcAi0nJFTDoo7K0dmvv3SSfgOEwkI93h31VeAtKzpfD5xPZcuslYznWOtkPZxxMJ6zIJsLXegcA4G/QXp4yFrZ5qmh4J2UXXbsx/NNwtES2D5CkpWxbIyNkTcxlpdQMPx8nKRe79+p/p8MRP1LMghhQpfFu7xUhy1iK9n/O8GDlpkYW/XasAgOypZolBLA06q1LbIr4fHJBKCf/zi1xuVw/fHsI9fPf14ciYz43TcujXk+QBT7A40qsp58qh0R5wPFMP+w95snWi80uy4wlp4O3ZGCvIG7LLHCWRNdgtzzA54owb6g+nKEY9WPr29aAgvq6KhNwjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtY8pTU56ajafEXOk2oRJOjSoIlAdnznVQop3x9vSIU=;
 b=PQjwQtJ78T37hZ24X7DdsNGgOj4Mi/Qo2kzPOELVy7cK8lFUpEqhuGleKohqXtnjIsOi0YMBE53LuCsVRdPTKP988804UbxwISrfIy4DktA1nwq5ksJmlWG7hR8NTi1f6g/v8lWER69y0jFBnlaxGfM+E16QN5tzlcPKs/ygxVw3YrwMJj4eprHWSHN8AP+qTQs2lRg0tnQYCDsJKPmSNiG5mKuWkMcpoTdoUcNz+4uW6ksc3WMbE1Q/XCysg7rlX7dc2Cv+Lic4ptHz7lAfZ+0WLQs9SgCTJhT2fBYuDwaX1FvNk0MlWYO9DDLlIDJciHwdTccmDup/CB7sUxn4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtY8pTU56ajafEXOk2oRJOjSoIlAdnznVQop3x9vSIU=;
 b=T19CyviuPZoRu3NqntT20Afc2ykBWANQ4DbxxIQFnjjGk9fmGZeSZgga3Vt5Ksb8DL0eSsoxF8Ro21nsNhHM9X0SHascGSb7WOvCbci6A+UUXzq48lxd8Js//dnPy6j4hM5JVEuXA1ht8vgaLLjeoHh2/OfiUuRqLatj1KRsyOc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR1001MB2313.namprd10.prod.outlook.com (2603:10b6:4:2c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 17 May
 2022 03:37:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 03:37:03 +0000
Message-ID: <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
Date:   Mon, 16 May 2022 20:37:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f69d84-c252-4b03-77a6-08da37b6820e
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2313:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2313F8A30E76CA94A6C6BC15E2CE9@DM5PR1001MB2313.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rzut0CCEVwQ8OPkteM+BU6/7f4DjqRe1RqX/1QriqwI+QD3sfURN3VQkBxaAwrT5ka1k/++1++O9R0Qx3onySkhhmEoFfO4GL/4wmgHVqD0pZ+plizzSETZMU5JZr4hoh4L5oIX3Sx/yv7Y1i9RwiDKxc7WrAxEOqWpQXhyM5o8prkURS2vl+mz8kdWRCR0eVCus2iw97hikONdpZSEayrOKhXSe0uyud9wTlcsE8O2D/Wv01bPR99bPQiq3dnGpDU9bV26Hqb+2kN5fjnp4eZwb5ue+2DPtU0b1Xkm7Z9Hm6qfIaEuaTlj6pmdqNewlxhZNcgSrUiOb/+Yu1wm41Brl3Ricbg7UclSAH2RYw9cfNwePyTuNJK6fR8+vdlZDKVvCfeBRQhpq8RAr3DO1xB3Z61woV9XRrCzZPfzhK4Q8dpJy4IrijMMRPhZiqMt9xg4NC63hNU/lpDN35+K1nPcXXQ0WFoxDpJ+adoUrtVmvradGh2ULDIEVOQKTxpHa7/Tq7ifT9OMXOT/tgx1yaVwaBpzx/0EBPvMOXM7cdPcv8IahAq4YXx/oXusz98l8f0hd3XDbLq2IALXcG4uqYnarnJWS6uzp70mFfmYipHC1/O16Q2vewC/FxMA42YEgd66o/pfeM7GoumlhTJUcUaUETOym+A7DTuLPwUxPUMbnfIhzLcO8MIdQOCp3PoMRpoAyB5kuKOv2W1zkLdsy9rFacWPmXbToSCH11IuPQLPgzwIFr2ynGqqZOSl2qbs1HqFkAoePpBLwGtxCIUbSUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6506007)(31686004)(6486002)(86362001)(54906003)(44832011)(83380400001)(316002)(36756003)(66556008)(7416002)(4326008)(2906002)(8676002)(26005)(5660300002)(66946007)(66476007)(6512007)(53546011)(31696002)(110136005)(38350700002)(186003)(52116002)(508600001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJINXdSWVo1V3dvSVdsOXErVXRXQmRCSmMzdnRUellaZTlhVjlVeGZqay9v?=
 =?utf-8?B?eC94L1BQd2piRnNGR2xJdXdzbkFnWlBkcCtIM2lRc3AvZkdlWTgwcDNYWTJ6?=
 =?utf-8?B?b09xbGljcHlmZ2s5cFptcTlOZnJ1Ti9BUTY1WXEvWE90WC82a3ZCa2E2ZVRF?=
 =?utf-8?B?ZnZpOFIweTBJV01NZ0VDMWdzNnVROVVNOUtWWU9qbkZNaFYyRDBzM1pBTTFC?=
 =?utf-8?B?NEZETTZHaFhHaWVqbVh3UVRJZ21Cc1VZR29mM3pRbzZTSWJMNnVHL01Jd24w?=
 =?utf-8?B?Ly9ST2RDaEZsT2t4UC8wWkdaZGJnUDEwOERNZVdDa3l5bVByNjl5NjRUWmR3?=
 =?utf-8?B?eS9CVlc1T2FTTjEreXgyM1V6M1kzNUJ1L2JuczlzQXhCK0VaemlKT2ZtNzRt?=
 =?utf-8?B?NFpsTDJQRnkxOXZYRGE2RWRoNU80UHZUcVVTUm9OSWJDL3B0S0c2T2ZiOTMy?=
 =?utf-8?B?Z2t1QmljelVack5DTnQxeEYxZjBUcXA2MEViQUQvS29OdkhPeHNCZEtEOEty?=
 =?utf-8?B?dWYxOGd5ZmM1NXREbmVubitwTEh4YXJkVGZwQ0lqdHZYK1RLZW5kK0NuVUVG?=
 =?utf-8?B?SFBUdWJiQ2NuQTYxTDN0TFBZOXhMWCtiN05xbWU4dmwxNnQ3MUkzazlDUGxB?=
 =?utf-8?B?TlJlZVNaZUR1RG5paGNCU1FTbHJtaVEzU3ZpT1lVbU9STmxlNVpmcHBXWkE1?=
 =?utf-8?B?SUNhZ3Fjbi93UGd3QkQvMTQ2b3c1MUZVQ3lXQWxpSEtwYjJpbXJNM1ZDZG44?=
 =?utf-8?B?M282aHByTGNkZ2F1S1JzZ2N2OVkydVVZb2xicnNRYXVrM0R0N1hPZHpaK0ZZ?=
 =?utf-8?B?eWMvU2Z3ZERsQnZveGpjOXAvVVNISFVKdUZIaUFYWjAyR3ZUTGE1T3dxeW1o?=
 =?utf-8?B?TU1NSlF3UG9LV0R2WFE0TmJIZ0NHNnY0MHhRNkpwZk8rZ2hNM1lmQTBVblBD?=
 =?utf-8?B?V2dqdlNMMXd4aTVMRDFmajlHbUFwTjV6bnZ2U2hxMWxFeFNzWWUraFlmQjhB?=
 =?utf-8?B?ZzRLaUpaZFZWcEhuU0xtMWpMQ2dGY2Rnd2dUMDV4Nmd6Yit3OWo5MTZIcFls?=
 =?utf-8?B?TkZXckdJQllUMktva3B5WVh5dUVjQ2ZjcG10ZmkwV1hvSkZsRm1NZzBzbW43?=
 =?utf-8?B?dDd4cXNGd1BDOHlTOThocGVwKzZLNW5UVVA1UWpJQTZselA4dFhoSll0NHJY?=
 =?utf-8?B?RzN4T0NRRm1KUXZseko1V0lDR1llTkh2dG9qNktrUTdBWDBOdTRQdkJQWHNE?=
 =?utf-8?B?WndzWUxlSDFhREtxZzluNXZqMGFMVnJkcGw1WEVjUzcyL0JzNjNsTXU4TUd0?=
 =?utf-8?B?NC80b0hpd1lYMG54clYxcUQ2QUlQRjdPOG5GYUFVQ1VhU2hGVGhrVnlJRW9w?=
 =?utf-8?B?aWN6TGZjckxyZFZUV3BBM21ZVE96YzMrRjFjNW93NDE2M0pBOFFSVC9UK3Bi?=
 =?utf-8?B?bU9wUkhTbXUyYWlFL1padTV1amlGN1hnLzcwcUpxSlFRb2dZZXNkT1ZyS3VQ?=
 =?utf-8?B?RGRra29aQXkxREc4NnNnL2FLajNnb2F6NFF5VS9mY0doQ0tUVUZwWWtaMU5H?=
 =?utf-8?B?TkJoaEpSUDNscERBRmQ4K2ZwMGtmRDFqMFdBaUZQU2VTVHFHVmp6T1NwQXNn?=
 =?utf-8?B?VVpuWlVsY052T0xhZGQzbkJJbmJ3QlNPeWtrUC9oYVF3dkZ5amFkSTRuK3R3?=
 =?utf-8?B?Nk41TFZIWS9DblIzWUNUbDNLWndBdkNsNmtNMlVjZmk4eWVQVGlUK0w4V0hI?=
 =?utf-8?B?Sks2emovbUovTjQ3VEFneDlZMW9xZ0o5TTFjZlgzenVyTk5QczVHRjN2dDAy?=
 =?utf-8?B?NjJnNit4QTEzcU8xNEFITEVyTFhZZ2pQVUhjd2IxTm82VzFCS0xLV1oyVVNn?=
 =?utf-8?B?VzhQbm42R014Q3NBdlRVQ0JaQ012NjV5NFN2TWdMdWxwdWJ6bVhlZDFIWC9R?=
 =?utf-8?B?TWcyZEtoVDM2MjF1eVFVY1JSVXpMd1Bpc1phZ0NiQ1c0eFpMV09JNXRVRHNL?=
 =?utf-8?B?RlJxeTc5VjhBcXNqTmJsZFBXTkgxRUZWVUR6QXF3RUZ0dy9EZWNBbHBHbTFM?=
 =?utf-8?B?NW1RdmpPN0lFUCt6RjEvVmpBQVNVMkROM01xTmhnUTBBYUh3QmtzU2g1UnhJ?=
 =?utf-8?B?Z0hjc0JuUGQwVVhoRXEwTmJRM1RrdjNwV29wS0dxeTRITmxuMW8wNGZUR2VJ?=
 =?utf-8?B?QjFCQW1BTFMwbWZXNUUyZk9rOFJteUY2SFBWNER0bFpld2h1b3NGV2pTWXNm?=
 =?utf-8?B?VlJzbzZXZ08wVk8rVHg4alBMMXEzc0xLT0ZYUWF5R2RmWVVud2VHdnZaYW9B?=
 =?utf-8?B?d1ZDY20vdWtKc1grNVIzV1JqVW1vUThuTVJxZkdJOHRHUWRYUXFsQkphSWlF?=
 =?utf-8?Q?9xyPYfLLHRh2U3/Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f69d84-c252-4b03-77a6-08da37b6820e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 03:37:03.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rnj7nNpf6WXnMz/nysddWrlF1Iz0WD7eaBoIAayLtM76z2YF6d/DYRXCOzc9cqd+SzEMraYyP8hpLNnt30qWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2313
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-17_01:2022-05-16,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=908 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170020
X-Proofpoint-GUID: lDnd3e-JgO2giLxw2V1uz8gA8j7Re_YL
X-Proofpoint-ORIG-GUID: lDnd3e-JgO2giLxw2V1uz8gA8j7Re_YL
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 17:56, John Hubbard wrote:
> On 5/13/22 17:26, Minchan Kim wrote:
>> Anything else further can we get insight from the warning?
>>
>> For example, pin_user_pages going on against a hugetlb page
>> which are concurrently running alloc_contig_range(it's
>> exported function so anyone can call randomly) so
>> alloc_contig_range changes pageblock type as MIGRATE_ISOLATE
>> under us so the hit at the warning?
> 
> Well, yes. First of all, the comments above the warning that fired have
> gone a little bit stale: they claim that we can only hit the warning if
> the page refcount overflows. However, we almost certainly got here via:

Yes, the comment is stale.

John, you added that comment with commit 3faa52c03f44.  At that time,
the code was doing a try_grab_page(), and this routine does not check
for pinnable page in any manner.  So, the comment was accurate at that
time.

Later, that code was modified (for performance reasons) in commit  0fa5bc4023c18 to do a single try_grab_compound_page() instead of multiple
calls to try_grab_page().  At the time it was not noticed that
try_grab_compound_page had a check for 'pinnable' when try_grab_page did
not.  So, I think this commit actually changed the behavior.

> 
> try_grab_folio()
>     /*
>      * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>      * right zone, so fail and let the caller fall back to the slow
>      * path.
>      */
>     if (unlikely((flags & FOLL_LONGTERM) &&
>              !is_pinnable_page(page))) /* which we just changed */
>         return NULL;
> 
> ...and now I'm starting to think that this warning might fire even with
> the corrected check for MIGRATE_CMA || MIGRATE_ISOLATE. Because
> try_grab_folio() didn't always have this early exit and it is starting
> to look wrong.
> 
> Simply attempting to pin a non-pinnable huge page would hit this
> warning. Adding additional reasons that a page is not pinnable (which
> the patch does) could make this more likely to fire.

Yes, that is correct.  One could easily allocate a hugetlb page from
CMA and trigger this warning.

> 
> I need to look at this a little more closely, it is making me wonder
> whether the is_pinnable_page() check is a problem in this path. The
> comment in try_grab_folio() indicates that the early return is a hack
> (it assumes that the caller is in the gup fast path), and maybe the hack
> is just wrong here--I think we're actually on the slow gup path. Not
> good.
> 
> Mike, any thoughts here?
> 

Do you know why try_grab_compound_page(now try_grab_folio) checks for
pinnable when try_grab_page does not?

Then I guess the next question is 'Should we allow pinning of hugetlb pages
in these areas?'.  My first thought would be no.  But, recall it was 'allowed'
until that commit which changed try_grab_page to try_grab_compound_page.
In the 'common' case of compaction, we do not attempt to migrate/move hugetlb
pages (last time I looked), so long term pinning should not be an issue.
However, for things like memory offline or alloc_contig_range() we want to
migrate hugetlb pages, so this would be an issue there.

At a minimum, I think the warning should go.

More thoughts?
-- 
Mike Kravetz
