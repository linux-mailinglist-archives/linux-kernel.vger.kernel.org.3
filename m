Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1E4F9356
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiDHKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiDHKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:55:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0229449276;
        Fri,  8 Apr 2022 03:53:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2388jbpS006378;
        Fri, 8 Apr 2022 10:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SsFg1aMqug3Zz5afyaZwovmNDm/UMD3lncaJ/AaX4Lc=;
 b=yEtu/7/sFLL8dlYMJpYSdY4iGlyMcbislezGqCgVW16VHRfuYb5Tzl2yIwgHgryPVg63
 D1n2P1hwcJ+II/ksnsqzpKXnDATgvotC3ZeFeJRn17G0PWnBW7RC90QsGxIiFjhzL+gC
 X9EaqXK/z8ex59hc8ZuzwZp47FZOyjOhLWU/8okHFcI8+ZXylN8EEKwX8qZIpihF+JDy
 5iiiUA95cNaB36Aqi2PKYxNkPiGPMbGqKxn2hbRZAmeboVtumKLxJbVKKBB0X7OBnDgo
 YUEcFZ1uiiU84Z9AAKsr0wMHQq+xMkbOvr1AzhZ4tX+2FW1Qyno8gdaCyKRnGKwy0Sge JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31pusn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 10:53:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238ApKNT036088;
        Fri, 8 Apr 2022 10:53:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974f621f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 10:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecaAN7AU0f6I41daFgGu0GnoPcef86KPF3JyKvNv/CASLMEJ4ooOGf+hRBTlheSZ9cLUPHuP72WkaLHgxayS7toCJRCHQyRPwmC0dXMJIR7fafvUSq4bZoiga/KCLB3/kHVvm0/NtUHOt9AzAkOocue42EY0nUB6Q+Iuq+dfSCd69xCIlLgsXcN29W/gdhMw8p6SZhDLUyWEvWft64G68BFgWqEl7zIvwe1+SfggF8IWjj5RIzl+P99ou2wSz1mmtwUN7ngRnTCR4zUUgYsu2BlNXaKQqux/yFr5tZ4ztZs8AcMjKv1IaWocEaqEHY7c2RkaueiyUMwLg6rKRa+dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsFg1aMqug3Zz5afyaZwovmNDm/UMD3lncaJ/AaX4Lc=;
 b=R5PokbjM6MM2DLPGo2PxM6bDX5sMQQUIMKJx8RGxCjKNalGAXQ7d98LpXWlZ26hZydwFuUzbv+ShH793XaJgTn4sY9uwsMwshP/NRKkqLpT94QewN5O38g2wV1nV02vzZSsPg9VUoV+NJe8gaVbsyid+bzvguqEQIFDAG5XbOot6LawRlaGxAXZdp1TdoeFyLoqXDn6j7SeztSyMXJtD48zcLiRzBxqpV/PmvHFpAbtFxaE+M8k0M6wUad8oLbBqQoukE69mHPagwo1RsDLiH/R0OGrQdO8XJTYQgmHsJN2oyNHJpcn/pS1SZ93FB4waQMcEz5eH4kghKuTP1oZQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsFg1aMqug3Zz5afyaZwovmNDm/UMD3lncaJ/AaX4Lc=;
 b=nhTuK8ITb8svDrbDQu0BEImcHdRNLAY9bOgRi/OCVINXSf06xC91avjZ9/s4YX8PCF1tlAiIRT+7+VxHOwjiKBhRBPl71dB8iejJPF9S4sqnLcs1kUjuPTfflwNVO34dY4fHdgXGCQvoSPj7DxpiP4DKH+AoTQ+gkcOq2QvFMiI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB5710.namprd10.prod.outlook.com
 (2603:10b6:806:23f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 10:53:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 10:53:07 +0000
Date:   Fri, 8 Apr 2022 13:52:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v3] staging: media: ipu3: Fix AWB x_start position when
 rightmost stripe is used
