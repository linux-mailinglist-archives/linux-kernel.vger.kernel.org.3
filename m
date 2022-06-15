Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC454C383
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiFOIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbiFOIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:30:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CC23FD8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:30:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F6xkvo002105;
        Wed, 15 Jun 2022 08:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qfDbGRdd+x+ewPCfs+SSiUocmz8YCIcE63ay8UkEivc=;
 b=QdHysixWx/H4rQ7BDj5GSz2ZHQ8KUz1mLgnzES4k/sy1yjLkm0HYu3DxdnKE/yBiWzxO
 haaTi+AzHqocMshGMVTjIB7iv8CWDt1gUNWYrbIh8CZR4y0v/qkFLkuAhh3viVTSxdlB
 h48D7kgmdCbVv9hbjxE5jyiiFQG/zuhTmkei9o1v11vcb9T8bQrIkvVe5POYjN8fgGgv
 Ve4sf7fd193tButDsHLTqRt9sDGZO1hTJUQ4t0fyP8wNRXHawwxPeQujZZhx5RLG9ptn
 md1Uvh2N2SGRX4rlmWwzU/7AZsUkfLmzJ+cIXP05ynfxxOo3yM/CDlmM+s6hVEeePJuS Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcqwpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:30:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F8ACBh009581;
        Wed, 15 Jun 2022 08:30:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2a0k8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCF6lSllLDZeIkyXYPkP3lKQgd1wo2s1R8cu1XoUhmFhNpxB45NJKRWpbppCJv4QiV+kCAg6k8L+xAm6v7yJAwkQPAJrbflahJJgVLPCRhlcDkO23jWal/IpzZq4Ewx1adC1ezKgoQcVsp8ZHKUB0J2UDyAxpiT2T7NTIBmVuMPUqakAb80yktVoqmH4QTF/do47x4T+jiYszZ/T9wNilYSnkSSqWIL8wgmlbU3JK9QeuImCGKpKYcD6i8oRB76QyuzkwZqU5UQvu/F7NKxOuHO9SR29JMVKffvRs8Zfo6RYFffZ1dQzRuQ2v7IJfcJ2e0XWi3tftMVYrbOZpFFHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfDbGRdd+x+ewPCfs+SSiUocmz8YCIcE63ay8UkEivc=;
 b=SmptQe/vxLNK10eKcEuRZjFq3ElgSHCwqoMr+Vd2v2lgwOrLlJyf2tNlNEDEKwGz6Osb69GkGM4+kzwWjhoLtiM7E9pkbyvq/jdwFmqmOSzf5YfzpdoPMKMGRsgjlS49HAzOyvz0YPJACTakorWDkslAjS5w21cSmCJANyQg2KrDE4y/d9bzVsFqiJzuQflQyhf7gBdiZwxZhV5tZLiZ7767nq548GM1fy6teN0IqMEstldMEkmxsv7BpruhpWkE6giB79DBeHLFOl6v1ZqP9MOvR3f2LDxcO7vMK7k+ZA/D2gWenI2wH+X6b3IEVtdk2UCOGKWrAM3PiOyhNd0y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfDbGRdd+x+ewPCfs+SSiUocmz8YCIcE63ay8UkEivc=;
 b=MLWIA9S+jEn5KOhfCtXIeRZZAQN0MDt1ZIENB+gMaOYvvUHlcs2fI4o2MjS/hgbpeJjAYqjGne5DCtRjVSSD+3BT18oUutNBBcinu9CoS+wMw0kvTTFJwNMLfsgdE8Ews8TfJ1xlM/9JLWeneC3lRmX90yu6locmF4TnFlrxY/4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5612.namprd10.prod.outlook.com
 (2603:10b6:510:fa::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 08:30:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 08:30:01 +0000
Date:   Wed, 15 Jun 2022 11:29:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com
Subject: Re: [PATCH v3 0/2] get rid of confusing macros
Message-ID: <20220615082941.GL2146@kadam>
References: <YqhWIiXadDC3hzel@kroah.com>
 <cover.1655220367.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655220367.git.namcaov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de2cdfd-2a6e-496e-51ce-08da4ea93d97
X-MS-TrafficTypeDiagnostic: PH0PR10MB5612:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB56124164858D0CF2E8F8A7B28EAD9@PH0PR10MB5612.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIxQjcKX5ihzgFitP4oa8hRnUcIus8skrK3hlSiduf8JCW3yZrz1KZRnNTCJ3GHFbHGA1GKmTbEw6n4Zr1TCy73aDnqEfcceLyKBp02vmaGTOTpar02wpQfVJjKUAOHBJFDiQYNFW65tJ4fv9qaZNJ8hpFbNKz+MIYqS71Ht7JiUxcLZdZxcjo0GP3YdTKNepKcu4Uph2mZjueL6vGWkbbr0KwECWKSXtVzXdbyU3BRgZ0hHVei+sVwjBXyF29NsSB9zVhgpCqJYUQKw5egJrNdWdkPj63JLSrQBwZCEdZZjK98nGi+2N4NlyeeE8nDa/krSM3SUWOuv/Nh5xeP8rU/NCdQN9xkUiVoeKb4Bk1czukF1jbdrS0Q3VQ8GA5sym389SKQaez6aJmTVNIjwzDD2CqiNHEGip3j8eUT2LI7d/RAuT77EhAdV6G6qQOKxLcgtvMbyEIw2baOTlGGWCKot4nFQKJ3zIlDwsXLxkZc4kPYGYzWNPa8NVhMg1/tS8hwoLjv+Z3eU40xCbUz9exYIZ/RotCZMHgWsKRznrnFNKzZvMForDSYJK3PPj5mAFmsixL4MzaHSGehFHGCpJEfB4Q/rtw5s+K2EBcVPOWvP4R1/FzjKPb12j/jLw2Eb9PYoXaT/j4qcSJCfS1FK9lR/9r3PjAwGsRB7Kj3Do4gSqqmtlmixLrTb/49wpd4lMGW7h1a+AEjZVQC7ma96VhVUziC/Y4nmsXOAkXdkH+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(86362001)(38100700002)(38350700002)(33656002)(9686003)(6512007)(1076003)(6506007)(26005)(52116002)(508600001)(2906002)(6666004)(33716001)(6486002)(66946007)(6916009)(4744005)(186003)(8936002)(4326008)(8676002)(44832011)(316002)(66556008)(5660300002)(66476007)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GuyaMEFmxPUE4L6dLfa5VCnx4a1pbO+miX39bOwXOq8f3wPX9NPhot3P34zG?=
 =?us-ascii?Q?jbJfPkGlAoKwWsnQlnwoJqSVWdhoOb1MshyBtbS5rvucpMC3HBdyRiHAp9Hn?=
 =?us-ascii?Q?ov5N3q9+ONxv77yN64CGjHKle3q2k/Zu/kZHUTmrscehMPLz8TjDJsW6vlJZ?=
 =?us-ascii?Q?FsnwmmvH1te4ht2+F8lzopw4koNNLHi6fvkzJN9WGg1irG+qk5jaaZ2snkDD?=
 =?us-ascii?Q?YmpyKbcFUPq6eRchzttoZSxChbu/vlhwr6QyLeTvNSvgCG/dYTeBJf2s+Mf4?=
 =?us-ascii?Q?AfiP7xblFyi7oPIQZFuo3k4q6ZGhBqk6DmsKAvNYb+Z/HVkW97wrOHbWGd93?=
 =?us-ascii?Q?ln3DQi+Au+SUN9ssq9LCK0SV0Ry1XtlH5SHjFJ5i2D9z/+4NeKoZCo5EP/PA?=
 =?us-ascii?Q?+OK1yrQtadKCw7KNkUdePVIYmKkELhIbKinguID0vHeSNG9njxNgz9RuTSCK?=
 =?us-ascii?Q?qnpgZnf/XqJP4vFx6ohQYSl86TpSOYI3fYxFjlXcoBykbxBAaqyVjNT8nyzd?=
 =?us-ascii?Q?MctVaD2Unn/i4THtHKCRHtw6v0PS5WkQz+dxRBzBjOAA6nVCi2beW9wRu7kK?=
 =?us-ascii?Q?Wqxzut8WoshaxHYCPD1CULSt5b3+3UdmLaFi7VKWvGqAdmiCHwQChObLqDEz?=
 =?us-ascii?Q?YE8iHKZUn5kL2qARdImVDnd6FtYjZqLKkb65u6LuBKDPS4mmhNcNymhjkHf1?=
 =?us-ascii?Q?mNKioPE4XYRCosaP7uG4q1exVF6kRR7h28Zk7ahe6Z1ufJQ/p8Ie5O2yhG2Q?=
 =?us-ascii?Q?Sk5rQ0Iag+ZDXZ2d0A3VUe9sxnUKao5Wzl7njqNh/+1UIErB7FvinCA9UffM?=
 =?us-ascii?Q?i/azi8AcjFrewvbscE/VyfruJJxBGWUVKrmPpnjrmigEbvABHucX2OIX7pG2?=
 =?us-ascii?Q?cPLgo5CZzAxgguVXKFTnPZOl15pqoGWFyyVBnJ/s3pa0vLHczF45aHkzbJ63?=
 =?us-ascii?Q?5e4I5942NT8vLU/Diw0kEX+f8sU7edfYZmj0SWX3kIPBYo8xmCoCWiFjqFGB?=
 =?us-ascii?Q?/ArKBAqQmUbARiBG3k0Ll/EAwNJa4i8s1gEIXSs+McOMmRl9wg35Ytngwvq2?=
 =?us-ascii?Q?c+krJqtiJy6rvQO8gE0Iuezn5SbonhNPibUpAbMzXr02JfRfe4uZRA9n8xh8?=
 =?us-ascii?Q?RkOyRMeLjhnULaQpNHuxE6xRrh9SrwV9n5ovjbRMTAIn67gw9ApjQAudHVv8?=
 =?us-ascii?Q?oUXSmOeEZsgd+JSTuE1A0kCEamf/PRWmQmERHqqd53/80FUFxsqOoF6H7HxA?=
 =?us-ascii?Q?Js/ltfDCKA1iyQ/DXwLgxCC0FF/Cx7yB+Dva2c8K10Nq2pmJRE8qEDV63zKY?=
 =?us-ascii?Q?ESDfDNClIOKtuHDfaWvI/tAYzGpkZK6YXz9n6mzh8w3tEHARQXHAzL/pk81I?=
 =?us-ascii?Q?1qrBDfuswoZzse1PXQSJR3I2dYc03eHlksHawxYJXtY6NGbnayzxMO098X+1?=
 =?us-ascii?Q?VviEFN7MZ1vSLf3OR2Jt/X+VoB/4IndbUGnj9GX2eYtxtEF/zPxOVa9lirJm?=
 =?us-ascii?Q?Flea0BsD2LFnBqfZzxhLXWsTSby/q4oSjaYR59qOZShel6lT8xyCAxIbgbRS?=
 =?us-ascii?Q?ZnsqBQyyJaHuTju4hzkaUsTbM5QMvZO51wOW5k2iNA+WJT89pgEh6Aaxxp/E?=
 =?us-ascii?Q?XGKDE09buRCh4/yXgpsp0c8XxSycM/Yyseq3JfEghiZTYtCWsVYPThsiXWSQ?=
 =?us-ascii?Q?uOq1uoGUPPpzbCeELp+mlxwxC+PzP3/sTjbqkpsJPb1FGhMJ3wTt8FrMsUOe?=
 =?us-ascii?Q?J8xNnISf9jCjnMdy0aLT/4aZ6Sx8pSI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de2cdfd-2a6e-496e-51ce-08da4ea93d97
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:30:01.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wuhuHLoR8UyJUINWyoMAgyUdQRJC3v5Qfj3SWWdeN7Y0WuWt75CHRTwY7sYIKif3K7GpNGdO9N84pU6pVoqhCDjhvk7+kIUh/vkIMkwrME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5612
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=965 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150030
X-Proofpoint-ORIG-GUID: 11xptC2oMjihfnfphX6J5rDtQO6L4ybM
X-Proofpoint-GUID: 11xptC2oMjihfnfphX6J5rDtQO6L4ybM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:58:43PM +0200, Nam Cao wrote:
> Replace some confusing macros with more explicit codes.
> 
> V3:
>   - Get rid of GET_TX_REPORT_TYPE1_RERTY_0 and similar
> V2:
>   - Split into smaller commits so that it's easier to review
> 
> Nam Cao (2):
>   staging: r8188eu: replace confusing macros
>   staging: r8188eu: remove unused macros

So much better!  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

