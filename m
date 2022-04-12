Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCE4FE5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357569AbiDLQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbiDLQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:31:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E25D664
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:29:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CFf5Sq029074;
        Tue, 12 Apr 2022 16:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0xfQDPgDkiBwRs44lIQMSvAMZatLd7NdTaAj77cPD00=;
 b=iXxuVtvefV5kPIlx8GEkNpTr06ogVSJcqVoyzAKbInn7+8z7inLcd2/O38l3Q06SyvGh
 X0lrpZEoZLwIReNVqoRvpm8tpbH/nhh+96p+OWbO+uKNnO21BOrzU3Eay6jdsW+mE3pI
 bM6F3fvBQPfupdwAmHAX7QXkFwHb8xi0fojAfa4DC3r/8Iy0waKcJWjukSga247TrZi7
 biDy8WIuBSyjgUEnPzSkJrv5OnriahtQYVC8xVR2jr8pvXxnF3H84zDJfhEh4mj37ov4
 rN7X67GQ5Ed/ZEVwVx7yEZx6jVdMeqyBTG/j5X9nnlLdhEeQa7FNh86fMJx0vQe+4v5O UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs7dmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 16:29:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CGBLL4001422;
        Tue, 12 Apr 2022 16:29:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k3frgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 16:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZim1Y5VQW3DKSEbzQkQIFiwTfQ6oBQNfIz7ml2/85IHYlCb64Svi4+fNXwlWQY36YEtrfeIv7+7IPUDL2rwwmlqPxCdcvqpPockqYL59FXq7s7lhrH6gqVzq1E2lGnjxLwtcyyCZWTcRSuQ/C7FZhq7+p3K9R0MJx4Og1ayxn3bjBPCTL7vZxNM38liHl6o9/W88N+3ly/VbLHzGsr/mD0Yje3BPDYsw8ltv+WK/jOe/SxRlCUkaZVUTwTt/RJe7HXe5wVmiU3BiMYNMb4gOUz1iKLMkBAo6FXAop5PjQ0zBuDSrofPkfG73C/rcYT3Y5Gw2cGDXK0zRXrsGELyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xfQDPgDkiBwRs44lIQMSvAMZatLd7NdTaAj77cPD00=;
 b=gIBcYXMm5Ft8CIlmzTxhNaeW0U+wjsQzGkBVgEABLbCaNEep+yE4XSjytm86tcsBx0uKm8D8x/eqLdjby0k8j45mr5/CZqZrPxpqoAep5e49HKbLl57e9dU+hwm4bONmkSz6epGsmC9Qg0wh/+ZGmHe/6Nplf3z0fiQj9h18Y4UUT56EGQ/y5zkMHJXceEDlmJ94GEXz2NInDyOPQlutJAFMbJB2WKcMPoZbTV7j5A71zwswqiaXnZHMGcPYA04JZLVNklWT32WMwBcbA36UJ78qgKc6ykhqeShGLWVE/rWIp8FRc7yD7tFDXk5S0bWzDgiMWo03op4kK/PxFaM7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xfQDPgDkiBwRs44lIQMSvAMZatLd7NdTaAj77cPD00=;
 b=kOCKPXkSZXdu9DYOigEO+PK15HQ9m71VAph0+x3dNQSifD88HYV+qVgeLAPMGcudrVcsVSea2/PxVEev9aserD/hJnOUYNLVjOdEtAEDjFynfwQymdf9it3La1HCqBELDtHW/pLfMTzCTxhSH0iQ0VP1RYeKcbtT83V0ETkroFA=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 12 Apr
 2022 16:29:09 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 16:29:09 +0000
Content-Type: multipart/mixed; boundary="------------od96F16BmcMNYjWNf40wDvbg"
Message-ID: <2b6ed542-b3e0-1a87-33ac-d52fc0e0339c@oracle.com>
Date:   Tue, 12 Apr 2022 11:28:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
 <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
 <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
X-ClientProxiedBy: DM6PR07CA0125.namprd07.prod.outlook.com
 (2603:10b6:5:330::7) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5782c7c6-5fbc-4bbf-a46a-08da1ca191ce
