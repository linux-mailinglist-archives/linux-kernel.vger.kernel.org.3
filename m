Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A29523B77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiEKR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbiEKR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:26:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408301D0E8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:26:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BH3osm010445;
        Wed, 11 May 2022 17:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VhpiXzgoExJHoMXufXpjJwWYxLIHN1bOkMjL5hBoE74=;
 b=xGd/zNSGuhRYCAOHZR2BAkK//BuRnFOIxPOm5L7tQk7vcUl56G4Mi79kiJHDMe6IRuIj
 xRPwfvyEB3wUfbhhv5WgyY+UYFmYkn2jJ2IO57kPLKfvefRpYGSGGRmxxRW+Zrm5An7i
 /QsVI2j0bKDsGU9v/+iEONzhaYJFGub60q4YqP5KTsKJRF9dKzje7x1ZPBGCmZfXF7eE
 kQccLdDqFQQtUoe3n/vo3JTuLfR2coHMbEQSbrTcGl8sdVQHk2wKPoQQprse2xJ6kRsi
 Ap8hV6yNOs2XhYzHLZRWIrN2geeLoL7OJrw9Sxi5kWIh7wsvVZSrgU9O6gN8Pdhh5rYE zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6ca8xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:26:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BH5VRB011988;
        Wed, 11 May 2022 17:26:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73vwpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW+ER1Em/JaE56S8AoFccowLwgweBPnsd93quNGQhFekpkAlhZv6ZB2UuWFvmWPBC7rhnvJC/Q6HobBh3IOg5Uqi0dgkCvx4WkZ2G+MyZFQq3Gx/QoFDJtDlPo+545BeaJJyPOWfb+foaUpmmVIj5O2gbfIkXQYd9dti77ieO+ciSmSMxCEf5/27N27Gc+w3J1Eq1gLbMlZIb44sBKJtTRdPH7j40tFdwHaGX4/8AufPKXuXMvthO1R+O3IO2S6pDVcEk1I03XQGS25RVMnuBseMGK4/eBA8ESXs8hIfu5GqiBKzSxdLjQ6A9LlPD/ntP9Rk7wFNXaFvGIWmNei6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhpiXzgoExJHoMXufXpjJwWYxLIHN1bOkMjL5hBoE74=;
 b=LHLdi9x6JIRNCuPu9N9zvJLs5/N/w3DHQI+JYyZfTdZ+gr8zCznPf1YUt8Cl0odjOTvXfGPRv0jDujkN1hvB1X9u91B2XMZzOIl21oOAo7L1EQrVmTm7QIP/0tQrgkz25HZnUYitymwyG7qdbGEg1Ut/4Nqrz0ceAfIGOSqdQ1NfyC80gNQDjLk4F7FM7DUoT/b3kF4mK4dU0XWTAx2f1dEL0ZEtf87Shnpo/10Q0ynK/Pn62Z4ETGMLgMunFRkib5wFNQ1IDFMtF9U3ibAXgBYAhSHD/vMPDasU5Y4jY4vActiUu83XPxTGDumWuuJdMfGVWmPF3+WNhxgLMdCUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhpiXzgoExJHoMXufXpjJwWYxLIHN1bOkMjL5hBoE74=;
 b=ZaokFfDm2FI9BF2kIUxC8hojSveofYee9s522nzFo22Dkb0FJ5OGUrHQ6Vbq2s2Ao1p7tRscLkOh6Krp/957X++HPn0T/aOhbDKYgIvtUqysxWJQQKgWGdLiDS2ZrsufdaY+Bfj12OqWYdBK1RSgzoY/jhcc3/i7kHd4Shwrs5U=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3272.namprd10.prod.outlook.com (2603:10b6:a03:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 17:26:03 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 17:26:03 +0000
Message-ID: <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
Date:   Wed, 11 May 2022 10:25:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-4-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220510112734.205669-4-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4484b372-a8c1-4ff9-e212-08da337352ac
X-MS-TrafficTypeDiagnostic: BYAPR10MB3272:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB32720E8AF3153E68E8352E0CB1C89@BYAPR10MB3272.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihAEpDXsAm83O/q8QiP8vll9L7keiZlhrTCSXMs+D+PFWuyfpa4tYYPrzv6MzNes1rg0s0nl+fWmk7Ean9hVhPgJOuBn+3ZvpeZFv6t3OOFhUFRkCEzPz1dOPTF1cnKIdSLGyiQWXaq6GwovQQ88BtTrdseht94pXLGz/aP01CADuIlmuc0hES7h0ymMm407hghSZoFefpiBLL4HN229uDcWKjU3z2SAxM3G/vdoWabM+UQzPWccg1r9/ll5MUZ/BWmaAwvkiu7UmcHlu+n8nzQGKPsENJ90V/gRBF5/DP4dUICEOhoFbFm4v5knd7YR/XxNBjdL13jpm8MPXMxUPGzm/UrA69DAJxfGEfsCJEkufDQ+Vc9ePMq6Ys9jN8+hRPx3PJpKWFuUcgtCOOTEsrjgJU/uFs9XtMvRtxS5Q3bmruTsKphoeKeraGkQXDbx1jumXBm6W1ZjpN3ZibbP3aJFSMLn6Qo2HQ2JYNSPo7lyWQdc1j07BAD3GQk7HIpVasbKYe3sIKPo08wJtmyoGRvjFeaJ0sptT5pdx8BMV2SW+JySKJFwkMT4qWoQ2VyZEMlk2abOjFjvqheQLO6S7Ec6YGkgrwUQarE/owrf7cp6/rH/pZVkWlBGvFWH51OuvbwNQeTJgKXdt3umAChSWNF+w95cYbd7Z1I+41Ts7tHcagxUddFaf30m16qY8IT+lqk+POK3/tfTtcqyA65gvDchnkoPovgIhl04RTb/S0QOZ4mFzz8QDQT+0nV5bx25
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(8936002)(2616005)(186003)(66476007)(66946007)(4326008)(66556008)(31686004)(30864003)(8676002)(5660300002)(36756003)(2906002)(316002)(86362001)(36916002)(508600001)(6506007)(31696002)(38100700002)(6666004)(6486002)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldBRjNFd0VzK2Y5bWtPeUxqN1JVU0wrV0dKQzkyUEN3YUZmcmFPMXdudmFO?=
 =?utf-8?B?ZjV2NjQ5Z1c3RThpcVZ1S0Rqb3h1U2dnbVlranZSVzBoUytqNDZ1UG8yTXM2?=
 =?utf-8?B?U3preW5Va1JKeW1XanJVSm1pdWRncVV1eW9VbTRlWGdRRW1xT0V4a2pwaXFs?=
 =?utf-8?B?WXJaUHkvbS8rTXhISjk5VThyejBvY3RxaU1uOXRycTE4TStNSzA2cGVJa293?=
 =?utf-8?B?Ykx5cEUwaGtPblJYT1A1QnNFb3Q1OVlhdjNvZDVUbDlnR2NJLy9lVFR2bnV0?=
 =?utf-8?B?VE5LS3hWN0lZeUIxc1FSQXJGdzE2dFhKSjVzNDdxZ1JLUWtFc3Bud2VQYy9U?=
 =?utf-8?B?M2V6Ukh6Vnlya09lc1VHZDJ0WmRvbVJ4OHY0ZEtmckRpZFBqeWNKVWttZm9E?=
 =?utf-8?B?TVlwYTAwYU1QSU9Ld3FvWHArdUQzYnJQY0hWOCtvT1JIRDhDVERvWmZSQnpI?=
 =?utf-8?B?cDk0NFRqY1RnVFEzZWNaWU5jRjIrUkcwck80a0drVkJsdWVtODZ1MUlFc3Rh?=
 =?utf-8?B?eDlXcmYrVGw5NzZYNmNtTy9XczM4SzBGWXI4dkhaZ0V0U2x0dkt5RWVuNlJ2?=
 =?utf-8?B?ZFFYTFpVcUJuMFVMSEFLQWRTVTdoM3phTHZtamp4Ni9tRkF0R3c4ZitpTEd5?=
 =?utf-8?B?LzlWdnE5RWhldlR4YUdPTis4RjJ5bU5EbkFzdmlhUDBnQkNlRlgzR2krN2c1?=
 =?utf-8?B?WFN6clhTb0xoK3VKZXQvSHVvSUNVb29vYmIyMEhhWXgzSDVWZVpuSnV0bW91?=
 =?utf-8?B?cFdFemNLWTN2dWhGZHdUalZrSGdJSHFuUXdzT0cyOWQ0VVdQaFBxNGd2TDZ1?=
 =?utf-8?B?YXNMK0xhc3lKOWJ3WWY3ZG0rYVFzbnVlYkZ6ME5wZGd3WWFmdk1FWE9PN1lw?=
 =?utf-8?B?VnduYUR1NTM0aDk3MnZGMG1VemZyWjNQeGFSWkJhMHltTUV0M01JL05MaVdu?=
 =?utf-8?B?TGlXN2pJRXlQOGlIZGhTTkErekExQjJGaUtvWlZZT2NqdW9WWml4TjlGb3Zi?=
 =?utf-8?B?bTdidy9UUm5sZHhlRzB2UFVoeVhxSlVxdGI4Q0d4QzZrRDJxMjVKMkxzVHFl?=
 =?utf-8?B?Z3A1a20rQTRpZkdnckpXdGlSVERmY0NjaWtoTkhNTjMycEhhWGJpV2VJNlNJ?=
 =?utf-8?B?aGxCU1RNdGhRUFJXc3JvdWN3MlZ5KzZxZ0pYM3ZabGVvRnhEOUZ0TjBDTk9h?=
 =?utf-8?B?QVFtNWJSWjZzQjdFZWpmdUE2MGM1aHVnbTEwdWl2NzMzam9GREdoZXVsMWJI?=
 =?utf-8?B?Z1VDSWNjZ2U1cytpV0xIL3ZHclJ5bFRWcjhlTjlrTldQMzVKSEVBU1B6YmRa?=
 =?utf-8?B?NHZ5S0hEdmdGV1ZVamtjeW9uamt5cWtNZ0E0SEpnTE9YU25XaCs4WGpGWS9S?=
 =?utf-8?B?cW1DZTdueTNNMXlnUlZPaXU5dkdHaXM3Ny93S1NFc0s5QStVbWx0QUl2QnNH?=
 =?utf-8?B?MEJIaVJVODROV1ozWVJkbHdlYjlzcHdSUFpHSUEyZmhDRGczSFl3czU4d0VI?=
 =?utf-8?B?bUFuK3ZzZDBTaXVxRllzY2FudDB0OHlYd1dvSjRpMFB0RjlrWHN5TTJGN0M4?=
 =?utf-8?B?S3BrOHlVQ3ZML3pmUnZ3Y3QvbVNLUU0vUFBnY1VrQzg3dTlzYmpSOEVzOTZz?=
 =?utf-8?B?cnI0TXRlOVhDV1RUWkRhZFYwQTF2MEgwS0VYNHprZU14UmVBUEI1TUxkN295?=
 =?utf-8?B?QTRJWHNtOER3bXhaZHZ2RUJGSXAwYXBQWFM3OW53cE9qV3hGQ2RYdVJucEF1?=
 =?utf-8?B?YkxOQVcrZUplVXRPREFjUVppd09GTzl4clFOcXJmOXg1T25sbVpNV1lPbERl?=
 =?utf-8?B?ODl4Q1Qzc0dvRSs3cURPeU91eExWOHRoaG1TV2FoMEJpRUZneUo5V0ZMelg0?=
 =?utf-8?B?YUgvQ0hVNGZjNHNhbUZxdEZ4SzFaaTZRWVErOHBNTFlrNURzYVVDYnE3dGow?=
 =?utf-8?B?NW5ESmlZanloS01BVFd6OEcxRFErRnF5RU0xMW9MMHVYRVgwRXR3QVd2dXpL?=
 =?utf-8?B?Nm5wMWpiOGZzbStzQWZ5ZitaaUVVMzFWTG95QnY5VTN3aWZ0NXlndWdpM3Rq?=
 =?utf-8?B?Q1hyaE9rNHlMblVBQVJtb1VXQWJMMUZDMXplNUN2aHZ3Kys4ZjB5V0VIREtP?=
 =?utf-8?B?cDV4Y3lxbE1SWXRxZHczaktvZ1RTVVJVS2UvRmdDb25DNXQ3WjJHc0lXeUxX?=
 =?utf-8?B?WGtvSkZOdmpKNkZHTTN6ZzZjbFNCc1dHcGlLS0I5SlArRE45RlRhY0xTUHk4?=
 =?utf-8?B?bGhwbzRNek45Tk9LWkJaVmk4UUM0OEdrSnpVRCtuY3hyV2FqTitYSC9QcjNO?=
 =?utf-8?B?V2txVjltZHVtcjliUG9maGYwNDlqcnNVVnl3VStPSkhXTUE4cWhZaHJJVUxk?=
 =?utf-8?Q?BqkwA/WJ0J8/BwsU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484b372-a8c1-4ff9-e212-08da337352ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 17:26:03.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAm50Mn6Y2gvvxC/AKwToLnjHDX+DmboB7JAFhR5TMjKwGYAQrhRajfzslUgaKqNKd/XNA84YOR1SzMWalSsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110078
X-Proofpoint-ORIG-GUID: _VeKQpWKU-UhBVUKUV6jWNikSUtjcUaY
X-Proofpoint-GUID: _VeKQpWKU-UhBVUKUV6jWNikSUtjcUaY
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 4:27 AM, Eli Cohen wrote:
> Implement the get_vq_stats calback of vdpa_config_ops to return the
> statistics for a virtqueue.
>
> The statistics are provided as vendor specific statistics where the
> driver provides a pair of attribute name and attribute value.
>
> In addition to the attribute name/attribute value pair, the driver
> returns the negotiated features and max virtqueue pairs for userspace
> can decide for a given queue index whether it is a data or control
> virtqueue.
>
> Currently supported are received descriptors and completed descriptors.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v4 -> v5:
>   Remove numq_lock mutex. Use reslock instread.
>
>
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
>   include/linux/mlx5/mlx5_ifc.h      |   1 +
>   include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
>   4 files changed, 207 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index daaf7b503677..44104093163b 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -61,6 +61,8 @@ struct mlx5_control_vq {
>   	struct vringh_kiov riov;
>   	struct vringh_kiov wiov;
>   	unsigned short head;
> +	unsigned int received_desc;
> +	unsigned int completed_desc;
>   };
>   
>   struct mlx5_vdpa_wq_ent {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 79001301b383..99b0621e7a87 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>   	struct mlx5_vdpa_umem umem2;
>   	struct mlx5_vdpa_umem umem3;
>   
> +	u32 counter_set_id;
>   	bool initialized;
>   	int index;
>   	u32 virtq_id;
> @@ -164,6 +165,7 @@ struct mlx5_vdpa_net {
>   	struct notifier_block nb;
>   	struct vdpa_callback config_cb;
>   	struct mlx5_vdpa_wq_ent cvq_ent;
> +	/* sync access to virtqueues statistics */
Dangling code change?

>   };
>   
>   static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -822,6 +824,12 @@ static u16 get_features_12_3(u64 features)
>   	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
>   }
>   
> +static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
> +{
> +	return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
> +	       BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +}
> +
>   static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   {
>   	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> @@ -876,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>   	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> +	if (counters_supported(&ndev->mvdev))
> +		MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
>   
>   	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>   	if (err)
> @@ -1139,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	return err;
>   }
>   
> +static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
> +	u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
> +	void *cmd_hdr;
> +	int err;
> +
> +	if (!counters_supported(&ndev->mvdev))
> +		return 0;
> +
> +	cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
> +
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> +
> +	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> +	if (err)
> +		return err;
> +
> +	mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> +
> +	return 0;
> +}
> +
> +static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
> +	u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
> +
> +	if (!counters_supported(&ndev->mvdev))
> +		return;
> +
> +	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
> +	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
> +	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
> +	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +	if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
> +		mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
> +}
> +
>   static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   {
>   	u16 idx = mvq->index;
> @@ -1166,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   	if (err)
>   		goto err_connect;
>   
> +	err = counter_set_alloc(ndev, mvq);
> +	if (err)
> +		goto err_counter;
> +
>   	err = create_virtqueue(ndev, mvq);
>   	if (err)
>   		goto err_connect;
> @@ -1183,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   	return 0;
>   
>   err_connect:
> +	counter_set_dealloc(ndev, mvq);
> +err_counter:
>   	qp_destroy(ndev, &mvq->vqqp);
>   err_vqqp:
>   	qp_destroy(ndev, &mvq->fwqp);
> @@ -1227,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>   
>   	suspend_vq(ndev, mvq);
>   	destroy_virtqueue(ndev, mvq);
> +	counter_set_dealloc(ndev, mvq);
>   	qp_destroy(ndev, &mvq->vqqp);
>   	qp_destroy(ndev, &mvq->fwqp);
>   	cq_destroy(ndev, mvq->index);
> @@ -1681,6 +1739,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   		if (read != sizeof(ctrl))
>   			break;
>   
> +		cvq->received_desc++;
>   		switch (ctrl.class) {
>   		case VIRTIO_NET_CTRL_MAC:
>   			status = handle_ctrl_mac(mvdev, ctrl.cmd);
> @@ -1704,6 +1763,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   		if (vringh_need_notify_iotlb(&cvq->vring))
>   			vringh_notify(&cvq->vring);
>   
> +		cvq->completed_desc++;
>   		queue_work(mvdev->wq, &wqent->work);
>   		break;
>   	}
> @@ -2323,6 +2383,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
>   	ndev->cur_num_vqs = 0;
> +	ndev->mvdev.cvq.received_desc = 0;
> +	ndev->mvdev.cvq.completed_desc = 0;
>   	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
> @@ -2442,6 +2504,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
>   	return mvdev->actual_features;
>   }
>   
> +static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
> +			     u64 *received_desc, u64 *completed_desc)
> +{
> +	u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
> +	u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
> +	void *cmd_hdr;
> +	void *ctx;
> +	int err;
> +
> +	if (!counters_supported(&ndev->mvdev))
> +		return -EOPNOTSUPP;
> +
> +	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> +		return -EAGAIN;
> +
> +	cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
> +
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> +	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
> +
> +	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> +	if (err)
> +		return err;
> +
> +	ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
> +	*received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
> +	*completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
> +	return 0;
> +}
> +
> +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> +					 struct sk_buff *msg,
> +					 struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_vdpa_virtqueue *mvq;
> +	struct mlx5_control_vq *cvq;
> +	u64 received_desc;
> +	u64 completed_desc;
> +	int err = 0;
> +	u16 max_vqp;
> +
> +	mutex_lock(&ndev->reslock);
I wonder if we can change this lock to r/w semaphore too, otherwise it 
almost defeats the merit of converting vdpa_dev_mutex to the same. This 
change would benefit multiple parallel readers.
> +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> +		NL_SET_ERR_MSG_MOD(extack, "feature negotiation not complete");
> +		err = -EAGAIN;
> +		goto out_err;
> +	}
> +
> +	if (!is_index_valid(mvdev, idx)) {
> +		NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
> +		err = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	if (idx == ctrl_vq_idx(mvdev)) {
> +		cvq = &mvdev->cvq;
> +		received_desc = cvq->received_desc;
> +		completed_desc = cvq->completed_desc;
> +		goto out;
> +	}
> +
> +	mvq = &ndev->vqs[idx];
> +	err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
> +		goto out_err;
> +	}
> +
> +out:
> +	err = -EMSGSIZE;
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> +			      mvdev->actual_features, VDPA_ATTR_PAD))
> +		goto out_err;
> +
> +	max_vqp = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> +		goto out_err;
Your userspace reference patch doesn't actually use this attribute, but 
instead calls the VDPA_CMD_DEV_CONFIG_GET in prior to get this 
information, which will break consistency. Is it your plan to change the 
userspace code to accommodate what's already piggybacked here and 
display stat query in just one atomic call? Hope all the available attrs 
here would satisfy the userspace need.

