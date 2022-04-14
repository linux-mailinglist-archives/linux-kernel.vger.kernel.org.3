Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B957501A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiDNR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiDNR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:59:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AEDEBAD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:57:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EGWohY028018;
        Thu, 14 Apr 2022 17:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8TXjcVFcPgCIo9VkfUzlHLWTHvkjg1y2NTBIeym8uCc=;
 b=tdvM9gtJZ61MueOMfxrUD2jPa2HHZrz/0dIUfP+oPX6+JgtwExjEYqPnCDLcUTWqRHca
 A4HwSxvidSwgIfteAKcysWcFsYhXMc20v4p7TPGQBQ5Fmf+QkvJ4DUNlgwgnyRlqRQsn
 +69D+t4lb4vPihYS3TmuRm9IjtDX++kt6ZfSjILBsUuU1BgtDdNBGaZM96zlfvdc2w+/
 2EkbU9Wu0Y2KiCeeYgJPxJ1DzaY0c153LusYn0+dhRjBpYGL+JQ5LsldhQMezYdi/QjL
 UJ6yOkl2NeM/TqDXZbTUQYrgpABV1Dw5nNq1kQFh4kAUQkTr97LFBtFosw8Z+b6EjTBl 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a52pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:56:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHphVa014084;
        Thu, 14 Apr 2022 17:56:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5n5sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I77KpXtcXvdNf5XSgxDxZrnGLpZSHhRhMF+XzZOGFJlfdb0JYft0J4klkAw3THcIY6M4HnBkXQJy2HA0Nk0bB/MiFrpCAACyhS7lh2Kpjd/bzZBjD0ECbilo7WYDs2Bvlc4V+tx4usEaGtWp2LG4P9mZO/GHlEfwgOoPvQASgOGfZrPpBJWe65GvXskzBjSzfQG23vtEGSBBUgvP+NufE4+GvKgxfVqMGKExhywgSUVOL/+qdup8hQZ2i/2sjPcHDpoCwUjAh3wgkAg9SpsNoMFYpV6Hp/J2gqyVJvBNG7Z1RBwyXFX3Fo0YdyoQrQILLC2gkBxjZOhcAOuyPyC/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TXjcVFcPgCIo9VkfUzlHLWTHvkjg1y2NTBIeym8uCc=;
 b=MDSJnCdMCkdnrjIzPt33FY3LfI5OgEPcWLtFBFosoSlRMArVvICfKuWJMOfa5Kpj+tOh50GO0p8sV1jW2Pa/PTZw4ebbLD8nTZr5UVgrqUCMPB0Rj/LyAzB1k8Ya+4oAF3Iubbj3+vPhV98ISWKMNbmpJMbs5erHg0YXWYc3ArtvbC+51vA/jGL/OiCafEYijva/xrtkVPfuQT53C9ceuG2/aul+gZf2JrVT+1bwvbQDTopPsrWLO3z03yLWKMFW1PuuiK2HpKfiSBaE+5su9LaTvs7fVUt32jvWR/LeOCaFYDhgj6I8RIB23Agmy1MtsLcCy3B0IFFlJudg/pDdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TXjcVFcPgCIo9VkfUzlHLWTHvkjg1y2NTBIeym8uCc=;
 b=Mc7AoR3KUTie+GJH9IzdG0WrTaVbgpSjdb37BDcv1VB8PqYZJMjeBuV81cm8tRuN6k5Wmpgk3tDEqHOPIVILTDgzDlqE61GXQ9YiSQhFNb0ordestXi76vguMYKTTg3yzWTMXNnAbAGr2wMNhh5hKYRxSvdlBfPy3MlCDw4mphk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2094.namprd10.prod.outlook.com (2603:10b6:301:2b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 17:56:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:56:46 +0000
Message-ID: <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
Date:   Thu, 14 Apr 2022 10:56:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 1/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29ee6e8-002d-48c5-b5c2-08da1e402472
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2094:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2094997332B7FD0644D28F72E2EF9@MWHPR1001MB2094.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0Dhrh27EAPEkweKwvhWkhRBBXe/RyvghiON9njjRKf+F18K/ZFJvk9pps8KdfaiATu6z4m8wppfdZnxZ3ED/rOlw2A8y7mXZaygIDln9sNe/pvvT5tI1ncJZz4zikUF9KqJ5mJ5bvTncSpwhxbSo5UcdpkgQ6ANqYQP2LCCuyHIFCRzKYh/v3bqF+ua8L0Jg+uEcRYvvFwCgSZkPfNUapBeCKPXdUsEzubtpGNjMNwTTtSz8jbRIKzBbcW9gzBf99sH/M2nRi3YLPnT0aYGWj8MRcQLkxAQsGQ3+2+2ulBZ7h+7vph9wsvb+4ryeITDbwRNiN9sS0SxNGb1gWYbyjDTAUAmLOwoykg5NgdPvKW4fA1+YnR09JOc2GC4pFkq5WoM++R1s38uBwwUvWeOE/rSoRoauq+dw3nwGmjMKS6yj9LTh5EDgP6ynBLSEEYDZVWbrA/C6viKxbGX6xrQy68uE/B8zvE/gfzR4XHUUpXd9Fhjlzn2iP1MXOmJnYprXowh3lA2i8t0QiteisdXdBbGZ2J2uDRMN9eypvUORVYDl74J1rORTEEWq+XUQSo9jFR9iaaamXothFSGRa1eEnqrWOCxmOcICuVmEkGZK23vtU3sf3886BriXoUdi4vXFysSMPHVLeebILRuEuBIHZENrG5UCGcW9mhMAog7pjseB1MmA0uUSK2GVj28M6UhdbpLDbkpuCQABL7cY8z+WEb5jLLql+2UaKHQ2l4X3c6o+wfevoeFnkfVCvcN9tBaIFWEAhVpyTJp+bpiOSINNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(38350700002)(26005)(36756003)(31696002)(2906002)(6486002)(31686004)(44832011)(508600001)(86362001)(5660300002)(6666004)(6506007)(52116002)(6512007)(8936002)(186003)(316002)(54906003)(66476007)(83380400001)(66946007)(66556008)(4326008)(2616005)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZOdjVFZExwWVpwdldzaHAxUUNKa0JrVDBjTWNHbWRxMUYzbXg4c245MVZU?=
 =?utf-8?B?T1RNU3JNTnB3cnN4ck0wMVZTbGpERm9jNHRvU01YMlhMYitpNTljS1IyMFhx?=
 =?utf-8?B?MC93blVCekJLRWZpL1MrS29ydEoxcWRDaTRiQk81Z2tvZE1ROG92cFhYSGhN?=
 =?utf-8?B?UmZXa1pyRUlrZWhBbjdTRm03Q0EvdUJOUm9yOGc5UGxyVzdLVnNBZWIwck4y?=
 =?utf-8?B?SmEyeWloTnB2VSs0SkhVVjk2bDhBMEdZcEVSR0VGbW9WOS8yYWhocTVjaUtC?=
 =?utf-8?B?bFd2Z2laYmJQT3hhRDl3SHNmMXB6b1hnU0ZabVJvR3ZTcW0wbTBFN2FDc3Q2?=
 =?utf-8?B?OG5nZjNqSFBiaG9adWg2QlIvbzN4N25CNXZrUTB3TFVaRkFTTnMxb2RUT0Va?=
 =?utf-8?B?MEladGpiYXV5TWpwVXZHcUlLZ3paSUtCZnVZb1NHdnB2SVRYUXdRWU15blN0?=
 =?utf-8?B?R056UnM2YkpuUjEyRTVJNUEzUmV5K3lEMlllVEdhWEFOUUxlSTl6enFhd3Fo?=
 =?utf-8?B?L0toODhMUUlKMUR4QVR3RmVXVEQvcmg3N0VkZVRIdVpwQ2ErRzhLSlprVzFD?=
 =?utf-8?B?Qi9tSlNQdmsxNHNxRUptMi8xV3Q5T2txaVZBbjJpcm5wdi9CbzBBakNubHlx?=
 =?utf-8?B?azNSeUZtMWp2aTVzeUo5ZFI0T0ZFbFRXTGVNcU9rMDk3ajF5WmsvZGpRVmZv?=
 =?utf-8?B?Y3pXYXJrZU1iOExBRFNuVGsxbnJYWXRxQTBpWFJNYXErOUNLai9YaDZjUSsx?=
 =?utf-8?B?ZHU5TXhqWGFGbnBjc2M2NFV4M2xLQi9ITk9MYk9kQm10QkdFZEVGajdsbE1V?=
 =?utf-8?B?VDBPaUpGbU5Pa01HSjhZK0RsbGlhUXFVeWFOMkVVbEZ4cDQwY3hFaWR2MkdE?=
 =?utf-8?B?VC9HbEwyRVdwL0JrSzVDU0M2c1pxcGdVWTZWbVQ5UDR2ajFQZkNpbTRGK3hp?=
 =?utf-8?B?Z1o4emdZQ3cyT3hjYTlob3NPb1AxbEpQMHZJcTF3ZUpLdmZ3cmQ5enVsbUFE?=
 =?utf-8?B?N2JCRGFWcGJqd0RBZmgyWEhKMkhOUnhuNFBqNjJIL29iL0R6YkJyS2JaWHhS?=
 =?utf-8?B?R3BrU29jQzZOZnFXRG04V3lWVWdzbEpLUDFUNDVocmVQd0kxd1RtU0tNbkR6?=
 =?utf-8?B?TExtdUVpMzFEMHVJV3l3QkI0ZmpqWWR4YXlQVnNaRU9CWVg0K0txN3RySWhO?=
 =?utf-8?B?OW1FRnRwRG9GNDRtQi84QTRqL3pUUjB6cWduS3c5di9jSWhtanhHeU5ucUh2?=
 =?utf-8?B?LzdkSzYxZ3Z0REYwRGNNRkxIelJlS1FleDYwQzAzTG9BZTVZcGkxOHJrTzEr?=
 =?utf-8?B?K1BIS01PUHNWRU9ZdmVlTDcxTVBNaVVtVGRkTGsxN1VTU3FlVHF2cjVFUjJw?=
 =?utf-8?B?U01lRUpzcTVEeXJSeU5GYjRUQUdiYU8xak9Kb1ZIVC81OWtsOURxWFE4UTl5?=
 =?utf-8?B?N3JZcTdLMGdYb0Q2V0hSNDdzMkIxRHg1UE1EU2FQbGkyS3hCd0lvaUZHUkRF?=
 =?utf-8?B?SURlM01qbnlmaFpnR1NWd1pKR2Vyc3lpWkJXcThGN1dpdDBPMkFXNTQzOEVW?=
 =?utf-8?B?eThCenJOb1AxY0pobk5wUjlQOFJlY01aTHE5UFltMTVOVUZOdUZPYVpJMHgz?=
 =?utf-8?B?dGc4emgwWm85ZzhYelpEaVN4TytVOEhuaHZIUzhmaW9TV0N3c2FkTWtqbzQx?=
 =?utf-8?B?RjZZa3hFNTZYQ0VDZGlWWVFMTk9UNU5hdHdLKzlZQWtQTmVvVEJxUkZyRTMr?=
 =?utf-8?B?OGVDV2ZLYk9zVnlDM0krcGdXRy8vd0Iwa1ljbzdnU3ZQbFBxZTYzN0ZVQ3E0?=
 =?utf-8?B?OVcyTDh3ODVTV1J5bGRIcVNiblREajk2WDBkdG8zOGgxYlRHdnM0OGZmV0ts?=
 =?utf-8?B?NGRsWG1OVFdJWUZXTEdYVFhMdkQ5TGJXcmNIWUNxcU1LZytrbEYrTlNaZTNX?=
 =?utf-8?B?UmNxVklYL081UUYxRUl3c3ZRbDVhK3d3ZS9xdjM3RXp1MWNzby85aVNXRG90?=
 =?utf-8?B?WHpwNXFSMXpESTBCSjlJMFhaMGo4WnBhRGhFb0ozbkhqTE8xZ3VmNDJubnNq?=
 =?utf-8?B?Tm1CemNndHFVUDFvWlA2N1ZXZzcvSkJ4WXU4M3BxVFhEcytPL2FlMkk2OWNx?=
 =?utf-8?B?Q1hIOWhzV2lCZEdUcU1vVkh6WGVNaFc1ZFptYmMvcnpkWk5UMks5ckRLOVVl?=
 =?utf-8?B?aFZzT1pLanQzTzJXbWM1ZUt5TEFvQ0NVdVIvbDdSYmQxdkNtbkVXdVdmSnFX?=
 =?utf-8?B?SGNhcmwveEI4YnJLRUxzZllFWm44c3VpTDJSaFpEVy9pYmYwaXBDSkd6alkr?=
 =?utf-8?B?cVYvSXhkUlNMakljbEZaVVlXN3R5ZmhDc2F2UmMxaWpsQWsvU1UwM1pXUWZN?=
 =?utf-8?Q?CRwQb56LokIHGfsE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29ee6e8-002d-48c5-b5c2-08da1e402472
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:56:46.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOeSbeJKu7gX7P+fQPUb0TQ/Yl2ss6ctrMlGLu3KBcoEl6wZBAoXzFWstC5KUDa/zXJ5x8fei9ylVLGWPV1MMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_05:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140094
X-Proofpoint-GUID: pyzWZQVq3q9xvz9n3DJnv97eBCv992fo
X-Proofpoint-ORIG-GUID: pyzWZQVq3q9xvz9n3DJnv97eBCv992fo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 06:53, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page.
> The one simple result is that wrong processes can be killed, but another
> (more serious) one is that the actual error is left unhandled, so no one
> prevents later access to it, and that might lead to more serious results
> like consuming corrupted data.
> 
> Think about the below race window:
> 
>   CPU 1                                   CPU 2
>   memory_failure_hugetlb
>   struct page *head = compound_head(p);
>                                           hugetlb page might be freed to
>                                           buddy, or even changed to another
>                                           compound page.
> 
>   get_hwpoison_page -- page is not what we want now...
> 
> The current code first does prechecks roughly and then reconfirms
> after taking refcount, but it's found that it makes code overly
> complicated, so move the prechecks in a single hugetlb_lock range.
> 
> A newly introduced function, try_memory_failure_hugetlb(), always
> takes hugetlb_lock (even for non-hugetlb pages).  That can be
> improved, but memory_failure() is rare in principle, so should
> not be a big problem.

Thanks!

I think this approach is the safest and makes the code easier to understand.

> 
> Fixes: 761ad8d7c7b5 ("mm: hwpoison: introduce memory_failure_hugetlb()")
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: stable@vger.kernel.org
> ---
...
> ---
>  include/linux/hugetlb.h |   6 ++
>  include/linux/mm.h      |   8 +++
>  mm/hugetlb.c            |  10 +++
>  mm/memory-failure.c     | 145 ++++++++++++++++++++++++++++------------
>  4 files changed, 127 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53c1b6082a4c..ac2a1d758a80 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -169,6 +169,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
>  bool isolate_huge_page(struct page *page, struct list_head *list);
>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
> +int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
>  void putback_active_hugepage(struct page *page);
>  void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
>  void free_huge_page(struct page *page);
> @@ -378,6 +379,11 @@ static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  	return 0;
>  }
>  
> +static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +{
> +	return 0;
> +}
> +
>  static inline void putback_active_hugepage(struct page *page)
>  {
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e34edb775334..9f44254af8ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3197,6 +3197,14 @@ extern int sysctl_memory_failure_recovery;
>  extern void shake_page(struct page *p);
>  extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(unsigned long pfn, int flags);
> +#ifdef CONFIG_MEMORY_FAILURE
> +extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> +#else
> +static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +{
> +	return 0;
> +}
> +#endif
>  
>  #ifndef arch_memory_failure
>  static inline int arch_memory_failure(unsigned long pfn, int flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f8ca7cca3c1a..3fc721789743 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6785,6 +6785,16 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  	return ret;
>  }
>  
> +int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +{
> +	int ret;
> +
> +	spin_lock_irq(&hugetlb_lock);
> +	ret = __get_huge_page_for_hwpoison(pfn, flags);
> +	spin_unlock_irq(&hugetlb_lock);
> +	return ret;
> +}
> +
>  void putback_active_hugepage(struct page *page)
>  {
>  	spin_lock_irq(&hugetlb_lock);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index dcb6bb9cf731..2020944398c9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1498,50 +1498,113 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>  	return 0;
>  }
>  
> -static int memory_failure_hugetlb(unsigned long pfn, int flags)
> +/*
> + * Called from hugetlb code with hugetlb_lock held.
> + *
> + * Return values:
> + *   0             - free hugepage
> + *   1             - in-use hugepage
> + *   2             - not a hugepage
> + *   -EBUSY        - the hugepage is busy (try to retry)
> + *   -EHWPOISON    - the hugepage is already hwpoisoned
> + */
> +int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	struct page *head = compound_head(page);
> +	int ret = 2;	/* fallback to normal page handling */
> +	bool count_increased = false;
> +
> +	if (!PageHeadHuge(head))
> +		goto out;
> +
> +	if (flags & MF_COUNT_INCREASED) {
> +		ret = 1;
> +		count_increased = true;
> +	} else if (HPageFreed(head) || HPageMigratable(head)) {
> +		ret = get_page_unless_zero(head);
> +		if (ret)
> +			count_increased = true;

The above code works as designed, but may be a bit confusing.  If HPageFreed()
we KNOW ref count is zero, so no need to even call get_page_unless_zero() as
it will always return false in this case.  It might be more clear if written
as separate else if statements such as:

	} else if (HPageFreed(head)) {
		ret = 0;
	} else if (HPageMigratable(head)) {
		ret = get_page_unless_zero(head);
		if (ret)
			count_increased = true;

Not insisting this be changed.  Just easier to understand IMO.

Again, thanks for your work on this!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
