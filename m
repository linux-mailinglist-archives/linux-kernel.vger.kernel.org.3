Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ECE522106
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbiEJQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbiEJQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:22:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B401D3D61
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:18:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFlv8H022574;
        Tue, 10 May 2022 16:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tVjNF2y/cwsX4ImxQwph9xXBTReZnFo7CCDwfmQ2a3c=;
 b=zO6IeIfVvjX6tTVM7+pS5+1nqQJCSl612akMFJNRo0+oPbYZznNQOs+7ApT2T5M0ix2w
 1C5Uyl6a9Kia0lB94w90/Vv6OSugB81Ya/xEPIeOqtvVcNsjtbd3Wd4ViZRGq9aCeZT5
 yTKzREQ59Aou+22ry+ySME6Fa391LE7NiXh190MEocw61DQRiECAdvQBEXX3fd+Z0x3I
 M8C22xJkW+2t2kdhR2pRdh9CHsdok1gQ62HsEE9gq+mYP24IpAvjQOtenyaltueaHMn9
 ZyE14uD17bF81KtiI42oE+p3EYb/fjrHjsKesxDD1TIZ1YLrj57rwPlBFAWpsqa4m9fE hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatf8j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:18:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AG1d57039998;
        Tue, 10 May 2022 16:18:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf737x5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkzorPzI4dZeVytR/RjtyYt4H7iEcgOPkw8N07AnS6oSh/CuxSd60TodyoFvUfEin/fhH23GCStYgWhSTy/jomJws2oYDa/+yCBCNgglVetJNeTvnqwuQmvO0DULAWQgGpn+BCUQAMfpOFECHU2x4yG4IOv3FlKJSrQyV9Y1Lo25D7pj+ATxdFb0btaDSuQa6KL/J/bmFdrSfZeUWb0NU7wAfUCse/KAF5BBr1eLMUOC/w5Qjfq513gmrhNbUbx7yjTvDW78vtcLQThekbEfvJeJ08iIhRyRb8tSiXjmZNrh6jhE/fWFlVjLIQ+JvP2ZCcR5x6TjcMt7suvZ8vd46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVjNF2y/cwsX4ImxQwph9xXBTReZnFo7CCDwfmQ2a3c=;
 b=leFSmLoUeOcgCbSl2uc9LboBiztt8YIW+rxM+1TwwbjWyeD+LuLin776My148/eb3ibyITQh6P5DQEPVSFqawqisrZlYnIXCvq0THc0oo10rnDgl3XLEixJLjQmhS+L3HTT11xgJ2fQKXq3RtDGlfCkUunNDjXUlpzapqW0ZZuPAdiA9/9l+cEgarauSu7K+cN2j8mT9zHBlrH3fEM49/1oBC4gkv+U2wjBkOUwaMDsLjGLBdu+iO3qsq1iBcR9kextvG6vcehHIUpcG3efPRp5jwzLoheaOlSfF0TE/qITuY7kdG4ORawRiQHCUS9+gRFPOcF2f6MJbrQstk5adMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVjNF2y/cwsX4ImxQwph9xXBTReZnFo7CCDwfmQ2a3c=;
 b=QzhQYAi1SSnhkd+pw9CQi0J+AaMaerY/DXCmCupS00LHSJIXj2cIjWXVRFrNMwK/J2YWiPf3oRvcliOodJdSvJ1yoEiszOFsUozUWMlTkO5NAO2h/0m935ZyLCdyFoFOBPsMomsTrPOIsHBaY3/c1RQH5lunV6rChCIVMuVEZP0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5295.namprd10.prod.outlook.com (2603:10b6:5:3a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 16:18:38 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:18:38 +0000
Message-ID: <e5820cda-ce5c-9b15-8822-7a6b858f806e@oracle.com>
Date:   Tue, 10 May 2022 09:18:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/3] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-2-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220510112734.205669-2-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:180::39) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e57441-6f8a-48f1-db21-08da32a0bd56
X-MS-TrafficTypeDiagnostic: DS7PR10MB5295:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB52954B01F239225C5615AB0BB1C99@DS7PR10MB5295.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SP8yenelMQcvXPNKyeCJI6fjT2FIMD1DCIu+ofSaa9t10rVefqToLgfuFojCG+eJqPDoizp+ptzJ6i6TDCixGz0Y3rzfkJx5O20yWyo8kh120x7zQ9VqwUsD65IBtwWtdu/iatDXPsA+u6+YzYO7pAgHZDrtlA3wAxSyJx+GzMyV05BMhuOLmNdnnv+R8NzHVtxXhC5m+C96Y1gSyoFA6PuDC6qsnGJVmfIEypPzbl6GLZUCwSHr5wtDM+M6RdUXq9u6RTFwX+xRtPNNPnaW7/M2Snrr4tSPD/mz/L/5fysgCW36LQLaVyfvRooYaeUq5oErovzS7CEx0mRGgQW0wQ3Sf2jzGfx4ZTDnau+MT0KogZrtVnoFv/NgS/IxyHVpOHqf4W6+00jGUDlTXwI9/UG9xVuIhzr4dk2dSHaA2zy+dF1p6tscyLotmhWFpZRceVtYq9vfPk4y/pwBIiHU0Lc/Tf3ZilmJxePEpxLyRoeDiRUhXkWrekWzUeKzBa7E+PoWglgfTu0GrPyV8mkr4WQspiLBTP5zF1G+RacA5xEBt4CQDl/6SmqRhggJRppSwA8fcEc3wys0Yw9swUBD7HkHqSU1GPthSIERV0oKfHITxbmS8sEdIssopKTtvMO/+BpqqzuNTBSPg/q+g5t1oENuwpH0PIrbzJzpT3OYtyuuRRRYs1bopkDtU9ygsCqq90AZGZI4bEm35VY9U2rejwLk+ob+qvd7Wo/Xp4+Pnjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36916002)(36756003)(6506007)(6666004)(2906002)(6512007)(4326008)(8676002)(8936002)(86362001)(5660300002)(26005)(53546011)(66556008)(66476007)(2616005)(66946007)(31686004)(31696002)(6486002)(508600001)(38100700002)(316002)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS91MGVCQlFqTVhBdHdlU0pDLzN0RUhYR1MvenFuR0ZFTWgzRmxNTGNSOXhI?=
 =?utf-8?B?L21kR3p1d2tUQmk3bXJlWmxnL2xMMnFjdG1IOUpxNlV4dlB1dkN2OXZDbjRy?=
 =?utf-8?B?QXhSc0JBVlhaTjFSVCtsQ2h5Mm9hUlFYaXpWczVFSmU5aUVQWk5QeEJjMjdD?=
 =?utf-8?B?ZmJiQ1REcG52Ti9scFB5U21JcU9mKzdLRnNJb0U2ekRlRU9MSzBpenliQk5Q?=
 =?utf-8?B?aHNudXU5N2NXSVZWbDJER21xWUVxdHN0N3N6Ym1vNG9SQmpveDhXK2RpKzNP?=
 =?utf-8?B?UnBoQ2NKZTl3TjBlL21xbVZaWkhvQXhxL2t5SGxnWUxyR1dpa3VOanBFNE1N?=
 =?utf-8?B?R29nME5UdklORWhnaGsrNXUxZi9OTnRsdVZKcjFWUHJJeTg4cU52N0xXdFJZ?=
 =?utf-8?B?NCtjYWhVSTFkT29lZldHeElGd2t6dVBmMVVXUjRHVkNleUJ0QXdkZHR1dlFn?=
 =?utf-8?B?UTRuOE9tazFiajNaOUE3ZkFTZXc1b0pRZXhwRXNLOFJGb0QwOFRNaFFHdzly?=
 =?utf-8?B?ald5N0pEdzZqbk1UWnBzdkFUUisyZVdmTVVHUXZMOVFLQnNMcVg2WWlLc3dR?=
 =?utf-8?B?ZjNtSm5lMEErSHJSYjBmRlN5cGNURGtMWkIzcUgxb1c2TFZXVmZ2QktNL3Ns?=
 =?utf-8?B?K0phd1RzNEJLRXVCdnhjQWFGVlk2OS8vVElLRHVJaXREU0pWZ2ZOUFF4WkZ1?=
 =?utf-8?B?QTAvNTBDZ0RkbFUwQzRnWnpXQjlLNmdKL2VNbURNTWtqYjhjNG9iQ2YvdFNP?=
 =?utf-8?B?QmtBaUZuQ2RJbmdpZDVMNmI4Ym1DbkVaWWdBa2pOb242YStzY1g2VzBRdFIy?=
 =?utf-8?B?S1VTRXFUTVdMeUJzNkpQSWp3MVd4YUFtcHg5bzhKUklFVUNSUXRtRyszdTV3?=
 =?utf-8?B?aHFoN1JYd2pxeGxuQU9OTDRJK0ZaNlBuVWl6NElZdHN1VUE3TEZ6dDYxMS9Q?=
 =?utf-8?B?UGZPRjlZdnhwWUZKbEJvNnNWNDMrUTZTSG4wbCtxbkV2VDNkNkFPb0VFMjkw?=
 =?utf-8?B?aGNpSDZwcUxCTVVSMHgxd3pNb1JwTkVoQXJoZEYvZlRuSG5ubnBNZDRnWEFx?=
 =?utf-8?B?dG04NUlWbjh3MDlZUnQzVFZOV0EvUndpMHVKQzVBMFVxVFhXWU83TForOW5B?=
 =?utf-8?B?MENySHFaUmhFWUwxbG5UN3A0MU9GSnAzeHZKSUQzYS9yODFaV2g5TXB0aFRa?=
 =?utf-8?B?NVIyQW9WYmgrRENRSGFXV0F4V3NPUmxZYVpxdGkvY2E5eFZuQjRKQ0pxV2FY?=
 =?utf-8?B?cmJXelNKcVdYU2lIMVR5NVMxUHNJK09jMEgvcHkyWVZ5T1VPWGEwUElnYXo3?=
 =?utf-8?B?MU85MUErWmY0V3kxZDRsV1B5a05HWnVaS3Y5SnE4SnY2Mkc1bmxQblJjakFS?=
 =?utf-8?B?Y2NubnFDSXNCdyt0ZXhyWG5YNDRMMExlRW1jbnBrMXhlKzBDc0dxUWs0VWI0?=
 =?utf-8?B?OUZ6UGVSSCt5M0FXY25DTE5oc2dmMWE3Ujd3RFpxOThraWZVQUpyTHErRjJ6?=
 =?utf-8?B?U1o1a1VvazZpRWRLZTZGTnlOM0MvMUcrbFN1cWxvY21HOCtPRnlIT2xhSWRN?=
 =?utf-8?B?ZFQ3Q0I2bWZsVC8vcFM1SlNnd3VxNGhWZnBCMTVUVjRzb0Y1a0M1RC9MY3c0?=
 =?utf-8?B?aUxGaHljUWUvZ1BHU0ZWSFBYWG9YSG1oeFpKcG84NjIxbkNvQ2gyVWJpK3Vk?=
 =?utf-8?B?L1NwSWhFK0laUi93NFBVQi9jZHFBKzRzMkpraWh5SzM2YjJscjJTRXducU1y?=
 =?utf-8?B?S0g1TitPSysveGcyWllab0VmVlh4Q25yMThvQnljRjhBSERUU1NRZWh4OWpM?=
 =?utf-8?B?Ynp5REVJbUlJZVQwa0hld2VYZlhxY2NtZEM4U1VDNFNVMHc1TGNPWUxWRjF0?=
 =?utf-8?B?Yk1lTVd5cG9nTUpZRGV3YmR5akJvdHhOM21lcWdaS2JsMHZhS2dnNVFkMjZZ?=
 =?utf-8?B?NXJvQlZPcGhScHYvSW9aTEFyV2JHRXpuZjJ4ejNyWU0ra2pReURhSWZzNUpF?=
 =?utf-8?B?U2YyWXR6TjliQnNSRm8zckVndWpsd1F1c3IzSWhMSDd2aTMyZm5KNGVUd0Jm?=
 =?utf-8?B?bEhIclk3VTdIOEM2alJDR3ZOb0podkJVTm01Y211cllsNHZzUkpVQ0lBOFFO?=
 =?utf-8?B?Ly82TDl1akczeGticDhVcE85L2VUd3lmZnhnOVl0STRHeUtuZUVaS3JleW9l?=
 =?utf-8?B?UzhGaThUS3FicEI2MldaVWMxSC8yRXJqVHQ2NGFsTG9VblZROWg2ZzJ5MlNu?=
 =?utf-8?B?Nlh1T2tEczQ2dkRtR2tmcUk4cnpWVy9HSU0yZWcwMUtLSmdDTXE3anloczJ3?=
 =?utf-8?B?WjdsQ2s5SE9EWnpMdHRMc3V0ZlRhQ3FMUlZxVDdQUFE1Z01Vc3NzUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e57441-6f8a-48f1-db21-08da32a0bd56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 16:18:38.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1ZmqvLHTIrY7s3yc61XDnaEyICWqU6YphGerHmHAmWIiomtrh8dXO+9WFQFumqThFQeWivWwlR9cOXmJnhulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_04:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100071
X-Proofpoint-GUID: VO_hO3bpv_Y8zNHRxvXP-nnW_CotslvU
X-Proofpoint-ORIG-GUID: VO_hO3bpv_Y8zNHRxvXP-nnW_CotslvU
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 4:27 AM, Eli Cohen wrote:
> In vdpa_nl_cmd_dev_get_doit(), if the call to genlmsg_reply() fails we
> must not call nlmsg_free() since this is done inside genlmsg_reply().
>
> Fix it.
>
> Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/vdpa.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..fac89a0d8178 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -756,14 +756,19 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto mdev_err;
>   	}
>   	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> -	if (!err)
> -		err = genlmsg_reply(msg, info);
> +	if (err)
> +		goto mdev_err;
> +
> +	err = genlmsg_reply(msg, info);
> +	put_device(dev);
> +	mutex_unlock(&vdpa_dev_mutex);
> +	return err;
> +
>   mdev_err:
>   	put_device(dev);
>   err:
>   	mutex_unlock(&vdpa_dev_mutex);
> -	if (err)
> -		nlmsg_free(msg);
> +	nlmsg_free(msg);
>   	return err;
>   }
>   

