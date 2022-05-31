Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8D539571
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbiEaR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiEaR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:28:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC593471
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:28:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VHHIkh011768;
        Tue, 31 May 2022 17:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=139RGQp/kOZy2vDpFFv/rH65u5e5cCcUG4ouCJbTr+M=;
 b=GATKNAnKAFJ0ZbEh5fxzNFOW5fsYoS7IlXsVNEyTUGOILlWITWAx8h0RzKPuuaBI9v49
 PXZXl7lWcCTIqf4+oQ9ktf1GFA1Fl5tSyspm6zOY1boEl5RmtF4vLThYWCrXQmJEhL/5
 rLKdqTUpebi+q+ebZDnsfNH50j8y4/SU94ZtSFtV7ODy4/J0FlFq8qkQCRUeYa3j2mft
 rnWjshT08N59pC3oOLe34pHKuRHMs48kvyYtmrClvxOrA8VW6dsy7blueSEG2D2Fok31
 IXpxtm6eGvnDtnDDTGWhIZzxBgOj/E/noXMwqhMHDFOvhYp/2EEHmGmMX4YvM3ZCH/2a kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaunubu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:27:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VHFb1r014571;
        Tue, 31 May 2022 17:27:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kf7yxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:27:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOjjvf0MlL1HQOK6+rNbXDFVcq1FPfJwVMpcsFBsUPmcWLy4svFpAP+ZnLfsrV6PyxfjqwN9LMpx5RQGlNm75N6qVObmf2VnwoahuXYKOX3ABqe3Vi27z0p1DInN+rgBqh++eQqMyDiXYEfCYKkM4WpJ3LOso9id7EECq0ccOZ9sVCkOfi262mFHbg0gRNvJgBHp6AgbTqNX7UiEM8IiGdlgPkj5EAMfkk7/7nfOb8dikgi4+6Z2FTywyZEMoXE1YE2iFWM+8rHdBI0dpahXUBdXKF4V1lAd8fdetVhISMjRnCe3/EkEmMQloBnl/rHHR8sdLdgRBANeEQobuTzVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=139RGQp/kOZy2vDpFFv/rH65u5e5cCcUG4ouCJbTr+M=;
 b=VYSkO0nAkOQTfu2OVKAI2q/yG57z56G0p8saUC6Mdpdwhk3sRI5uxdZB53ZvISzwxGNqNOg40jncH60l9fnQ0FnKpWxZqBEuCuW5ONkZ/zcrF0xwtrREQzRWYkDIIzcfiHJ1BdUXbcfmzAUH/5LZGtKd5YP86l1BzM3M7HjuO+6h3oqRyWxzVNSTyetwICCBDJY5Oam69f9StGs0jQlr9Zcz29JKSavdg3xDjIfPjY3TEjAGL9V/i01VpnMbvuFqWdEF73CTqZzioGy+hj00HHQCf7h0O/rJeolULLURelXh5LukxN4GDHW/J8hoKDEE/ywDeiZ1QyIDqUXPrip/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=139RGQp/kOZy2vDpFFv/rH65u5e5cCcUG4ouCJbTr+M=;
 b=FAIzrevvBhjKTXJqiZjp7pVhPHhjurw6NAeDaOzba+z9e3m9NCtxjyWnew0LGCGEcjFfI4VhE5xTOw30fZRHxv3i4xrWmiIpPwCx9T9adWru0Mc7LlaSAWcqZ7ubaXALtW6n6GW3tkAFCWYtSRPykCwAwn4fguTchmLEiAfHfwI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY4PR10MB1846.namprd10.prod.outlook.com (2603:10b6:903:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 17:27:46 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f961:32c1:44e0:6517]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f961:32c1:44e0:6517%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 17:27:46 +0000
