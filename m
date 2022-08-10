Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8A58E8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiHJIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHJIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:25:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085F321E1A;
        Wed, 10 Aug 2022 01:25:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A7iQKg017697;
        Wed, 10 Aug 2022 08:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mTUfvC8+CFDhkKSOPwEWZvQ6my+9oevqjPA2FYim668=;
 b=mJeGZLGjfXlareI4tvGVHMpfEt7q2rbvUSyxjiUkDBWkNeULcVC8ZJySkzebvG0JAtwr
 SzZ0LevdcOlHK4AVCKulEhyrjPbM/FHLaeFB3BU5G0A+v6LQYZdo+HczPDzEVFgvoc2R
 moIIa4RZsiHoRfr8UcmnAwfQ/cf3NrvnqgfhS4hD4PwKhMP+TyqgGsJkjNr8v2m/oUSH
 ui6TMCyaflwiI9OxpbSWxoEMfBQYWVbe+QHPXAXk40dOug5GkJZmPDXbypnnZWqfZfRP
 86PawqfBDR4IUiC3LI2JSs31v8vfxBN1e8rpudRSbP1hdUQi79sFNhdDECFiIoHFrHtC mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbh7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 08:25:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8OhmW015334;
        Wed, 10 Aug 2022 08:25:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhemcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 08:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c32UwG5dqrVRdx9R8XdBANLYqq+OpijMgo/SyA4KuWGf5daQ23J4KXdK8MReuLLds9wz7HAONNPQrd+wu/URVU83xZtJ5av8m/pUZ6bkxgXI53z1SQOs1KQpnCwwi98L732R+zXvDOphgSDbSuNNTwfhhsJnUQWAN+WojBm64GKutq8IIFOS//9joPBAdVCXK+OKrdEe1bfVgVtnBy+8wz30gpR65Dgu6/aNHFGhlcVc8s7nVxCViY9FgyeaQyN5ueftdmD7Jn1UTFB0/WF+dGzlVMlYU9B1A4IfHb6HSLhEte6wN0rDeQrCA9/tvFK47DL3IFP+whoiv7GFMk41WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTUfvC8+CFDhkKSOPwEWZvQ6my+9oevqjPA2FYim668=;
 b=S8Qfci3a4ao7n0Z3gx/Sl5M1RRytscwr5fk5AWXV3xVtYzJcuYx/SpLLS33OH0/246r2axx+lWplny3kuou/BoO5eT94q7bxVNfpBBpJYT1GOZGP60D38VGzMGiPbGulnluSe0sCRoKGAlUBPnhYU/kfegqSvQiTWRd11vnkyzekcZRQmngE5akdMpuM1aFbG4McIuUfYhrolh+CI5mNqAm1G/VHQ5JuC/UzwWfGg988Ek1OUOe35x0UDSVzbRBb31Un9cj76LzHPG0zjPXr7WHr3FLuog5lovAYSvSWQ6ej7URyUQOZuVvGYKxFbyCd830uqgGIct7/kH5I2eDrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUfvC8+CFDhkKSOPwEWZvQ6my+9oevqjPA2FYim668=;
 b=UyDXKCG0ksANeE2H3W8xNClgnO1mA0lcyKxYVNN8GbcHwOYXBh38PzdJtsN/2vSKb2s5Ytm7D9luvPLYQ17Q2f6w1749FgNzpXO5p7qzq1Ef7tDGkoAOFK/h1QB1XDqu1nKyFKMhk9VHY1DS8IJU7mMWk+b6Gnys6vjtRMDU7RY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO6PR10MB5636.namprd10.prod.outlook.com (2603:10b6:303:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 10 Aug
 2022 08:25:24 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7%9]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 08:25:24 +0000
Message-ID: <d4ded816-ec34-ae1e-b8ee-a7d87c924f1b@oracle.com>
Date:   Wed, 10 Aug 2022 10:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
 <202208091551.6879CADA0@keescook>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <202208091551.6879CADA0@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::7) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee2fee21-7791-47be-9e68-08da7aa9df57
