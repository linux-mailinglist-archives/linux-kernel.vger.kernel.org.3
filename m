Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778FC5685DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGFKk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:40:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E64275FE;
        Wed,  6 Jul 2022 03:40:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2668RL0h017566;
        Wed, 6 Jul 2022 10:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zFHSKfKFXKen2WVwe519npnMUv2X2UNUm6uZofYlSm8=;
 b=ChpJHkRBGqL9TulxASEKbeXW/N46O+CJoLPcA/Jc+KkZDX50rYYfITBG2KXchHkgYBXm
 1kBuWRX9xmJxH28O49CtQL7ZGQyu2U+qXdYwl2Kn3RbXrv4ijjJEbGMLsdYdpNMckErA
 qy4FQvzrnJ8fdY6HYj7OurML0xsSEA5M48i2M2K02+PXnQ1QlMMq0Bs6gWm0PGZwLO0o
 54J36y9kYLdJrtzPNWDu4I9M/sxwAnYetTvlKz57bdmFlbcfe6bwntK1XhiecgZT3SW9
 o0TMDpWXmgi8ion3ey+8b+sBkYvrwtdWo5EmH+jblXHaJGs88jDgoNT1rtC3NWyXFcYl Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby9hpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 10:40:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266AVHkT018101;
        Wed, 6 Jul 2022 10:40:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5ykyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 10:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYTWqEpjpPvSEyB0rDQN/MmMEkDUbj20eW1JuZwUsRPTQNeepGZVo2ut6xiLFRftHaX/cUk5IQKY1MZOc83DAFljZy5t440G3bQAKs7FQZKW9IVnWtX/bu/7G/72RyCD1ja2zgJVdwqVkRIBPZFSuOfh9qRhf1bCdWat+7e447ocaIs9CgByJSYWDnZb4INVHI+UUfZkOWmC3GHA73VqMGWn2irHzegPW5sualER2dQvABp7Wg+7teEWuJ6f6pDqOcLBtKfcSSdJEL0HimLpoQVSLws1PR+cZWy3ZsEfwkHftEAiqF0J/ZmkvZNb98ntpZk/ZQdVJ6hZGT0xhiB75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFHSKfKFXKen2WVwe519npnMUv2X2UNUm6uZofYlSm8=;
 b=abA4e/5nip8cAayXy2pDBmDho2esloGXFoTI9ZJGM0esRD03G3o9ZrI68c+h7LyiQ3kTBaApwaLxqzmZahznC1trxJTAPgnKDheN+lf43kGYcWv4t11c7GwBNrae/V4o0aKxQt9hcv1MRxPmnZqdqtD4lVHVE66CIcaxqHc8L7VfpCH62pB9wsJmQfJ1Y+GZL1joWgiHTFTXUnNMOIcu9/4DY/bASkyI/qBhKNEDpYSONDAWqGyCXrQDqbzdUN2X5ROMMOw+pZVPLD3QD7FRxSy1ByFwmhHtKwGwdWj5VxdbwuIf1IBRsFTTD+AMhJjpahi8l1CKZJSzQJ6ZTV6ekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFHSKfKFXKen2WVwe519npnMUv2X2UNUm6uZofYlSm8=;
 b=MI5ZtQoSaX4/U1o2SZ0Z/7ciVHYr/ZXvrOVkSrJYKCCTNir4HYkgOrdGLyQmgqb/VkB14CbRwys/Ql69FfIRQ++6yk74IAvokvO710u7h2+mv8MEfXOVykqxKvf2RxCjIMqJSf1mG6+MIGFsd3APllkl6tqe/FqLL8fFxoPBZwg=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by MN2PR10MB3920.namprd10.prod.outlook.com
 (2603:10b6:208:1bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 10:40:42 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e038:d513:8896:32f4]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e038:d513:8896:32f4%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 10:40:42 +0000
Date:   Wed, 6 Jul 2022 13:40:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: uninitialized data in
 idt_dbgfs_csr_write()