Message-ID: <50fc0322-78b2-061a-46f1-dc13e4ec7184@oracle.com>
Date:   Tue, 31 May 2022 13:27:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] xen: replace xen_remap() with memremap()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220530082634.6339-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220530082634.6339-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:806:28::14) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b0b92d-1547-4047-9ccb-08da432ae080
X-MS-TrafficTypeDiagnostic: CY4PR10MB1846:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB184689C4F610DC4DB9238D458ADC9@CY4PR10MB1846.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKblSy644DUa8GzhJUo9Md3DQFY/ehZ4ujwSIdc7+xP1elZ0WuBqax7HFt5THp/QxOh6lLIC2Nk64SYHJfpzZu0GCW7fYCZgy7zgKwfsTxOPfwte/G5CGKh8rzIfUId7eK8QjwuvGcFA5xLIjbUaWmRJDidgxkc3rR5+7ITPCzKJfCheIZBB3Y0/deSGdhsqikFW1uOClK8SUF34tXGwyWlRKRAYd95pk5abNZCw8u0zh8xG+6t2f6X45wNALEb7moiX6dIfGZVXBdQbdlKD85YpOl8PIuFXZ4vgHxw72Eqx31kvqdr/nXNDidGN6Jnxs2bZw9ygZvhFP8G0DHkSqD1AP+v1bUBeixj+1NDGTgRFCLKPqdux8o/9fE4dIddfkmaJstVR2HObfYWOciXPRdTEiDlShle0rNSNWA+UMXr+OuwzAkkMuO/X+XoxgtcDVQy+qDakeU2gxpD9AjyLklHttlZR2R141LL8enni9lZPzbdFPSHSKyCCou1tRg3YXCKnEfKaxH3qmGazqnFSwiQU4qwL5m+3JQG8qjra23Co5t+rzkeEa3NYB3iQJO5dQcC4n+eqbH7Hujw8kOWh0EYX369IbiPhRumKSc7q/KkxL5YDYlokLRGBZxDRCQIjii+njZ4awbQ5gXGYA4gWTHx1YoCsC2MhSo45FerqbVI/Ya++DxXHMsx3LSHSWqr8XGDxZOQVeDOFbAR6zYhoSJ4THsSrK3MrctYTDxmGK3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31686004)(2616005)(54906003)(36756003)(2906002)(316002)(26005)(6512007)(53546011)(186003)(5660300002)(31696002)(66946007)(6506007)(86362001)(8676002)(4326008)(66556008)(66476007)(6666004)(8936002)(508600001)(6486002)(7416002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVViZDVXeGV2V0hnUTM1d1pua1Y1WWgyQXBnU2RCa2J6Y0dHY1F1Q3ZtUjN0?=
 =?utf-8?B?UC9uM2hiT0gxUmt4UHNCOWFJbjh5dDA5SUZ4MmJHQVg3amhHcVgzcTdjQ2p1?=
 =?utf-8?B?ZWV1OERORk8yS3M2ZE5NOEpWYW94Z3lIY1paTXJDK2RhalFNV3hHU2xETzNp?=
 =?utf-8?B?ekkrNDlNcnc5Vk1nTUM5VWhnRk1rT28zOVdCcFk1djlPYXZERUVYODE4OWxD?=
 =?utf-8?B?R3IybmJORHBHZFZZMjR2bmZkNXBnMkhnem5pTHhUVDdkbU5KMFJQRTBwR1Jm?=
 =?utf-8?B?ejVyc01tMXliWXhnUk93d1AvQm9RdEZoWlhEN0VHU2ZIK1MxajQxVzRDREMy?=
 =?utf-8?B?MTE2Q2hnZWErRkUzL09UTktNd1ZzK2wrclNvK2dnTWVmS3BmODJuSmVXSmQ3?=
 =?utf-8?B?N052dm1xTlBobVAwaFRpQVR3emdSeUNyaVEyaS9RYjdDODdzWGVua3lEWVNs?=
 =?utf-8?B?bHo4SmphNkZVdnVCRkhtNEQzYzBTSFNzam5uMWdzcHBRMEQzTkViVGcya3dH?=
 =?utf-8?B?ajYrMG9pbHRlZjI1bkk2bm13TkZES1F0a2hYbDdHdmFBSUh0b0kvdklta2NP?=
 =?utf-8?B?UEFSb0dZcFYvRFRRNFRjY25KZ1JRalpHeGN5VjZ6cTRob0o2cXVRVHcrNXFx?=
 =?utf-8?B?aUFIcnpGWWZkYXZ1amhnQWJFN1RwNzh5MGdUbVJlZjVqSGVjVjBDN1ZjeFJX?=
 =?utf-8?B?STdNeDExRmdWZUxWU2pWanlMMjd4dnRpZ1UycW9mNkEyMnZlRTgvNU83T1kw?=
 =?utf-8?B?endkaG4rb3lVQVl6blpXR09nQlcvbG9idDNqUElyZjRoSzQ3a2JZYkMyWkZ5?=
 =?utf-8?B?cU1oRXYxUm53Nnd2dHViRk1KaDVTZ0d1VElqbkF5anpLWW9oL3pYcDhERGk5?=
 =?utf-8?B?Z1RUUmR6RXY0Y1grWTdBOVVOeDc0bnl4eFgxSDBRUGdOTzBCSUpGT0kxN1cv?=
 =?utf-8?B?NWhxUmFIL0t2OGZBSmF5VFIrOWFDZmhzY3ZHZVVVT1RyWi8rdENCWFdQT1Zr?=
 =?utf-8?B?eHdlT0RVWDlxdzNNVk4wRG5HcGU5dkhjMVMrWTFScGFSUlZsc05SQzV2RkZL?=
 =?utf-8?B?VStNdGcrczlmenlFZVcwTXRDeXo0Z1p0UVp2THB0NThvWVFyS2IrZ1BFajE5?=
 =?utf-8?B?NkNBVldzaFpNeXJHNUkzNUx3dzhabEVwQml0ZFFHR2VTQXloRktOUDQvUmp5?=
 =?utf-8?B?Z3FnOC9qSjRjVzF5ck4yYThDKzBIWnMrZ09OaTIrYjZyd016bTRtVjhwU0d3?=
 =?utf-8?B?cTFHK2NnR1AvcTQveDgzTjFLZHdRVVhNNkE3TTRtU0wrZFFVVVFjdG8va1ph?=
 =?utf-8?B?R1ZtVzhCelBQb1FmOWx4WVYwWVB0aDNaR0Zaa1FMd2NwbW9pTlorQjRER1I2?=
 =?utf-8?B?QWFtM1ZDdnJ0Vm9Bd21GdFVzY0pyZEExZE1DYzg1UnRnc01UY1BBTVNnTXYy?=
 =?utf-8?B?SFV2MmlpRk80YXZlSEdGVVQ2K016Y2JlVXhBd2dmVU96WDZTRXVMNnRBZFRC?=
 =?utf-8?B?blhaTC94Uk5sMDZHOTF6eUhteFBWb1dwRzcyUlczZFBGVkl4ZFJOVzNHRWZ0?=
 =?utf-8?B?K1puQjFNOG9zRUl4TStHZ2N3bVM2SVBRWUxvMnB3eUlIMFJ1bGlVU0xobkNn?=
 =?utf-8?B?Si9ZWmxMWXcvVnR4WkpxUlo4MmtvMjdKYkg5Y01oKzJkOVZMZDRZc3MxWkt6?=
 =?utf-8?B?R3FSR2tMZWZqWXZBTnJtU3dKazNKakZQeHpWREN3b1QxVThGeFRYako2WVF4?=
 =?utf-8?B?aTZIcFdXcFNOM3NxYzlCTUQ4ZGRZbkJPeHlzOG1ic2hUVldqN1Z6Z1QzWWZB?=
 =?utf-8?B?VkhNaWNpMjJYa1NKN3Y0QnpFVGN0RnU3c2ZBRGZnRjY3Umxxam5zSk9xazI5?=
 =?utf-8?B?dmM2d29Ga3dxOUpocnpmWWZWckVSMFhobUVycnE2Y1ArZEtkbk1NMGZwSzFi?=
 =?utf-8?B?TFMwZzI1WUJXSHZidkFydjJiMitrUGd6dm9jUDR5L0xBTWRrQUtUaVlNeEp1?=
 =?utf-8?B?bU9weDN1N3dvRWw5T2hCbWhRR1hMNmxPU1gvVGt3SzlRUlR6UHI3SnhTdUlK?=
 =?utf-8?B?dURRVlYvZHhvaVpzT2RvR1dHa2Fuajk0K2EyYkFTMElKM0NoS2VUelcrcTh6?=
 =?utf-8?B?VzZvc093OXdxeWV5RytycXVTSXBjOVpPazgralNkeFoxTUtnSHFvU2ZTLzRs?=
 =?utf-8?B?RWxJbTFDank5MlZTN055WHhjS1B1OXhqTDQwdWJDVHp1Q25hQStOOGFPcTFu?=
 =?utf-8?B?M21aSkZKRy9yNGxrNWpoSGVYc1oydmwzMjRmblprZEFZWGRqOXl3QlhmaEdy?=
 =?utf-8?B?ZE16d3g0WVIwYkY5R0pEUWMxQm82eno5d21zZlJReFhidDZwM1loajdpWnpX?=
 =?utf-8?Q?aCtzrj0FpMYXF/1o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b0b92d-1547-4047-9ccb-08da432ae080
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:27:46.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FToyA8KUwIaDrUS7VVEJR8cAydo/ABLKvjST829zwOfNIiuslBxfHREgJ0dnmhhh0hb3iSczgFzOKsLuTagzg1WIXEaSQGn5rYntu4MFEgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1846
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310081
X-Proofpoint-ORIG-GUID: 1OduQthX29qWivf9uxvq95tNT4ajXpIS
X-Proofpoint-GUID: 1OduQthX29qWivf9uxvq95tNT4ajXpIS
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/22 4:26 AM, Juergen Gross wrote:
> xen_remap() is used to establish mappings for frames not under direct
> control of the kernel: for Xenstore and console ring pages, and for
> grant pages of non-PV guests.
>
> Today xen_remap() is defined to use ioremap() on x86 (doing uncached
> mappings), and ioremap_cache() on Arm (doing cached mappings).
>
> Uncached mappings for those use cases are bad for performance, so they
> should be avoided if possible. As all use cases of xen_remap() don't
> require uncached mappings (the mapped area is always physical RAM),
> a mapping using the standard WB cache mode is fine.
>
> As sparse is flagging some of the xen_remap() use cases to be not
> appropriate for iomem(), as the result is not annotated with the
> __iomem modifier, eliminate xen_remap() completely and replace all
> use cases with memremap() specifying the MEMREMAP_WB caching mode.
>
> xen_unmap() can be replaced with memunmap().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>



Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

