Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B952B472
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiERIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiERIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:14:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65158D6BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:14:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I7RUmP023077;
        Wed, 18 May 2022 08:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fWIlhl3xtPBE4856KhgEcJD/qAiZtdTHnUeRoEBc39A=;
 b=Dce57V4SY+yIfyfy6B3n639qoRFWvCZEjvR1K6miT1wj6ncB9Cbp9sPJt2IGyGvhfLgh
 2Tcu5s0WXTM8RRTrr5N52omMj7MCgY4/4SlalG+3OLloXds094W9yPTyb6djY1l9jDV4
 Au9fkndrKlTlCWJtVBLzZLDxr8d45XHW8qK95ObDWZaBrOynnhoSDRPWANviwDqKbga/
 76pe2MpGAzVXkjZ6/O378EvACugpoFR0mx+0SwK9VItzSfMZKYXX8uR+kXm+DZPHrZr0
 qju1l+cLYGbCrs5Cw9CRARKQaUHsdzH9ekVcra2PusUkkuN8tZpzlEQw1tVpIQSre3q5 jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s8gdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 08:13:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I8Bn1X006302;
        Wed, 18 May 2022 08:13:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v44c6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 08:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+Arwre6adfZH2Q0z7WRePkOf2Ir+Yf+n2PWle6jRrvYOqfSG3dFbFkoFFRNlzNco2zCer9P1LROfgHJfRnYcs+SIixdyEIJZx5QQ+5HE9FqXPgFKCcVB63plksET0om+XMqGfjebaRZsViLKbSVS4vwoxluHoZDx5OL1Im3zHbpn8B5C9wlKbnEdbxwvnFUurH1msH2DkAJERjqKa77IVDh+Tsj+6jaAl+ddJhgK+4vh2/hXEClf0slWSJIG5eGV9IMY566BF/DFfgq/cE5q4Fl5AFigSakRQ9xvYlO+m68lys8ycEvNZSscHhKWJjbbDY7T5d+WHiv/cZqlBL1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWIlhl3xtPBE4856KhgEcJD/qAiZtdTHnUeRoEBc39A=;
 b=VD90jO0dzZtSUqm0SILwfbGJw6omGWFf5jEr4rgmk1oyDISEzI0EvTC/Sq6V/Wl/kNFF3HhiYpzf+p5ppcTRlL8/r4kergkKVBiM1TbXxtD9yK1H7xOyjgDdFDgZXMgB7Rh++IdI4HfmwhTsCW4PBcKK9N4/fSh64svOAkDgxFtX7pHZJaGQ+gC3ImXanr/J2XB4bUxOYIYr/R3MpOc/8ALxHj3uSWCAZiNzcZ3bnIyOwnhc10CVZr3g/KKhKgz3+nNG+0Nj1Ths9h9KJjzyZUHifVpff1lRED79pzKsreu3DKnXFkWlN8wlcqWa6GpoRGlsdfa+tfs3k8q/CmmeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWIlhl3xtPBE4856KhgEcJD/qAiZtdTHnUeRoEBc39A=;
 b=m8jh1w2SB6LtGlTOkFlRPpje7X/NwexoXOnlmTIId40852TvOuoWqmixtISc9HykI9anwgHZSk0HxWrobRI8gGpEncPf7A/thpJfcLUW7hxvI0HYWwAmNj7wtQD7ChfmxTB4J0udIC47VgivtbdwGUbMqHx1UoWb+93ij+1o5/Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4710.namprd10.prod.outlook.com
 (2603:10b6:510:3e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 08:13:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 08:13:49 +0000
Date:   Wed, 18 May 2022 11:13:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Message-ID: <20220518081335.GR4009@kadam>
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0181.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e08536c-950e-44a6-f8bf-08da38a65689
X-MS-TrafficTypeDiagnostic: PH0PR10MB4710:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4710ACA4A3EF2DDE41114E568ED19@PH0PR10MB4710.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/h4cQq/5Sv4A98pJfJbwJlc3+L5fUwbpn6OjBhgA7LUOUaB3B8E3P5QLsrC3hyvTRvTlPfrudlpaz5PFED24dzMj7T/LcEWdadPRtdkcr4bKHDbV9rtyQ4CeF2ux4ahZoqqgTrZT04cowBUzDBUhRukjiPs56TRT2utFWP8rh9WPgp8m8tDpU4unUxUenMZSs67Oa8aUjTuh95HkGs9XSogq0Y3HIlsyCrSj7CspdqBWTAOuyopvkOq0gZYFDb1IJg675mL89EGw6mO39+DmGbtZDjNOPRtZUjZ2ulrg3wD2kn2YbBzc6YVj5hz4WnrzsICS5eFkPiMP+zBblx2ahCvbjZd9AqrbFo1wICZoPDX7psx4n+O026fhq+FJojA/2IiOg12GF9cYjSv7eDcSvyOxq4lwuV4APC9ruwRhX1KyRMTc4d+pwzAikXEK6B0Be5eC/nggG2uJiQb8zQbaxpMPmStaFUitic0kflwtPRSnL6ZEVu5b8EM1jyE6XVULV6wSq58p38Ylg5jdm/ELqZw3O1zs6DqHujikq1a781qohNyc0EJg31aFLvRfmStS3OTUdf3D40R/vIWIcqBCQQrCqzu95OOQpy0884Vgmw0UD5dKc3wlnPuv8ibuMH/kyr+/4xv6oVAGvElPggHLVG4aFW3u+KSnoI06RddLJFi5V3k2zp1IX99Xenalf7RNQ2s5k3hm5aVJnNyToWP2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(26005)(6666004)(8936002)(33716001)(508600001)(4744005)(6506007)(9686003)(38350700002)(38100700002)(2906002)(1076003)(6486002)(66946007)(86362001)(6916009)(6512007)(44832011)(33656002)(186003)(66556008)(66476007)(4326008)(8676002)(316002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhnyjJ06dYIHVcjijC2xkczN7r65ifIOeSKpsqu4kMlYPiPKSRemN83S5uwz?=
 =?us-ascii?Q?WO6Gm0/Hs8f30hgZFc9NQLz73xSogRozB7LbWZu/mV4dUyPZUcrGJUy3HZYj?=
 =?us-ascii?Q?UNLflwOEV7WQ+Y5D5GV7dzopzJoOHsE/3iOQoDCR+Mus2xrxHrarFXpzREng?=
 =?us-ascii?Q?SdhtYaHOjekjt7oduxePkP8Tf/pX7aEhKAN8znHDBChi6NuiCiAC+pX+BQAF?=
 =?us-ascii?Q?K1/tkT92wdibh1i99IrxsMSTU/xuhsox59lT1O9Db4z2mS1rUo7IaqtD433s?=
 =?us-ascii?Q?NN7mH+JXaS2hFWY3UlfZro2OTdZzOmbQU5f4zqrjBXQ61Rav9psBgF9zFZwN?=
 =?us-ascii?Q?cTx+OiUOD7r0i9O13+c7D44K4bz/5Xp2P+qSlzNSRbaqvlxl7ObKO35EPPIj?=
 =?us-ascii?Q?sDPHIyiI8Q/i/nCpeg3goB+4EhdTgEffn925I4jGL114weRVEmdNqb+1bFow?=
 =?us-ascii?Q?NrBzdliEtoE1+k0pJK5nLzUolX+cBkNbuYw4Q/vTS6fBU2gHwuvxrc2ZrKUX?=
 =?us-ascii?Q?4Dd64SA5Km/9bAbG118cgyl3bxpGqIIECsXzAuf8Ep6qWuNMf390KHArZppd?=
 =?us-ascii?Q?0ozcrwxHsisazcfhLtEegXVAmHG0m6ma3e/F2V3BciTEKFyYz03PpKUrqbLf?=
 =?us-ascii?Q?TP0mUE32B9BRDl2Jt3Q+KQlCl7hkigN2JhV5KrpLJYpbnKPj0qh7Qg11YOIW?=
 =?us-ascii?Q?z984EwQdY0px38wjXVuzxKbHbDE7dbKxCSijOTD/Rs6O1OMvLkoX8Snw9a/D?=
 =?us-ascii?Q?42CQsVjjcmA1OUGwuoVT9iX+S3ZI+kh7e+p7QxHovwbjLz2WKN/X83+ZS4/1?=
 =?us-ascii?Q?gOY4b3N1EQvEC9HvxiOE3ccAHNU9Ce9RJc1CNGso+bG0+3Wc4njzFKs7NtWK?=
 =?us-ascii?Q?Pa90m9fhqG7eqM344/CtAq5eu9bhKHPX2FSgClfQpcj+6fWIqVFCvsYBbzis?=
 =?us-ascii?Q?jvg8YXdTwByDSVMjqJgmAvndwy0qnApqCxCsEH+GNY2Fqyl9As0PL0hfacbv?=
 =?us-ascii?Q?xthMmWyKL8duGdsoqHx9KRsljds1hrfGuSZM/TJsnLF/lxHm6u7XgcT8Vb1R?=
 =?us-ascii?Q?IZ6HV5EsRM04Bus8vqN2Ba4z4p2WaZ6U7ASMgmIVRQ1kXiHF615i26lbNJ0D?=
 =?us-ascii?Q?2nl3hjAdEuh9RHmSBOPlKWNI5Pj5uhEohP5hfmpmrRR7HeKEqO228G5KhFm+?=
 =?us-ascii?Q?uVYqODnfTvhT2trc3DcFyW5iNuRATid6xxnj2BBaAJuoxuBKRsq0YO611xlI?=
 =?us-ascii?Q?giX5k6kSSBcClm3dyrNZv8QfzCP9zrpVnU36g7P6cCQwBKTq8D391ZpMv37l?=
 =?us-ascii?Q?hC2N1zq8KLrCo8+uUH/61IM+iZX2nkHN3suK2FCFACsbb2mjrb4OP63sLRjV?=
 =?us-ascii?Q?SrpeDqfLZ9DVoNSv8RcAoIriUpR/aFwo/QNKUxcR/34V6gn79J3aBrWJb16Y?=
 =?us-ascii?Q?EvDF1b5Qz/XC+VbdIu9JBgVlWAyieP5MYwc2kXj/pzWv9KBOXgS9SdlLcjsE?=
 =?us-ascii?Q?V6zjEfaptvGNEXfXIYlW0q9HqVSvJO5PO1CqpgFLbdx9VeIloZQKarVotJwP?=
 =?us-ascii?Q?fmKBedQd3eULM/ZFNMBWa9jbWxe4Clnvy1HLYIoR1J5bWStsZuUNvi3IPQnc?=
 =?us-ascii?Q?/Xq/K8dWDZUx7kLHdjCIpfBO5j3Phs5tJI48NjZT3ah3U1sG8/mLTph8ntyA?=
 =?us-ascii?Q?8pkDrruaHrZ4OgLW8RQhAenqvaPa9jBrPJ4M+Ud1QN1SvW50pUlqv7ogl/S8?=
 =?us-ascii?Q?2SGQBIpWQD7XjzDlmULjK410UdPshnY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08536c-950e-44a6-f8bf-08da38a65689
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:13:49.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/oXwYlrU/eLIF4Y0q85TSQLL51rYPCUwZdhwGcDITk8tL3utAPsnMn8pn3/AN93BcqG2802QupzJeJGYg3HmYjYbjwCSGhtiYGMhPVqnQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_02:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180041
X-Proofpoint-GUID: oBbOwswWG9DzkcV67Sc1Ybj694-3p6eb
X-Proofpoint-ORIG-GUID: oBbOwswWG9DzkcV67Sc1Ybj694-3p6eb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:59:57PM +0800, Jiasheng Jiang wrote:
> As kzalloc() may return null pointer, it should be better to
> check the return value and return error if fails in order
> to avoid dereference of null pointer.
> Moreover, the return value of rtw_alloc_hwxmits() should also
> be dealt with.
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Looks good!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