X-MS-TrafficTypeDiagnostic: MW5PR10MB5665:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB56657B2919B14E928FAD508BC7ED9@MW5PR10MB5665.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOwzijzYdIfImjMphih7GGs8SLjQ8aTz44J7VVmuX1K+VClsmwG2KqvMEbIM7oIiAC26gnCZsUb4zLhE7+XgCtUIB5VPWkaUDVXCdaQ0tFyLPvgv/mnK1OF+Js/4fLiHPiIA6haB6pMi7kdCMyf0B7o0hLZwFz7SRFJblwF0LWYoaHUDXevQzEfNiaPyX6RZ0Y6SbUUrsVhyF0zv2bONG9bjdvPjVTnBZJfImXP8YEAjmdjOQflng3dbT5tNqTXSZXRcBuqcMNkU08LhN8XVUUe/+g1crJn+rT1Sfuu7bbbG2ltRG3CeMOfOrhxTOYdBHh/9BqgM7hWVP/7KxQS485ilsxgRaHm8po50ouA1qalM0w+36afYcCujb5MfnUm4E7LGxy7GGVKpz08Ckm6SSSx7fQCxRaCECpm0ixaGBEk0Xyd5o+nhmx9ens+PJ2uCNXLjkCxIfjqd+dDoOOKFkS1UZq2ATGZJuusKXJ8GExRP6L2mun2x/Ax+jMNAK4XYD10xZIRzZ9qXOdKIUBYv1YojjnUK9LqvEsPMVFEC3NoYM/C9WQBZRnXV2DZxabgzWHxzVgTF0tWSkH0RQOHoND8O4fOGr0QqhSGzhy7KnJev0pi3ce0VUiwKJ+89bAtkoPmPreWOeDQehOb7IGtKU5KGotWTA7lHyWSKDpOwbvd1szZ4oJumEXFpalFU3VI1FXc7wwEJutxcryoMcabnhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(31696002)(6666004)(316002)(38100700002)(66556008)(66946007)(7416002)(86362001)(8936002)(9686003)(4326008)(8676002)(6486002)(235185007)(508600001)(66476007)(186003)(5660300002)(31686004)(2906002)(53546011)(2616005)(26005)(33964004)(6512007)(36756003)(83380400001)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm8rdU4xRGIxVWRXY1FKVmNpNkZzRDRJdXJJbWh5UDk1R2U2K2NlMTd0L2FI?=
 =?utf-8?B?d1VJQXJTSTY3STBCMnJFY24rZzJiZHdCMk9VNmppYWlLcElpNytjZTk4bEpW?=
 =?utf-8?B?TzZsT2ZPbElzWnFXYkt1N2hGT0pEOEh1NmpZVWYzbFMrcS9EL1dMd0o3TmdU?=
 =?utf-8?B?S2xrQUx6cWNVL1MvREhWOGt3dExQTzVhTGVTN1FKM2wwZjlmWUNHUk51aEl4?=
 =?utf-8?B?RXp1eTdrTUlyb2FRSVhKU1NIL1AyZFJZYjZEY1ZUY01xS0dQWG15UUdlb3Jp?=
 =?utf-8?B?UlRUdHJIeGlrVWNQbG0vazVuY3g2UStTWVpoQm5adXcraXJwS25iV05Bd1Ni?=
 =?utf-8?B?OWZ0L01oU3Z6b3VieDIyVkNsSG5CTTF0OW5DNVM4dGdVdkU0TmJaS1FNZzJO?=
 =?utf-8?B?Q3pIbGFjL3dQbU1ram5Nd1hZeDhSY25JOHJhZ2JyL2czV0RqUmNBMjNLN0or?=
 =?utf-8?B?T21jbGVZZXowME1jR0ZTUnRmM0FtK1RmYlkxV2xmUUQ1S3laRElRUXdlZ2tD?=
 =?utf-8?B?L1paNkczQXlucHZyU0V0MnRTVDcwTVFjT00rK2R5cnJoWWxCblNPUElKb2Ur?=
 =?utf-8?B?aWtsVUNNalNSSFdla2Z4WktCcEd6S0g0TFF0QVMvTVBTNXJ2SlNEaWowWTdX?=
 =?utf-8?B?eEt6dCs0cVZ3RXlJc0greE9vbnd4WEFaSiszSys0cnZ1bW5iNTZJTTFxWnYv?=
 =?utf-8?B?WnhJMk9VRm5EcER6M21vTEk3dnAzUnIycjZ6Rit5K2JyMHJJVmtRMHl4dmlt?=
 =?utf-8?B?ZGlBdkNYSTJ3azJLV3NoT091Uk9hNnN1QmtlVC9ZdmVUN1VFL2E5bDRYWnEy?=
 =?utf-8?B?ZjNNaVhUQUYyRHErZ0Y0LzcyS3dhQ2ZHdys1QlpOT1Z5Y2J5dC9yWXdIc05N?=
 =?utf-8?B?SnJ6RGpnMXlJcjBobGZuOEhJT0FoQlhuWUthK29FZWpIMEZOSDRzc1hvYVZs?=
 =?utf-8?B?czIzWHY4RHBheGJXSHFrdzN6RUxLZVVtZFpGSzFNdC9hbTVMbjg5UFJmOFhB?=
 =?utf-8?B?SCs5SE5mbU9xVEZycUVoaG10MXVrWmJodEdJQ0xudnh6QjRvVTdxWkJSSjFK?=
 =?utf-8?B?U1hNek15b1JEVFF2UzJiQ0FMb01EVzNsMzJ2WGdiS214ejFqOTdNRy9XeFhy?=
 =?utf-8?B?V29oMnhmYWNFbC9CTU1UMmxmZFBEYkJWSmlxYUhab1paSUMxcG5aK3QxTzRV?=
 =?utf-8?B?ZTJmMlp0am0xUjRERWQxV1FYODhpQ242NUJCR2NveXVkMEV0NjdQejJMaGhQ?=
 =?utf-8?B?akFYalFOTXdQZXR2N3ZLRVAzTWRmTWN6NXo0eFdUNkF6c1RpR1FWSVY1Mnlt?=
 =?utf-8?B?YkZ5aG5PZysxL3plU3lHaVIxakVQRGZvZ0hKT3YyckdWMGV2OE1kcjFDNG1w?=
 =?utf-8?B?RVVJY3BRVTlPMGZtUWpGZzZzZzZnYzI2akR0ekg2b0JVYVpTMHpNaDh2Tno4?=
 =?utf-8?B?RjhmelZ5YnBoa09KUXo3dEZ5OUdZVVZrL3RyOWd4bnZYQzkzbEtQRDFXclEr?=
 =?utf-8?B?eHBBWFViYVkrOFdkN3E2aFZTUlMzU3JtdlBDNDFVLzRVS2xickxBMHJOeDA0?=
 =?utf-8?B?QThwWC9melpjWWU1SXArVGpVWEtYSzh2QVhxd2IxOHRPY0Q1dFBNYVVEUnFX?=
 =?utf-8?B?anBqb0UxYjQ0dHNOdEE2Y3RCcmdGZExoUnhVeHNldy9XOUhGTG55aWJWWlNv?=
 =?utf-8?B?cFpoQW1odU9sS0xJNVpHVDVrdzRMR2FyVGFmdlNZVkJLQUhEdmhhYVFNdDUz?=
 =?utf-8?B?dWxCVThNcHBxSDhiVVhmc0pScmRzdVVGVDlFS0NQSlZHN1hKNGtlV3JLSHpM?=
 =?utf-8?B?OFNGTW5wWGlEOTRab2lsYzNIR0VNa1F0MndmQmZPanNvMjNpQThuK0FFUXFG?=
 =?utf-8?B?VlFBK1d2RDVWcnE4RTZ5YlhzK2ZjclhKajZhSXdRdVp4MlJQVXZ1TXE0UHo0?=
 =?utf-8?B?aXNWanRvN1huZlhmVk0zVldNdU9mT05nVlUxVVNRV0YyWFNRRExaLzVGbktE?=
 =?utf-8?B?MVlXWWh1SzF5RjFOZ01yc1VDSURNUEVFR1RQNGxHWHVXM2xUaUhUbjROZ0VN?=
 =?utf-8?B?YnBnTXJMc0s3b3RvUDlHQ3M0NVU2YVpBV3QvSFVBVm04WHU0b1UzOUJUQk5q?=
 =?utf-8?B?c3VEcnNsajhHbWFOMmFGUzZPUG14Q21aTkpvalg3OHVBSjR3aHJETFEycWNv?=
 =?utf-8?B?cnM5SGhzZUpkZ3ZBeVZmZ2EvNnl5VXRrVk9ZVUhpWU9Ja2VmNVRXRE9WcWxS?=
 =?utf-8?B?aWNER2dVY25OM3l2VW5aQm1Ub3pZYUpSWHhtUnZyMHNZNmVna3FyYmdabXVx?=
 =?utf-8?B?ZlNFci9jOVNiZDBlcjQwTGNGN2d4WjJuaWxJTjEwZkRlV3ltd3FsVGllRXFa?=
 =?utf-8?Q?23B3neHmQVcsOgwM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5782c7c6-5fbc-4bbf-a46a-08da1ca191ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 16:29:08.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYSvekDwgfecnrVoa6zOeZi59Hr0lYeAt2l7Qbgp627q5o0mG2LkDND/8KlgdovvKMt1G6YqpJ8MpatZvYTANAurJdsPQHQNoibl7QIoC8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120078
