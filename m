Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6BA579748
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiGSKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiGSKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:05:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEB371AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:04:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8Xs0I026736;
        Tue, 19 Jul 2022 10:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RQ9pn4em/wAbz3wFMAxirXNFya3W55B/chRbfuf7TJ4=;
 b=t/xT2Wv/rC53tAmli2lxtgxc5UebKyhgitkO7L5GeiAVcLHaPqB/2Yaat845KkRMvsns
 yJeFBtrL6iU38xWGtOP1blzsVF0yf5DUMmxiYzAEfrm4pbrhpJSfStU/qrJFwhqbNoMh
 gwxDh4Nc/VVYSBobd5e6D2MdPCL56o6ftRVzEDTJ2RLnXp0HZSkSMCSyfwQWrtvsZ2dJ
 f9bZZrqYUbT/n0P8h3yzdzL/nX3mHvXan5Tg/93Gs6t+aii/N5ta2m775J+4ycqJUcpd
 wHzErCKmYZgVrHZ+h8wf51fpUDum2M/45j9ayJo1zILoRWBsQOR4oQGrj4+/jT9fPTVZ Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a5q4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 10:04:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8a8Gx002721;
        Tue, 19 Jul 2022 10:04:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mayv97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 10:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEQZ3+QXP6URUQ6PHPHMYhHjIyOqqCSeWMEc1NElfaYXeDqc3fVWwMqI/mM2OO3rAg99FaiRH0yLGgxr2L8rv3af+d/31DCaEvEcrMT1fSHbPbDiwPfz2RSnlwtmiLM2xnjOENGJAQVloJ8gRtC5gCdFHaYEJJPiBTakDOxPQoxbTTvj2hhYDlPzShOKZ1jPSZbu3pmFMdVX48gTIos9Fz/qCOpnNijy6umTHlz7jZLsUGufb18WjR8h5G0SX+oYDT5c0y9dh5TagWt5k0q/C3DiT57owJvWOzX403Tz92utfJiEB3GnoDc+tm4aWwSD45ZJ0YsFugmGMaQ8Lhx15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ9pn4em/wAbz3wFMAxirXNFya3W55B/chRbfuf7TJ4=;
 b=Z8fG9wPBvr+yAnaT3lRnRl0vIC0VuTc5Ag9Ojm+WLvmSo8/HP3p5bWpqBcSK3y3S00XbWfKFPr7l+hmra+cYN0IkVMN6ilJwUNIy4f5hPo6k+1i7FdWfApAyXJ8FsArEc+Cc/ipKs0CZlWj12UH7niAbSPwyhxgVjtTaN8gbpdmfWbZGq8EbkJMN/xfFtarrk88pi/6/dfsMsDGqKUcxHpJv2UPCTUGYCnHBxZFmOdobfe04qh436GAWuDnRSehsfxzX/T0DSQGQ1y44kdg/TMm/llbRUo3kHynP0CnAiOIZEYHMa9AD42Iu1bCbCKpaO1Mei1uJbpke3CxZrUr0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ9pn4em/wAbz3wFMAxirXNFya3W55B/chRbfuf7TJ4=;
 b=uBKITylkMjzJsPTsvULSo9OIgfq4rtsl7EHtR4j86ZG3zWfccppq4TuJ8liQwax8uw/qr4yEyJjIODW51QBS7N2OK+lHrMOdV6zgTf3L9rpQs3tg0F5vjEWcNG4b0jsnBT+mrQgWz7xwQ6pv5ix5t8vsQkPSMAY+BvahQcG3t6Y=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by IA1PR10MB6147.namprd10.prod.outlook.com
 (2603:10b6:208:3a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 10:04:38 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 10:04:38 +0000
Date:   Tue, 19 Jul 2022 13:04:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] staging: vt6655: Replace MACvReceive1 with function
 vt6655_mac_dma_ctl
Message-ID: <20220719100420.GF2338@kadam>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
 <c433e54f0fae051fc8ba9050aa094d6f7141e8d4.1658094708.git.philipp.g.hortmann@gmail.com>
 <20220718124136.GE2338@kadam>
 <71368760-0399-52f2-ca6e-ad8f4daf8003@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71368760-0399-52f2-ca6e-ad8f4daf8003@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a06071-b674-4a2c-a749-08da696e16b3
