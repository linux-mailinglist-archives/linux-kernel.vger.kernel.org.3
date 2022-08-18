Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9C5990B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiHRWoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbiHRWom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:44:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732BDB8F0E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:44:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILxQwp032377;
        Thu, 18 Aug 2022 22:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=v86Rvac4GOetni01UbRxuioyzabU8H4xGkLhxEFY4xM=;
 b=oZ1F9c9hxwVfrGGkDgZEAU1X1imnr+wh77g+EOqVUmuQw3gXCIA9bMFCZ/Se7yGh8E1u
 DQHCCGgWPUNzSbiGmcm5hg+9+07+dTYrP64XTkMOpJpUx+nxFslzjpN8v//qQU0nXQHZ
 573MjsE3sEBTP1AuOaxgkfNBB0jI9OL5+re8i5P1Q2UWcC7yiL6vIj9jrBRmTdMV7nJ6
 R2XRCdFuuuapACubXALpFQewRSA+EXHA8bhl6TBn6L8/FkArfDJFBA5bWgNTbYreHUGx
 nUHCq+7VcJIHShMnceme6Zbqjwxq3g9V8nZ5ZpeO/WeRYUZVpAR2fgZ4g/Kte+0kF79H mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1wtsg220-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 22:43:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILeLwB009975;
        Thu, 18 Aug 2022 22:43:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c2cg62e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 22:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQWuMlDK4xAKgqI4VONuBcC7AYYKV27JmtUbCEQtk+X8UVgOAoGPH2uBouxbc2IbiSJDRsjLQq3BlzALMUc0wp+yu/gJT8xRraXNWR63PRiM4SENgNeGds2I4fozuJB6KO2Qxx90yYlVayZhaXFYPEKzsNTcm089EMDTrNlN0AmS/zZVOGPJrS/64hgHe08CFrXXhcyjjunRvNF0/Igr2PHxATYOF6wLW1jnnCaWpdFV+YEDJ9/LEIvfoT1o3XNhIGBCBKwY/iMewGdKIDvHSYZzrLIBD0iLiDHcSSGweqLKYNSuBBT4OaRFnexyRNOzomAYsZ/SxEKeHA7VYUqQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v86Rvac4GOetni01UbRxuioyzabU8H4xGkLhxEFY4xM=;
 b=fBAvodEv7mNlaX3PK3X8mBS+cgH1GH/z+7djr4//Acw8CeLEeIGgbG96o+8znkio+16PorznMGNwvekg3QuMg/WsF2wDOwc02GUFkW5PCeE/Yo/hcGOnPY62AfXnHPDNfZuDuaOqF3oMHsU/n/FpjdE69dHkHm3UayoOGFkdgodI09EwTgqL5fMmHB0VeJCztaKSU03D5FQn07c50FYFjNfeSE210SDN3N/tp83tXCjpCI8nvt5iWtl1xbDeT2i6h95E8ReUfcf6Uh8N9SE0kbe8xlpcdGe70avHSg9yTjh7gI1pxcGyfoSEdUdWpbAi7NN24qhPbCpSVp2W9FkElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v86Rvac4GOetni01UbRxuioyzabU8H4xGkLhxEFY4xM=;
 b=zyZnetZlRqwkDqSjtaxdj89AS1Ct7E2YT6OsNag7Lb3s/QIHzueL+6dbf3/8mTuKG7g3+dRrPqZibFnp1FFINk2aUcun9TDlfu0o/NQlG7yuuCJhobSpzjTk2bjF8C2Oaus4apTFnSJWk8xRAHmgpc22p+oOiUX3+Sb//8bwEPc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5184.namprd10.prod.outlook.com (2603:10b6:5:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 22:43:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 22:43:37 +0000
Date:   Thu, 18 Aug 2022 15:43:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] mm/hugetlb: various bugs with avoid_reserve case in
 alloc_huge_page()