Thanks,
-Siwei

> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
> +		goto out_err;
> +
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
> +			      VDPA_ATTR_PAD))
> +		goto out_err;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
> +		goto out_err;
> +
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
> +			      VDPA_ATTR_PAD))
> +		goto out_err;
> +
> +	err = 0;
> +out_err:
> +	mutex_unlock(&ndev->reslock);
> +	return err;
> +}
> +
>   static const struct vdpa_config_ops mlx5_vdpa_ops = {
>   	.set_vq_address = mlx5_vdpa_set_vq_address,
>   	.set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2451,6 +2615,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>   	.get_vq_ready = mlx5_vdpa_get_vq_ready,
>   	.set_vq_state = mlx5_vdpa_set_vq_state,
>   	.get_vq_state = mlx5_vdpa_get_vq_state,
> +	.get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
>   	.get_vq_notification = mlx5_get_vq_notification,
>   	.get_vq_irq = mlx5_get_vq_irq,
>   	.get_vq_align = mlx5_vdpa_get_vq_align,
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 49a48d7709ac..1d193d9b6029 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -94,6 +94,7 @@ enum {
>   enum {
>   	MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
>   	MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
> +	MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
>   	MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
>   	MLX5_OBJ_TYPE_MKEY = 0xff01,
>   	MLX5_OBJ_TYPE_QP = 0xff02,
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> index 1a9c9d94cb59..4414ed5b6ed2 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
>   	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
>   };
>   
> +struct mlx5_ifc_virtio_q_counters_bits {
> +	u8    modify_field_select[0x40];
> +	u8    reserved_at_40[0x40];
> +	u8    received_desc[0x40];
> +	u8    completed_desc[0x40];
> +	u8    error_cqes[0x20];
> +	u8    bad_desc_errors[0x20];
> +	u8    exceed_max_chain[0x20];
> +	u8    invalid_buffer[0x20];
> +	u8    reserved_at_180[0x280];
> +};
> +
> +struct mlx5_ifc_create_virtio_q_counters_in_bits {
> +	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +	struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> +};
> +
> +struct mlx5_ifc_create_virtio_q_counters_out_bits {
> +	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +	struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> +};
> +
> +struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
> +	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
> +	struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_query_virtio_q_counters_in_bits {
> +	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_query_virtio_q_counters_out_bits {
> +	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +	struct mlx5_ifc_virtio_q_counters_bits counters;
> +};
> +
>   #endif /* __MLX5_IFC_VDPA_H_ */