X-MS-TrafficTypeDiagnostic: CO6PR10MB5636:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WJU/r28snAEO7cnNnILhdRvm9gzk0sSBqhVroQPrKtGunRMIoBIf35FvIFmlFZdtMp7m8KT+Kgo4aivHQXDg8VDyKbPt87GMXrPDhl7pHJyjr6LboC+igwJgW0IY0fjlvcTdd6fX3ugQ1e1JqJ/4XImK+sJo4YDEzBFHiLgAskdNUw+X/YXxmZluwQZ0wBtEO+knpZ2KMgwRsn9WP2+SiREQ0IJUtDDaMrUzMw2xaUExSVqL+3hQoB3/Tb6lLVYQV295RFMVW4I3NnINQd6EnFbwruz0VRE3gzwWH67ck1XLH80L1ykFtZTCFOe3FzSZYrA53OFduK3xgnpq1twA2kJB2KzypUe1j5BJE6nLHvBSYekWc2lyPNhTzIk4QeIuoVcInAQCwR7VFrno5qm1dNHuJryYK3eBJBelN2U4m/m8XEq8djxdL0tl9r0Zn1mE8YN8/YgPcG4sxb7l/ELlGDSdrp+h0zJC+69GnHqUctZJrv//cCD5DW3CxmNGeAfLLY8WxD11bji244GHP4NWwh6fc62VxHt5q+fiiN7z2mqaGQyDj6WYfrz25c0bcmA15uLkgFz4G2JCFGIi78pr9TCkDRfZI9OZx2gqyTBprtg76rh5mHgJbbGwY93WJ6m/TtzVf+RNe9KIDyb4/1SS8K4W2uFjxDO2q5J+ces5XaEEHKwvKJQe6T+3hh99qhY6TEqr9I8Nj9GO2gNO0AZDMf1rHm9fypjd1XW8bxAgomQ8LkTvWmn8f2t6/E6r/oE51saIqDlvmzIB9hXlDju94t9GcemOInM+6WjKGcfHVuwjHCCKGha+BbLbvrWqjookvHcBkzIlESs+UnslpC4g/0PVWQ9L6IYp9RosPs66yEeMCELzF57rQHogY2VeAq0gdKAICCL0Foqwmzh9ug1DGFl9tnz1AHeZtXK3YmHBho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(86362001)(31696002)(6512007)(53546011)(6506007)(6666004)(26005)(38350700002)(41300700001)(2616005)(38100700002)(52116002)(107886003)(83380400001)(186003)(66476007)(4326008)(8676002)(66556008)(66946007)(36756003)(44832011)(5660300002)(2906002)(8936002)(31686004)(54906003)(6916009)(478600001)(966005)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlxL2R0K1lOdWVvc2paS0srL25vUjJsRHNkN0VzNFZrQmovSDIyQ2RhRmJU?=
 =?utf-8?B?clZmaC9FUzdKeTk3ak8vNGJydDFzUlJ3akJtbC9XZ3FKNlR3WjZjZzBTSnpY?=
 =?utf-8?B?TXZsL2lyK0drSDAzQ3B3R1o5MG1PdFJhVllNWFVvcnFSYzNLajJGUDQwSlo4?=
 =?utf-8?B?U2p0SFFmeWcrUjdqVk5oQ01nOW9WOHM3cDVhMThpSTBBWFhTMkpHWE5LaXNI?=
 =?utf-8?B?VHN6ODVCY1NXQ3RIeGU4dTRQQzJ2MFVhVHNETStkYmNvMWFlSGplYjkrYWFD?=
 =?utf-8?B?c2hVck15R2laS0VxU1IvYU5aMU9TK28xSVVpRVlJcHJTSittdlFrTGtoa1d3?=
 =?utf-8?B?bGp0Nk4yWUtkeEtJVmp6RW00aEExcDlERXdFTDUxVGVWd1Flam83VzVSdCtr?=
 =?utf-8?B?ZTFpU0tMWG93amlqV0hWWFF0Z01SeFp0bGozUWdjWEF0ak9LamR5aERXcUZE?=
 =?utf-8?B?Zm1LYTlwaFcyRkx2VVNJeC9xQnI5eUtBem5HSXV5Vk1zelJzak9seSt3S2JR?=
 =?utf-8?B?RWZDOFg5TFJBcUpyZnR2emN4MlNoUmc3L1NYQStRNnprMTJMY3hrbjdMVnE5?=
 =?utf-8?B?cS9ZSElsTUhyMmRkMDk2THpFak5YaVBzOEYyR1RHdlJta2JhY1F4cFp5SmYv?=
 =?utf-8?B?aDdtNFZqTXYyaTZJbHRDYkR0dDJxaUNkNHpaZUV5SWhQRGVsQTBGZjk4cVZx?=
 =?utf-8?B?TGpCOWQxdS90b2tBTmRyVmcvVzQ4STQ1Rnc0Vy9pVlZNcGJ4RmhZYmE2U003?=
 =?utf-8?B?aGhjT2NhbTRrNkxVQ20vSWRYb2FNQ011dzF5eFNJMG1IQzdpMUtNVHZTOWpX?=
 =?utf-8?B?Y25hcVRnRkFibFRMTGVjeUNxaUZFYWgxcE5TZUlyck9rUzFVZjN4SnArZkdG?=
 =?utf-8?B?OU43NlBKeGhQWml2S0JGbzh3TTBMT3o5eHJCbXQzaGdiQ0hjR1ZTbXF2Wm5V?=
 =?utf-8?B?TjExTlVZZ1BNL2s2VTVGNWNpVE9iWisrQ2YzbzZuZmNqUTM1dG95a3QrTERz?=
 =?utf-8?B?aDdQOVNDY0VOZGNKWG1SSXhPQWp2SzI3bDV3azlsOWRBa1hCMzhkYStoTjlY?=
 =?utf-8?B?dEhyWkdDb1BpM3dWTGs3TlRxYVpLdmZkZHJCbUpxV01rQnpOM3YrSjlseVlS?=
 =?utf-8?B?aGdVVHRWZVZzUXRlK2dZWUN5Z2lqS05ET2cwYXJSVGRJZ2dIdmxuWHdaRTdT?=
 =?utf-8?B?VkZISUZKaTRPMGtISW5VZmZwaXhnRzh5RkdYUFF5aTBYcDdXODAzOUlWVUdu?=
 =?utf-8?B?TGhIRW9QMFMxTU03M1p2ZEJZVlI0SUNTeHFoZkV1Y2lUbjV2RWNZTFNKbXF6?=
 =?utf-8?B?QTkzZGlzR2ZLbXZlM1RHeHl6UlZiNXA4RnhvbVgrdVUyN1MyWlVlOWhLNFYx?=
 =?utf-8?B?cGhYbk1nM21adFJBL2MxNUtUWHBqN3VaUUpmOEpkQnRFbHdZdEhRUVV1bVMx?=
 =?utf-8?B?cDFUVDZmMmp0TFR6bFJjRDdXN2o0L0RGNnpvUDVvMllZbE1NV3dhR2FnR1g4?=
 =?utf-8?B?UTZVaXBwNVlTNEh5ajhmLzBFZFRVTDhoeUVsaWxiVjVEUnVnbHR4aSt6bmhs?=
 =?utf-8?B?b25kT2xPeWJjNnRWZitpZHlPd3dTNXBoaWZISjkvZXgzQi82bitqRXZkaUtT?=
 =?utf-8?B?bU41QkJhaTY5U0dkV0Jqc1h0Q1hFTVdObEFXL1ZROGo0bGs1aHluRzhoRmJ2?=
 =?utf-8?B?eGlabXZuQXhtbFBLRzgyOWFtMHhmUERlUENoWm9GOGYwT3c2RjZnNlJMclZk?=
 =?utf-8?B?OVl5c0JRMzZnbnVWOE5CenB2SnRwaTJLbXdCMWQ0czZhZERLbW1ybVpQdDNB?=
 =?utf-8?B?RlZtTU5ER2o0cG1KTENwa0NhRm5SeEhxTVB3WDZRUjVxaW14TlUxZ3N5emxL?=
 =?utf-8?B?UmdqdEhJaXJ2cE5qekE4elVRZy9xeDU1Z3lIUlFVd2JRNUNJQlR2MEhxeVF3?=
 =?utf-8?B?YVBodVJ1M01qOG1JUFJnNjJUaHY0ay9sUlZxTzl2UFVSTmtqOXdudXozTVVI?=
 =?utf-8?B?UzFMN1NieFhmaFhMTmpnWTNUbjBuQVRaUE5IZXF0TUlTdFlqamxKRWVrTmZy?=
 =?utf-8?B?MG9YazBrWEZUQ29UNVRscE1JanUxaG52RTVuYjBuK2NZYzY0OU5nYk5zWUlm?=
 =?utf-8?B?dEI5dEFFZlovRnFHM0srYlBxQ1hibjFrMThSQkFGMm1vZHZMNmZOcVRkYWE3?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2fee21-7791-47be-9e68-08da7aa9df57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 08:25:24.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrd4yPNJ2A2aUJoRPIzjQLU+E1tGvHiSMpv84x7Fjzy4f9RKC/A3NMUHaoK+ksR40BAr+t3RL/ShJyZ6w4epDhY0uQ8CvlAQmShN38SAhx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100024
