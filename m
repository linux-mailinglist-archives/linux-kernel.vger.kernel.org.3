Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868D8508EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381286AbiDTRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiDTRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:55:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AB3968A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:53:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KHl62U025975;
        Wed, 20 Apr 2022 17:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FuaUr/qf9l3oj6KK0z9UGxrMLRTpkFCONNgfrzKT8G8=;
 b=GRwrgD59t9TEakEWkRQwaVkiO9p6KrhHXWx7wti5U29jOSmTxkibkSOalTaUr3R2GDtC
 fOp6LtUW6EyVBkF4xZ9pnwD8m271jtSEjMe+7l3NNINIXkg9IgMoBO/ogUF3Avd8h/a5
 6nzKFKmApe+PQ7BWsH+3df+NGreLHwJ0zRmLBWMh2YpQkv2EU1PQzhiEQ9jNxTQxxCsi
 cNJZVpqAndwIO0a4owV8qDNgWRbAMd6CrJJy8ZFMM7TIRcbixqQ6sGGveBMHdAGFBV7f
 Kwp/VDWxcNKEaE1iThukESUtWzKCsME3Ey51QzTOY41E43q3F+9LBitb3y3AX+UHFHqv XQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7csp6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:53:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KHpmVi032198;
        Wed, 20 Apr 2022 17:53:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87fdhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZFukR57Jv+aUTxjGpmr8t/nszNOpSmaHO44tGqHYjr9NOl1NLNw2MdU1bixxoGG8yui/cOkYgMdEqzIyobHI9LeLdUqe4Hyk7fumE9SIcTzJyv99ry/T6FAXa5rmMefVxYthcq5wmmSnmuKP54jlHb81yUp1y/uLFNos15EyeLz1E2fduR1GAQpxDmXJSyC/zxcdKyP7xVgzPGtcKVWR/R2mjHC52mVRUYFu5/NgSXCKe2FUuM0mGUtWm2zu1H8h2kp820y1jq90K0ryfZAbXkmWGwYylH3sYDaaQ3sxzl6ENTfX5v0BfX1uuOtq4uPAOpYDpr3kq1GKNQ1G0H3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuaUr/qf9l3oj6KK0z9UGxrMLRTpkFCONNgfrzKT8G8=;
 b=Y6eybDbbwO4PZKe0blXC0V1elzwEQoRg2wCkiBb0/TITqh77mUgdkmMm5IDRTk6lTgINjg3uoXYQ8TjjfJ0uFz3yvts9zYa4te4ZxaCLkAcodWuB6N2I8OvQhE1BnwjMREFrbY41zs59Ld8c76NKC0wEdKG7h4ZMMdcQOpO8YcMgDUOwWaUUdmFId1ulDDxIoZJpESdku6aI6vLlxw0ZwuAsgT9GZh6nR1OFUt8skZNZkCglOvXEHLnnRj2J+9ZxFTI+TzHHcQkcrhz2bLJjck5+dKBSGHWIuxJmfGuge1Q2qx4ZGo6VxHzvEdIMcHHskycu9W0spvVzlUxGZDpdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuaUr/qf9l3oj6KK0z9UGxrMLRTpkFCONNgfrzKT8G8=;
 b=CcsXTh5wShgNgXREMMomjQ8jHWiGS3tKaToamleyX0R3y268IPYg7aDpZgE8cNTUMj2Nfh7QAMvUqRtG9aKfZJWa14GAPyTNRoTY5BzYIJLsFfpnI9FNdRoLcz7rodySi4xhvNkFCy9vdQ3roOj2X8SLOOAgvgqq2OkvST016aw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4280.namprd10.prod.outlook.com
 (2603:10b6:610:aa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 17:53:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:53:03 +0000
Date:   Wed, 20 Apr 2022 20:52:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8192u: change get_key functions to return 0
 instead of -1
Message-ID: <20220420175243.GI2951@kadam>
References: <Yl/7QPKXer7YtXOs@bertie>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl/7QPKXer7YtXOs@bertie>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a310baea-b815-4949-df8f-08da22f69d8d
X-MS-TrafficTypeDiagnostic: CH2PR10MB4280:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4280AC5D1EB8E4CCFEEC76218EF59@CH2PR10MB4280.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FKOJs4mIqL1sksE3EtdTzn/VwQD5ENivrVv0WjXr+ytAgs8n9kyWb8OLY3v6oXzL0bFc5LfoYQ3jfpc1xStvhy3rmh04dFY89KKbnlfE3+ZOv01oklWcqd5Bs+WsBoGGZ6Q3gW3rQT7jHKE5j9T7/CehMp9hxLb1n23ZbAqquOOmDaNUCZJv2QA9l4qbZkl2NNTrvC7sDpPbC9fm+L2gy6hsKMJO9r0cVGPAmRO3BLU4SLeeliSXWy2hNsFp/YxmjzRRcq2Qnko09m1qK6nBkIOfVjTEuGR++oH5JdOA6JEkmFIbIOp0YbYCtRUQKt42r3LNOAzVshsOsMjreQK+8cvs+PJu8nRXKXy92l4gfwvTjHgYELy3Jg+8+dEPnInnhIVT4I5o/1oCJzMmvXUIVvdmKnsR1tVGVAdSFFjL35FvzwoJQy7WwWU1mgQk+e0w93TNjjxgoeZUwdeL2qB+nStqmPOOXptfa53Q+RZQYVUGJYiglfy9CgFs93bbiZVTpdM3z+naiwCeFg0PwtLTlR11gjzuAcOXdAZqTHftmJgVm6mhbrUTXJwhlSea/C8kRdIjJrc/56KWKPMDLFPtg/7Fw+RIKy0gHRUCZYYgLdzvYAToocgdA+z28HneF4MQexmaSs4hRqktP08VriLwJDDQVrHUcW8epCHijpfR3aBdE/g4KHX791W7+LjZ5yhbJnUzCCvaC7v//el5+IBZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(508600001)(66946007)(186003)(86362001)(1076003)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(2906002)(52116002)(6666004)(83380400001)(38100700002)(44832011)(9686003)(26005)(38350700002)(5660300002)(33656002)(316002)(33716001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB1XM8z9iVQvPQKBUhysBG9f3ltIRB8y2HEtmwKEJfqjWpXwYMmJBbg9pXKL?=
 =?us-ascii?Q?gQaNFUg2tn14qW21Zyn6gDl7lIjG+y9Aq7yvy/CRDl4CT/7LtgC/a95vmw3d?=
 =?us-ascii?Q?BaorVMjPCtZMYj+swxQguRfC6NvrHI+p40FVa9WP8pay9KPWsWKYcqOPJ4iB?=
 =?us-ascii?Q?7n8+IVTwZHSSyFfFIf0wWVBMVyFpWC361Vp2d8GVohSoUCg5A7Gmxgh3/VRO?=
 =?us-ascii?Q?SwkXDpVftO8Tlf+WE59K9oABr5qX/Iz9a9DG3FawtRddSgXWOK9sQNBNPd/C?=
 =?us-ascii?Q?d/oxwMUGAj7VXpac8xYJl88siqWmAHxXBkLSOBKn9aTs8Z8bRU38QFYzNHdG?=
 =?us-ascii?Q?mZExfqbnYlT8U8SKdqWIe5JzxdQEnnD8/NJZu6Rgi306XW1kUmznL7KMuZyB?=
 =?us-ascii?Q?mAUsx2WkaLJxROYHx/rjhgYQOiU0eRQ4icNb8qu4jdlSenCZfMqyrnujkrv6?=
 =?us-ascii?Q?ECZ8qh6rO0DkAFGCM78YqJvugZ7CYwP6YxYBTsHe8Txkn/8QcPNIV2qJhYYP?=
 =?us-ascii?Q?hE+euYkUquJJbeTCS7UWUJtQ7G7/hw7vDbOfMiLWUDqIZql09tXJIzl1EH+U?=
 =?us-ascii?Q?asm4I5kSxerzhLzRlRDxq/ab0fZnCHOHbbf5JnCFJ/Lmd7vOlsafzCHGjnNy?=
 =?us-ascii?Q?xFX/WuIY+zqDWuHkJp95CXGF1812eUNKTzp5/Yoq0A9V3wrXhU2wFUhDMDjY?=
 =?us-ascii?Q?FQvFwoaY9liUeKHrpK1QX31pFq5yTpUu55JoX1VWMoQKRo5LgVkr9pIxi9xm?=
 =?us-ascii?Q?MuEPQ0zwPN717FnUYG+wqDrKOXKN+XyX6CK+Y150ySIA63obG5mRXn9o5krK?=
 =?us-ascii?Q?wnua7DfSrUIep/iJ3bS2JcEqxZsW7IHr8YYrhJ3JCuifeKwHgJBluqxpp/9Z?=
 =?us-ascii?Q?UcAUu9IrdILH7WszGfE0p0M+ScLa3YpSibU76wZtY4+MBxD7/nZH2VY4VWqC?=
 =?us-ascii?Q?s1KEuUCRb0Or2OthDAFuCOCf+/WCaS7bXcgVj/m0cY1BMP3FCN025DPDhc9z?=
 =?us-ascii?Q?RHDPtKv80PRt+L6CYiyMMyDqE4zN6ng+lRkFSfpr+nZu+YKksB4fCXS+ijnb?=
 =?us-ascii?Q?UTu11fmuzqcsXIsVnZ5G0A50U/YXuwqW1bZFqn0HeW9xo5ODMstj66jflZC0?=
 =?us-ascii?Q?xQjo5fk8zGndmeJiIJPyRa21I9I3RMgenQx45H7TAzKvA4RuV1uXtDNMj+1d?=
 =?us-ascii?Q?IJNnXE1vl3EDmtAEeczHtioGLgNRkJzKl/UAK3PKXqAKDU/FeAlM3Ho9vs1y?=
 =?us-ascii?Q?1/Skjs1jOtezrUilw6MKay6g7DxCC6xsX5X611gP+kSvfmpOdlskcJCP18Ct?=
 =?us-ascii?Q?4TakOCaH6uBym+sQ+ng/unJfG+fSEtYSisWhYg5ZVrJriRQNzU1KHpzy8QuS?=
 =?us-ascii?Q?MblOi+H4TA4k26tOwmCvAMnFoRUQRuiWo2WpD4Hcf+h4q8P1zCgzAfETUNL2?=
 =?us-ascii?Q?oGHfZDQ188muwZHJhOXxxCDuJ3hyQHB0dRv/taTgJ556tVloL7nRwnRyo4sT?=
 =?us-ascii?Q?/dgCrAe7z/KY/3pMUK3ikXV/WA/8Qq/kCl9f86cjNbW1vdT25EBxnynMnMDJ?=
 =?us-ascii?Q?x0yMTLOnXF2KMPskAVjcKZLmdQxY6zK4528K797XAc9PXtg0qT5f6cvfXkQo?=
 =?us-ascii?Q?5L53oXb0csoSVVFp7KZZJvpcRzUhCUXl+fjpGxWvBTONv07JfdqcyRomIhP0?=
 =?us-ascii?Q?YNAy4BHeBPM08LMDEaBp2sUPrWzeRlCyCGrzv2Ojz+TqwY4RdDZ77uVhxvf9?=
 =?us-ascii?Q?J+S+DOv0ulILOWcAtkMbN+k/Bm5NEGs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a310baea-b815-4949-df8f-08da22f69d8d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 17:53:02.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr3nBj8osVqKbPq2sQvhpwateLPkXeFAS/EmO5L2qOYr1WSfz86aZZYaX5oma6l9V+0sWfPthGX0djTGJkGm+uowcBq9YhWrlOdmfYbFOOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4280
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200106
X-Proofpoint-GUID: IkMq1XDi9-BmolhOwt0q_sYvn-wC10KQ
X-Proofpoint-ORIG-GUID: IkMq1XDi9-BmolhOwt0q_sYvn-wC10KQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:23:28AM -0500, Rebecca Mckeever wrote:
> Currently, these three get_key functions return -1 when the provided len
> value is less a specific key length value, which can result in buffer
> overflow depending on how the returned value is used. These functions are
> used in three places in ieee80211/ieee80211_wx.c:
> 
>   ieee80211_wx_get_encode() :
>     The behavior of this function will be unchanged.
> 
>   ieee80211_wx_get_encode_ext() :
>     The result of the get_key function is written to ext->key_len,
>     resulting in a buffer overflow if the result is negative.
> 
>   ieee80211_wx_set_encode() :
>     The behavior of this function will change. When len is less than the
>     key length value, it will set a default key of all 0.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Of course I suggested this one, but reviewing it again it still seems
like the right thing.  Good commit message.  It explains the
controversial bit nicely which is the behavior change in
ieee80211_wx_set_encode().  When you explain the all controversial bits
in advance then it builds trust.

regards,
dan carpenter

