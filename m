Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76572526D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384862AbiEMWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384858AbiEMWsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:48:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956B52E53
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:48:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DJPHMF005765;
        Fri, 13 May 2022 22:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QaJkVXMOMi38yyg2phhp9H8Du3O5D7Tu0by2MhDkMAg=;
 b=rXlIBXNiprMBf97Rw0Q6Mw26kmB210iEN89UxXZSPARUAQ29SJOZgzeGcntibUiwbf1i
 guqanY1tDtRcVFWCtM3yCCD1MQNuYyFvDuJ4rc5SC5CFzwFMjTQM7+3vc2rVhTMHnEuT
 MFDUH2yw1FBfYLLnOec1utgpr4z5+b9tAWiGVz3DYBu32+TfIPyBMQx1CF3Q0HkuFjsC
 4mlZXZbzPs7/ub0UwSbe2zgM0eBu/OHgDh3oV4Kh0dU1HavxqL63ZI4cADTFtUUbJgvu
 nOnuw69nZeembZHMETFCv9aoRGD1Vyfh9x2RPrNGQp92hJyReVkA1tZXLzcdFyyFd/a8 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatrrsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 22:48:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DMfmAm016080;
        Fri, 13 May 2022 22:48:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7dcbyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 22:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/QQNTa95bXgADN2xFpi7J/uEzLyJSpqW/GYPVnV8QCbc69GPG7zk8C1szTizGLxTY7cesFWs3hP4Pw5U0+GYc1HwnjoWSeOMBKtA/ztuTW4QGTBdfjxWb5jcJpIU4HypqU2NU3SPlcZHwUS6U3ZsQPHqtVYcYPDt/br4Q0Kx/ABfd9+yrOZiQji6PL6iSu5LqAV0XGwshGBRkTupKGzOBzGuSKSEpHG5zGi7JbH8IOWPqJAyiFdALfnHj1KpHYKXPZ+sHhRyZ9SLPsZKCN3ecXewwF79+Z30RWEmVlMIgn+IimuC+rahdG3uqWAxT9mPQ6ApDKGSFTiHItHh6TP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaJkVXMOMi38yyg2phhp9H8Du3O5D7Tu0by2MhDkMAg=;
 b=mHHH6Zn14lFsaWRjXY6ZqHC95MZDz56u/pWTsadao6YZKLaBWaouET6BKsIhgvmtpN7WXAnFL1grcdv/zGFss92qaYyssGqUTu/wUkPeQbFuKgpitMmIlngctwLWRkap1VykK22elwL+PSPjZCCceC5f2sWilsax2PbSK3xrelwzvBCx5zd5En+HU/ThATcZGRu50s3in6rcsmh2z4YXhpeF4QuxGWHnYlQ8yd7+U/W2MZZ+yquUqnQP9nC4OvX4nhZn9fZCfYZQ6RHc3sGoP3AOM+Cm+ncATi8peFp6l4XDcf7BM4oK73x8/s+Qftzq2XZxTJ+V25jT+JzMBiCJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaJkVXMOMi38yyg2phhp9H8Du3O5D7Tu0by2MhDkMAg=;
 b=l7xAIgADarLXL2sV59aJ5p5n2JyuccWHgtB3llurQWWH2B91kGBeHtEZz1EBw+L5dO8xcqdGv1HyT0Gtlbb5zzmj6un2z8KhMQAYqDBNVcOpEuws7GxRIxzG7CRpbkmqRtIJIF4FZKlBcLfojiv1d7qsnlBniC73PccISG27sj8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 22:48:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.016; Fri, 13 May 2022
 22:48:17 +0000
