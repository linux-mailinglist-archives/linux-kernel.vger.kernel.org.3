Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085357C5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiGUIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGUIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58635E815
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:15:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L7ZFbi001728;
        Thu, 21 Jul 2022 08:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=woAaI1TKr5zt6319ToYHKwG4HxbRbJOe2P+BBAqmv9s=;
 b=CY9l6VCVZkajRf/2eU7zhYcvbUoTiLKBGx/q/Sk2Z0U4AriLQwY7GHFnXPKhub1XqZmV
 /n8mDkojwljAp9hqgZX25u0nIqs6qiqK58ZWMhpZobN0r9CaF9AA9uzy2YiiWl4LQI/K
 TQLikcA8uVBCWxNh+fyXqN6Q7gk9l4vw9HjMw9Hmhc57GE3hvzyN6fucFC9H84pxOwII
 Wf5QuuQM3oj+SlCP6gVDwrZbqdwM75VbGEz59MUDu3evsntrSV91buOfdXxwqJYQ3AQ4
 ep36ntWttoFGrFk43NwWnsX1TtAFgygkuB5GlEDL/l1osP+vPLj8q+mi39nL/wIiN9hc lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrcbg8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 08:15:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26L6l5bK016442;
        Thu, 21 Jul 2022 08:15:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ep4uhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 08:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzt5mWKmpZlpNDMfxieMVEwdqs4jgrrggiWnkbebm6mMMv3SheswiYIv7rm58NEmKkN9hjgD/y5xm6viotCjtUCcrVZAzVA/dXn7gzTxxLzsips/LC9ePCS6SgUQfoGX1yky80gUILHFa1kDpGcI5djInVwfuXQLLRkFYf5dr3tziwpuH5pC2UVPzoB/vvGBVk6ELQuVitNz6MSUwnlD10Wt8ItXjSvpt9Eg5mfNHtyKWV2BjTsolSuN1UaVWa9vaUyhOD06FC/MwVy4gctYDB9+lC5uXd/lM8FND+On7ELgVxCI8IMMcRzMUh8A1qrtIHqZ8dpIVMKBRxa2N0fz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woAaI1TKr5zt6319ToYHKwG4HxbRbJOe2P+BBAqmv9s=;
 b=C1q9E7oK34siczGRBE4ZqOASdprZCjgGqg26BOjqDCTO5qXGlnLjfRCMn9M9I3d35XKYC3bUcT3rwPJzrLZdp5M5m89PdW13fOpPFPVdYlQqiO/aH/G46g3g+BzDZ4EzypBsJx0DxRkcoF5HUIAw9qAJ7VD3eT9RZub8tDottDGtqmouhS7XzamCT7y5K1XqTmBQWHMMVGwrKN1dXs+y+NiYouIiy5JCBIboAeDmAuqMOyg/VqhI7d7DcWBJ15hL9siJ0tluXuKAsVLBKZidTYwc4fqG1lIGlgW7XQEpnglAEOz4oviW0fRo6vPXkxGk6VMHzG4bwMLOT7RUUeHZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woAaI1TKr5zt6319ToYHKwG4HxbRbJOe2P+BBAqmv9s=;
 b=Q0pptKleo8HQwVTs3ycb/NRilOtyhujG1ODR2+c3xev5ASy5n4zos9CoS+U4jmJpDY/E46BM3pdoHzLTudlPhcm5zN/NnpK3DurfWaP7LWcuU1OP/o7EHhTg4ay7PxXI0YZKhDT6TdU5XcYmgpxcrXilqqdYV59tnZ7l6kpUDL8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5946.namprd10.prod.outlook.com
 (2603:10b6:208:3d6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 08:15:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 08:15:40 +0000
Date:   Thu, 21 Jul 2022 11:15:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Inserted empty line after declarations
Message-ID: <20220721081516.GK2338@kadam>
References: <a2747f00-99b8-10a2-edf5-7dd6fd7a1f8b@gmail.com>
 <20220721035146.11719-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721035146.11719-1-abhijeet.srivastava2308@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2b9529-f8e0-4663-f24e-08da6af1312f
X-MS-TrafficTypeDiagnostic: IA1PR10MB5946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et5fTBmEr5O3lm3QZbkXbkh/4radzmWTQXpfizNBXkz3cYHhZkTMk3hNZcO6Uaqdkl4URHhKKEhndBJnheJsOZlkk5Jce7sjLKlZxDt+6BbPiX8SBW36Y3LREf2PF11Gvp6sCMjLJw3khsLnDj4b8sHz8g0o6HTRUUlG4gBCSbNJ16FXZ+ZGOJZl2XG6LhWYWj5cVq0/ZdOcl6J0S4QJAHP6JuMNOdu7ozyONdcPa9ZXuGmvSGkcAuwE16Ct4Sva45Md8JEQGhpPxjp5zDW8ZwGLTmU+j98zaiTMYK9rCuKEqdme65ZEppIWfIJ5xRGXSbo5eHsNsAsvGgpzhBgjRUtEI995A6ZWbvT4j+lof81Vy9lpU5i5REd9pTtvR1bkbSuhOWCMZT8dz9fpyqEjElXLfGnolveV0whFtHkecpreCcp1hkQiK/R/vrxwXFYVCyb90goPwivdoZfIgNUy1/Q6AlJZdXmDx3MUGy1oak465MJIw4AdSMhZ77OpF0EJ4DQOpNOy/Ynk/dq57rkg05kbznpBNmBkT5QalhaydrYUyEQeEmAFiFdE9ONZk83dMdE+6RNweLJ49U2V1aly/o4rtRrpL7vAJoWA9KvJlFZLyGmRpEqmS0HNybVK0nMpJ8EV2O+UH39n2ennX1VUoZVSqILZU410rRUPTmy7Z2dUENrBoitfbECFoRjgcxPtCrkfLUQid7MBMA34wKGEzn4iMkAvnN6FRTPwEqPCr34pBZhU3bAz9eajltStlyW53wrQE3YzVOCnOh9ij0g/xChGKo7EjNt9eiLJl8pZRDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(5660300002)(316002)(54906003)(44832011)(38100700002)(86362001)(4744005)(7416002)(38350700002)(83380400001)(6916009)(33716001)(478600001)(8936002)(66476007)(4326008)(33656002)(26005)(66946007)(1076003)(2906002)(186003)(41300700001)(52116002)(6486002)(6512007)(9686003)(6666004)(66556008)(8676002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoT8M1YxTRYcObeVOZ2MRc1eP32IjZe7SJQc7OaMfMf6An4Fo1ljbKtGyjpv?=
 =?us-ascii?Q?3D2yA6QXTTztdxLUlzWOatgj3ooDncvjqtSIfA7i7mqxaxZwqtx9ThBasGxZ?=
 =?us-ascii?Q?4m7bgTQuaiW5LtN7YgiGCtCV4eObMccbFNDTbgyZrQI30FqaRn52YbuN0fmD?=
 =?us-ascii?Q?RTkLysQmIgY0WkGmBbO3H6KuBUNpt8fTKgqDDe6dxVaTx9ff+s1AIxvRZGag?=
 =?us-ascii?Q?e5YqnkF1gnjbuFfnTKMqC+JeFyAQ9h1XjNvTK1sK7XtZtR2hWDBPTDmVGK2U?=
 =?us-ascii?Q?0Tx6Sa72yc0zjTYvj9bS4Nz8pqRTgjMoyP5VheZ1VInrS+vRwXLOqbi3jIQn?=
 =?us-ascii?Q?NrfkCO5YdiNRMsvE5MwtRGPf1fI7T5V067FUkcySky7+auDTKNE5A0jalkVz?=
 =?us-ascii?Q?ayyDfBTxO9LJBnGWbL/QfnXJ/dvm1CzqM3v9PuJX3Llgk/RyXrjrM7vLO7X8?=
 =?us-ascii?Q?txCliDnAxy+jawvpMgs0bwe9lzlxnWadSxyPtoUVQx8RwA6k6KgnJXhC74KM?=
 =?us-ascii?Q?uPYseDPqf/aSAIUuGgPzZp9htvhQ+peHvuSK0wFtM7CwRuwiOpuJHqWGMXP7?=
 =?us-ascii?Q?eHhMALX45nhbjkGK1rxX82mBIqUjSSw8hMP60PIgVcMdwaQwCRxlUIv56iPY?=
 =?us-ascii?Q?mvz06KoCFdu4AILUU4b03F7aWNdppi0FZPjOmWMFAQsUGod+g0xHU28o+jUa?=
 =?us-ascii?Q?0VNNwtG89aq8qI3LpxZSa05/rqxUQ6wnRletC8W6RVg6crLzaU2Uspk+yROe?=
 =?us-ascii?Q?vha3ubhxLffsAGV5xxtePQwxJXQ1CCz5AL3Im4V2ilp2NUDl4uYGRIm+BHje?=
 =?us-ascii?Q?FE27Fkg01bWdf52UkhfdE6cx6G1Wz75PQM5oGU2kWjyBdVQuOhjKq3tPPNwP?=
 =?us-ascii?Q?rXattYndi0J6fcWnwGq2O1eb9RY21IDeNN8UsUVz6fWyzdLzLZazJlpm1Ww8?=
 =?us-ascii?Q?AbXbC/PoGqWXb7NS9rHXcswI/AEBI2XIaWdkIDYNoBhTd2/+qx7mtVhPWVKe?=
 =?us-ascii?Q?QB9lwIx6go/tVUP3qFNOqsU4IMwkxtHvqmh+jDtq5A00XInbcjeChKYUDpiB?=
 =?us-ascii?Q?v5dR4aLG3wXdyotp+bJi75CXoFy9neMefg3szi6AyNO7JQo12kK/ghKQ1yCQ?=
 =?us-ascii?Q?36rd6b12HlS+u0TFSNanLKoFaf9k8B+rMWoWimG71C8pqG44BNDlATTavYx3?=
 =?us-ascii?Q?xNHspnfff5ZV25lABoVd6qg9M+V+5ciiLQBKp0PpGlMGKi9kE4eXIAcC4IOi?=
 =?us-ascii?Q?SzMdLD7ypfi+BWZwP88oRwgXKx4vICuO6Sf68jufMvRFhVPLDHTgjSedh6TN?=
 =?us-ascii?Q?fmFtGgtZ0NJS+jrOd7dUwZqvUUA1ck67pvKUsCfFNcObeOma1R72OCpvgYYq?=
 =?us-ascii?Q?VKFC4v5xBer+IOcJy9CYnl4hcOoHL8NNVuQnViNVYreTa4bT+1ENwTZI30DV?=
 =?us-ascii?Q?2A8V82oj5w/sEIvpALZPQkQB/kATQHn+BmNXUT3ZJ2Fehg7SoXIL1Y3kd/re?=
 =?us-ascii?Q?5M+UnhIegCdVBnV42eSiAiBwLGmehOJDxTdm1GoBZZXQW4YzqVzgImNWZxHp?=
 =?us-ascii?Q?2NJ8QLi6EYPP7o8WY0g9TaTdZkJDvoET4vwKKI2kw+2gikQt1fkgLhd5CBUf?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b9529-f8e0-4663-f24e-08da6af1312f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 08:15:40.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHCEl6NgZvOYFJNydlEVA5vR+UeokSl04gON6LBIj73/zaLryfHuXo2nw86ArrgJd0Jpr0JRrs1OOJ22ZZKJXBZ4MEpo9LcPeWnfGv5o33c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210032
X-Proofpoint-GUID: CR9tXV2BEztJHq2aFth9e7TtWK2Nca59
X-Proofpoint-ORIG-GUID: CR9tXV2BEztJHq2aFth9e7TtWK2Nca59
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put [PATCH v2] (now v3 I guess) in the subject.

On Thu, Jul 21, 2022 at 09:20:39AM +0530, Abhijeet Srivastava wrote:
> Warning found by checkpatch.pl script. Resending this patch after
> correcting my Username

Don't put this stuff in the permanent git log.  Put it after the ---


> 
> Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> ---
  ^^^
cut off here.
v2: fix my name
v3: fix commit message

regards,
dan carpenter

