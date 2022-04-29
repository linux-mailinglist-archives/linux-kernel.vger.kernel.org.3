Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A725145E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiD2Jyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357928AbiD2Jya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:54:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C447C6649;
        Fri, 29 Apr 2022 02:51:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T74j8K018590;
        Fri, 29 Apr 2022 09:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=g5ztM4swd0OBzijvluDkW/HIC18vBq0eTRKn3zQ0g6A=;
 b=R2iYWydXfHAIjKpasZRe4OYQgbnrMSmh0xfjq+uJ7+9c4L3uQDXRfU6gRt6xcT3gMxxk
 xnteKyKArr1cYHu8+b8ubbe5tH+FzZYu2rR3Si7I5vzXwGs1gzm5chtRgxRZHtBMnAWA
 b6SIPPldrbsYk1RjJD1oUrbDnNpTRTnXANwsKXrcY5Cbo6RYKepdL1MJ9khgbPuqOMqP
 lxr69dN4aPgLXDyyA0f07kOeHneCpZvdhxIynMKuSbOwfVgwpetFeYYuClaw2/dLKAGK
 U3bzKo9IspYGFj8kE6iDXNp5wg7+iNIFcIwML8iemyNDYvhherAukO74hW+mrr6DZN/m jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k6c0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 09:50:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23T9jE7D015420;
        Fri, 29 Apr 2022 09:50:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w7v3w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 09:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKop3HYB4Z5gyKykYG+N5dWU2AZQygkVGWfWtECVU/Q136VlBiDMuwJXJi9K5I0E0AnnrAQUUQE0CkWB2aLbVJyYgCYCgzo18fjCGyK2HntrsKqU9XWQNC2ACaBb9Ks0wum15zOWWQWTgrH0Yh2cdIXx2egi00cOOHGIv9QlLVdQxvCd3t7AlvzpkdSE4rFkarPyJiDGtb5XJ3c5mdlcVLPY6pg0/SFACDMNu36tGaReMiPTbEKUVoVN/rXu/A4Kge+ZNh0tIliFR8Q5C3Cn3Aip9uzw0hIn2ubGv89TQorTuVUlxA6lVNSS8SvoRRvNWI6SQ3/fwTSsrnOVNnpvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ztM4swd0OBzijvluDkW/HIC18vBq0eTRKn3zQ0g6A=;
 b=QpMhvY+reFcU+bMrE5UlHhwPaH90HZtSkXAJAr/p46NCrQxP+um50wAgog54gD13EidnAsN9KGvdoRemwO7Ab5QjlBRE8Vj9d0eLigDk0mIma/8PeJtECENl8qYD45pbDbwQnWt5V/03emS86kf5rCu98S20qjJej34y8XYspjPLk9Ju+bEEif63PH7Tknrpb2ix3J92ZhP7BG/1IGx6+OyY6FYPeHrllvYHI7mCLG0U/epbFoj3Tj9L7zw0VJiLVydEdT4/Ua7CuVNbYi9q0Vcr9DPtAMmrwGlBjaIkGowyzyMh4H9q9odhe2YXnLs8bLXDrJODdoS5YXVbab6c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ztM4swd0OBzijvluDkW/HIC18vBq0eTRKn3zQ0g6A=;
 b=pHJNpBYiEJDr1tZQbphE1V87w3minspGtXed/bwGziShObt0BHoHXAb09Hk+Hqi+eikvN+FOwKG0V2SNLkU2zTahNvd91LK53+5vpVxTLEIdAe95SZpaIcgDNNmGbKp2RK58yH1fkM3BgRABWJfFwL6uT8oIaGyMOkTl9TV3Xv0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5673.namprd10.prod.outlook.com
 (2603:10b6:510:125::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 09:50:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 09:50:50 +0000
Date:   Fri, 29 Apr 2022 12:50:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmem: check for allocation failure
Message-ID: <20220429095032.GB4031@kadam>
References: <20220301081127.GC17375@kili>
 <996eb652-8a18-184b-c163-85e67d67b530@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996eb652-8a18-184b-c163-85e67d67b530@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca4b803-d9b3-483d-3ee8-08da29c5bdf7
X-MS-TrafficTypeDiagnostic: PH7PR10MB5673:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5673A63175F1DB70E82741478EFC9@PH7PR10MB5673.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dzrr0DeDMYcDohh1cPzSryUkE/PVor2JwocfK+LtAL1vX2oXmqoZB3SXSo2lmjAyoHO/8U9IJkwLEgsecL/GsC/l77Gkuax0zX8SjofnehGsI3RTHNRPA0A9w3ZnX7YK5UdU+VF+Yq4ngTkqEq1/fitzUWlfOt2f0B4l0hMbMwfYsbKORsCYqVUs1btfxcR8Cw8Py4UYyMPPSeDAiZ1nsQyoWc+XIzYDJQ1gpCwgCCFAKtKenOgei8NANmojBWZkn9To1KGi/mg69ALUDTfMThXbNVAUkPYDe5D9MRg6SF42QFqw2qbdQqov8scTapAWtesPefbKSqwVF52t7A1Vkz2Fug0/K1qbMzVtgSuD23lavcjF1m5nOZNkBRS4KYBOZgj8Z1aTDgx0vSYMpoT4+KRkw5uOfIvL3PO9fg1VR5slnIMt1axzrhNJB+yI4Se18y4vZiDPK3Re0wBaxlgA/PnHZhTxDKV1M4jNmFN/vq/dDykoeUHcu+o8PuGB3PBvZawVQDGg8CVUkezEcz7O1/trNHop8ocuUSMJRVPF2zDKuE/FFrH1E0tJwlvyqeS0rIbPZoo21tNlWgu8PQ+/dl2PyjjmyXZW5mckta4eWlFHLgQW3fraIInttyRdHGi6AlLWJikTLDSh4H/HlpAbXEPdHVGh/0HFS53THVplp6FwA4zZ92SZdIOVBZ1v0Hw32MPh22zFknMI4YXu1bC/Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(33656002)(6486002)(86362001)(508600001)(8936002)(4744005)(44832011)(2906002)(33716001)(83380400001)(1076003)(66946007)(4326008)(8676002)(186003)(66476007)(66556008)(6512007)(6506007)(6666004)(26005)(316002)(53546011)(52116002)(9686003)(6916009)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGQMGWwjudpQArUYHMKwimDWgGsJMh9ut1xX6K3cMbGED6J4myKCRx6Lio+y?=
 =?us-ascii?Q?PFaX6WE7N6+NGLcx7DY55cjXfU/5giGDROT6sEMBAdIS38iRE8d8UoWIf9LN?=
 =?us-ascii?Q?DFH7f/kJl5wZ9y5OIIxYHPg31W4Ma12NWTv9mP0BH7ZUjbo9zYtrxr4tStss?=
 =?us-ascii?Q?cAHqCPJeL7gKpFbDH5WifYXQ7tmgmMGxbRLkv+2qD/ABjbAkNuVKQSF8BdUU?=
 =?us-ascii?Q?VsPTmvirxf49XLle3RK7IwW/glyBIFOgejk1egcVPtuHThEpPHAw6ekqm+v0?=
 =?us-ascii?Q?8DaIVj4yNt3IMgHfeky0gW7bjiGNvkipgdWZ3B07rw0OEft8d81CyiC8sqQF?=
 =?us-ascii?Q?jBFWrMLuY49PzC9VWtDZOlhNdVZdqqpH14BLMXc5EXsgMSRBOQz868IQlGn1?=
 =?us-ascii?Q?JFiLupJnuIk1xCj+R1Rrh1LKRaB6P7sQwMcBjB2UZvheoKp+a9XbDF7H1fJg?=
 =?us-ascii?Q?38cn0cp5l66wZXZBp60uxIUJse6kvAVemjpYG4ZnEUYogi/a+9d/1m037YWE?=
 =?us-ascii?Q?ZzzDRHe1s4jn8W271UH+6piIlFpXkDkLVXAvR+BXzu7He7qC+0/Mk0p6F+Yt?=
 =?us-ascii?Q?MYdv0x5aswn3XulPfW8p1GPoAi7gUJnMGmfAVYrGY7qtlJB1iJQ+bEzaHcDk?=
 =?us-ascii?Q?PtFeI6/hc14SMc1QaO/NqJSJ70io8knijt6bz67cz+MVOSPp5PoMZdvdgzGa?=
 =?us-ascii?Q?a7ITQ5Hfkj/pDB448mW/qy2sPqEF+TFO8jB/txH7vdp8gy5F5JA2dLHUlNrj?=
 =?us-ascii?Q?1cYUGkbH0kSVoF65NaNsjpDQGNS2kEvyFXdW9PkePWRdaPhauRGOOucYdb36?=
 =?us-ascii?Q?HssWmpdQQPT8xJH0AC6VKVrmBfbkqS7p3IwsvFCQaeRdXLRLQ6zfBQ3vGvcT?=
 =?us-ascii?Q?hZVP46/gI4RENAh3PNagsNw+DdfAkeLa9qIuVlz0WCzv8c0K6UtPVZuuhps3?=
 =?us-ascii?Q?1KPskdw1y5zgNJJzoQ1lvaLQVdtAlOfSb83tK3EI3bE3t8PbPsbKfAV3psvO?=
 =?us-ascii?Q?GFo02tF0cErM8utJVtdx6A7ufqwxjRThMGgM0CJ7IsC4LGb77s8T0FnUiRjI?=
 =?us-ascii?Q?sO0otKmY1P89TdHXRhQe3w55/a8sbSPrB9xTunLcDh6scOa83a/ODwXvT4P1?=
 =?us-ascii?Q?XLn9KLbPU+SYgJ8aWLINXW9bv4XKPvtLVgMohtsgiVjPlSdvTfwdIALn3mtQ?=
 =?us-ascii?Q?TZ9LyoYW0i6VwFpBqU60oABtBHSJ9E3wN6reCjpHdUeh49VJ06Oj1eu80c/y?=
 =?us-ascii?Q?oufpeBaSyTCY0iuKcgYxgmTzaZaxNLGx4ltTcIC3lSUENntByKFBY28Sd6pf?=
 =?us-ascii?Q?rhMLT9rP7iirBbOdgFH0dmhb7CWq/9EVMqgbTtiS1COTWxNtOvQ9W0fvQXUN?=
 =?us-ascii?Q?lDEE0mWb+13rWqoyGcqP+Pp+UNZdnn8r4SchujheeQ7mSUxaPJmptqbOyPES?=
 =?us-ascii?Q?1bEdl/KLGjDvnEGPhZ+LufkzbA4JtTuMrxduPqDmjpUyhqBgGF9o3WuQutcn?=
 =?us-ascii?Q?WLuUGG+PRoI5hTFDeH+rByhNMbIDfbYEeatc1cjTpyrXA90LMiS6FEN5/B8p?=
 =?us-ascii?Q?pKFfuKsJRtpcmKrZdZR8I6LI5pfonkBDwbXMNWG/+SAnLqbJh9FlDSnNnWdY?=
 =?us-ascii?Q?O59VlzD07zyDeNG/CEyjySb3xC6aRlxRPmkCabfnZCa1m7PkTmMe33nu2t2g?=
 =?us-ascii?Q?5a5Z1mIo4pGt8YwZXHaa3JMgxaSkZK1sFwSVuMNEuX2ONPxz2Tj+AwaspwcU?=
 =?us-ascii?Q?DklnZwNZgbutA48bWSk4fSgBMaEtxpk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca4b803-d9b3-483d-3ee8-08da29c5bdf7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 09:50:50.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DsiwoL2XysRgDZaEO2Toyd1fxnHS0fzjkhEoYOO+6TJLM06cdoZyOwP7J2bdi4tzbUu3P4VfdUWuvD8UZ1ZwvWAL4lfURBNH5RiJ9uTSS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5673
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_03:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290056
X-Proofpoint-GUID: Xr6gFLgPizqo4M07B8ayEGqOzodAkiBK
X-Proofpoint-ORIG-GUID: Xr6gFLgPizqo4M07B8ayEGqOzodAkiBK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:33:44AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 01/03/2022 08:11, Dan Carpenter wrote:
> > Check for if the kcalloc() fails.
> > 
> > Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> 
> 
> Applied after changing subject line to "nvmem: brcm_nvram: check for
> allocation failure"
> 

Thanks.  Not sure why I didn't copy and paste the whole prefix.

regards,
dan carpenter

