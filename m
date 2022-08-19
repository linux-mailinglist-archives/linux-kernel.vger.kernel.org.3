Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16355599D10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiHSNoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiHSNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:44:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03ECD501
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:44:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDYWG9016223;
        Fri, 19 Aug 2022 13:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AnAlXLJGK27AQ7HXn00KWuBU8ofEq1X0F/SX5BnryqU=;
 b=V372LZlu32g3cht6I3/MEHLTllhi+NTQdkb7Uw08TPWNgBfRMatlME+tfUD1SRmh3Why
 Yulg5KzPwUTsUZbiJSxJtXnqqYG7T4hiQxZwocXQpcLvwwKdWy0746lGE0qosBNBcndn
 gr2pheTtWywDvwOfXLA/1/Xq7wFuLZrHH/+47cJzu3e1eszwUwNkd5sxAx8lIUq+iPBh
 hqc1ttsBXBKb1bzzVlci2xd8b770r6leTK52XJplFIVZVKzk8vX9k/x4DBZm77CDvdXn
 OKSOcGpUaxmK6oUS5o1pp8KavvT081SgeTgynjMic8d3rsBf2xIRsrURMgY2INaHrVQk cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2awm8489-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 13:44:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDMPKi005694;
        Fri, 19 Aug 2022 13:44:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2dbj0m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 13:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIfckgK5ARETBqsMrk98Z//hklw4yOt7DbYI5ju2veXQyvcjvCuJInBfDjScdQd4Z6c772Cw6z//eAyM0bXlI0Y7n5Q/Clq2YRkqulCvDVjLluQ/QJtA3QcN0DCU/3gySiA2pRB/dDiclAX0XBgxcPxq2spsED6P9pManqj/V486MYBdnNXC6AwZok6QszeMsmkbOrGEJOD4NE73CC0PLQC8Ct7eE7kxOKUY4YCtTwPPfrCYGCYsTU9fayl62MOzDWxpePAaBR3ufmnF8H28JaPP6N1KBEhz0/ozJH+XetZj/a52mcJS0rYhb8UUteINO5u4dguXZtDM+wv5kMZHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnAlXLJGK27AQ7HXn00KWuBU8ofEq1X0F/SX5BnryqU=;
 b=SfjyF3egaWt0uPTSz4GKLdn/d1VXBcuJw6Fc2UdgkcW72SwU8Mp1dt9ByP91wKk/NAT8MGxmiLO5vgc009qthyDKAck94ZkJfwQG13yBwucy0bqfcuWWGUNQ/kivMaLONq2woc01b20SS0NRVbqDOBgG6HmkqpBxTf2eT8tp0Mt1Y4l+/mooqtL+1B4xHP9XCzOzCvJwNGr0bjTvxQGqrJjC9kIoxV0Ov+QqGGLTV/De1vsy0QmDaULoKxMmNgUQTd77PKedOcrMhGt9dADSGA/JStmkJ01XOrRpEsqzyknHveUI5e9JVjYDNDD8ZFZGGBKhHQZIiN+2opeCcauwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnAlXLJGK27AQ7HXn00KWuBU8ofEq1X0F/SX5BnryqU=;
 b=Nk/LedbDrdBoVrETBWmH3mW0h18Suy8oV66INQ1OkKtEWJOsMJxMVTmLVhh6uf36SL4MtC86a4SZ2hSCIy69/V+pS54BEbGlSfJZrhYYD9nwaWIGpRGDgbzUyLqaSypae8sLPrBIvODlo/2s6JDiXFYk0d0Ku4tnOAL5tN5Eb2k=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN6PR10MB1524.namprd10.prod.outlook.com (2603:10b6:404:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Fri, 19 Aug
 2022 13:44:07 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 13:44:07 +0000
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
To:     Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        jxgao@google.com, konrad.wilk@oracle.com
References: <20220819084537.52374-1-chao.gao@intel.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <38c58aa0-11c7-f553-95fd-292fd4944a75@oracle.com>
Date:   Fri, 19 Aug 2022 06:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20220819084537.52374-1-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::27) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c2a679-a038-4a49-73db-08da81e8e34d
X-MS-TrafficTypeDiagnostic: BN6PR10MB1524:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+XOgLkLNupC1EMjdA0gXvvMTd7+RIFStTG0Bwe013mqHMpYnxtRirutc/qxmzwALqny6OchyjibQQTJyzicIEfkDEqcMQlrUbYqHV2BYtO7oqXybx14GyyNozZGaLa6Wqnkr8NKshJvHsjV2leDVIT6j3xfSXG4K/JPxpTfLdjnG/p+DHWuuVJ2lUoa8isZis17jFXXf46S3+zlkYpvZJVfa/oX7pFIanW1LkZMu1lsQuNw/cGI7xcahnnt5gn2PLbv+aqXwIdyzWte88RJwN8yPN6i34IHaMXQQHcy7NHXE10zAmg2j5pCtsf25ThGFKUawPJDBwel9zhDB+eoWq61zSvKBZXRGCrXkv8FCoxEiDHOZLBa4prnuG7mvCPacz4NJ4+SvHNWcl+vhqoReG9OzVozsCk8AF7l+C8D9fiMQwssjDBUgktbniIIf2wEU9N36kRauMbw5Hlq43Y3NusLFs2S3qKktYTosxo2zJOQ6hoy9Cnp17FLBq+2nc1wFlISRrYo7zV/SsP5psom+nfNcPZ6d/bnh07tZbMVNhN9oYwzqez910xvqEKU3HvD5nM0WFymOBfKSn/A7e3wZ+77FUhJR+iY3YTbv+syYqD5nRI56gHFdqmDnLthrX7DeYidbYbD0K0oLhSTI06Jfv+Ixl9PODyUSMUomgAoanC9pFrEcjlYtYBXHyoA21zYJ2GMZy0lrFZiTKkjG2luDHEbzPs9lbuCVXWJ2Td4Gs4q5j4OdvZZieqzVn1L2KVF/RmnApgkXzGuimKMDCI1SvU+WLhfpB0t4DSUkNVUjrUIQ1zGygTsG0/iGkWL4eYABMnUAf6NLoNvTYxHlJHZ6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(31696002)(2616005)(107886003)(86362001)(5660300002)(38100700002)(83380400001)(66476007)(316002)(8676002)(66556008)(4326008)(66946007)(36756003)(31686004)(44832011)(41300700001)(6512007)(53546011)(478600001)(2906002)(6486002)(966005)(8936002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmRQMTZQMmp6VkRwbDJjUVplSDhMQ2hHaVN6b0hheTNwV0VBOFM5ZG84c253?=
 =?utf-8?B?TG9CNitxYk9wUUlld2VMVkdLRjUxaFczN1d6cEF5WkhiRGR1V2FDQ2d2OEVt?=
 =?utf-8?B?VGxoa2V6WEs2cWhLRmtuNVBOOVRyeGhRMTFBWjBvdUw0RC9ncVEzNzZ4MTRD?=
 =?utf-8?B?eGlEa1Jyb0tLTmVrTGpxcDl5WCtWazl1bVNPSlQ5eFNDR3BqRDNqK0hPM2Vy?=
 =?utf-8?B?Zm1PblZOWWRYdDRtbzdIZnRsSVRqcEF4bThBY01GbTViV1lPdjZjUUdLS1oy?=
 =?utf-8?B?T1RvUEFnek90ZjV2K3ZLWVFlU2ZkQkVFOHprZ3l5bDRrSFF1TDErdWlkVzdE?=
 =?utf-8?B?d0xuYUJmTWNXNzV1Q3B6MDcyZVduaFEwUVIrWHJpTUhBaS9wZ0RWVXdnbUxa?=
 =?utf-8?B?dldCTE5iemZYQ2FVSHQ5YWVQRTYzNXpNSC8rbkd5NEw4K2E5YzhxY2xxMktL?=
 =?utf-8?B?NGw5eHIxb01nd3kzYXR5aDJlbndFNldzYk55UnNzS05VS0pxNExWUmh1N29v?=
 =?utf-8?B?MFZwWW1HY3NERkloOHpEVnJNZFlTM0ZNWjRSaTRURGlKcFJVL0RqRXg5R3JG?=
 =?utf-8?B?WWpiQlBseUo0OExURnBBWWx5SUF5NmpkcG9aQmpicktUa2J1aGZaMldXazYy?=
 =?utf-8?B?dFFXTzRJQXhuRVNxSzg1U0EyYnRqKzZzNWZHRm4vQXJIRzRzN3oyNEV6UXY0?=
 =?utf-8?B?Tzc5SmdmY3ZON0NvYzV6VHZxVkJWUnpkYWdSVU5oUHVSTllWQnVmWHRoNHZm?=
 =?utf-8?B?U1o0aC9KaFlGbFVDRUxDTENBcXdMSGF1MFUxUWhtVWlEeVZrdXJHaGZEQnlC?=
 =?utf-8?B?d3pVbnlrczc4bXpWQ3k1cmN5QlhGOFgyeEw4VG83eGxLbmFIREdnVllQeVlP?=
 =?utf-8?B?dlRlWVVTSGpZelErS25NdDRkMDRjY2pSRi9iNTNibVVjZ3piWVlTUUpFNllS?=
 =?utf-8?B?VnkxM0toV1FHeXN0SExQTE5wU3cwSzVGYmVSdk5abEpUZE9jSHBIVVdhWkFW?=
 =?utf-8?B?RUhtT0pYZjk1eU55bWNaQnFLelBRRVFTRVZ5MXpXNTczeGpmODFkYUtLdnli?=
 =?utf-8?B?TXJoeGd4amxpZm40UWVFbFRMbzJSb25lRC9rR0pYblQ4RnVQaUJhVjRFSjND?=
 =?utf-8?B?MnhxTEZteVg1YUJuaVVsZjhvRU9HaGZLVGdpMUxicndJS1ovNmo4eDJaaU1m?=
 =?utf-8?B?Y0NYNFNNSTc3dUxwQkE5S29HQ1RJYTFXY2ZRcnJMRTJmb2JaajJNaFU5Mlhl?=
 =?utf-8?B?TFdiSmp2WkxMOE9IRG5UWCtob25PK3BGNUdTbGdqa29YUVlpNHQ1TXlDSEZs?=
 =?utf-8?B?UVNIWkxsWWh4Z3hDbG9YVHdoZ0VqSTJwWUFtaWc4Yy9IeE9oSlpsRGlBMTJH?=
 =?utf-8?B?L1FlUmxXdmtXQlM0cWZJL1llMnJ6eWhrRWt2TnM1Z2Y5MWJ6NEpQSEltblhn?=
 =?utf-8?B?U25BaGgxVXNzc0dLRTJhYVNwck5uS3JRaDcxa3lBYkJ5WWpKcm5MSURYNFYr?=
 =?utf-8?B?WUt5TE5jVTcyb1VMbkdLMStzWWROQld1ZlJnZVk1alJSNGdtVUpJNFc4VmFP?=
 =?utf-8?B?aWRXOUlXWW05bTJTc1Q2NkJmTmxNcGVnNVplVzNjVFpxRVlkQkNFdkVTanQ2?=
 =?utf-8?B?cjVCZjk1emordmxsN1NEejZVNTRFNVZ3NkI5YmgwOEQ0bGc5ZzhJU2ZwK2w0?=
 =?utf-8?B?SkJpSlhDKzgwN0hYQ3hhNllocDNpdyttaDQ0UExEV1hmRUVsc3lPMDRiRW4w?=
 =?utf-8?B?Uzd4YmJOd29pUFVLUVg5bjFlMm9oa21BNi9YK3NrNjhtNnFlZTZ5a1NGTWY4?=
 =?utf-8?B?eGk2N0ZvYU9oWFJyeS9SVzhxa1IzTy9MMDcvWTAzZzJJUHVWdC9PUmZ2N0tD?=
 =?utf-8?B?YTJkbXVZRDRMQkVNQXRQTUF6bHlDNXhTU0NLMUdWYVh2ZloraUEyOTkxb1FE?=
 =?utf-8?B?TUNhK0poc29KNGJqelpOcDR5WVQyeDhnSnFuRU1iQWQzOUUzcmF1TGVtUWVw?=
 =?utf-8?B?SEc5NnlsUksvQW5KSTd0U2dDNmJ1WjNjQ3BzZ0t1Nm5aMVpteXB0dTduR2hu?=
 =?utf-8?B?ZFYveWZIK3lnSGVucTkrUzA1bkF6RmFBa0h6MkZXcWRuUFB2bkRrc0FYRFJR?=
 =?utf-8?B?cWxsalQwV1RaOW9ZVURRZ1k1UVB6dWtWNmZWNHczUHBERVBoK21iMTdNOUNa?=
 =?utf-8?Q?j8YFy2YM2ylDTuh9nzcLMV4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T0xURlIwWlpzeURrSzlteUZ3VXVaTG92ZW01RDNkeGpBZGxCYmJsMGI4ZUxN?=
 =?utf-8?B?UFpBWERjcFRsK0pvdSsrNmhuZ1FNWlc5aEpmd0VKYjFQWC9sVXdpajJVeWVl?=
 =?utf-8?B?V3FQd0NXclJIbFdQVjE1SERvbjcxSzkxS3JXMFlSVnZxQTFJS1BvT1dMc3Bx?=
 =?utf-8?B?QXltRWYvYWRRaXZxOTQrZWJCSGxrdVdXc3FwVFhQWDVyK3gwR1JpK3k4WHNk?=
 =?utf-8?B?dEI2SGw0S29PalFjbmlEbkF4bWxCRmNMaVBuZyt3UTlSNWZOVHhTb1RFUXEr?=
 =?utf-8?B?dkt0YVdkZ0I4bEVNaHdJSXdRbVJza29LUjZqNUtCVHFqazdrV2dFQmFrVUJ6?=
 =?utf-8?B?RjhuTTBzNVgwTno1bEdzZ2t4TTRXNkJaRWZxaFdxVm1nUThrSll0R0YzWWh4?=
 =?utf-8?B?YmZMQUswN2JpcjhGTERtNjE2TWVORXEyL1hidFBnTEtXSzRFTUdWS0lLNUs4?=
 =?utf-8?B?MzZWeko2VDNPdzVnNVlUb2VXeVJXYlNuU0tpNUw1bllYSkt4bStvN2xac043?=
 =?utf-8?B?ZXozSVkwTjhTMXg0Z0h2Z09UU1U3Y0pBTk9SL2pIVUlac3Boa0NIUUY2S1Nr?=
 =?utf-8?B?UWZ3NG5JQkV1WlpQdmNMcjdOSFEvVGE0S2ZtQ3NzaUdjaWQzRUl2Njk1QUpY?=
 =?utf-8?B?akMzTDR3aERBOTJPTWJGT3lja2hnRzNOckdKRldiY0JkVmpyRi91cmY0Z3Fy?=
 =?utf-8?B?UVdxMzIrMHpFRTBKWnZmRGpVMENydG5mVmJxMG1KOC9iVlM2c2czMktJSTJM?=
 =?utf-8?B?OWJMVGUwdzl0OVhTZDVjbi9JRXJHZ3dYT3hFYUpXWU9DbFVDa0llZkh1VzRE?=
 =?utf-8?B?dDRtWi9va3c3QTFXTUw5L3k3NHlMUVNkV0hwSFlxTHdXWC9BRDBsSjFFS0E1?=
 =?utf-8?B?cTZYdjA4MkVZRlRibUh5Rlp0dm5aK09UR0VwV0JOR0Z4SkpEUjVwY1lHK2Vj?=
 =?utf-8?B?UStvdWtiZzlQdEhLNGVlaG9sbEhwQ3UrUCsvajZiMWRPYW15RDVKaGUrdktZ?=
 =?utf-8?B?bHF6TWZaOFZhL1dvMGJvSjEwa3lwWGROelN2b3dkbXVEb0prellPeVhCNW12?=
 =?utf-8?B?TW4zK1llOVJ3cmlHaTFMYStnK3pQVy83amt5dXlxL0NFTVdSRTNBNDRoeDN2?=
 =?utf-8?B?L2JtaHN1Y0htTFE5NmJBRnE1Vk1YUUFoMUVDKytoUW04dGZYeVRQM0M0K1Fp?=
 =?utf-8?B?blFCamJKOU1XcEZCRkhKZ0pDRTMwOWNsZzJxcEpQYjgyZy9PbGRRRU4zYlJK?=
 =?utf-8?B?aGlFWHhOODJCMk9lNDk5aVExQjV2ancwUmt6Z2taQXVQQitxeUtaeFpyMVM2?=
 =?utf-8?B?dXJuRm4vTk80WHluZVZ2eW1NNGMwWWZuM2FFK0VzN1lyVFkxTzlpTHpDTUls?=
 =?utf-8?Q?zuQQON2TIu2B0Qh3dnAhHVj1TQ6yabpQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c2a679-a038-4a49-73db-08da81e8e34d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 13:44:07.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDwG9k9X7eYtDV1M5lXk/8ynHO9m7wSEkRoQRNO0BnLl8W0YZDkq5ksMYTLu9P+kEqxzhxfgy5T2uhqQNewGrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190052
X-Proofpoint-ORIG-GUID: Ldi3q-85kUeqZ7Xc1TpiS8xXsWNlXHVd
X-Proofpoint-GUID: Ldi3q-85kUeqZ7Xc1TpiS8xXsWNlXHVd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I also encountered this when sending out another version of the 64-bit swiotlb.

https://lore.kernel.org/all/20220609005553.30954-8-dongli.zhang@oracle.com/

Unfortunately, I could not find an environment (e.g., powerpc) to allocate more
than 4G until swiotlb supports 64-bit.

Although xen supports 64-bit, but the hypervisor side limits the max to < 4G.

Dongli Zhang

On 8/19/22 1:45 AM, Chao Gao wrote:
> The second operand passed to slot_addr() is declared as int or unsigned int
> in all call sites. The left-shift to get the offset of a slot can overflow
> if swiotlb size is larger than 4G.
> 
> Convert the macro to an inline function and declare the second argument as
> phys_addr_t to avoid the potential overflow.
> 
> Fixes: 26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  kernel/dma/swiotlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c5a9190b218f..41ea9fb3efe1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -579,7 +579,10 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  	}
>  }
>  
> -#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
> +static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
> +{
> +	return start + (idx << IO_TLB_SHIFT);
> +}
>  
>  /*
>   * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
> 
> base-commit: 5c850d31880e00f063fa2a3746ba212c4bcc510f
> 