Message-ID: <20220408105242.GT3293@kadam>
References: <20220408104222.13893-1-hpa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408104222.13893-1-hpa@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd1dd23-bc64-4f13-a547-08da194df67e
X-MS-TrafficTypeDiagnostic: SA1PR10MB5710:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB57109868FCBF48CE437F259C8EE99@SA1PR10MB5710.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKYIoq6/2oENRsECT09iO0NZQfJt0v+UHEjrx0vCV26WkcZXXCTKQH36NghSB2fUv1o6lLNTltDtQZYlm4lZw9FrEVIOWXM5rmQSufQc+U41LZ/SXEvdt20zcFprALVf2llbncdFczJgvhGggJHfAXxcBFLa09PcHZcLqcXVil+As92R7wLuxYOoex7OORwOFBq1olypS3hWFRrytyx9GotfGX6igVby+/IGzLdCnfiFYDUYBOx4ownMv0MtlzmUu3ZaOT9U1U8Z6BzsXK7Y9xYTCl3kPnwU5rWdo+pRO3zOyBk4NWlNYmBfTVi3FqzzzWJBHoETBqj4/bA4Prm7xEgPONrN9dgDzs9Qmg/pcWJV4V/6aTq2Sil5ZmFyHFtCphX1WTP5iJI44hg4Qvngqsqg1g9T6ykZde0fVYAalarGe/cRLGRlQsvzRgksSHJeWYvfas2ngg9HkBQ7j9MRejQafFKGDU1zsqPV1kz7e5942Xne8jNBS2EhEw6yg5a2BDF+5888nciHna3Tk40l3HiHuymKa3hNVImZuQw7WVPqcHJ/+ftFt1o/f3PDkbp02e7iRGVnGFjjsKU/gbnoR9oLdz3rwKfxcawYT7JvKNg2Dl0JMV6fOw8/6lONJPy5Dl4BVS8YZLZBQXNqI6adZgM9pOR+G4lvT7q88KSLeWEIuiAv/baVoIaOXr4nXRDx4bI3p2PBRXPAy+MAUZlVOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(2906002)(66556008)(38350700002)(26005)(5660300002)(6506007)(33716001)(8676002)(4326008)(186003)(44832011)(66476007)(52116002)(4744005)(66946007)(6486002)(6916009)(8936002)(316002)(38100700002)(9686003)(86362001)(33656002)(508600001)(54906003)(1076003)(7416002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7KXMyP5vnsBiSK69ImUuz/VUIyVyuI4WyIsGgRoxp8q4fU5Rvv+lwRUbpEA?=
 =?us-ascii?Q?VxWx5EypNHIPWKDWcGeDIzFTgmTtLGgyPXk46Q0ZMklEQRiQIDdvPOnu9J1s?=
 =?us-ascii?Q?cfIWYAtxAeOdSZ3mb2j1ls3s3i26ICm2KGtCynNtDWu738Hub7rtyoApW3YV?=
 =?us-ascii?Q?+kvI/JFA2Oe0ofXFWCzWPvoiWSO8wex+p1mfX6obSONGY81xOMXMxTk6JBAc?=
 =?us-ascii?Q?iqCDSorStU8Br8tesXzMfJiDxYfy0aZdzl3P84A6m9nJsrbc403A1dIHDrn7?=
 =?us-ascii?Q?dgBfC2NfdfmfjoNddj+qmCkGTNCuDyGCNQeP9pZ94G6BiXpEKl9arfhyAyg6?=
 =?us-ascii?Q?B19B/pTWiz22K5cYQioH82j2IZ8CTM9HXVknq+29Pk0yR4/Y6FkLC23tMYEY?=
 =?us-ascii?Q?AxeVfVqn9uiBkSLzBkS01ie9Ext9qhrd8D8rGWEmFtttoD61BaxNDzQNXMt7?=
 =?us-ascii?Q?/87NcTiEkVb/SPMhHglyJe1SlVZ5b3jwZ265zoYl9DqOwGY4wh5vBtZlyVWk?=
 =?us-ascii?Q?vk/egbpuEiB4/vLfvTvwa8nYcFi872A/G340QpWHwWQyFJSzaNIvK7Z2Dr22?=
 =?us-ascii?Q?9ANXy0Y09uRxiR9Hjib0cMjbszOB6gqWrRi1IRK4DJ5HJv2fBBn0phSPm8nw?=
 =?us-ascii?Q?oLR1YqaPsTH7Ulqa6F381L4XSAYQSXd+hg0ZCg9tQI8n0HWGE1N6j1hT4w4s?=
 =?us-ascii?Q?39OMJ+C3YcOBujTVZrudoDUfoeH+7kQCJbkvjWW/ipH7LLH6boAf8z3zYlQE?=
 =?us-ascii?Q?T4mHleBIgfXcZjSgTwCd9RZiiTxshf2NeW+m/x3jzmS4bMUO5gt+sj4VIi7W?=
 =?us-ascii?Q?PaXKb/ZhlZ8SvYE+bRcRESZPEXciR+bk7VaJ79qsnXS7P3sacvOcMKHe+Y82?=
 =?us-ascii?Q?9AfosTxrMiILcQjuz9pkIcTY8NRK8cpd9PcCle3qgOPpJhqwJEOU2ykJYTw2?=
 =?us-ascii?Q?VhYL+bkD5cpf9gDXAR3Z7nvkjEsirCQBQjl1jP+Lw3ab7uxKxN12tFTiIm+o?=
 =?us-ascii?Q?V98x97OugF/74ofXn6lwaCxn06MxfzwIPC/tcEBxKarPvYHYyBItym0IWPTG?=
 =?us-ascii?Q?ydcPPn3UjXNv/MOGPliUb0hzenIEfl3yF16IkAkFE+FZo5xyD/04Z2vFyoul?=
 =?us-ascii?Q?HHwzmwABwcdqxXKMEZyqz0vldkB0Y9MxNFa23HnORDeonvS+KkoF+Cw0RINq?=
 =?us-ascii?Q?+Qe/27Bh4hd43rwaTD+PyCeYg+cB+QiJnWsQCLYBdgtyGf/UrTnLjmWx5d1B?=
 =?us-ascii?Q?pOtwj5XWCaSLkMn+FQD5AxlYIpiE9BoVb+hAmJAHza0BwgT/nFAK6xYhMe6N?=
 =?us-ascii?Q?G73/8jz1kNaRLugEpdc0EixdFjbJ9FupSO1CAyGJ3GbQ3y4cOHrW99CFrtNP?=
 =?us-ascii?Q?lXTqh66SyObJBzN5g5xCrhE5IQxvY6wuxHod3dHpBpf1Osk0t7NPzkwb8x+g?=
 =?us-ascii?Q?xcQiMxAShEb3b0ic7CZRod1nqtIv7xjTu0eeAnwotCRqJcqvT5NvwVVxuigx?=
 =?us-ascii?Q?trHvDo/7LHf3ym1TRFfTrbKDojd3BtGcEtU9dYQOfwYz6BoK8pG7ioHhn0N6?=
 =?us-ascii?Q?uWY0SCStHHhIoYNPW5hwrmfMIT9y/yTub4LVBdiVIoeB4bG9GUdMBTqVzJxM?=
 =?us-ascii?Q?7Pr92OREkbVQ4xzMpDsMEg5JhHiUM3c4q2ob1Xm8aRWlYzvqKD4vtP7k84QK?=
 =?us-ascii?Q?W6fIk8L+pPwvQ6nNCBNe9Kicfq/xnpAJYNmZeqAekp/3iKKNqsCqmfLkdlL/?=
 =?us-ascii?Q?/i4ep6t9PPkYZ0BU20J45SsjzA1T5j4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1dd23-bc64-4f13-a547-08da194df67e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 10:53:06.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9ywNHKi5jwuMIaYAlcoYhxbmHzOq7we00asg7XV0poR85diuDrfYYTJThJnL2aGU6XP8/UNhuSfquSDcfbLtsP1+B+RyvDNm6SHEfDMMmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_03:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080055
X-Proofpoint-GUID: 4Pe5eyE5vMw9C2Bez06wjiXpZDZ21c85
X-Proofpoint-ORIG-GUID: 4Pe5eyE5vMw9C2Bez06wjiXpZDZ21c85
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 06:42:22PM +0800, Kate Hsuan wrote:
> An not calibrated x_start setting would result in an incorrect AWB grid
> configuration on a sensor when only the rightmost stripe is used.
> 
> If the AWB grid coordinate is set to the rightmost stripe, for example,
> x_start is greater than 640, the AWB grid will be at the rightmost edge of
> the sensor. The AWB statistic will be fetched from the wrong place of the
> sensor and results in an incorrect AWB estimation result. Therefore,
> stripe offset should subtract from x_start to have a correct grid
> configuration for the rightmost stripe.
> 

Thank you!

regards,
dan carpenter