X-Proofpoint-ORIG-GUID: pIvj8nXrU4Q5JaX0qW80hHLERtrD5iLI
X-Proofpoint-GUID: pIvj8nXrU4Q5JaX0qW80hHLERtrD5iLI
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------od96F16BmcMNYjWNf40wDvbg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/22 4:07 PM, Waiman Long wrote:
> 
> On 4/11/22 17:03, john.p.donnelly@oracle.com wrote:
>>
>>>>
>>>> I have reached out to Waiman and he suggested this for our next test 
>>>> pass:
>>>>
>>>>
>>>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>>> out_nolock path
>>>
>>> Does this commit help to avoid the lockup problem?
>>>
>>> Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
>>> reader first in the wait queue is interrupted out without acquiring 
>>> the lock. It is actually not a fix for commit d257cc8cb8d5. However, 
>>> this commit changes the out_nolock path behavior of writers by 
>>> leaving the handoff bit set when the wait queue isn't empty. That 
>>> likely makes the missed wakeup problem easier to reproduce.
>>>
>>> Cheers,
>>> Longman
>>>
>>
>> Hi,
>>
>>
>> We are testing now
>>
>> ETA for fio soak test completion is  ~15hr from now.
>>
>> I wanted to share the stack traces for future reference + occurrences.
>>
> I am looking forward to your testing results tomorrow.
> 
> Cheers,
> Longman
> 
Hi

  Our 24hr fio soak test with :

  1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock 
