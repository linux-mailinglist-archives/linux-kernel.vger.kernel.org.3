Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658E575D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiGOIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:15:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCE6BC0A;
        Fri, 15 Jul 2022 01:15:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F4ZLpg011776;
        Fri, 15 Jul 2022 08:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=38I4dd4dIeKZ4tmBMvCl1ZgyGuSIzv7l1V3gDgYSb30=;
 b=nqFDIxUB8wUDmqAJQ6T60PSg+rGJR8/fdQIbJfUzZBBahLIuPYBJtJMvirvFVODKjCOI
 +lEn+zJQEDqDnqkWJNErSyjTvfCzz8ZPQc+iySwvrgvcsBmWVtLYShVZbFhcMCbsGGIs
 x94VWrO6vqPu7wuzGD4EX1M0v9yNlRhr5WEpngywLq8RF4UR04gWe+yXJ6sCUT3cuB/0
 MhITGZ4dUgSAlt1rZ7dlWKiGTI3zTdYX6sjkoUETdB2tkwByUlah+Fy5/duOA76O4lIZ
 n9vvH657w7unfKzyicy15clwjactLe98Bk7DF9jbI7/FPokLntrQ/iFGxNh40lLMko5Q dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg7272-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:15:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F8BSFR030094;
        Fri, 15 Jul 2022 08:15:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70475vbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:15:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwdVOoqr9//N8ZdGGAmYcIAXTA1fEqfTsBVNOsncEoV8a7CByTg23xhSEMcDklQQumkmr8MU/Dyg3/vJ4g2+CJ+QJQ7+Q68bhC0FrqkU4QqcpmBcuoxslwlH2mnUtpPsknmJbfVLj1Em5/0gLTlXPX1kskzJjHBfzJSGKta/hQmth5i8/m5pyILPaXzgL/LJPaxi0AJuTfEAt7likTjn+15YlSZx0DtQiKKRXxW7B5alyuE0lF62UNUKUz3utt5uqaoiRqPaha4n2zlJZwVGrMtpDVgn+TFMfdUub9SPp3/7MGCJwrkwOEsNx7ZV2D2K9GtvMZT5HZUsNnRMUJxIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38I4dd4dIeKZ4tmBMvCl1ZgyGuSIzv7l1V3gDgYSb30=;
 b=eUlLLHuQYWwg8kbj4hZSZNWzGHL4avms3rbbl4/UtaVjn4uMn9dC6ZKTOeFU/6EILvCxoaFc523HRVEe3mzfwCgsIPy/iS3gJvrZH0SwRm5D4ahTIkD4dFsgQ0/TD89Y7CvwTtDa0T9Qq3FHxmUKaCl5U1tGiXXGf4rHMJzbTTrUANsiDij/zwhMKzPQAo4UZjg4CiQrFKJSPj5hMZKOzPPichb6cAkP5BiRh1QRCrc0qDavL83EdxQrIeXLniHbvpP4mJK5EKyXq6GamqOIxIT9u0CqzAEnSyNXlNwL7/RdypE9Dq5pjz6gZdsGpeVIKzGlqTllPDIB8vLxzNS1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38I4dd4dIeKZ4tmBMvCl1ZgyGuSIzv7l1V3gDgYSb30=;
 b=yF/x+/Gp1ueDD0rjnVpzUXG96x0mGqxZwHj6imiU0ZiZ2A1S5g8k0B2785QxUNZ1jkDWAv33UOh1O9gd3jMDmoGQt+USnNF1nb+9Q0JXSO6+s8nNDW+Z7gpPZXFSjAhJvRCpjT/9gctjnBxeJEnTEtpH6/op+WlN9+uCyf7vXDc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3459.namprd10.prod.outlook.com
 (2603:10b6:408:b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 08:15:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:15:42 +0000
Date:   Fri, 15 Jul 2022 11:15:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: Re: Is casting a void ptr to something else considered bad kernel
 coding style
Message-ID: <20220715081520.GX2338@kadam>
References: <CAH2r5msuc3-1V+dh5NdwnE6uBoN+7_cf=m6kwrFrTnwArND0LQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msuc3-1V+dh5NdwnE6uBoN+7_cf=m6kwrFrTnwArND0LQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63788aee-d473-4058-756f-08da663a3491
X-MS-TrafficTypeDiagnostic: BN8PR10MB3459:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ov3+XC8kd12XiZPV26Sx0GlB/W6PDnFdEO9pW6bm80vMkcq8WEr0uHyoISjmZTTg+XIbOLKLCT+QWTF8z7OWqoqBmWWRYTfNFdKvCoR0T+e2IsEWpD5Nbh0y0RDQ6EAwnTTq5q4DU38tCaXGpFhzvzCjRpszZeTSgCVaD9OEIyDHcyAzEUmWO34idnHPRpop68A34BaaZ16a9Qvm3crwqK7Lqsf0pbjkxXc2eeagKKNt2LFTvYo5y7B3Rx0NEgQQ4jl25BwIL3I5eDgXal0cYmk1NrJnyxUPIKInfekPP7f6f7AE+R64MUNbkl/ob37GpNHwGGxWom4ctt5321CqB348tHEk7yBb1lvyhTI9Dg8stqyoi2ADGfl5b7pgitkXDn+gEMLE4ZJ4JOxVo18+r4NTMK1AE5Ec9/BZIKtbDP74tPOHE3qloPvQKWrEyXSm5So2S7vtyoHwB5ryoAycAIfkwl2ZqURfwkVOeP7INndFkqUXvqu7TX4E6w1jAKBPoVU+CG9XmX9vIpIjrOQfgCz/8EJl1Ob65ZYQr7HaM4lYJStsV7c0BQUUHV1z4aynj4SsT8yLQprjjQDU/ADVerIJSNYQbpXIWwVmKj8OUY6rRVB9+GO3BW3NvLeH1OAeC+RCRLSuMmSuLrsHD4cFps06vREubH+Bweq0NTM5/OyZ3R0EHCczn0yve0YKWvnTgjkgpXJ00j4tl4osnMiQQAM7FyspgsBd1aaPM3sBwoeP1q0dPp5Hb7df6PBdGFfBfG3Rh2qUfTi/ne0iBDMvqBwKrHujSWPFFFb7vePAYKkbYaNDQZ9HVkapAK5eDYEs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(6666004)(316002)(41300700001)(26005)(6506007)(6486002)(478600001)(54906003)(6916009)(52116002)(2906002)(4326008)(8676002)(66476007)(66556008)(66946007)(44832011)(4744005)(8936002)(33716001)(5660300002)(86362001)(33656002)(38100700002)(38350700002)(1076003)(186003)(9686003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSRp6c60fqmB+dRG1LvwNn59pQKdkpKP+d4RrWQSsLdvge8EGGqIrnHvy1hv?=
 =?us-ascii?Q?INb8BFxw8+XO66DqezDLabKRk+mz0/LjeZoepG7gpnUY/wfvaTiAgKhE2/C+?=
 =?us-ascii?Q?36w8MXT5KdEhIpAHtNoXFeKc6xa/cz1LrOuC+eS8QS5A7PdgCQsULNr6UAYf?=
 =?us-ascii?Q?+/vYsVAbYiFtDIGYaVkfliRnDOqghYKL+KelRyK3VDoZSl3Th77oYtJQFnpc?=
 =?us-ascii?Q?o6pJrMewfF5gAV01/akz3C/7o8xRzQDjw/ervuWj7i7V34/DV5oHGeZmOWEL?=
 =?us-ascii?Q?GfzBtA1LS19Tmy88sqERsl7wfR6nR0qY24V/+ebdcAVr2hVgObOwREaM5Qlw?=
 =?us-ascii?Q?tU7DKlK0IoLpFVU3WhwL1SKM/i/Jm13zwCHfbBvpQhfZWC+TnrpTQI9BUlBw?=
 =?us-ascii?Q?DDonQP9EaijZ02IQHo7HKyrQw+EdUeGWZdNXPWpje5lJLFoAJLsMrwRXj/Br?=
 =?us-ascii?Q?j1dsZLdBzyGJ1D7L0L2Bm71SxuXgnV+/Gl/mDZvXatGy9lSNX+Y3GnWMYZEv?=
 =?us-ascii?Q?D8XPi4cef/4nk6giHPoJJBsBXaC3gO947o9No3avb+OK8/NDzoKcSN2t/B1+?=
 =?us-ascii?Q?3eat0kWB+VqhYAXPtxD8j7aPPiHPC0W9o1eIZq3bE33BhEQ+qz+7Ma8nwKcH?=
 =?us-ascii?Q?3FLtJcID5LYg77U3c1CfXViU2mbI8lMIHGV1b6VO0rzBxIig/W0OTsrqvo0D?=
 =?us-ascii?Q?QacfpJLh5gRcyrocjK1bH9BaN1DaErPZoEPAqmxIWOS7Auq96s9EjXfpLUtF?=
 =?us-ascii?Q?UvNtyf2UO1mfakUyZDlrMu/uYw0S+TFKz4+CD7sNpIPzCa5B2MwoKModv5fQ?=
 =?us-ascii?Q?vv+K849fitnfxObNKGM6FkKWm2OAoMIHKos61WDnyfpcBnKIprnrLU5sqL0n?=
 =?us-ascii?Q?a7J/6UxVhbjE/QltrRKC+x7lxEBLz87yI17d+7SLLz4CedZhVrlK9gfWmssy?=
 =?us-ascii?Q?4hZI0rj4sUiC2BMK3hNjy0Peai4z74pGEvodRHgRNuFB+refIdIPA0XWjMn5?=
 =?us-ascii?Q?anczKcshztF9K+Qaxp6caPEw2mvLtAgGcGRNTg4iv9dekafA4WllOiOaPOq1?=
 =?us-ascii?Q?1JU26Xv/988iWaXNxt6Uk/kcZrYH/j77hJyCFAwN+Cv5+DaNhfiNQXWzscf6?=
 =?us-ascii?Q?7JF1siFow0YintJd16UsPvYZ+pPVmb1IaVwsxE+H1mf8V9O8AWucrP179t3A?=
 =?us-ascii?Q?JIOGTzkubr0UgZvJIW3buhq1yRHXnTJgxjSLPokD7DEahhp8IqP3m+MhdUi2?=
 =?us-ascii?Q?aBTBAfMrSo4mJCWSjaEq1FaUp7OLUW/pG+JINZAYDHpM0NIF2nHq47p0Vcef?=
 =?us-ascii?Q?jF2YDc0HGBUhF2u/1NJUlyF1a1KCBFZxx4FSRk9IOYvuFp6ddHrCc/R1yygw?=
 =?us-ascii?Q?BZvnziY2kD9gE5XG6oeP51VEt4G+L7pgr8/4h/B22Pb/E/8QPq5TyaTlt3V5?=
 =?us-ascii?Q?datP1WCbNw7bA37eT9ZzLyaRKkH8E+8taRdGDpHwoizmdxYiUWfQpj5JIi+/?=
 =?us-ascii?Q?6a8ZrmT2V41EYg2vhlWB1mbZRHrTXUUIswRXvOxhGNF7O3vzlJ/EiYBEMRbM?=
 =?us-ascii?Q?8/LFnZJJ8V1vZQQmFzKn9ilmmomHQve0Si4eIpMaKEUBYTpt+XKh4nAx/DRN?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63788aee-d473-4058-756f-08da663a3491
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:15:42.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l53yknr/8oIgbNLrssLABEYur3kQB/paBqYcidAKgS+n5I7b1E+6K03U5uVOJYJxO83Sba/C7tc5bk3S2BnXU9LtNIH0NjNeypjv+jFPnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3459
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150035
X-Proofpoint-GUID: 8DD7Ydu4t9UzDKKbtAetWMCwpAek9QPW
X-Proofpoint-ORIG-GUID: 8DD7Ydu4t9UzDKKbtAetWMCwpAek9QPW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 05:00:19PM -0500, Steve French wrote:
> For examples like this where a pointer which is (void *) is cast to
> something else, is this considered bad coding style in kernel C
> programming?
> 
> It may be that leaving the (unnecessary) cast in, although it is not
> required for C, makes the code clearer in some cases.
> 
> Any opinions on changes to remove casts of void pointers for kernel
> code (which I have recently seen suggested)?
> 

Pointless casts are bad, but the churn is bad too...

regards,
dan carpenter