Message-ID: <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
Date:   Fri, 13 May 2022 15:48:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
In-Reply-To: <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bcb1a81-6471-4f08-9e69-08da3532abf1
X-MS-TrafficTypeDiagnostic: MN2PR10MB4304:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB43049A2D15284B3DBDAC0EBFE2CA9@MN2PR10MB4304.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRa2oA5R0iUM3y61yLYAb7HNqbw3DFi8Hqbr54MgGTCwmlYGMdrGggRNUTtRd2QXwgog2Gyxrla+LIyhTq7IRuo3fzfMcj3VH7RoFneQhUsTEi6nqbZCEEpNts0Ea8lGX60Y6tE8WZxZ/l9DR32/4YIaY6OJ//nhhuTrPciZ5uBtos3RFDZzHTOkA4MMAAtwRvyjMOCoM+5jZYM7EhXps+6nl8UxSlGA6CCqmSMzpR8xSCHXozYG7IlTZf5T26ucaVZJi+kHv6+xeRdB7zxVXeG2vQpQBgh6vShP2sDPwL99iz/FkG9Qtc/JCYRrawgC8fCDPAXSPNAKE8lhpy9mkrxzzStob599iP0MODjBV5aGqS6S77nq1FqCfuzpWpdLmqGoGIamAggva2mglEX6fvrcJCZMkq+z6H4zhAh4byiP5jgXNgB1hQ0STr78s647K5ODTb2JMc1ch2PAjzlW9HRreYs8K+2G2oKco2sonEaK/oNS/9GU23ZKChYOLa9fWMJBqHzUZL5lA1wlBjgPCcNYWZZtTr6TLKQyBqO/QSHPXV9GpEXzFqrbQfDF0qJmpCv5VZbGgrbnnnb+fQDHzHdGtYcdrNDtjKAHacy1VnWeq8rywWTIwI5gGMw1eZoVkJTCKq8z3JNZ7rmIy6HXYCmfaOUboUki/BtJD7N2KEN+iJc4EA3SyfUlmQAtkFGtKpfbzcozbBbNpLV63eY6pVsEiA36D/A+RIXkZUXYXnoG86BeoV9bJV4WNNWxynGHXGmaF7a0aUJkl6vyCLgM0h+ZggZejo5GlJxY+En+Kd5D0WL+PzKSId0MqlpO+aMqvQQy9aHKEwo/1Iw7qXwHmZmCLukJjYC48JtSpa/4MPM/6mHap5M4EC7HJeTxFhrP7PvonYHvKd/tj+WTPqPEc55PgV6wJFFRm0fGKTp7gLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6512007)(5660300002)(31696002)(66556008)(8676002)(66946007)(66476007)(186003)(83380400001)(52116002)(2906002)(31686004)(7416002)(6506007)(53546011)(8936002)(26005)(508600001)(4326008)(966005)(6486002)(36756003)(44832011)(110136005)(316002)(2616005)(38350700002)(38100700002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNGTmVaVm9KMTdFN2V3QzFiekwyZXdsMzdpdE9BUUFrWi8zb21wQXhlMDNt?=
 =?utf-8?B?SHBockhnck1QYzR2VERGbm9FWUVZblR4RXVOU1Z4a0JIeGxGT3FUSFI4Rk56?=
 =?utf-8?B?OGR6VElIQkFCWjdnd1RuNmFwVm1ySFlqM0lZTDZvUDFCVnY2MnJyZnl6N1lp?=
 =?utf-8?B?aS9NSFJ1R2dpZVpCYkpiUkdpV29PQkFkSG1FTkQvaU9YWGp5ODNNRDNSODU5?=
 =?utf-8?B?aS9ma3FiMHRTWVR6Y25qUThpR1JpYll5bFk0Q1FRdnRRbVV0MHFSVXpoakEy?=
 =?utf-8?B?STV0Q2pldWNoU0NmVWRLN0w1WUFzZzRBOEthVnlyVDlNTzJIbDlnTEN3aG1z?=
 =?utf-8?B?Vm9nVWZwMThoNnY3QXdmTnF5d2tyOU1sbnpBVDFDdXJaWmt5N1dUQ1hBSFhP?=
 =?utf-8?B?STV0Zy9TRU1pUXBoaGUvUE5RdXJCcllBb2d2azNVc2ttdlJTTlZaN2IwSWJC?=
 =?utf-8?B?cEk1SE1MYUQ5NWxCTDRONFl3ZGVuTk16Nk1MUExZVjdxNytkbVhvWUUybmRr?=
 =?utf-8?B?cXhVZ1ByMGM5RThGRW5QanBOemdFNE40WVRuMk8rdVVGaDYza2RiL3hzL0Q5?=
 =?utf-8?B?akplem9QQTJ1QlcvTk9rSVl6MVVQbVpSMjVKQVdpc01kalJhR00xWHZ1K3VF?=
 =?utf-8?B?U252ZVFXTUpWeHJhUmF0VUtWSTA3NGhYdU45VHJsOWpUL3REWlNYaXJhcGM0?=
 =?utf-8?B?MEduSy9YZ01rWEUwN3FPQVV3d3VhKzJ6dDZVZ1BUOXliRDNKdGk3b1dRajNs?=
 =?utf-8?B?bWtNb2NxRzhGOURqc0hYam1JN1F3N2JOcWVMWm9nLzJCb0ZtZTFwSWM2WlR3?=
 =?utf-8?B?b29EbmUzdW1TZ3M5RW5Xd2wvcTNmMlRuaHhyaXcyc09mVERCMzRMN2srZzlL?=
 =?utf-8?B?M2RHYUNSNGZmNDFGOWNxSTlib1ZMUnBJMEtRMHhwVzFBU1NuZWlQaEI0eXQ1?=
 =?utf-8?B?R0VmZ2h3NlN6RjBiTHdLVXZvU0NrT09HeCtESUdraTUxTG9veiszcENUL0hj?=
 =?utf-8?B?QU40eGd3V1ZOTFo2TlJzMkF6UTRRdkJhTDFTOVR6NTMzeDFVRmxzZmxHVTNO?=
 =?utf-8?B?a3hxd3NJZ1VrYXNyNy9MQnBBTUhTK2c3Z3FkN05XaUpHbS9DenBjSm5uK3pk?=
 =?utf-8?B?Z2hES050ekpQUWkrZTYyVnR5UFJpUkhHTWc3c3V1TmV6MkVncVU2aEtwNUlH?=
 =?utf-8?B?eURoMnVXTDlLTk0ydURpaVFoemJkNmdteTM0QUJDSndQbjIvN0QxYS9oTlFN?=
 =?utf-8?B?NzlBbWJDeFBtalJPOFlMYU84Ymk5NGFWcHBLY3ZlYUx6QVROWmR0QWhnYjdy?=
 =?utf-8?B?UnZoUW4vVkJqRHVoUzVHT1dmQTBHR2V3QktCQ000eTg1bUJRZkJTUXJIN2t0?=
 =?utf-8?B?U1A2NW9FcHAzUERZU1hhQjJxWDhZZ1diRmhuYzZpL25zcHNEV3FJWnJpTmNz?=
 =?utf-8?B?ZXhSejNDTzc0U2JjdWRLSERHbkI3WElMNUtHN2ZTdytYbWJwUU9hcTExQ000?=
 =?utf-8?B?WlJUNnl6RUF4eFREaXZXd0M0ZkNIZjd5d0VqcFRoTkRQL3Y2YlpLRnZaNVMr?=
 =?utf-8?B?dFA3aXNqNkRQY3hyWGp4RlVvYzlSUGMzYmVIVkR1ZzJaTGx3MFdmNUZ4YlF5?=
 =?utf-8?B?M2JYTEZoMmdWZzJGb2ZqSDVuL3E5MjZMS1cyUEhZUUkzRUJFNDlaRk11VU5M?=
 =?utf-8?B?MTQ1L000R3psRHFqZERqSVpOZ3ZtM3Zva0Ywd0pnQVQ3Vm9qaWpmZktaN0ox?=
 =?utf-8?B?UjhlVzN2ZVVtVWpQU3Vkd245VktMYXdBVExuQjBNdEYxM05XMEtMblFrenRO?=
 =?utf-8?B?SUpUNmI3c0lVSklMTit3VVZ4TFdrQWNyK3F3dmgvSWliUndma1RZbEQxTmpL?=
 =?utf-8?B?TTVNeGY2MFFHZlZqNzF1VkdUUWtIZ2pnNEo1RHRiT0FDTUdaSEJlNkVBNkpX?=
 =?utf-8?B?UGhyZVVRUUEzRENwdnJ2TCthVEMrYnN0ZzhwblYwNWlpQ2FaVXArZnIwMjMw?=
 =?utf-8?B?dVNsV2N1QnhlUFJwMXpNdDllYzlCaGhwdHduejNkMmFIWHdHRlBISjVHbDYy?=
 =?utf-8?B?a2VScjFuMlRLRktaUXZyc0REVlFmN2xBTmZreHZoakNLZjJFU2xwWjA4TERi?=
 =?utf-8?B?UExLVnhvUE9XZUpCMlk2Zk0vTis5em9SZmdWKzVuUEplR2p1NEFmM2htRzVO?=
 =?utf-8?B?QmxWMTZQcnBoelgxdTJoZTB6UUlkTmdCTjdyK1VsVHRaVjV1VTBZallWTlZO?=
 =?utf-8?B?aUlVSHBPdTg0R0xWeVdlZmVHQ05NNHBXRDlLeTZCWVVWSjltTWdibjNUOEgy?=
 =?utf-8?B?V1J2RXVGK3RFdmxtMXJFeUx0KzBoMzN5WkpGR01zQ1ZHQXNzQ3k5a2prNnEx?=
 =?utf-8?Q?qvB43+z7xaOSPNEk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcb1a81-6471-4f08-9e69-08da3532abf1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 22:48:17.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmP23+4sxLRvY03Ut64y4zBrCo2cnB22lDuI1/+RixOgNuXTB2z6PLSvn3XeziR/wwgImeohRre7ILIglukhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_08:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130097
