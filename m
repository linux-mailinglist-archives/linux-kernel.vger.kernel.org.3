Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB92557382
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFWHFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFWHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:05:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26145521
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:05:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N737AE004652;
        Thu, 23 Jun 2022 07:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ho9FxlPra/r+MpwyLglk445Fk402rDbfI71+Ms+WXj0=;
 b=KgSeFnkEvBCKU4NEwqVL3R91DpBR5RBISs8joK8+Kiq/nkSWFyAbicjpo5wGffEokxBc
 ptpDZ6EfYdzGnyzA5UBV7NW3m++WL6nyBr63wU8H+LWpkg9E7+HcjKla17gn5xK4n4Yu
 ZAFW57MrdiAQV9AezFbiVb6uwi7Zpxb++wwIJhUMIzBOIztYPXB/MwMH2DqshAr5Pm29
 CgWb5LzMhPw7Q75FUkO4tShGqazLC9PoGzer9NzaN1juRUnGs+qydeYpXSS/tZoLRth2
 GD93TFjDVH4SNpCH2QVKtiXygR8ciDiyTOQtZXfXbSJKFLNpY2g/einyeTmST+84OK0/ NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54ct8dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 07:05:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25N710Kk029633;
        Thu, 23 Jun 2022 07:05:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5ecb2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 07:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEgGowdGkrPu0tYI6qKpJ51HI/8mEgZ3ixBDkcOWGcXl/7SpS7G1B4S+mLDd2iDwLT3pwfSrmq1Tff5E7cqQ6ic3K1uzOE+ZRPCShGOu299BaXRAY4MZTsuX1lvCu7TBP5RanLDeUKEzh5hvdCxdt+ghCbnfWXzrKE7TR/Im/kRRDFmU1L893ss++PyauHPvAyHfKtmglTnK1sqqNvbNVp2TjghMQQUKwSvfjzUGGMCzyF44YdSddh9vSuEVPxMF5HDKwxtvwxh4YaCIWoabFOmFIL4ezxyt4o7/AU+9Lprm73X98nNheMySYcbMpA107N2jTPQt1aKM6PrqELcvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho9FxlPra/r+MpwyLglk445Fk402rDbfI71+Ms+WXj0=;
 b=nvQBk72Pbzp692WaWhCw3Mr4M3jXz+WsqLdfURq8YZ48vsRCGjqDGSjnmiZJNaOkjWm3pfuM5//xR5870xXSA9HIFk0vnaGtd8xBbde4cDd8Ug7jyM88T4YGmdeRkY8SKwWwhqCdy+ANwkm0pCVgsvfx6tbvvjWYG/bu3/Ulgz/v9gwjNeOprP6xpT0oQLe8wmK2I4nU866ew0JQ1bmHr1lV/Shy1etMybFZsx2g2LJ3pBy7vbHWEyi+aBb+m1ZDrGEpf8hzz0cahtv+b9PnbsqxAKV4ENGD6X4pL/OlGGsPhmxLprje2f2e6/bO4cbXtbIhXke2DYNFRhGgbXKWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho9FxlPra/r+MpwyLglk445Fk402rDbfI71+Ms+WXj0=;
 b=RFS316TPvLUFIdsP7PuwC+6nzoYZGIJRfcpE0idk9ww151uud10rRVB9dVFqkv2bEjtGK4YSWTbh4lWdTMdBpX4cw8Yuoi1mhp/jzGrrqqxbSSFr0AQh0+FUAScH8e5z0jmQQOIwyxKUsRPbFFB267mlNyukG0L9kcAcq9yYrXo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1566.namprd10.prod.outlook.com
 (2603:10b6:300:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 07:05:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 07:05:37 +0000
Date:   Thu, 23 Jun 2022 10:05:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Message-ID: <20220623070519.GP16517@kadam>
References: <cover.1655909205.git.f3sch.git@outlook.com>
 <AM9P190MB12995D1FF1EECE4C633A865FA5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB12995D1FF1EECE4C633A865FA5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ae0932-38c2-4046-71f1-08da54e6c633
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB156674446FA9CAD0EF7AA9628EB59@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kvz8uDmRFGdKaQ1WS0o8P9qYL2cXTeodH3Ti8YqG42psHlAPKJ45UB3M94gFJ7dOau4FYfAn3jJCSsahR/ry1tsyYt7qKrst4KO5DjB+Q3yrxOQzWLSGxTeJAguxHYvU4i2s6WNjnV6LP7UZrixWU0OWroXpmzDJiGGy8UvWc91yr44FwB/QDOBHC0MseOH92H5JIF0d9H2EPhMR7CL1ZfIEqbLn42B0jja5pQ/S11jGk9twfEEoxpYLNYSn/NUInHQ/R87gh4vxusbWixpojlNfEFDlBHyB5Yp8ubQtSi083+57Pa2Odk+eS7muYFhQphk5nqsCWkdUT9JpoNE0GygFEtaZ9jqNY/QTdP4+Gs4y70CZcNkurWvg1d7tFui55RC/p9vKU6D2eKDandk4VysjARn6r1UZpPb/eScqXYzoJnjcPvRyaJIyGRVHjh0worb2Ea9lZf+7A53jVzXRnz7QrHa+LjJNo2cpTDXKxpugGwxkjmnDc1cQmRiJxTDd6Q3Ysqou7ZGlteJqVIZPtK5wH0EezxrbElUt+d2XC6aRdEdkEQTFKZc/l9Q5ciHBGz97TkeGW1+yxSQfHFXRp2NwFlidNAFVYb1/SGFjpNISMK5IkUbOuviAHBRtZiLLBLu3H8T6HFlUIaHOSYPnHinMxOH1DL4ZwNMIbsbcv3Kl8ZSr7pYIeWE1MEDzPKRfZVjwVTDhNH+R4Op9PtC/1kSt1kw1quRIUT4tx9dMbjVq2K8SuMhFnaSMi+lMXgjaq0SflM2cPKcn2fNWukhs2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(38350700002)(26005)(6512007)(6486002)(38100700002)(9686003)(83380400001)(186003)(86362001)(41300700001)(478600001)(33656002)(6666004)(316002)(66946007)(66556008)(4326008)(66476007)(52116002)(33716001)(6916009)(4744005)(2906002)(5660300002)(8936002)(44832011)(6506007)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bLWy+3uFgEazvf20B4dm++NsFVpm0zUaVS4lCe2VMulNeAMZT8umWHRrmyeHl2pMjVohpltGNyIYGeDbE2XI5D7itM6y9Hpq/3L/06hNUTDYpI7686i0jSsrXct8e5RJ3athiJjSUrok/3JzHFmSzOhvRLgahufBIJVnTml/e/hDdSbS1yp1zrr2/wNiODqswhkiKgExc1/UvUSIZs56adpBVItcJl4I4dB/UfzouepX3bVAX20s5eLQnC4RGDeQ5eDSU7OFkdNfV7j6oXv2v65iRdg9pZ/FcY76u+JDBVFgWoWbs1mGvxfLRxNIPR+0rx6hx8zOTtH1rMmR558VOahq5/2oAh2NgN0MGgpqYDJNpzFp5WvJRmxNO9hAWb9qYqt9O2l8yK+BiltKPzVlFAITqH590O3KuC/bZmKlvZMGCLknhmW8ZwSTIFeIk8Inkh53OF1I0KG6C6Gq9Wq7XOOnI1pom3m0YbHC3fb+Ln4tMi8lNbBbhnoJOilDSQuZM60uEBGi2/oR4dQjZWwNWg8VfLkHY41LEqaj15mdNp/FTG+sA88HF5sp1tUul98CKNZL08k/WYmXme3UsCFHy94ooAiSwnqZcL/2N+k8qt7WbsJeNS39ucqX3rhezzguKKd0O5Wbml9fkoOAtO//oUKB2DWTt4ck3YgfUyQjz5MQNxSZWS8F6X2CMsqdfTFtjGXVFgBaBeg9dbh7dgM9MblJ1ohCi1/7Zfiwmmk82DxdFJ5qlUpBXXN39rnkSJ1Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ae0932-38c2-4046-71f1-08da54e6c633
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:05:37.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS5WteM6spefFRHj5K457hZCnSOLFZ7X3l121l94HTptWBG7A9kJVrUpAqxSa8cGuSvcZ6dEWuMGfMj7AQgWxLnwXaZa6U6lr52LDn/sZeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_03:2022-06-22,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230026
X-Proofpoint-GUID: Mz8TQ88T8NKWw29uOwF9YIB_V95aFHou
X-Proofpoint-ORIG-GUID: Mz8TQ88T8NKWw29uOwF9YIB_V95aFHou
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:12:45PM +0200, Felix Schlepper wrote:
> By using kzalloc, we can delete a memset and avoid
> memory initialization defects.
>

This commit message is slightly confusing.  The "avoid memory
initialization defects" bit is very vague.

The difference between the original code and patched code is that the
patched code zeroes out the txb->fragments[] array.  The original code
worked.  The new code is slightly cleaner, but also slower.  Whatever,
either way is fine.

But just state it clearly in the commit message.

  "By using kzalloc, we can delete a memset.  The practical difference
   is that using kzalloc() will zero out the txb->fragments[] array.
   The original code worked fine, but zeroing everything seems nicer."

regards,
dan carpenter