Message-ID: <Yv7AlZyNaAgpB4Qg@monkey>
References: <d449c6d1-314f-5b90-6d68-3773e2722d7f@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d449c6d1-314f-5b90-6d68-3773e2722d7f@huawei.com>
X-ClientProxiedBy: MW4PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:303:8e::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b455d2-8672-4525-ec9d-08da816b167a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5184:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiD04J6AG9ctRsSjHXNJbVjD/Fty/G8dOq3SmR58yTCf4DeC4fqlvKkBKB8UVut7Y5wZNNhpQLq1u2wXSs56r4FuPo2yJhRX1Xf0+rTJPlWO5OefzEMcOzbPGVL3su09v92pV2PwlQ2ChwpmwuPE4+r2PCIgDzuVgKQkZf2cU5zh/esfxRGPo8RPnqxwkj+Mqg4Oi/RG0BG4uvj0koYqnRjNjVoEmFzueHB7MkjYAnvJOT8tuqlKF1qTggW7QnVEfn2Kf514rrk1mxr0S3Dg14/+P9P20dd2Rfz6udfVU6YvYouQOR8hTA3T81Crj4EDnq6HxrAS6fiP/4a62MjMTIMdynxHqMncOTZAh7WHLPHTOM09WdbDj4Nup3KnsgAfw1vHktF3qTLJzIZiDLaUloebh6hTgrYloNqg7p0yNLJRMqi6cSjEfveGrDFayRCLaE3FkpFgLoCyS8daEqeOZewP2EbxUDNwmXweJviqTxv5hmziBT3XZRG5i1jIKE1XYrBuvjaNEvxJKqyeinPDsqIr5hLb86KmhsbN67IzlngiAIb191NgOIgFhCLBXDDM4ypco9k5hM1k15SywFh62AuxqDFAWAE6FJldxsIKVpRAlUmKmRFkthR+oOulJqa0GcO1oRtTPWgO7jRjrn09W6gmXjzYCHC8iyFkh44IprQiLNSdHEf7BFymVzPyVWzbzH/dnc6xrqMB4rJb5BaHFWQo6nkET0+Z/LLNyn/egTmoZWQQPztiKVRjdDTqCVaC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(86362001)(6486002)(478600001)(6666004)(33716001)(2906002)(54906003)(41300700001)(316002)(6916009)(8936002)(38100700002)(186003)(26005)(6506007)(6512007)(9686003)(53546011)(8676002)(44832011)(83380400001)(66476007)(66556008)(66946007)(4326008)(5660300002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOVM9L3tEGrEHFOcNbPh4/RGA1zi+ANeqpL7sz5R0R3N6mUF7t3PN0nrrQco?=
 =?us-ascii?Q?4hGM7bSSZSEdHw8uWrHZJE6scUUPRityPTytpczTjRv/KsnuYNZLXAvn3hNJ?=
 =?us-ascii?Q?nq3PholJBsm1lAaN1Y9h0yyAcOahGv0/NdseVYTgXEIWAZiTX4FDuzo+JN4v?=
 =?us-ascii?Q?nGJGZ3z9yj1mtMz2qL+X1BuehpmTidHsK1TxafXkdbTu2GLcsOO4INRTF9+h?=
 =?us-ascii?Q?TCaFt3Bhec2/ancY+kYZwPt3Jxebn1Vi+zM/OCk+6p9MCE0TuDvJJfo4P6Wa?=
 =?us-ascii?Q?gSlykVLq2MYIFbNoowdK/xpa+94TdYbMcb6KXZO0Ld054+T/VKvs0n8/xFo6?=
 =?us-ascii?Q?vYxqiSTgZks9zqCqTqNEVxxmuFDKI2ueIJ6bbPjqbaUQFfpdLK0vFOekuX3D?=
 =?us-ascii?Q?+AdqhGjMdWgTPfeumPgX1j/JuPy7xuVMj8k9LmjvguydeceNEmPmQI+aAXxO?=
 =?us-ascii?Q?vvk0mbl58Dg9tyAB8zeSdCYgMnzc0Y9s44Tp6Jfxlbkzrd9HGS7u3/sjP28J?=
 =?us-ascii?Q?hQ//4xX3aOMz4t4W7DvRAp2gn62AzTHXHgiBBhdWW6M2hw/e0Rf61dVB8xmo?=
 =?us-ascii?Q?/dTWfAKSJyCFQeuRy8Tc1O1nJev1YMtgLwB6vNMykz/kMOECa9A8b3j7c2Fl?=
 =?us-ascii?Q?4a99yIP9M44BFEw/h9k5oEr9N1f+tnjH5mb6tFmjYRUoEKZ5+83k772aGLU/?=
 =?us-ascii?Q?lnd8caZgECHPn3Vkh8uYdJ1CqQ0ctylKCyK2E/grET305o6hZQNsfeDgTjvC?=
 =?us-ascii?Q?lUMf0dRQOZk7k+IzJSczmZ9uFrwTBrtyaXTIF9156FvZrvdAMkGPrVhMhTKR?=
 =?us-ascii?Q?0kqxGYWbNHArL7Mu1kdo0biXgWY9ZHJlUucYUaHNfG3PsWUhW5xHeSgvK0c/?=
 =?us-ascii?Q?lL/cZg4/85aozlRF54K/M7BVbuRlG72AB+jCxCE3Hr5JIhMmq15GrH8EtsPx?=
 =?us-ascii?Q?2Jb5V/ZPXTC9jWsidE4eliHaoBy/tAmUnEurPVP0Jj0UkmzuS7nnZXaLYmw3?=
 =?us-ascii?Q?ujsY6Ms6tIWKfhXYSxzytX9xV9HmKLmm4fnyCCkJ0PQU6sOD3GL+9TQaS1gx?=
 =?us-ascii?Q?TAps4KkY5+VocJS+N4pqc8xaOdJ3wU34PqUEwVjnzELhIBbiW17ChXB9fVpl?=
 =?us-ascii?Q?RyNwAM3q83cKCTra0CRhj45PEaooMKHk2fjweptxdKrTvelzxbI4LbX3rR4i?=
 =?us-ascii?Q?hPmbm3XHOf0ZZYoQkLObtzCMSMYYU+FF6Ztdl92t2torlSXJzH0VM2PRJIhD?=
 =?us-ascii?Q?94pLXHQ+OftIIKWSAVYqYaFoscokdGQZx3nzFkIC9UwB0u6uOdxlAGAtwU0g?=
 =?us-ascii?Q?8/sIjbmquJwMpm8b12ZsBM047kZW4ZPI6fBF2utytS1+uMjzSqjK2g3b0RpT?=
 =?us-ascii?Q?H1DyC30ftIwjdYolYj+zRvUN22Yv/XDfpolCeTia+Nu5WcGHRSL3obL7NCCC?=
 =?us-ascii?Q?8ZTU0lqW2RLX8RBMBdeyS253e/+SQ0qo/j4F6fhepYQeOAJJaAa1lj4UJNAe?=
 =?us-ascii?Q?ZsiEA/yaSkb3L1tOGkpR6AgbLH+4iWUVEYLK6TgaRWAGV+IfWYCvRnd7riW3?=
 =?us-ascii?Q?SGIrhur52kewsgL6ictImW6h1dgTzfo7eEwlBwuzZloUFLhP5gLV1/Ty2cdr?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9AVTqbVOgYC2Wjc3r5NgoRnAMnoK9Vb9W/N1R2nOG/6q9eua1Ntg4IML/wKY?=
 =?us-ascii?Q?1IIcydkdaDOWpU8T1cRlWNkXWQnJWClLtaaw0HXd2iL9y4iuVZvu+aSzhuTN?=
 =?us-ascii?Q?wUaJc+qUfPIs2WlhYarHtiiL/h/zQuiHl23h63iZD5e8ilwx/PgbnbJTmnT5?=
 =?us-ascii?Q?PU7eEustV4CeLx3U5M+5u2YainxuHDBMr6TTx0IrfO0kTL7kCzgTZEBMSJ7C?=
 =?us-ascii?Q?G93LjOnHA+5LzR1xz5Tuc9CjUZnJYnQKURMV+MARDK1Rn0vHOO/37EN9H/cm?=
 =?us-ascii?Q?26ZkagLDGghaiLUWyWkoNlzQ7om1bGgzNmQ1DdQcI3uUGeYsyaSfc2lGNeEe?=
 =?us-ascii?Q?VKnrK7qrmNOdXbFF3UsamXqOEuMu/axsgeypgTei7kbdUeq5GRc7Dk1QrgDg?=
 =?us-ascii?Q?N7Ss/6n8Wg8Jw4ipwoTYxjVUMLiphf0cR9EWEERZFjBxyuA4AOrD2URsqpJe?=
 =?us-ascii?Q?MtfFWRZw5UYwJHB2JMofmAX/qHtus3a6bGvIgJ5mA8XlsxBh+cESKzyFS4Os?=
 =?us-ascii?Q?b1/XPlHUtfLsk8Skx0/ahylMTeVuftSRJpTAWFgvhoFD+kfjoqxD2yWl3vu6?=
 =?us-ascii?Q?+FB4XzwkQxlnGpslnyUYK8fvoG+PgyWm5JKpe9gMRJVsEUsIqMg573i1Hixf?=
 =?us-ascii?Q?0b5elG2LrpD5ZJen9BtFiXlQrNz1JU41Vpm+N4AVg6hujHjY/YQ+WhIDYdp3?=
 =?us-ascii?Q?IdvbOOD4gmfo6AVmN3l82P8hdML0yNfrQk36KrVmR2qCvxxKYttd+NYQOixr?=
 =?us-ascii?Q?KSdRM8lSDjf7HerMxL9E9LIwzwBogMpcdoQ0sV071BN0+SmU7J0AbYy9JCz4?=
 =?us-ascii?Q?CZzf9aOHhPIMqWsGvjPngBVCYKB1n+lKJnVN4kVxBVCECOdmtmoX6dhUrZBn?=
 =?us-ascii?Q?UBqZaC7RYsQ1pV9w4GBR6UWjdOfpSnSP5+8JopqkZPit+C2hJBIdhqrbYXUq?=
 =?us-ascii?Q?GwbcEOcb3C3PLU2QwYujeg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b455d2-8672-4525-ec9d-08da816b167a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 22:43:37.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2SKLuP1vFq4W3zGyjETeICABkeeDbEZ+6/A2QrOOZgL6uUftjm+yaWzW9huzI7XNVDgm8Ei/giFkAo6Zb3Vng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180082
X-Proofpoint-ORIG-GUID: wKgwBTIVUDCSiXMVi5eNPpR2XewZmJJn
X-Proofpoint-GUID: wKgwBTIVUDCSiXMVi5eNPpR2XewZmJJn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/22 16:31, Miaohe Lin wrote:
> Hi all:
>     When I investigate the mm/hugetlb.c code again, I found there are a few possible issues
> with avoid_reserve case. (It's really hard to follow the relevant code for me.) Please take
> a look at the below analysis:

Thank you for taking a close look at this code!

I agree that the code is hard to follow.  I have spent many hours/days/weeks
chasing down the cause of incorrect reservation counts.  I imagine there could
be more issues, especially when you add the uncommon avoid_reserve and
MAP_NORESERVE processing.

> 1.avoid_reserve issue with h->resv_huge_pages in alloc_huge_page.

Did you actually see this issue, or is it just based on code inspection?
I tried to recreate, but could not.  When looking closer, this may not
even be possible.

>     Assume:
> 	h->free_huge_pages 60
> 	h->resv_huge_pages 30
> 	spool->rsv_hpages  30

OK.

> 
>     When avoid_reserve is true, after alloc_huge_page(), we will have:

Take a close look at the calling paths for alloc_huge_page when avoid_reserve
is true.  There are only two such call paths.
1) copy_hugetlb_page_range - We allocate pages in the 'early COW' processing.
   In such cases, the pages are private and not associated with a file, or
   filesystem or subpool (spool).  Therefore, there should be no spool
   modifications.
2) hugetlb_wp (formerly called hugetlb_cow) - Again, we are allocating a
   private page and should not be modifying spool.

