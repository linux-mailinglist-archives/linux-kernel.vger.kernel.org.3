Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B757508CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380430AbiDTQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:16:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E41AF32;
        Wed, 20 Apr 2022 09:13:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KEiXxS019340;
        Wed, 20 Apr 2022 16:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iR7t+QrE0HeqxKbKGoC5cY0rBqqhBGg66dUiGeZ+tXY=;
 b=H2vSo7Rh5UYtJ2hY6qXqtSL9D6hvH/RZYUBlxGjxGT2JyzIEec2ANWi4ntywSWZh5G/W
 xNeD1QnzPz15z3/uOpDUYMMhVlC2e5Wjlr9zeETwOcx6Pf4y0O8q+FYzw8GIpW7JaUg5
 qukjJhthpH/ehREqtFbM4BrA+Mnho0g5ZVVNoiMJePmnM+ATCLsoFt0pKwKM0+VQ2hWG
 8t2ElRqSfRPQMCxERHSFLsCxE0U9/KBw/1sHG0/bisyETqRU0gJjOt67lcOKY56xkN6Z
 XGYesSgaZxnGbGj1edgu5X2+xiVxwOVhg/vnxSqaLk0C47Zd+eLvF271ZC05ByS94WOb mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7csdfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:13:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KGCAGD026812;
        Wed, 20 Apr 2022 16:13:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm874wfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/V1iIf/gYPK8TxXOnWkzrOcFR+AKsbx+neUll5y4pA8TAbspk+N9l0egW9Jc9Fe6opdLLWQF/8hwydU4SVlDzvDAAo6RAZg7nM6l00IuFZHqpLwt3sVWAFcnbHoa8yTOaljJ72YT7Jj6LACHwSPloFdTdlIFA4YnAXHfWWiIiQWXeSHzLy1Aw0aibye4xqQIDm/cxqhRFoM/B6/tXto6IzRPkWNb8ey2NibEIGrB/K6onhDXLcH8CRkqlupvsL/5lUbpWTeB52DRkZzWx0j5CnkOW11yHAEHwx0ex61gsKJeTke7spQpReROrrzpYuUhPexeBG++J2R8rpQSgRq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR7t+QrE0HeqxKbKGoC5cY0rBqqhBGg66dUiGeZ+tXY=;
 b=NL5SiBlw2G7sedeHV8cjsewEjUqYWGH1xiT8VcRzz6k6du5o5HKVsZVMJwG8q3VbUSL1TOXkBkBe6cZhUTZFIG8vjb/ZX8iN3+tg5UNH7GHQhAgDH4UtsWMrCptBJW3ub0ov0CTSDgxSUkCDJB6sigBFrkT4qj4gC49K7q7y2hqu6nmREISnqtBzCIWQkfauFjaXy+R1FumFwQ1r38WtLqMFPz9AQmPWoIcTIlUQHH4USt4iTdX2JxUGvp4VX4PfskZ80+wHzTVy2n2Ey7Wbd7UED9DGNVj4lt1EfuHIYuEL7BAtLwhRoEFVMPTqR3ZUw3gf1OyKFf3FTUchjRsdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR7t+QrE0HeqxKbKGoC5cY0rBqqhBGg66dUiGeZ+tXY=;
 b=fvVIELZrsdZPmbXlWnWk/v24QUe6QzfOsbY6L9yLX/iH7FW8JwuM/BmHYVFZDonQK5gpLIriNn6GK0WZptvG9IyqSPq4qCoMBiMzzUtJjVD9bRdjXe+7ByTttlHxKGfg/7fohIb4IL/g9xF2qaOP7Fz19WNUUi+CBv4yVY2zIrA=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR1001MB2301.namprd10.prod.outlook.com (2603:10b6:301:2d::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 16:12:38 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:12:38 +0000
Message-ID: <e4bce8f1-c6f5-cb99-8a1e-97b09ea1f840@oracle.com>
Date:   Wed, 20 Apr 2022 12:12:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] xen/scsiback: use new command result macros
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-3-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220420092503.11123-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:5:80::20) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cdc698-1749-491e-ccec-08da22e896ff
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2301:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23015E6767FD1156B8E7E84D8AF59@MWHPR1001MB2301.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoOkwagp4IOJLtypk33NrZZc3th+GEJWMGt3KgO1jWpXf9FQhxyg8HSlLSUKlRAWa9vNi0BxSfxPLomqSaLP9obs2kTVEuglq73ISmSKbU/UMxsm1l25u9bpp3PuL/5e2rGgqH0kaQKdxpovLXFXA9NxaEPKHGhiWTEx70Wy3F/TSZjpjHU2Xx/HY7uKwH+JM3tEsev+KRGZDiDeA986QOk1J5groJy/GvRKMPdmWplK7IippLSDTm3pooYsZhKcjt7fVbA1uX7LDha0SQmZYIDQzzXas0KxXSJ4m4Z/oQ4Of3Cql1J8q1znk2iKx4R2ePFJCFiOuthhuP4HTCsojK0A6p4ibxv8kNYStlK+8voR9doesrd0Sd2u68AAc9eLNuFoNZaalb6zV8m6fekHzTg9YEGOKcmiY/JGE6dSWQFvircZ5dD1jq1aBqcKLEAuRLB4yP/auAxgWRJVSTAxslV08aO7LfM5rhV4F+1mthbf8i++LOau8X0bR/LBjCXS50DKQcFJEaKTiwwvgIYyTJNSWo5w9oe87iq6xKvWpw0UNeLre6xNZpxAE0wNPSjD/7JApSci1K4O4gr4ZjiC3ThVcvfHVHvXBGAGyB+xvepFMs0c00cUdyFeIlS3/A2CURkIctFqi22MJp/ioDbpqkVXQwB/eoYFzf8n2ayH/jhRUoZzoTIiSfedeaMO35zddXWQ41KhGsdmJFwJoi23quzqzbhNOzL6RlcovxPpQCai42jjo4SFOtlH4DuGeJRl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(31686004)(2906002)(66946007)(8676002)(4326008)(36756003)(4744005)(2616005)(86362001)(186003)(508600001)(5660300002)(66476007)(316002)(6486002)(26005)(38100700002)(31696002)(6512007)(8936002)(66556008)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lVUVNObFRHYzdRZWxjZEhZNzRUaEJURHdnWUJtc1J1NG9oZFluZ1ZJdHht?=
 =?utf-8?B?SXo3WFdFaFlIOHVyQnd1b0pOanpneW9GN1pmS3FBZDJKSFIwZndYUlFrODQ4?=
 =?utf-8?B?VHhzeERPQ3IzTjc1aHdCZVRIU2Z0VmhCUFJsaGZCVzhYTmRQMTdJaE9YUkVp?=
 =?utf-8?B?Z01pdEhXUFVsVVdlRkcxSExYekl2aGhuN213Z0ozaXpQeVllaGo1R0RZWmo1?=
 =?utf-8?B?cElkK2g5VlNWbkwrOHNpMlJhZ3RUb0h0U1NwYlBZOVZoT3VwandOeUk2andG?=
 =?utf-8?B?K2NmV1QwYks4YVpzZkVmY3Exc0owVlFQeVNNYlh4aDhOMWtXL0NHV2N3WHJP?=
 =?utf-8?B?bDBRWDdxTUVnT2Y2N09VNWJIMG9GWERCWERBbnIvMEV4YmxLaGNCMTRDRVdv?=
 =?utf-8?B?MlhDZzROandES1hoT2d4YWw5aVFheE1TbzdlK3dtWVFZajBreUcySER1OGlw?=
 =?utf-8?B?cnRDYVErdkxDaHZ4QWJkNmxNRGhFRmI1d1NEYnpVdjBnTWhnYUhJbDVaL3pr?=
 =?utf-8?B?bXZtUVZEU1Z2ZW4ycVA0OU9ZNk5pQWl5NW95bUtaRGpaazArY0RrbG9CRmpV?=
 =?utf-8?B?bHJqdXd2anVsc2VIY2phbEhBbEZMVlZ5UkpFR3pLeURTVTRKSm05b0VzZStU?=
 =?utf-8?B?RW5rWVUrVnp2QU9VZlJHT2hrUUFSMm9nQWVtRHU5NTJEWjl0NHI1ZkV1eTdQ?=
 =?utf-8?B?Y01ZcnBXcHVZNU9QdmgyRCtuckZkcElxc3B3YVUweWJPYXJ1YXZwUGhhTUFF?=
 =?utf-8?B?QmJkR29YbjI0RjBFV1BCY2pJTE0xVUtZVGQ1K2FXS2xhN2YzMzlrbS9MZGRZ?=
 =?utf-8?B?eTBQRzVhaTk0L3djOVoxRjFnMTdPVk9TODVKME1nVEdRMm1mSzFrQUVjcVZU?=
 =?utf-8?B?RmEvOW5pZ2RCSHk1SUo1VDk3YzMwUCtGOUhoeVlWK3g2c1RJemZXZjBKSXlr?=
 =?utf-8?B?ZVdzSFVqcmxidGM3QmZXVTkxTmlTaDdJMG9nOXkvc0cvSGcreXhzVnE1QS9S?=
 =?utf-8?B?R2hoRG9GbitCeThnM3RyNW81MGkzSGtWSmJzZWVJRE02c2M2NWJMWDdqYmx6?=
 =?utf-8?B?ZjUwN0x0dWtRRStiN2Yrd3dQTEZKczJYQlk0M1o1YzhHQzNQZXpkSENwZDFn?=
 =?utf-8?B?V3c2VDRvd1NGRGNFVHV6ZHJYbFpHS2dXUGdBNHo4bDFPRUEvekh5VXRaSWJ0?=
 =?utf-8?B?ZXdhaE5BS0hKeG9oMWxtc1U1NHhtOVJpOFZ6OXFuQ1NQb0pWRUpTVEtpbzBR?=
 =?utf-8?B?V2Qyb2E0aWdIeHNMZzlCdXdUNENGeFFFK0VnSzRkaitKTjI5akFlbHFBakRE?=
 =?utf-8?B?eW1BR2ZENmxCRktuNkVrR2RoWCtsUzVTUmNTcXpqRGZ0NTNadTZpa2U5a2J3?=
 =?utf-8?B?SDRZNVRZTUFsd1NPMkF1MlJQYTdKMllSb1FPWlJsZ2VuWU45UUVBN3FveDZJ?=
 =?utf-8?B?ckhvZ2EwZUUxYkUyNTVrS3RPeHVHQzVibDgvOXV4VHFGMk9NK2hpdzRyNnVU?=
 =?utf-8?B?bHJFTmREZ0RCOGVrK1VPem92cjZyM1p0NFArM2pMWHhwbkhDUTZqQitWUGpM?=
 =?utf-8?B?NzBhMmVyTDBPUGlqVUxuUlFNOEVsUHFqMjNkQ1h6a2t3ZzQvVitwaXV1OTdn?=
 =?utf-8?B?djl0ZXZTaGl5N3RnQlFiZzUzVTFkVTZWa1lMbkNXVVhxN0R0djVOc2kxazJV?=
 =?utf-8?B?aCthMFN1eVR2bkxveU9rZ0s2dUZ1MElpd0dUTUY5YllPVWp0NDVDNEl2TGtZ?=
 =?utf-8?B?cFlVSzdiNzI3clZCQW5nV0lvb2tzSDk0VXVMZHdnYk5GV3RORVp3RjVyc3k0?=
 =?utf-8?B?OVA5RUJYWDJYSEdOdGkyaG5pc1gvYUZ3NkxJZm0vZlVwNE4vYk4yLzlBVTI1?=
 =?utf-8?B?OVZndFpQYitPSVg4eFFtN0hkdTBPMTlZOEx2bVlRcEIwUXptcTZsYVVkYmpI?=
 =?utf-8?B?bmJQbVYwaGxHYi9JR0ZQZHkrNmhMd0Z2SytRTWRQTVBPRWtqOFJ1UlIwTkE2?=
 =?utf-8?B?VWROcmM4WDdKbTI5YlNmN0ZzcUcwZ3NGNTE2bHBDWXR3R245eWVsS1hQbisz?=
 =?utf-8?B?S3hrdnRacGhTcHNoZHFmTFY1UU92OG8zN3NwR0hvbXZpUExMK0tQTnZBaVZU?=
 =?utf-8?B?MUwrV3FtYzcxTE5RZk16MGtwWU9IT2dTV2t0QnF4VXZ5MU1kWTNkUHg4SURP?=
 =?utf-8?B?Z3haKzhhRWg3bEZ2NkpNczZOenB4bm9ORXBHZjVOa21JWmN2TzJZNzRrWDVF?=
 =?utf-8?B?Q2tKYkJEajBJcWw1b1U4Zm9zVzAwc2VzOXB0a0Jra09CNmRZNXNIQ0FFeWxT?=
 =?utf-8?B?WFlmM3h2ZVdIVm54ZnE5YzJkTUZ1MG9lSnF0ZFdRbWY4SFdyNDhXendkNzFO?=
 =?utf-8?Q?HQO3Wr0c7aEZSvbQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cdc698-1749-491e-ccec-08da22e896ff
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:12:38.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evgORJpYMo0PWFoFJ5dJuArcYc6+AH7yY88q0hKzDeUmdSR9DTYqdb9cQdJTNR9ewK2wNz3BkU2NK6J5uOaY/IaWwmC/vPFyA/RyAY5TgAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_04:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200097
X-Proofpoint-GUID: DzTvsBdnHLfWy6Tgc-d-yrQb3DCjs0om
X-Proofpoint-ORIG-GUID: DzTvsBdnHLfWy6Tgc-d-yrQb3DCjs0om
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/20/22 5:25 AM, Juergen Gross wrote:
> @@ -569,7 +645,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
>   	wait_for_completion(&pending_req->tmr_done);
>   
>   	err = (se_cmd->se_tmr_req->response == TMR_FUNCTION_COMPLETE) ?
> -		SUCCESS : FAILED;
> +		XEN_VSCSIIF_RSLT_RESET_SUCCESS : XEN_VSCSIIF_RSLT_RESET_FAILED;
>   
>   	scsiback_do_resp_with_sense(NULL, err, 0, pending_req);
>   	transport_generic_free_cmd(&pending_req->se_cmd, 0);


You also want to initialize err to XEN_VSCSIIF_RSLT_RESET_FAILED.


And also looking at invocations of scsiback_do_resp_with_sense() I think those may need to be adjusted as well.




-boris