path


  applied to 5.15.30  passed.

  I suggest you append  1ee326196c6658 with :


  cc: stable

   Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
consistent")


I'll leave the implementation details up to the core maintainers how to 
do that ;-)

...

Thank you

John.

--------------od96F16BmcMNYjWNf40wDvbg
Content-Type: message/rfc822; name="[PATCH v5] locking/rwsem: Make handoff bit
 handling more consistent.eml"
Content-Disposition: attachment; filename*0="[PATCH v5] locking/rwsem: Make
 handoff bit handling more con"; filename*1="sistent.eml"
Content-Transfer-Encoding: 8bit

Received: from SN6PR10MB2976.namprd10.prod.outlook.com (2603:10b6:805:d6::12)
 by CO1PR10MB4722.namprd10.prod.outlook.com with HTTPS; Mon, 11 Apr 2022
 21:03:51 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by SN6PR10MB2976.namprd10.prod.outlook.com (2603:10b6:805:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 21:03:50 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:03:50 +0000
Message-ID: <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
Date: Mon, 11 Apr 2022 16:03:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, chenguanyou
 <chenguanyou9338@gmail.com>, gregkh@linuxfoundation.org
Cc: dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
 mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
 quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org,
 John Donnelly <john.p.donnelly@oracle.com>
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-ExpirationStartTime: 11 Apr 2022 21:03:50.3769
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: 
 f24d91a9-2ff3-4b28-83b6-08da1bfec72f
X-MS-Exchange-Organization-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 14
X-ClientProxiedBy: DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16)
 To CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
X-MS-Exchange-Organization-MessageDirectionality: Originating
Return-Path: john.p.donnelly@oracle.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24d91a9-2ff3-4b28-83b6-08da1bfec72f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2976:EE_
X-Oracle-Tenancy: 1
X-MS-Exchange-Organization-SCL: -1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:-1;SRV:;IPV:NLI;SFV:SKI;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-CrossTenant-Network-Message-Id: f24d91a9-2ff3-4b28-83b6-08da1bfec72f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 21:03:50.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcelX3jxfFDN045gruLrZ2dACptl396b4YXHtueSzxP2ZSdRB1JVqdtcjlyp24kTEwcFJInw++LhoR5T3dZTikO7hj3I2IQmIvfJUCVfIuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2976
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.1239883
X-MS-Exchange-Processed-By-BccFoldering: 15.20.5144.029
X-Microsoft-Antispam-Mailbox-Delivery: 
 ucf:1;jmr:0;auth:0;dest:C;OFR:CustomRules;ENG:(910001)(944506458)(944626604)(920097)(425001)(930097);
