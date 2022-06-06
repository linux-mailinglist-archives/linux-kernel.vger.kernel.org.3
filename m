Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4000453E83D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiFFLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiFFLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:31:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84F200
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:31:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2568UN7W028887;
        Mon, 6 Jun 2022 11:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0iwOeAjUp9XltvnH0iDO/T6HOcuMcUf3DG95ZgtnW34=;
 b=yTmqegkiO19O97erC6Xc0emF/Fx9tSIvPhY604RJ+2+jxtEhScjKvHzNFK7RfeCpYB2V
 OSOL3M4exK4RDuwp4E7jy4O1AF7sG1LP2eDU0vWyC0jEZhIH1XS83k1OnkNphHngaLry
 Kb47yxnppdfcZejDVNZ3Dv0MVwTFDPhLuOjL57Eaz9vy3EkvLkY6fA1mlbqpYnkpKKIR
 e/7dtOjAwb+Hjdtcjra5Ot7NGfjTjrSJa9PAT0eXcxyk9+rRqudVjyBTu1KQpddMWuwN
 RImTkRehgjKJfYIA/t5iSVTdkcSGDh4o2p/gdYI3LePySBN1C5P5EH5SGNZy32cymqTQ eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsawrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:25:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256BGZmG006612;
        Mon, 6 Jun 2022 11:25:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu7h7af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXuKT0Tdge2XDdXf3Ud/o0vGgb568Gt3UdHY3WCDq0Xj/yAvc00sOvaBLJ/k34LLmXifSC5y80h46zT4wEReFYqmO7HvCbcnDSHt3kutL5xURyX0ZDXxwYTBVo7EWW/h3OwK42mruyOR6lQWSHiouGrTejyk3bOl+IUz5YWckeghxY/TPIt3uGb7b0x9vXfLMpAv+zj01hAXro7jk2iCIax/vDfTLQpO1raejJCyWbpeC93VsT08vXVrpXP7+dxdpZg7SgnQou36mYhVaGQa0JRlMw9eAGC2eXSvbfS61mVlEV3H5JDWHzPEC2HBKIEJBB0dlmo6tOv/o8ptsykYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iwOeAjUp9XltvnH0iDO/T6HOcuMcUf3DG95ZgtnW34=;
 b=U7sITDzha5PRmZPXy3A5W0Cr6JHwM0Y5OPxJLSPMrBFE+kg/mD3vSK8FkTEUC+4ZpFhdWFpYcgojPRXOPeYQWcNVpOdKzp4bF4DtsIV6sx4jlpHXPGYyuVY+ELyZJ6y6VGlfmOsawKR8lPR/ZHxdxOZk5XSsTZltRHtIyKyK86tCg+9BCrrKtzaAQ+yflyX7zqbZcSJCXHgw0JirFt3jChQxSqLTq/GSj8pFfPEVA+bek/jVR8gmZSTqVfi7vIrBlH5fxoP0tJOsJU5OqTAPGN0fIqAPn669uUu2MxyZMhB8Cqa19bufME1Mo6Yyy9kfb3tSTTqMYE6tzPHCzQziPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iwOeAjUp9XltvnH0iDO/T6HOcuMcUf3DG95ZgtnW34=;
 b=Dk8SOt/bDGB4Y0MwslmPjl2vDaTXtTInPWVUC7ppqkfKzaW7R05J8J7PKY8Y3/fQrjwDA5TD3jtXpNvGYW69DTkXgx+TIx/2RXch7xxkrjDf3SJeQQ2sRLV0KAL9llEVCH5D3xTbHaxf8QzhMioBp4UA3LC/9wHv4wLlRptNyco=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1974.namprd10.prod.outlook.com
 (2603:10b6:903:128::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 11:25:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 11:25:21 +0000
Date:   Mon, 6 Jun 2022 14:25:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/irqchip/irq-apple-aic.c:941 aic_of_ic_init() error:
 uninitialized symbol 'off'.
Message-ID: <20220606112502.GN2168@kadam>
References: <202206010439.LRgjym7t-lkp@intel.com>
 <87zgiq3uux.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgiq3uux.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 586158c1-ba5d-48e6-7aea-08da47af3dae
X-MS-TrafficTypeDiagnostic: CY4PR10MB1974:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1974BC780B24802772D46D648EA29@CY4PR10MB1974.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77RyqtSt7fhTmwsU+VMuaM8Unw2ZhuSV0XWEBIXhX7W/cYCR2cVoNjOVm8M7q4C2kgEBwUV7b37QmhxrwAiL2SM8ZiNlosggvPrGV1O8oroq+xwBwv7WYQoJNYnQf+cRZLq11M2fACAkzd/o/L1w2BpCfWaJVDopKP3HsPjh069pQcxatk/qR4Lmo8nhawdWAHqESTW7NGVFGDGsS0siaUdX0syIxv+p6u/aFtIQ0yJEef09+/lmakMCH1mzFe2NmsIDfRmiy735gfGjwmrr4WNHMAL0v9bgVdyQjJKHNBN0vq5XojXqFYLZy+dgHohOJY/hmLgBJ73hQJxHkS41+kOpJiV3zPeTuiBI1kPqiAJL3ZHNeXkVfSSBYQkfKuPL0WBXFM1r2NLSvYZ2LY78DOhTPeP3Eu25RH/v7V2eP3IVcH+g+akJwSLmVu+xf5bkNRm7sTXU1zt2XO3DChCnFFERARrNVYk+yc+Z+g6f12GLNLRFyPRf2X+8PoGLHryhNDudyrWdEJld6JVj/tLpiaBfY61lnVlgVDXcvzqJRs7CJ9p96Ddax8ebHIR6vmLt+NIIXfuK1l93lYgwqyf/dBC1UE88TKTHUUArXKnBQX3aqudhYshFNziMjMXfAuOQBZeKNr+RpuT0VieW9XgNeE1bdgxgsfkIea9EpVFg5IYj4R4pWLiSe/waaPUMbIuuuS2rh6ggGH72gAThbyOSq6K1Ce3xuIZiIM6JbevKuH4faFk7WQL3wRdaeMwv3s5Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(47660400002)(6486002)(33656002)(38350700002)(38100700002)(316002)(186003)(2906002)(33716001)(1076003)(6512007)(9686003)(6506007)(26005)(52116002)(86362001)(6666004)(6916009)(8936002)(5660300002)(66476007)(8676002)(66556008)(44832011)(508600001)(4326008)(66946007)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixDfjtK8CtdtjwlLUM7bREWICs/z0qLKJs1HaXk8fJWPjUAoBp9waoenw3CW?=
 =?us-ascii?Q?jSh++eiaXpQjd+GC3KhBUkkdqEt39rLADo1Nctt2VVoMTKKr2xSz7p9vJIMu?=
 =?us-ascii?Q?bGo+Rd9g9jEmdCfUEkAFuolFLsV0zPSDb4e+AUovyfsAA9wLy2cb5gKAB4b1?=
 =?us-ascii?Q?3PMors4ZKXprYpi6rZsg0ZLEZPXrzJMyIKucf/vbQozeTAe9jDkmo+eH+rjx?=
 =?us-ascii?Q?0/8ugft8LrV5fxYLEA8JbZ/Pa9rwWRjA6sxqcbuW7rDbEWSUU2deroj7baNl?=
 =?us-ascii?Q?JFURHod5AgGxNgtUYpzoLzuoDFyKi8JDNCyl8qrlzGqA1UBdopepEZp6hVD/?=
 =?us-ascii?Q?KQzC/uTdo0xuf3c4kodFjPOjSvT3OTGNwRsdGHcbJYrQXjei/1yYuu/OO5wB?=
 =?us-ascii?Q?wzcStFedskWVxQfz5hP+Zjvkll0LVFlatH6bbGV5oG++1HQTLGNKaMspx788?=
 =?us-ascii?Q?0HizYtuhOa7yGDwjteIenS6cEAsQwF3kKgiYoV/uVKBlzTcbisKTxIIAGph0?=
 =?us-ascii?Q?8oehBdIqQhAT225i9jA54ND91lsrPKbxn3kt7dCAnoGj1q9VUuD97NdDcmXE?=
 =?us-ascii?Q?Wp8JJEhMHs9ZdTYNLRSrTfhGYV7gg50yJquWQj1F29IisaVCfViMyTlsXXCC?=
 =?us-ascii?Q?1bhU5N/9LLmiijRShEz8jmQbRwfVemcjW5CagRYxkec+sZ8lzm1/88JJiZZT?=
 =?us-ascii?Q?e719q6L9I+XSNT2wIDawy5Xohn+TbA3yHoVLTfeA7PmoGsCNx59IBUKEc0+q?=
 =?us-ascii?Q?g7uZswkHqZze9mqX7mz+LiXX3LCr0rt9v6+AZ6slxuF/aMw5RwAHMbc9G88c?=
 =?us-ascii?Q?G3lUaP13xcCjH4DFFefEXHLJgGno0A7Sq11k913m7s4hVmyIz6D0DzKFMvXT?=
 =?us-ascii?Q?UDWJp824GkIUyeea6dJXA948Vdavr3WRkCYT/psIG/kh0ruQJ7OICDfHCbh1?=
 =?us-ascii?Q?meQbvOj+t9dT1FxWd/MlJzyF0cX2iKgkZy568cCRVrGaqwOt/kyLjpb/gnbp?=
 =?us-ascii?Q?gTjrn+Vm/1rI8+c4OMKHaLhDzQenxps8H0mfr/vWyDe+QjENBYXcGzUa0MoC?=
 =?us-ascii?Q?XaKkbCK20Y5zU9VP3istdfjOJ1ZBGxJm4cw7jjo48SHFxJZZ1w9g8Zz4xig8?=
 =?us-ascii?Q?wd2mpL88EV8QWAA+j22x3rESJbA+WUDJJ/Xx1cGJTnSuUADdi5SReKeAIlCI?=
 =?us-ascii?Q?uyKr+3CNzcE43wWVFv+EXzfHyqxVN7opNCgFwYBN9vUGF1g4Juom31XvUzc8?=
 =?us-ascii?Q?b92wE8stHV8JU4KIcQ22n8uPsYqb6k4dUXVt+r6/V/MEQ3l8m/qREsj55Jxk?=
 =?us-ascii?Q?eE1WYKL2eBLGvknFQr/HzsGN8IEtzpMh+CEu5NaLvHTVC1RFeHzYM1SoXBWR?=
 =?us-ascii?Q?ZHEg5x/5it3Ezwq/RyIemRr6fpjmaKMyiwONTIkNr+5vJDB/j6ygvI+AchhX?=
 =?us-ascii?Q?V7SRQH8qEQ9Nt8RHI9uiaNIWl1xOurnTkUgfLnC/7Wu7apNors/4sSGbC76u?=
 =?us-ascii?Q?aVubOmd9T8dEhg8n6/3hxAj26OC6kow1AKABKVIAdYl0Wzqa+HJVdcVrnaBf?=
 =?us-ascii?Q?/gQvZxCmSlGzc88kUY2hcQ4V5b3/Kb7tVe5WcRQzMj25NuRlUQOIwkBeu5lO?=
 =?us-ascii?Q?HEQNXaulj3r/ExzJ7oR3O2c+DBzPKjvpEokrEKM3eEEzEPXjXtDXhJ/fDGrY?=
 =?us-ascii?Q?lXGRa7dUPAcgGJkrwLG3N/tuIpYmEp7Kz39QNYUgAYvgUu8KDKi6nV2U512w?=
 =?us-ascii?Q?qyqEahfmQ4avmgeoHIO799I0DIHy0dw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586158c1-ba5d-48e6-7aea-08da47af3dae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:25:21.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIZGsnRZs3dmlwQvMwcN4p1iP98lZAPDbkq/fxcSyFcNmYPfOac8kZ1kyQyTDTz5AQjA4l4oCGuDvk5AOL95/oJg9qLwts2t8rM5pNpohJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1974
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060052
X-Proofpoint-ORIG-GUID: C7YWOftWFTKvYVnFS-uY5RFqq5AUgXGU
X-Proofpoint-GUID: C7YWOftWFTKvYVnFS-uY5RFqq5AUgXGU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 12:16:22PM +0100, Marc Zyngier wrote:
> > dc97fd6fec0099 Hector Martin 2022-03-10   926  	switch (irqc->info.version) {
> > dc97fd6fec0099 Hector Martin 2022-03-10   927  	case 1: {
> > dc97fd6fec0099 Hector Martin 2022-03-10   928  		u32 info;
> > dc97fd6fec0099 Hector Martin 2022-03-10   929  
> > 76cde26394114f Hector Martin 2021-01-21   930  		info = aic_ic_read(irqc, AIC_INFO);
> > 7c841f5f6fa3f9 Hector Martin 2022-03-10   931  		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
> > dc97fd6fec0099 Hector Martin 2022-03-10   932  		irqc->max_irq = AIC_MAX_IRQ;
> > dc97fd6fec0099 Hector Martin 2022-03-10   933  
> > dc97fd6fec0099 Hector Martin 2022-03-10   934  		off = irqc->info.target_cpu;
> > dc97fd6fec0099 Hector Martin 2022-03-10   935  		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
> > dc97fd6fec0099 Hector Martin 2022-03-10   936  
> > dc97fd6fec0099 Hector Martin 2022-03-10   937  		break;
> > 
> > "off" uninitialized if irqc->info.version != 1.
> 
> Which is pretty much impossible by construction, as as of this
> particular commit, all the possible implementations have version == 1.
> 
> Subsequent patches do add cases where version == 2, and that gets
> covered too.
> 
> So unless I'm missing something obvious, there is no bug here.

I assumed it was something like that.  The kbuild bot doesn't do cross
function analysis.  Neither does Clang really.

regards,
dan carpenter
