Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF950EE31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiDZBrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDZBrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:47:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C73340D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:43:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q0MJ0v023432;
        Tue, 26 Apr 2022 01:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E0DRh/8SiU2IkLlkH80jVC0OeMQQUzJQDXF9leAvFjA=;
 b=mB7CLKFFtRLAQrqnf6UsahJHfibg0OGrrQRCU59Ghe1xW7Ij5hEqCIyaCg4TirlATlgP
 ccCf6ujbwYR5jf5grSFfwU0D1KfvXcLrJgZ9h1bRM2Ag0p5VDDwTG8Vl3EsKofhALl8q
 MJlHbNRt9lLrt8Oi1Yr4WyPR5cpO1E8Qom/TdWIrmtPC+YWX9egO3o6tvFM+3j153j2n
 kVWDYRyt/tSjrLuN+X30F2tSSiCTRQjgB98s6OhtTn3aJGgdYz4F2F3gvFwIpQfanJgw
 xwK19nVcb+EPk0uC5nOmNFt9S/95v8WQDzuDSADiyy+8TifXDD35ij8eHGD+mkVj+9D5 IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yvkmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 01:43:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q1YuNt031596;
        Tue, 26 Apr 2022 01:43:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2td9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 01:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ3wRNu2ZIvUztU/eoQwmH2HilBpzMpQcw8J/aCbHKa5ZpbaAeXrylwpsGHkMWr6Xa/maEAhUM0+KKIJe03nm0aaEsQ1jYPv4OJ9QBsB+FOUDG/rorfkhx26/WKOOWjjkG1xw6RdnLJsXXd1U4AhON3qEenI7ACjXPSLR2jtuSqQ6Mt3VPf+twZhucfN3c0wT1PVXw8DHxl+Skd+QvYVrU09j31bpDj6aVbRZykKE1yp9j/A9fEFj7n2EhygnIr0zY9sU4JjFzbA12OOcKmJH257U6WptgZ9t30asTFLj/miiHfVzyaxG63m6ZpS8WlcaYFHx4WKCWOVVgtwdhHpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0DRh/8SiU2IkLlkH80jVC0OeMQQUzJQDXF9leAvFjA=;
 b=hPsM4RsZBBz9r/t8Y7aviQ8LO6EPEEzGFo1bS1WNQA2462tI+K49hBAFi8cKd2DsNxcn/cYpudSqEf2n/+xMDiHdTwQYyFYn5pUewmcfpn4xkCTMJXk3bDC/NwtOD90PzpSCJbrLx7iDHz6libIJfdU4MgfieAnMq5Hdaexvs0V945FcMs/cYnLWnL+AXvhkXyNPTnoI0Sa0x/SvBOxTQVescfhwAr7r5shaqMc00PL5gQwtDnzTq/H7GfNH/X7qbMRHdKhBukTpsxSanxbnnNZaGDvsR6QZkn14BeFxPvnw7MyOP5bh5rllEO5/U8NX9tSIGD57oBOspGu9ihj0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0DRh/8SiU2IkLlkH80jVC0OeMQQUzJQDXF9leAvFjA=;
 b=aadTHv+fk72axroyd35ClTut56Vk1Bzmsb6HcBSYr4dzaI2ii+YNE607BZJH+kthZY7+I+8IMh3705UYaPzif6IUgcsz2A4oQgwxdplJOfLyMAbeh3mBzCoZ8Xnvv07If77ai6EeWsWOran4pim//8bvtxhE36xXlN5IogKfTnk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SJ0PR10MB5488.namprd10.prod.outlook.com (2603:10b6:a03:37e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 01:43:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 01:43:46 +0000
