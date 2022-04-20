Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA52508FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381558AbiDTSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiDTSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:47:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB962BE2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:44:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KGHllo020622;
        Wed, 20 Apr 2022 18:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mIgCx3qy+wGt5g+bKCz+mXdTduGa4CCdQN2W26eK25Q=;
 b=kyQspdQrYjw+ur7K2GQQEr4ntUlibCXrPnDG2UuXaHGL/ebDuuoNgAsdPtpY5jR4JkA4
 K5tb3AfEX8NrUYr0XkPkUUTq5xgyXDv/b/kGtRx2taW8m0Nqo0feTvuCePk1C4oZE3JJ
 IR5vW3PcS+D/Q1MkvD1neexV4yJU5/8A6Dti0IxKdCLEk2oF0uS4y4s1Qd6r3av8yU6P
 CewT2zzIrc4Fhgg9+vf3bVow6GqD1aR0xDrz6OqN/wZ/GwANhAecya4WbvsVbTRDfrb1
 7PkqlmgO5tCpK0+bkhlQr/l+b6k5BGmQvxjWdN5LED5spY0nSSlqmtbJOoVfWsTntRx4 XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1a33f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 18:44:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KIg9op038787;
        Wed, 20 Apr 2022 18:44:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87rwys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 18:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+lasMn6Hf+orNcQ4FZjRThhQA8GP+2opoEvIAbh4gEX3E79iL7qEnGgEenNH4mc2VafaNn8KPbR8qZjyXYYYN28ypwXZRr4lfkaVurO7m/sSmIeQ6R7yaACn7LXAvo+2KIzKGGo6G4/4w7GwW4OX5tyB5vYFcin7jHkIm2LAkFqVu7OK3frUkoD8RoSf+3dcVx0epW7gfE9TYv6Enb7lFTY4W64Rjw4UaiCOrv6Yh0udO5H3sRQl8aalaCQ/HucnaGt78FWqUMBdrfH/pmPJctn0y4cElaowldoaAEWgs51NkN0mzPWkQ38FwRTEq9DdaN65Uz7NEGBQZOo+uYY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIgCx3qy+wGt5g+bKCz+mXdTduGa4CCdQN2W26eK25Q=;
 b=oXtOT8ju9HtXXNg+1j1HMHgm1d06Q//VtqwCT9wREK7HH3Qx58Tehj6KtVTtygk5GgqHpBM/ZNDck64vmRegjIAILXEtpmty3WohgsQ084RKaOIh0PN8CekFQ+5PVcbZGgG7LOliDJFoYZK5l5PHz/U51Dna6aZipYlUlMyXRF5veoNhZG5stqbKy7W6p7mLoe9154brMaFzlAgAYb9hgEBbspUkQY9iVeqhfcLKd0J+ZQOvhqIwcXySQS/rfwaOLbJ7/ZrM8YKTAwLMU8hzyfT4ySi1M7Pf+jR+58/0YcyumTfkTSr0buU8cM/0/mroPFvQBngOEZBlXFz8Ip7Cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIgCx3qy+wGt5g+bKCz+mXdTduGa4CCdQN2W26eK25Q=;
 b=xc1eAQudVCsIrjvG6Ff/mgXo8DCmgpI5bxoSXiMvkA5MckBvZGOKk9lcN7MMqwYiD4Trp7moR6xh74sEHPuWr/LWaZcHUTrsk5vys9x53yZoYJP0KL6+5FM1Q5V+UNGHm4nlVvcskWfcopOggJc97XB24zPZdWfOOVnNMOEjuBM=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BN6PR10MB1298.namprd10.prod.outlook.com (2603:10b6:404:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 18:44:35 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 18:44:35 +0000
Message-ID: <0d5ae87a-be43-ce7c-57b2-4567bb7e9f4d@oracle.com>
Date:   Wed, 20 Apr 2022 14:44:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 09/18] xen/xenbus: add xenbus_setup_ring() service
 function
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-10-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220420150942.31235-10-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be03f60c-e93b-47ea-e95b-08da22fdd0fb
X-MS-TrafficTypeDiagnostic: BN6PR10MB1298:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB12982BD7C83E4013F4DA04228AF59@BN6PR10MB1298.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y/Y2txxb/33JdxPGJfgPzkbP3SkgPc07T5PShS48yL0LLAShAQwpWOUkOVUaAOEGlpufhMx2PWUHbzPib5v43WPf/TxzBhvfCj5aw7OllV6JfivBmRTpiHbkpQaQzl6WWAn782ldoDEQyY/uJSCu8D7CBiQdoCC0vq3rSWNalZGOxYrzoVe2bFbP5iqxWFypZrcIQ35MwYnwxYNLK7lXTCegGtzkxhCpLqxPHgbRzM7Fl+jYGPQZmVGNgQjd00Uk3P1wETkgKrvrrFNF5UMG283q9NNp3BIVH8VL4tmtXPZnOZyyeUqtEEyOXtyh3khpJmMZNlAXFj7A/1CDap0gIM+WohtZtd25eT6dM/HXT3Vnlop5LzIFcIuP7TkA654lDBmAmJmwjik8s9/Qq1mNJMmN+J0nM/h5PVum/sXw4VGE6hegDpv920cKDhXk1fOluEmDoOH/ouotTmLAORe2SBR8JdK2rXpBtWqPfZ7MR0ylAT/s+nlV9iPB/LQcd9Bmigcy2PzBkxqdGsjs9tjOmRwZ9nV168GFwFe8r0vJD7bihaNRmQjDHYCOWQD9+Do4WKfsXCdBNaVJ69sBklbXuAeuectyvzoYs6nD7m/WHwFDIScFYbmVESDmhoswg3SKAhqvXIagKfVbBzvAzVDFCajkYVPocsdydQGHO5awMzzfIN2sCjil9sJwWsSf1meNRoFggLSZGAlxOORqJAwg+RVaG/EDYqREXU98UtoSrFD0z2HsYbF3CerIBA+n+r1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(2906002)(6506007)(31686004)(6486002)(36756003)(4326008)(86362001)(8936002)(8676002)(31696002)(508600001)(186003)(2616005)(53546011)(26005)(38100700002)(316002)(5660300002)(66946007)(44832011)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym12dVI2Y1hMMFhxK0lpYUp1Z3dLTGEwa3NNSUJ1ejAyeS9EVXRvcHVBTS9S?=
 =?utf-8?B?ZUJQRStZRHZiZmFPczc4Qml4dFZwbGRwdUlseUVkTlhmWlYzVmtvOFZlVkZx?=
 =?utf-8?B?enB6OVJ1Tng2Q05CU0VHa1VXS0FMQkhvQzJCUXFPQTZpcVRRTUd6cy9ZL0hr?=
 =?utf-8?B?UW5kT1JXZXp2WnU1a0MzcEd2R2JHcXkyTlBrTVd2NEFVY3QzNitXL3RSNUcz?=
 =?utf-8?B?b21Bbkpjd0phWWpLZFIwOTZFZGhJQy9aN2RPdStid3ZiNmdBWDcwKzZDUzgv?=
 =?utf-8?B?d2JCS2RHNUhsQlNoNG9nOEdnRGJnelZpYzdlNk83YnJiZ1FtaHpZVjNLWWZP?=
 =?utf-8?B?VGZ6TDlaVUQ4OGpvTmFRSGREUFQ2bU1KTktPUjluWDgwWnNSYVc3Uzc5aGlU?=
 =?utf-8?B?THpER29wY0pPbUtyNndxQzVYWUF4aWVMRDR5Q3F2TDVYMTlTOVorUVAvblNr?=
 =?utf-8?B?OWdpcjRFenpRMXZ1THJmcW1tVWF5VWh3SEgrR05PaTlPM3ZuU1pPd2RSaUxU?=
 =?utf-8?B?Rk9rclZsdzRtYU94QXpzZlhRcHJKUXJIRkVNejd3eWRBajVRenJKbEFtTmcx?=
 =?utf-8?B?enRmZ2VmN3c4cjJFMDg5TUp2YmZ2blZHa1NPa2ZoY3diWGUzcVEvM0dWYmxG?=
 =?utf-8?B?QSthR0habmliN1VtUTd6K0xRQmhabExEUmg4U3JHaGNCOE9URWlUb0lmNnhZ?=
 =?utf-8?B?M0FjTkJHakFDOFBUclNMcWw5ZFFJRUJaSzZxZUVaYml5bWNqVXg5NE56VExX?=
 =?utf-8?B?SFZXUWRMYWNwN3kza3dQRytiM1RTL3QyVDFKSUluWnJuaVFLNHBRTStWWklO?=
 =?utf-8?B?OXBsTjR1MDc2V0RYOVFsak5XQTZzWEJRd25zNlUxeExBaFFvaUVBdUx2OEcr?=
 =?utf-8?B?MWZYUTNpc3YwcUhlSlRFdE1QZXdyeHk4WXJQZWxpSWZEeERpc3NBNXlsMmxM?=
 =?utf-8?B?cUFWbnJYeTNGdWNGelBVUExRNlU1dzVDNlBTOG43cng1clQ0S0NDcXo5NFRn?=
 =?utf-8?B?NkVNd0Z6MkVhbnVNMVJWTElheFFSdVFBODQyTmVRRGNKWVk4ZkMyQW1UL0dM?=
 =?utf-8?B?TTZKa0pnaWIzOVZoRXZpUXhLWmxSZm9lbDYvOVVSaHNJWW9TbzdpTTYyaVNH?=
 =?utf-8?B?a2R4UFlJWFNDbDBvajl1VEV2NytEUEM5Z3o5ZWFFaDlhYVYvYnI2LzlnMG00?=
 =?utf-8?B?d2pndnJMbjYvSVlhQmZqTHFsc3FlMDV0QjBETE4wL3c0NXhwd3dQN2lqOEFD?=
 =?utf-8?B?Z3FoamVLa1ZuWEhNWHFDQWlySUY3QWU1NHoyS0FqUDZCWnJSbDVFdzIyWGtI?=
 =?utf-8?B?ZWxtWnlKZVF6cmtGZkE3YU9zd3I4MjZaRWNXZWl4TUxPQ0JZUDZoQzRxa3JH?=
 =?utf-8?B?U25RbSs0KzR3R2NqVS90QjhQV2xCc2xWNVh5aWh3V1RBNnZmR2lMNHphMWpT?=
 =?utf-8?B?R2VrRDF0S2lSdUNwdnZsNHBLTGdQUEdBcStDTVFMMHNxdGwvVEpVSU04TnMx?=
 =?utf-8?B?RkZTMzlhZjRoVUZMc0NrU0NxTHRFYXRwMFR6dlF0WW12NU9mcjdJMHhNa2dh?=
 =?utf-8?B?aDZqSGphQWd5NUFPeGxkVFgzSTVkRVJSdjk3b1ZxTWdrS1ZCMVgyRFIwcWJt?=
 =?utf-8?B?OHRLU1BYUjR3eTh4aUh1RWhkc2dGSkZOMmluenVZVWV3UUNxWUxMUEg1T2dY?=
 =?utf-8?B?R2hQMFZ6SUxyMlh4c1dUQldxS2htRWMzNk5jY3E1RnZ3YkNtSlM5YWxtZWJP?=
 =?utf-8?B?S2xENHNpMDVtRW1mOGxPakZVVGJ2Wlo2cExLcDZNWnVYSmk2N0RnaiszK0FE?=
 =?utf-8?B?aGlGU3VHRm10Y1p1WmMzd3VVZTZqSkJxaUVVWCswMkFpWEY5VmpoTnRuZGpO?=
 =?utf-8?B?ZjFudnZPMWw1ZFZHbWNGWVpoTkpYSDNOMnk4Vy8yRnNsbnR1OVBvbGt5V20y?=
 =?utf-8?B?ZlR4d0JMTXZTcHFWcUpNZWV3bUlKcjFPdUgwL01tbHhmVVVkdVdYWWc1dXFS?=
 =?utf-8?B?elNXTWc5VWd2MXBjczAvbi81dWd4ZEtjY3pWR1dqaWdZUjR5NDdvNFI2OGpO?=
 =?utf-8?B?L3d0QXkyZ2tqMHFXa1ptbFNmWFgzcTQ0UUZFS3FyY2JNUU1MdGxSME84dUc0?=
 =?utf-8?B?YXcxcnNnUERlWWNkSUpWYkhYWmdEc2NlMnlVRlJBay9UenNYcWFySU4wUVNB?=
 =?utf-8?B?dGo0TEdSYVpwUTRJY2F1UXdQNmZXY0RvR3V2N3NYSUcwQ1VjT2kvOXZvMTI3?=
 =?utf-8?B?Kytaa3lmK3lxS0RoT0Y2cTFicjNvSmdYeUkyZlVYZmpxeTNGUStxeURXZUpD?=
 =?utf-8?B?bHEyZjZJVUJuNGJURmkyTG9yZ3IyWlE2UC9LOC9HQWRFaEhwVVlzSjk4U0xz?=
 =?utf-8?Q?dBC1Y13ur6yx7u5w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be03f60c-e93b-47ea-e95b-08da22fdd0fb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 18:44:35.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k4Tpv0aYB2mfDatVOe+KiHEkY3kqg4I/kOarKpMqjl66+ceUpiMHaDQuvfuHd/+me4Ygyh8mwLyaD1wBZiychxssPJvKff1902bleT8JBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1298
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200110
X-Proofpoint-ORIG-GUID: Xq-Lrdf6vHn9cHvuS_ocp4uWE9Xzpwg9
X-Proofpoint-GUID: Xq-Lrdf6vHn9cHvuS_ocp4uWE9Xzpwg9
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/20/22 11:09 AM, Juergen Gross wrote:
>   
> +/*
> + * xenbus_setup_ring
> + * @dev: xenbus device
> + * @vaddr: pointer to starting virtual address of the ring
> + * @nr_pages: number of pages to be granted
> + * @grefs: grant reference array to be filled in
> + *
> + * Allocate physically contiguous pages for a shared ring buffer and grant it
> + * to the peer of the given device. The ring buffer is initially filled with
> + * zeroes. The virtual address of the ring is stored at @vaddr and the
> + * grant references are stored in the @grefs array. In case of error @vaddr
> + * will be set to NULL and @grefs will be filled with INVALID_GRANT_REF.
> + */
> +int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
> +		      unsigned int nr_pages, grant_ref_t *grefs)
> +{
> +	unsigned long ring_size = nr_pages * XEN_PAGE_SIZE;
> +	unsigned int i;
> +	int ret;
> +
> +	*vaddr = alloc_pages_exact(ring_size, gfp | __GFP_ZERO);
> +	if (!*vaddr) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = xenbus_grant_ring(dev, *vaddr, nr_pages, grefs);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> + err:
> +	if (*vaddr)
> +		free_pages_exact(*vaddr, ring_size);
> +	for (i = 0; i < nr_pages; i++)
> +		grefs[i] = INVALID_GRANT_REF;
> +	*vaddr = NULL;
> +
> +	return ret;
> +}


We can create a wrapper around this function that will also call SHARED_RING_INIT() and FRONT_RING_INIT(). A bunch of drivers do that.


-boris