X-Microsoft-Antispam-Message-Info: 
 AbvWkKWJpj1NTrW84R+PCJyLV1AzCqa9QzLNCPK0UmjgIkqGaisWYtx/P5zMCUWRM+ui8NdiySYW5x3Ebf7zyZViG8Do0QlmPrgsgtejHDoE/wHWnfbUfRuFjZd0gWZptxYxH87G2TY6GfERsU/DjkKnbXl1LvqlCABh0u0g2yTxRcAZIORx2ZNUdTvBgQK2bGRgEH5CXFKGC8KnLzxoMkZ2lH9E9P5c8rorz41zmuNS/l9Si181uOn2kOwFwQJI0u12AL5MNNMEn/GrYBKC4bJPTpj/nG9cid9GvwpzF23i2xVhYQ4kYpE39eH49STpnxAU9/2x3f647jKD8ZnTFXphOyqABq8TeYZBRJjGXQr1DZjDRa6+jk2940w/+YCHfBkICvjyk6E9j4603/AY/C76lY103yFaRgJo0o9kUT+SQjj6AUheBABkbqm9gn3QkraoFRyX3ji3ixrm4CBY7/U+HNzfZnCS7SHd/FJY9Uv5vzmymB7bwvarevNvzN5v1Zi7ev4y4M485tl+iBN869VX6j0sAEAAQn/Fh4lJTAudLTEfdonRIBBFG9Q3lpfUNXr+6K6C+r/2XiGhhCnCiEzX96aRgUsDi9qxxZlVFJfYGLCm0sDJIgjzn1tP03FytgcRwvMPUpzpBph0zSIbLWhAzekHPQDfXKWY/ixSkmHrhg7uLztYJFWIGCo6c6+0mDp2lmQeMhfcat9N5w0/ZGkv0ZscVtOsLsrshBBPBNY=
MIME-Version: 1.0

On 4/11/22 1:40 PM, Waiman Long wrote:
> On 4/11/22 14:26, john.p.donnelly@oracle.com wrote:
>> On 2/14/22 9:47 AM, chenguanyou wrote:
>>> Hi Waiman, Greg,
>>> This patch has been merged in branch linux-5.16.y.
>>> Can we take it to the linux-5.10.y LTS version?
>>>
>>> thanks,
>>
>> Hi,
>>
>> As a FYI:
>>
>> We have observed that following lockup with this commit added to 
>> 5.15.LTS:
>>
>> d257cc8cb8d5 - locking/rwsem: Make handoff bit handling more 
>> consistent (4 months ago) <Waiman Long>
>>
>> The "fio" test suit fails with LVM devices composed of four NVME 
>> devices with these observed lockup, panic.
>>
>>
>>
>> ext4:
>>
>> PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
>>  #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
>>  #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
>>  #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
>>  #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
>>  #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
>>     [exception RIP: _raw_spin_lock_irq+23]
>>     RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
>>     RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
>>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
>>     RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
>>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
>>     R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>     <NMI exception stack> ---
>>  #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
>>  #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
>>  #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
>>  #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
>> ffffffffc11ad9e0 [ext4]
>>  #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]
>>
>> xfs:
>>
>> PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
>>  #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
>>  #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
>>  #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
>>  #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
>>  #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
>>     [exception RIP: _raw_spin_lock_irq+23]
>>     RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
>>     RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
>>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
>>     RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
>>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
>>     R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>     <NMI exception stack> ---
>>  #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
>>  #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
>>  #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
>>  #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15
>> [xfs]
>>  #9 [ffffbb7ec9637dd0] xfs_dio_write_end_io at ffffffffc072db62 [xfs]
>>
>>
>> I have reached out to Waiman and he suggested this for our next test 
>> pass:
>>
>>
>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock 
>> path
> 
> Does this commit help to avoid the lockup problem?
> 
> Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
> reader first in the wait queue is interrupted out without acquiring the 
> lock. It is actually not a fix for commit d257cc8cb8d5. However, this 
> commit changes the out_nolock path behavior of writers by leaving the 
> handoff bit set when the wait queue isn't empty. That likely makes the 
> missed wakeup problem easier to reproduce.
> 
> Cheers,
> Longman
> 

Hi,


We are testing now

ETA for fio soak test completion is  ~15hr from now.

I wanted to share the stack traces for future reference + occurrences.


Cheers.

JD



...


--------------od96F16BmcMNYjWNf40wDvbg--
