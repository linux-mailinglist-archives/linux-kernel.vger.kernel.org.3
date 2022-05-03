Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D42518CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiECS63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiECS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:58:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054E3CFEE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:54:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Nnl4N025194;
        Tue, 3 May 2022 00:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NF11mrs4SJe+N/BII3rrquFE4xqHCDrybufPlRQxC0w=;
 b=cMW0YeycEBxQaUUoiueKRO5OCphG66alSLZmv8YQoz0/qZsIVdZZjWx5E3YlyzKko49S
 G5nbvxYBsCLvdbvKZMyK3VuW4RXRfECVBh37wudRhps4NDjTqt1zJNBW6prcBaWG0ujk
 cmcSAdGDQgTHKtSms42Vis9/HBxl3UAfKga0oec4peLHoJfuq5vdbZTSl07LsH/2c40n
 genBArwBfM043XzpNwF6+OBOO44YCCYZBDlol+Ydv4VdUNjeYIdfRUwxfLiwiwDlYiIl
 16+ke/84ovKt9zCZHnr6v6aEc3bLeyErPYJTbICAVz69MmV+zukUV9YQJ7r1RVJFLr+a Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2cnhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:36:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430Up4v002704;
        Tue, 3 May 2022 00:36:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83q00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOcKMTB8LkOEXdVuFHJiHNNubHCd1m2z4lWg40QNgTojJbZHUAtDTFCGNHRbzATVNqKJObhcrffL/o43j5DWHEDm+0pvjHcDMJavczwNPcYhiYe5EmFXfJeDr3I6/Fg69FMVSHVKdo/pl5dSFaQ4kzejKe33EnUsSGUB1PN2WadwnoNV6ROJJPmV9IBfnNbRAdvRJvJpELpT6tuZqji5WciEHEtyWHY60+8oUXT5eN8mTCKk9tgQV2rR6FORmlmaYiecGjUuEIiKFI16hAw0Mhs4CA6EEYLJ3OL97vgUX9Ov2FcHNj3cRMoC0UIn3E6eOFIdfvjgrFUtqLfAcRXz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF11mrs4SJe+N/BII3rrquFE4xqHCDrybufPlRQxC0w=;
 b=ZcDrgx2gM3WLOa3CPJhoWeNlrPfm5Cpo6+es/9n4G2rGofQ4lWdNCr42rsvPpyU5ua7YT3O45byvHOPFeUamG329MsbDTtrY70DA0jtGzvComvkluy/KGue/IwCNtfELrTT9lPkRvBotCosFsTWyb288TKoCYdnbs3H6hQQrYrVE/z7AIRMf+WYUYJQB92FS7dg6Jehbv8onK/sS9hlqiPxmAPfWh1tNcnbwWv1WvdY4tncWQFGsm0lxmrrvifxcj/PXQLsG/yzlPKlaRodHN3Za31xkDriZYndKQ9SBLZj2ZELAracvY9AzZExXAkOpcr/TN14tHWwpW9SwUlzKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF11mrs4SJe+N/BII3rrquFE4xqHCDrybufPlRQxC0w=;
 b=enumGNLkf143FqELorhqAIojJHQgClbdWtjyy4sXI/Z/0q9KAsbI/USiOnUfJ/zSV6zUf+ayCGOIho7YqjRJI5nyljuP2WinpeholeyTnwFS/zhf2A6I/987xCG3VbNxgSNyrgIveeFwRYj25mEHVfXKaXZyXxsVL1kl77WUSgE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5245.namprd10.prod.outlook.com (2603:10b6:5:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 00:36:21 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 00:36:21 +0000
Message-ID: <fdef13b9-74e4-e578-482e-b9632c9f582c@oracle.com>
Date:   Mon, 2 May 2022 17:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
Content-Language: en-US
To:     mst@redhat.com, jasowang@redhat.com, Eli Cohen <elic@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-3-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220502102201.190357-3-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 508ef772-6588-454e-2846-08da2c9cf189
X-MS-TrafficTypeDiagnostic: DS7PR10MB5245:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5245F6FC41E159C4B3D2C08BB1C09@DS7PR10MB5245.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MLY69dWo1y7r9HlHg7EknOPovJD41VIwwPXqjlR12o//d+xBby8Uhm0PpHUrW9+erWRF7kwy3JiTHPg2lRO0+43gdTp801ias3Dj4jmt9lsHTxOSwDcKbQztHsumF/P7OxycCnOJWb882Zih6xrCJ5tbtgJ5+Xus+JIakgxCGykQiMZQPh/1Sd5hXsTq4rEn4NdXW6ScUp+1cDkGyHaojl+9Nh3yQM1muQBSjIUhLGIEWU39H8tfDhsjkV0Hk/U6VKrlccLQOT68gznw/DOzD2xK+CjQ8E6c6xOi9CKK683U7BR+fJTp3hvdLjwngsjmjPGo3gB8T6x8EB4zzWUgzRJ8UPWsUny3tMrP6Z4XYC/VP8hWu2Czk1i/pqVSOZu8S0/7zTpC3k/5O23uLYfkIdqpLm7hPQUYc5rOmM6S6D3t7YP8E31rCGOkr0zL6GDnul89erlO0TaV3kzC3I2qSKmdf39AHujlNPQH3OhpvTiLEn8rkpeNo3UV0O4aitZZetUJ+Y24WfIkCR74Rb9uuJeS1PBZo0AVXG4b5b9YZAgGlTeuhxLoGUa8o1L/CBFjJZ1JgyBz+kq6TP2+9shj0Kz4OgUNPgODnq717jilTVHTjPt7DyuEozNiFWb+pq5IUGXEecPNZSir8GifU2qMIpJwuBGj4JHEKK5tV//3okTqjQQk+hsZZBvsxUnZ1YfiYIMyV9WPBEUIexFI4n64IBQWYoI8umVotb5d2w8DItuZHeu/Bpr9Ybkt5UA0+Cq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(66476007)(66556008)(8676002)(4326008)(316002)(186003)(6512007)(26005)(31686004)(53546011)(6506007)(2616005)(6916009)(6486002)(31696002)(36916002)(86362001)(6666004)(5660300002)(8936002)(508600001)(38100700002)(83380400001)(2906002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRFNU8yVVJLZ2JmaWcyMHRKbnZrRkFnclJVTlh6aVJDWDBROXA5R01qRWky?=
 =?utf-8?B?S2pjSXJVL2JaYjFDa1RsdXc3bzBtTy91MHpJaW5DV1RrQ0FpMHEwSVBFSGQ0?=
 =?utf-8?B?MkRWcHNVcFdqSDhHYnErUys3Z3dqMzFHcTRkVWZGTzlPdjg1MFl1L1RVTUZL?=
 =?utf-8?B?NjYwanJIWTR3MEJaUlZvR1VhZDF5V29IcXFhQlRnRjdPTjg4RytNYjh2Y3Q1?=
 =?utf-8?B?SVZQK0QyS0JueTNWM2NSSW9peVhBL1F3UkxLazl4SkhyUnB5RUJ4VEpTMTR4?=
 =?utf-8?B?UmhoNWZyT2JRNkRLNHY0UGVCa0llZlBmdjFDR1VRVnE1WjhuVjlscGhRck95?=
 =?utf-8?B?UUNYcGNwZFY4QkpmajZMVjk4Tm5ZWk9pVS9IbVAvWSs5eDJCWjlFYStqb293?=
 =?utf-8?B?UDJsdUxUOUtlNDlNeHRKRWpFMHpWZXMxdUxDMGZySEcrdkNaZ2s2U2F0aHpu?=
 =?utf-8?B?Uno4VEhJdlBWVkhCS25MS0VXWjdFNnZ1RnhEcitkWDdXNFp4emwxMG10djFW?=
 =?utf-8?B?N1Z2SC9DaWVJbXBSS01lY0xGQXVla2lkaDViOVRJcGZ6RUNNVU9wcUlUalVP?=
 =?utf-8?B?dW85blR1S01hcHk2cFpRUElpcDIwL2dKYnlqbDZNUHQ0OXVja0ZIY05iS0U1?=
 =?utf-8?B?OUw2amFURzhSYXkzUE5jYWpRSXZuTi80Ykh5NFpOUHZvOVA0eFBNUm12Wnpa?=
 =?utf-8?B?N04wQ1NnbWUyMUxac3RqMnZWTDlNRjkzYUMwNjZrdGloY3ZDWjBRak5uOWZ0?=
 =?utf-8?B?QlNHT3prVVlCY2NwcTMreGVmYnpLdzdhQS9JSHpueVU5TUIvWWlqY2FsNEJj?=
 =?utf-8?B?empCL0p6N0tNUm05TDkzbXZmM0RPeVJ4VWRMZlRzelhJM29rcFZBNlhhZlR3?=
 =?utf-8?B?MjF0Zm9LNFY1aDFGL1Vsazlzc3hRNEgvM3JuVnVFMHdZdVRJUVJaSkZBYisw?=
 =?utf-8?B?dXY0Lzh5dkwxOWpjRkN6SDhWamozK2NRWHpsTTQzU3Jma0NWUTNYeW1pZVNt?=
 =?utf-8?B?Z2VjR2xubzUxYjlGNWk5dko4MTh3ZEN1cXVnNVlpWkdPSmtMM3IxMFo4TUxB?=
 =?utf-8?B?MW11TGNBY1liOVNWOHllYnV5d0thNzNGeFhmWEw4dEIwMVdPMFZEZ2U4TnEz?=
 =?utf-8?B?NjBOL05MMkpoa2hZeFRQaEVYcFhYOGNNVUIzeitpZ0hTbDNpM1crdHc3a2xk?=
 =?utf-8?B?ZnhJV3pzRmkwTFU2cmlSckdmdWhSMzI1MlFEMVJwNTNMYzIrbTBRMCtmNTdG?=
 =?utf-8?B?U3ZtNkFaSVJpdVgxUVVlb212MllCOHlreDFBUGFWaFM3aHM3akhUR2lKV2dB?=
 =?utf-8?B?V2tTRjhuZllud3J3S3U5aEZocElsZU9CRlRMNEJKZys5Uk85OTlHcVZnNTRC?=
 =?utf-8?B?aU5oV3BYQk1Va0FZaXp2bjNJZUJKUmhhMU1sMW1tTk9yRVV2NDg3TXpjRERY?=
 =?utf-8?B?VlNzNlRMM2xFRk5uZTVtRTRnUU5rMUtyaDNmNUVHS0grRlUvZThNZHRSeXZu?=
 =?utf-8?B?cU5pd2t0K0RRdDUrU2lsM3pwNGhCZDBWdktWbE1Ra3B1TWwwVlhKTnlnaWtk?=
 =?utf-8?B?YlI5cUcvNnMyeDh0YlVFOEZsS2RtS0hOdyt3bTV3NTFqUGpVQzFKelRMMm9q?=
 =?utf-8?B?ZVZSMThYM25hT0w5bURleTgwYmtTVldocGgzVktyUlNqWHJNeHFNUE1HQml3?=
 =?utf-8?B?TkVqalNjN2JTUjJHVkNORlhXaHRCcks3OVFxbzROazg4aWRqd2gvRTE2ZTdI?=
 =?utf-8?B?bE9rRy8wYVltSWtzTmJDdkExOE5ZRXlkQjFYeWx2YTZMeGNyRkV0TEVjUysz?=
 =?utf-8?B?VDJ3TVhFai9iSEVYdi9aaVkrNGt2WkJWbUNmang4RlIwQkMyajJlZ21JUC94?=
 =?utf-8?B?TXRoWEFacEhxOXUwR01zZnRBdnpramZHdFJiZ1JyRU1aQnM2bDMySFArV0JD?=
 =?utf-8?B?YmxyUlAxcFFidXpXM0JZVUZsVGo4Y3Iva2p5TlZVSG9xQjUxTXNtYng4VElT?=
 =?utf-8?B?czg2ekVWUjd1UndoVUZTTFVRZDBlMjVtV0hRNVZ4SGpBSkhEczRjTE50QlFN?=
 =?utf-8?B?NjBEVDlsU1VySU41QW9tS2xFdkpUSjZOYUUrdU1ZalFHZU5nT0RnM1VOa1F2?=
 =?utf-8?B?OEZ0d0VMZ1VIbVpuZ1cwbnhERkU1S2VuOXhnZW9FM1RTblR6WnV0Qk5tOEh3?=
 =?utf-8?B?dVhEeXd3dm9IUHE0eE1ZeXZiNDdSZUtuRXNEZitpMW1FT0FtTWpXRTJ0djhL?=
 =?utf-8?B?dUtsc2dicllGaElRTi9ER3FhUkdzSGNJc3ZTTy9lTTA4ZHVnUXhKYldTQmtY?=
 =?utf-8?B?TC92Y3RHemtKOGUxZXhLWDQxSzloeS9CeW9YQ3RVRjk2cHJ5bXhGMW5CUmE2?=
 =?utf-8?Q?lHYc0+RtXBm2n79E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508ef772-6588-454e-2846-08da2c9cf189
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:36:21.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7lHCC8sGcOLNjkmcjPSIP8Od74sLP7N4JXn1oOea0zA7KEaaE1OyrwCfbF6bi6iuihWYI+WpmQweI7h+DI+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5245
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_08:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205030002
X-Proofpoint-GUID: HrvTWckAd-GfWr_r5kD6DwDytbQQw_oL
X-Proofpoint-ORIG-GUID: HrvTWckAd-GfWr_r5kD6DwDytbQQw_oL
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2022 3:22 AM, Eli Cohen wrote:
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
>
> v2 -> v3:
> Fix sparse warning
> ---
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
> index 79001301b383..473ec481813c 100644
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
> @@ -164,6 +165,8 @@ struct mlx5_vdpa_net {
>   	struct notifier_block nb;
>   	struct vdpa_callback config_cb;
>   	struct mlx5_vdpa_wq_ent cvq_ent;
> +	/* sync access to virtqueues statistics */
> +	struct mutex numq_lock;
>   };
>   
>   static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -822,6 +825,12 @@ static u16 get_features_12_3(u64 features)
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
> @@ -876,6 +885,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>   	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> +	if (counters_supported(&ndev->mvdev))
> +		MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
>   
>   	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>   	if (err)
> @@ -1139,6 +1150,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
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
> @@ -1166,6 +1218,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   	if (err)
>   		goto err_connect;
>   
> +	err = counter_set_alloc(ndev, mvq);
> +	if (err)
> +		goto err_counter;
> +
The setup_vq() can be called from change_num_qps() to recreate vq stat 
counters with zero value when changing (increasing) the number of 
queues. See below.
>   	err = create_virtqueue(ndev, mvq);
>   	if (err)
>   		goto err_connect;
> @@ -1183,6 +1239,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   	return 0;
>   
>   err_connect:
> +	counter_set_dealloc(ndev, mvq);
> +err_counter:
>   	qp_destroy(ndev, &mvq->vqqp);
>   err_vqqp:
>   	qp_destroy(ndev, &mvq->fwqp);
> @@ -1227,6 +1285,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>   
>   	suspend_vq(ndev, mvq);
>   	destroy_virtqueue(ndev, mvq);
> +	counter_set_dealloc(ndev, mvq);
Likewise, teardown_vq() can be called from change_num_qps() to destroy 
vq stat counters when changing (decreasing) the number of queues.

This is not ideal, at least from usability point of view it's quite 
confusing for e.g. if guest user changes the queue number via ethtool 
from 8 to 4 then back to 8, the vq stat on, say queue #6, will not 
persist. Perhaps here it needs some clarifications in the VirtIO spec 
about what should be the expected behavior for these cases:

- if queue number changes without going through a device reset, should 
any device side stat count reset to zero?
- if an individual vq gets reset but the device does not, should device 
side stat counter for the vq reset to zero?

Anyway, the above could be good enhancement with future patches. Given that,

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>


>   	qp_destroy(ndev, &mvq->vqqp);
>   	qp_destroy(ndev, &mvq->fwqp);
>   	cq_destroy(ndev, mvq->index);
> @@ -1633,8 +1692,10 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   			break;
>   		}
>   
> +		mutex_lock(&ndev->numq_lock);
>   		if (!change_num_qps(mvdev, newqps))
>   			status = VIRTIO_NET_OK;
> +		mutex_unlock(&ndev->numq_lock);
>   
>   		break;
>   	default:
> @@ -1681,6 +1742,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   		if (read != sizeof(ctrl))
>   			break;
>   
> +		cvq->received_desc++;
>   		switch (ctrl.class) {
>   		case VIRTIO_NET_CTRL_MAC:
>   			status = handle_ctrl_mac(mvdev, ctrl.cmd);
> @@ -1704,6 +1766,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   		if (vringh_need_notify_iotlb(&cvq->vring))
>   			vringh_notify(&cvq->vring);
>   
> +		cvq->completed_desc++;
>   		queue_work(mvdev->wq, &wqent->work);
>   		break;
>   	}
> @@ -2323,6 +2386,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
>   	ndev->cur_num_vqs = 0;
> +	ndev->mvdev.cvq.received_desc = 0;
> +	ndev->mvdev.cvq.completed_desc = 0;
>   	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
> @@ -2401,6 +2466,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
> +	mutex_destroy(&ndev->numq_lock);
>   	mutex_destroy(&ndev->reslock);
>   	kfree(ndev->event_cbs);
>   	kfree(ndev->vqs);
> @@ -2442,6 +2508,102 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
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
> +	mutex_lock(&ndev->numq_lock);
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
> +	mutex_unlock(&ndev->numq_lock);
> +	return err;
> +}
> +
>   static const struct vdpa_config_ops mlx5_vdpa_ops = {
>   	.set_vq_address = mlx5_vdpa_set_vq_address,
>   	.set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2451,6 +2613,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>   	.get_vq_ready = mlx5_vdpa_get_vq_ready,
>   	.set_vq_state = mlx5_vdpa_set_vq_state,
>   	.get_vq_state = mlx5_vdpa_get_vq_state,
> +	.get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
>   	.get_vq_notification = mlx5_get_vq_notification,
>   	.get_vq_irq = mlx5_get_vq_irq,
>   	.get_vq_align = mlx5_vdpa_get_vq_align,
> @@ -2706,6 +2869,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   
>   	init_mvqs(ndev);
>   	mutex_init(&ndev->reslock);
> +	mutex_init(&ndev->numq_lock);
>   	config = &ndev->config;
>   
>   	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> @@ -2788,6 +2952,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	if (!is_zero_ether_addr(config->mac))
>   		mlx5_mpfs_del_mac(pfmdev, config->mac);
>   err_mtu:
> +	mutex_destroy(&ndev->numq_lock);
>   	mutex_destroy(&ndev->reslock);
>   err_alloc:
>   	put_device(&mvdev->vdev.dev);
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

