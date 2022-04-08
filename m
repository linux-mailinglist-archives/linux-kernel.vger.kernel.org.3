Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64AE4F98D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiDHPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiDHPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:01:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E27F24CECE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:59:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238CPIlm006371;
        Fri, 8 Apr 2022 14:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2zzyI7smGU2RMQ16UaE9y0utQG3Yje8jR7Jabb4p8is=;
 b=0VB4y/aovcWeOWiOZgF9Bm5mK5IiG0Gr9xPK+Oad/DUQihftO+SF+tNN6wBXQa+aQE+h
 V+AZc4DaAKqyfAk+TsJSaDMByRpFIYrnZD/Pba96cSggM0JtO+7RMrZbtYIhc1FsIcKP
 O2pOz3RSGBYJzYF/UtxMq0MuZvVpRwCHxFkjv/riHqvhOBBTHKdJkzwipfnzCCoGL5uT
 iortM6vc/mBVbWXIAyREI9k/rqrJpLdN02Z+ymsF9XAFCTZSeOFCwCLQaDTpiKeQ3CLq
 Ce6HBaRst33K4IXaR0cR1BjBj9BVKgfcr6OyaufZMijLnz+hRWncEoDoIuN+CJuraye4 bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31qfnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:59:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238DUqIp030686;
        Fri, 8 Apr 2022 14:59:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9805byw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHOqRGKpl/nVIcJ3AsLIQ5zqjS0mgwAwV85dMwV3NHH2h58LvxDNTRcgFH3V/YAkIMLlzYvFtN0kjuKF9m29fWu0PiT5cIFkwJ4qs4bAhLn15RwAQATpn+XfSUmeS/kj8XDI6LIG07Gz1nQAS3fr62XNYQ/UQIY7LRTqGUm6ev2BjhdEX/zzdbfmxbHH0Ch+HOTGNkpCnThi5Sbqj3BntAsACZq5Py5hqr8pXeMvxZtEJDWdMkjvoscgY6V89uoGUKdraQvS5l6pioAzHvYx/ErsJIJFbxMqg1ymHi8GpLpKy6dekYyf7qu5O62xDoMaZ3MpYSSDBz42GPzU2Yjuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zzyI7smGU2RMQ16UaE9y0utQG3Yje8jR7Jabb4p8is=;
 b=XSNXxO2/yN5sLUo+k6hUsyEXJV4T4noWMSWh3Es8hEhEnp4xWhZVY39/5XlrVLtt2scWIDQg3fJ7WEnVBlHe/5tD+kMkdmUsX+IPh37if9B4e8doGVXpphxxVh3+oLoT2HAN1J/H7bPJPCyvgR+JJveUl9+TQDijjEMmkkZ/6TYesZTgRmCfuCtyUWpyLzaUh+5Rebi+DsZ1QUbzMjBdABNGbn+oGUqiPXvQBkbqyjLeiJLug+66fUzL2omeUc+dfMLyHrAFs/1VWBplTN2/QdJEE07KWPKc07QeGmv16uVk+NB/jUOJbUCIzVneGaEjS0GLpd2GePX0HAZwo+RhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zzyI7smGU2RMQ16UaE9y0utQG3Yje8jR7Jabb4p8is=;
 b=X7BtX3x9X9JwIPsdft3wWON3OGDYIg3ynKFTXm8fwEq1lmeVFkuT2EEzkPSLGD3jnqDm4BjsAtx23bRaBaAG9nMLzl6KU7qgG4qBTw9Dqc9n4IijU3j8KVlvw1IDO/FaWMeGvmnl3JKOinOLw89jdvrawbOTVCcS0BTprfG+G3k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2134.namprd10.prod.outlook.com
 (2603:10b6:910:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 14:58:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 14:58:58 +0000
Date:   Fri, 8 Apr 2022 17:58:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v3] staging: rtl8723bs: tidy up error handling
Message-ID: <20220408145836.GV3293@kadam>
References: <20220408144442.17611-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408144442.17611-1-hanyihao@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f1071c-f47e-4d3f-5a32-08da19704f60
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2134:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB21343FFE1171F012085287FB8EE99@CY4PR1001MB2134.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQCNivOcG2mopvsdqBHMmpL4uWz28EyzSAguuNj4ZBOrWqiK9oPU4N4c/tKdklXgtbjdXShsmt8uauIm+YUXeO22yOxznEGEl+7K/R0v7obx+teR59qctf/VQAHftP3/hcg6tFwTVxYpmVYME0GLLlvb38Y3irRGeii5CrKFNmSWu+j+7brzd3Q4DmdhVKF25GlohsW7NiI1fW/uhckHyv1/hIknsGj0MT8yV+V0sxAX9YqlL7QQQH9mf38z1nEkwVbDlgqmLP6uTk1ZmcbPM8Desi7uQTOHN5GqOwb6cvo5ogP4zzTuZ+3XH9hsHCsMa6yA16gGuji0kN8bPZYW2F0+Pt3NFKCUVJi1O0On9963S4Jdb2S/3aHc4rOQg7A0gveygQr0UAnwweonauhzD9Qp+cOrGLzei+HYNN6NP/7D8ZegKPQniSV6Av3/FSbTmQtPZdFS09GaBjGgrOgJpSXcqTN94cr5cY7LIPBUP03CRHQb65YNiwJPXeH5JB6uYOVgK4Nz4/KTskxTT3PTMj+kwG4FA562W5DvY8oKiNRpNkPIhn4OAiZxbv1+x1M/TQCyjFOr61DYfVvYHtiyiQVTxVpoLNDGu9CAFD07A5fxSih9cVnXiI8e4aJh8fNkIQoJ1dSJJNgL067cfOVBCJiJ3YVXF8+um6CsMideUW0y46MldIyqDgRAcKn+FCTugY9DbIIDJ5fqwdlexs5y4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(7416002)(508600001)(6506007)(44832011)(26005)(33716001)(6666004)(6486002)(83380400001)(1076003)(33656002)(52116002)(186003)(54906003)(8936002)(4744005)(66946007)(66556008)(2906002)(66476007)(8676002)(9686003)(6512007)(4326008)(86362001)(38350700002)(38100700002)(5660300002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxSIuQZwA/+BJyJU6pEmKo46hrxrlE6p2l/yri3Czqms3ixRvnMD2pStmztD?=
 =?us-ascii?Q?ZRFsTV50be/7CtRxxSnaiz8EGQOzF7QEqoF/eWliQekvmi0SK9EmyEvHkYOR?=
 =?us-ascii?Q?tInq89j1HJRINugHfkwSf/lDUBjZpQx5+WsrEef99YiOYENc3xpx7r8Vy3iA?=
 =?us-ascii?Q?QtnXwdIKy/EHNr/3qAR/HQEbVEyGjgK0iWJ3XXLFjIz5AWjPtNZadZrv+cqt?=
 =?us-ascii?Q?l1JZNcH2NRQfLnKfKvbl9eAXYrUgSBW2mLRmoy2mKH8nDPOE3xzUTwjhVC6z?=
 =?us-ascii?Q?oqHO/Z1mBhumfKEIN0a3QqnZMT0zCS98/vaOi5w847wiW0OzgczA+MzPOJ5X?=
 =?us-ascii?Q?FUwvKv7vI9heKjNuME1DctwJe1XZwJYvFABYZ0Zgx4W6h9b+4ESZlxuE1q54?=
 =?us-ascii?Q?X7jk+bswBCNpUNsrE/DwplWF80Beq9GoTUlOCrwEhj9Gp3ghraH4RzL9iBla?=
 =?us-ascii?Q?eP/aLI0REeb30GoJT6dhPptu4hbt8t38gCAu1/hhkoljqdxTpQrb36W0FA31?=
 =?us-ascii?Q?t9OxPHtjYgPBAs1MztUE6G7arnhUfq+b7UaNP7oxAyg8jZEJysXYIr/FAB8Y?=
 =?us-ascii?Q?v+/17IhoNWG6+kvOVmmpRQ9XiwGxiZuQsSQqOAmwKbJ7qGjqm6qPJr0Hlpd4?=
 =?us-ascii?Q?ZHeb9wufv/jJFs7qVJ+5v0P71hwupOdBduZTlzMttsFI1ILJcdKTrQWm4AUu?=
 =?us-ascii?Q?gJNVhORlovo8qMbo17kARx7mwqdlMnpW7bz35malHemGe6QvvXusheW4WMQD?=
 =?us-ascii?Q?sXmvRe0EX8zEH2y0TptvIAuvTc3oYarmX0etETVJkheFgN9XEfRzAR44DmmR?=
 =?us-ascii?Q?zRfubJfQYuYlFhqtMapn/ux1JENrJQsGkSV97tf8/GvSSwAZjmRwVKF75we8?=
 =?us-ascii?Q?tjow/XtgwDXRpxb+zcIahJke8UVgmEktJ1GJkAnJqV8YiOOPuPVQSSiH90UX?=
 =?us-ascii?Q?QTgK/blXia/+RuqH4h54m6GahO9J4QPZPkuEPEmzGc2GtQI0hU75aXdwMMww?=
 =?us-ascii?Q?9FikWRMUyDhPdHEgsVsrL+470/aTMcl2eWmvGQ0nA1PdmYdPIoHE7iFkof9x?=
 =?us-ascii?Q?C59Hu63lsVYcf34FOupWY70UBWgLUDaI57kp7a+P/LgSgXrrGfScxNjQEOKX?=
 =?us-ascii?Q?aumFGfrRaVRsxFG5lCu4qTPHa3z7hFiEMXf4rouk6nFHNYHzQz3q0TGscNRv?=
 =?us-ascii?Q?TRK+yf4cxROIzfKQapPtqu8NEDZFzH0CeRzCb/xqlZXunC7Qsl7uAx52s4fa?=
 =?us-ascii?Q?VsQMRssIjCRFmJzJByrgWxWlVZi3yHOZeZdbKaydOVcfrPVTL0mbZIERMHRU?=
 =?us-ascii?Q?ul2rJncbTHvNssPNo2JhmiSWWqA5rPaBXkeKnm05PcNnFfnES/otkXGzh/XR?=
 =?us-ascii?Q?jGWf7ouuJPDR7rImABS4+T+LWmHY0uY+x3RrtZH1eKrTnzkzZnv7VmdM1buG?=
 =?us-ascii?Q?FhgyvxUZ+laFZlWsAGzjXRj1mIIFqeWWMANFBFgNVy5MqLWTOyM3PhpKlFSN?=
 =?us-ascii?Q?9s9VRPljaHzBxk7uJ0cLIdj+TRwG3Dqam8eGXg4iwhUO6ZlgslGpNla3TCbp?=
 =?us-ascii?Q?RyUyWZ44LSKnzH07WVocC65HcQuFL0xHLS3T09KIXH1/1E48lHDc14YtA1Dn?=
 =?us-ascii?Q?AylyOLNr3hp8r+bDggwVZfrw3tETL4cZU5XFCuHiCkhhAixG1/qzcTyg0aPg?=
 =?us-ascii?Q?GoFew4RGH7mwnzqIMYY57eZ4gyCTwYJJfqNYizWnL76ljYiflnv9ip9VLKTL?=
 =?us-ascii?Q?Uq6Vk8RzIMgC0hY5gMx1m+90eskK3Hs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f1071c-f47e-4d3f-5a32-08da19704f60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:58:58.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmgDDCbUHEIIl/trq9KmLIYhLRvLTW4BpnRGGIoZSYqO9ttCtguRbWQgCcFigokkCAUVLosc8ezHpqPYDCD+iWg0wqWqZKp/lBiq/QkAyek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2134
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_04:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080058
X-Proofpoint-GUID: U_5GUDpeei0Qv1ft3tzo2kt2m3XKCVl4
X-Proofpoint-ORIG-GUID: U_5GUDpeei0Qv1ft3tzo2kt2m3XKCVl4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:44:40AM -0700, Yihao Han wrote:
> The check for if rtw_skb_alloc() fails is done twice and is written
> in a confusing way.  Move the "if (!recvbuf->pskb)" right after
> the allocation.  The "if (recvbuf->pskb)" check can now be deleted
> and the code pulled in one tab.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
> v2: more extensive cleanup
> v3: edit commit message

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