X-Proofpoint-GUID: 1Ip2v0N7j9Z1RKez6akzHxlKvGHaUN6K
X-Proofpoint-ORIG-GUID: 1Ip2v0N7j9Z1RKez6akzHxlKvGHaUN6K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/22 00:56, Kees Cook wrote:
> On Tue, Aug 09, 2022 at 08:52:29PM +0200, Vegard Nossum wrote:
>> Creating a new user namespace grants you the ability to reach a lot of code
>> (including loading certain kernel modules) that would otherwise be out of
>> reach of an attacker. We can reduce the attack surface and block exploits
>> by ensuring that user namespaces cannot trigger module (auto-)loading.
>>
>> A cursory search of exploits found online yields the following extremely
>> non-exhaustive list of vulnerabilities, and shows that the technique is
>> both old and still in use:
>>
>> - CVE-2016-8655
>> - CVE-2017-1000112
>> - CVE-2021-32606
>> - CVE-2022-2588
>> - CVE-2022-27666
>> - CVE-2022-34918
>>
>> This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
>> 0 will block requests to load modules when the request originates in a
>> process running in a user namespace.
>>
>> For backwards compatibility, the default value of the sysctl is set to
>> CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
>> there should be absolutely no change in behaviour unless you opt in either
>> at compile time or at runtime.
>>
>> This mitigation obviously offers no protection if the vulnerable module is
>> already loaded, but for many of these exploits the vast majority of users
>> will never actually load or use these modules on purpose; in other words,
>> for the vast majority of users, this would block exploits for the above
>> list of vulnerabilities.
> 
> We've needed better module autoloading protections for a long time[1].
> This patch is a big hammer ("all user namespaces"), so I worry it
> wouldn't actually get used much.
> 
> Here's a pointer into a prior thread, where Linus chimed in[2].
> I replied back then, but I'm not sure I agree with my 2017 self any
> more. :P
> 
> It really does feel like the loading decisions need to be made by the
> userspace helper, which currently doesn't have enough information to
> make those choices.
> 
> -Kees
> 
> [1] https://github.com/KSPP/linux/issues/24
> [2] https://lore.kernel.org/kernel-hardening/CA+55aFxiDKfe6VCM+aV2OgnkzMpP+iz+rn2k25_Qa_QLex=pPQ@mail.gmail.com/

Thanks for the pointers, I didn't have any of this context.

I would still argue for my patch with the following points:

1) As you said, it's been almost 7 years since the discussion you linked
and apparently it's still a problem (including those 5 privilege
escalation CVEs from my changelog); this relatively simple patch
provides a mitigation _today_

2) it can be layered with any other future mitigations if they do show up

3) it's not as big a hammer as completely disabling unprivileged user
namespaces, which seems to be the next best thing currently in terms of
protecting your users (as a distro)

4) both the implementation and the user interface are fairly simple in
my patch, which means it's not a huge long term maintenance burden like
block-/allowlists or capabilities based on whether modules are
maintained or not (I would also argue that "maintained or not" is not a
great proxy for whether there are security issues in the code)

5) it resembles other sysctls like unprivileged_bpf_disabled or
perf_event_paranoid, or even modules_disabled

6) it's opt-in by default, and even then, if you run into problems with
containers that don't work or whatever, the solution is extremely
simple: just load the modules you need before starting your container
(the module names are printed in the kernel log so it shouldn't be
difficult to track down issues)

What's the downside..?


Vegard
