Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D885913C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiHLQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiHLQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:13:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A5A61EA;
        Fri, 12 Aug 2022 09:12:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CEhwwv007044;
        Fri, 12 Aug 2022 16:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=djusEIYsii5w+xqHVjtPQ4uWmW7N7lEQltc9pt/K3YY=;
 b=kX8egjD6McxK/6sEyBRfOh3b39kWKKBiPxUhv9qX1NWizQVuUIXUngTMJWJtaoMh7NUB
 PFSl9p1FgHYvLF23780eDtxVjGjZUkkgLrq5BkjtRF5vTrgaNwClnZYFyngMqGqQAR4/
 h/WH/3GjHJTputMlBrH+QMQeQoPv5pYKGaE/tc7F32YqfaiPwf0l1ou0S5PbdLkzWGPy
 yM/wc8XxGGUD2fZ0ZkD0fu0JNRHV7eSRUblRjfJQj6+IodCu3AxggcsA4ijKeQBn7lNK
 c+jYRffveAGzmZK+OwoukSIr2Oo3FZbTgS6CjZPpbUcF/tMjkgaPFTHKk7A7mcB10vS4 ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9qncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 16:12:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27CF65jq019052;
        Fri, 12 Aug 2022 16:12:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqm7xbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 16:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMAAwAkBcdP3ILPKYzRJ8ynsGiBO4JegkRwm+GO/DIRXaq0h0o+qa4lAbD1a1gDj3DoPgj7kiC4zK7MM5VCf4CF38oWSUnxVyre2D7Re8nduK7U1CmQbZn57bo75TL17JuMqzJYxMU2f7jxchPhhCSsihwmG2zOqTYtWukmA+47dWq58AtjwDPzPBMUkcI4XkBcJxEZje/XfMEFfxSvr7Jz8zIq9o6brR94b+LJkEuascXYeElp+w+1C0olzN9J9EO2w5R856mPEcn3NNgN2VC1d15uN6FRK+yWICeS2FkTivQvi7/0I20AhSdppQemi9bi0NWr7LHFJbc6faYQ2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djusEIYsii5w+xqHVjtPQ4uWmW7N7lEQltc9pt/K3YY=;
 b=gM6V2nCjbTj3DM3dzOAbgrKG3J3deZB5eHAGVf5DgVhHyROb2cO1evQmXoubuMi2LJU/TG/Rz/oyxEzDZHAXpTaHCMrb73Hk7jw9CkEjwFGmrnu1RwbR6j4p7IaMEAUQF8XQWzt+OzYnZK2WW28JAr7qRdvZA+6lJOgVclYqbWEBiQJeX8kqBUKrDMBJUSN1RhIhgI2lab8DWpY47YrixsZaJINySE7PWZ2RnZwzKDI360pkqlCmH4WStBUb79bFkqYDyAILMF6fWo0z24nwXNNklZsPRGttCgQG3kQaa3jfngNgSaZeKwmbPBbIQjOFdHtzhFQCjQ/61SFxzaTdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djusEIYsii5w+xqHVjtPQ4uWmW7N7lEQltc9pt/K3YY=;
 b=LTcyuv81dfByS5tI2ATGzuxoojYa10+od/IgpJ4RSzxdw4qtCUmkJtTu5IPvgjRo0icXCYsR28bI0UZ9dAyJLHgulLLWmApB319KLKaJ5vgbj23IVZZWQF/f2QvQjsn7Gd/qOYY/rK81BTEHH94qYe6pix8lLfMcDv0qEjIEMew=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR10MB1397.namprd10.prod.outlook.com (2603:10b6:903:27::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 12 Aug 2022 16:12:55 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 16:12:55 +0000
Message-ID: <dd162258-bd3d-af1d-179c-e9d412f3f5c4@oracle.com>
Date:   Fri, 12 Aug 2022 11:12:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] scsi: target: Save a few cycles in
 'transport_lookup_[cmd|tmr]_lun()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <e4a21bc607c39935cb98d4825cd63ba349820550.1635974637.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <e4a21bc607c39935cb98d4825cd63ba349820550.1635974637.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:610:38::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d48ee3-0bf6-4561-65a7-08da7c7d842d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MhPrLX/0srryXK7OTCB2H3JpWM/9I9AKi1bfl4PCoBrwgoI9urTnsxAE2ivDs/jvfLS+wxaIhvNjf7PDnA1v0TQ6OP4eZuV3OGF8yGdm7kChd3siTaopzPPHi80jiydvHzcZymMvZ2wpPl5E83QmN3kn9fQg0/WaPYjZPXRXnCHorAbT+7hS7Xg0jmk56x43V1SlMoPFdsDz+kc3ipkKvmjCS66oqREAICwB52KpmmHMMNlE/tKHfMs2A+/EBBdYx7emnRBrMjfKBYXiCVInxPd5IW36+A3Dm2LRgmMNmbQjVO0sGUX+vR9SvuGjaSowu/WlMLeEW+k/qfGSZJgMr14+8DcYvREMdrkYXggnwz/nFe1xX5ixMz65zE30hpGNAwTAFMYHwx22dLCFuPrI59GChT+Q+BWl0UdNpa6/7eoRoD/J4byuC4mywek8fpNKivxHtiM3+ZoWEnFqvU0Ga40GzhbeUa/IrraensL/hjWITlls/jzqVPkz1UE7dd1r3V/GMjFt4EeXuMkcSvvOFIxzPjL+gU1zzpcNO6dN7AWHD9yZ+Lmw/HhkEFjffgDRIpgtCdfyrSRsKDrMm44asCr5Y9A5KWxWQRxxczhV3Dstp2in+U1E7latSm5XnM+koNu//0X/nTuFpVUjbpVoetEVirg7KjI9UR2gPO3GEQjjqJJP1+cU/ZMbWHv76BpWhAa9sllQ2uEJRwc2dueGl2UMs6ykXN9SNTwUdWnZTlzYfQIPR06C0QK91U+ruc/DAPoiyLq+bXv7UYOah89JAszqFnETXnvNIL/+d0HSEns2oAvApe9s+bXjBnbdjseitkYM++EO8Vg5aMWYPe5epJH5/uHdqe3salNn+p9xtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(31686004)(36756003)(83380400001)(2616005)(186003)(316002)(2906002)(6636002)(5660300002)(6512007)(41300700001)(8936002)(53546011)(26005)(6506007)(478600001)(966005)(6486002)(38100700002)(86362001)(66476007)(31696002)(66556008)(8676002)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWl6ck11OW9DSElwTWdUbTR5bEE1dC8xOHM0RUIySEtJSW5CT0VybFpkSW9a?=
 =?utf-8?B?Wm1LQ0tmaW52ZU04TWZGbWxTaGZMYXgrUVdOdnVtQjVZT3U4aXE3RHZPNjVw?=
 =?utf-8?B?eFV5NmZUUStuUzVHbXY0NHhQc3dBRGRaSWVTaXBHdG9vb3RWWEE2OVZXRE5z?=
 =?utf-8?B?cllrV0MxNy9OOHBMdjhWblVMdWtNRlZuMXFScHVoaElTbWZhSytGWEhrSlg3?=
 =?utf-8?B?UlkrMlBJbkJxUjhQODVtUFJUbTFuRy9YUitJeWtaWmpxVGF2NHIvaXB5S0t2?=
 =?utf-8?B?RzRyaGFIeDRTRHFVRTFHUkQ3T2FtYktzSUV5M1kzblBuTS9JWjZJMjJXRVNp?=
 =?utf-8?B?ODEwVTNEU2dvK2NFZVBlUEZPaW5KYWhObWdlVEdlSlJnY3FYV0dqSUw5TVN6?=
 =?utf-8?B?OW5IN1FzMHEyUHBVbDM4WUVSUUdtU25PZWFhVm9FV2NZQks5MVBCdHM4dGxF?=
 =?utf-8?B?UDRtTm52ZmhyTDJvOXdNV1ZOS21XTkpKUU5VdkJXd1lrSkV4UzhjNE5vbUVi?=
 =?utf-8?B?bHl3Vi85T1Y1VnZrRnhzaWVrNFcyUEZDWENhVzNpVHVIT3pRTm9wZHV3VE9m?=
 =?utf-8?B?RTVZTHVxd3FKRHVKQk5FUmdEK0VKODB1UWNsM1hENXpzcGttM21tRE5CQVpt?=
 =?utf-8?B?ZXMyWTc2NTF0MmQxTHNDcksrVUJCb3ZPUzZlRUxWUkFZYzRRYnJUNWdKQVhJ?=
 =?utf-8?B?ZzNLSDdRbVAvM1BnT1pCMTltRmVGSlV2M0Y5QVBEWllPV0xKRTk4VFk3ZHZv?=
 =?utf-8?B?aExaeWszaVphL1gyQXdYK0JnNHM5VTVMK3h2aENVY3hPdmE0S1Y5d01mQVRk?=
 =?utf-8?B?RUg0Y3lSbE5JZXJKWm9xQW9RaElrRSt6dytvSVAzdEFKSjNRMTlhSVA5L0VH?=
 =?utf-8?B?eWZLTTNhK0R2bDQ2RHV4b1hYS3N0RE1iSERHUEF4VzZzUDdGazRRRWQ1di9H?=
 =?utf-8?B?SjNjZFlyOHBLbXhBRVNzZU1jZmd4RytpWkRad00weCtFZHRidDZmVXhnUlBP?=
 =?utf-8?B?YmpMUHJuRlNySVNZOEVoWWsxeUxnZUpaalVBbXphdUFsNFlmTXN4ZWhWR3FX?=
 =?utf-8?B?TXI4VVJOYXNmNmZRTlNOWlhheVVlaEp4M0V6VXpmVE5DdHFhTmM4MnlYOE1j?=
 =?utf-8?B?N3laUDZPUHdDcW5sZGwzcTZwWmpEU2R4ckh5dlJkM3ZhTSt2Y2lETXpuZW01?=
 =?utf-8?B?R0EvRXJmWHRTbmFSK2l6YUpWTUFPMzJvSHpIZnZZT3FXL00xa1lmWkJyaVVX?=
 =?utf-8?B?Z0tzS0g1d2RlazdZNXpwWXRpQzU3QUNEQlpGMFdlMnZJcmZ4dFVGMGtXMnNU?=
 =?utf-8?B?QnVhWDZveGVLWU8yTERHZDRRbVRwTEJaRnBpNGRUSUVwek5ZUkVVMXhhSm82?=
 =?utf-8?B?Ynp6QnZrMmcvTm02VHZKcVlyL2hBTXpITFNoMURyVVNjYWVSV21sbVo2VDNF?=
 =?utf-8?B?eWQ2MllYY1dHMWhmbHk1L2J6MjNHbm5SaSttTXdjS3NEa2EzYzE1Vko1Qmho?=
 =?utf-8?B?TWplazlJWWxaM1gxMlU3aXViL1NFcUJlcGhFUW1iYWp6UGJOdGQ0cTh1alBs?=
 =?utf-8?B?RUhsWmp1TC9aeFdyRCtiVzhyNXFleW5OUERrYnpRVGVReFNsbzgyUmVNczhJ?=
 =?utf-8?B?d0V0RkJwWXZlaTd2YlhqOFJnUGliNGFMRUkzVTg4MFdYOWpXbUtoTXRqU0Ra?=
 =?utf-8?B?TEQrdmVWQTVmYm9JUWFCL2tMN2JzZ0xKZTF2SXA5OTJ2bXliME5aODhaakxu?=
 =?utf-8?B?QnRRZEFqWHNYeEd0UnZPMDRyZFZ0RUk1VVFGQ1B3L2RDSVg0anR2K2VYVzh0?=
 =?utf-8?B?c3RxVmFlc3lySXRrYVpaN2tNY3ByRDFCeVp5YUVFem9RM2o5NHhSbzhzWEJN?=
 =?utf-8?B?U2hoZGNjWHZIMmh2MmFJcUltQ3h0Z0hpRGZQWHVUSVE1eStBVXVhVzhtWUto?=
 =?utf-8?B?L3RMbG55bUhJdGsyRGxmTm8wU1MwTmwzRWhqQllCVGpzVFUxTnc5NTBaNFBx?=
 =?utf-8?B?N2VEYjY1WW9JeHFDRUYzNzhLcG1wazIrRHJNVGgzQmlIY05BNHlkcGtMWEwx?=
 =?utf-8?B?ZTBURTkxdlJzeFVSYnBVNzUrbk91cklOU3VPOHo2SWI2Z2lrcmg3d0RxME9i?=
 =?utf-8?B?SnNzTERLOVk4OWxrdEtMdXlTUExCUzQrelRydjVYc3pGZFBHbnM1K2hmbmdX?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K1RkSGo3NHpjVUl5cU9ISFZXRUJhVEQ2UnVjeG5WK3RYOGpzQ09pMFFRNllv?=
 =?utf-8?B?TStaY3h6UnFWWHBITmdXMWMxQmlSY3BxcGZDQldyR0ZyUGgzMks1T2F1eGln?=
 =?utf-8?B?dlY3UHJwR2ZLL3lyQ1lHaUhXZ1duNnN3a3ZjcEMyY1JKYmlkYkxPTjhIZnNW?=
 =?utf-8?B?djF5MC9BanhsbXhaZElXTUZxTWxqSjFnRWpqZ0w4Ky9VREpKQkxXckE0dzJa?=
 =?utf-8?B?VlJlbWxib1pQSUhuUGVDN0hCdENTaWpFVVVKRXZHSUJxZEI2aEpUNFZIYUhL?=
 =?utf-8?B?NkthWFFXRDdoM2RRSGgxdFR5RDJ2U0QvOHJCN3hQQ3RoOW9udVdRdHlxMlQ1?=
 =?utf-8?B?MWdUNDlVZGRpckQ5R3ZydDBxMFZpNHgrald3QXNBN3JaN09zalIzVGljblNu?=
 =?utf-8?B?WTEzemJDaEdoQ2Z3aDByODMzd1VyR05nTmIyeVM2aEFLNENZY3JkYXVoYnRM?=
 =?utf-8?B?YldlODk3bDM2UG1YcWRRUjdFQ0M5MGcrZ3RvTFl0aFRVbjhVUXNETHQvRWtN?=
 =?utf-8?B?Y1hXQTN2VmxMbENxczF6T1kvTCtycXpiWXZYQnp4OW9xNGZnV1c1N0FaSys3?=
 =?utf-8?B?SWsvU1BNcTYzdXhsVWNlL2lJWHA2QndDTUNZRjloTzhoNXQ2YzY5WU5VQTA1?=
 =?utf-8?B?ZTZxMmo0eVRxUm5JK3hmRTJCV3ZHaHlHZ0VjU0lEZFJaQ092WjVndDRWVU93?=
 =?utf-8?B?K1U2ZTRmZnlraEcwYmcwS2I1TnFQYzdmVFdVZ3gzeVpXSVRrR3VXRWFNZExG?=
 =?utf-8?B?aVJsdU1sMWZrTGs1TlJ5Nk84dUJ6NVBGTmMyaDBQZmVUdHN2anY4S3JLclI5?=
 =?utf-8?B?SjNqc1FJMGVYU2Jpb1RkcTg3Szg1UzI3dW5acWo1OUFWWEZsbytKWWQ3TzZ2?=
 =?utf-8?B?Mzkxc05SdGRsZjV0TzhhdlpoOGZJVTdIOVhSZFllZFZMRXhwb05xTUlxY29K?=
 =?utf-8?B?Ymk2czg5Q0lyaitwZ0VIRFpuL0s5QWZJQVhWa1B4b2pab0xZdVZBS0huWHRN?=
 =?utf-8?B?RFREVGEwLzZuNzR3ejNJNnBlS3Vha1NLdHljNytaMTFzWm5XRUVMa0hGb1hr?=
 =?utf-8?B?Vkd1MzRkS2ZScGJiSUFuQXhsKzVFSmp0V0ZLRzBIYk91STRSVnc1TS9IbS9t?=
 =?utf-8?B?bjU2Zy9na0lDQzI5OFEySDQySzBKSDNkOWNSL04wdGg0WDk1UlVLNGJHUU4x?=
 =?utf-8?B?RWpJWmdhNHZ3K1o1a2c3cnBJdkZZYmdUSVltcnZwdjdsMVNqeHFpb1dQK2Ra?=
 =?utf-8?B?UVZYbE4yQWZsZGI3ZCtXT1djNDZYNnZNaFlzMERpcW80VU0zZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d48ee3-0bf6-4561-65a7-08da7c7d842d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 16:12:55.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NTDFfMbwRmYRGvbpHQyGEIBON1UvetaE7hKveAhS0WyBeyUX07xftb6+1ri7IK6IkuMPXnUqYR23deGpUkthvEBN+/Oe6LQhfr90JhhcgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120043
X-Proofpoint-ORIG-GUID: pfTVdNmsgItO7XTESh3R1CeTm1sFi-4f
X-Proofpoint-GUID: pfTVdNmsgItO7XTESh3R1CeTm1sFi-4f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 4:24 PM, Christophe JAILLET wrote:
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/target/target_core_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 44bb380e7390..bfd5d5606522 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -77,7 +77,7 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd)
>  
>  		se_lun = rcu_dereference(deve->se_lun);
>  
> -		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
> +		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
>  			se_lun = NULL;
>  			goto out_unlock;
>  		}
> @@ -154,7 +154,7 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
>  	if (deve) {
>  		se_lun = rcu_dereference(deve->se_lun);
>  
> -		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
> +		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
>  			se_lun = NULL;
>  			goto out_unlock;
>  		}

The patch looks ok.

You just got a little unlucky because the Martin just put some
conflicting patches into his 5.20 staging branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/?h=5.20/scsi-staging

so I think you want to build your patch against that tree and branch.