X-MS-TrafficTypeDiagnostic: IA1PR10MB6147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOj/aUgd6YjDrTAp/DnfwG0cliD/L7GVrDNbwCCZXc6QPAts9ZWE8OxAEQ/Dzc0PN2PPAgVhcn+wDtJk6etVT9hzqXmPaSfdusSWMmqoE4baJyMYXd2CGQAX+suDr5SHAbrHpDvm/2qVgbBzKwJ9Qf5xqEYLC2VGSIgB8NIpnywsuhZtURLyEQ9DMnJg03T/F+G4BWGQJIaPrYsxAuihy7pj/u6bR6ZQ8gvUXSwxu3cJiYncbUu8NBFvETvsu8qL3xknjd2c8i6Az1OZT/iqKKyZsAPVP3RKGBlnX4AZsBVn38hiy0oULXQiG/X7j7zkx58QVH8UIFK3SN0jLpfqNNc11GixPBb73UX7BDDv3RPd6AN5xQkUpjG1u3ivoFunZu6t+6eYsJlwkAadKjT1X2a9Db4cyZc2sJdrJRD130cfLx3cZMiNZUhujKwX3BY9S1MgJGjb1JJujmXnnV490y3JDgcFMnrDLn70DPpfG6Wsece3QJ0uCl1TLcKVtmKDFUgYJ65X4d0FHqjsCF1yRRne0gUy5u065Q1wEihicokc8CZi24KFIcvqlABt8hn8i2T1T+Qoq1/PyMYFEtVdEea/7f3FT+QErZukqttMtnzUjbaM6O8My/kB80ukf9ckkOKfVnf+jfkoD4JfPwyuFoRC5wQNL/uGXVpoLTt1FIrvLb4mK1D78j38jLniFuJyZnub9NRGpgR9WNTak0Ex62oQf6cH97ZWERw7BEPRDof6472XmuIMG5a4Z6T7qLj0LhvCdivxiFA//oMOFCJ3vlCbxpKSDafyagDuhfD3hO8hZOiCgWtDrG60zycv1ez6kVA6nWNnNBpgZBQ9BTWC8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(6506007)(9686003)(52116002)(6512007)(86362001)(186003)(26005)(316002)(83380400001)(478600001)(1076003)(6916009)(33716001)(54906003)(6666004)(44832011)(66556008)(966005)(33656002)(38350700002)(66476007)(6486002)(38100700002)(2906002)(5660300002)(66946007)(8676002)(4326008)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kHBUBjtYUHEjbUCwyovilV7dI/CAj05XOZQJrHQI1EV79ShGKvKkaKzHch6z?=
 =?us-ascii?Q?BszhMZozxN36zMs2j2pvd2S4J7LFPvuAyFHwS+PpZVDqhWYMMdZESJvdovY1?=
 =?us-ascii?Q?qEftxlyzElnK8eMw+pbiE52BHHXT4PMuXQKwdztf7VhoQ3E0e2GXFN/75Uso?=
 =?us-ascii?Q?Pc+cMNUi3ihg85KFX20XS+BhlBlClp5clqwKaFEfIGvGGmekRHwW4LzXQPSZ?=
 =?us-ascii?Q?rkzjpqCeTyJfxkIvc+Wz55AkPHmHK2ak802yPR5YW6UHmJHv6mqIOzEVWQTn?=
 =?us-ascii?Q?G8u7nul3rEn7An4bvUfkv1xqKpFeyMFf9YwBAAdFeD9AjEALkCatqMIVFen2?=
 =?us-ascii?Q?vLpqGJYYyyK/JxsjxnxFCa/N1YYDc/0v6m6rwFLFmhWzFNEsoL2KCFYVfB8v?=
 =?us-ascii?Q?6fsUkTKlpT/uK/K+UOxfXqVGmRkWEAPO7J58RxdbDs2JLvBZXTJ6OPhRdlem?=
 =?us-ascii?Q?CN/db6Xmp7q+SeqUVVWjrr4IsmlwGpPVAVee1DsSfMJL2+vL0gyoDDq93Ow4?=
 =?us-ascii?Q?Xy7e316l3HD6cNfJ4aX6OaC3+UGpoHkDItDK4yzODUHjWwU7QmdL7jyPhSS8?=
 =?us-ascii?Q?4/9sgPGlURPbw8SzxGZ/HdwbSQFDTuuopZtWhUjdiOqJKo1uo9XB5t89VR+P?=
 =?us-ascii?Q?0dKz7xx4Je4mC+W7zp0ee9I+31CMfgD27FnxoSGqbQHqCRRdxaHTLiwDxejX?=
 =?us-ascii?Q?5kKpvbR0ZzMqBVi/1sis8wQ46zFqF+frjTZsw3mgZgY2GtePAfeKPtVhcjZE?=
 =?us-ascii?Q?RHdLeTeJQJ5mXHLpq9OCLPWXuSnAiBaPSCAmBe4cMOUI3+byjPIScamIoGE4?=
 =?us-ascii?Q?wE4lU22tXzGvaqcTteY0NZmv8Ts19Td76t9OGAMXtBu1Tc7nhkxE14H3BoOD?=
 =?us-ascii?Q?zBVa60vFMZeHZB4gmaaPP4dD+3sYn9b3RAH+X1Nj6s6x8DuxRCHhAkDR67KY?=
 =?us-ascii?Q?Yx8xLV1pa+1ujE22RSU4cA2+SC0fQBFhLso5xkgm90ik6Z3kOcTUwEzw0zaq?=
 =?us-ascii?Q?9PlSa4Vc1aK8k5hdncOuBNCk6w5a6tSlACdEq27ss/PbekMRBDEXSugCeMn3?=
 =?us-ascii?Q?gbmw2sFzx5GTa0Sg19XM+Xz1ewy3q6M780hHcCFlX8YVEC7NE6EW3qJqMXlq?=
 =?us-ascii?Q?s9Iz+cZKggAzwPNTA/Ps2Ws2F2MJ5aZ9A1z8DlKD7v0N9SX0BT/N+L+PmANm?=
 =?us-ascii?Q?tiQD73nMuvN0kfepxD1w2SF+smd/wK/D3RKUXblkaQKR25kBHT7uXgedJ/eI?=
 =?us-ascii?Q?pBrmhKBSW7fxOeDAVrwKUCpLWNqpNnjRoi/lAvQ5bP2cbOUDdrr1SBImFU0D?=
 =?us-ascii?Q?0i31tdd4d776hlIM0xdzBYodUAGaulGmQvMuqH/BesgxCNy/4uXmjR3cXqwe?=
 =?us-ascii?Q?32x570DJxuuUWHh1Pr1gmwmI4ojqqpXgWNuMfpQCF4+0oLNXSPQ2nc8FVBhl?=
 =?us-ascii?Q?auaBBo/Jrxa5WoV9BGQ9m/2Oq/N5UL7bC8BExv++h4H1y5qKzd0O2xOMQGQX?=
 =?us-ascii?Q?RSk377Y2qmGJcgzvHsi9dxfFhkGjJEbOYlX/MqoeDovS8VL0eH2eR2KU71GX?=
 =?us-ascii?Q?Rj7bzfyp9nG1L0+m9ssScRQ/GnYZ5uoJ2oFb6RJHP0L8haCWpePDiIE1WZF5?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a06071-b674-4a2c-a749-08da696e16b3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 10:04:38.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGhCGT/Xvn5/e1LUM7U8qAqRdPN/u2mDXYeVEIaH+A3FhqIuv9FkYEah1ykFMtRzxQxJBlS9mFsgNQnpLgUCNwzyd5fXKVfXgo4ZmyONJ4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190043
