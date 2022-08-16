Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71873596603
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiHPXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiHPXbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:31:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600690835
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:31:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GN0LQU032471;
        Tue, 16 Aug 2022 23:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mBf8Dyf/X+j0+eIdzzOK6gbl93SgyY1qJl2fnc9sa5Q=;
 b=VTg2ANAag66FPU2O5sg4JnvfQtd7hhhMk3OgJlUaIs86t2uQwaK/okI1kvOSkPpqxUKx
 7ddrMg4SxcNvdrOyLL7KlOa+B35I7zYX92G2FmEKwbYOGHqbzAxu/9m0ePkyhqIMWxnv
 fIEhZYKKcwPbL6Czl4SN3wjHQy9W9Yjz7O2pnmV8AJGTQZw7F5LlqgPVaZXjd+bJPcws
 akku8azxt0vNcOLLPDeG3EGl+Wi0am3des4z/RxYn8RAPdrpSz1emBQ6msy9fYMI16Pq
 UUAvKBJ4HMtFFhXw0NmzvehdYl4tC50aKEFPYZ6i4ri6tz4U0V4EVuQWicUpdpDn/rb4 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3js7j9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 23:31:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GKg8Qs004258;
        Tue, 16 Aug 2022 23:31:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c478sua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 23:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpeIyswse52sJkFuwtGRWnL1JOGkHURDB5nw+EnyZ1NVs6oNPIVf4WXJWV1XF1+HWOxxZHrMGi8J4RJXoIMgJZjE64nT16B9a9XUDhLJVUWICtKYfWTXSLXcbeXHh8qIHEx46gA+3KjOS3rQPTD5IOm20XxAItqO4D9oAkTf5MasN8j1s+hG0p5VkHPzGZFeKsMiE9ronWOqeSBYNnmSOZ0X8MvEGYq2sVoQQjz9lOepa/z0HnhQyh0jGIHRHsOAyNKEoSL4BQtBQETw8I43oGNwrpfb5T6WnI9hNTrvP6COOAp/+sQDUK7Us3QA0/DhMp6VwOeHHc1PdXg5IqQ/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBf8Dyf/X+j0+eIdzzOK6gbl93SgyY1qJl2fnc9sa5Q=;
 b=nSKvTL2o7nAV8ct0g9Y4SthIiOLHWX6XBdH2+Gk7rLhic8ku6OMFFPzE3IpqC6XblbLSbY8bMZun6DikWkQCZp2BJ1LDIKiqy8nbKYHBobKAie9C4uV5fU9iPauP3MJTYaL/WvAyAP07eGQYFDE9NqB8A7NbayJx+wyA8X358tRK0uC1Aefh7koQ22z7O/ioFcn9AaIRu2hNaZHgSX2k7J6i4b5PLd2lBiZRAspif71HYqkqS2hfcAtR7mDy0hi0BdMD9JXUVzftyCoS4PW8QAHoEV+gXHvBzrXCmQRF7ywx8Tcx/7FUipUPeRoLMqSM7LGnpZtAfxVVenDCYXWVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBf8Dyf/X+j0+eIdzzOK6gbl93SgyY1qJl2fnc9sa5Q=;
 b=Qro/8B2zCfvOqbLIrm7kQk2gMLJfl5mMk3cUnhIEqsjh1deoaTZ4qmj+qGxxIf3EmdsPCQ5opwbs+CIoqHhp0TOXMHJSEEZWKiDlmX6NlEs453NqVgdo2z01ah5zU0wy04jXFi606gphspwWOoPfP8hiSYtQE2qc5Vn+Zl5gg4Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2426.namprd10.prod.outlook.com (2603:10b6:5:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 23:31:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 23:31:11 +0000
Date:   Tue, 16 Aug 2022 16:31:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/hugetlb: fix missing call to
 restore_reserve_on_error()
Message-ID: <YvwovBboCJBOJ1Wm@monkey>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130553.31406-4-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be6cea6e-4677-494f-19c8-08da7fdf6719
X-MS-TrafficTypeDiagnostic: DM6PR10MB2426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dDkebZLJiK60bnKq06y0jHl9RkDWGPu/U8dpq/diP+1749XLMoOZmvDbaCwa2vFZ8DNr9pAWF62uSxQwV7L3SN6Fipx2ah/0JgD4VIp2aYXzvokk+ywzG/krwc8qt7Ps1qXCFdb2AZLD6YiY2Diyspwu/EadTRaz5ei/sekvnTb/vvx6sg1+RBGKIuLKpoZxM8cNh6gSZDs2RfgDhz3re0BDLEiJfL1aOqO5vKVaP1xPOgMWICbHsQOUkyLK+QIR/ZdOBybrER4hn8e3QtLoKfyooGQVkESxPaG6Vkpqlggs6ArF+ImYvjamUmRzZAbQz61D9jxifgFuKojj3gpwhtCmQtrAty/E7hG3c60rinhqIJYDp8tzU5DAI+kBJwgsY8ApB8vULStrcTlcJn9cg/1FC5OvHaf1KOBd/DEMidB3XbzIU4C31lgZTJdrnT4bXodTAqeLlTgyw2kk7lTDDMU08TLZIph6z21Oeh6OBJrN2InURlm6yVajzup3fxUsMKwva96bV3Kx4Heg4OCPLpRawIkEdhV28cCefZ50UgcaYwnQiaZq6PUA51TOCKmEUXCguncLp6MXgdGWvreCijmF/QWaQbCcqn6b9M/XxqjTsQ2SlqtIqxefAZ6JVJ56B2ns69rMo9OYf/sxZIad1FKFyvxB5NrqAJf+8Xaz6aKw0zuS8jSAHHsTrTKmf946gi5u04P9JdfKt0tZNFWnk9GQHb3vauu/lQGblF+OFUROkH99mw8W5PPeDJdj97h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(38100700002)(86362001)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(6916009)(44832011)(316002)(5660300002)(8936002)(26005)(6512007)(9686003)(53546011)(6506007)(83380400001)(186003)(6666004)(478600001)(33716001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YIfm0UPChabL3kfU0dMdwb6RPh52CebSptvK8m4w+obD4t7OywzYvHtuyot?=
 =?us-ascii?Q?q/JQYF0JnuirunY/x3IYd9u4djVkWZNvWzEnHHUHBmcEDxNnepxBmqNxJin3?=
 =?us-ascii?Q?aAHVDApOmRJAPFXnTiXTDpkWjgH6M4a6N1UM60XWlylDx5itIkxqWYUzSQRs?=
 =?us-ascii?Q?+5SavMKcoZcR/3z5CYIx9dyFQm2nJPHuzeFkCqq9/vxwmNboERChcVgBblE9?=
 =?us-ascii?Q?9EOFWR8Oc/u7Rs9W7zu4OvW/ADuV+1Tmg0awPi2t/DbZZ/ErqEZ5fR0oUoqc?=
 =?us-ascii?Q?wHUHgMQUUrfbmkqCBc5LmuUIY/LaCRIuA2mpChXekTd7e2ardxMXqmbQ3nfP?=
 =?us-ascii?Q?CKPqgDt2dZQHcS7eQgLhjTLXMaBP1q3jbZY2c+LGH3hqXm47yE2111ZZy6ot?=
 =?us-ascii?Q?Bt918wA3vKAoLpBZWbkuIG6KlgTQlGg9NTK+MY49fq68oSbap794H2WQdVZs?=
 =?us-ascii?Q?nK9gG5x1rLy3dM9ZIb07GwbM9y+yXdU9aSvkn/QwD75B+Ad+X3O136NhDLj1?=
 =?us-ascii?Q?vErMBcYQB/PNcW5WXRtLReZvmkpsOiA/qphSC5uDy+Z06N3Bacmh1HWHdVjZ?=
 =?us-ascii?Q?aGg2NMZWMK6Ltk4wFjdXlWtMf/wBzH6h2WxoEJdEyYiQrJIm/gO+1v2BR0xW?=
 =?us-ascii?Q?4UcNt3uWlzHG8GWXU8J5dDxCafOCC97K/KE8cgsu8odYoyHsVlpEDDcdANke?=
 =?us-ascii?Q?FQ1hIj83Lnchbk7vvQ4lnbBokvRtky00BfjX/nBskhd9c68aER2pDHbxwv5p?=
 =?us-ascii?Q?bfs6SwhPTLB4BvK4qyBvlUxAnxB8j/HJSJzWAXueBPzHDoyomoLbiZu5tvTG?=
 =?us-ascii?Q?zj0yQlk4SxsV7oQglyCUgv9nokcG5D+PThLO52jYCDUk838v0RN0hy2HLlcD?=
 =?us-ascii?Q?7xuDLqkMySg9mjoddL0bjW+JMf8jHhjhxm9bBTsip1y/fSWvgFTIKmvLEdkT?=
 =?us-ascii?Q?h94Aisb58FJK0GMcY2oqIo5NE94xGoLzpBBQuH/r+XJJaeSxYYVhIUH3GkIC?=
 =?us-ascii?Q?lWQgk8Y0g5os1muBVboHlNM0bq9CRNuOZSSrtWo0UinDOS7MMpry5AnwBob+?=
 =?us-ascii?Q?5fyschHUp4lT4gZyJK5GBJhoH4gYF1BXWSoMjmgrIBPeQtHT8AxdI23VvaU+?=
 =?us-ascii?Q?cNG3aUeGEcDqUdW+IoUyD+JJ5gDUo3KK97wk7y40VFxN0D9Zruh+Zp1Q7VNp?=
 =?us-ascii?Q?xzRcjWnhBZNbBqXDt0CKooeZveP3FTHQeqz6t/xVqNyyzcfd9BMiH9tAqWBk?=
 =?us-ascii?Q?XmOnBZImjJPTCkOfGx/1PFIm6hJrfznEQbBfifudu9mHpS/QKtmgROo675Fc?=
 =?us-ascii?Q?mydF99uC9FIQfDS4C0srntdtyFJXirLfWjko6C7GUwLtOqXQgaIFQpUe3JWR?=
 =?us-ascii?Q?qkkeg1EdnkDhLSU+5eq9R16WpZgK0EYBIyA2eEB5zO4XXwXKlm5Nabu7bqTD?=
 =?us-ascii?Q?WZk1JDr3Deu1BCELixGChwfnjsdWbeR5GRwl2pAW5BMgqxcLcm+BNNXcZRlX?=
 =?us-ascii?Q?RKQGYsODKcJG+ZzygRv1+GraXhIs1l1L0/WMPbm81nrvFse/cfF/fHnJ3G0j?=
 =?us-ascii?Q?AK9ykfA6WK5R0XRSoRcBmXDrVGU1O5XGPoySiNZAQrooJ7/B3YOxT0GFlrQx?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?i2vEF8EA24yJrZqqHWWji7YOPK3kHnvtHIntK3gep16p07WsDx86U6XUt/Kw?=
 =?us-ascii?Q?O+PhqrQFlTCKei+m3gTYpVOn5v74eeUXovpt7yxYCI0mm3MGw1v7s/C9eP7w?=
 =?us-ascii?Q?qTBPp8V3lcWoeHi6hyYoST7zsXCimF6aXch9Mg0O8pkoJ8gV4G0s8HrNn1v9?=
 =?us-ascii?Q?PajJj0q0gXRKlXTO+ReYMFaTzjq+qxXXpb39/j0JWvhKpoFXJKQgCs49hjcr?=
 =?us-ascii?Q?LdnrFzKMxjc/BUn9lKQHkH346p5GzBNyBfCuzCcYOpxXbFKoVAs4X7NpGWxy?=
 =?us-ascii?Q?3wEgo4GKxrAIKLNzO51nFSqQKGaXxz0uUbnGciu3ZLWYi99q1E4hw/ofoVl2?=
 =?us-ascii?Q?n+Q7BFNv6xKdOtbx6qxrPQCCc4w+HzcuvqQrBme0jFkluiA1dxgdJweTujAK?=
 =?us-ascii?Q?QRpRhCbRrOSsZfDnNLp+352qPo0fScO7mA8kGIvBXDEvq6tYVLtAuxhjF9qX?=
 =?us-ascii?Q?LXpb8q0osRXlYrgchiL/rCzUQMoDZhynhH34eu/kMHV9bhN57m1+6DKdwA7H?=
 =?us-ascii?Q?jetMMJcs9lH1qc2GpAE3esluU3AatoCiq7//UJxd0fsFnmKu7TgLqs5/WCDS?=
 =?us-ascii?Q?bdaepODmhfLXLWuZWOHXFKdwYMJBtVNOmqzApYA/BO2OF5tSwHy6zd3sUHVt?=
 =?us-ascii?Q?YtzI6FYPp96Mm+d+ZlPolVnbklure+CnhuGYIUxy8zXfvMX59mZM4h7+GqbH?=
 =?us-ascii?Q?kTZGhDMiRzMvc3yJkrVScAwxtqgdc4UN764MyR7FXmzeRWo0xEwIXg9gLfmd?=
 =?us-ascii?Q?I0J1uLAFpxGl9/rCzddkmrBq62hLKSdlXU+JpKTt27mIukf1Wq5jKJMBfWzx?=
 =?us-ascii?Q?rdS3PmGynLKl09wp9+BlP4J3Y0pgzeQ5MMrSyN2DaAhwQQpnDyiIfRqTRMy0?=
 =?us-ascii?Q?adpboXMvpXbMyLI6lQp0lwozI/sBzLOjadt5Q9YQKmm3IlUZSl4gcuIfHi5F?=
 =?us-ascii?Q?YvHl2GEPC+9fZAnUQgJjYw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6cea6e-4677-494f-19c8-08da7fdf6719
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 23:31:11.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNFtkOZA0GLSeI5HzZnDpMmAOe4tfa/4CRXGpvN6/JPQfUnMEsqc/2JHkPt48CzbHSv7O2pcuXQHKvOEFpDn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160084
X-Proofpoint-GUID: PsLgeyMBJz_DACqHDElzSxoDrJBlchxF
X-Proofpoint-ORIG-GUID: PsLgeyMBJz_DACqHDElzSxoDrJBlchxF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 21:05, Miaohe Lin wrote:
> When huge_add_to_page_cache() fails, the page is freed directly without
> calling restore_reserve_on_error() to restore reserve for newly allocated
> pages not in page cache. Fix this by calling restore_reserve_on_error()
> when huge_add_to_page_cache fails.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ff991e5bdf1f..b69d7808f457 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5603,6 +5603,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		if (vma->vm_flags & VM_MAYSHARE) {
>  			int err = huge_add_to_page_cache(page, mapping, idx);
>  			if (err) {
> +				restore_reserve_on_error(h, vma, haddr, page);

Hmmmm.  I was going to comment that restore_reserve_on_error would not handle
the situation where 'err == -EEXIST' below.  This is because it implies we
raced with someone else that added the page to the cache.  And, that other
allocation, not this one, consumed the reservation.  However, I am not sure
how that could be possible?  The hugetlb fault mutex (which we hold)
must be held to add a page to the page cache.

Searching git history I see that code was added (or at least existed) before
the hugetlb fault mutex was introduced.  So, I believe that check for -EEXIST
and retry can go.

With that said, restore_reserve_on_error can be called here.  But, let's
look into removing that err == -EEXIST check to avoid confusion.
-- 
Mike Kravetz

>  				put_page(page);
>  				if (err == -EEXIST)
>  					goto retry;
> -- 
> 2.23.0
> 