Message-ID: <20220706104024.GD2338@kadam>
References: <YsUyqwe9Caxb6k4g@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsUyqwe9Caxb6k4g@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deda5c44-d5f0-400d-4c37-08da5f3bf9a0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsM4rLcls8+zXrd5BhTdXj2wPUuC3382YPLInUsl8yOCLcWkXLJaUrAAajAPvV6iEwz+kG5kZocjxxeuE/ahpIPRnA8iFD6+pntvrFbgkx1oip+v0kdie+IXGLWThw3RzYabDzo8lXWQOcCuFHNS35shDBaI3K9KtZldtpxtPJEIa6Lpwcy5+aeLjZMtnb4a4sZYzx5jd37zspLrpS8VnR7pkJaDj10XJpSxy+SYxUoLPJnKyWfD1PogvTtV768HSIlJDwkPlFvodGC3N5pw2+fcBWwuWztNEt9WFo8/bC9zoYIIr4eKiV8BaVRQISDkfFxPlFN5jZ3fvIVY380fqlT2Kd0/moyr99BqzpDJExlTiaqE1FtALiLG0tPMv2ShXmEcfkBKKm3RT3W5jVayJ2OYCkWXcsqT5rKfw96UWYnJg/nGOY+STSWELlh4Qw1hzsfNM3Pxk1Gf4UfJVuIp52CB1npggvolS4Y1grjzxmoHZncWs7FGPS0ga2rmg7cRuPLH6xcDxAfb0mhF93jhv2d+LxvgegLFDQEc2eSkFoAT6i71ik+BOnyG234CnRrMJWmh7skwRHVUGKy3xregKDbbG0aoW9k5Sl6r5+FOj5GZFtAg5fGePKEYuJQYNUG7K8i9HmqviQ0svjMUZTpnu1Bd/8u4N6CknU2h5Y0QCCiUD/atDPXTwF2FfiXpp3BeD53VUXZMTa38+NekWsFIGlpywHfHqPrTG6WePkr+/vUgzscV/KHFgQo23++0JZCjzRfh5Z37gezeUBqk5xCWiS7EDvsDaHNc8q6va2FRJDxwJ9mvieWPiQVuVPhTAcFn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(1076003)(4744005)(6512007)(6486002)(9686003)(38350700002)(110136005)(316002)(186003)(38100700002)(66476007)(66556008)(4326008)(8676002)(44832011)(41300700001)(86362001)(66946007)(52116002)(33716001)(8936002)(33656002)(5660300002)(26005)(478600001)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVuXvhvs1WAObpKC++1Wc3ZXIPaZIG9Su6HWhZPu9tWQoZE68zoqOO+PfPXa?=
 =?us-ascii?Q?jA+HOkiBwYrCqyCwKqEtuJ5Z2OcrAXeg0SJhBuLDrIwO4joIInw4WrHEdk7u?=
 =?us-ascii?Q?Vm3f68S5MvPNJqlTsjeeFpJisJbqRGRQlJO0xt8kiSCg141rEd4DWLsa1cDO?=
 =?us-ascii?Q?HmFYkpwgRr+L5dE+tsOEW2myIHMIHQYbectEKNzQKvns7YeKlrcBdpZiWleY?=
 =?us-ascii?Q?nVjEdG3vjDmVpvlHhOhZKJQRSVtcgnYQnT7vmWRkSiSKfPv43I97s3KCoFYL?=
 =?us-ascii?Q?A27yLUtvKvN/VfhyY+e7L8j7B3XsZFqY8JwHVgziRB/XP1PMPOZfBAaIQK3L?=
 =?us-ascii?Q?fmeraYc1GoWKidLE731V1c+4KOYOeDJLywKGi76ZjjCz5XwBfSBhK4y9+Bx1?=
 =?us-ascii?Q?xmCIcpl+nE2YZUnvnYZSG6FBITDNpzD7CGTeKviZiNGBW5jnxDnh3PmZoA+b?=
 =?us-ascii?Q?V13Qic6KckUTkrp5lLQ9c+Lm54b8+kLsdF3QKzsBZzPlwf5FryF77hKgn00t?=
 =?us-ascii?Q?y+WEVcMrThgXwfuhWlDtakh1AcfLrrRI5zeb7M6hC7OR/VL4ut5bOVdplk5u?=
 =?us-ascii?Q?Od/6bP4WK+wDaB4+ApPggI28o7b4PMhSuL+Ype0CKcZbUzQB3wZMman015jm?=
 =?us-ascii?Q?hc5zde/8p9IFYCsvfSFH5pSyA0K1ydzWOCXz7/8+SB131AmnD5rz9lxOPAaJ?=
 =?us-ascii?Q?4kIGz6SiqtGZpijl4sDu5KdwqQvS3kRm0SLVs2mnVw2MXWHwAHHV6t9qsZZG?=
 =?us-ascii?Q?lwY/efXTCFX1zEkWiP28eIp9Thz0MnGRh73k3WuEtuINg3J+a4NIi+4Mzqnx?=
 =?us-ascii?Q?6GZayxl03uM2OBcRDJT0rkr4L40bwVnW0jdPfV23fSYqwrvpKfJXFUDlpuxT?=
 =?us-ascii?Q?6yNmqFMfeVEPVTjL/0Avgcs5nRChrHL0Hjf6o9fvMfGEBfgDJpcud6ZOINZq?=
 =?us-ascii?Q?BUIZbMD8cL19owH+41uFMELtxJ3R4D8z6Vv/Ez+LDWXGANYhNEXW/pqgf1Wk?=
 =?us-ascii?Q?JjnxtGb/cHSxsonScUVrYaneYJzfrQDazqwOmHdV6X9d8AZ0UbFFcjG4dGQ9?=
 =?us-ascii?Q?CTrLbp6Aw/r7HQ9V0djZnPeI1vnAvDkXySm+B2Zhn9dUviY3feSiPYHQ1BJg?=
 =?us-ascii?Q?fhF9qN/VgCMzcyxw/I8fZEKADmlixiuR3Ak2qUOSaRhLY3yPrivg3vTTJei8?=
 =?us-ascii?Q?i32+ljA7XjfMstVKOE4+U8izUZATQbbEvtBcVv4SCF3SVP4KFajRM6frtNUJ?=
 =?us-ascii?Q?RbVXuDL0noTxtscBIbq5wU/Up48/SkFHdbqIUT0tXZhJF/ia04r8+sq8Oc1v?=
 =?us-ascii?Q?95tXWWoYzzQM86h5DhGvKAIbPNAPZ9S9PBTc3K+hlF76n5dhNk/T72PgE3Ey?=
 =?us-ascii?Q?qsk4OAmB3X+SvfvOp9Os2OfrXoxppKjNyHS51fb80isEMzoQ89mNRqQDt6hN?=
 =?us-ascii?Q?ZFc+c9sKgGHrn2YphOHha6ZsUWD0G7ANm7wtOgN6f7Xc5PD4GR9LLBz5klJc?=
 =?us-ascii?Q?X0n90gbKg5e8Ij+4PghuWeB9wCYhmcZ/3YLw9HXV5MydgQl+svryZa+NqDA1?=
 =?us-ascii?Q?Hdc0tKcunCqoeephnHehBzOpQT81U/PomRQB2O1Z6hHv9LxbCS7/qDFiVbaD?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deda5c44-d5f0-400d-4c37-08da5f3bf9a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 10:40:42.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S45DgEYXh4LPfxx2mmJwDmwXvyQ6x63pn5T9OtJsqkxkRFY2SXO7uXCYB+uUQF4xeAZzZHRKF0i73I+8mV4fptFjIfz6CfOMqwPmvp3Gb1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_06:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060040
X-Proofpoint-GUID: TzQfyFx7hKSiLwtGR4i6xSXOn9Yc6th8
X-Proofpoint-ORIG-GUID: TzQfyFx7hKSiLwtGR4i6xSXOn9Yc6th8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:58:51AM +0300, Dan Carpenter wrote:
> The simple_write_to_buffer() here is used to copy a string from the
> user.  However the function call will succeed if it manages to read
> just one byte anywhere within the buffer while we need the whole string
> to be initialized to avoid using uninitialized data.
> 
> Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

NAK.  The strndup_user() function is too strict.  I will resend this
using memdup_user() instead.

regards,
dan carpenter

