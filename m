Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2C4FF070
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiDMHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiDMHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:20:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA027CD2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:18:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D6XfHe032238;
        Wed, 13 Apr 2022 07:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NYjjOJwJmJadC5RsuhonWlIgqgcExBoxlJ4v/TPqAQM=;
 b=vn9D0mK9uIO+FMc5AZUHUnxTlWhJSU5ywwZNp5pT80vn7a3MxkIhdiQLEIiYCA/1j5F/
 8czTG1M+QvhQFKsByUmRq670iWAYzsIu0IVzF59DaabLNLiwKkh4fL7gBzK5/hrOyIua
 IeLKptC58AtgI6HyZgjPWVm9VerDW8uVN1rTgjAjbLyQZgtDBcSziEkbOb4TNbJjYcZi
 SuxRDhdZEW34k2ng1ZJl27yoBx3F1ZVoHzKdD03DehgsL5HWi71CPm6sxmfSZAziNw/G
 Xr7xMwviGemwkN/SQQ0zLSbHbDs8yaGSYs6hSazOQhmUoJ6sbDr00GFwF0Xf9JOnfBfU 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd8tc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 07:18:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D7GPWu022613;
        Wed, 13 Apr 2022 07:17:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck13mep3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 07:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTY8HoADajFGLugYJih+fWCxSUqTKv2utyMmz/ozN3iQxES76FYGdr4amKtTsLiav1A3BIxuEGsGRnXxmGbmYdIIHhK/WYutbrhpFHsGxi+7hQ1TfNWTgjSvpika16qJ2JYGaejlowAuKQRm3wbpVfn7JNOrhzMxqHEH4XRmA43p5ZoACcZGTa1EO2YzMV+yFN+sreGrmgGseaLcOVPVtoFL3cBfujd31NJVOYgT5cA5U4R8R0P304pE0piDulAHV/qWL6Wb4xObEPakk1Q2cHEN3eY/COj5bSRFePSoBpb8eZb6g+1lI/gfdHhPjzfg50T4DXQbFavv2JLskXudkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYjjOJwJmJadC5RsuhonWlIgqgcExBoxlJ4v/TPqAQM=;
 b=OjTF6D1OfO1n3vjn5sRB1eJ2du2J2+N23xo+NaV2d+schqiKQd4QJx+nqrVze17qzezchTSWUejk29wkSX5j/uwBxa0UdEFjJDWRYygGLPjwMwnY0ijsNpQFnd+lsGAd+NVAxNnRk/WtQDfmtOhji9vT7Dq5lmILYY7hgOdEW68KOfDyjJLgEODMCk509JKDe8LUg3pBQ5NsXFHY/DvEjwotLHvDD8Wkf+1owdbwkmzenISXxnH9cbPbdCKmnobVV2IgLUHkqQkiWbfXdTgsyHcQkYEqzI6q1R/zBXcIB0CrIcPd8S0V7n1Tg78IblbsMWRo7n1AtZYzuEDYBuFXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYjjOJwJmJadC5RsuhonWlIgqgcExBoxlJ4v/TPqAQM=;
 b=gblPmj/bnVrCD+sGfHkO64n0+va3T6JXI+iTspQSPfjF51PNAgrEKi+UOy049M+NOJ3T/Wi/fvd1TV1D3twaOnkIdYm+UptUdrY2WyWYjBeMSki8lQ856GPVknghjsInzBDYbWjc45n4VN34wk5PpB6eA4VksRK5YHq/55vsJvM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3800.namprd10.prod.outlook.com
 (2603:10b6:610:9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:17:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Wed, 13 Apr 2022
 07:17:57 +0000
Date:   Wed, 13 Apr 2022 10:17:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: replace zero-element array with
 flexible-array
Message-ID: <20220413071732.GG3293@kadam>
References: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
 <YlUGbFs8oNikJCcv@kroah.com>
 <YlUGp+/BzMSm3oDC@kroah.com>
 <20220413045031.GC3357359@jaehee-ThinkPad-X1-Extreme>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413045031.GC3357359@jaehee-ThinkPad-X1-Extreme>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9751898-5ba2-4e5c-3d8b-08da1d1dbc20
X-MS-TrafficTypeDiagnostic: CH2PR10MB3800:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB380027B8341BDD5A57FB41BF8EEC9@CH2PR10MB3800.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smPTNzFt1EI8lOHcUQibfbsmwDLcF+f39ULtQy26i+kAASe/j9kbkvthfkiyEtwzn568S/dLeWzERr1kR5scag7lZ+Oev7da5zIPtqgxx62TH3VItY/hvmK8V1tJy/gXxIgizBVVJJ4YPD28+URqj/m78fvVGhBxHGzfyGK4P338EEdMGoegXLOoIuXroY1tFQZ72GSZuBRjy1UF1SW3t1fVPi64LuFsJptr39/D3xgabTIWRwyUf6AYQSQ1X5glKOMOPb6Bd/9HvUJZSaONZPt5oCFmcFHYCcyoHjxS9dTa96839nZUqLuD08wE0ACZGjMmWK62UzYh0lggi6PDcmT2Nx2GblLq+D7dtcTy8JAV/+IGHnekit0tVuIwpt7f0adn1Ak3EfWaWQ5HYc6e7iwFuGAayCatf5Zhy6fYS6Uf1ThF4d4qVJoTM2tozchbhDduJyXUc2vq87yJS5aGu7VKm3MWXNukhGPiSpt2h+E/qmShIxHVmHp0gOuRUb6S44v7ixhkcm75Qa9ywP351uqWD6UOP2clnSzigNNrdBSdnVvJ/qzGOb5EV1F8652Li4L31Qc6d1Pt92ezXd/Mp5jfRgHwQ2QJAe0T9wIwboPtC8Q5T6tHogg0oPPafnS13IJUAH1bmKVmbSuBr6tWv5T1G+ia6BeuqkCa4kEC9nHOkAifC9r4qtO4thNmcNn2AMEA99bv1tNN4CjJYaC2yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(1076003)(38100700002)(5660300002)(6666004)(86362001)(44832011)(4744005)(6512007)(186003)(26005)(9686003)(2906002)(6506007)(66946007)(4326008)(316002)(38350700002)(6486002)(54906003)(66476007)(33716001)(66556008)(6916009)(8936002)(33656002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12cNE91zCn2fZm5G3oVGEC+SH9k57xV078ouTWXCPlvMl1d9YI8ug1wjpObr?=
 =?us-ascii?Q?isW6cw9k1D76IJl+9le9LLYUhO443+1gvhAIYc9tJjxe3zJBjUcn5CF9+z0A?=
 =?us-ascii?Q?sK44rb9m7tw9Fvu9Ma3DBNKy9nsWYZwcqit26lexSawCL+V4HMxIW15o/Jrf?=
 =?us-ascii?Q?N0yB24/ZpZh9GLvb17ztPAkAx2z5PxKczR+Y3t4jL3TyoTZXn82W8avqPF4w?=
 =?us-ascii?Q?How8JDpiA2YJRNh1m8FtvVDS0jDy2FvFPC3IqYdmjin8me91vyd2qH03anfk?=
 =?us-ascii?Q?r3h1kIAqqNs7IsSrtjiVV73UYcRahgxUBbBbz112XAB/S3QTUOnKN0fI5cEX?=
 =?us-ascii?Q?GktilO7NpyazVaT1YdmOCw5v59QUeMwDWBAZ8v1IAq66YjedYJbmw/qGzSew?=
 =?us-ascii?Q?KWHP74k+hU4a8SemO9m/47hlA+X8gMQOc0O372dHXQf/l5db7T/NJ4Ym0XPM?=
 =?us-ascii?Q?dTECRaqxCJxM3h/EeTX6h4Zr7hzIZqAt1FHZ9yo4PEV7FWdHk66QCJSLHLyU?=
 =?us-ascii?Q?VWmK4ojiix9snoTE28XJ3CvfaVqkivev/sW6v58XUYKL/1ldfPiCKgg5rO3T?=
 =?us-ascii?Q?n+9NaF37KoCsjSIftyDrZy5qkPU/c8WisODhAa2M0h+WdCfAkNaVEA4UW7ce?=
 =?us-ascii?Q?OCVYI38HNfocFjl/WoJuTMoEJpWbVNsxtc5dnsBNJ/IM5yPZYShUl5REyPhR?=
 =?us-ascii?Q?bo0ANRVeJyH3NbJZCYHMUaccvHSFF+Qnxa5JjnNkiR7A7eaIT/Yd+8eps4Bd?=
 =?us-ascii?Q?jpgwPHjtWkxW1XkmgSi5Y1+DPyTOG8TdEHbke6RswW7fLC8EOB1q19vYk9HY?=
 =?us-ascii?Q?yAaTzwRRWXVHfXvrinoPQAF+wH8VONzYIixNshIH+t2vj9dfyS4Se0acrLF9?=
 =?us-ascii?Q?48c0XmBgbvCdOTDl0xHF9umc5prIpZNqouhshfRgJ5ROe1nHVIcC3Xp+Nw87?=
 =?us-ascii?Q?obnDHw4gKjcBbXUdo2LZNaPIBWtZGdp49s2st96LW1PW/YYwLoHdrNY5xvAy?=
 =?us-ascii?Q?OBJo+w0GIQaYDr7ZeKH0ma/9w7SZRCcE6qgSZKKNZKCb0cDwZdq8O+q51w8I?=
 =?us-ascii?Q?pHrON9rzZQCLcQRro0Fhsd7SIUGeqJl5/Tqpo0ctS2qgV9gOrP0Ofmz2n4dl?=
 =?us-ascii?Q?vO11r3rTjPVasrt0+fjqFcebDC4iLjbQOr1HQEdL8tKGlyVGXwqqT+MglbOI?=
 =?us-ascii?Q?YPzttQlR/rlLNrOUvTvmk3oq7Ngd9/AYKAgBPQF8HpLxMPV45N25awvHfJMo?=
 =?us-ascii?Q?cRd/z0a638L5S7FMqyqZExEsZCjtdmGPKkT2dDz+rNou8gpsB3IgkV4Es9qo?=
 =?us-ascii?Q?6z+W/y3pdctay7AfxeOhcFd3bP+4VnZcnvJtKr4THWY82hgzsGU0owQyaZB0?=
 =?us-ascii?Q?3R8MsNwL72OE4CQ8bQ9nw3NPYa+v0h4SeTPLd7Lt8uVaFwilMiprdzKgN1DS?=
 =?us-ascii?Q?iHpvg4VUkQ+j1imLtja/KTyo210EbqEoTGbHW+bba983vKNFclNv1cjA7OvE?=
 =?us-ascii?Q?nMtOhLYKHNqPZSjY0dVjGa3XTEA31/GrPvhQaIcF9UbgejH0za/g9XDj4buL?=
 =?us-ascii?Q?jt3L1XZdT+mZb4B4EoPnIrCbi7PQ0jf306/iR3YeSYkFHKFCyUzGj/UpWrbZ?=
 =?us-ascii?Q?7BN6x2wxbneXDpFUc+ZrY54uGdEo4XpSFGeaoKAygz3uqsRYygUhiqQ8vICE?=
 =?us-ascii?Q?OI6y1+dVeBjIHWkB9OkaZJcuiqeGjczkavEBN4xB0amlifQETdcDhmC74MAa?=
 =?us-ascii?Q?jLeElP1JnQApAPf7E+0h5oBaqAR501k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9751898-5ba2-4e5c-3d8b-08da1d1dbc20
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 07:17:57.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Px+Hh7kYp7h7wU9UrSlC/35Kq4sXAjXseNnM24X0vx6g9uXpNfqn2OC7a3/W9qG8erHXEeU8WPWbxxLqvjRoHjFmJtuhHZWjqPwaHsE4+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_08:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=678
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130041
X-Proofpoint-ORIG-GUID: X0sPRHpY6R542GQyo8sxuxC4IELr0IIj
X-Proofpoint-GUID: X0sPRHpY6R542GQyo8sxuxC4IELr0IIj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:50:31AM -0400, Jaehee Park wrote:
> I should've made this into a question for the maintainers instead of a
> patch. Sorry about that.

Not at all.  Always best to send patches instead of questions.  Patches
are easier to discuss as well.  Making mistakes is part of the process.

regards,
dan carpenter

