Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA55A6BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiH3SKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiH3SJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:09:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D012633
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:09:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI3iSC005510;
        Tue, 30 Aug 2022 18:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Wj6OnWM/oS1y3vdKca+vHM149hSoy+iUoIA9RBzCLz0=;
 b=MGunNnaynFneB+fOD+Mlk3z+NPoLNZClftgjCh7ZQTnnFWvQfkvf8sChUCrq6bYn0Cf/
 MuKZ+yFCuveKUWk8rb0y2SfZrbQA44Yl0/61he81QvKtUmTDoU5PhLEfknWInHwd/SH2
 xZtK/IAOLs0c2Tw5oxXMYz7tXUpBykqmlPfymWflsl/c7+fDDUkg8rf9NrYK74YtcOgi
 TOYk9m9OFwi9URQfiwOVKB26f/3+LsvvUUllUF3x5p9Ucgc+iVO7kGKwPC/s//V/Tn9G
 q5N0kZUQp9x9LUcUpL5bLwdjrtP81a/s2xpQsXgio7TmeI7jCBVizWmxoP6YscU0W3Ke Aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pby0jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:09:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI6u9q017544;
        Tue, 30 Aug 2022 18:09:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q47gb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeWqYgmWK2iMsENRSVL293fwwxZtRVGWJC297e1FXNRyxkme1KzkJEPlAysmPb5bTg68eDc7HgQgyJWARPgQWxkdQqH3RPmTUeHRYk40q6XZTEh6SS3KPEa+SKJRNQw+yCX7Yoy/Rej64Rw6yYqE5ywq39UejxPZRV6jHmVcnSMf3ckHIEjxNg6kAXCw0/0ZSwIU/8eNjq+UUFnWxI26qTlI+WEwRrPPMFXBxuE3/qzED+Y4Km0heLPMMM9+BV/YYdYcSWger0lLi8GU/Xqbk0ZvMtg7wl4Vm7bYlMi/kYufzg9YvuKmUM4K0AIGSj1nr08mM34vur3LPmAkxtBMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj6OnWM/oS1y3vdKca+vHM149hSoy+iUoIA9RBzCLz0=;
 b=A/dcEyBUb3tSGMZTOMAIhm3j4wP5sm2f/eKZwqCPipAyFJ4H8b9fTKO9Ev8L3qeZ4JF6/zq8hyGlvc4EZE0iAJBGmu9B245iIJgwkOmBNPDrfHU0lBsM1ijqdosVoG3NfS+o2uHbbSg5svQhjsefPfrXDwXXK9pNlxsvR4Jyy7QfQwDJat3h0MebM6Z7OpCI5KwER5oc61x6dr8jJd1re4tN8Re+n/pJxxNQ+eMDOBm21wVpc4zmmtBW4wwXPN0CSAtRV5dM9W/QX9eQ1mpQSlLd5CWPHYqq9kKHUQos01K+eiG1lFh3Hh3vnNlbtWqvjkJWN39ut/XqUlCMQMrfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj6OnWM/oS1y3vdKca+vHM149hSoy+iUoIA9RBzCLz0=;
 b=ZNTVjkNKA5aqEeDQp0KC0PneUWmyHCSglQpjLABaCALrp8eOssNiGGDEvwOHk91BoZp6z3/Duq8EDmqlmPfJP7dLevCUU/9e9K41Zq6j3cSmdd+jZnq6sNILlCSiroNzsQq86Ts60Or7g8FMOpzcL6mpsbtvPisWRZbOJtqqW9I=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:09:37 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:09:37 +0000
Message-ID: <12303882-dd84-485a-28cb-cefbaac4d960@oracle.com>
Date:   Tue, 30 Aug 2022 11:09:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/7] mm/hugetlb: add folio support to hugetlb specific
 flag macros
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-2-sidhartha.kumar@oracle.com>
 <Yw2E937l+GARR3Vb@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Yw2E937l+GARR3Vb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c963a6-d792-4d80-4928-08da8ab2ccc8