X-Proofpoint-GUID: MClMZMfV8t18W9ZDez4xHMni17Kw2d5-
X-Proofpoint-ORIG-GUID: MClMZMfV8t18W9ZDez4xHMni17Kw2d5-
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 11:09, Mike Kravetz wrote:
> On 5/13/22 10:26, Andrew Morton wrote:
>> On Fri, 13 May 2022 09:43:24 -0700 syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com> wrote:
>>
>>> syzbot has found a reproducer for the following issue on:
>>
>> Thanks.
>>
>>> HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
>>> git tree:       linux-next
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=174ae715f00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11531766f00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce5a9ef00000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 3611 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
>>
>> The try_grab_folio() added by 822951d84684d ("mm/hugetlb: Use
>> try_grab_folio() instead of try_grab_compound_head()").  That commit
>> has been there over a month so I guess it's something else.  Does
>> someone have the time to bisect?
> 
> I can recreate in my 'easy to debug' environment, so I can bisect in
> parallel with other things I need to do today.
> 

I isolated this to Minchan Kim's "mm: fix is_pinnable_page against on cma
page".  Yes, the fat finger fix is in next-20220513.

I don't have time to analyze right now, but can confirm that in the
reproducer is_pinnable_page is returning false after this change when it
previously returned true.
-- 
Mike Kravetz