Message-ID: <e30f95c3-ab55-bb1b-75c1-8bd2f91787b5@oracle.com>
Date:   Tue, 26 Apr 2022 11:43:38 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v8 01/10] kernfs: Remove reference counting for
 kernfs_open_node.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-2-imran.f.khan@oracle.com>
 <YmLRxWUnF/zflEO2@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YmLRxWUnF/zflEO2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c18a0f3-9c23-4726-1f2d-08da272633ca
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5488:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5488621193D4DAAE40E9C898B0FB9@SJ0PR10MB5488.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRz9Q+vhXGYnSLdfNfoio4Sa7wx5636qQ0HLLai4CVD5X4x8j8xZm+92sabfXR2OhzdYTnSCAsJ6LOZo0g8ShrbkghdcFcVYLbQC+zMQUrBSuzGT56xtGLtcfyrkAIFt/8MKTWHQ10LsoW5R5wt6fssbQyZ2pIvhx6LezPwRfBF8dUEAtSbCXbSEtvLdvEREnyvXl1RaH0i6HQHxqORNo3pGImXRDW/53DtGBmnMOn1P2hzk5hnG2kq4vF89slBmA9Dlx92ZmJxeIQKtBv4TGLqIpNktFnCO4oAY58DlsgvlN6GJDDWQYii4k3lUth3JqzfngrrmHxmryHZGm+1DSLRiyLFnNX4sb7PrIWPxD494SJipQ6bkEZjVfgGapdGnyhsYtF71ge7e2Ijjdruybu+T+efUUBd+tXlXrHNTE/UGZSdAuyCx291eJZ9C8KSbF1enqL0XsxPpFjCr9/JJfrTtdXjaO0WR7jwGWyWm3DlDz1yYanLaQiq5/VHqeCQ+vxW/Lc9DI3xB/8pCvS7ISAwZ8zbqoubFgyZq+JJLaCOfAeCbxIIgXZ4hzyPMA3VwE2khDoYMxmgsy0+Q42uVH01257LvptaZFHHy9igKiA9HYekPoiUD0uoBK4rgpW/GNwMEv70g/vTdCS7ntBrP7MzapGd+naCpncfodWZ5pW1a2erwxVhLUcA11T4WJwNrMfyTKuQq7fbvDXYuIMrOdyDuBbxOyEhVRHINLQwai30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(86362001)(83380400001)(31686004)(6666004)(26005)(4326008)(5660300002)(316002)(6916009)(38100700002)(186003)(66476007)(8676002)(53546011)(6486002)(2906002)(66556008)(66946007)(508600001)(6506007)(31696002)(8936002)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVNUVM4b0NJTllCY3JKYUcxTXRhcnA0MVIxN3RTS2t0VUVtbGNuRmxKQ2Q2?=
 =?utf-8?B?TFRjTDRjYmlvZ0Ywa1lzVDg5WmhMclNzc3JyNUprVkxxOXRwT1ZsUlo2NGFo?=
 =?utf-8?B?UFFnQ1BQTUh2ajg5ZFVZSk1ac1Y5b3RYQTlLNlZZSGt2ZWZOMUZMalhEanhz?=
 =?utf-8?B?ejRENnNkbmdWd2phTXJQK1o3VlRkNDNWaXVhQUxZZVJiRFNlTzZ3S2hQeEg5?=
 =?utf-8?B?WFZnWUk3WHpOaTNTOWs4UUdNME9sYjFVNXUxKzlOVTUwN2VLYTB1enM4bURZ?=
 =?utf-8?B?NVlHQ2RMcUE4Zk9tcU9CSFlTZkJhWTV4a211dUpwZXhkQnZFUnVJc2tBcThI?=
 =?utf-8?B?WDY5cDVyYlF1U1FJM1JMV1J6Q1VnZ0R6NEV1Mk40Tm5mWWk1aVFBeGFtWnp1?=
 =?utf-8?B?U1dkZVVyd3dBY3JyUW1QWVFPTXZEQnlwdm5rSVRMYkMvaHliS2JySmlxb05v?=
 =?utf-8?B?WStuaWNVc1JURlU1RDM0ZVZpcHZoampaNHJzTHRMMVRib1prOUUvNmlpNlls?=
 =?utf-8?B?V2NCd2s1NVc0S2xRcVR6RlByVkVjZUhnQ1RjY3BMRXZaMS9mMXJDSWp6azEr?=
 =?utf-8?B?QmluMjlJZG5XYWdxZzJqSkQ0ZHB5dUdVOTFsckVoQnd4UzdvUzJoSE84d0tu?=
 =?utf-8?B?OEpmQXpjUDd4Sk92V1pGM2lKZW02NnVVbGRscy92Y3FhN2FYYmI4L3ZRclZM?=
 =?utf-8?B?Qm5nUmpoZzF4blRnWVFWaXBJRUNWZlNIS2E4UFhQSjExcU15MHJrVzBwcDBC?=
 =?utf-8?B?OWZFRE4yb0g5ZHFPQS9CbEtTVklHbGxrWThDaFcrajFURlVxTE9pbFpJaDZv?=
 =?utf-8?B?Y3VFZGlmTGxLY2RybnhsTENEc2VGNUdpTndIMmVyMnd3djhpL09Od0s3dVpn?=
 =?utf-8?B?YUR0a3drU0VmSXBDZ2VKak1NQ2hJc1A1MDJUVlBtZWxJOEs1bEd2RVRZOWRs?=
 =?utf-8?B?OFp1ek9PcWxGbmRBUXZlRTdHd2dHdEpSc1dIYnJJWXpmRzMrRzk1NDByZmNY?=
 =?utf-8?B?R2N6dUxhRDVwUTl0YlphTGF0U1pjQ3F6V2VKRlYxTmRzcHFDR3BXazU0bEhr?=
 =?utf-8?B?azNMMUV6blRHTDcrWmtjQitjOFA4eXVrNGdHNDRkTERMWHR4REpiWDNsYjBx?=
 =?utf-8?B?UUNRM2RkZ3pjdFU5QllZQWZKSWpmVENtekVWalFFMXFpMWRoOWpwQmdYYTFI?=
 =?utf-8?B?TGgrYlpPdmtUZ3BWUEV1M2hyODN0SFRZQW5CYkZqbDd4Zjg1N1hTRlFkdi9V?=
 =?utf-8?B?blZIWXNTUHNHSzNoTFhQOVlxRTBrODN2dURTeWhLS1Y3dnk2eUI1YWxFNlk3?=
 =?utf-8?B?NjVVcVVrb2dpZEtoUkRXOWlPczd3c2pmWkJzMG1HdzJka1B2OFJndHNMdFZZ?=
 =?utf-8?B?ZThCQ2kwTXJ3MVA4Uk1GamlIVnRIckVGWklMTnFkQlRTeUJwUjZNdXhNOXpV?=
 =?utf-8?B?N3V4ajFzVzVaTGtZUk1YRDVEaXpDamVKd0YydktQS2VUellYKytiRDRYRHpQ?=
 =?utf-8?B?M1d3S0FoUk9Pc2JMM2kzRHVHZkZhaUtJdjhBKzZ1aGYyMy9zWG1xWHhWVzhn?=
 =?utf-8?B?UjhvbUg2R2drSjd0bkc2TUZmUURYc0N5NmR5NGtGOHNhdGVjSmQ3bXE1eXJu?=
 =?utf-8?B?YUtja2JZWTBLcjdXVGRkMWx1NGZsYS9RY1JCbjZmYnRYTlhWUFBNNXBIeDZJ?=
 =?utf-8?B?RXl1OWNJbUJDK1R0d3NsQmZmZ1dmajdCNnpQcTE4SEs3MFlZeEcwZzlJaWV4?=
 =?utf-8?B?RzBCSVl0YktJSmJMeEc3Q0RKN0MwUUExYXkxK0pKa1hSdnduMEZ1OWNRcm5M?=
 =?utf-8?B?cU43d3g3T2ZtcHpEM3A1UGxFMVJSbk5oMUxlYXFIeGNkUE14bWE2V2pGRWRN?=
 =?utf-8?B?b1hRMjBTbnlxTGJUcWtReTNsTCtWSFBRSWRsaDI3MnlRa0lmdEo4SnViYnNZ?=
 =?utf-8?B?RVZ5Njl0TnpjWDI5eTFBQ2xQc2Q5aldmZVFWaVpuSmRSZEorQ3JnelVUcHVm?=
 =?utf-8?B?MnlleXY3cVBHWUVFSXJCRU5VaDBjbnl3Y1Rreks5NXhHZXlhMjdvOW54bUVI?=
 =?utf-8?B?RDRsb2QvYVVJS1dGUUJXeXJ6clZPNk5vNjZveVBhQXdPS0hkRnNVTUh0NHhW?=
 =?utf-8?B?azdvQktGbG5kZi9QWTJCSVdHYklQbjhBZmxzeVExNForemNYaTBFV00weGdi?=
 =?utf-8?B?VElNTEc5VHJWN2VsVkVnWWlJaW1ReDAyUDBCYjNFK2hFa2R0U2hVZ3BnMHVO?=
 =?utf-8?B?SUYrV1ViZXlvOVArVWpzMGhlSWJTQXJSSHZpTUM2ZGx5QlF1cnBmQjRVM0RI?=
 =?utf-8?B?UXZET0Fab08yZWk0SU9mTU41dlZRQlpXRWpPUGE4RXpiNkt4c1NlYVlRUUFN?=
 =?utf-8?Q?L15dKub4eJLCkYr0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c18a0f3-9c23-4726-1f2d-08da272633ca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 01:43:46.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gANSkB1EJsXV1X2RIvWJgdgg0uX9tDFvx7W3XdPmhTYgUwdoc11QECV8cdNqfJ0nEnT31hny2XL4pgZjfn2Sag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5488
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260008
X-Proofpoint-ORIG-GUID: bFEaOO1bP01DRbKk30dV0Jx9ysiUKoiD
X-Proofpoint-GUID: bFEaOO1bP01DRbKk30dV0Jx9ysiUKoiD
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 23/4/22 2:03 am, Tejun Heo wrote:
> On Sun, Apr 10, 2022 at 12:37:10PM +1000, Imran Khan wrote:
>> @@ -768,15 +765,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>>  		return;
>>  
>> -	spin_lock_irq(&kernfs_open_node_lock);
>>  	on = kn->attr.open;
>> -	if (on)
>> -		atomic_inc(&on->refcnt);
>> -	spin_unlock_irq(&kernfs_open_node_lock);
>>  	if (!on)
>>  		return;
>>
>>  	mutex_lock(&kernfs_open_file_mutex);
>> +	if (!kn->attr.open) {
>> +		mutex_unlock(&kernfs_open_file_mutex);
>> +		return;
>> +	}
> 
> What if @on got freed and new one got allocated between the lockless check
> and the locked check? Is there a reason to keep the lockless check at all?
> 

The only reason for lockless check is to opportunistically check and
return if ->attr.open is already NULL, without waiting to acquire the
mutex. This is because no one will be adding to ->attr.open at this
point of time.
But we can live with just the locked check as well.
Please let me know if you think of lockless check as an overkill in this
case.

Thanks
 -- Imran