X-MS-TrafficTypeDiagnostic: DM6PR10MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsNH6BbvA3h/OZcOOyuKNIycaIjajfaCVt1ZRLPvCY6/4jT20LQKW+nU9qkWv/oiHCco0VyCBk2nWtlXIvgFCkEKnUblY4e26t1BOUrMS5gg6LrZh0786eOGk1zcCocN4w3DAaBpuSE7qOXLUYZNUjVHzwGGpVxvaarYekhB40Bv4eJnZKpxbz6YNBmAnEzdujKb0fiNxa8y6k4zuCoSpx1hmCO+n7K+JLnLNQEQGXMwDWG3NWf3s+XfnfAiUqLtHNo2F9BDHChMJnc7uAbIBYHqnJXG+5rvRabwdPLu5kaQ007U+KTCQ9ewEVa0fkVCY2UFkI+636KR8fntreMNC6g+i91pnE/DT9QlHhWBcP0oVFRvl/ABGgbt3ZC9V+UTLlH6YtjudR+3l0pbt3+IB0jdCJ2knCB3BoFaBkG/7VjMPRC7oTgsE+Ui1VitjOf+XF0gajQs4p3QkGy097ppEmOroXrwFYpmiI9UJPrTndjj3iGHh6L23tjzE6zvlC4G7lXUt8U7BffVScF400scUumGW4c50fT+eWi0O+lGLqU9zmT6YeYQ73+joZZJRDoYq+pBXczgOLVP4AC+oJnUHwNf+tMKr2FEaJNCnw1L6ATE0AZOSRONBNdXeuXM4R3KFIkbVK3KPl4GM4a/Lp98LCjTJ2IAz53nzfLH8zaTYslBuFj37p9SHrJFvAuDd68HAZMmcWA4gKmYse4pITDuo1o0LruUNVuhZ4OBqKWQ5QS0spp5MvC9NbaZJT+z9Qxwptu/W38Eg+Sc4knzAwcR9HOqpplgkXhS4na1LoTya/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(31686004)(38100700002)(66476007)(316002)(8676002)(4326008)(66556008)(66946007)(86362001)(31696002)(36756003)(6512007)(53546011)(26005)(6506007)(6666004)(6486002)(478600001)(41300700001)(6916009)(7416002)(44832011)(186003)(2616005)(4744005)(5660300002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUl6WWhmOGpJY1lCLytoTHhRWk9FdktBVG5DaXR1S0IyUCtxTmZkVCs0UzVt?=
 =?utf-8?B?Z0lHRTlaUk80U1BGbTJsUy9nZDBBdHNsdWFVUWR3U3JtVzNlaU4zU1ByMHY3?=
 =?utf-8?B?c0x0c1BJUXhSa2FSa1d6eTVLcWk0RjJTSVZSQnVmMC9IODhIcFBDT1B5ejJ6?=
 =?utf-8?B?aTRDeGx6LzVWSjF4YTVvZlV4WjlBcVlyajlMemprUzJJMlluTkFiSC9hVnMr?=
 =?utf-8?B?L1ZFU0Z3WU5Wb25QbitEMkZGNDZvSnhZYWpqUFNzZVNjcFJpc2IrWU1JR2ZX?=
 =?utf-8?B?SGxYZnhRT2dwVjhWK2R3UHgrRHl6SWIxTHFibG5wdmZRVU1VTk1GdDlEN3lo?=
 =?utf-8?B?MnMya3E0azJtN1k5NjhNSUkwRDJNeXZtckh4TWN1cndOQTE3ZGVmTVo2MjRD?=
 =?utf-8?B?Wk9FdVM2SFJ3UGpYekxUOEhlVTRtYlFFaVJoNGI4TE9NNlU5dURFcDBZVTVQ?=
 =?utf-8?B?dmozVEQ4eHF1bjUzb1pqV1QwNjV4RnBRbGxaOTR1TVhybXkvcnNUa1V6aEwv?=
 =?utf-8?B?bmdCaVJNc0NINW5NZnhLakd6ZVRMbFZodGVidStqOU5ON0t5MzBlQUNBbWFE?=
 =?utf-8?B?NDA5UGVObVJHVXdvZ1hLeVo5TlZ0YVQ5dUl5R3d3TUNwQ2dZTW1OK01EbUh5?=
 =?utf-8?B?eVh2Qi8yM0NMbitkcTNqcVdEREhWYzNxbEZWSFh5T3RGWWtpK29JbExaUm1E?=
 =?utf-8?B?dXJacncxcW9XWk9ZMmNzUXgyQy9GZDl6dVY2YmNyaFF6QlVtaFhFakg4ajNL?=
 =?utf-8?B?QVFFbm9samxxRW12aEhqazR1QVZnVXlyZlZEbnBWemdDVWlqTDgrTjhNVk0y?=
 =?utf-8?B?UC9MRGlvZGdsYVJ5ZDJpMllFUk02ODIwVU9KSUlJVXZ6Ym9DMEFEU3hCQVJJ?=
 =?utf-8?B?V3BJNGJsTWlIWjNiVkRGMlowSmV2cUdHNU1nN3VSMWRBL252elV0eFFXNmJK?=
 =?utf-8?B?R2lVVW8xYk41bTN4bzhZUlBiRXRWa1dPWHQyRHQzb2JKQ0pBV3lwZ0Y5K1VF?=
 =?utf-8?B?TWc1ZjNsR3dBcEZLeWt4dElHNTMwVFFFeENRZUdZVi9vazM2dHRZMU5RdUdU?=
 =?utf-8?B?Z2NjM3lPbUpMUTVKV3ROV3ZUWlpPSnpKdDZOYkhSdEFZVi9SUUxObkQ1ODkw?=
 =?utf-8?B?MXhXMVIyN0UrRVVyME04Ly9tTC8vWFgrWEltbFRvaXBzVkgxNGJ3cUF4akli?=
 =?utf-8?B?KzZPSGxCaXdNQXZBZ0xZcFB0K1YwZWNnR0FuVVhUY3d4ZjB2WEMya3hlTFpO?=
 =?utf-8?B?L0lPTzJkUU5tUHRjN0xJK0EvemFIQk15Z2QrM0podVQ0VDF5bU9vSm9VbW8x?=
 =?utf-8?B?ZVJHRXFJS0tBOHlFVWQzeGNXa3Ixbit0V0h5RzFDOXVJTCtNSEdBRkhVQy9M?=
 =?utf-8?B?ankyMU5ON3ZoVko3WnFINzNmdlNtM2FuWUNyY0xkZHF3UDlNeTBTRkI0bDN1?=
 =?utf-8?B?b1ZuNWpycmNqckRBL1lYODExVS9zVWxaUzJTSTVnYmgvV0l5Z2R2WVM5TlJJ?=
 =?utf-8?B?aE5UVFEwL2RtQnBLRVVZdUxEcWNJZ0k5Q1NoVGYrU0FWZ2xCOUs5QkZXbWdU?=
 =?utf-8?B?VDVnQkZrVE8zem1ZSzNsaGQ5eG11QklIYjRkL21UcTZLZDRDWE9qTDliajlh?=
 =?utf-8?B?UUtkS0Zodzl5dFR2QU9MSHlHdUY2K21ma1djUEZ5cmdqczN3M3VxZXJTQ3Vk?=
 =?utf-8?B?djdCV3JBUUdEd0doUkx1Mmt2ZVV0MU9JWnFIMFFCbjF0RUxmOEtrZHdoeDRF?=
 =?utf-8?B?bStwN3RnWWZySnpnZDh0b0NDWmFtcWlNL0tndEZUTm4wbmt1N3VJUDBUYkV4?=
 =?utf-8?B?ZUxURk1vQ1FhNWJ1NkJlcmpyVUprak9MdEwyOHg0K1JjbVNpOHNaSzZQamx3?=
 =?utf-8?B?MElFNEQzclhnbmNhakgweGVSRkZvVnNQSHJNV0xMQm9oQW53VGs3ajhtNDk2?=
 =?utf-8?B?YUs5U0NrZmsxUkx1M3hvU1FDRnl0alJOTmRiSWE4UmY5Nnp5dkRwYjI1Uk5H?=
 =?utf-8?B?K1VKODZiMitjZmJPTkFvU3phMnFWWE1IT3BtQnBqQUpkakxFZU9OdmhQYkdB?=
 =?utf-8?B?Y0gyUldVYUM5VzY5VjU3TUpaaHNSVHJhR3MrTnNBNFdYOFE0QUh1Q3NkN0pl?=
 =?utf-8?B?OHBpRENSZmZtbU1zcGEzS2lQaXROQnF6TmV6SG5tUGR5THR2NmZIRUx2K0Vk?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c963a6-d792-4d80-4928-08da8ab2ccc8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:09:37.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXS/gX79nN6EQxcCxNhXYYR6rsAJbmGxAs8PuLoUXQ+PEnrk7Ek8lT0zIHIvJCkcuP6G25KNeOa44oBF/QhCPxwttR631GRlpvA91WUz3Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300083
X-Proofpoint-ORIG-GUID: FCR7OYbSVMiA174ZRRaeQ6b41rpTT-es
X-Proofpoint-GUID: FCR7OYbSVMiA174ZRRaeQ6b41rpTT-es
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/22 8:33 PM, Matthew Wilcox wrote:
> On Mon, Aug 29, 2022 at 04:00:08PM -0700, Sidhartha Kumar wrote:
>>   #define TESTHPAGEFLAG(uname, flname)				\
>> +static __always_inline								\
>> +int folio_test_hugetlb_##flname(struct folio *folio)		\
> One change I made was to have folio_test_foo() return bool instead of
> int.  It helps the compiler really understand what's going on.  Maybe
> some humans too ;-)
>

I went with returning an int to stay consistent with the page version
of the macros which return an int. I'm fine with changing it to return
a bool.

>> +	{	void **private = &folio->private;		\
>> +		return test_bit(HPG_##flname, (void *)((unsigned long)private));	\
> I've made this tricky for you by making folio->private a void * instead
> of the unsigned long in page.  Would this look better as ...
>
> 	{							\
> 		void *private = &folio->private;		\
> 		return test_bit(HPG_##flname, private);		\
>
> perhaps?

Ya this looks much better and passes the tests, will add to v2.