X-Proofpoint-ORIG-GUID: 25Fps1lKQo5BgND47N_MRpd-l1DMz8HN
X-Proofpoint-GUID: 25Fps1lKQo5BgND47N_MRpd-l1DMz8HN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:00:59PM +0200, Philipp Hortmann wrote:
> > > diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> > > index 5747de436911..129a6602f6f0 100644
> > > --- a/drivers/staging/vt6655/mac.h
> > > +++ b/drivers/staging/vt6655/mac.h
> > > @@ -537,16 +537,6 @@
> > >   /*---------------------  Export Macros ------------------------------*/
> > > -#define MACvReceive1(iobase)						\
> > > -do {									\
> > > -	unsigned long reg_value;					\
> > > -	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
> > > -	if (reg_value & DMACTL_RUN)					\
> > > -		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
> > > -	else								\
> > > -		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
> > > -} while (0)
> > > -
> > >   #define MACvTransmit0(iobase)						\
> > >   do {									\
> > >   	unsigned long reg_value;					\
> > 
> 
> I was asking in kernelnewbies what to do with multi line macros as
> checkpatch.pl warnings cannot be totally avoided.
> 
> Greg replied to make functions out of them.
> 
> Please find the full email under:
> 
> https://www.mail-archive.com/kernelnewbies@kernelnewbies.org/msg22042.html
> 
> In this case I really like the static function solution much more than the
> macros.

Yes.  We all like the static function.  It's the commit message, I'm not
so keen on.

You could have avoided the checkpatch warning with an assignment at the
start of the macro:

	typeof(iobase) base = (iobase);

#define MACvReceive1(iobase)						\
do {									\
	typeof(iobase) base = (iobase);					\
	unsigned long reg_value = ioread32(base + MAC_REG_RXDMACTL1);	\
	if (reg_value & DMACTL_RUN)					\
		iowrite32(DMACTL_WAKE, base + MAC_REG_RXDMACTL1);	\
	else								\
		iowrite32(DMACTL_RUN, base + MAC_REG_RXDMACTL1);	\
} while (0)

It's not a *good* solution, but it works.

The means the "iobase" argument would only be executed one time.
Imagine if someone passed "iobase++" to the original function.  It
would have incremented twice instead of once as expected.  That's what
the checkpatch warning is saying.  Nothing to do with multiple lines.

regards,
dan carpenter