If the above is correct, then we will not modify spool->rsv_hpages which
leads to the inconsistent results.

It is confusing that MAP_NORESERVE does not imply avoid_reserve will be
passed to alloc_huge_page.

> 	spool->rsv_hpages  29 /* hugepage_subpool_get_pages decreases it. */
> 	h->free_huge_pages 59
> 	h->resv_huge_pages 30 /* rsv_hpages is used, but *h->resv_huge_pages is not modified accordingly*. */
> 
>     If the hugetlb page is freed later, we will have:
> 	spool->rsv_hpages  30 /* hugepage_subpool_put_pages increases it. */
> 	h->free_huge_pages 60
> 	h->resv_huge_pages 31 /* *increased wrongly* due to hugepage_subpool_put_pages(spool, 1) == 0. */
> 			   ^^
> 

I'll take a closer look at 2 and 3 when we determine if 1 is a possible
issue or not.
-- 
Mike Kravetz

> 2.avoid_reserve issue with hugetlb rsvd cgroup charge for private mappings in alloc_huge_page.
> 
>     In general, if hugetlb pages are reserved, corresponding rsvd counters are charged in resv_maps
> for private mappings. Otherwise they're charged in individual hugetlb pages. When alloc_huge_page()
> is called with avoid_reserve == true, hugetlb_cgroup_charge_cgroup_rsvd() will be called to charge
> the newly allocated hugetlb page even if there has a reservation for this page in resv_maps. Then
> vma_commit_reservation() is called to indicate that the reservation is consumed. So the reservation
> *can not be used, thus leaking* from now on because vma_needs_reservation always return 1 for it.
> 
> 3.avoid_reserve issue with restore_reserve_on_error
> 
>     There's a assumption in restore_reserve_on_error(): If HPageRestoreReserve is not set, this indicates
> there is an entry in the reserve map added by alloc_huge_page or HPageRestoreReserve would be set on the
> page. But this assumption *does not hold for avoid_reserve*. HPageRestoreReserve won't be set even if there
> is already an entry in the reserve map for avoid_reserve case. So avoid_reserve should be considered in this
> function, i.e. we need *a reliable way* to determine whether the entry is added by the alloc_huge_page().
> 
> Are above issues possible? Or am I miss something? These possible issues seem not easy to fix for me.
> Any thoughts? Any response would be appreciated!
> 
> Thanks!
> Miaohe Lin
